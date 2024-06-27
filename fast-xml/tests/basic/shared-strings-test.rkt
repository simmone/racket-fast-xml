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
      
      (check-equal? (hash-ref xml_hash "sst1.count1") "17")
      (check-equal? (hash-ref xml_hash "sst1.uniqueCount1") "17")
      (check-equal? (hash-ref xml_hash "sst1.xmlns1") "http://schemas.openxmlformats.org/spreadsheetml/2006/main")

      (check-equal? (hash-ref xml_hash "sst1.si1.t1") "")
      (check-equal? (hash-ref xml_hash "sst1.si2.t1") "201601")
      (check-equal? (hash-ref xml_hash "sst1.si3.t1") "201602")
      (check-equal? (hash-ref xml_hash "sst1.si4.t1") "201603")
      (check-equal? (hash-ref xml_hash "sst1.si5.t1") "201604")
      (check-equal? (hash-ref xml_hash "sst1.si6.t1") "201605")
      (check-equal? (hash-ref xml_hash "sst1.si7.t1") "Asics")
      (check-equal? (hash-ref xml_hash "sst1.si8.t1") "Bottom")
      (check-equal? (hash-ref xml_hash "sst1.si9.t1") "CAT")
      (check-equal? (hash-ref xml_hash "sst1.si10.t1") "Center")
      (check-equal? (hash-ref xml_hash "sst1.si11.t1") "Center/Middle")
      (check-equal? (hash-ref xml_hash "sst1.si12.t1") "Left")
      (check-equal? (hash-ref xml_hash "sst1.si13.t1") "Middle")
      (check-equal? (hash-ref xml_hash "sst1.si14.t1") "Puma")
      (check-equal? (hash-ref xml_hash "sst1.si15.t1") "Right")
      (check-equal? (hash-ref xml_hash "sst1.si16.t1") "Top")
      (check-equal? (hash-ref xml_hash "sst1.si17.t1") "month/brand")

      (check-equal? (hash-ref xml_hash "sst1.si1.phoneticPr1.fontId1") "1")
      (check-equal? (hash-ref xml_hash "sst1.si2.phoneticPr1.fontId1") "1")
      (check-equal? (hash-ref xml_hash "sst1.si3.phoneticPr1.fontId1") "1")
      (check-equal? (hash-ref xml_hash "sst1.si4.phoneticPr1.fontId1") "1")
      (check-equal? (hash-ref xml_hash "sst1.si5.phoneticPr1.fontId1") "1")
      (check-equal? (hash-ref xml_hash "sst1.si6.phoneticPr1.fontId1") "1")
      (check-equal? (hash-ref xml_hash "sst1.si7.phoneticPr1.fontId1") "1")
      (check-equal? (hash-ref xml_hash "sst1.si8.phoneticPr1.fontId1") "1")
      (check-equal? (hash-ref xml_hash "sst1.si9.phoneticPr1.fontId1") "1")
      (check-equal? (hash-ref xml_hash "sst1.si10.phoneticPr1.fontId1") "1")
      (check-equal? (hash-ref xml_hash "sst1.si11.phoneticPr1.fontId1") "1")
      (check-equal? (hash-ref xml_hash "sst1.si12.phoneticPr1.fontId1") "1")
      (check-equal? (hash-ref xml_hash "sst1.si13.phoneticPr1.fontId1") "1")
      (check-equal? (hash-ref xml_hash "sst1.si14.phoneticPr1.fontId1") "1")
      (check-equal? (hash-ref xml_hash "sst1.si15.phoneticPr1.fontId1") "1")
      (check-equal? (hash-ref xml_hash "sst1.si16.phoneticPr1.fontId1") "1")
      (check-equal? (hash-ref xml_hash "sst1.si17.phoneticPr1.fontId1") "1")

      (check-equal? (hash-ref xml_hash "sst1.si1.phoneticPr1.type1") "noConversion")
      (check-equal? (hash-ref xml_hash "sst1.si2.phoneticPr1.type1") "noConversion")
      (check-equal? (hash-ref xml_hash "sst1.si3.phoneticPr1.type1") "noConversion")
      (check-equal? (hash-ref xml_hash "sst1.si4.phoneticPr1.type1") "noConversion")
      (check-equal? (hash-ref xml_hash "sst1.si5.phoneticPr1.type1") "noConversion")
      (check-equal? (hash-ref xml_hash "sst1.si6.phoneticPr1.type1") "noConversion")
      (check-equal? (hash-ref xml_hash "sst1.si7.phoneticPr1.type1") "noConversion")
      (check-equal? (hash-ref xml_hash "sst1.si8.phoneticPr1.type1") "noConversion")
      (check-equal? (hash-ref xml_hash "sst1.si9.phoneticPr1.type1") "noConversion")
      (check-equal? (hash-ref xml_hash "sst1.si10.phoneticPr1.type1") "noConversion")
      (check-equal? (hash-ref xml_hash "sst1.si11.phoneticPr1.type1") "noConversion")
      (check-equal? (hash-ref xml_hash "sst1.si12.phoneticPr1.type1") "noConversion")
      (check-equal? (hash-ref xml_hash "sst1.si13.phoneticPr1.type1") "noConversion")
      (check-equal? (hash-ref xml_hash "sst1.si14.phoneticPr1.type1") "noConversion")
      (check-equal? (hash-ref xml_hash "sst1.si15.phoneticPr1.type1") "noConversion")
      (check-equal? (hash-ref xml_hash "sst1.si16.phoneticPr1.type1") "noConversion")
      (check-equal? (hash-ref xml_hash "sst1.si17.phoneticPr1.type1") "noConversion")
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
