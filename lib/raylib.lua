print("RAYLIB FFI INIT: STARTED")
local ffi = require("ffi")
print(ffi.os)
print(ffi.arch)
ffi.cdef("\13\n  void InitWindow(int width, int height, const char *title);  // Initialize window and OpenGL context\13\n  void SetTargetFPS(int fps);                                 // Set target FPS (maximum)\13\n  bool WindowShouldClose(void);                               // Check if application should close (KEY_ESCAPE pressed or windows close icon clicked)\13\n  void BeginDrawing(void);                                    // Setup canvas (framebuffer) to start drawing\13\n  void EndDrawing(void);                                      // End canvas drawing and swap buffers (double buffering)\13\n  void CloseWindow(void);                                     // Close window and unload OpenGL context\13\n")
local rl = ffi.load("lib\\raylib-5.5_win64_mingw-w64\\lib\\raylib.dll")
local init_window = nil
local function _1_(width, height, title)
  return rl.InitWindow(width, height, title)
end
init_window = _1_
local set_target_fps = nil
local function _2_(fps)
  return rl.SetTargetFPS(fps)
end
set_target_fps = _2_
local window_should_close = nil
local function _3_()
  return rl.WindowShouldClose()
end
window_should_close = _3_
local close_window = nil
local function _4_()
  return rl.CloseWindow()
end
close_window = _4_
local begin_drawing = nil
local function _5_()
  return rl.BeginDrawing()
end
begin_drawing = _5_
local end_drawing = nil
local function _6_()
  return rl.EndDrawing()
end
end_drawing = _6_
print("RAYLIB FFI INIT: COMPLETED")
return {["init-window"] = init_window, ["set-target-fps"] = set_target_fps, ["window-should-close"] = window_should_close, ["close-window"] = close_window, ["begin-drawing"] = begin_drawing, ["end-drawing"] = end_drawing, rl = rl}
