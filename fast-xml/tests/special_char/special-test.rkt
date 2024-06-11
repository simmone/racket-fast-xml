#lang racket

(require rackunit/text-ui
         rackunit
         racket/runtime-path
         "../../main.rkt")

(define-runtime-path special1_xml_file "special1.xml")
(define-runtime-path special2_xml_file "special2.xml")

(define test-special
  (test-suite
   "test-special"

   (test-case
    "test-special-xml"

    (let ([xml_hash
           (xml-file-to-hash
            special1_xml_file
            '(
              ("basic1.attr" . a)
              ("basic1.value" . v)
              ))])

      (check-equal? (hash-count xml_hash) 2)

      (check-equal? (hash-ref xml_hash "basic1.attr") '("<2>"))

      (check-equal? (hash-ref xml_hash "basic1.value") '("<1>"))
      ))

   (test-case
    "write-special1-xml"

    (let ([xml '("basic1" ("attr" . "<2>") ("value" "<1>"))])
      (call-with-input-file special1_xml_file
        (lambda (p)
          (check-equal? (lists-to-xml xml)
                        (port->string p))))))

   (test-case
    "test-special-char"

    (let ([xml_hash (xml-file-to-hash special2_xml_file '(("sst.si.t" . v)))])
      
      (check-equal? (hash-ref xml_hash "sst.si.t") '("<test>" "<foo> " " <baz>" "< bar>" "< fro >"
                                                     "<bas >" "<maybe" "<< not >>" "show>"))
      ))

  ))

(run-tests test-special)
