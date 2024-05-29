#lang racket

(require rackunit/text-ui
         rackunit
         "../lib.rkt")

(define test-lib
  (test-suite
   "test-lib"

   (test-case
    "test-defs-to-hash"

    (let ([def_hash (defs-to-hash '("topic.v"))])
      (check-equal? (hash-count def_hash) 2)

      (check-eq? (hash-ref def_hash "topic") 'k)
      (check-eq? (hash-ref def_hash "topic.v") 'v)
      )

    (let ([def_hash (defs-to-hash '("h1.h2.h3.topic"))])
      (check-equal? (hash-count def_hash) 4)

      (check-eq? (hash-ref def_hash "h1") 'k)
      (check-eq? (hash-ref def_hash "h1.h2") 'k)
      (check-eq? (hash-ref def_hash "h1.h2.h3") 'k)
      (check-eq? (hash-ref def_hash "h1.h2.h3.topic") 'v))

    (let ([def_hash (defs-to-hash '("h1.h2.h3.topic" "h3.h4.h5.v"))])
      (check-equal? (hash-count def_hash) 8)

      (check-eq? (hash-ref def_hash "h1") 'k)
      (check-eq? (hash-ref def_hash "h1.h2") 'k)
      (check-eq? (hash-ref def_hash "h1.h2.h3") 'k)
      (check-eq? (hash-ref def_hash "h1.h2.h3.topic") 'v)

      (check-eq? (hash-ref def_hash "h3") 'k)
      (check-eq? (hash-ref def_hash "h3.h4") 'k)
      (check-eq? (hash-ref def_hash "h3.h4.h5") 'k)
      (check-eq? (hash-ref def_hash "h3.h4.h5.v") 'v))

    (let ([def_hash (defs-to-hash '("h1.h2.h3.topic" "h1.h2.h4.topic"))])
      (check-equal? (hash-count def_hash) 6)

      (check-eq? (hash-ref def_hash "h1") 'k)
      (check-eq? (hash-ref def_hash "h1.h2") 'k)
      (check-eq? (hash-ref def_hash "h1.h2.h3") 'k)
      (check-eq? (hash-ref def_hash "h1.h2.h4") 'k)
      (check-eq? (hash-ref def_hash "h1.h2.h3.topic") 'v)
      (check-eq? (hash-ref def_hash "h1.h2.h4.topic") 'v))
    )
  ))

(run-tests test-lib)
