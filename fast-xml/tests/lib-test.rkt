#lang racket

(require rackunit/text-ui
         rackunit
         "../lib.rkt")

(define test-lib
  (test-suite
   "test-lib"

   (test-case
    "test-defs-to-hash"

    (let-values ([(def_hash attr_hash) (defs-to-hash '(("topic.v" . v)))])
      (check-equal? (hash-count def_hash) 2)

      (check-eq? (hash-ref def_hash "topic") 'k)
      (check-eq? (hash-ref def_hash "topic.v") 'v)

      (check-equal? (hash-count attr_hash) 0)
      )

    (let-values ([(def_hash attr_hash) (defs-to-hash '(("h1.h2.h3.topic" . v)))])
      (check-equal? (hash-count def_hash) 4)

      (check-eq? (hash-ref def_hash "h1") 'k)
      (check-eq? (hash-ref def_hash "h1.h2") 'k)
      (check-eq? (hash-ref def_hash "h1.h2.h3") 'k)
      (check-eq? (hash-ref def_hash "h1.h2.h3.topic") 'v)

      (check-equal? (hash-count attr_hash) 0)
      )

    (let-values ([(def_hash attr_hash) (defs-to-hash
                                        '(("h1.h2.h3.topic" . v) ("h3.h4.h5.v" . v)))])
      (check-equal? (hash-count def_hash) 8)

      (check-eq? (hash-ref def_hash "h1") 'k)
      (check-eq? (hash-ref def_hash "h1.h2") 'k)
      (check-eq? (hash-ref def_hash "h1.h2.h3") 'k)
      (check-eq? (hash-ref def_hash "h1.h2.h3.topic") 'v)

      (check-eq? (hash-ref def_hash "h3") 'k)
      (check-eq? (hash-ref def_hash "h3.h4") 'k)
      (check-eq? (hash-ref def_hash "h3.h4.h5") 'k)
      (check-eq? (hash-ref def_hash "h3.h4.h5.v") 'v)

      (check-equal? (hash-count attr_hash) 0)
      )

    (let-values ([(def_hash attr_hash) (defs-to-hash '(("h1.h2.h3.topic" . v) ("h1.h2.h4.topic" . a)))])
      (check-equal? (hash-count def_hash) 6)

      (check-eq? (hash-ref def_hash "h1") 'k)
      (check-eq? (hash-ref def_hash "h1.h2") 'k)
      (check-eq? (hash-ref def_hash "h1.h2.h3") 'k)
      (check-eq? (hash-ref def_hash "h1.h2.h4") 'k)
      (check-eq? (hash-ref def_hash "h1.h2.h3.topic") 'v)
      (check-eq? (hash-ref def_hash "h1.h2.h4.topic") 'a)

      (check-equal? (hash-count attr_hash) 1)

      (check-equal? (hash-ref attr_hash "h1.h2.h4") '("h1.h2.h4.topic"))
      )

    (let-values ([(def_hash attr_hash) (defs-to-hash '(("h1.h2.h3.topic" . a) ("h1.h2" . v)))])
      (check-equal? (hash-count def_hash) 4)

      (check-eq? (hash-ref def_hash "h1") 'k)
      (check-eq? (hash-ref def_hash "h1.h2") 'v)
      (check-eq? (hash-ref def_hash "h1.h2.h3") 'k)
      (check-eq? (hash-ref def_hash "h1.h2.h3.topic") 'a)

      (check-equal? (hash-count attr_hash) 1)
      (check-equal? (hash-ref attr_hash "h1.h2.h3") '("h1.h2.h3.topic"))
      )

    (let-values ([(def_hash attr_hash) (defs-to-hash '(("h1.h2" . v) ("h1.h2.h3.topic" . a) ("h1.h2.h3.content" . a)))])
      (check-equal? (hash-count def_hash) 5)

      (check-eq? (hash-ref def_hash "h1") 'k)
      (check-eq? (hash-ref def_hash "h1.h2") 'v)
      (check-eq? (hash-ref def_hash "h1.h2.h3") 'k)
      (check-eq? (hash-ref def_hash "h1.h2.h3.topic") 'a)
      (check-eq? (hash-ref def_hash "h1.h2.h3.content") 'a)

      (check-equal? (hash-count attr_hash) 1)
      (check-equal? (hash-ref attr_hash "h1.h2.h3") '("h1.h2.h3.topic" "h1.h2.h3.content"))
      )
    )
  ))

(run-tests test-lib)
