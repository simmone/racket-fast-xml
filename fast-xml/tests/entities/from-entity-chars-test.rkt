#lang racket

(require rackunit/text-ui
         rackunit
         racket/runtime-path
         "../../entity.rkt")

(define test-entities
  (test-suite
   "test-entities"
   
   (test-case
    "test-from-entity-chars"
    
    (check-equal? (from-entity-chars "basic") "basic")
    (check-equal? (from-entity-chars "basi;") "basi;")
    (check-equal? (from-entity-chars "b&sic") "b&sic")
    (check-equal? (from-entity-chars "b&sic;") "b&sic;")
    (check-equal? (from-entity-chars "b&amp") "b&amp")
    (check-equal? (from-entity-chars "b&am&p") "b&am&p")
    (check-equal? (from-entity-chars "b&amps;") "b&amps;")
    (check-equal? (from-entity-chars "b&amp;c") "b&c")
    (check-equal? (from-entity-chars "&amp;c") "&c")
    (check-equal? (from-entity-chars "b&amp;") "b&")

    (check-equal? (from-entity-chars "b&amp;c") "b&c")
    (check-equal? (from-entity-chars "b&amP;c") "b&c")
    (check-equal? (from-entity-chars "b&gt;c") "b>c")
    (check-equal? (from-entity-chars "b&lt;c") "b<c")
    (check-equal? (from-entity-chars "b&apos;c") "b'c")
    (check-equal? (from-entity-chars "b&quot;c") "b\"c")

    (check-equal? (from-entity-chars "&#&amp;;") "&#&;")
    )
  ))

(run-tests test-entities)
