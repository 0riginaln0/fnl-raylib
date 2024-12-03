(print "RAYLIB FFI INIT: STARTED")
(local ffi (require :ffi))

(print ffi.os)
(print ffi.arch)	

(ffi.cdef "
  // Color, 4 components, R8G8B8A8 (32bit)
  typedef struct Color {
      unsigned char r;        // Color red value
      unsigned char g;        // Color green value
      unsigned char b;        // Color blue value
      unsigned char a;        // Color alpha value
  } Color;

  void InitWindow(int width, int height, const char *title);  // Initialize window and OpenGL context
  void SetTargetFPS(int fps);                                 // Set target FPS (maximum)
  bool WindowShouldClose(void);                               // Check if application should close (KEY_ESCAPE pressed or windows close icon clicked)
  void BeginDrawing(void);                                    // Setup canvas (framebuffer) to start drawing
  void EndDrawing(void);                                      // End canvas drawing and swap buffers (double buffering)
  void CloseWindow(void);                                     // Close window and unload OpenGL context

  void ClearBackground(Color color);                          // Set background color (framebuffer clear color)
")

(local rl (ffi.load :lib\raylib-5.5_win64_mingw-w64\lib\raylib.dll))

(local init-window (fn [width height title] (rl.InitWindow width height title)))
(local set-target-fps (fn [fps] (rl.SetTargetFPS fps)))
(local window-should-close (fn [] (rl.WindowShouldClose)))
(local close-window (fn [] (rl.CloseWindow)))
(local begin-drawing (fn [] (rl.BeginDrawing)))
(local end-drawing (fn [] (rl.EndDrawing)))
(local clear-background (fn [color] (rl.ClearBackground color)))
(local Color (fn [r g b a]
               (ffi.new :Color [r g b a])))


(print "RAYLIB FFI INIT: COMPLETED")
{: init-window
 : set-target-fps
 : window-should-close
 : close-window
 : begin-drawing
 : end-drawing
 : clear-background
 : Color
 : rl}
