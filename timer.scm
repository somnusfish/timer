#lang scheme
(require scheme/gui/base)
(define frame (new frame%
                   [label "timer"]
                   [width 200]
                   [height 100]
                   ))
(define (form inum)
  (if (> (string-length (number->string inum)) 2)
      #f
      (string-append  (make-string 
                       (- 2 (string-length (number->string inum))) 
                       #\0 )
                      (number->string inum))))
(define (chstr inum)
  (if (> inum 60) 
      (string-append (chstr (floor (/ inum 60)))
                     (string-append ":"
                                    (form (remainder inum 60))))
  (number->string inum)))

;(chstr 3600)
(form 6)
#|(define my-canvas%
  (class canvas% 
    (define/override (on-char event)
      (let ([keycode (send event get-key-release-code)])
        (case keycode
          ('up
           (set! cb  (gen-cb (mv-up cb))))
          ('down
           (set! cb (gen-cb (mv-down cb))))
          ('left
           (set! cb (gen-cb (mv-left cb))))
          ('right
           (set! cb (gen-cb (mv-right cb))))
          ('#\s
           (set! cb (gen-cb (gen-cb cb))))
          ('#\r
           (set! cb (make-chess-board)))
          (else #f))
        ;(set! cb  (mv-up (gen-cb cb)))
        (set! text (change-to-str cb))
        (if (win? cb)
            (set! text (string-append text "You Win!"))
            #f)
        (if (fail? cb)
            (set! text (string-append text "Sorry For You loss!"))
            #f)
        (send this refresh-now)
        (send this on-paint))
      )
    (super-new)))|#

(send frame show #t)