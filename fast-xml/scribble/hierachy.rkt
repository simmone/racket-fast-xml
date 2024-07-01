#lang racket

(require racket/runtime-path
         "../main.rkt")

(define-runtime-path hierachy_xml_file "hierachy.xml")

(let ([xml_hash (xml-file-to-hash
                 "hierachy.xml"
                 '(
                   "level1.level2.level3.attr"
                   "level1.level2.level3.level4"
                   ))])

  (printf "level1.level2.level3.attr: [~a]\n" (hash-ref xml_hash "level11.level21.level31.attr1"))

  (printf "level1.level2.level3.level4: [~a]\n" (hash-ref xml_hash "level11.level21.level31.level41"))
)
