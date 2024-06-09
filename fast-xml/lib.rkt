#lang racket

(provide (contract-out
          [defs-to-hash (-> (listof (cons/c string? (or/c 'v 'a))) (values hash? hash?))]
          [STATUS? (-> symbol? boolean?)]
          ))

(define (STATUS? status)
  (if (not (memq status
                 '(
                   TRAVERSE_START
                   KEY_WAITING
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
                   TRAVERSE_END
                   )))
      #f
      #t))

(define (defs-to-hash def_list)
  (let ([def_hash (make-hash)]
        [attr_hash (make-hash)])
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
                
                (when (eq? type 'a)
                  (let* ([node (string-join (reverse last_keys) ".")]
                         [default_hash (hash-ref attr_hash node (make-hash))])
                    (hash-set! default_hash key #f)
                    (hash-set! attr_hash node default_hash)))

                (loop-items (cdr items) keys))))
          )
        (loop-def (cdr defs))))
    (values def_hash attr_hash)))
