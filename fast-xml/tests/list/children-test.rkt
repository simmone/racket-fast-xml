#lang racket

(require rackunit/text-ui
         rackunit
         racket/runtime-path
         "../../main.rkt")

(define-runtime-path children_xml_file "children.xml")

(define test-xml
  (test-suite
   "test-xml"

   (test-case
    "read-children-xml"

    (let ([xml_hash (xml-file-to-hash children_xml_file
                                 '(
                                   "children.child1"
                                   "children.child1.attr1"
                                   "children.child2"
                                   "children.child2.attr1"
                                   ))])

      (check-equal? (hash-ref xml_hash "children1.child11") "c1")
      (check-equal? (hash-ref xml_hash "children1.child12") "")
      (check-equal? (hash-ref xml_hash "children1.child11.attr11") "a1")

      (check-equal? (hash-ref xml_hash "children1.child21") "c2")
      (check-equal? (hash-ref xml_hash "children1.child22") "c3")
      (check-equal? (hash-ref xml_hash "children1.child21.attr11") "a2")
      
      (check-equal? (hash-ref xml_hash "children's count") 1)
      (check-equal? (hash-ref xml_hash "children1.child1's count") 2)
      (check-equal? (hash-ref xml_hash "children1.child2's count") 2)

      (check-equal? (hash-count xml_hash) 9)
      )
    )

   (test-case
    "write-children-xml"

    (let ([xml '("children" ("child1" ("attr1" . "a1") "c1") ("child2" ("attr1" . "a2") "c2") ("child1") ("child2" "c3"))])
      (call-with-input-file children_xml_file
        (lambda (p)
          (check-equal? (lists-to-xml xml)
                        (port->string p)))))
    )
  ))

(run-tests test-xml)
