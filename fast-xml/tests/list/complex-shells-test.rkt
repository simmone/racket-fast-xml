#lang racket

(require rackunit/text-ui
         rackunit
         racket/runtime-path
         "../../main.rkt")

(define-runtime-path complex_shells_xml_file "complex_shells.xml")

(define test-xml
  (test-suite
   "test-xml"

   (test-case
    "test-complex-shells-xml"

    (let ([xml_hash
           (xml-file-to-hash
            complex_shells_xml_file
            '(
              ("worksheet.cols.col.min" . a)
              )
              )])

      (check-equal? (hash-count xml_hash) 1)
      
      (check-equal? (hash-ref xml_hash "worksheet.cols.col.min") '("1" "3" "4" "8" "13" "14" "16" "17" "18"
                                                                   "22" "25" "27" "31" "33" "38" "39" "40"
                                                                   "47" "48"))
      ))
  ))

(run-tests test-xml)
