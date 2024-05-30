#lang racket

(require "../lib.rkt")

(provide (contract-out
          [key-reading (-> char? STATUS?)]
          ))

(define (key-reading ch)
  (cond
   [(char=? ch #\space)
    'ATTR_KEY_WAITING]
   [(char=? ch #\>)
    'KEY_START]
   [else
    'KEY_READING]
   ))
