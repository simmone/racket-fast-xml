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

; 'START: scan start
; 'KEY_START: waiting to encounter '<'
; 'KEY_READING: next chars will be read as key;
; 'KEY_END: next chars will be read as key;
; 'KEY_VALUE_START: reading key value

(define (xml-port-to-hash xml_port def_pairs)
  (let ([xml (XML 'START def_pairs '() '() (make-hash))])
    (let loop ([ch (read-char xml_port)]
               [keys '()]
               [chars '()])
      (when (not (eof-object? ch))
        (cond
         [(eq? (XML-status xml) 'START)
          (set-XML-status! xml 'KEY_START)]
         [(and
           (eq? (XML-status xml) 'KEY_START)
           (char=? ch #\<))
          (set-XML-status! xml 'KEY_READING)]
         [(eq? status 'KEY_READING)
          (when (char=? ch #\>)
            (set-XML-status! xml 'KEY_END)
            (let ([key (list->string (reverse chars))])
              (if (string=? key (car defs))
                  (loop (read-char xml_port) (cons key keys) '())
                  (loop (read-char xml_port) keys '()))))]
         [(and
           (eq? status 'KEY_END)
           (char? ch #\<))
          (set-XML-status! xml 'KEY_START)]
         )
        
        (cond
         [(eq? (XML-status xml) 'KEY_READING)
          (loop (read-char xml_port) keys (cons ch chars))]
         [(eq? (XML-status xml) 'KEY_VALUE_START)
          (loop (
          
         
        (if (or (eq? status 'KEY_START)
                (eq? status 'KEY_VALUE_START))
            (loop (read-char) (cons ch chars))
            (loop (read-char) '()))
    (XML-xml_hash xml)))

(define (xml-port-to-hash xml_port def_pairs)
  (let ([xml_hash (make-hash)])
    (let loop ([ch (read-char xml_port)]
               [defs def_pairs]
               [status 'START]
               [keys '()]
               [values '()])
      (when (not (eof-object? ch))
        (cond
         [(eq? status 'START)
          (loop ch defs 'KEY_START keys values)]
         [(eq? status 'KEY_START)
          (if (char=? ch #\<)
              (loop (read-char) defs  'READING_OR_KEY_END' keys values)
              (loop (read-char) defs status keys values))]
         [(eq? status 'READING_OR_KEY_END)
          (if (char=? ch #\>)
              (let ([value (list->string (reverse values))])
                (if (string=? value (caar defs))
                    (if (pair? (cdr defs))
                        (loop (read-char) defs 'KEY_START (cons value keys) '())
                        (loop (read-char) defs 'VALUE (cons value keys) '()))
                    (loop (read-char) defs'KEY_START keys values)))
              (loop (read-char) defs status keys (cons ch values)))]
         [(eq? status 'VALUE)
          (if (char=? ch  #\<)
              (hash-set! xml_hash (foldr (lambda (key1 key2) (string-append key1 "," key2)) "" keys) (list->string (reverse values)))
              (loop (read-char) defs status keys values))]
         [else
          (void)])))
    xml_hash))

(define (lists-to-xml xml_list)
  "")


