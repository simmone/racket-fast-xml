#lang racket

(require racket/runtime-path
         "../main.rkt")

(define-runtime-path empty_xml_file "empty.xml")

(let ([xml_hash (xml-file-to-hash
                 empty_xml_file
                 '(
                   ("empty" . v)
                   ("empty.attr1" . a)
                   ("empty.attr2" . a))
                )])

  (printf "xml hash has ~a keys.\n" (hash-count xml_hash))

  (printf "empty: ~a\n" (hash-ref xml_hash "empty"))

  (printf "empty.attr1: ~a\n" (hash-ref xml_hash "empty.attr1"))

  (printf "empty.attr2: ~a\n" (hash-ref xml_hash "empty.attr2")))
