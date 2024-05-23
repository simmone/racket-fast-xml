#lang racket

(provide (contract-out
          [xml-defs-to-hash (-> (or/c path-string? input-port?) list? hash?)]
          [lists-to-xml (-> list? string?)]
          ))

(define (def->hash def)
  (let ([def_hash (make-hash)])
    (let loop-def ([loop_defs def])
      (when (not (null? loop_defs))
        (hash-set! def_hash (caar loop_defs) (cdar loop_defs))
        (loop-def (cdr loop_defs))))
    def_hash))

(define (xml-defs-to-hash in def)
  (let ([xml_hash (make-hash)]
        [def_hash (def->hash def)])
    xml_hash))

(define (lists-to-xml xml_list)
  "")


