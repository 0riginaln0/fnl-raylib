(print "RAYLIB FFI INIT: STARTED")
(local ffi (require :ffi))

(print ffi.os)
(print ffi.arch)	

(ffi.cdef "
  void InitWindow(int width, int height, const char *title);  // Initialize window and OpenGL context
  void SetTargetFPS(int fps);                                 // Set target FPS (maximum)
  bool WindowShouldClose(void);                               // Check if application should close (KEY_ESCAPE pressed or windows close icon clicked)
  void BeginDrawing(void);                                    // Setup canvas (framebuffer) to start drawing
  void EndDrawing(void);                                      // End canvas drawing and swap buffers (double buffering)
  void CloseWindow(void);                                     // Close window and unload OpenGL context
")

(local rl (ffi.load :lib\raylib-5.5_win64_mingw-w64\lib\raylib.dll))

(var init-window nil)
(set init-window (fn [width height title] (rl.InitWindow width height title)))

(var set-target-fps nil)
(set set-target-fps (fn [fps] (rl.SetTargetFPS fps)))

(var window-should-close nil)
(set window-should-close (fn [] (rl.WindowShouldClose)))

(var close-window nil)
(set close-window (fn [] (rl.CloseWindow)))

(var begin-drawing nil)
(set begin-drawing (fn [] (rl.BeginDrawing)))

(var end-drawing nil)
(set end-drawing (fn [] (rl.EndDrawing)))


(print "RAYLIB FFI INIT: COMPLETED")
{: init-window
 : set-target-fps
 : window-should-close
 : close-window
 : begin-drawing
 : end-drawing
 : rl}
