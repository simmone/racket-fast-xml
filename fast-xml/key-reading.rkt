#lang racket

(require "xml.rkt")

(provide (contract-out
          [key-reading (-> char? XML? void?)]
          ))

(define (key-reading ch xml)
  (let ([key (list->string (reverse (XML-chars xml)))])
    (if (string=? value (caar defs))
        (if (pair? (cdr defs))
                        (loop (read-char) defs 'KEY_START (cons value keys) '())
                        (loop (read-char) defs 'VALUE (cons value keys) '()))
                    (loop (read-char) defs'KEY_START keys values)))

                (if (string=? value (caar defs))
                    (if (pair? (cdr defs))
                        (loop (read-char) defs 'KEY_START (cons value keys) '())
                        (loop (read-char) defs 'VALUE (cons value keys) '()))
                    (loop (read-char) defs'KEY_START keys values)))

