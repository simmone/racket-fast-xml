#lang racket

(require rackunit/text-ui
         rackunit
         racket/runtime-path
         "../../main.rkt")

(define-runtime-path special_char_xml_file "special_char_test.xml")

(define test-xml
  (test-suite
   "test-xml"

   (test-case
    "test-special-char"

    (let ([xml_hash (xml-file-to-hash special_char_xml_file '(("sst.si.t" . v)))])
      
      (check-equal? (hash-ref xml_hash "sst.si.t") '("<test>" "<foo> " " <baz>" "< bar>" "< fro >"
                                                     "<bas >" "<maybe" "<< not >>" "show>"))
      ))
  ))

(run-tests test-xml)
