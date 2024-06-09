#lang racket

(require "../lib.rkt")

(provide (contract-out
          [key-waiting (-> char? (values STATUS? boolean? boolean? boolean?))]
          ))

(define (key-waiting ch)
  (cond
   [(char=? ch #\<)
    (values 'KEY_START #t #f #f)]
   [else
    (values 'KEY_WAITING #t #f #f)]))
