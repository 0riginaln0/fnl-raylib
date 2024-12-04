(local rl (require :lib.fennelib))

(rl.init-window 640 640 "Fennel & Raylib")
(rl.set-target-fps 60)

(local background (rl.Color 161 212 242 250))

(while (not (rl.window-should-close))
  (rl.begin-drawing)
  (rl.clear-background background)
  
  (rl.end-drawing))

(rl.close-window)
(print "That's all")