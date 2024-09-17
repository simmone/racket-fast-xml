#lang racket

;; numeric character reference and character entity reference's define from WIKI.
;;
;; In HTML and XML, a numeric character reference refers to a character by its Universal Character Set/Unicode code point, and uses the format:
;; 
;; &#xhhhh;
;; or
;; 
;; &#nnnn;
;; where the x must be lowercase in XML documents, hhhh is the code point in hexadecimal form, and nnnn is the code point in decimal form. 
;; The hhhh (or nnnn) may be any number of hexadecimal (or decimal) digits and may include leading zeros.
;; The hhhh for hexadecimal digits may mix uppercase and lowercase letters, though uppercase is the usual style.
;; However the XML and HTML standards restrict the usable code points to a set of valid values, which is a subset of UCS/Unicode code point values,
;; that excludes all code points assigned to non-characters or to surrogates, and most code points assigned to C0 and C1 controls (with the exception of line separators and tabulations treated as white spaces).
;; 
;; In contrast, a character entity reference refers to a sequence of one or more characters by the name of an entity which has the desired characters as its replacement text. 
;; The entity must either be predefined (built into the markup language), or otherwise explicitly declared in a Document Type Definition (DTD) (see [a]). The format is the same as for any entity reference:
;; 
;; &name;
;; where name is the case-sensitive name of the entity. The semicolon is usually required in the character entity reference, unless marked otherwise in the table below (see [b]).
;; 
;; Standard public entity sets for characters
;; XML
;; XML specifies five predefined entities needed to support every printable ASCII character: &amp;, &lt;, &gt;, &apos;, and &quot;. 
;; The trailing semicolon is mandatory in XML (and XHTML) for these five entities (even if HTML or SGML allows omitting it for some of them, according to their DTD).
;; 

(provide (contract-out
          [from-entity-chars (-> string? string?)]
          [to-entity-chars (-> (or/c string? symbol?) string?)]
          ))

(define MAX_HEX_LENGTH 5)
(define MAX_DEC_LENGTH 6) 

(define (from-entity-chars str)

;  (printf "str:[~a]\n" str)

  (let loop ([chars (string->list str)]
             [state 'SEARCH]
             [cache_char_list '()]
             [result_char_list '()])

;    (printf "state:[~a], cache:[~a], result:[~a]\n" state cache_char_list result_char_list)

    (if (or
         (eq? state 'CHAR_PATTERN_END)
         (eq? state 'DEC_PATTERN_END)
         (eq? state 'HEX_PATTERN_END)
         (not (null? chars)))
        (cond
         [(eq? state 'CHAR_PATTERN_END)
          (let ([cache_str (string-downcase (list->string (reverse cache_char_list)))])
            (loop
             chars
             'SEARCH
             '()
             (cond
              [(string=? cache_str "&amp;")
               (cons #\& result_char_list)]
              [(string=? cache_str "&gt;")
               (cons #\> result_char_list)]
              [(string=? cache_str "&lt;")
               (cons #\< result_char_list)]
              [(string=? cache_str "&apos;")
               (cons #\' result_char_list)]
              [(string=? cache_str "&quot;")
               (cons #\" result_char_list)]
              [else
               `(,@cache_char_list ,@result_char_list)])))]
         [(eq? state 'HEX_PATTERN_END)
          (let* ([cache_str (list->string (reverse cache_char_list))]
                 [hex_str (substring cache_str 3 (sub1 (string-length cache_str)))]
                 [num (string->number hex_str 16)])
            (if (and (<= (string-length hex_str) MAX_HEX_LENGTH) num)
                (loop chars 'SEARCH '() (cons (integer->char num) result_char_list))
                (loop chars 'SEARCH '() `(,@cache_char_list ,@result_char_list))))]
         [(eq? state 'DEC_PATTERN_END)
          (let* ([cache_str (list->string (reverse cache_char_list))]
                 [hex_str (substring cache_str 2 (sub1 (string-length cache_str)))]
                 [num (string->number hex_str)])
            (if (and (<= (string-length hex_str) MAX_DEC_LENGTH) num)
                (loop chars 'SEARCH '() (cons (integer->char num) result_char_list))
                (loop chars 'SEARCH '() `(,@cache_char_list ,@result_char_list))))]
         [(char=? (car chars) #\&)
          (loop (cdr chars) 'PATTERN_START (cons (car chars) '()) `(,@cache_char_list ,@result_char_list))]
         [(eq? state 'PATTERN_START)
          (if (char=? (car chars) #\#)
              (loop (cdr chars) 'NUM_PATTERN_START (cons (car chars) cache_char_list) result_char_list)
              (loop (cdr chars) 'CHAR_PATTERN_START (cons (car chars) cache_char_list) result_char_list))]
         [(eq? state 'CHAR_PATTERN_START)
          (if (char=? (car chars) #\;)
              (loop (cdr chars) 'CHAR_PATTERN_END (cons (car chars) cache_char_list) result_char_list)
              (loop (cdr chars) state (cons (car chars) cache_char_list) result_char_list))]
         [(eq? state 'NUM_PATTERN_START)
          (if (char=? (car chars) #\x)
              (loop (cdr chars) 'HEX_PATTERN_START (cons (car chars) cache_char_list) result_char_list)
              (loop (cdr chars) 'DEC_PATTERN_START (cons (car chars) cache_char_list) result_char_list))]
         [(eq? state 'HEX_PATTERN_START)
          (cond
           [(char=? (car chars) #\;)
            (loop (cdr chars) 'HEX_PATTERN_END (cons (car chars) cache_char_list) result_char_list)]
           [else
            (loop (cdr chars) state (cons (car chars) cache_char_list) result_char_list)])]
         [(eq? state 'DEC_PATTERN_START)
          (cond
           [(char=? (car chars) #\;)
            (loop (cdr chars) 'DEC_PATTERN_END (cons (car chars) cache_char_list) result_char_list)]
           [else
            (loop (cdr chars) state (cons (car chars) cache_char_list) result_char_list)])]
         [else
          (loop (cdr chars) state '() (cons (car chars) result_char_list))])
        (list->string (reverse `(,@cache_char_list ,@result_char_list))))))

(define (to-entity-chars str)
  (regexp-replaces
   (if (symbol? str) (symbol->string str) str)
   '(
     [#rx"\\&" "\\&amp;"]
     [#rx">" "\\&gt;"]
     [#rx"<" "\\&lt;"]
     [#rx"\"" "\\&quot;"]
     [#rx"'" "\\&apos;"]
     )))
