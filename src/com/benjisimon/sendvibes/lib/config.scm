;;
;; sendvibes's configuration is an Scheme expressions that
;; when envaluated should return the following shaped
;; list:
;;
;; ((button-name to-address vibe-spec ...)
;;  ...)
;;
;; where vibe-spec is either a sequence of numbers
;; in the form:
;;    vibrate pause vibrate pause ...
;; or is a sequence of lists:
;;  ((vibrate pause) ...)
;;
;;
(module-name (lib config))
(module-export valid-config? expand-config entry-button entry-to entry-vibe-pattern)

(require 'srfi-1)

(define (valid-config? config)
  (call/cc (lambda (k)
             (with-exception-handler (lambda (ex)
                                       (k #f))
                                     (lambda ()
                                       (expand-config config)
                                       #t)))))
(define (expand-config config)
  (eval config))

(define (entry-button entry)
  (first entry))

(define (entry-to entry)
  (second entry))
    
;;
;; Our spec allow for the vibrate pattern to be either a list of
;; (vibrate pause) lists, or just a sequence of vibrate pause numbers.
;;
;; Android expects the first value to be a pause - which is so frequently
;; 0, I'm just setting it to zero
;;
(define (entry-vibe-pattern entry)
  (let ((pattern (cddr entry)))
    (cons 0
          (apply append
                 (map (lambda (x)
                        (if (list? x) x (list x)))
                      pattern)))))
  
