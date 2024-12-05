(local rl (require :lib.raylib))

; Initialization
(local screen-width 800)
(local screen-height 450)

(rl.init-window screen-width screen-height "raylib [core] example - mouse input")
(rl.set-target-fps 60)

(var cursor-pos (rl.Vector2 0 0))
(var cursor-color rl.darkpurple)
(var monitor-number (rl.get-current-monitor))
(var window-pos (rl.get-window-position))

(while (not (rl.window-should-close))
  ; Update
  (set cursor-pos (rl.get-mouse-position))
  ; If window moves, we must 
  (set monitor-number (rl.get-current-monitor))
  (set window-pos (rl.get-window-position))
  (print window-pos)
  
  ; (if (rl.is-key-pressed rl.key-f11)
  ;   )
  
  ; Draw
  (rl.begin-drawing)
  (rl.clear-background rl.raywhite)
  
  (rl.draw-text "move ball with mouse and click mouse button to change color"
                 10 10 20 rl.darkgray)
  (rl.draw-circle-v cursor-pos 10 cursor-color)
  
  (rl.end-drawing))

(rl.close-window)
(print "That's all")