(local rl (require :lib.raylib))
(local lume (require :lib.lume))
(local utils (require :lib.utils))
(local inspect (. utils :inspect))

(print "epic")
(-> 4.5
    (lume.round)
    (print))

(rl.init-window 640 640 "Fennel & Raylib")
(rl.set-target-fps 60)

(local background rl.darkgray)

(while (not (rl.window-should-close))
  (rl.begin-drawing)
  (rl.clear-background background)
  (rl.draw-text "Congrats! You created your first window!" 10 10 20 rl.lightgray)
  (rl.end-drawing))

(rl.close-window)
(print "That's all")

(-> 245
    (inspect "RGBA color before normalization: ")
    (rl.normalize 0 255)
    (inspect "RGBA color after normalization:  "))