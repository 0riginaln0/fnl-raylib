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
    (do 
      (rl.set-window-size screen-width screen-height) 
      (rl.enable-cursor))
    (do 
      (rl.set-window-size (rl.get-monitor-width current-screen) (rl.get-monitor-height current-screen))
      (rl.disable-cursor)))
  (rl.toggle-fullscreen))

(fn toggle-mouselock []
  (if (rl.is-cursor-hidden)
    (rl.enable-cursor)
    (rl.disable-cursor)))

(while (not (rl.window-should-close))
  ; Update
  (set cursor-pos (get-new-cursor-pos))
  
  (when (rl.is-key-pressed rl.key-f11)
    (toggle-fullscreen))
  
  (when (rl.is-key-pressed rl.key-f10)
    (toggle-mouselock))
  
  ; Draw
  (rl.begin-drawing)
  (rl.clear-background rl.darkgray)
  
  (rl.draw-text "Press F11 to toggle full screen mode" 10 10 20 rl.lightgray)
  (rl.draw-text "Press F10 to toggle mouse lock mode" 10 40 20 rl.lightgray)
  (rl.draw-circle-v cursor-pos 10 cursor-color)
  
  (rl.end-drawing))

(rl.close-window)
(print "That's all")
