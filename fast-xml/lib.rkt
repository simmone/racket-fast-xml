#lang racket

(provide (contract-out
          [defs-to-list (-> (listof string?) list?)]
          ))

(define (defs-to-list def_list)
  (let loop-def ([defs def_list]
                 [result_list '()])
    (if (not (null? defs))
        (loop-def
         (cdr defs)
         (cons
          (let ([def_items (reverse (regexp-split #rx"\\." (car defs)))])
            (let loop-items ([items (cdr def_items)]
                             [result_pair (car def_items)])
              (if (not (null? items))
                  (loop-items (cdr items) (cons (car items) result_pair))
                  result_pair)))
          result_list))
        (reverse result_list))))
          

