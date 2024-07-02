#lang racket

(require rackunit/text-ui
         rackunit
         racket/runtime-path
         "../../main.rkt")

(define-runtime-path app_xml_file "app_test.xml")

(define test-xml
  (test-suite
   "test-docProc"

   (test-case
    "test-docProc"

    (let ([xml_hash (xml-file-to-hash
                     app_xml_file
                     '(
                       "Properties.TitlesOfParts.vt:vector.vt:lpstr"
                       ))])

      (check-equal? (hash-ref xml_hash "Properties1.TitlesOfParts1.vt:vector's count") 1)
      (check-equal? (hash-ref xml_hash "Properties1.TitlesOfParts1.vt:vector1.vt:lpstr's count") 6)

      (check-equal? (hash-ref xml_hash "Properties1.TitlesOfParts1.vt:vector1.vt:lpstr1") "数据页面")
      (check-equal? (hash-ref xml_hash "Properties1.TitlesOfParts1.vt:vector1.vt:lpstr2") "Sheet2")
      (check-equal? (hash-ref xml_hash "Properties1.TitlesOfParts1.vt:vector1.vt:lpstr3") "Sheet3")
      (check-equal? (hash-ref xml_hash "Properties1.TitlesOfParts1.vt:vector1.vt:lpstr4") "Chart1")
      (check-equal? (hash-ref xml_hash "Properties1.TitlesOfParts1.vt:vector1.vt:lpstr5") "Chart4")
      (check-equal? (hash-ref xml_hash "Properties1.TitlesOfParts1.vt:vector1.vt:lpstr6") "Chart5")
      )
    )

  ))

(run-tests test-xml)
