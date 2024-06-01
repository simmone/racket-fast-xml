#lang racket

(require "../lib.rkt")

(provide (contract-out
          [attr-key-reading (-> char? (values STATUS? boolean?))]
          ))

(define (attr-key-reading ch)
   (if (char=? ch #\=)
       (values 'ATTR_VALUE_WAITING #f)
       (values 'ATTR_KEY_READING #t)))
