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
              "worksheet.xmlns"
              "worksheet.cols.test"
              "worksheet.cols.col.collapsed"
              ))])

      (check-equal? (hash-count xml_hash) 7)

      (check-equal? (hash-ref xml_hash "worksheet's count") 1)

      (check-equal? (hash-ref xml_hash "worksheet1.cols's count") 1)

      (check-equal? (hash-ref xml_hash "worksheet1.cols1.col's count") 3)

      (check-equal? (hash-ref xml_hash "worksheet1.xmlns") "http://schemas.openxmlformats.org/spreadsheetml/2006/main")

      (check-equal? (hash-ref xml_hash "worksheet1.cols1.test") "2")

      (check-equal? (hash-ref xml_hash "worksheet1.cols1.col1.collapsed") "1")

      (check-equal? (hash-ref xml_hash "worksheet1.cols1.col2.collapsed") "2")
      ))
  ))

(run-tests test-attr)
