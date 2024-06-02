#lang racket

(require "../lib.rkt")

(provide (contract-out
          [attr-key-reading (-> char? (values STATUS? boolean? boolean? boolean?))]
          ))

(define (attr-key-reading ch)
   (if (char=? ch #\=)
       (values 'ATTR_KEY_END #t #t #f)
       (values 'ATTR_KEY_READING #t #f #t)))
