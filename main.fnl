(local rl (require :lib.raylib))

(rl.init-window 640 640 "Fennel & Raylib")
(rl.set-target-fps 60)

(while (not (rl.window-should-close)) 
  (rl.begin-drawing)
  (rl.end-drawing))

(rl.close-window)
(print "That's all")	