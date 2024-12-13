(local rl (require :lib.raylib))
(local utils (require :lib.utils))
(local inspect (. utils :inspect))

(local screen-width 800)
(local screen-height 450)

(rl.init-window screen-width screen-height "3D-2D transition")

(local camera (rl.Camera3D (rl.Vector3 5 10 10)
                           (rl.Vector3 0 0 0)
                           (rl.Vector3 0 1 0)
                           45
                           rl.camera-perspective))

(local cube-position (rl.Vector3 0 0 0))

(-> (rl.get-current-monitor)
    (rl.get-monitor-refresh-rate)
    (inspect "Monitor refresh rate:")
    (rl.set-target-fps))

(local view-2D 0)
(local view-3D 1)

(var current-view view-2D)

(fn draw-3D []
  (rl.begin-mode3d camera)
    (rl.draw-cube cube-position 2 2 2 rl.red)
    (rl.draw-cube-wires cube-position 2 2 2 rl.maroon)
    (rl.draw-grid 10 1)
  (rl.end-mode3d))

(fn draw-2D []
  (rl.draw-rectangle cube-position.x 
                     (- cube-position.z cube-position.y)
                     20 20
                     rl.red))

(while (not (rl.window-should-close))
  
  (when (rl.is-key-pressed rl.key-a)
    (if (= current-view view-3D)
      (set current-view view-2D)
      (set current-view view-3D)))
  
  (rl.begin-drawing)
    (rl.clear-background rl.raywhite)
    (if (= current-view view-3D)
      (draw-3D)
      (draw-2D))
    (rl.draw-text "Welcome to the third dimension!" 10 40 20 rl.darkgray)
  (rl.end-drawing))

(rl.close-window)