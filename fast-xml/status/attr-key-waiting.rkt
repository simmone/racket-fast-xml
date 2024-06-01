#lang racket

(require "../lib.rkt")

(provide (contract-out
          [attr-key-waiting (-> char? (values STATUS? boolean?))]
          ))

(define (attr-key-waiting ch)
  (cond
   [(char=? ch #\space)
    (values 'ATTR_KEY_WAITING #f)]
   [(char=? ch #\>)
    (values 'KEY_VALUE_READING #f)]
   [(char=? ch #\?)
    (values 'KEY_END #f)]
   [else
    (values 'ATTR_KEY_READING #t)]
   ))
