#lang racket

(require "../lib.rkt"
         "../status/key-start.rkt"
         "../status/key-reading.rkt"
         "../status/key-end.rkt"
         "../status/key-value-reading.rkt"
         "../status/attr-key-waiting.rkt"
         "../status/attr-key-reading.rkt"
         "../status/attr-value-waiting.rkt"
         "../status/attr-value-reading.rkt"
         "../status/attr-value-end.rkt"
         racket/runtime-path
         )

(define-runtime-path data_xml_file "data.xml")
(define-runtime-path show_file "show.md")

(define (xml-file-to-hash xml_file def_list out_port)
  (with-input-from-file xml_file
    (lambda ()
      (xml-port-to-hash (current-input-port) def_list out_port))))

(define (xml-port-to-hash xml_port def_list out_port)
  (let ([xml_hash (make-hash)]
        [def_hash (defs-to-hash def_list)])
    (let loop ([status 'TRAVERSE_START]
               [ch (read-char xml_port)]
               [keys '()]
               [chars '()]
               [waiting_key #f])



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
           [(eq? status 'KEY_END) (key-end ch)]
           [(eq? status 'KEY_PAIR_END)
            (set! keys (cdr keys))
            (values 'KEY_START #t #f #f)]
           [(eq? status 'ATTR_KEY_END)
            (let ([key (string-join (reverse keys) ".")])
              (when (and (hash-has-key? def_hash key) (eq? (hash-ref def_hash key) 'v))
                (set! waiting_key key)))

            (set! keys (cdr keys))
            (values 'ATTR_VALUE_READING #t #f #f)]
           [(eq? status 'ATTR_VALUE_END)
            (when waiting_key
              (hash-set! xml_hash waiting_key `(,@(hash-ref xml_hash waiting_key '()) ,(car keys))))
            (set! keys (cdr keys))
            (let ([key (string-join (reverse keys) ".")])
              (if (and (hash-has-key? def_hash key) (eq? (hash-ref def_hash key) 'v))
                  (set! waiting_key key)
                  (set! waiting_key #f)))
            (attr-value-end ch)]
           [(eq? status 'KEY_READING_END)
            (let* ([key (if (> (length keys) 1)
                            (string-join (reverse keys) ".")
                            (car keys))])
              (when (and (hash-has-key? def_hash key) (eq? (hash-ref def_hash key) 'v))
                (set! waiting_key key))

              (values 'KEY_VALUE_READING #t #f #f))]
           [(eq? status 'KEY_VALUE_END)
            (when waiting_key
              (hash-set! xml_hash waiting_key `(,@(hash-ref xml_hash waiting_key '()) ,(car keys))))
            (set! keys (cdr keys))
            (set! waiting_key #f)
            (values 'KEY_START #f #f #f)]
           ))

        (fprintf out_port "|~a[~a,~a,~a]|[~a]|~a|~a|~a|\n" status read_char? reserve_key? reserve_char? ch keys chars waiting_key)

        (loop
         next_status
         (if read_char? (read-char xml_port) ch)
         (if reserve_key? (cons (list->string (reverse chars)) keys) keys)
         (if reserve_char? (cons ch chars) '())
         waiting_key)))
    xml_hash))

(with-output-to-file
 show_file
 #:exists 'replace
 (lambda ()
   (printf "| Status | Char | Keys | Chars | Waiting Key|\n")
   (printf "|--------|------|------|-------|------------|\n")

   (let ([xml_hash (xml-file-to-hash
                    data_xml_file
                    '(
                      "?xml.version"
                      "?xml.encoding"
                      "basic1.value"
                      )
                    (current-output-port))])

     (printf "\n\n~a\n" xml_hash))))