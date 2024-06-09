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
              ("worksheet.cols.test" . a)
              ("worksheet.cols.col.collapsed" . a)
              ))])

      (check-equal? (hash-count xml_hash) 3)

      (check-equal? (hash-ref xml_hash "worksheet.xmlns") '("http://schemas.openxmlformats.org/spreadsheetml/2006/main"))

      (check-equal? (hash-ref xml_hash "worksheet.cols.test") '("2"))

      (check-equal? (hash-ref xml_hash "worksheet.cols.col.collapsed") '("1" "2" ""))
      ))
  ))

(run-tests test-attr)
