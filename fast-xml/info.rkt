#lang info

(define scribblings
  '(("scribble/fast-xml.scrbl" (multi-page) (tool 100))))

(define compile-omit-paths '("tests"))
(define test-omit-paths '("lib.rkt" "status" "main.rkt" "scribble" "info.rkt"))
