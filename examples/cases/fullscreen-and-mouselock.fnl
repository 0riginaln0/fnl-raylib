(local rl (require :lib.raylib))

; Initialization
(var screen-width 500)
(var screen-height 500)
(rl.init-window screen-width screen-height "raylib [core] example - mouse input")
(rl.set-target-fps 60)

(var cursor-pos (rl.Vector2 0 0))
(var cursor-color rl.darkpurple)
(var current-screen (rl.get-current-monitor))

(fn get-new-cursor-pos [] 
  (let [mouse-position (rl.get-mouse-position)]
    (if (not (rl.is-window-fullscreen))
      (do 
        (print mouse-position "\nis hidden:" (rl.is-cursor-hidden))
        (if (rl.is-cursor-on-screen)
            mouse-position
            cursor-pos))
      (do 
        (let [screen-width (rl.get-monitor-width current-screen)
                screen-height (rl.get-monitor-height current-screen)]
            (print "Screen width: " screen-width "\nScreen Height"
                   screen-height "\nmouse pos" mouse-position 
                   "\nIs focused: " (rl.is-window-focused)
                   "\nis hidden:" (rl.is-cursor-hidden)))
        mouse-position))))

; Когда is-cursor-hidden (после rl.disable-cursor), то мышь может иметь координаты за пределами

(while (not (rl.window-should-close))
  ; Update
  (set cursor-pos (get-new-cursor-pos))
  
  ; Toggle Fullscreen
  (when (rl.is-key-pressed rl.key-f11)
    (set current-screen (rl.get-current-monitor))
    (if (rl.is-window-fullscreen)
      (do 
        (rl.set-window-size screen-width screen-height))
      (do 
        (rl.set-window-size (rl.get-monitor-width current-screen)
                            (rl.get-monitor-height current-screen))))
    (rl.toggle-fullscreen))
  
  (when (rl.is-key-pressed rl.key-f10)
    (if (rl.is-cursor-hidden)
      (rl.enable-cursor)
      (rl.disable-cursor)))
  
  ; Draw
  (rl.begin-drawing)
  (rl.clear-background rl.raywhite)
  
  (rl.draw-text "Press F11 to toggle full screen mode" 10 10 20 rl.darkgray)
  (rl.draw-circle-v cursor-pos 10 cursor-color)
  (rl.draw-text "Press F10 to toggle mouse lock mode" 10 40 20 rl.darkgray)
  (rl.draw-circle-v cursor-pos 10 cursor-color)
  
  (rl.end-drawing))

(rl.close-window)
(print "That's all")
