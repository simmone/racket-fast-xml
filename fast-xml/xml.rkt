#lang racket

(provide (contract-out
          [struct XML
                  (
                   (status (or/c
                            'START
                            'KEY_START
                            'KEY-READING
                            'KEY_END
                            'KEY_VALUE
                            ))
                   (defs pair?)
                   (keys (listof string?)
                   (data_hash hash?)
                   )
                  ]
          ))

(struct XML
        (
         (status #:mutable)
         (defs #:mutable)
         (keys #:mutable)
         (data_hash #:mutable)
         )
        #:transparent
        )
