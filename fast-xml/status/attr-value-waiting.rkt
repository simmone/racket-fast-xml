#lang racket

(require "../lib.rkt")

(provide (contract-out
          [attr-value-waiting (-> char? STATUS?)]
          ))

(define (attr-value-waiting ch)
  (cond
   [(char=? ch #\")
      'ATTR_VALUE_READING]
   [else
    'ATTR_VALUE_WAITING]))
