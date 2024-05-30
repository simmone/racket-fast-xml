#lang racket

(require "../lib.rkt")

(provide (contract-out
          [attr-key-waiting (-> char? STATUS?)]
          ))

(define (attr-key-waiting ch)
  (if (char=? ch #\space)
      'ATTR_KEY_WAITING
      'ATTR_KEY_READING))
