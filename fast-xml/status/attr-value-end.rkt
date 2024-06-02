#lang racket

(require "../lib.rkt")

(provide (contract-out
          [attr-value-end (-> char? (values STATUS? boolean? boolean? boolean?))]
          ))

(define (attr-value-end ch)
  (values
   (cond
    [(char=? ch #\?)
     'KEY_PAIR_END]
    [(char=? ch #\>)
     'KEY_END]
    [else
     'ATTR_KEY_WAITING])
   #t
   #f
   #f))
