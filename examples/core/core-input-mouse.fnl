(local rl (require :lib.raylib))

(local screen-width 800)
(local screen-height 450)

(rl.init-window screen-width screen-height "raylib [core] example - mouse input")

(var ball-position (rl.Vector2 -100 -100))
(var ball-color rl.darkblue)


(rl.set-target-fps 60)

(while (not (rl.window-should-close))
  (set ball-position (rl.get-mouse-position))
  
  (if 
    (rl.is-mouse-button-pressed rl.mouse-button-left) (set ball-color rl.maroon)
    (rl.is-mouse-button-pressed rl.mouse-button-middle) (set ball-color rl.lime)
    (rl.is-mouse-button-pressed rl.mouse-button-right) (set ball-color rl.darkblue)
    (rl.is-mouse-button-pressed rl.mouse-button-side) (set ball-color rl.purple)
    (rl.is-mouse-button-pressed rl.mouse-button-extra) (set ball-color rl.yellow)
    (rl.is-mouse-button-pressed rl.mouse-button-forward) (set ball-color rl.orange)
    (rl.is-mouse-button-pressed rl.mouse-button-back) (set ball-color rl.beige))
  
  (rl.begin-drawing)
  (rl.clear-background rl.raywhite)
  
  (rl.draw-text "move ball with mouse and click mouse button to change color"
                 10 10 20 rl.darkgray)
  (rl.draw-circle-v ball-position 40 ball-color)
  
  (rl.end-drawing))

(rl.close-window)
(print "That's all")