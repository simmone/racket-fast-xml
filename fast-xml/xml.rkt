#lang racket

(provide (contract-out
          [struct XML
                  (
                   (status (or/c
                            'START
                            'KEY_START
                            'KEY-READING
                            'KEY_END
                            ))
                   (defs pair?)
                   (chars (listof char?))
                   (data_hash hash?)
                   )
                  ]
          ))

(struct XML
        (
         (status #:mutable)
         (defs #:mutable)
         (keys #:mutable)
         (chars #:mutable)
         (data_hash #:mutable)
         )
        #:transparent
        )
