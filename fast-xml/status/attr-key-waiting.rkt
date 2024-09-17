#lang racket

(require "../lib.rkt")

(provide (contract-out
          [attr-key-waiting (-> char? (values STATUS? boolean? boolean? boolean?))]
          ))

(define (attr-key-waiting ch)
  (cond
   [(char=? ch #\space)
    (values 'ATTR_KEY_WAITING #t #f #f)]
   [(char=? ch #\newline)
    (values 'ATTR_KEY_WAITING #t #f #f)]
   [(char=? ch #\return)
    (values 'ATTR_KEY_WAITING #t #f #f)]
   [(char=? ch #\>)
    (values 'KEY_END #t #f #f)]
   [(char=? ch #\?)
    (values 'KEY_PAIR_END #t #f #f)]
   [(char=? ch #\/)
    (values 'KEY_END #f #f #f)]
   [(char=? ch #\<)
    (values 'KEY_WAITING #f #f #f)]
   [else
    (values 'ATTR_KEY_READING #t #f #t)]
   ))
