#lang racket

(require "lib.rkt")

(provide (contract-out
          [key-start (-> char? STATUS?)]
          ))

(define (key-start ch)
  'KEY_START)
