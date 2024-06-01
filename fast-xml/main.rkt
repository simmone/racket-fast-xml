#lang racket

(provide (contract-out
          [xml-file-to-hash (-> path-string? (listof string?) hash?)]
          [xml-port-to-hash (-> input-port? (listof string?) hash?)]
          [lists-to-xml (-> list? string?)]
          ))

(require "lib.rkt"
         "status/key-start.rkt"
         "status/key-reading.rkt"
         "status/key-end.rkt"
         "status/key-value-reading.rkt"
         "status/attr-key-waiting.rkt"
         "status/attr-key-reading.rkt"
         "status/attr-value-waiting.rkt"
         "status/attr-value-reading.rkt"
         )

(define (xml-file-to-hash xml_file def_list)
  (with-input-from-file xml_file
    (lambda ()
      (xml-port-to-hash (current-input-port) def_list))))

(define (xml-port-to-hash xml_port def_list)
  (printf "start\n")
  (let ([xml_hash (make-hash)]
        [def_hash (defs-to-hash def_list)])
    (let loop ([status 'KEY_START]
               [ch (read-char xml_port)]
               [keys '()]
               [chars '()]
               [waiting_key #f])

      (printf "~a,~a,~a,~a,~a\n" status ch keys chars waiting_key)

      (when (not (eof-object? ch))

        (define-values
            (next_status reserve_key? reserve_char?)
          (cond
          [(eq? status 'KEY_START) (key-start ch)]
          [(eq? status 'KEY_READING) (key-reading ch)]
          [(eq? status 'KEY_VALUE_READING) (key-value-reading ch)]
          [(eq? status 'KEY_END) (key-end ch)]
          [(eq? status 'ATTR_KEY_WAITING) (attr-key-waiting ch)]
          [(eq? status 'ATTR_KEY_READING) (attr-key-reading ch)]
          [(eq? status 'ATTR_VALUE_WAITING) (attr-value-waiting ch)]
          [(eq? status 'ATTR_VALUE_READING) (attr-value-reading ch)]
          [(eq? status 'ATTR_KEY_END)
           (let ([key (format "~a.~a"
                              (string-join (reverse keys) ".")
                              (list->string (reverse (cdr chars))))])
             (printf "key:~a\n" key)
             (if (and (hash-has-key? def_hash key) (eq? (hash-ref def_hash key) 'v))
                 (begin
                   (set! waiting_key key)
                   (values 'ATTR_VALUE_READING #t #f))
                 (values 'ATTR_KEY_WAITING #f #f)))]
          [(eq? status 'ATTR_VALUE_END)
           (when waiting_key
             (hash-set! xml_hash waiting_key `(,@(hash-ref xml_hash waiting_key '()) ,(list->string (reverse chars))))
             (set! waiting_key  #f))
           (values 'ATTR_KEY_WAITING #f #f)]))

        (loop
         next_status
         (read-char xml_port)
         (if reserve_key? (cons (list->string (reverse chars)) keys) keys)
         (if reserve_char? (cons ch chars) '())
         waiting_key))
    xml_hash)))

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


