#lang racket

(require rackunit/text-ui
         rackunit
         racket/runtime-path
         "../../main.rkt")

(define-runtime-path broken_xml_file "broken.xml")

(define test-xml
  (test-suite
   "test-broken"

   (test-case
    "test-broken"

    (check-exn
     exn:fail?
     (lambda ()
       (xml-file-to-hash broken_xml_file)))

    (check-exn
     exn:fail?
     (lambda ()
       (xml-port-to-hash (open-input-file broken_xml_file))))
    )

  ))

(run-tests test-xml)
