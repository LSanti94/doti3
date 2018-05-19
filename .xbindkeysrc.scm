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

;; use xbindkeys-config to get the correct key-configuration

;; Move pointer to position x,y
(xbindkey '(Menu) "xdotool mousemove 640 800; xdotool mousemove 960 0")

;; Ctrl+ Right Click should play sound
(xbindkey '(control "b:3") "pn mclick")

;; Shift+Click simulated middle click and plays a sound
(xbindkey '(release "m:0x3" "b:1" ) "/usr/bin/xte 'mouseclick 2';pn mclick;")

;; Shift+Wheel Up/Down should run fast scroll+sounds 
(xbindkey '("m:0x11" "b:5") "~/bini3/i3-mousewheel up")
(xbindkey '("m:0x11" "b:4") "~/bini3/i3-mousewheel down")

; (xbindkey '(release shift "b:5") "pn mclick;xte 'mousedown 5' 'mouseclick 5' 'mouseup 5'")
; (xbindkey '(shift "b:4") "repeat 3|xte 'mouseclick 4'")

;; Shift + PageDown/Pageup should result in Home/End
; (xbindkey '(release "m:0x3" "Prior") "xdotool key --clearmodifiers Home")
; (xbindkey '(release "m:0x3" "Next")  "xdotool key --clearmodifiers End")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; End of xbindkeys configuration ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

