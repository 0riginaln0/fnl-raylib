(print "RAYLIB FFI INIT: STARTED")
(local safe-mode true)

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

// Vector2 type
typedef struct Vector2 {
    float x;
    float y;
} Vector2;

void InitWindow(int width, int height, const char *title);  // Initialize window and OpenGL context
void SetTargetFPS(int fps);                                 // Set target FPS (maximum)
bool WindowShouldClose(void);                               // Check if application should close (KEY_ESCAPE pressed or windows close icon clicked)
void BeginDrawing(void);                                    // Setup canvas (framebuffer) to start drawing
void EndDrawing(void);                                      // End canvas drawing and swap buffers (double buffering)
void CloseWindow(void);                                     // Close window and unload OpenGL context

void ClearBackground(Color color);                          // Set background color (framebuffer clear color)

bool IsKeyDown(int key);                                // Check if a key is being pressed


// module: rtext
void DrawText(const char *text, int posX, int posY, int fontSize, Color color);       // Draw text (using default font)


void DrawCircleV(Vector2 center, float radius, Color color);                                       // Draw a color-filled circle (Vector version)                            // Draw a color-filled circle

Vector2 GetMousePosition(void);                         // Get mouse position XY

// Input-related functions: mouse
bool IsMouseButtonPressed(int button);                  // Check if a mouse button has been pressed once
")

(local rl (ffi.load :lib\raylib-5.5_win64_mingw-w64\lib\raylib.dll))

(fn init-window [width height title] (rl.InitWindow width height title))
(fn set-target-fps [fps] (rl.SetTargetFPS fps))
(fn window-should-close [] (rl.WindowShouldClose))
(fn close-window [] (rl.CloseWindow))
(fn begin-drawing [] (rl.BeginDrawing))
(fn end-drawing [] (rl.EndDrawing))
(fn clear-background [color] (rl.ClearBackground color))
(fn Color [r g b a]
  (when safe-mode
    (assert (<= 0 r 255) (.. "Red value of Color must be in range of 0 to 255, but it's " r))
    (assert (<= 0 g 255) (.. "Green value of Color must be in range of 0 to 255, but it's " g))
    (assert (<= 0 b 255) (.. "Blue value of Color must be in range of 0 to 255, but it's " b))
    (assert (<= 0 a 255) (.. "Alpha value of Color must be in range of 0 to 255, but it's " a)))
  (ffi.new :Color [r g b a]))


(local raywhite (Color 245 245 245 255))
(local lightgray (Color 200 200 200 255))
(local maroon (Color 190 33 55 255))
(local darkblue (Color 0 82 172 255))
(local darkgray (Color 80 80 80 255))
(local yellow (Color 253 249 0 255))
(local gray (Color 130 130 130 255))
(local gold (Color 255 203 0 255))
(local orange (Color 255 161 0 255))
(local pink (Color 255 109 194 255))
(local red (Color 230 41 55 255))
(local green (Color 0 228 48 255))
(local lime (Color 0 158 47 255))
(local darkgreen (Color 0 117 44 255))
(local skyblue (Color 102 191 255 255))
(local blue (Color 0 121 241 255))
(local purple (Color 200 122 255 255))
(local violet (Color 135 60 190 255))
(local darkpurple (Color 112 31 126 255))
(local beige (Color 211 176 131 255))
(local brown (Color 127 106 79 255))
(local darkbrown (Color 76 63 47 255))
(local white (Color 255 255 255 255))
(local black (Color 0 0 0 255))
(local blank (Color 0 0 0 0))
(local magenta (Color 255 0 255 255))

(fn draw-text [text pos-x pos-y font-size color]
  (rl.DrawText text pos-x pos-y font-size color))
(fn Vector2 [x y]
  (ffi.new :Vector2 [x y]))


(local key-right 262) 
(local key-left 263)
(local key-down 264)
(local key-up 265)


(fn is-key-down [key]
  (rl.IsKeyDown key))

(fn draw-circle-v [center radius color]
  (rl.DrawCircleV center radius color))

(fn get-mouse-position []
  (rl.GetMousePosition))

(fn is-mouse-button-pressed [button]
  (rl.IsMouseButtonPressed button))

(local mouse-button-left 0)
(local mouse-button-right 1)
(local mouse-button-middle 2)
(local mouse-button-side 3)
(local mouse-button-extra 4)
(local mouse-button-forward 5)
(local mouse-button-back 6)

(print "RAYLIB FFI INIT: COMPLETED")

{: safe-mode
 
 : init-window
 : set-target-fps
 : window-should-close
 : close-window
 : begin-drawing
 : end-drawing
 : maroon
 : Color
 : clear-background
 : raywhite
 : lightgray
 : darkgray
 : yellow
 : gray
 : gold
 : orange
 : pink
 : red
 : green
 : lime
 : darkgreen
 : skyblue
 : blue
 : purple
 : violet
 : darkpurple
 : beige
 : brown
 : darkbrown
 : white
 : black
 : blank
 : magenta
 
 
 : draw-text
 : Vector2
 : key-right
 : key-left
 : key-down
 : key-up
 : is-key-down
 : draw-circle-v
 : darkblue
 : get-mouse-position
 : is-mouse-button-pressed
 : mouse-button-left
 : mouse-button-right
 : mouse-button-middle
 : mouse-button-side
 : mouse-button-extra
 : mouse-button-forward
 : mouse-button-back
 
 
 : rl}
