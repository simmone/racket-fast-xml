#lang racket

(provide (contract-out
          [xml-file-to-hash (-> path-string? list? hash?)]
          [xml-port-to-hash (-> input-port? list? hash?)]
          [lists-to-xml (-> list? string?)]
          ))

(define (def->hash def)
  (let ([def_hash (make-hash)])
    (let loop-def ([loop_defs def])
      (when (not (null? loop_defs))
        (hash-set! def_hash (caar loop_defs) (cdar loop_defs))
        (loop-def (cdr loop_defs))))
    def_hash))

(define (xml-file-to-hash xml_file def)
  (with-input-from-file xml_file
    (lambda ()
      (xml-port-to-hash (current-input-port) def))))

; 'START: scan start
; 'WAITING_KEY: waiting to encounter '<'
; 'READING_KEY: next chars will be read as key

(define (xml-port-to-hash xml_port def)
  (let ([xml_hash (make-hash)]
        [def_hash (def->hash def)])
    (let loop ([ch (read-char xml_port)]
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


