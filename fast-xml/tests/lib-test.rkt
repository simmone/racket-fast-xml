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
      (check-eq? (hash-ref def_hash "h1.h2.h3.topic") 'v)
      )

    (let ([def_hash (defs-to-hash '("h1.h2.h3.topic" "h3.h4.h5.v"))])
      (check-equal? (hash-count def_hash) 8)

      (check-eq? (hash-ref def_hash "h1") 'k)
      (check-eq? (hash-ref def_hash "h1.h2") 'k)
      (check-eq? (hash-ref def_hash "h1.h2.h3") 'k)
      (check-eq? (hash-ref def_hash "h1.h2.h3.topic") 'v)

      (check-eq? (hash-ref def_hash "h3") 'k)
      (check-eq? (hash-ref def_hash "h3.h4") 'k)
      (check-eq? (hash-ref def_hash "h3.h4.h5") 'k)
      (check-eq? (hash-ref def_hash "h3.h4.h5.v") 'v)
      )

    (let ([def_hash (defs-to-hash '("h1.h2.h3.topic" "h1.h2.h4.topic"))])
      (check-equal? (hash-count def_hash) 6)

      (check-eq? (hash-ref def_hash "h1") 'k)
      (check-eq? (hash-ref def_hash "h1.h2") 'k)
      (check-eq? (hash-ref def_hash "h1.h2.h3") 'k)
      (check-eq? (hash-ref def_hash "h1.h2.h4") 'k)
      (check-eq? (hash-ref def_hash "h1.h2.h3.topic") 'v)
      (check-eq? (hash-ref def_hash "h1.h2.h4.topic") 'v)
      )

    (let ([def_hash (defs-to-hash '("h1.h2.h3.topic" "h1.h2"))])
      (check-equal? (hash-count def_hash) 4)

      (check-eq? (hash-ref def_hash "h1") 'k)
      (check-eq? (hash-ref def_hash "h1.h2") 'kv)
      (check-eq? (hash-ref def_hash "h1.h2.h3") 'k)
      (check-eq? (hash-ref def_hash "h1.h2.h3.topic") 'v)
      )

    (let ([def_hash (defs-to-hash '("h1.h2" "h1.h2.h3.topic" "h1.h2.h3.content"))])
      (check-equal? (hash-count def_hash) 5)

      (check-eq? (hash-ref def_hash "h1") 'k)
      (check-eq? (hash-ref def_hash "h1.h2") 'kv)
      (check-eq? (hash-ref def_hash "h1.h2.h3") 'k)
      (check-eq? (hash-ref def_hash "h1.h2.h3.topic") 'v)
      (check-eq? (hash-ref def_hash "h1.h2.h3.content") 'v)
      )

    (let ([def_hash (defs-to-hash '("h" "h.a" "h.b"))])
      (check-equal? (hash-count def_hash) 3)

      (check-eq? (hash-ref def_hash "h") 'kv)
      (check-eq? (hash-ref def_hash "h.a") 'v)
      (check-eq? (hash-ref def_hash "h.b") 'v)
      )

    (let ([def_hash (defs-to-hash '("h.a" "h" "h.b"))])
      (check-equal? (hash-count def_hash) 3)

      (check-eq? (hash-ref def_hash "h") 'kv)
      (check-eq? (hash-ref def_hash "h.a") 'v)
      (check-eq? (hash-ref def_hash "h.b") 'v)
      )
    )

   (test-case
    "test-from-keys-to-pure-key"
    
    (check-equal? (from-keys-to-pure-key '(("a" . 1))) "a")

    (check-equal? (from-keys-to-pure-key '(("b" . 1) ("a" . 1))) "a.b")

    (check-equal? (from-keys-to-pure-key '(("c" . 2) ("b" . 1) ("a" . 2))) "a.b.c")

    (check-equal? (from-keys-to-pure-key '(("d" . 3) ("c" . 2) ("b" . 1) ("a" . 2))) "a.b.c.d")
    )

   (test-case
    "test-from-keys-to-count-key"

    (check-equal? (from-keys-to-count-key '(("a" . 1))) "a")

    (check-equal? (from-keys-to-count-key '(("b" . 1) ("a" . 1))) "a1.b")

    (check-equal? (from-keys-to-count-key '(("c" . 2) ("b" . 1) ("a" . 2))) "a2.b1.c")

    (check-equal? (from-keys-to-count-key '(("d" . 3) ("c" . 2) ("b" . 1) ("a" . 2))) "a2.b1.c2.d")
    )

   (test-case
    "test-from-keys-to-value-key"

    (check-equal? (from-keys-to-value-key '(("a" . 1))) "a1")

    (check-equal? (from-keys-to-value-key '(("b" . 1) ("a" . 1))) "a1.b1")

    (check-equal? (from-keys-to-value-key '(("c" . 2) ("b" . 1) ("a" . 2))) "a2.b1.c2")

    (check-equal? (from-keys-to-value-key '(("d" . 3) ("c" . 2) ("b" . 1) ("a" . 2))) "a2.b1.c2.d3")
    )

  ))

(run-tests test-lib)
