#lang racket

(require "../lib.rkt")

(provide (contract-out
          [attr-key-reading (-> char? STATUS?)]
          ))

(define (attr-key-reading ch)
  (if (char=? ch #\=)
      'ATTR_VALUE_READING
      'ATTR_KEY_READING))
