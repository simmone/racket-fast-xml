#lang racket

(require "../lib.rkt")

(provide (contract-out
          [attr-value-reading (-> char? (values STATUS? boolean? boolean? boolean?))]
          ))

(define (attr-value-reading ch)
  (cond
   [(char=? ch #\")
    (values 'ATTR_VALUE_END #t #t #f)]
   [(char=? ch #\/)
    (values 'KEY_END #t  #t #f)]
   [else
    (values 'ATTR_VALUE_READING #t #f #t)]))
