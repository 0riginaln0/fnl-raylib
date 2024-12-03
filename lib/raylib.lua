print("RAYLIB FFI INIT: STARTED")
local safe_mode = true
local ffi = require("ffi")
local os = ffi.os
print(os)
local rl
if (os == "Windows") then
  rl = ffi.load("lib\\raylib-5.5_win64_mingw-w64\\lib\\raylib.dll")
elseif (os == "Linux") then
  rl = ffi.load("lib/raylib-5.5_linux_amd64/lib/libraylib.so")
else
  rl = nil
end
assert((rl == nil), "Unknown OS. Sorry")
ffi.cdef("\n// Color, 4 components, R8G8B8A8 (32bit)\ntypedef struct Color {\n    unsigned char r;        // Color red value\n    unsigned char g;        // Color green value\n    unsigned char b;        // Color blue value\n    unsigned char a;        // Color alpha value\n} Color;\n\n// Vector2 type\ntypedef struct Vector2 {\n    float x;\n    float y;\n} Vector2;\n\nvoid InitWindow(int width, int height, const char *title);  // Initialize window and OpenGL context\nvoid SetTargetFPS(int fps);                                 // Set target FPS (maximum)\nbool WindowShouldClose(void);                               // Check if application should close (KEY_ESCAPE pressed or windows close icon clicked)\nvoid BeginDrawing(void);                                    // Setup canvas (framebuffer) to start drawing\nvoid EndDrawing(void);                                      // End canvas drawing and swap buffers (double buffering)\nvoid CloseWindow(void);                                     // Close window and unload OpenGL context\n\nvoid ClearBackground(Color color);                          // Set background color (framebuffer clear color)\n\nbool IsKeyDown(int key);                                // Check if a key is being pressed\n\n\n// module: rtext\nvoid DrawText(const char *text, int posX, int posY, int fontSize, Color color);       // Draw text (using default font)\n\n\nvoid DrawCircleV(Vector2 center, float radius, Color color);                                       // Draw a color-filled circle (Vector version)                            // Draw a color-filled circle\n\nVector2 GetMousePosition(void);                         // Get mouse position XY\n\n// Input-related functions: mouse\nbool IsMouseButtonPressed(int button);                  // Check if a mouse button has been pressed once\n")
local function init_window(width, height, title)
  return rl.InitWindow(width, height, title)
end
local function set_target_fps(fps)
  return rl.SetTargetFPS(fps)
end
local function window_should_close()
  return rl.WindowShouldClose()
end
local function close_window()
  return rl.CloseWindow()
end
local function begin_drawing()
  return rl.BeginDrawing()
end
local function end_drawing()
  return rl.EndDrawing()
end
local function clear_background(color)
  return rl.ClearBackground(color)
end
local function Color(r, g, b, a)
  if safe_mode then
    assert(((0 <= r) and (r <= 255)), ("Red value of Color must be in range of 0 to 255, but it's " .. r))
    assert(((0 <= g) and (g <= 255)), ("Green value of Color must be in range of 0 to 255, but it's " .. g))
    assert(((0 <= b) and (b <= 255)), ("Blue value of Color must be in range of 0 to 255, but it's " .. b))
    assert(((0 <= a) and (a <= 255)), ("Alpha value of Color must be in range of 0 to 255, but it's " .. a))
  else
  end
  return ffi.new("Color", {r, g, b, a})
end
local raywhite = Color(245, 245, 245, 255)
local lightgray = Color(200, 200, 200, 255)
local maroon = Color(190, 33, 55, 255)
local darkblue = Color(0, 82, 172, 255)
local darkgray = Color(80, 80, 80, 255)
local yellow = Color(253, 249, 0, 255)
local gray = Color(130, 130, 130, 255)
local gold = Color(255, 203, 0, 255)
local orange = Color(255, 161, 0, 255)
local pink = Color(255, 109, 194, 255)
local red = Color(230, 41, 55, 255)
local green = Color(0, 228, 48, 255)
local lime = Color(0, 158, 47, 255)
local darkgreen = Color(0, 117, 44, 255)
local skyblue = Color(102, 191, 255, 255)
local blue = Color(0, 121, 241, 255)
local purple = Color(200, 122, 255, 255)
local violet = Color(135, 60, 190, 255)
local darkpurple = Color(112, 31, 126, 255)
local beige = Color(211, 176, 131, 255)
local brown = Color(127, 106, 79, 255)
local darkbrown = Color(76, 63, 47, 255)
local white = Color(255, 255, 255, 255)
local black = Color(0, 0, 0, 255)
local blank = Color(0, 0, 0, 0)
local magenta = Color(255, 0, 255, 255)
local function draw_text(text, pos_x, pos_y, font_size, color)
  return rl.DrawText(text, pos_x, pos_y, font_size, color)
end
local function Vector2(x, y)
  return ffi.new("Vector2", {x, y})
end
local key_right = 262
local key_left = 263
local key_down = 264
local key_up = 265
local function is_key_down(key)
  return rl.IsKeyDown(key)
end
local function draw_circle_v(center, radius, color)
  return rl.DrawCircleV(center, radius, color)
end
local function get_mouse_position()
  return rl.GetMousePosition()
end
local function is_mouse_button_pressed(button)
  return rl.IsMouseButtonPressed(button)
end
local mouse_button_left = 0
local mouse_button_right = 1
local mouse_button_middle = 2
local mouse_button_side = 3
local mouse_button_extra = 4
local mouse_button_forward = 5
local mouse_button_back = 6
print("RAYLIB FFI INIT: COMPLETED")
return {["safe-mode"] = safe_mode, ["init-window"] = init_window, ["set-target-fps"] = set_target_fps, ["window-should-close"] = window_should_close, ["close-window"] = close_window, ["begin-drawing"] = begin_drawing, ["end-drawing"] = end_drawing, maroon = maroon, Color = Color, ["clear-background"] = clear_background, raywhite = raywhite, lightgray = lightgray, darkgray = darkgray, yellow = yellow, gray = gray, gold = gold, orange = orange, pink = pink, red = red, green = green, lime = lime, darkgreen = darkgreen, skyblue = skyblue, blue = blue, purple = purple, violet = violet, darkpurple = darkpurple, beige = beige, brown = brown, darkbrown = darkbrown, white = white, black = black, blank = blank, magenta = magenta, ["draw-text"] = draw_text, Vector2 = Vector2, ["key-right"] = key_right, ["key-left"] = key_left, ["key-down"] = key_down, ["key-up"] = key_up, ["is-key-down"] = is_key_down, ["draw-circle-v"] = draw_circle_v, darkblue = darkblue, ["get-mouse-position"] = get_mouse_position, ["is-mouse-button-pressed"] = is_mouse_button_pressed, ["mouse-button-left"] = mouse_button_left, ["mouse-button-right"] = mouse_button_right, ["mouse-button-middle"] = mouse_button_middle, ["mouse-button-side"] = mouse_button_side, ["mouse-button-extra"] = mouse_button_extra, ["mouse-button-forward"] = mouse_button_forward, ["mouse-button-back"] = mouse_button_back, rl = rl}
