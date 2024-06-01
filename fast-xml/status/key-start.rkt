#lang racket

(require "../lib.rkt")

(provide (contract-out
          [key-start (-> char? (values STATUS? #f))]
          ))

(define (key-start ch)
  (values
   (if (char=? ch #\<)
       'KEY_READING
       'KEY_START)
   #f))
