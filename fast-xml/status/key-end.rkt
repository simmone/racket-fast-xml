#lang racket

(require "../lib.rkt")

(provide (contract-out
          [key-end (-> char? (values STATUS? boolean? boolean? boolean?))]
          ))

(define (key-end ch)
  (cond
   [(char=? ch #\>)
    (values 'KEY_WAITING #t #f #f)]
   [(char=? ch #\<)
    (values 'KEY_WAITING #f #f #f)]
   [(char=? ch #\/)
    (values 'KEY_PAIR_END #f #f #f)]
   [else
    (values 'KEY_VALUE_READING #f #f #f)]))
