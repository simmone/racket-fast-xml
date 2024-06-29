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
              "worksheet.cols.col.min"
              )
              )])

      (check-equal? (hash-ref xml_hash "worksheet1.cols1.col1.min1") "1")
      (check-equal? (hash-ref xml_hash "worksheet1.cols1.col2.min1") "3")
      (check-equal? (hash-ref xml_hash "worksheet1.cols1.col3.min1") "4")
      (check-equal? (hash-ref xml_hash "worksheet1.cols1.col4.min1") "8")
      (check-equal? (hash-ref xml_hash "worksheet1.cols1.col5.min1") "13")
      (check-equal? (hash-ref xml_hash "worksheet1.cols1.col6.min1") "14")
      (check-equal? (hash-ref xml_hash "worksheet1.cols1.col7.min1") "16")
      (check-equal? (hash-ref xml_hash "worksheet1.cols1.col8.min1") "17")
      (check-equal? (hash-ref xml_hash "worksheet1.cols1.col9.min1") "18")
      (check-equal? (hash-ref xml_hash "worksheet1.cols1.col10.min1") "22")
      (check-equal? (hash-ref xml_hash "worksheet1.cols1.col11.min1") "25")
      (check-equal? (hash-ref xml_hash "worksheet1.cols1.col12.min1") "27")
      (check-equal? (hash-ref xml_hash "worksheet1.cols1.col13.min1") "31")
      (check-equal? (hash-ref xml_hash "worksheet1.cols1.col14.min1") "33")
      (check-equal? (hash-ref xml_hash "worksheet1.cols1.col15.min1") "38")
      (check-equal? (hash-ref xml_hash "worksheet1.cols1.col16.min1") "39")
      (check-equal? (hash-ref xml_hash "worksheet1.cols1.col17.min1") "40")
      (check-equal? (hash-ref xml_hash "worksheet1.cols1.col18.min1") "47")
      (check-equal? (hash-ref xml_hash "worksheet1.cols1.col19.min1") "48")
      ))
  ))

(run-tests test-xml)
