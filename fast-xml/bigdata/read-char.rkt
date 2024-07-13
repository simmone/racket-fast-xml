#lang racket

(with-input-from-file "data.xml"
  (lambda ()
    (let loop ([ch (read-char)]
               [count 0])
      (if (not (eof-object? ch))
          (begin
            (when (= (modulo count 100000) 0)
              (printf "~a\n" count))
            (loop (read-char) (add1 count)))
          (printf "~a\n" count)))))
