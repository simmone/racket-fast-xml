#lang racket

(reqauire "xml.rkt"
          "key-end.rkt"
          )

(provide (contract-out
          [xml-file-to-hash (-> path-string? pair? hash?)]
          [xml-port-to-hash (-> input-port? pair? hash?)]
          [lists-to-xml (-> list? string?)]
          ))

(define (xml-file-to-hash xml_file def_pairs)
  (with-input-from-file xml_file
    (lambda ()
      (xml-port-to-hash (current-input-port) def_pairs))))

; 'KEY_START: waiting to encounter '<'
; 'KEY_READING: next chars will be read as key;
; 'KEY_VALUE_READING: reading key value

(define (xml-port-to-hash xml_port def_pairs)
  (let ([xml_hash (make-hash)])
    (let loop ([status 'KEY_START]
               [ch (read-char xml_port)]
               [defs def_pairs]
               [keys '()]
               [chars '()])
      (when (not (eof-object? ch))
        (cond
         [(and
           (eq? (XML-status xml) 'KEY_START)
           (char=? ch #\<))
          (loop 'KEY_READING (read-char xml_port) defs keys chars)]
         [(eq? status 'KEY_READING)
          (if (char=? ch #\>)
            (let ([key (list->string (reverse chars))])
              (if (string=? key (car defs))
                  (cond
                   [(pair? (cdr defs))
                    (loop 'KEY_START (read-char xml_port) (cdr defs) (cons key keys) '())]
                   [(and 
                     (symbol? (cdr defs))
                     (eq? (cdr defs) 'v))
                    (loop 'KEY_VALUE_START (read-char xml_port) '() (cons key keys) '())])
                  (loop 'KEY_START (read-char xml_port) defs keys '())))
            (loop status (read-char xml_port) defs keys (cons ch chars)))]
         [(eq? status 'KEY_VALUE_READING)
          (if (char=? ch #\<)
              (begin
                (hash-set! xml_hash
                           (foldr (lambda (key1 key2) (string-append key1 "." key2)) "" keys)
                           (list->string (reverse chars)))
                (loop 'KEY_START (read-char xml_port) defs '() '()))
              (loop status (read-char xml_port) defs keys (cons ch chars)))]
         ))
      
(define (lists-to-xml xml_list)
  "")


