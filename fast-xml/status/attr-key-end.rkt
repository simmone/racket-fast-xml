#lang racket

(require "../lib.rkt")

(provide (contract-out
          [attr-key-end (-> char? (values STATUS? boolean? boolean?))]
          ))

(define (attr-key-end ch)
   (if (char=? ch #\=)
       (values 'ATTR_KEY_END #t #f)
       (values 'ATTR_KEY_END #f #t)))
