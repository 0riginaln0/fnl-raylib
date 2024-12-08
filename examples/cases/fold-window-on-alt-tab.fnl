;; Based on the fullscreen-and-mouselock.fnl
;; The only addition is the "fold-window" part

(local rl (require :lib.raylib))
(local lume (require :lib.lume))
(local utils (require :lib.utils))
(local inspect (. utils :inspect))


; Initialization
(var screen-width 500)
(var screen-height 500)
(rl.init-window screen-width screen-height "raylib [core] example - mouse input!")

(var cursor-pos (rl.Vector2 0 0))
(var cursor-color rl.maroon)
(var current-screen (rl.get-current-monitor))

(-> (rl.get-monitor-refresh-rate current-screen)
    (inspect "Monitor refresh rate:")
    (rl.set-target-fps))


(fn get-new-cursor-pos [] 
  (let [mouse-pos (rl.get-mouse-position)]
    ; When rl.is-cursor-hidden aka is captured, mouse can have coordinates out of the monitor 
    ; (lower than 0 or higher than (rl.get-render-width or -height))
    (if (rl.is-cursor-hidden)
      ; Captured
      (let [window-width (rl.get-render-width)
            window-height (rl.get-render-height)]
        ; Is mouse in window?
        (if (and (< 0 mouse-pos.x window-width) (< 0 mouse-pos.y window-height))
          ; yes, set to current mouse pos
          mouse-pos
          ; no, adjust pos with deltas, but don't set out of window
          (let [mouse-dt (rl.get-mouse-delta)
                dt-x (lume.clamp (+ cursor-pos.x mouse-dt.x) 0 window-width)
                dt-y (lume.clamp (+ cursor-pos.y mouse-dt.y) 0 window-height)
                dt (rl.Vector2 dt-x dt-y)]
            (rl.set-mouse-position dt.x dt.y)
            dt)))
      ; Not captured. Set to current mouse pos
      mouse-pos)))

(fn toggle-fullscreen []
  "
  Sets window to fullscreen and captures the mouse
  or
  Sets window to default res and uncaptures the mouse
  "
  (set current-screen (rl.get-current-monitor))
  (if (rl.is-window-fullscreen)
    (rl.set-window-size screen-width screen-height)
    (rl.set-window-size (rl.get-monitor-width current-screen) 
                        (rl.get-monitor-height current-screen)))
  (rl.toggle-fullscreen))

(fn toggle-mouselock []
  (if (rl.is-cursor-hidden)
    (rl.enable-cursor)
    (rl.disable-cursor)))

(fn toggle-borderless-windowed []
  (rl.toggle-borderless-windowed))

;; Hack (or they really do it in prod) the window to fold on when unfocused (dor example after alt+tab)
(fn fold-window []
  (if (rl.is-window-state rl.flag-window-unfocused)
    (rl.set-window-state rl.flag-window-minimized)))


(while (not (rl.window-should-close))
  ; Update
  (set cursor-pos (get-new-cursor-pos))
  
  (when (rl.is-key-pressed rl.key-f11)
    (toggle-fullscreen))
  
  (when (rl.is-key-pressed rl.key-f10)
    (toggle-mouselock))
  
  (when (rl.is-key-pressed rl.key-f9)
    (toggle-borderless-windowed))
  
  (when (rl.is-window-state rl.flag-window-unfocused)
    (fold-window))
  
  ; Draw
  (rl.begin-drawing)
  (rl.clear-background rl.darkgray)
  
  (rl.draw-text "Press F11 to toggle full screen mode" 10 10 20 rl.lightgray)
  (rl.draw-text "Press F10 to toggle mouse lock mode" 10 40 20 rl.lightgray)
  (rl.draw-text "Press F9 to toggle borderless windowed" 10 70 20 rl.lightgray)
  
  ;; As far as I tested mixing borderless and fullscreen breaks things, so maybe you want
  ;; to choose only one option for the "fullscreen": 
  ;; 1. toggling borderless
  ;;  or
  ;; 2. toggling fullscreen
  ;; I prefer the first one (toggling borderless)
  (do
    (rl.draw-text (.. "flag-vsync-hint: "
                      (tostring (rl.is-window-state rl.flag-vsync-hint)))
                  10 100 10 rl.lightgray)
    (rl.draw-text (.. "flag-fullscreen-mode: "
                      (tostring (rl.is-window-state rl.flag-fullscreen-mode)))
                  10 120 10 rl.lightgray)
    (rl.draw-text (.. "flag-window-resizable: "
                      (tostring (rl.is-window-state rl.flag-window-resizable)))
                  10 140 10 rl.lightgray)
    (rl.draw-text (.. "flag-window-undecorated: "
                      (tostring (rl.is-window-state rl.flag-window-undecorated)))
                  10 160 10 rl.lightgray)
    (rl.draw-text (.. "flag-window-hidden: "
                      (tostring (rl.is-window-state rl.flag-window-hidden)))
                  10 180 10 rl.lightgray)
    (rl.draw-text (.. "flag-window-minimized: "
                      (tostring (rl.is-window-state rl.flag-window-minimized)))
                  10 200 10 rl.lightgray)
    (rl.draw-text (.. "flag-window-maximized: "
                      (tostring (rl.is-window-state rl.flag-window-maximized)))
                  10 220 10 rl.lightgray)
    (rl.draw-text (.. "flag-window-unfocused: "
                      (tostring (rl.is-window-state rl.flag-window-unfocused)))
                  10 240 10 rl.lightgray)
    (rl.draw-text (.. "flag-window-topmost: "
                      (tostring (rl.is-window-state rl.flag-window-topmost)))
                  10 260 10 rl.lightgray)
    (rl.draw-text (.. "flag-window-always-run: "
                      (tostring (rl.is-window-state rl.flag-window-always-run)))
                  10 280 10 rl.lightgray)
    (rl.draw-text (.. "flag-window-transparent: "
                      (tostring (rl.is-window-state rl.flag-window-transparent)))
                  10 300 10 rl.lightgray)
    (rl.draw-text (.. "flag-window-highdpi: "
                      (tostring (rl.is-window-state rl.flag-window-highdpi)))
                  10 320 10 rl.lightgray)
    (rl.draw-text (.. "lag-window-mouse-passthrough: "
                      (tostring (rl.is-window-state rl.flag-window-mouse-passthrough)))
                  10 340 10 rl.lightgray)
    (rl.draw-text (.. "flag-borderless-windowed-mode: "
                      (tostring (rl.is-window-state rl.flag-borderless-windowed-mode)))
                  10 360 10 rl.lightgray)
    (rl.draw-text (.. "flag-msaa-4x-hint: "
                      (tostring (rl.is-window-state rl.flag-msaa-4x-hint)))
                  10 380 10 rl.lightgray)
    (rl.draw-text (.. "flag-interlaced-hint: "
                      (tostring (rl.is-window-state rl.flag-interlaced-hint)))
                  10 400 10 rl.lightgray))
  
  (rl.draw-circle-v cursor-pos 10 cursor-color)
  
  (rl.end-drawing))

(rl.close-window)
(print "That's all")
