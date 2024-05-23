#lang racket

(provide (contract-out
          [xml-defs-to-hash (-> (or/c path-string? input-port?) list? hash?)]
          [lists-to-xml (-> list? string?)]
          ))

(define (xml-defs-to-hash in def)
  (make-hash))

(define (lists-to-xml xml_list)
  "")


