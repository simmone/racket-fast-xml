#lang racket

(require "../lib.rkt")

(provide (contract-out
          [attr-value-reading (-> char? (values STATUS? boolean? boolean? boolean?))]
          ))

(define (attr-value-reading ch)
  (cond
   [(char=? ch #\")
    (values 'ATTR_VALUE_END #f #f #t)]
   [else
    (values 'ATTR_VALUE_READING #t #f #t)]))
