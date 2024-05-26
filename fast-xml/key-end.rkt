#lang racket

(require "xml.rkt")

(provide (contract-out
          [key-reading (-> (listof char?) XML? void?)]
          ))

(define (key-reading chars xml)
  (let ([key (list->string chars)])
    (if (string=? key (caar defs))
        (begin
          (set-XML-keys! xml `(,@(XML-keys xml) ,key))
          (set-XML-status! xml 'KEY_VALUE))
        (set-XML-status! xml 'KEY_START))))
