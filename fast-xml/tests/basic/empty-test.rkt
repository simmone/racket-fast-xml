#lang racket

(require rackunit/text-ui
         rackunit
         racket/runtime-path
         "../../main.rkt")

(define-runtime-path empty1_xml_file "empty1.xml")
(define-runtime-path empty2_xml_file "empty2.xml")

(define test-xml
  (test-suite
   "test-xml"

   (test-case
    "test-empty1-xml"

    (let ([xml_hash (xml-file-to-hash
                     empty1_xml_file
                     '("data.empty" "data.empty.attr1" "data.empty.attr2")
                     )])

      (check-equal? (hash-ref xml_hash "data's count") 1)
      (check-equal? (hash-ref xml_hash "data1.empty's count") 5)
      (check-equal? (hash-ref xml_hash "data1.empty1") "1")
      (check-equal? (hash-ref xml_hash "data1.empty2") "3")
      (check-equal? (hash-ref xml_hash "data1.empty3") "")
      (check-equal? (hash-ref xml_hash "data1.empty4") "4")
      (check-equal? (hash-ref xml_hash "data1.empty5") "")
      (check-equal? (hash-ref xml_hash "data1.empty1.attr11") "a1")
      (check-equal? (hash-ref xml_hash "data1.empty1.attr21") "a2")
      )
    )

   (test-case
    "test-empty2-xml"

    (let ([xml_hash (xml-file-to-hash
                     empty2_xml_file
                     '("empty" "empty.attr1" "empty.attr2")
                     )])

      (check-equal? (hash-count xml_hash) 4)
      (check-equal? (hash-ref xml_hash "empty's count") 1)
      (check-equal? (hash-ref xml_hash "empty1") "")
      (check-equal? (hash-ref xml_hash "empty1.attr11") "a1")
      (check-equal? (hash-ref xml_hash "empty1.attr21") "a2")
      )
    )

   (test-case
    "write-empty-xml"

    (let ([xml '("data"
                 ("empty" "1" ("attr1" . "a1") ("attr2" . "a2"))
                 ("empty" "3")
                 ("empty" "")
                 ("empty" "4")
                 ("empty" "")
                 )])
      (call-with-input-file empty1_xml_file
        (lambda (p)
          (check-equal? (lists-to-xml xml)
                        (port->string p))))))

  ))

(run-tests test-xml)
