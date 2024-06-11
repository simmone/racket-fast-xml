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

      (check-equal? (hash-count (hash-ref attr_hash "h1.h2.h4")) 1)

      (check-false (hash-ref
                    (hash-ref attr_hash "h1.h2.h4")
                   "h1.h2.h4.topic"))
      )

    (let-values ([(def_hash attr_hash) (defs-to-hash '(("h1.h2.h3.topic" . a) ("h1.h2" . v)))])
      (check-equal? (hash-count def_hash) 4)

      (check-eq? (hash-ref def_hash "h1") 'k)
      (check-eq? (hash-ref def_hash "h1.h2") 'v)
      (check-eq? (hash-ref def_hash "h1.h2.h3") 'k)
      (check-eq? (hash-ref def_hash "h1.h2.h3.topic") 'a)

      (check-equal? (hash-count attr_hash) 1)

      (check-equal? (hash-count (hash-ref attr_hash "h1.h2.h3")) 1)

      (check-false (hash-ref
                    (hash-ref attr_hash "h1.h2.h3")
                   "h1.h2.h3.topic"))
      )

    (let-values ([(def_hash attr_hash) (defs-to-hash '(("h1.h2" . v) ("h1.h2.h3.topic" . a) ("h1.h2.h3.content" . a)))])
      (check-equal? (hash-count def_hash) 5)

      (check-eq? (hash-ref def_hash "h1") 'k)
      (check-eq? (hash-ref def_hash "h1.h2") 'v)
      (check-eq? (hash-ref def_hash "h1.h2.h3") 'k)
      (check-eq? (hash-ref def_hash "h1.h2.h3.topic") 'a)
      (check-eq? (hash-ref def_hash "h1.h2.h3.content") 'a)

      (check-equal? (hash-count attr_hash) 1)

      (check-equal? (hash-count (hash-ref attr_hash "h1.h2.h3")) 2)

      (check-false (hash-ref
                    (hash-ref attr_hash "h1.h2.h3")
                   "h1.h2.h3.topic"))

      (check-false (hash-ref
                    (hash-ref attr_hash "h1.h2.h3")
                   "h1.h2.h3.content"))
      )
    )

   (test-case
    "test-from-special-chars"
    
    (check-equal? (from-special-chars "1&lt;2") "1<2")
    (check-equal? (from-special-chars "1&gt;2") "1>2")
    (check-equal? (from-special-chars "1&amp;2") "1&2")
    (check-equal? (from-special-chars "1&apos;2") "1'2")
    (check-equal? (from-special-chars "1&quot;2") "1\"2")

    (check-equal? (from-special-chars "1&quot;&quot;2&lt;3&gt;4&amp;5&apos;6") "1\"\"2<3>4&5'6")
    )

   (test-case
    "test-to-special-chars"
    
    (check-equal? (to-special-chars "1<2") "1&lt;2")
    (check-equal? (to-special-chars "1>2") "1&gt;2")
    (check-equal? (to-special-chars "1&2") "1&amp;2")
    (check-equal? (to-special-chars "1'2") "1&apos;2")
    (check-equal? (to-special-chars "1\"2") "1&quot;2")

    (check-equal? (to-special-chars "1\"\"2<3>4&5'6") "1&quot;&quot;2&lt;3&gt;4&amp;5&apos;6"))

  ))

(run-tests test-lib)
