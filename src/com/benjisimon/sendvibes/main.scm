;;
;; Our main entry point to SendVibes
;;

(require 'android-defs)
(require <com.benjisimon.sendvibes.lib.config>)

(define-alias Vibrator android.os.Vibrator)


(define (logi . entries)
  (for-each (lambda (e) 
              (android.util.Log:i "com.benjisimon.sendvibes" e))
            entries))

(activity
 main

 ((on-create-options-menu (menu :: android.view.Menu))
  (let ((inflator ((this):get-menu-inflater)))
    (inflator:inflate R$menu:main menu)
    #t))

 ((on-vibe-click (view :: android.view.View))
  (let ((vibr ((this):getSystemService android.content.Context:VIBRATOR_SERVICE)))
    (Vibrator:vibrate vibr 300)))


 (on-create-view R$layout:main))
