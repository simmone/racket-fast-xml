#lang racket

(require rackunit/text-ui
         rackunit
         racket/runtime-path
         "../../main.rkt")

(define-runtime-path list1_xml_file "list1.xml")
(define-runtime-path list2_xml_file "list2.xml")
(define-runtime-path list3_xml_file "list3.xml")
(define-runtime-path list4_xml_file "list4.xml")

(define test-xml
  (test-suite
   "test-xml"

   (test-case
    "test-list1-xml"

    (let ([xml_hash
           (xml-file-to-hash
            list1_xml_file
            '(
              "list.child"
              "list.child.attr"
              ))])

      (check-equal? (hash-count xml_hash) 8)
      
      (check-equal? (hash-ref xml_hash "list1.child1") "c1")
      (check-equal? (hash-ref xml_hash "list1.child2") "c2")
      (check-equal? (hash-ref xml_hash "list1.child3") "c3")
      (check-equal? (hash-ref xml_hash "list1.child1.attr1") "a1")
      (check-equal? (hash-ref xml_hash "list1.child2.attr1") "a2")
      (check-equal? (hash-ref xml_hash "list1.child3.attr1") "a3")
      ))

   (test-case
    "write-list1-xml"

    (let ([xml '("list"
                 ("child" ("attr" . "a1") "c1")
                 ("child" ("attr" . "a2") "c2")
                 ("child" ("attr" . "a3") "c3"))])

      (call-with-input-file list1_xml_file
        (lambda (p)
          (check-equal? (lists-to-xml xml)
                        (port->string p))))))

   (test-case
    "test-read-list2-xml"

    (let ([xml_hash
           (xml-file-to-hash
            list2_xml_file
            '(
              "list.child"
              "list.child.attr"
              ))])
      
      (check-equal? (hash-count xml_hash) 15)

      (check-equal? (hash-ref xml_hash "list's count") 2)

      (check-equal? (hash-ref xml_hash "list1.child's count") 3)
      (check-equal? (hash-ref xml_hash "list1.child1") "c1")
      (check-equal? (hash-ref xml_hash "list1.child2") "c2")
      (check-equal? (hash-ref xml_hash "list1.child3") "c3")

      (check-equal? (hash-ref xml_hash "list2.child's count") 3)
      (check-equal? (hash-ref xml_hash "list2.child1") "c4")
      (check-equal? (hash-ref xml_hash "list2.child2") "c5")
      (check-equal? (hash-ref xml_hash "list2.child3") "c6")

      (check-equal? (hash-ref xml_hash "list1.child1.attr1") "a1")
      (check-equal? (hash-ref xml_hash "list1.child2.attr1") "a2")
      (check-equal? (hash-ref xml_hash "list1.child3.attr1") "a3")

      (check-equal? (hash-ref xml_hash "list2.child1.attr1") "a4")
      (check-equal? (hash-ref xml_hash "list2.child2.attr1") "a5")
      (check-equal? (hash-ref xml_hash "list2.child3.attr1") "a6")
      ))

   (test-case
    "test-read-list3-xml"

    (let ([xml_hash
           (xml-file-to-hash
            list3_xml_file
            '(
              "list.child"
              ))])
      
      (check-equal? (hash-count xml_hash) 5)
      
      (check-equal? (hash-ref xml_hash "list1.child1") "c1")
      (check-equal? (hash-ref xml_hash "list1.child2") "")
      (check-equal? (hash-ref xml_hash "list1.child3") "c3"))

    (let ([xml_hash
           (xml-file-to-hash
            list3_xml_file
            '(
              "list.child.attr"
              ))])
      (check-equal? (hash-count xml_hash) 5)
      
      (check-equal? (hash-ref xml_hash "list1.child1.attr1") "a1")
      (check-equal? (hash-ref xml_hash "list1.child2.attr1") "a2")
      (check-equal? (hash-ref xml_hash "list1.child3.attr1") "a3")
    ))

   (test-case
    "test-read-list4-xml"

    (let ([xml_hash
           (xml-file-to-hash
            list4_xml_file
            '(
              "list.child"
              "list.child.attr"
              ))])

      (check-equal? (hash-count xml_hash) 14)
      
      (check-equal? (hash-ref xml_hash "list1.child1") "c1")
      (check-equal? (hash-ref xml_hash "list1.child2") "")
      (check-equal? (hash-ref xml_hash "list1.child3") "c3")
      (check-equal? (hash-ref xml_hash "list1.child4") "")
      (check-equal? (hash-ref xml_hash "list1.child5") "c4")
      (check-equal? (hash-ref xml_hash "list1.child6") "")
      (check-equal? (hash-ref xml_hash "list1.child7") "")
      (check-equal? (hash-ref xml_hash "list1.child8") "")
      (check-equal? (hash-ref xml_hash "list1.child1.attr1") "a1")
      (check-equal? (hash-ref xml_hash "list1.child2.attr1") "a2")
      (check-equal? (hash-ref xml_hash "list1.child3.attr1") "a3")
      (check-equal? (hash-ref xml_hash "list1.child8.attr1") "a6")
      ))

  ))

(run-tests test-xml)
