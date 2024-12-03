print("RAYLIB FFI INIT: STARTED")
local ffi = require("ffi")
print(ffi.os)
print(ffi.arch)
ffi.cdef("\13\n  // Color, 4 components, R8G8B8A8 (32bit)\13\n  typedef struct Color {\13\n      unsigned char r;        // Color red value\13\n      unsigned char g;        // Color green value\13\n      unsigned char b;        // Color blue value\13\n      unsigned char a;        // Color alpha value\13\n  } Color;\13\n\13\n  void InitWindow(int width, int height, const char *title);  // Initialize window and OpenGL context\13\n  void SetTargetFPS(int fps);                                 // Set target FPS (maximum)\13\n  bool WindowShouldClose(void);                               // Check if application should close (KEY_ESCAPE pressed or windows close icon clicked)\13\n  void BeginDrawing(void);                                    // Setup canvas (framebuffer) to start drawing\13\n  void EndDrawing(void);                                      // End canvas drawing and swap buffers (double buffering)\13\n  void CloseWindow(void);                                     // Close window and unload OpenGL context\13\n\13\n  void ClearBackground(Color color);                          // Set background color (framebuffer clear color)\13\n")
local rl = ffi.load("lib\\raylib-5.5_win64_mingw-w64\\lib\\raylib.dll")
local init_window
local function _1_(width, height, title)
  return rl.InitWindow(width, height, title)
end
init_window = _1_
local set_target_fps
local function _2_(fps)
  return rl.SetTargetFPS(fps)
end
set_target_fps = _2_
local window_should_close
local function _3_()
  return rl.WindowShouldClose()
end
window_should_close = _3_
local close_window
local function _4_()
  return rl.CloseWindow()
end
close_window = _4_
local begin_drawing
local function _5_()
  return rl.BeginDrawing()
end
begin_drawing = _5_
local end_drawing
local function _6_()
  return rl.EndDrawing()
end
end_drawing = _6_
local clear_background
local function _7_(color)
  return rl.ClearBackground(color)
end
clear_background = _7_
local Color
local function _8_(r, g, b, a)
  return ffi.new("Color", {r, g, b, a})
end
Color = _8_
print("RAYLIB FFI INIT: COMPLETED")
return {["init-window"] = init_window, ["set-target-fps"] = set_target_fps, ["window-should-close"] = window_should_close, ["close-window"] = close_window, ["begin-drawing"] = begin_drawing, ["end-drawing"] = end_drawing, ["clear-background"] = clear_background, Color = Color, rl = rl}
