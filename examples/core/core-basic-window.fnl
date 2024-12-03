; fennel .\examples\core\core-basic-window.fnl

(local rl (require :lib.raylib))

(local screen-width 800)
(local screen-height 450)

(rl.init-window screen-width screen-height)
(rl.set-target-fps 60)

(while (not (rl.window-should-close))
  (rl.begin-drawing)
  (rl.clear-background rl.raywhite)
  (rl.draw-text "Congrats! You created your first window!" 190 200 20 rl.lightgray)
  (rl.end-drawing))

(rl.close-window)
(print "That's all")