#lang racket

(require rackunit/text-ui
         rackunit
         racket/runtime-path
         "../../main.rkt")

(define-runtime-path entities_value_xml_file "entities_value.xml")
(define-runtime-path entities_attr_xml_file "entities_attr.xml")

(define test-entities
  (test-suite
   "test-entities"

   (test-case
    "test-entities-value-xml"

    (let ([xml_hash
           (xml-file-to-hash
            entities_value_xml_file
            '(
              "basic1.value"
              ))])
      (check-equal? (hash-ref xml_hash "basic11.value1") "&")
      (check-equal? (hash-ref xml_hash "basic11.value2") "<")
      (check-equal? (hash-ref xml_hash "basic11.value3") ">")
      (check-equal? (hash-ref xml_hash "basic11.value4") "'")
      (check-equal? (hash-ref xml_hash "basic11.value5") "\"")
      (check-equal? (hash-ref xml_hash "basic11.value6") "Σ")
      (check-equal? (hash-ref xml_hash "basic11.value7") "ß")
      ))

   (test-case
    "test-entities-attr-xml"

    (let ([xml_hash
           (xml-file-to-hash
            entities_attr_xml_file
            '(
              "basic1.attr1"
              "basic1.attr2"
              "basic1.attr3"
              "basic1.attr4"
              "basic1.attr5"
              "basic1.attr6"
              "basic1.attr7"
              ))])

      (check-equal? (hash-ref xml_hash "basic11.attr11") "&")
      (check-equal? (hash-ref xml_hash "basic11.attr21") "<")
      (check-equal? (hash-ref xml_hash "basic11.attr31") ">")
      (check-equal? (hash-ref xml_hash "basic11.attr41") "'")
      (check-equal? (hash-ref xml_hash "basic11.attr51") "\"")
      (check-equal? (hash-ref xml_hash "basic11.attr61") "Σ")
      (check-equal? (hash-ref xml_hash "basic11.attr71") "ß")
      ))
  ))

(run-tests test-entities)
