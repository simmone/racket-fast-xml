#lang racket

(require "../lib.rkt"
         "../status/key-start.rkt"
         "../status/key-reading.rkt"
         "../status/key-reading-end.rkt"
         "../status/key-end.rkt"
         "../status/key-value-reading.rkt"
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
  (let ([xml_hash (make-hash)])

    (define-values
        (def_hash attr_def_hash)
      (defs-to-hash def_list))

    (let loop ([status 'TRAVERSE_START]
               [ch (read-char xml_port)]
               [count 0]
               [keys '()]
               [chars '()]
               [waiting_key #f]
               [key_value_obtained #f]
               [attr_hash #f])

      (when (= (remainder count (* 1024 1024 1)) 0)
        (fprintf stderr_port "~aMk\n" (/ count (* 1024 1024 1))))

      (when (not (eof-object? ch))
        (define-values
            (next_status read_char? reserve_key? reserve_char?)
          (cond
           [(eq? status 'TRAVERSE_START) (values 'KEY_START #f #f #f)]
           [(eq? status 'KEY_START) (key-start ch)]
           [(eq? status 'KEY_READING) (key-reading ch)]
           [(eq? status 'KEY_VALUE_READING) (key-value-reading ch)]
           [(eq? status 'ATTR_KEY_WAITING) (attr-key-waiting ch)]
           [(eq? status 'ATTR_KEY_READING) (attr-key-reading ch)]
           [(eq? status 'ATTR_VALUE_WAITING) (attr-value-waiting ch)]
           [(eq? status 'ATTR_VALUE_READING) (attr-value-reading ch)]
           [(eq? status 'KEY_END)
            (let* ([key (if (> (length keys) 1)
                            (string-join (reverse keys) ".")
                            (car keys))])
              (when (hash-has-key? attr_def_hash key)
                (set! attr_hash (hash-copy (hash-ref attr_def_hash key)))))

            (key-end ch)]
           [(eq? status 'KEY_READING_END)
            (let* ([key (if (> (length keys) 1)
                            (string-join (reverse keys) ".")
                            (car keys))])

              (when (and (hash-has-key? def_hash key) (eq? (hash-ref def_hash key) 'v))
                (set! waiting_key key)
                (set! key_value_obtained #f))

              (when (hash-has-key? attr_def_hash key)
                (set! attr_hash (hash-copy (hash-ref attr_def_hash key)))))

            (key-reading-end ch)]
           [(eq? status 'KEY_PAIR_END)
            (let* ([key (if (> (length keys) 1)
                            (string-join (reverse keys) ".")
                            (car keys))])

              (if attr_hash
                (hash-for-each
                 attr_hash
                 (lambda (k v)
                   (when (not v)
                   (hash-set! xml_hash k `(,@(hash-ref xml_hash k '()) "")))))
                (when (hash-has-key? attr_def_hash key)
                  (hash-for-each
                   (hash-ref attr_def_hash key)
                   (lambda (k v)
                     (hash-set! xml_hash k `(,@(hash-ref xml_hash k '()) ""))))))

              (when (and (hash-has-key? def_hash key) (eq? (hash-ref def_hash key) 'v) (not key_value_obtained))
                (hash-set! xml_hash key `(,@(hash-ref xml_hash key '()) ""))))

            (set! keys (cdr keys))
            (set! key_value_obtained #f)
            (set! attr_hash #f)
            (values 'KEY_START #t #f #f)]
           [(eq? status 'ATTR_KEY_END)
            (let ([key (string-join (reverse keys) ".")])
              (when (and (hash-has-key? def_hash key) (eq? (hash-ref def_hash key) 'a))
                (set! waiting_key key)))

            (set! keys (cdr keys))
            (values 'ATTR_VALUE_READING #t #f #f)]
           [(eq? status 'ATTR_VALUE_END)
            (when (and waiting_key (hash-has-key? def_hash waiting_key) (eq? (hash-ref def_hash waiting_key) 'a))
              (hash-set! xml_hash waiting_key `(,@(hash-ref xml_hash waiting_key '()) ,(list->string (reverse (cdr chars)))))
              (hash-set! attr_hash waiting_key #t))

            (let ([key (string-join (reverse keys) ".")])
              (if (and (hash-has-key? def_hash key) (eq? (hash-ref def_hash key) 'v))
                  (set! waiting_key key)
                  (set! waiting_key #f)))

            (attr-value-end ch)]
           [(eq? status 'KEY_VALUE_END)
            (when waiting_key
              (hash-set! xml_hash waiting_key `(,@(hash-ref xml_hash waiting_key '()) ,(list->string (reverse (cdr chars)))))
              (set! key_value_obtained #t))

            (set! waiting_key #f)
            (values 'KEY_START #f #f #f)]
           ))

        (fprintf out_port "|~a[~a,~a,~a]|[~a]|~a|~a|~a|~a|~a|\n" status read_char? reserve_key? reserve_char? ch keys chars waiting_key key_value_obtained attr_hash)

        (loop
         next_status
         (if read_char? (read-char xml_port) ch)
         (if read_char? (add1 count) count)
         (if reserve_key? (if (> (length chars) 0) (cons (list->string (reverse chars)) keys) keys) keys)
         (if reserve_char? (cons ch chars) '())
         waiting_key
         key_value_obtained
         attr_hash)))
    xml_hash))

(let ([stderr_port (current-error-port)])
  (with-output-to-file
      show_file
    #:exists 'replace
    (lambda ()
      (printf "| Status | Char | Keys | Chars | Waiting Key| Key Value Obtained | Attr Hash |\n")
      (printf "|--------|------|------|-------|------------|--------------------|-----------|\n")

    (let ([xml_hash
           (xml-file-to-hash
            data_xml_file
            '(
              ("list.child" . v)
              ("list.child.attr" . a)
              )
            stderr_port
            (current-output-port)
            )])

      (check-equal? (hash-count xml_hash) 2)
      
      (check-equal? (hash-ref xml_hash "list.child") '("c1" "c2" "c3"))
      (check-equal? (hash-ref xml_hash "list.child.attr") '("a1" "a2" "a3"))
))))
