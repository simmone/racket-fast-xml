#lang racket

(require "../lib.rkt")

(provide (contract-out
          [attr-value-reading (-> char? (values STATUS? boolean?))]
          ))

(define (attr-value-reading ch)
  (cond
   [(char=? ch #\")
    (values 'ATTR_KEY_WAITING #f)]
   [(char=? ch #\/)
    (values 'KEY_END #f)]
   [else
    (values 'ATTR_VALUE_READING #t)]))
