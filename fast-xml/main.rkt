#lang racket

(provide (contract-out
          [xml-file-to-hash (-> path-string? pair? hash?)]
          [xml-port-to-hash (-> input-port? pair? hash?)]
          [lists-to-xml (-> list? string?)]
          ))

(require "lib.rkt")

(define (xml-file-to-hash xml_file def_pairs)
  (with-input-from-file xml_file
    (lambda ()
      (xml-port-to-hash (current-input-port) def_pairs))))

; 'KEY_START: waiting to encounter '<'
; 'KEY_READING: next chars will be read as key;
; 'KEY_VALUE_READING: reading key value

(define (xml-port-to-hash xml_port def_strs)
  (let ([xml_hash (make-hash)])
    (let loop ([status 'KEY_START]
               [ch (read-char xml_port)]
               [defs (car (defs-to-list def_strs))]
               [keys '()]
               [chars '()])
      (printf "~a,~a,~a,~a,~a\n" status ch defs keys chars)
      (when (not (eof-object? ch))
        (cond
         [(eq? status 'KEY_START)
          (if (char=? ch #\<)
              (loop 'KEY_READING (read-char xml_port) defs keys chars)
              (loop status (read-char xml_port) defs keys chars))]
         [(eq? status 'KEY_READING)
          (if (char=? ch #\>)
            (let ([key (list->string (reverse chars))])
              (if (string=? key (if (string? defs) defs (car defs)))
                  (cond
                   [(string? defs)
                    (loop 'KEY_VALUE_READING (read-char xml_port) defs (cons key keys) '())]
                   [else
                    (loop 'KEY_START (read-char xml_port) (cdr defs) (cons key keys) '())]
                   )
                  (loop 'KEY_START (read-char xml_port) defs keys '())))
            (loop status (read-char xml_port) defs keys (cons ch chars)))]
         [(eq? status 'KEY_VALUE_READING)
          (if (char=? ch #\<)
              (begin
                (hash-set! xml_hash (string-join (reverse keys) ".") (list->string (reverse chars)))
                (loop 'KEY_START (read-char xml_port) defs keys '()))
              (loop status (read-char xml_port) defs keys (cons ch chars)))]
         )))
    xml_hash))

(define (lists-to-xml xml_list)
  (add-xml-head (lists-to-xml_content xml_list)))

(define (lists-to-compact_xml xml_list)
  (add-xml-head (regexp-replace* #rx">\n *<" (lists-to-xml_content xml_list) "><")))


(define (add-xml-head xml_str)
  (format "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>\n\n~a" xml_str))

(define (lists-to-xml_content xml_list)
  (call-with-output-string
   (lambda (xml_port)
     (let loop ([out_p xml_port]
                [nodes xml_list]
                [prefix_spaces ""])
       (when (and (not (null? nodes)) ((or/c string? symbol?) (car nodes)))
         (let* ([properties (filter (cons/c (or/c string? symbol?) (or/c string? symbol?)) (cdr nodes))]
                [children (filter-not (cons/c (or/c string? symbol?) (or/c string? symbol?)) (cdr nodes))]
                [value_children (filter (or/c string? symbol?) children)]
                [list_children (filter list? children)])
           (fprintf out_p
                    "~a<~a~a"
                    prefix_spaces
                    (car nodes)
                    (call-with-output-string
                     (lambda (property_port)
                       (let loop-properties ([properties (filter (cons/c (or/c string? symbol?) (or/c string? symbol?)) (cdr nodes))])
                         (when (not (null? properties))
                           (fprintf property_port" ~a=\"~a\"" (caar properties) (cdar properties))
                           (loop-properties (cdr properties)))))))

           (if (null? children)
               (fprintf out_p "/>\n")
               (begin
                 (fprintf out_p ">")
                 (if (not (null? value_children))
                     (fprintf out_p "~a</~a>\n" (apply string-append (map (lambda (v) (format "~a" v)) value_children)) (car nodes))
                     (fprintf out_p "\n~a~a</~a>\n"
                              (call-with-output-string
                               (lambda (children_port)
                                 (let loop-children ([children list_children])
                                   (when (not (null? children))
                                     (loop children_port (car children) (string-append prefix_spaces "  "))
                                     (loop-children (cdr children))))))
                              prefix_spaces
                              (car nodes)))))))))))


