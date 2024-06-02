#lang racket

(require "../lib.rkt")

(provide (contract-out
          [attr-value-end (-> char? (values STATUS? boolean? boolean?))]
          ))

(define (attr-value-end ch)
  (values
   (cond
    [(or (char=? ch #\?) (char=? ch #\>))
     'KEY_END]
    [else
     'ATTR_KEY_WAITING])
   #f
   #f))
