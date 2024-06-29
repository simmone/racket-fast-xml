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
              "basic1.attr"
              "basic1.value"
              ))])

      (check-equal? (hash-count xml_hash) 4)

      (check-equal? (hash-ref xml_hash "basic11.attr1") "<2>")

      (check-equal? (hash-ref xml_hash "basic11.value1") "<1>")
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

    (let ([xml_hash (xml-file-to-hash special2_xml_file '("sst.si.t"))])
      
      (check-equal? (hash-ref xml_hash "sst1.si1.t1") "<test>")
      (check-equal? (hash-ref xml_hash "sst1.si2.t1") "<foo> ")
      (check-equal? (hash-ref xml_hash "sst1.si3.t1") " <baz>")
      (check-equal? (hash-ref xml_hash "sst1.si4.t1") "< bar>")
      (check-equal? (hash-ref xml_hash "sst1.si5.t1") "< fro >")
      (check-equal? (hash-ref xml_hash "sst1.si6.t1") "<bas >")
      (check-equal? (hash-ref xml_hash "sst1.si7.t1") "<maybe")
      (check-equal? (hash-ref xml_hash "sst1.si8.t1") "<< not >>")
      (check-equal? (hash-ref xml_hash "sst1.si9.t1") "show>")
      ))

  ))

(run-tests test-special)
