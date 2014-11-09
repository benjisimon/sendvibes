;;
;; experimewnt away
;;

(define config
  '(let* ((short 300)
          (long  600)
          (zero  0)
          (S     (list short short))
          (L     (list long  short))
          (_     (list zero  short))
          (wife  "ABC")
          (bro   "XYZ"))
     `(("Find Me" ,wife ,S ,S ,S)
       ("Love You" ,wife ,L ,S ,L)
       ("Left" ,bro ,S ,S ,S)
       ("Right" ,bro ,S ,L ,L)
       ("Stop" ,bro ,L ,L))))
              
(let ((c (expand-config config)))
  (map entry-vibe-pattern c))
      
