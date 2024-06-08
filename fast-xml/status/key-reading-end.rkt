#lang racket

(require "../lib.rkt")

(provide (contract-out
          [key-reading-end (-> char? (values STATUS? boolean? boolean? boolean?))]
          ))

(define (key-reading-end ch)
  (cond
   [(char=? ch #\/)
    (values 'KEY_PAIR_END #f #t #f)]
   [else
    (values 'KEY_VALUE_READING #t #f #f)]
   ))
