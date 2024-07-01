#lang racket

(require racket/runtime-path
         "../main.rkt")

(define-runtime-path empty_xml_file "empty.xml")

(let ([xml_hash (xml-file-to-hash
                 empty_xml_file
                 '(
                   "empty"
                   "empty.attr1"
                   "empty.attr2"
                   )
                )])

  (printf "xml hash has ~a keys.\n" (hash-count xml_hash))

  (printf "empty's count: ~a\n" (hash-ref xml_hash "empty's count"))

  (printf "empty's value: ~a\n" (hash-ref xml_hash "empty1"))

  (printf "empty.attr1: ~a\n" (hash-ref xml_hash "empty1.attr11"))

  (printf "empty.attr2: ~a\n" (hash-ref xml_hash "empty1.attr21")))
