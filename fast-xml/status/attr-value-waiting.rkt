#lang racket

(require "../lib.rkt")

(provide (contract-out
          [attr-value-waiting (-> char? (values STATUS? boolean? boolean?))]
          ))

(define (attr-value-waiting ch)
  (values
   (cond
    [(char=? ch #\")
     'ATTR_VALUE_READING]
    [else
     'ATTR_VALUE_WAITING])
   #f
   #f))