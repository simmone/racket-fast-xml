#lang racket

(require racket/runtime-path
         "../main.rkt")

(define-runtime-path default_xml_file "default.xml")

(let ([xml_hash (xml-file-to-hash
                 "default.xml"
                 '(
                   "list.child.attr"
                   ))])

  (printf "list1.child1.attr1: [~a]\n" (hash-ref xml_hash "list1.child1.attr1"))

  (printf "list1.child1.attr2: [~a]\n" (hash-ref xml_hash "list1.child1.attr2" ""))
)
