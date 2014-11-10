;;
;; Our main entry point to SendVibes
;;

(require 'android-defs)
(require <com.benjisimon.sendvibes.lib.config>)
(require <com.benjisimon.sendvibes.settings>)

(define-alias Vibrator android.os.Vibrator)
(define-alias MenuItem  android.view.MenuItem)
(define-alias Intent  android.content.Intent)


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

 ((on-options-item-selected (item :: MenuItem))
  (let ((selected (MenuItem:getItemId item)))
    (cond ((equal? selected R$id:action_settings)
           (let ((intent (Intent (this) settings)))
             (Context:startActivity (this) intent)
             #t))
          (else #f))))

   

 (on-create-view
  (define (vibrate pattern)
    (let ((vibr ((this):getSystemService Context:VIBRATOR_SERVICE)))
      (Vibrator:vibrate vibr (apply long[] pattern) -1)))

  (define (empty? x)
    (equal? x ""))

  (let ((config (config-get (this)))
        (box    (LinearLayout (this)
                              orientation: LinearLayout:VERTICAL)))
    (if (empty? config)
      (LinearLayout:add-view box
                             (TextView (this)
                                       text: "Edit the configuration to see some buttons here."))
      (for-each (lambda (e)
                  (LinearLayout:add-view box 
                                         (Button (this)
                                                 text: (as string (entry-button e))
                                                 on-click-listener: 
                                                 (lambda (v)
                                                   (vibrate (entry-vibe-pattern e))))))
                config))
    box))
 )
