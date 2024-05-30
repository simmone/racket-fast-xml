#lang racket

(require "../lib.rkt")

(provide (contract-out
          [attr-value-reading (-> char? STATUS?)]
          ))

(define (attr-value-reading ch)
  (cond
   [(char=? ch #\space)
      'ATTR_KEY_WAITING]
   [(char=? ch #\/)
    'KEY_END]
   [else
    'ATTR_VALUE_READING]))
