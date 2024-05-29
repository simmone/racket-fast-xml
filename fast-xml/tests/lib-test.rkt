#lang racket

(require rackunit/text-ui
         rackunit
         "../lib.rkt")

(define test-lib
  (test-suite
   "test-lib"

   (test-case
    "test-defs-to-hash"

    (let ([defs '("topic.v")])
      (check-equal? (defs-to-hash defs)
                    '#hash(
                           ("topic" . k)
                           ("topic.v" . v)
                           ))

    (let ([defs '("h1.h2.h3.topic")])
      (check-equal? (defs-to-hash defs)
                    '#hash(
                           ("h1" . k)
                           ("h1.h2" . k)
                           ("h1.h2.h3" . k)
                           ("h1.h2.h3.topic" . v))))

    (let ([defs '("h1.h2.h3.topic" "h3.h4.h5.v")])
      (check-equal? (defs-to-hash defs)
                    '#hash(
                           ("h1" . k)
                           ("h1.h2" . k)
                           ("h1.h2.h3" . k)
                           ("h1.h2.h3.topic" . v)
                           ("h3" . k)
                           ("h3.h4" . k)
                           ("h3.h4.h5" . k)
                           ("h3.h4.h5.v" . v))))

    (let ([defs '("h1.h2.h3.topic" "h1.h2.h4.topic")])
      (check-equal? (defs-to-hash defs)
                    '#hash(
                           ("h1" . k)
                           ("h1.h2" . k)
                           ("h1.h2.h3" . k)
                           ("h1.h2.h4" . k)
                           ("h1.h2.h3.topic" . v)
                           ("h1.h2.h4.topic" . v))))

      ))
  ))

(run-tests test-lib)
