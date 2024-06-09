#lang racket

(require "../lib.rkt")

(provide (contract-out
          [key-value-reading (-> char? (values STATUS? boolean? boolean? boolean?))]
          ))

(define (key-value-reading ch)
  (cond
   [(char=? ch #\<)
    (values 'KEY_VALUE_END #f #f #t)]
   [(char=? ch #\/)
    (values 'KEY_VALUE_END_MAYBE #t #f #t)]
   [else
    (values 'KEY_VALUE_READING #t #f #t)]
   ))
