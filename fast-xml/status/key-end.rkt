#lang racket

(require "../lib.rkt")

(provide (contract-out
          [key-end (-> char? (values STATUS? boolean? boolean?))]
          ))

(define (key-end ch)
  (cond
   [(char=? ch #\>)
    (values 'KEY_START #f #f)]
   [else
    (values 'KEY_VALUE_READING #t #f)]))
