#lang racket

(require rackunit/text-ui
         rackunit
         racket/runtime-path
         "../../entity.rkt")

(define test-entities
  (test-suite
   "test-entities"
   
   (test-case
    "test-from-numberic-chars"
    
    (check-equal? (from-entity-chars "&#amp;") "&#amp;")
    (check-equal? (from-entity-chars ";am#;") ";am#;")
    (check-equal? (from-entity-chars "&am#;") "&am#;")

    (check-equal? (from-entity-chars "&#931;") "Σ")
    (check-equal? (from-entity-chars "&#0931;") "Σ")

    (check-equal? (from-entity-chars "&#x3a3;") "Σ")
    (check-equal? (from-entity-chars "&#x3A3;") "Σ")
    (check-equal? (from-entity-chars "&#x03A3;") "Σ")

    (check-equal? (from-entity-chars "&#21453;&#39304;&#20154;id") "反馈人id")

    (check-equal? (from-entity-chars "&amp&#931;;") "&ampΣ;")

    (check-equal? (from-entity-chars "&amp;#&#x03A3;") "&#Σ")
    )
  ))

(run-tests test-entities)
