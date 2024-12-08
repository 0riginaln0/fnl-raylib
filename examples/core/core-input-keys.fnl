(local rl (require :lib.raylib))
(local utils (require :lib.utils))
(local inspect (. utils :inspect))

(local screen-width 800)
(local screen-height 450)

(rl.init-window screen-width screen-height "raylib [core] example - keyboard input")

(var ball-position (rl.Vector2 (/ screen-width 2) (/ screen-height 2)))

(print ball-position.x)
(print ball-position.y)


(var current-screen (rl.get-current-monitor))
(-> (rl.get-monitor-refresh-rate current-screen)
    (inspect "Monitor refresh rate:")
    (rl.set-target-fps))

(while (not (rl.window-should-close))
  (if (rl.is-key-down rl.key-right) (set ball-position.x (+ ball-position.x 6)))
  (if (rl.is-key-down rl.key-left)  (set ball-position.x (- ball-position.x 6)))
  (if (rl.is-key-down rl.key-up)    (set ball-position.y (- ball-position.y 6)))
  (if (rl.is-key-down rl.key-down)  (set ball-position.y (+ ball-position.y 6)))
  
  
  (rl.begin-drawing)
  (rl.clear-background rl.raywhite)
  (rl.draw-text "move the ball with arrow keys" 10 10 20 rl.darkgray)
  (rl.draw-circle-v ball-position 50 rl.maroon)
  (rl.end-drawing))

(rl.close-window)
(print "That's all")