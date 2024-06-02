#lang racket

(require "../lib.rkt")

(provide (contract-out
          [key-reading (-> char? (values STATUS? boolean? boolean?))]
          ))

(define (key-reading ch)
  (cond
   [(char=? ch #\space)
    (values 'ATTR_KEY_WAITING #t #f)]
   [(char=? ch #\>)
    (values 'KEY_READING_END #f #t)]
   [else
    (values 'KEY_READING #f #t)]
   ))
