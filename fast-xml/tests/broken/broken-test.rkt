#lang racket

(require rackunit/text-ui
         rackunit
         racket/runtime-path
         "../../main.rkt")

(define-runtime-path broken_xml_file "broken.xml")

(define test-xml
  (test-suite
   "test-broken"

   (test-case
    "test-broken"

    (let ([xml_hash
           (xml-file-to-hash broken_xml_file '("worksheet.xmlns"))])

      (check-equal? (hash-ref xml_hash "worksheet1.xmlns1") "http://schemas.openxmlformats.org/spreadsheetml/2006/main"))

    (let ([xml_hash
           (xml-port-to-hash (open-input-file broken_xml_file) '("worksheet.xmlns"))])
      (check-equal? (hash-ref xml_hash "worksheet1.xmlns1") "http://schemas.openxmlformats.org/spreadsheetml/2006/main"))
    )

  ))

(run-tests test-xml)
