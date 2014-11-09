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

 (on-create-view
  (define (vibrate pattern)
    (let ((vibr ((this):getSystemService android.content.Context:VIBRATOR_SERVICE)))
      (Vibrator:vibrate vibr (apply long[] pattern) -1)))

  (define (get-config)
    `(("Click Me" "xxx" (400 300) (800 300))
      ("And Me!"  "xxx" (900 200) (300 200) (900 200))))

  (let ((config (get-config))
        (box    (LinearLayout (this)
                              orientation: LinearLayout:VERTICAL)))
    (if config
      (for-each (lambda (e)
                  (LinearLayout:add-view box 
                                         (Button (this)
                                                 text: (as string (entry-button e))
                                                 on-click-listener: 
                                                 (lambda (v)
                                                   (vibrate (entry-vibe-pattern e))))))
                config)
      (LinearLayout:add-view box
                             (TextView (this)
                                       text: "Edit the configuration to see some buttons here.")))
    box))
 )
