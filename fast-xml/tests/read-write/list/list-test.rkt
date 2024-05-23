#lang racket

(require rackunit/text-ui rackunit)
(require racket/date)

(require racket/runtime-path)
(define-runtime-path list_xml_file "list.xml")

(require "../../main.rkt")

(define test-xml
  (test-suite
   "test-xml"

   (test-case
    "test-list-xml"

    (let ([xml_hash (xml->hash list_xml_file)])
      (check-equal? (hash-count xml_hash) 8)

      (check-equal? (hash-ref xml_hash "list's count") 1)

      (check-equal? (hash-ref xml_hash "list1.child's count") 3)

      (check-equal? (hash-ref xml_hash "list1.child1") "c1")
      (check-equal? (hash-ref xml_hash "list1.child1.attr") "a1")

      (check-equal? (hash-ref xml_hash "list1.child2") "c2")
      (check-equal? (hash-ref xml_hash "list1.child2.attr") "a2")

      (check-equal? (hash-ref xml_hash "list1.child3") "c3")
      (check-equal? (hash-ref xml_hash "list1.child3.attr") "a3")
      ))

   (test-case
    "write-list-xml"

    (let ([xml '("list"
                 ("child" ("attr" . "a1") "c1")
                 ("child" ("attr" . "a2") "c2")
                 ("child" ("attr" . "a3") "c3"))])

      (call-with-input-file list_xml_file
        (lambda (p)
          (check-equal? (lists->xml xml)
                        (port->string p))))))

  ))

(run-tests test-xml)
