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
(print window-pos)
(print "Windows pos x:" window-pos.x)
(print "Windows pos y:" window-pos.y)
(var aindow-pos (rl.Vector2 240 267))
(print aindow-pos)
(print "Aindows pos x:" aindow-pos.x)
(print "Aindows pos y:" aindow-pos.y)
(print (= aindow-pos window-pos))

(print "vectors eq")
(local vec1 (rl.Vector2 1.0 2.0))
(local vec2 (rl.Vector2 1.0 2.0))
(local vec3 (rl.Vector2 2.0 3.0))

(print (= vec1 vec2))
(print (= vec1 vec3))
(print (# vec1))


(while (not (rl.window-should-close))
  ; Update
  (set cursor-pos (rl.get-mouse-position))
  (set monitor-number (rl.get-current-monitor))
  
  
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