;;
;; our activity for configuring our sendvibes app
;;
(require 'android-defs)

(define-alias R$layout com.benjisimon.sendvibes.R$layout)
(define-alias Context  android.content.Context)
(define-alias ActionBar  android.app.ActionBar)


(activity
 settings

 (on-create-view

  (let ((bar ((this):get-action-bar)))
    (ActionBar:set-display-home-as-up-enabled bar #t))

  R$layout:settings)

)
