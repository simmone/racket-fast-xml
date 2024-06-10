#lang racket

(require "../lib.rkt")

(provide (contract-out
          [key-value-end-maybe (-> char? (values STATUS? boolean? boolean? boolean?))]
          ))

(define (key-value-end-maybe ch)
  (cond
   [(char=? ch #\>)
    (values 'KEY_VALUE_END #f #f #t)]
   [else
    (values 'KEY_VALUE_READING #t #f #t)]
   ))