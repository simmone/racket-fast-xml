#lang racket

(require rackunit/text-ui
         rackunit
         racket/runtime-path
         "../../main.rkt")

(define-runtime-path attr1_xml_file "attr1.xml")

(define test-attr
  (test-suite
   "test-attr"

   (test-case
    "test-attr1-xml"

    (let ([xml_hash
           (xml-file-to-hash
            attr1_xml_file
            '(
              ("worksheet.xmlns" . a)
              ))])

      (check-equal? (hash-count xml_hash) 1)

      (check-equal? (hash-ref xml_hash "worksheet.xmlns") '("http://schemas.openxmlformats.org/spreadsheetml/2006/main"))
      ))
  ))

(run-tests test-attr)
