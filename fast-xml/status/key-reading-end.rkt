#lang racket

(require "../lib.rkt")

(provide (contract-out
          [key-reading-end (-> char? (values STATUS? boolean? boolean? boolean?))]
          ))

(define (key-reading-end ch)
  (cond
   [(char=? ch #\/)
    (values 'KEY_VALUE_END #f #f #f)]
   [(char=? ch #\>)
    (values 'KEY_END #t #t #f)]
   [else
    (values 'ATTR_KEY_WAITING #t #f #f)]
   ))
