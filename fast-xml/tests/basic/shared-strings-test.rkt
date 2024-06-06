#lang racket

(require rackunit/text-ui
         rackunit
         racket/runtime-path
         "../../main.rkt")

(define-runtime-path sharedStrings_xml_file "sharedStrings.xml")
(define-runtime-path sharedStrings_formated_xml_file "sharedStrings_formated.xml")
(define-runtime-path sharedStrings_compact_xml_file "sharedStrings_compact.xml")

(define test-xml
  (test-suite
   "test-xml"

   (test-case
    "test-shared-string"

    (let ([xml_hash (xml-file-to-hash
                     sharedStrings_xml_file
                     '(
                       "sst.count"
                       "sst.uniqueCount"
                       "sst.xmlns"
                       "sst.si.t"
                       "sst.si.phoneticPr.fontId"
                       "sst.si.phoneticPr.type"
                       ))])
      
      (check-equal? (hash-ref xml_hash "sst.count") '("17"))
      (check-equal? (hash-ref xml_hash "sst.uniqueCount") '("17"))
      (check-equal? (hash-ref xml_hash "sst.xmlns") '("http://schemas.openxmlformats.org/spreadsheetml/2006/main"))

      (check-equal? (hash-ref xml_hash "sst.si.t") '("" "201601" "201602" "201603" "201604"
                                                     "201605" "Asics" "Bottom" "CAT" "Center"
                                                     "Center/Middle" "Left" "Middle" "Puma" "Right"
                                                     "Top" "month/brand"))

      (check-equal? (hash-ref xml_hash "sst.si.phoneticPr.fontId")
                    '("1" "1" "1" "1" "1"
                      "1" "1" "1" "1" "1"
                      "1" "1" "1" "1" "1"
                      "1" "1"))

      (check-equal? (hash-ref xml_hash "sst.si.phoneticPr.type")
                    '("noConversion" "noConversion" "noConversion" "noConversion" "noConversion"
                      "noConversion" "noConversion" "noConversion" "noConversion" "noConversion"
                      "noConversion" "noConversion" "noConversion" "noConversion" "noConversion"
                      "noConversion" "noConversion"))
      ))

   (test-case
    "write-sharedString-xml"

    (let ([xml '("sst"
                 ("xmlns" . "http://schemas.openxmlformats.org/spreadsheetml/2006/main")
                 ("count" . "17")
                 ("uniqueCount" . "17")
                 ("si" ("t") ("phoneticPr" ("fontId" . "1") ("type" . "noConversion")))
                 ("si" ("t" "201601") ("phoneticPr" ("fontId" . "1") ("type" . "noConversion")))
                 ("si" ("t" "201602") ("phoneticPr" ("fontId" . "1") ("type" . "noConversion")))
                 ("si" ("t" "201603") ("phoneticPr" ("fontId" . "1") ("type" . "noConversion")))
                 ("si" ("t" "201604") ("phoneticPr" ("fontId" . "1") ("type" . "noConversion")))
                 ("si" ("t" "201605") ("phoneticPr" ("fontId" . "1") ("type" . "noConversion")))
                 ("si" ("t" "Asics") ("phoneticPr" ("fontId" . "1") ("type" . "noConversion")))
                 ("si" ("t" "Bottom") ("phoneticPr" ("fontId" . "1") ("type" . "noConversion")))
                 ("si" ("t" "CAT") ("phoneticPr" ("fontId" . "1") ("type" . "noConversion")))
                 ("si" ("t" "Center") ("phoneticPr" ("fontId" . "1") ("type" . "noConversion")))
                 ("si" ("t" "Center/Middle") ("phoneticPr" ("fontId" . "1") ("type" . "noConversion")))
                 ("si" ("t" "Left") ("phoneticPr" ("fontId" . "1") ("type" . "noConversion")))
                 ("si" ("t" "Middle") ("phoneticPr" ("fontId" . "1") ("type" . "noConversion")))
                 ("si" ("t" "Puma") ("phoneticPr" ("fontId" . "1") ("type" . "noConversion")))
                 ("si" ("t" "Right") ("phoneticPr" ("fontId" . "1") ("type" . "noConversion")))
                 ("si" ("t" "Top") ("phoneticPr" ("fontId" . "1") ("type" . "noConversion")))
                 ("si" ("t" "month/brand") ("phoneticPr" ("fontId" . "1") ("type" . "noConversion"))))])

      (call-with-input-file sharedStrings_formated_xml_file
        (lambda (p)
          (check-equal? (lists-to-xml xml)
                        (port->string p))))

      (call-with-input-file sharedStrings_compact_xml_file
        (lambda (p)
          (check-equal? (lists-to-compact_xml xml)
                        (port->string p))))))

  ))

(run-tests test-xml)
