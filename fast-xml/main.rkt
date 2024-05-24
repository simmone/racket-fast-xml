#lang racket

(provide (contract-out
          [xml-file-to-hash (-> path-string? pair? hash?)]
          [xml-port-to-hash (-> input-port? pair? hash?)]
          [lists-to-xml (-> list? string?)]
          ))

(define (xml-file-to-hash xml_file def_pairs)
  (with-input-from-file xml_file
    (lambda ()
      (xml-port-to-hash (current-input-port) def))))

; 'START: scan start
; 'WAITING_KEY_START: waiting to encounter '<'
; 'READING_KEY: next chars will be read as key
; 'KEY_END: next chars will be read as key

(define (xml-port-to-hash xml_port def_pairs)
  (let ([xml_hash (make-hash)])
    (let loop ([ch (read-char xml_port)]
               [defs def_pairs]
               [status 'START]
               [value ''])
      (when (not (eof-object? ch))
        (cond
         [(eq? status 'START)
          (loop ch 'WAITING_KEY value)]
         [(eq? status 'WAITING_KEY)
          (if (char=? ch #\<)
              (loop (read-char) 'READING_KEY value)
              (loop (read-char) 'WAITING_KEY value))]
         [else
          (void)])))
    xml_hash))

(define (lists-to-xml xml_list)
  "")


