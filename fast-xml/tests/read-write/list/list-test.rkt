#lang racket

(require rackunit/text-ui
         rackunit
         racket/runtime-path
         "../../../main.rkt")

(define-runtime-path list1_xml_file "list1.xml")

(define test-xml
  (test-suite
   "test-xml"

   (test-case
    "test-list-xml"

    (let ([xml_hash
           (xml-file-to-hash
            list1_xml_file
            '(
              "list.child"
              "list.child.attr"))])
      (check-equal? (hash-count xml_hash) 2)
      
      (check-equal? (hash-ref xml_hash "list.child") '("c1" "c2" "c3"))
      (check-equal? (hash-ref xml_hash "list.child.attr") '("a1" "a2" "a3"))
      ))

   (test-case
    "write-list-xml"

    (let ([xml '("list"
                 ("child" ("attr" . "a1") "c1")
                 ("child" ("attr" . "a2") "c2")
                 ("child" ("attr" . "a3") "c3"))])

      (call-with-input-file list1_xml_file
        (lambda (p)
          (check-equal? (lists-to-xml xml)
                        (port->string p))))))

  ))

(run-tests test-xml)
