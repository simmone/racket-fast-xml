#lang racket

(require "../lib.rkt")

(provide (contract-out
          [key-value-reading (-> char? (values STATUS? boolean? boolean? boolean?))]
          ))

(define (key-value-reading ch)
  (cond
   [(or (char=? ch #\<) (char=? ch #\/))
    (values 'KEY_VALUE_END #f #f #t)]
   [else
    (values 'KEY_VALUE_READING #t #f #t)]
   ))
