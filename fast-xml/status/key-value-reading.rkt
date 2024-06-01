#lang racket

(require "../lib.rkt")

(provide (contract-out
          [key-value-reading (-> char? (values STATUS? boolean? boolean?))]
          ))

(define (key-value-reading ch)
  (cond
   [(char=? ch #\<)
    (values 'KEY_READING #f #f)]
   [else
    (values 'KEY_VALUE_READING #f #t)]
   ))
