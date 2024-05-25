#lang racket

(provide (contract-out
          [xml-file-to-hash (-> path-string? pair? hash?)]
          [xml-port-to-hash (-> input-port? pair? hash?)]
          [lists-to-xml (-> list? string?)]
          ))

(struct TRAVERSE
        (
         ( #:mutable)
         (mode #:mutable)
         (error_level #:mutable)
         (version #:mutable)
         (modules #:mutable)
         (point_val_map #:mutable)
         (point_type_map #:mutable)
         (matrix #:mutable)
         (one_color #:mutable)
         (zero_color #:mutable)
         )
        #:transparent
        )

(define (xml-file-to-hash xml_file def_pairs)
  (with-input-from-file xml_file
    (lambda ()
      (xml-port-to-hash (current-input-port) def_pairs))))

; loop parameters:
; ch: read a char each loop.
; defs: searching defines, '(key1 (key2 (key3 . 'v)))
; status: current search status.
; keys: combine find keys to a list: '(key1 key2 key3...)
; value: combine char to a list.

; 'START: scan start
; 'KEY_START: waiting to encounter '<'
; 'READING_OR_KEY_END: next chars will be read as key, or waiting to encounter '>'
; 'VALUE: reading value

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


