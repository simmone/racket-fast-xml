#lang racket

(require "../lib.rkt")

(provide (contract-out
          [key-reading (-> char? (values STATUS? boolean? boolean? boolean?))]
          ))

(define (key-reading ch)
  (cond
   [(char=? ch #\space)
    (values 'KEY_READING_END #f #t #f)]
   [(char=? ch #\>)
    (values 'KEY_READING_END #f #t #f)]
   [(char=? ch #\/)
    (values 'KEY_END #f #t #f)]
   [else
    (values 'KEY_READING #t #f #t)]
   ))
