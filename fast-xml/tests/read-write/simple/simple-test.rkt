#lang racket

(require rackunit/text-ui
         rackunit
         racket/runtime-path
         "../../../main.rkt")

(define-runtime-path simple1_xml_file "simple1.xml")

(define test-simple
  (test-suite
   "test-simple"

   (test-case
    "test-simple1-xml"

    (let ([xml_hash
           (xml-file-to-hash
            simple1_xml_file
            '(("value" . v)))])
      (check-equal? (hash-count xml_hash) 1)

      (check-equal? (hash-ref xml_hash "value") 1)
      ))

   (test-case
    "write-simple1-xml"

    (let ([xml '(("value" "1"))])
      (call-with-input-file simple1_xml_file
        (lambda (p)
          (check-equal? (lists-to-xml xml)
                        (port->string p))))))

  ))

(run-tests test-simple)
