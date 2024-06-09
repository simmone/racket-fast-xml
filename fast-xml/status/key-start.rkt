#lang racket

(require "../lib.rkt")

(provide (contract-out
          [key-start (-> char? (values STATUS? boolean? boolean? boolean?))]
          ))

(define (key-start ch)
  (cond
   [(char=? ch #\/)
    (values 'KEY_PAIR_END #t #f #f)]
   [else
    (values 'KEY_READING #t #f #t)]))
