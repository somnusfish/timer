#lang scheme
(require scheme/gui/base)

(define clock 0)

(define (form inum)
  (if (> (string-length (number->string inum)) 2)
      #f
      (string-append  (make-string 
                       (- 2 (string-length (number->string inum))) 
                       #\0 )
                      (number->string inum))))
(define (chstr inum)
  (if (>= inum 60) 
      (string-append (chstr (floor (/ inum 60)))
                     (string-append ":"
                                    (form (remainder inum 60))))
      (number->string inum)))


(define text (chstr clock))

(define frame (new frame%
                   [label "timer"]
                   [width 200]
                   [height 100]
                   ))

(define timer 
  (new timer%
       [notify-callback (lambda () 
                          (set! clock (+ 1 clock))
                          (set! text (chstr clock))
                          (send my-canvas refresh-now)
             (send my-canvas on-paint))]
       [interval #f]
       [just-once? #f]))

(define my-canvas%
  (class canvas% 
    (define/override (on-char event)
      (let ([keycode (send event get-key-release-code)])
        (case keycode
          ('#\r
           (begin
             (send timer stop)
             (set! clock 0)
             (set! text (chstr clock))
             (send this refresh-now)
             (send this on-paint)
             ))
          ('#\return
           (send timer start 1000))
          ('#\space 
           (send timer stop))
          (else #f))
        )
      )
    (super-new)))

(define my-canvas
  (new my-canvas%
     [parent frame]
     [paint-callback
      (lambda (canvas dc)
        (send dc set-scale 3 3)
        (send dc set-text-foreground "blue")
        (send dc draw-text text 0 0 )
        )]))

(send frame show #t)
