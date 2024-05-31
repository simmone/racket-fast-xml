#lang racket

(provide (contract-out
          [defs-to-hash (-> (listof string?) hash?)]
          [STATUS? (-> symbol? boolean?)]
          ))

(define (STATUS? status)
  (if (not (memq status
                 '(
                   KEY_START
                   KEY_READING
                   ATTR_KEY_WAITING
                   ATTR_KEY_READING
                   ATTR_VALUE_WAITING
                   ATTR_VALUE_READING
                   KEY_END
                   )))
      #f
      #t))

(define (defs-to-hash def_list)
  (let ([def_hash (make-hash)])
    (let loop-def ([defs def_list])
      (when (not (null? defs))
        (let ([def_items (regexp-split #rx"\\." (car defs))])
          (let loop-items ([items def_items]
                           [last_keys '()])
            (when (not (null? items))
              (let ([keys (cons (car items) last_keys)])
                (if (= (length items) 1)
                    (hash-set! def_hash (string-join (reverse keys) ".") 'v)
                    (hash-set! def_hash (string-join (reverse keys) ".") 'k))
                (loop-items (cdr items) keys)))))
        (loop-def (cdr defs))))
    def_hash))        
