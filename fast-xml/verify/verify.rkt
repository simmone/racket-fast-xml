#lang racket

(require "../lib.rkt"
         "../status/key-start.rkt"
         "../status/key-waiting.rkt"
         "../status/key-reading.rkt"
         "../status/key-reading-end.rkt"
         "../status/key-end.rkt"
         "../status/key-value-reading.rkt"
         "../status/key-value-end-maybe.rkt"
         "../status/attr-key-waiting.rkt"
         "../status/attr-key-reading.rkt"
         "../status/attr-value-waiting.rkt"
         "../status/attr-value-reading.rkt"
         "../status/attr-value-end.rkt"
         racket/runtime-path
         rackunit/text-ui
         rackunit
         )

(define-runtime-path data_xml_file "data.xml")
(define-runtime-path show_file "show.md")

(define (xml-file-to-hash xml_file def_list stderr_port out_port)
  (with-input-from-file xml_file
    (lambda ()
      (xml-port-to-hash (current-input-port) def_list stderr_port out_port))))

(define (xml-port-to-hash xml_port def_list stderr_port out_port)
  (let ([xml_hash (make-hash)]
        [def_hash (defs-to-hash def_list)])

    (printf "~a\n" def_hash)

    (let loop ([status 'TRAVERSE_START]
               [ch (read-char xml_port)]
               [count 0]
               [keys '()]
               [chars '()]
               [waiting_pure_key #f]
               [waiting_value_key #f])

      (when (= (remainder count (* 1024 1024 1)) 0)
        (fprintf stderr_port "~aMk\n" (/ count (* 1024 1024 1))))

      (when (not (eof-object? ch))
        (define-values
            (next_status read_char? reserve_key? reserve_char?)
          (cond
           [(eq? status 'TRAVERSE_START) (values 'KEY_WAITING #f #f #f)]
           [(eq? status 'KEY_WAITING) (key-waiting ch)]
           [(eq? status 'KEY_START) (key-start ch)]
           [(eq? status 'KEY_READING) (key-reading ch)]
           [(eq? status 'KEY_VALUE_READING) (key-value-reading ch)]
           [(eq? status 'KEY_VALUE_END_MAYBE) (key-value-end-maybe ch)]
           [(eq? status 'ATTR_KEY_WAITING) (attr-key-waiting ch)]
           [(eq? status 'ATTR_KEY_READING) (attr-key-reading ch)]
           [(eq? status 'ATTR_VALUE_WAITING) (attr-value-waiting ch)]
           [(eq? status 'ATTR_VALUE_READING) (attr-value-reading ch)]
           [(eq? status 'KEY_END)
            (let* ([pure_key (from-keys-to-pure-key keys)]
                   [count_key (from-keys-to-count-key keys)]
                   [value_key (from-keys-to-value-key keys)]
                   )
              
              (when (hash-has-key? def_hash pure_key)
                (let ([type (hash-ref def_hash pure_key)])
                  (when (or (eq? type 'v) (eq? type 'kv))
                    (set! waiting_pure_key pure_key)
                    (set! waiting_value_key value_key)))))

            (key-end ch)]
           [(eq? status 'KEY_READING_END)
            (let* ([pure_key (from-keys-to-pure-key keys)]
                   [count_key (from-keys-to-count-key keys)]
                   [key_count (format "~a's count" count_key)]
                   [value_key (from-keys-to-value-key keys)]
                   )

              (when (hash-has-key? def_hash pure_key)
                (let ([type (hash-ref def_hash pure_key)])
                  (when (or (eq? type 'v) (eq? type 'kv))
                    (set! waiting_pure_key pure_key)
                    (set! waiting_value_key value_key))

                  (hash-set! xml_hash key_count (add1 (hash-ref xml_hash key_count 0))))))

            (key-reading-end ch)]
           [(eq? status 'KEY_PAIR_END)
            (when waiting_pure_key
              (hash-set! xml_hash waiting_value_key
                         (if (null? chars)
                             ""
                             (from-special-chars (list->string (reverse (cdr chars)))))))

            (set! waiting_pure_key #f)
            (set! waiting_value_key #f)

            (set! keys (cdr keys))
            (values 'KEY_WAITING #t #f #f)]
           [(eq? status 'ATTR_KEY_END)
            (let* ([pure_key (from-keys-to-pure-key keys)]
                   [count_key (from-keys-to-count-key keys)]
                   [value_key (from-keys-to-value-key keys)]
                   )
              (when (hash-has-key? def_hash pure_key)
                (let ([type (hash-ref def_hash pure_key)])
                  (when (or (eq? type 'v) (eq? type 'kv))
                    (set! waiting_pure_key pure_key)
                    (set! waiting_value_key value_key)))))

            (set! keys (cdr keys))

            (values 'ATTR_VALUE_READING #t #f #f)]
           [(eq? status 'ATTR_VALUE_END)
            (when waiting_pure_key
              (when (hash-has-key? def_hash waiting_pure_key)
                (let ([type (hash-ref def_hash waiting_pure_key)])
                  (when (or (eq? type 'v) (eq? type 'kv))
                    (hash-set! xml_hash waiting_value_key (from-special-chars (list->string (reverse (cdr chars)))))))))

            (set! waiting_pure_key #f)
            (set! waiting_value_key #f)

            (attr-value-end ch)]
           [(eq? status 'KEY_VALUE_END)
            (when waiting_pure_key
              (hash-set! xml_hash waiting_value_key
                         (if (null? chars)
                             ""
                             (from-special-chars (list->string (reverse (cdr chars)))))))

            (set! waiting_pure_key #f)
            (set! waiting_value_key #f)
            (values 'KEY_WAITING #f #f #f)]
           ))

        (fprintf out_port "|~a[~a,~a,~a]|[~a]|~a|~a|~a|~a|\n" status read_char? reserve_key? reserve_char? ch keys chars waiting_pure_key waiting_value_key)

        (loop
         next_status
         (if read_char? (read-char xml_port) ch)
         (if read_char? (add1 count) count)
         (if reserve_key?
             (let* ([key (list->string (reverse chars))]
                    [_keys (cons (cons key 0) keys)]
                    [count_key (from-keys-to-count-key _keys)]
                    [key_count (format "~a's count" count_key)])

               (if (> (string-length key) 0)
                   (cons (cons key (add1 (hash-ref xml_hash key_count 0))) keys)
                   keys))
             keys)
         (if reserve_char? (cons ch chars) '())
         waiting_pure_key
         waiting_value_key)))
    xml_hash))

(let ([stderr_port (current-error-port)])
  (with-output-to-file show_file
    #:exists 'replace
    (lambda ()
      (printf "| Status | Char | Keys | Chars | Waiting Pure Key| Waiting Value Key |\n")
      (printf "|--------|------|------|-------|-----------------|-------------------|\n")

      (let ([xml_hash
             (xml-file-to-hash
              data_xml_file
              '(
                "basic1.attr1"
                "basic1.attr2"
                "basic1.attr3"
                "basic1.attr4"
                "basic1.attr5"
                )
              stderr_port
              (current-output-port)
              )])
        
        (fprintf stderr_port "~a\n" xml_hash)

        (check-equal? (hash-ref xml_hash "basic11.attr11") "&")
        (check-equal? (hash-ref xml_hash "basic11.attr21") "<")
        (check-equal? (hash-ref xml_hash "basic11.attr31") ">")
        (check-equal? (hash-ref xml_hash "basic11.attr41") "'")
        (check-equal? (hash-ref xml_hash "basic11.attr51") "\"")
        ))))
