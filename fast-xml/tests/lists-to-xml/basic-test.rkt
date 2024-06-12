#lang racket

(require rackunit/text-ui
         rackunit
         racket/runtime-path
         "../../main.rkt")

(define-runtime-path empty_xml_file "empty.xml")
(define-runtime-path one_node_xml_file "one_node.xml")
(define-runtime-path property_xml_file "property.xml")
(define-runtime-path content_xml_file "content.xml")
(define-runtime-path symbol_content_xml_file "symbol_content.xml")
(define-runtime-path children_xml_file "children.xml")
(define-runtime-path children_compact_xml_file "children_compact.xml")
(define-runtime-path no_header_children_xml_file "no_header_children.xml")
(define-runtime-path no_header_children_compact_xml_file "no_header_children_compact.xml")
(define-runtime-path three_xml_file "three.xml")
(define-runtime-path three_compact_xml_file "three_compact.xml")
(define-runtime-path parallel_xml_file "parallel.xml")
(define-runtime-path parallel_compact_xml_file "parallel_compact.xml")
(define-runtime-path more_complex_xml_file "more_complex.xml")
(define-runtime-path more_complex_compact_xml_file "more_complex_compact.xml")

(define test-xml
  (test-suite
   "test-lists-to-xml"

   (test-case
    "test-empty-xml"

    (let ([xml '()])
      (call-with-input-file empty_xml_file
        (lambda (p)
          (check-equal? (lists-to-xml xml)
                        (port->string p))))))

   (test-case
    "test-one-node-xml"

    (let ([xml '("H1")])
      (call-with-input-file one_node_xml_file
        (lambda (p)
          (check-equal? (lists-to-xml xml)
                        (port->string p))))))

   (test-case
    "test-property-xml"

    (let ([xml '("H1" ("color" . "red"))])
      (call-with-input-file property_xml_file
        (lambda (p)
          (check-equal? (lists-to-xml xml)
                        (port->string p))))))

   (test-case
    "test-content-xml"

    (let ([xml '("H1" ("color" . "red") "Hello XML")])
      (call-with-input-file content_xml_file
        (lambda (p)
          (check-equal? (lists-to-xml xml)
                        (port->string p))))))

   (test-case
    "test-symbol-content-xml"

    (let ([xml '(H1 (color . red) "Hello XML")])
      (call-with-input-file content_xml_file
        (lambda (p)
          (check-equal? (lists-to-xml xml)
                        (port->string p))))))

   (test-case
    "test-children-xml"

    (let ([xml '("H1" ("color" . "red") ("height" . "5") ("H2" ("color" . "black") "Simple XML"))])
      (call-with-input-file children_xml_file
        (lambda (p)
          (check-equal? (lists-to-xml xml)
                        (port->string p))))

      (call-with-input-file children_compact_xml_file
        (lambda (p)
          (check-equal? (lists-to-compact_xml xml)
                        (port->string p))))))

   (test-case
    "test-three-xml"

    (let ([xml '("H1" ("color" . "red") (height . "5") ("H2" ("color" . "black") ("H3" ("color" . "pink") "Simple XML")))])
      (call-with-input-file three_xml_file
        (lambda (p)
          (check-equal? (lists-to-xml xml)
                        (port->string p))))

      (call-with-input-file three_compact_xml_file
        (lambda (p)
          (check-equal? (lists-to-compact_xml xml)
                        (port->string p))))))

   (test-case
    "test-parallel-xml"

    (let ([xml '("H1" ("color" . "red") ("height" . "5") ("H2" ("color" . "black") "Simple XML") ("H3" ("color" . "pink") Haha))])
      (call-with-input-file parallel_xml_file
        (lambda (p)
          (check-equal? (lists-to-xml xml)
                        (port->string p))))

      (call-with-input-file parallel_compact_xml_file
        (lambda (p)
          (check-equal? (lists-to-compact_xml xml)
                        (port->string p))))))

   (test-case
    "test-more_complex-xml"

     (let ([xml '("H1" ("color" . "red") ("height" . "5")
                  ("H2" ("color" . "black") ("H3" ("color" . "pink") "Simple XML"))
                  ("H2" ("color" . "red") ("H3" ("color" . "yellow") "Peace"))
                  )])
      (call-with-input-file more_complex_xml_file
        (lambda (p)
          (check-equal? (lists-to-xml xml)
                        (port->string p))))

      (call-with-input-file more_complex_compact_xml_file
        (lambda (p)
          (check-equal? (lists-to-compact_xml xml)
                        (port->string p))))))

   (test-case
    "test-no-header"

    (let ([xml '("H1" ("color" . "red") ("height" . "5") ("H2" ("color" . "black") "Simple XML"))])
      (call-with-input-file no_header_children_xml_file
        (lambda (p)
          (check-equal? (lists-to-xml_content xml)
                        (port->string p))))

      (call-with-input-file no_header_children_compact_xml_file
        (lambda (p)
          (check-equal? (regexp-replace* #rx">\n *<" (lists-to-xml_content xml) "><")
                        (port->string p))))))
  ))

(run-tests test-xml)
