#lang racket

(require rackunit/text-ui
         rackunit
         racket/runtime-path
         "../../../main.rkt")

(define-runtime-path simple1_xml_file "simple1.xml")
(define-runtime-path simple2_xml_file "simple2.xml")

(define test-simple
  (test-suite
   "test-simple"

   (test-case
    "test-simple1-xml"

    (let ([xml_hash
           (xml-file-to-hash
            simple1_xml_file
            '(
              "?xml.version"
              "?xml.encoding"
              "?xml.standalone"
              "basic1.value"
              ))])
      (check-equal? (hash-count xml_hash) 4)

      (check-equal? (hash-ref xml_hash "?xml.version") '("1.0"))

      (check-equal? (hash-ref xml_hash "?xml.encoding") '("UTF-8"))

      (check-equal? (hash-ref xml_hash "?xml.standalone") '("yes"))
      
      (check-equal? (hash-ref xml_hash "basic1.value") '("1"))
      ))

   (test-case
    "write-simple1-xml"

    (let ([xml '("basic1" ("value" "1"))])
      (call-with-input-file simple1_xml_file
        (lambda (p)
          (check-equal? (lists-to-xml xml)
                        (port->string p))))))

   (test-case
    "test-simple2-xml"

    (let ([xml_hash
           (xml-file-to-hash
            simple2_xml_file
            '("h1.h2.topic"))])
      (check-equal? (hash-count xml_hash) 1)
      
      (check-equal? (hash-ref xml_hash "h1.h2.topic") '("cx"))
      ))
  ))

(run-tests test-simple)
