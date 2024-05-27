#lang racket

(require rackunit/text-ui
         rackunit
         "../lib.rkt")

(define test-lib
  (test-suite
   "test-lib"

   (test-case
    "test-defs-to-list"

    (let ([defs '("topic.v")])
      (check-equal? (defs-to-list defs) '(("topic" . "v")))

    (let ([defs '("h1.h2.h3.topic")])
      (check-equal? (defs-to-list defs) '(("h1" . ("h2" . ("h3" . "topic"))))))

    (let ([defs '("h1.h2.h3.topic" "h3.h4.h5.v")])
      (check-equal? (defs-to-list defs) '(("h1" . ("h2" . ("h3" . "topic"))) ("h3" . ("h4" . ("h5" . "v"))))))
      ))
  ))

(run-tests test-lib)
