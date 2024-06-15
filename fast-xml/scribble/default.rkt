#lang racket

(require racket/runtime-path
         "../main.rkt")

(define-runtime-path default_xml_file "default.xml")

(let ([xml_hash (xml-file-to-hash
                 "default.xml"
                 '(
                   ("list.child.attr" . a)
                   ))])

  (printf "list.child.attr: [~a]\n" (hash-ref xml_hash "list.child.attr"))
)
