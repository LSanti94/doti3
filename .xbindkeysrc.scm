;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Start of xbindkeys configuration ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; This configuration is guile based.
;;   http://www.gnu.org/software/guile/guile.html
;;
;; This configuration allow combo keys.
;; ie Control+z Control+e -> xterm
;;    Control+z z         -> rxvt
;;    Control+z Control+g -> quit second mode
;;
;; It also allow to add or remove a key on the fly!

(xbindkey '(control shift q) "xbindkeys_show")

(xbindkey '(Menu) "xdotool mousemove 640 800; xdotool mousemove 960 0")

(xbindkey '(control "b:3") "pn mclick")

(xbindkey '(release "m:0x3" "b:1" ) "/usr/bin/xte 'mouseclick 2';pn mclick;")

(xbindkey '("m:0x3" "b:5") "xdotool click --clearmodifiers --repeat 5 --delay 0 5")

(xbindkey '("m:0x3" "b:4") "xdotool click --clearmodifiers --repeat 5 --delay 0 4")

(xbindkey '(release "m:0x3" "Prior") "xdotool key --clearmodifiers Home")
(xbindkey '(release "m:0x3" "Next")  "xdotool key --clearmodifiers End")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; End of xbindkeys configuration ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

