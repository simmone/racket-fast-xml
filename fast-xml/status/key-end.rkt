#lang racket

(require "../lib.rkt")

(provide (contract-out
          [key-end (-> char? STATUS?)]
          ))

(define (key-end ch)
  'KEY_START)
