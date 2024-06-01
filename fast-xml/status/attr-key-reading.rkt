#lang racket

(require "../lib.rkt")

(provide (contract-out
          [attr-key-reading (-> char? (values STATUS? boolean? boolean?))]
          ))

(define (attr-key-reading ch)
   (if (char=? ch #\=)
       (values 'ATTR_KEY_END #f #t)
       (values 'ATTR_KEY_READING #f #t)))
