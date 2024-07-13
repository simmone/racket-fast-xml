#lang racket

(require rackunit/text-ui
         rackunit
         racket/runtime-path
         "../main.rkt")

(define-runtime-path data_xml_file "data.xml")

(define test-xml
  (test-suite
   "test-xml"

   (test-case
    "test-sheet"

    (call-with-input-file data_xml_file
      (lambda (p)
        (let ([xml_hash
               (xml-port-to-hash
                p
                '(
                  "worksheet.dimension.ref"
                  "worksheet.sheetData.row.r"
                  "worksheet.sheetData.row.spans"
                  "worksheet.sheetData.row.s"
                  "worksheet.sheetData.row.customFormat"
                  "worksheet.sheetData.row.ht"
                  "worksheet.sheetData.row.customHeight"
                  "worksheet.sheetData.row.c.r"
                  "worksheet.sheetData.row.c.s"
                  "worksheet.sheetData.row.c.t"
                  "worksheet.sheetData.row.c.v"
                  "worksheet.mergeCells.mergeCell.ref"
                  ))
               ])
          (check-equal? (hash-ref xml_hash "worksheet's count") 1))))
    )
  ))

(run-tests test-xml)
