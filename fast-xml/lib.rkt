#lang racket

(provide (contract-out
          [defs-to-hash (-> (listof string?) hash?)]
          [from-special-chars (-> string? string?)]
          [to-special-chars (-> (or/c string? symbol?) string?)]
          [STATUS? (-> symbol? boolean?)]
          [from-keys-to-pure-key (-> (listof (cons/c string? natural?)) string?)]
          [from-keys-to-value-key (-> (listof (cons/c string? natural?)) string?)]
          [from-keys-to-count-key (-> (listof (cons/c string? natural?)) string?)]
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
                   KEY_VALUE_END_MAYBE
                   KEY_VALUE_END
                   KEY_PAIR_END
                   TRAVERSE_END
                   )))
      #f
      #t))

(define (from-special-chars str)
  (regexp-replaces
   str
   '(
     [#rx"&gt;" ">"]
     [#rx"&lt;" "<"]
     [#rx"&quot;" "\""]
     [#rx"&apos;" "'"]
     [#rx"&amp;" "\\&"]
     )))

(define (to-special-chars str)
  (regexp-replaces
   (if (symbol? str) (symbol->string str) str)
   '(
     [#rx"\\&" "\\&amp;"]
     [#rx">" "\\&gt;"]
     [#rx"<" "\\&lt;"]
     [#rx"\"" "\\&quot;"]
     [#rx"'" "\\&apos;"]
     )))

(define (defs-to-hash def_list)
  (let ([def_hash (make-hash)])
    (let loop-def ([defs def_list])
      (when (not (null? defs))
        (let ([def_items (regexp-split #rx"\\." (car defs))])
          (let loop-items ([items def_items]
                           [last_keys '()])
            (when (not (null? items))
              (let* ([keys (cons (car items) last_keys)]
                     [key (string-join (reverse keys) ".")]
                     [type (hash-ref def_hash key #f)])

                (if (string=? (car defs) key)
                    (if type
                        (cond
                         [(eq? type 'k)
                          (hash-set! def_hash key 'kv)]
                         [(eq? type 'v)
                          (hash-set! def_hash key 'v)])
                        (hash-set! def_hash key 'v))
                    (if type
                        (when (eq? type 'v)
                          (hash-set! def_hash key 'kv))
                        (hash-set! def_hash key 'k)))

                (loop-items (cdr items) keys))))
          )
        (loop-def (cdr defs))))
    def_hash))

(define (from-keys-to-value-key keys)
  (let ([_keys (map (lambda (k) (format "~a~a" (car k) (cdr k))) keys)])
    (if (> (length _keys) 1)
        (string-join (reverse _keys) ".")
        (car _keys))))

(define (from-keys-to-pure-key keys)
  (let ([_keys (map car keys)])
    (if (> (length _keys) 1)
        (string-join (reverse _keys) ".")
        (car _keys))))

(define (from-keys-to-count-key keys)
  (let loop ([_keys (reverse keys)]
             [result_str ""])
    (if (not (null? _keys))
        (loop
         (cdr _keys)
         (format "~a~a"
                 (if (string=? result_str "")
                     ""
                     (format "~a." result_str))
                 (if (= (length _keys) 1)
                     (caar _keys)
                     (format "~a~a" (caar _keys) (cdar _keys)))))
        result_str)))
