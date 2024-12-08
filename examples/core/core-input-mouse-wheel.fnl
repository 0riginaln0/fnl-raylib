(local rl (require :lib.raylib))
(local lume (require :lib.lume))
(local utils (require :lib.utils))
(local inspect (. utils :inspect))

(local screen-width 800)
(local screen-height 450)

(rl.init-window screen-width screen-height "raylib [core] example - mouse wheel input")


(var box-position (lume.round (- (/ screen-height) 40)))
(var scroll-speed 10)
(var current-screen (rl.get-current-monitor))
(-> (rl.get-monitor-refresh-rate current-screen)
    (inspect "Monitor refresh rate:")
    (rl.set-target-fps))


(while (not (rl.window-should-close))
  (set box-position (- box-position 
                       (* (lume.round (rl.get-mouse-wheel-move)) 
                          scroll-speed)))
  
  (rl.begin-drawing)
  (rl.clear-background rl.raywhite)
  (rl.draw-rectangle (/ screen-width 2) box-position 80 80 rl.maroon)
  (rl.draw-text "Use mouse wheel to move the cube up and down!" 10 10 20 rl.gray)
  (rl.draw-text (.. "Box position Y: " box-position) 10 40 20 rl.lightgray)
  (rl.end-drawing))


(rl.close-window)
(print "That's all")