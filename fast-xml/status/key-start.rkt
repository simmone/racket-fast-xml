#lang racket

(require "../lib.rkt")

(provide (contract-out
          [key-start (-> char? STATUS?)]
          ))

(define (key-start ch)
  (if (char=? ch #\<)
      'KEY_READING
      'KEY_START))
