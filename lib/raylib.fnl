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
               (when safe-mode
                 (assert (<= 0 r 255) (.. "Red value of Color must be in range of 0 to 255, but it's " r))
                 (assert (<= 0 g 255) (.. "Green value of Color must be in range of 0 to 255, but it's " g))
                 (assert (<= 0 b 255) (.. "Blue value of Color must be in range of 0 to 255, but it's " b))
                 (assert (<= 0 a 255) (.. "Alpha value of Color must be in range of 0 to 255, but it's " a)))
               (ffi.new :Color [r g b a])))


(local raywhite (Color 245 245 245 255))
(local lightgray (Color 200 200 200 255))
(local darkgray (Color 80 80 80 255))
(local maroon (Color 190 33 55 255))


(local draw-text (fn [text pos-x pos-y font-size color]
                   (rl.DrawText text pos-x pos-y font-size color)))
(local Vector2 (fn [x y]
                 (ffi.new :Vector2 [x y])))


(local key-right 262) 
(local key-left 263)
(local key-down 264)
(local key-up 265)


(local is-key-down (fn [key]
                     (rl.IsKeyDown key)))

(local draw-circle-v (fn [center radius color]
                       (rl.DrawCircleV center radius color)))

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
 : draw-text
 : Vector2
 : key-right
 : key-left
 : key-down
 : key-up
 : is-key-down
 : draw-circle-v
 
 : rl}
