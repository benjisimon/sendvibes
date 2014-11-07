;;
;; Our main entry point to SendVibes
;;

(require 'android-defs)

(define (logi . entries)
  (for-each (lambda (e) 
              (android.util.Log:i "com.benjisimon.sendvibes" e))
            entries))

(define (resource type instance)
  (logi "from resource: " (static-field R type))
  (logi "going to fail: " (static-field (static-field R type) instance)))

(activity
 main

 ((on-create-options-menu (menu :: android.view.Menu))
  (let ((inflator ((this):get-menu-inflater)))
    (inflator:inflate (static-field (static-field R 'menu) 'main) menu)
    #t))
                         
 (on-create-view 
  (logi "from main: " (static-field R 'layout))
  (resource 'layout 'main)
  (static-field (static-field R 'layout) 'main)))
                 
