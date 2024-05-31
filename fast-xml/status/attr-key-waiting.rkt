#lang racket

(require "../lib.rkt")

(provide (contract-out
          [attr-key-waiting (-> char? STATUS?)]
          ))

(define (attr-key-waiting ch)
  (cond
   [(char=? ch #\space)
    'ATTR_KEY_WAITING]
   [(char=? ch #\>)
    'KEY_END]
   [(char=? ch #\?)
    'ATTR_KEY_WAITING]
   [else
    'ATTR_KEY_READING]
   ))
