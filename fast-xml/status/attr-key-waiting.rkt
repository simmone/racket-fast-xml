#lang racket

(require "../lib.rkt")

(provide (contract-out
          [attr-key-waiting (-> char? (values STATUS? boolean? boolean? boolean?))]
          ))

(define (attr-key-waiting ch)
  (cond
   [(char=? ch #\space)
    (values 'ATTR_KEY_WAITING #t #f #f)]
   [(char=? ch #\>)
    (values 'KEY_VALUE_READING #t #f #f)]
   [(char=? ch #\?)
    (values 'KEY_PAIR_END #t #f #f)]
   [(char=? ch #\/)
    (values 'KEY_PAIR_END_NO_VALUE #t #f #f)]
   [else
    (values 'ATTR_KEY_READING #t #f #t)]
   ))
