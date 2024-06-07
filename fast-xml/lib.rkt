#lang racket

(provide (contract-out
          [defs-to-hash (-> (listof (cons/c string? (or/c 'v 'a))) hash?)]
          [STATUS? (-> symbol? boolean?)]
          ))

(define (STATUS? status)
  (if (not (memq status
                 '(
                   TRAVERSE_START
                   KEY_START
                   KEY_READING
                   KEY_READING_END
                   ATTR_KEY_WAITING
                   ATTR_KEY_READING
                   ATTR_KEY_END
                   ATTR_VALUE_WAITING
                   ATTR_VALUE_READING
                   ATTR_VALUE_END
                   KEY_END
                   KEY_VALUE_READING
                   KEY_VALUE_END
                   KEY_PAIR_END
                   KEY_PAIR_END_NO_VALUE
                   TRAVERSE_END
                   )))
      #f
      #t))

(define (defs-to-hash def_list)
  (let ([def_hash (make-hash)])
    (let loop-def ([defs def_list])
      (when (not (null? defs))

        (hash-set! def_hash (caar defs) (cdar defs))

        (let ([def_items (regexp-split #rx"\\." (caar defs))])
          (let loop-items ([items def_items]
                           [last_keys '()])
            (when (not (null? items))
              (let* ([keys (cons (car items) last_keys)]
                     [key (string-join (reverse keys) ".")]
                     [type (hash-ref def_hash key 'k)])

                (hash-set! def_hash key type)

                (loop-items (cdr items) keys)))))
        (loop-def (cdr defs))))
    def_hash))
