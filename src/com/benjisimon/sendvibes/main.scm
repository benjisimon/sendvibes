;;
;; Our main entry point to SendVibes
;;

(require 'android-defs)

(define (resource path)
  (let loop ((path path) (obj R))
    (cond ((null? path) obj)
          (else
           (loop (cdr path) (static-field obj (car path)))))))

(activity
 main
 ((on-create-options-menu (menu :: android.view.Menu))
  (let ((inflator ((this):get-menu-inflater)))
    (inflator:inflate (static-field (static-field R 'menu) 'main) menu)
    #t))
                         
 (on-create-view 
;  (as integer (resource '(layout main)))))
  (static-field (static-field R 'layout) 'main)))
                 
