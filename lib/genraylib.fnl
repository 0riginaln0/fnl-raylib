
; My Raylib bindings for Fennel and so for Lua

(print "RAYLIB FFI INIT: STARTED")
(local safe-mode true)

(local ffi (require :ffi))

(local os ffi.os)
(print os)

(local rl 
  (case os 
    :Windows (ffi.load :lib\raylib-5.5_win64_mingw-w64\lib\raylib.dll) 
    :Linux   (ffi.load :lib/raylib-5.5_linux_amd64/lib/libraylib.so)))

; CFFI BLOCK
(ffi.cdef "
typedef struct Vector2 {
    float x;                // Vector x component
    float y;                // Vector y component
    } Vector2;

typedef struct Vector3 {
    float x;                // Vector x component
    float y;                // Vector y component
    float z;                // Vector z component
    } Vector3;

typedef struct Vector4 {
    float x;                // Vector x component
    float y;                // Vector y component
    float z;                // Vector z component
    float w;                // Vector w component
    } Vector4;

typedef Vector4 Quaternion;
typedef struct Matrix {
    float m0, m4, m8, m12;  // Matrix first row (4 components)
    float m1, m5, m9, m13;  // Matrix second row (4 components)
    float m2, m6, m10, m14; // Matrix third row (4 components)
    float m3, m7, m11, m15; // Matrix fourth row (4 components)
    } Matrix;

typedef struct Color {
    unsigned char r;        // Color red value
    unsigned char g;        // Color green value
    unsigned char b;        // Color blue value
    unsigned char a;        // Color alpha value
    } Color;

typedef struct Rectangle {
    float x;                // Rectangle top-left corner position x
    float y;                // Rectangle top-left corner position y
    float width;            // Rectangle width
    float height;           // Rectangle height
    } Rectangle;

typedef struct Image {
    void *data;             // Image raw data
    int width;              // Image base width
    int height;             // Image base height
    int mipmaps;            // Mipmap levels, 1 by default
    int format;             // Data format (PixelFormat type)
    } Image;

typedef struct Texture {
    unsigned int id;        // OpenGL texture id
    int width;              // Texture base width
    int height;             // Texture base height
    int mipmaps;            // Mipmap levels, 1 by default
    int format;             // Data format (PixelFormat type)
    } Texture;

typedef Texture Texture2D;
typedef Texture TextureCubemap;
typedef struct RenderTexture {
    unsigned int id;        // OpenGL framebuffer object id
    Texture texture;        // Color buffer attachment texture
    Texture depth;          // Depth buffer attachment texture
    } RenderTexture;

typedef RenderTexture RenderTexture2D;
typedef struct NPatchInfo {
    Rectangle source;       // Texture source rectangle
    int left;               // Left border offset
    int top;                // Top border offset
    int right;              // Right border offset
    int bottom;             // Bottom border offset
    int layout;             // Layout of the n-patch: 3x3, 1x3 or 3x1
    } NPatchInfo;

typedef struct GlyphInfo {
    int value;              // Character value (Unicode)
    int offsetX;            // Character offset X when drawing
    int offsetY;            // Character offset Y when drawing
    int advanceX;           // Character advance position X
    Image image;            // Character image data
    } GlyphInfo;

typedef struct Font {
    int baseSize;           // Base size (default chars height)
    int glyphCount;         // Number of glyph characters
    int glyphPadding;       // Padding around the glyph characters
    Texture2D texture;      // Texture atlas containing the glyphs
    Rectangle *recs;        // Rectangles in texture for the glyphs
    GlyphInfo *glyphs;      // Glyphs info data
    } Font;

typedef struct Camera3D {
    Vector3 position;       // Camera position
    Vector3 target;         // Camera target it looks-at
    Vector3 up;             // Camera up vector (rotation over its axis)
    float fovy;             // Camera field-of-view aperture in Y (degrees) in perspective, used as near plane width in orthographic
    int projection;         // Camera projection: CAMERA_PERSPECTIVE or CAMERA_ORTHOGRAPHIC
    } Camera3D;

typedef Camera3D Camera;    // Camera type fallback, defaults to Camera3D
typedef struct Camera2D {
    Vector2 offset;         // Camera offset (displacement from target)
    Vector2 target;         // Camera target (rotation and zoom origin)
    float rotation;         // Camera rotation in degrees
    float zoom;             // Camera zoom (scaling), should be 1.0f by default
    } Camera2D;

typedef struct Mesh {
    int vertexCount;        // Number of vertices stored in arrays
    int triangleCount;      // Number of triangles stored (indexed or not)
    
    // Vertex attributes data
    float *vertices;        // Vertex position (XYZ - 3 components per vertex) (shader-location = 0)
    float *texcoords;       // Vertex texture coordinates (UV - 2 components per vertex) (shader-location = 1)
    float *texcoords2;      // Vertex texture second coordinates (UV - 2 components per vertex) (shader-location = 5)
    float *normals;         // Vertex normals (XYZ - 3 components per vertex) (shader-location = 2)
    float *tangents;        // Vertex tangents (XYZW - 4 components per vertex) (shader-location = 4)
    unsigned char *colors;      // Vertex colors (RGBA - 4 components per vertex) (shader-location = 3)
    unsigned short *indices;    // Vertex indices (in case vertex data comes indexed)
    
    // Animation vertex data
    float *animVertices;    // Animated vertex positions (after bones transformations)
    float *animNormals;     // Animated normals (after bones transformations)
    unsigned char *boneIds; // Vertex bone ids, max 255 bone ids, up to 4 bones influence by vertex (skinning) (shader-location = 6)
    float *boneWeights;     // Vertex bone weight, up to 4 bones influence by vertex (skinning) (shader-location = 7)
    Matrix *boneMatrices;   // Bones animated transformation matrices
    int boneCount;          // Number of bones
    
    // OpenGL identifiers
    unsigned int vaoId;     // OpenGL Vertex Array Object id
    unsigned int *vboId;    // OpenGL Vertex Buffer Objects id (default vertex data)
    } Mesh;

typedef struct Shader {
    unsigned int id;        // Shader program id
    int *locs;              // Shader locations array (RL_MAX_SHADER_LOCATIONS)
    } Shader;

typedef struct MaterialMap {
    Texture2D texture;      // Material map texture
    Color color;            // Material map color
    float value;            // Material map value
    } MaterialMap;

typedef struct Material {
    Shader shader;          // Material shader
    MaterialMap *maps;      // Material maps array (MAX_MATERIAL_MAPS)
    float params[4];        // Material generic parameters (if required)
    } Material;

typedef struct Transform {
    Vector3 translation;    // Translation
    Quaternion rotation;    // Rotation
    Vector3 scale;          // Scale
    } Transform;

typedef struct BoneInfo {
    char name[32];          // Bone name
    int parent;             // Bone parent
    } BoneInfo;

typedef struct Model {
    Matrix transform;       // Local transform matrix
    
    int meshCount;          // Number of meshes
    int materialCount;      // Number of materials
    Mesh *meshes;           // Meshes array
    Material *materials;    // Materials array
    int *meshMaterial;      // Mesh material number
    
    // Animation data
    int boneCount;          // Number of bones
    BoneInfo *bones;        // Bones information (skeleton)
    Transform *bindPose;    // Bones base transformation (pose)
    } Model;

typedef struct ModelAnimation {
    int boneCount;          // Number of bones
    int frameCount;         // Number of animation frames
    BoneInfo *bones;        // Bones information (skeleton)
    Transform **framePoses; // Poses array by frame
    char name[32];          // Animation name
    } ModelAnimation;

typedef struct Ray {
    Vector3 position;       // Ray position (origin)
    Vector3 direction;      // Ray direction (normalized)
    } Ray;

typedef struct RayCollision {
    bool hit;               // Did the ray hit something?
    float distance;         // Distance to the nearest hit
    Vector3 point;          // Point of the nearest hit
    Vector3 normal;         // Surface normal of hit
    } RayCollision;

typedef struct BoundingBox {
    Vector3 min;            // Minimum vertex box-corner
    Vector3 max;            // Maximum vertex box-corner
    } BoundingBox;

typedef struct Wave {
    unsigned int frameCount;    // Total number of frames (considering channels)
    unsigned int sampleRate;    // Frequency (samples per second)
    unsigned int sampleSize;    // Bit depth (bits per sample): 8, 16, 32 (24 not supported)
    unsigned int channels;      // Number of channels (1-mono, 2-stereo, ...)
    void *data;                 // Buffer data pointer
    } Wave;

typedef struct rAudioBuffer rAudioBuffer;
    typedef struct rAudioProcessor rAudioProcessor;

typedef struct AudioStream {
    rAudioBuffer *buffer;       // Pointer to internal data used by the audio system
    rAudioProcessor *processor; // Pointer to internal data processor, useful for audio effects
    
    unsigned int sampleRate;    // Frequency (samples per second)
    unsigned int sampleSize;    // Bit depth (bits per sample): 8, 16, 32 (24 not supported)
    unsigned int channels;      // Number of channels (1-mono, 2-stereo, ...)
    } AudioStream;

typedef struct Sound {
    AudioStream stream;         // Audio stream
    unsigned int frameCount;    // Total number of frames (considering channels)
    } Sound;

typedef struct Music {
    AudioStream stream;         // Audio stream
    unsigned int frameCount;    // Total number of frames (considering channels)
    bool looping;               // Music looping enable
    
    int ctxType;                // Type of music context (audio filetype)
    void *ctxData;              // Audio context data, depends on type
    } Music;

typedef struct VrDeviceInfo {
    int hResolution;                // Horizontal resolution in pixels
    int vResolution;                // Vertical resolution in pixels
    float hScreenSize;              // Horizontal size in meters
    float vScreenSize;              // Vertical size in meters
    float eyeToScreenDistance;      // Distance between eye and display in meters
    float lensSeparationDistance;   // Lens separation distance in meters
    float interpupillaryDistance;   // IPD (distance between pupils) in meters
    float lensDistortionValues[4];  // Lens distortion constant parameters
    float chromaAbCorrection[4];    // Chromatic aberration correction parameters
    } VrDeviceInfo;

typedef struct VrStereoConfig {
    Matrix projection[2];           // VR projection matrices (per eye)
    Matrix viewOffset[2];           // VR view offset matrices (per eye)
    float leftLensCenter[2];        // VR left lens center
    float rightLensCenter[2];       // VR right lens center
    float leftScreenCenter[2];      // VR left screen center
    float rightScreenCenter[2];     // VR right screen center
    float scale[2];                 // VR distortion scale
    float scaleIn[2];               // VR distortion scale in
    } VrStereoConfig;

typedef struct FilePathList {
    unsigned int capacity;          // Filepaths max entries
    unsigned int count;             // Filepaths entries count
    char **paths;                   // Filepaths entries
    } FilePathList;

typedef struct AutomationEvent {
    unsigned int frame;             // Event frame
    unsigned int type;              // Event type (AutomationEventType)
    int params[4];                  // Event parameters (if required)
    } AutomationEvent;

typedef struct AutomationEventList {
    unsigned int capacity;          // Events max entries (MAX_AUTOMATION_EVENTS)
    unsigned int count;             // Events entries count
    AutomationEvent *events;        // Events entries
    } AutomationEventList;

void InitWindow(int width, int height, const char *title);  // Initialize window and OpenGL context

void CloseWindow(void);                                     // Close window and unload OpenGL context

bool WindowShouldClose(void);                               // Check if application should close (KEY_ESCAPE pressed or windows close icon clicked)

bool IsWindowReady(void);                                   // Check if window has been initialized successfully

bool IsWindowFullscreen(void);                              // Check if window is currently fullscreen

bool IsWindowHidden(void);                                  // Check if window is currently hidden

bool IsWindowMinimized(void);                               // Check if window is currently minimized

bool IsWindowMaximized(void);                               // Check if window is currently maximized

bool IsWindowFocused(void);                                 // Check if window is currently focused

bool IsWindowResized(void);                                 // Check if window has been resized last frame

bool IsWindowState(unsigned int flag);                      // Check if one specific window flag is enabled

void SetWindowState(unsigned int flags);                    // Set window configuration state using flags

void ClearWindowState(unsigned int flags);                  // Clear window configuration state flags

void ToggleFullscreen(void);                                // Toggle window state: fullscreen/windowed, resizes monitor to match window resolution

void ToggleBorderlessWindowed(void);                        // Toggle window state: borderless windowed, resizes window to match monitor resolution

void MaximizeWindow(void);                                  // Set window state: maximized, if resizable

void MinimizeWindow(void);                                  // Set window state: minimized, if resizable

void RestoreWindow(void);                                   // Set window state: not minimized/maximized

void SetWindowIcon(Image image);                            // Set icon for window (single image, RGBA 32bit)

void SetWindowIcons(Image *images, int count);              // Set icon for window (multiple images, RGBA 32bit)

void SetWindowTitle(const char *title);                     // Set title for window

void SetWindowPosition(int x, int y);                       // Set window position on screen

void SetWindowMonitor(int monitor);                         // Set monitor for the current window

void SetWindowMinSize(int width, int height);               // Set window minimum dimensions (for FLAG_WINDOW_RESIZABLE)

void SetWindowMaxSize(int width, int height);               // Set window maximum dimensions (for FLAG_WINDOW_RESIZABLE)

void SetWindowSize(int width, int height);                  // Set window dimensions

void SetWindowOpacity(float opacity);                       // Set window opacity [0.0f..1.0f]

void SetWindowFocused(void);                                // Set window focused

void *GetWindowHandle(void);                                // Get native window handle

int GetScreenWidth(void);                                   // Get current screen width

int GetScreenHeight(void);                                  // Get current screen height

int GetRenderWidth(void);                                   // Get current render width (it considers HiDPI)

int GetRenderHeight(void);                                  // Get current render height (it considers HiDPI)

int GetMonitorCount(void);                                  // Get number of connected monitors

int GetCurrentMonitor(void);                                // Get current monitor where window is placed

Vector2 GetMonitorPosition(int monitor);                    // Get specified monitor position

int GetMonitorWidth(int monitor);                           // Get specified monitor width (current video mode used by monitor)

int GetMonitorHeight(int monitor);                          // Get specified monitor height (current video mode used by monitor)

int GetMonitorPhysicalWidth(int monitor);                   // Get specified monitor physical width in millimetres

int GetMonitorPhysicalHeight(int monitor);                  // Get specified monitor physical height in millimetres

int GetMonitorRefreshRate(int monitor);                     // Get specified monitor refresh rate

Vector2 GetWindowPosition(void);                            // Get window position XY on monitor

Vector2 GetWindowScaleDPI(void);                            // Get window scale DPI factor

const char *GetMonitorName(int monitor);                    // Get the human-readable, UTF-8 encoded name of the specified monitor

void SetClipboardText(const char *text);                    // Set clipboard text content

const char *GetClipboardText(void);                         // Get clipboard text content

Image GetClipboardImage(void);                              // Get clipboard image content

void EnableEventWaiting(void);                              // Enable waiting for events on EndDrawing(), no automatic event polling

void DisableEventWaiting(void);                             // Disable waiting for events on EndDrawing(), automatic events polling

void ShowCursor(void);                                      // Shows cursor

void HideCursor(void);                                      // Hides cursor

bool IsCursorHidden(void);                                  // Check if cursor is not visible

void EnableCursor(void);                                    // Enables cursor (unlock cursor)

void DisableCursor(void);                                   // Disables cursor (lock cursor)

bool IsCursorOnScreen(void);                                // Check if cursor is on the screen

void ClearBackground(Color color);                          // Set background color (framebuffer clear color)

void BeginDrawing(void);                                    // Setup canvas (framebuffer) to start drawing

void EndDrawing(void);                                      // End canvas drawing and swap buffers (double buffering)

void BeginMode2D(Camera2D camera);                          // Begin 2D mode with custom camera (2D)

void EndMode2D(void);                                       // Ends 2D mode with custom camera

void BeginMode3D(Camera3D camera);                          // Begin 3D mode with custom camera (3D)

void EndMode3D(void);                                       // Ends 3D mode and returns to default 2D orthographic mode

void BeginTextureMode(RenderTexture2D target);              // Begin drawing to render texture

void EndTextureMode(void);                                  // Ends drawing to render texture

void BeginShaderMode(Shader shader);                        // Begin custom shader drawing

void EndShaderMode(void);                                   // End custom shader drawing (use default shader)

void BeginBlendMode(int mode);                              // Begin blending mode (alpha, additive, multiplied, subtract, custom)

void EndBlendMode(void);                                    // End blending mode (reset to default: alpha blending)

void BeginScissorMode(int x, int y, int width, int height); // Begin scissor mode (define screen area for following drawing)

void EndScissorMode(void);                                  // End scissor mode

void BeginVrStereoMode(VrStereoConfig config);              // Begin stereo rendering (requires VR simulator)

void EndVrStereoMode(void);                                 // End stereo rendering (requires VR simulator)

VrStereoConfig LoadVrStereoConfig(VrDeviceInfo device);     // Load VR stereo config for VR simulator device parameters

void UnloadVrStereoConfig(VrStereoConfig config);           // Unload VR stereo config

Shader LoadShader(const char *vsFileName, const char *fsFileName);   // Load shader from files and bind default locations

Shader LoadShaderFromMemory(const char *vsCode, const char *fsCode); // Load shader from code strings and bind default locations

bool IsShaderValid(Shader shader);                                   // Check if a shader is valid (loaded on GPU)

int GetShaderLocation(Shader shader, const char *uniformName);       // Get shader uniform location

int GetShaderLocationAttrib(Shader shader, const char *attribName);  // Get shader attribute location

void SetShaderValue(Shader shader, int locIndex, const void *value, int uniformType);               // Set shader uniform value

void SetShaderValueV(Shader shader, int locIndex, const void *value, int uniformType, int count);   // Set shader uniform value vector

void SetShaderValueMatrix(Shader shader, int locIndex, Matrix mat);         // Set shader uniform value (matrix 4x4)

void SetShaderValueTexture(Shader shader, int locIndex, Texture2D texture); // Set shader uniform value for texture (sampler2d)

void UnloadShader(Shader shader);                                    // Unload shader from GPU memory (VRAM)

Ray GetScreenToWorldRay(Vector2 position, Camera camera);         // Get a ray trace from screen position (i.e mouse)

Ray GetScreenToWorldRayEx(Vector2 position, Camera camera, int width, int height); // Get a ray trace from screen position (i.e mouse) in a viewport

Vector2 GetWorldToScreen(Vector3 position, Camera camera);        // Get the screen space position for a 3d world space position

Vector2 GetWorldToScreenEx(Vector3 position, Camera camera, int width, int height); // Get size position for a 3d world space position

Vector2 GetWorldToScreen2D(Vector2 position, Camera2D camera);    // Get the screen space position for a 2d camera world space position

Vector2 GetScreenToWorld2D(Vector2 position, Camera2D camera);    // Get the world space position for a 2d camera screen space position

Matrix GetCameraMatrix(Camera camera);                            // Get camera transform matrix (view matrix)

Matrix GetCameraMatrix2D(Camera2D camera);                        // Get camera 2d transform matrix

void SetTargetFPS(int fps);                                 // Set target FPS (maximum)

float GetFrameTime(void);                                   // Get time in seconds for last frame drawn (delta time)

double GetTime(void);                                       // Get elapsed time in seconds since InitWindow()

int GetFPS(void);                                           // Get current FPS

void SwapScreenBuffer(void);                                // Swap back buffer with front buffer (screen drawing)

void PollInputEvents(void);                                 // Register all input events

void WaitTime(double seconds);                              // Wait for some time (halt program execution)

void SetRandomSeed(unsigned int seed);                      // Set the seed for the random number generator

int GetRandomValue(int min, int max);                       // Get a random value between min and max (both included)

int *LoadRandomSequence(unsigned int count, int min, int max); // Load random values sequence, no values repeated

void UnloadRandomSequence(int *sequence);                   // Unload random values sequence

void TakeScreenshot(const char *fileName);                  // Takes a screenshot of current screen (filename extension defines format)

void SetConfigFlags(unsigned int flags);                    // Setup init configuration flags (view FLAGS)

void OpenURL(const char *url);                              // Open URL with default system browser (if available)

void TraceLog(int logLevel, const char *text, ...);         // Show trace log messages (LOG_DEBUG, LOG_INFO, LOG_WARNING, LOG_ERROR...)

void SetTraceLogLevel(int logLevel);                        // Set the current threshold (minimum) log level

void *MemAlloc(unsigned int size);                          // Internal memory allocator

void *MemRealloc(void *ptr, unsigned int size);             // Internal memory reallocator

void MemFree(void *ptr);                                    // Internal memory free

void SetTraceLogCallback(TraceLogCallback callback);         // Set custom trace log

void SetLoadFileDataCallback(LoadFileDataCallback callback); // Set custom file binary data loader

void SetSaveFileDataCallback(SaveFileDataCallback callback); // Set custom file binary data saver

void SetLoadFileTextCallback(LoadFileTextCallback callback); // Set custom file text data loader

void SetSaveFileTextCallback(SaveFileTextCallback callback); // Set custom file text data saver

unsigned char *LoadFileData(const char *fileName, int *dataSize); // Load file data as byte array (read)

void UnloadFileData(unsigned char *data);                   // Unload file data allocated by LoadFileData()

bool SaveFileData(const char *fileName, void *data, int dataSize); // Save data to file from byte array (write), returns true on success

bool ExportDataAsCode(const unsigned char *data, int dataSize, const char *fileName); // Export data to code (.h), returns true on success

char *LoadFileText(const char *fileName);                   // Load text data from file (read), returns a '\0' terminated string

void UnloadFileText(char *text);                            // Unload file text data allocated by LoadFileText()

bool SaveFileText(const char *fileName, char *text);        // Save text data to file (write), string must be '\0' terminated, returns true on success

bool FileExists(const char *fileName);                      // Check if file exists

bool DirectoryExists(const char *dirPath);                  // Check if a directory path exists

bool IsFileExtension(const char *fileName, const char *ext); // Check file extension (including point: .png, .wav)

int GetFileLength(const char *fileName);                    // Get file length in bytes (NOTE: GetFileSize() conflicts with windows.h)

const char *GetFileExtension(const char *fileName);         // Get pointer to extension for a filename string (includes dot: '.png')

const char *GetFileName(const char *filePath);              // Get pointer to filename for a path string

const char *GetFileNameWithoutExt(const char *filePath);    // Get filename string without extension (uses static string)

const char *GetDirectoryPath(const char *filePath);         // Get full path for a given fileName with path (uses static string)

const char *GetPrevDirectoryPath(const char *dirPath);      // Get previous directory path for a given path (uses static string)

const char *GetWorkingDirectory(void);                      // Get current working directory (uses static string)

const char *GetApplicationDirectory(void);                  // Get the directory of the running application (uses static string)

int MakeDirectory(const char *dirPath);                     // Create directories (including full path requested), returns 0 on success

bool ChangeDirectory(const char *dir);                      // Change working directory, return true on success

bool IsPathFile(const char *path);                          // Check if a given path is a file or a directory

bool IsFileNameValid(const char *fileName);                 // Check if fileName is valid for the platform/OS

FilePathList LoadDirectoryFiles(const char *dirPath);       // Load directory filepaths

FilePathList LoadDirectoryFilesEx(const char *basePath, const char *filter, bool scanSubdirs); // Load directory filepaths with extension filtering and recursive directory scan. Use 'DIR' in the filter string to include directories in the result

void UnloadDirectoryFiles(FilePathList files);              // Unload filepaths

bool IsFileDropped(void);                                   // Check if a file has been dropped into window

FilePathList LoadDroppedFiles(void);                        // Load dropped filepaths

void UnloadDroppedFiles(FilePathList files);                // Unload dropped filepaths

long GetFileModTime(const char *fileName);                  // Get file modification time (last write time)

unsigned char *CompressData(const unsigned char *data, int dataSize, int *compDataSize);        // Compress data (DEFLATE algorithm), memory must be MemFree()

unsigned char *DecompressData(const unsigned char *compData, int compDataSize, int *dataSize);  // Decompress data (DEFLATE algorithm), memory must be MemFree()

char *EncodeDataBase64(const unsigned char *data, int dataSize, int *outputSize);               // Encode data to Base64 string, memory must be MemFree()

unsigned char *DecodeDataBase64(const unsigned char *data, int *outputSize);                    // Decode Base64 string data, memory must be MemFree()

unsigned int ComputeCRC32(unsigned char *data, int dataSize);     // Compute CRC32 hash code

unsigned int *ComputeMD5(unsigned char *data, int dataSize);      // Compute MD5 hash code, returns static int[4] (16 bytes)

unsigned int *ComputeSHA1(unsigned char *data, int dataSize);      // Compute SHA1 hash code, returns static int[5] (20 bytes)

AutomationEventList LoadAutomationEventList(const char *fileName);                // Load automation events list from file, NULL for empty list, capacity = MAX_AUTOMATION_EVENTS

void UnloadAutomationEventList(AutomationEventList list);                         // Unload automation events list from file

bool ExportAutomationEventList(AutomationEventList list, const char *fileName);   // Export automation events list as text file

void SetAutomationEventList(AutomationEventList *list);                           // Set automation event list to record to

void SetAutomationEventBaseFrame(int frame);                                      // Set automation event internal base frame to start recording

void StartAutomationEventRecording(void);                                         // Start recording automation events (AutomationEventList must be set)

void StopAutomationEventRecording(void);                                          // Stop recording automation events

void PlayAutomationEvent(AutomationEvent event);                                  // Play a recorded automation event

bool IsKeyPressed(int key);                             // Check if a key has been pressed once

bool IsKeyPressedRepeat(int key);                       // Check if a key has been pressed again

bool IsKeyDown(int key);                                // Check if a key is being pressed

bool IsKeyReleased(int key);                            // Check if a key has been released once

bool IsKeyUp(int key);                                  // Check if a key is NOT being pressed

int GetKeyPressed(void);                                // Get key pressed (keycode), call it multiple times for keys queued, returns 0 when the queue is empty

int GetCharPressed(void);                               // Get char pressed (unicode), call it multiple times for chars queued, returns 0 when the queue is empty

void SetExitKey(int key);                               // Set a custom key to exit program (default is ESC)

bool IsGamepadAvailable(int gamepad);                                        // Check if a gamepad is available

const char *GetGamepadName(int gamepad);                                     // Get gamepad internal name id

bool IsGamepadButtonPressed(int gamepad, int button);                        // Check if a gamepad button has been pressed once

bool IsGamepadButtonDown(int gamepad, int button);                           // Check if a gamepad button is being pressed

bool IsGamepadButtonReleased(int gamepad, int button);                       // Check if a gamepad button has been released once

bool IsGamepadButtonUp(int gamepad, int button);                             // Check if a gamepad button is NOT being pressed

int GetGamepadButtonPressed(void);                                           // Get the last gamepad button pressed

int GetGamepadAxisCount(int gamepad);                                        // Get gamepad axis count for a gamepad

float GetGamepadAxisMovement(int gamepad, int axis);                         // Get axis movement value for a gamepad axis

int SetGamepadMappings(const char *mappings);                                // Set internal gamepad mappings (SDL_GameControllerDB)

void SetGamepadVibration(int gamepad, float leftMotor, float rightMotor, float duration); // Set gamepad vibration for both motors (duration in seconds)

bool IsMouseButtonPressed(int button);                  // Check if a mouse button has been pressed once

bool IsMouseButtonDown(int button);                     // Check if a mouse button is being pressed

bool IsMouseButtonReleased(int button);                 // Check if a mouse button has been released once

bool IsMouseButtonUp(int button);                       // Check if a mouse button is NOT being pressed

int GetMouseX(void);                                    // Get mouse position X

int GetMouseY(void);                                    // Get mouse position Y

Vector2 GetMousePosition(void);                         // Get mouse position XY

Vector2 GetMouseDelta(void);                            // Get mouse delta between frames

void SetMousePosition(int x, int y);                    // Set mouse position XY

void SetMouseOffset(int offsetX, int offsetY);          // Set mouse offset

void SetMouseScale(float scaleX, float scaleY);         // Set mouse scaling

float GetMouseWheelMove(void);                          // Get mouse wheel movement for X or Y, whichever is larger

Vector2 GetMouseWheelMoveV(void);                       // Get mouse wheel movement for both X and Y

void SetMouseCursor(int cursor);                        // Set mouse cursor

int GetTouchX(void);                                    // Get touch position X for touch point 0 (relative to screen size)

int GetTouchY(void);                                    // Get touch position Y for touch point 0 (relative to screen size)

Vector2 GetTouchPosition(int index);                    // Get touch position XY for a touch point index (relative to screen size)

int GetTouchPointId(int index);                         // Get touch point identifier for given index

int GetTouchPointCount(void);                           // Get number of touch points

void SetGesturesEnabled(unsigned int flags);      // Enable a set of gestures using flags

bool IsGestureDetected(unsigned int gesture);     // Check if a gesture have been detected

int GetGestureDetected(void);                     // Get latest detected gesture

float GetGestureHoldDuration(void);               // Get gesture hold time in seconds

Vector2 GetGestureDragVector(void);               // Get gesture drag vector

float GetGestureDragAngle(void);                  // Get gesture drag angle

Vector2 GetGesturePinchVector(void);              // Get gesture pinch delta

float GetGesturePinchAngle(void);                 // Get gesture pinch angle

void UpdateCamera(Camera *camera, int mode);      // Update camera position for selected mode

void UpdateCameraPro(Camera *camera, Vector3 movement, Vector3 rotation, float zoom); // Update camera movement/rotation

void SetShapesTexture(Texture2D texture, Rectangle source);       // Set texture and rectangle to be used on shapes drawing

Texture2D GetShapesTexture(void);                                 // Get texture that is used for shapes drawing

Rectangle GetShapesTextureRectangle(void);                        // Get texture source rectangle that is used for shapes drawing

void DrawPixel(int posX, int posY, Color color);                                                   // Draw a pixel using geometry [Can be slow, use with care]

void DrawPixelV(Vector2 position, Color color);                                                    // Draw a pixel using geometry (Vector version) [Can be slow, use with care]

void DrawLine(int startPosX, int startPosY, int endPosX, int endPosY, Color color);                // Draw a line

void DrawLineV(Vector2 startPos, Vector2 endPos, Color color);                                     // Draw a line (using gl lines)

void DrawLineEx(Vector2 startPos, Vector2 endPos, float thick, Color color);                       // Draw a line (using triangles/quads)

void DrawLineStrip(const Vector2 *points, int pointCount, Color color);                            // Draw lines sequence (using gl lines)

void DrawLineBezier(Vector2 startPos, Vector2 endPos, float thick, Color color);                   // Draw line segment cubic-bezier in-out interpolation

void DrawCircle(int centerX, int centerY, float radius, Color color);                              // Draw a color-filled circle

void DrawCircleSector(Vector2 center, float radius, float startAngle, float endAngle, int segments, Color color);      // Draw a piece of a circle

void DrawCircleSectorLines(Vector2 center, float radius, float startAngle, float endAngle, int segments, Color color); // Draw circle sector outline

void DrawCircleGradient(int centerX, int centerY, float radius, Color inner, Color outer);         // Draw a gradient-filled circle

void DrawCircleV(Vector2 center, float radius, Color color);                                       // Draw a color-filled circle (Vector version)

void DrawCircleLines(int centerX, int centerY, float radius, Color color);                         // Draw circle outline

void DrawCircleLinesV(Vector2 center, float radius, Color color);                                  // Draw circle outline (Vector version)

void DrawEllipse(int centerX, int centerY, float radiusH, float radiusV, Color color);             // Draw ellipse

void DrawEllipseLines(int centerX, int centerY, float radiusH, float radiusV, Color color);        // Draw ellipse outline

void DrawRing(Vector2 center, float innerRadius, float outerRadius, float startAngle, float endAngle, int segments, Color color); // Draw ring

void DrawRingLines(Vector2 center, float innerRadius, float outerRadius, float startAngle, float endAngle, int segments, Color color);    // Draw ring outline

void DrawRectangle(int posX, int posY, int width, int height, Color color);                        // Draw a color-filled rectangle

void DrawRectangleV(Vector2 position, Vector2 size, Color color);                                  // Draw a color-filled rectangle (Vector version)

void DrawRectangleRec(Rectangle rec, Color color);                                                 // Draw a color-filled rectangle

void DrawRectanglePro(Rectangle rec, Vector2 origin, float rotation, Color color);                 // Draw a color-filled rectangle with pro parameters

void DrawRectangleGradientV(int posX, int posY, int width, int height, Color top, Color bottom);   // Draw a vertical-gradient-filled rectangle

void DrawRectangleGradientH(int posX, int posY, int width, int height, Color left, Color right);   // Draw a horizontal-gradient-filled rectangle

void DrawRectangleGradientEx(Rectangle rec, Color topLeft, Color bottomLeft, Color topRight, Color bottomRight); // Draw a gradient-filled rectangle with custom vertex colors

void DrawRectangleLines(int posX, int posY, int width, int height, Color color);                   // Draw rectangle outline

void DrawRectangleLinesEx(Rectangle rec, float lineThick, Color color);                            // Draw rectangle outline with extended parameters

void DrawRectangleRounded(Rectangle rec, float roundness, int segments, Color color);              // Draw rectangle with rounded edges

void DrawRectangleRoundedLines(Rectangle rec, float roundness, int segments, Color color);         // Draw rectangle lines with rounded edges

void DrawRectangleRoundedLinesEx(Rectangle rec, float roundness, int segments, float lineThick, Color color); // Draw rectangle with rounded edges outline

void DrawTriangle(Vector2 v1, Vector2 v2, Vector2 v3, Color color);                                // Draw a color-filled triangle (vertex in counter-clockwise order!)

void DrawTriangleLines(Vector2 v1, Vector2 v2, Vector2 v3, Color color);                           // Draw triangle outline (vertex in counter-clockwise order!)

void DrawTriangleFan(const Vector2 *points, int pointCount, Color color);                          // Draw a triangle fan defined by points (first vertex is the center)

void DrawTriangleStrip(const Vector2 *points, int pointCount, Color color);                        // Draw a triangle strip defined by points

void DrawPoly(Vector2 center, int sides, float radius, float rotation, Color color);               // Draw a regular polygon (Vector version)

void DrawPolyLines(Vector2 center, int sides, float radius, float rotation, Color color);          // Draw a polygon outline of n sides

void DrawPolyLinesEx(Vector2 center, int sides, float radius, float rotation, float lineThick, Color color); // Draw a polygon outline of n sides with extended parameters

void DrawSplineLinear(const Vector2 *points, int pointCount, float thick, Color color);                  // Draw spline: Linear, minimum 2 points

void DrawSplineBasis(const Vector2 *points, int pointCount, float thick, Color color);                   // Draw spline: B-Spline, minimum 4 points

void DrawSplineCatmullRom(const Vector2 *points, int pointCount, float thick, Color color);              // Draw spline: Catmull-Rom, minimum 4 points

void DrawSplineBezierQuadratic(const Vector2 *points, int pointCount, float thick, Color color);         // Draw spline: Quadratic Bezier, minimum 3 points (1 control point): [p1, c2, p3, c4...]

void DrawSplineBezierCubic(const Vector2 *points, int pointCount, float thick, Color color);             // Draw spline: Cubic Bezier, minimum 4 points (2 control points): [p1, c2, c3, p4, c5, c6...]

void DrawSplineSegmentLinear(Vector2 p1, Vector2 p2, float thick, Color color);                    // Draw spline segment: Linear, 2 points

void DrawSplineSegmentBasis(Vector2 p1, Vector2 p2, Vector2 p3, Vector2 p4, float thick, Color color); // Draw spline segment: B-Spline, 4 points

void DrawSplineSegmentCatmullRom(Vector2 p1, Vector2 p2, Vector2 p3, Vector2 p4, float thick, Color color); // Draw spline segment: Catmull-Rom, 4 points

void DrawSplineSegmentBezierQuadratic(Vector2 p1, Vector2 c2, Vector2 p3, float thick, Color color); // Draw spline segment: Quadratic Bezier, 2 points, 1 control point

void DrawSplineSegmentBezierCubic(Vector2 p1, Vector2 c2, Vector2 c3, Vector2 p4, float thick, Color color); // Draw spline segment: Cubic Bezier, 2 points, 2 control points

Vector2 GetSplinePointLinear(Vector2 startPos, Vector2 endPos, float t);                           // Get (evaluate) spline point: Linear

Vector2 GetSplinePointBasis(Vector2 p1, Vector2 p2, Vector2 p3, Vector2 p4, float t);              // Get (evaluate) spline point: B-Spline

Vector2 GetSplinePointCatmullRom(Vector2 p1, Vector2 p2, Vector2 p3, Vector2 p4, float t);         // Get (evaluate) spline point: Catmull-Rom

Vector2 GetSplinePointBezierQuad(Vector2 p1, Vector2 c2, Vector2 p3, float t);                     // Get (evaluate) spline point: Quadratic Bezier

Vector2 GetSplinePointBezierCubic(Vector2 p1, Vector2 c2, Vector2 c3, Vector2 p4, float t);        // Get (evaluate) spline point: Cubic Bezier

bool CheckCollisionRecs(Rectangle rec1, Rectangle rec2);                                           // Check collision between two rectangles

bool CheckCollisionCircles(Vector2 center1, float radius1, Vector2 center2, float radius2);        // Check collision between two circles

bool CheckCollisionCircleRec(Vector2 center, float radius, Rectangle rec);                         // Check collision between circle and rectangle

bool CheckCollisionCircleLine(Vector2 center, float radius, Vector2 p1, Vector2 p2);               // Check if circle collides with a line created betweeen two points [p1] and [p2]

bool CheckCollisionPointRec(Vector2 point, Rectangle rec);                                         // Check if point is inside rectangle

bool CheckCollisionPointCircle(Vector2 point, Vector2 center, float radius);                       // Check if point is inside circle

bool CheckCollisionPointTriangle(Vector2 point, Vector2 p1, Vector2 p2, Vector2 p3);               // Check if point is inside a triangle

bool CheckCollisionPointLine(Vector2 point, Vector2 p1, Vector2 p2, int threshold);                // Check if point belongs to line created between two points [p1] and [p2] with defined margin in pixels [threshold]

bool CheckCollisionPointPoly(Vector2 point, const Vector2 *points, int pointCount);                // Check if point is within a polygon described by array of vertices

bool CheckCollisionLines(Vector2 startPos1, Vector2 endPos1, Vector2 startPos2, Vector2 endPos2, Vector2 *collisionPoint); // Check the collision between two lines defined by two points each, returns collision point by reference

Rectangle GetCollisionRec(Rectangle rec1, Rectangle rec2);                                         // Get collision rectangle for two rectangles collision

Image LoadImage(const char *fileName);                                                             // Load image from file into CPU memory (RAM)

Image LoadImageRaw(const char *fileName, int width, int height, int format, int headerSize);       // Load image from RAW file data

Image LoadImageAnim(const char *fileName, int *frames);                                            // Load image sequence from file (frames appended to image.data)

Image LoadImageAnimFromMemory(const char *fileType, const unsigned char *fileData, int dataSize, int *frames); // Load image sequence from memory buffer

Image LoadImageFromMemory(const char *fileType, const unsigned char *fileData, int dataSize);      // Load image from memory buffer, fileType refers to extension: i.e. '.png'

Image LoadImageFromTexture(Texture2D texture);                                                     // Load image from GPU texture data

Image LoadImageFromScreen(void);                                                                   // Load image from screen buffer and (screenshot)

bool IsImageValid(Image image);                                                                    // Check if an image is valid (data and parameters)

void UnloadImage(Image image);                                                                     // Unload image from CPU memory (RAM)

bool ExportImage(Image image, const char *fileName);                                               // Export image data to file, returns true on success

unsigned char *ExportImageToMemory(Image image, const char *fileType, int *fileSize);              // Export image to memory buffer

bool ExportImageAsCode(Image image, const char *fileName);                                         // Export image as code file defining an array of bytes, returns true on success

Image GenImageColor(int width, int height, Color color);                                           // Generate image: plain color

Image GenImageGradientLinear(int width, int height, int direction, Color start, Color end);        // Generate image: linear gradient, direction in degrees [0..360], 0=Vertical gradient

Image GenImageGradientRadial(int width, int height, float density, Color inner, Color outer);      // Generate image: radial gradient

Image GenImageGradientSquare(int width, int height, float density, Color inner, Color outer);      // Generate image: square gradient

Image GenImageChecked(int width, int height, int checksX, int checksY, Color col1, Color col2);    // Generate image: checked

Image GenImageWhiteNoise(int width, int height, float factor);                                     // Generate image: white noise

Image GenImagePerlinNoise(int width, int height, int offsetX, int offsetY, float scale);           // Generate image: perlin noise

Image GenImageCellular(int width, int height, int tileSize);                                       // Generate image: cellular algorithm, bigger tileSize means bigger cells

Image GenImageText(int width, int height, const char *text);                                       // Generate image: grayscale image from text data

Image ImageCopy(Image image);                                                                      // Create an image duplicate (useful for transformations)

Image ImageFromImage(Image image, Rectangle rec);                                                  // Create an image from another image piece

Image ImageFromChannel(Image image, int selectedChannel);                                          // Create an image from a selected channel of another image (GRAYSCALE)

Image ImageText(const char *text, int fontSize, Color color);                                      // Create an image from text (default font)

Image ImageTextEx(Font font, const char *text, float fontSize, float spacing, Color tint);         // Create an image from text (custom sprite font)

void ImageFormat(Image *image, int newFormat);                                                     // Convert image data to desired format

void ImageToPOT(Image *image, Color fill);                                                         // Convert image to POT (power-of-two)

void ImageCrop(Image *image, Rectangle crop);                                                      // Crop an image to a defined rectangle

void ImageAlphaCrop(Image *image, float threshold);                                                // Crop image depending on alpha value

void ImageAlphaClear(Image *image, Color color, float threshold);                                  // Clear alpha channel to desired color

void ImageAlphaMask(Image *image, Image alphaMask);                                                // Apply alpha mask to image

void ImageAlphaPremultiply(Image *image);                                                          // Premultiply alpha channel

void ImageBlurGaussian(Image *image, int blurSize);                                                // Apply Gaussian blur using a box blur approximation

void ImageKernelConvolution(Image *image, const float *kernel, int kernelSize);                    // Apply custom square convolution kernel to image

void ImageResize(Image *image, int newWidth, int newHeight);                                       // Resize image (Bicubic scaling algorithm)

void ImageResizeNN(Image *image, int newWidth,int newHeight);                                      // Resize image (Nearest-Neighbor scaling algorithm)

void ImageResizeCanvas(Image *image, int newWidth, int newHeight, int offsetX, int offsetY, Color fill); // Resize canvas and fill with color

void ImageMipmaps(Image *image);                                                                   // Compute all mipmap levels for a provided image

void ImageDither(Image *image, int rBpp, int gBpp, int bBpp, int aBpp);                            // Dither image data to 16bpp or lower (Floyd-Steinberg dithering)

void ImageFlipVertical(Image *image);                                                              // Flip image vertically

void ImageFlipHorizontal(Image *image);                                                            // Flip image horizontally

void ImageRotate(Image *image, int degrees);                                                       // Rotate image by input angle in degrees (-359 to 359)

void ImageRotateCW(Image *image);                                                                  // Rotate image clockwise 90deg

void ImageRotateCCW(Image *image);                                                                 // Rotate image counter-clockwise 90deg

void ImageColorTint(Image *image, Color color);                                                    // Modify image color: tint

void ImageColorInvert(Image *image);                                                               // Modify image color: invert

void ImageColorGrayscale(Image *image);                                                            // Modify image color: grayscale

void ImageColorContrast(Image *image, float contrast);                                             // Modify image color: contrast (-100 to 100)

void ImageColorBrightness(Image *image, int brightness);                                           // Modify image color: brightness (-255 to 255)

void ImageColorReplace(Image *image, Color color, Color replace);                                  // Modify image color: replace color

Color *LoadImageColors(Image image);                                                               // Load color data from image as a Color array (RGBA - 32bit)

Color *LoadImagePalette(Image image, int maxPaletteSize, int *colorCount);                         // Load colors palette from image as a Color array (RGBA - 32bit)

void UnloadImageColors(Color *colors);                                                             // Unload color data loaded with LoadImageColors()

void UnloadImagePalette(Color *colors);                                                            // Unload colors palette loaded with LoadImagePalette()

Rectangle GetImageAlphaBorder(Image image, float threshold);                                       // Get image alpha border rectangle

Color GetImageColor(Image image, int x, int y);                                                    // Get image pixel color at (x, y) position

void ImageClearBackground(Image *dst, Color color);                                                // Clear image background with given color

void ImageDrawPixel(Image *dst, int posX, int posY, Color color);                                  // Draw pixel within an image

void ImageDrawPixelV(Image *dst, Vector2 position, Color color);                                   // Draw pixel within an image (Vector version)

void ImageDrawLine(Image *dst, int startPosX, int startPosY, int endPosX, int endPosY, Color color); // Draw line within an image

void ImageDrawLineV(Image *dst, Vector2 start, Vector2 end, Color color);                          // Draw line within an image (Vector version)

void ImageDrawLineEx(Image *dst, Vector2 start, Vector2 end, int thick, Color color);              // Draw a line defining thickness within an image

void ImageDrawCircle(Image *dst, int centerX, int centerY, int radius, Color color);               // Draw a filled circle within an image

void ImageDrawCircleV(Image *dst, Vector2 center, int radius, Color color);                        // Draw a filled circle within an image (Vector version)

void ImageDrawCircleLines(Image *dst, int centerX, int centerY, int radius, Color color);          // Draw circle outline within an image

void ImageDrawCircleLinesV(Image *dst, Vector2 center, int radius, Color color);                   // Draw circle outline within an image (Vector version)

void ImageDrawRectangle(Image *dst, int posX, int posY, int width, int height, Color color);       // Draw rectangle within an image

void ImageDrawRectangleV(Image *dst, Vector2 position, Vector2 size, Color color);                 // Draw rectangle within an image (Vector version)

void ImageDrawRectangleRec(Image *dst, Rectangle rec, Color color);                                // Draw rectangle within an image

void ImageDrawRectangleLines(Image *dst, Rectangle rec, int thick, Color color);                   // Draw rectangle lines within an image

void ImageDrawTriangle(Image *dst, Vector2 v1, Vector2 v2, Vector2 v3, Color color);               // Draw triangle within an image

void ImageDrawTriangleEx(Image *dst, Vector2 v1, Vector2 v2, Vector2 v3, Color c1, Color c2, Color c3); // Draw triangle with interpolated colors within an image

void ImageDrawTriangleLines(Image *dst, Vector2 v1, Vector2 v2, Vector2 v3, Color color);          // Draw triangle outline within an image

void ImageDrawTriangleFan(Image *dst, Vector2 *points, int pointCount, Color color);               // Draw a triangle fan defined by points within an image (first vertex is the center)

void ImageDrawTriangleStrip(Image *dst, Vector2 *points, int pointCount, Color color);             // Draw a triangle strip defined by points within an image

void ImageDraw(Image *dst, Image src, Rectangle srcRec, Rectangle dstRec, Color tint);             // Draw a source image within a destination image (tint applied to source)

void ImageDrawText(Image *dst, const char *text, int posX, int posY, int fontSize, Color color);   // Draw text (using default font) within an image (destination)

void ImageDrawTextEx(Image *dst, Font font, const char *text, Vector2 position, float fontSize, float spacing, Color tint); // Draw text (custom sprite font) within an image (destination)

Texture2D LoadTexture(const char *fileName);                                                       // Load texture from file into GPU memory (VRAM)

Texture2D LoadTextureFromImage(Image image);                                                       // Load texture from image data

TextureCubemap LoadTextureCubemap(Image image, int layout);                                        // Load cubemap from image, multiple image cubemap layouts supported

RenderTexture2D LoadRenderTexture(int width, int height);                                          // Load texture for rendering (framebuffer)

bool IsTextureValid(Texture2D texture);                                                            // Check if a texture is valid (loaded in GPU)

void UnloadTexture(Texture2D texture);                                                             // Unload texture from GPU memory (VRAM)

bool IsRenderTextureValid(RenderTexture2D target);                                                 // Check if a render texture is valid (loaded in GPU)

void UnloadRenderTexture(RenderTexture2D target);                                                  // Unload render texture from GPU memory (VRAM)

void UpdateTexture(Texture2D texture, const void *pixels);                                         // Update GPU texture with new data

void UpdateTextureRec(Texture2D texture, Rectangle rec, const void *pixels);                       // Update GPU texture rectangle with new data

void GenTextureMipmaps(Texture2D *texture);                                                        // Generate GPU mipmaps for a texture

void SetTextureFilter(Texture2D texture, int filter);                                              // Set texture scaling filter mode

void SetTextureWrap(Texture2D texture, int wrap);                                                  // Set texture wrapping mode

void DrawTexture(Texture2D texture, int posX, int posY, Color tint);                               // Draw a Texture2D

void DrawTextureV(Texture2D texture, Vector2 position, Color tint);                                // Draw a Texture2D with position defined as Vector2

void DrawTextureEx(Texture2D texture, Vector2 position, float rotation, float scale, Color tint);  // Draw a Texture2D with extended parameters

void DrawTextureRec(Texture2D texture, Rectangle source, Vector2 position, Color tint);            // Draw a part of a texture defined by a rectangle

void DrawTexturePro(Texture2D texture, Rectangle source, Rectangle dest, Vector2 origin, float rotation, Color tint); // Draw a part of a texture defined by a rectangle with 'pro' parameters

void DrawTextureNPatch(Texture2D texture, NPatchInfo nPatchInfo, Rectangle dest, Vector2 origin, float rotation, Color tint); // Draws a texture (or part of it) that stretches or shrinks nicely

bool ColorIsEqual(Color col1, Color col2);                            // Check if two colors are equal

Color Fade(Color color, float alpha);                                 // Get color with alpha applied, alpha goes from 0.0f to 1.0f

int ColorToInt(Color color);                                          // Get hexadecimal value for a Color (0xRRGGBBAA)

Vector4 ColorNormalize(Color color);                                  // Get Color normalized as float [0..1]

Color ColorFromNormalized(Vector4 normalized);                        // Get Color from normalized values [0..1]

Vector3 ColorToHSV(Color color);                                      // Get HSV values for a Color, hue [0..360], saturation/value [0..1]

Color ColorFromHSV(float hue, float saturation, float value);         // Get a Color from HSV values, hue [0..360], saturation/value [0..1]

Color ColorTint(Color color, Color tint);                             // Get color multiplied with another color

Color ColorBrightness(Color color, float factor);                     // Get color with brightness correction, brightness factor goes from -1.0f to 1.0f

Color ColorContrast(Color color, float contrast);                     // Get color with contrast correction, contrast values between -1.0f and 1.0f

Color ColorAlpha(Color color, float alpha);                           // Get color with alpha applied, alpha goes from 0.0f to 1.0f

Color ColorAlphaBlend(Color dst, Color src, Color tint);              // Get src alpha-blended into dst color with tint

Color ColorLerp(Color color1, Color color2, float factor);            // Get color lerp interpolation between two colors, factor [0.0f..1.0f]

Color GetColor(unsigned int hexValue);                                // Get Color structure from hexadecimal value

Color GetPixelColor(void *srcPtr, int format);                        // Get Color from a source pixel pointer of certain format

void SetPixelColor(void *dstPtr, Color color, int format);            // Set color formatted into destination pixel pointer

int GetPixelDataSize(int width, int height, int format);              // Get pixel data size in bytes for certain format

Font GetFontDefault(void);                                                            // Get the default Font

Font LoadFont(const char *fileName);                                                  // Load font from file into GPU memory (VRAM)

Font LoadFontEx(const char *fileName, int fontSize, int *codepoints, int codepointCount); // Load font from file with extended parameters, use NULL for codepoints and 0 for codepointCount to load the default character set, font size is provided in pixels height

Font LoadFontFromImage(Image image, Color key, int firstChar);                        // Load font from Image (XNA style)

Font LoadFontFromMemory(const char *fileType, const unsigned char *fileData, int dataSize, int fontSize, int *codepoints, int codepointCount); // Load font from memory buffer, fileType refers to extension: i.e. '.ttf'

bool IsFontValid(Font font);                                                          // Check if a font is valid (font data loaded, WARNING: GPU texture not checked)

GlyphInfo *LoadFontData(const unsigned char *fileData, int dataSize, int fontSize, int *codepoints, int codepointCount, int type); // Load font data for further use

Image GenImageFontAtlas(const GlyphInfo *glyphs, Rectangle **glyphRecs, int glyphCount, int fontSize, int padding, int packMethod); // Generate image font atlas using chars info

void UnloadFontData(GlyphInfo *glyphs, int glyphCount);                               // Unload font chars info data (RAM)

void UnloadFont(Font font);                                                           // Unload font from GPU memory (VRAM)

bool ExportFontAsCode(Font font, const char *fileName);                               // Export font as code file, returns true on success

void DrawFPS(int posX, int posY);                                                     // Draw current FPS

void DrawText(const char *text, int posX, int posY, int fontSize, Color color);       // Draw text (using default font)

void DrawTextEx(Font font, const char *text, Vector2 position, float fontSize, float spacing, Color tint); // Draw text using font and additional parameters

void DrawTextPro(Font font, const char *text, Vector2 position, Vector2 origin, float rotation, float fontSize, float spacing, Color tint); // Draw text using Font and pro parameters (rotation)

void DrawTextCodepoint(Font font, int codepoint, Vector2 position, float fontSize, Color tint); // Draw one character (codepoint)

void DrawTextCodepoints(Font font, const int *codepoints, int codepointCount, Vector2 position, float fontSize, float spacing, Color tint); // Draw multiple character (codepoint)

void SetTextLineSpacing(int spacing);                                                 // Set vertical line spacing when drawing with line-breaks

int MeasureText(const char *text, int fontSize);                                      // Measure string width for default font

Vector2 MeasureTextEx(Font font, const char *text, float fontSize, float spacing);    // Measure string size for Font

int GetGlyphIndex(Font font, int codepoint);                                          // Get glyph index position in font for a codepoint (unicode character), fallback to '?' if not found

GlyphInfo GetGlyphInfo(Font font, int codepoint);                                     // Get glyph font info data for a codepoint (unicode character), fallback to '?' if not found

Rectangle GetGlyphAtlasRec(Font font, int codepoint);                                 // Get glyph rectangle in font atlas for a codepoint (unicode character), fallback to '?' if not found

char *LoadUTF8(const int *codepoints, int length);                // Load UTF-8 text encoded from codepoints array

void UnloadUTF8(char *text);                                      // Unload UTF-8 text encoded from codepoints array

int *LoadCodepoints(const char *text, int *count);                // Load all codepoints from a UTF-8 text string, codepoints count returned by parameter

void UnloadCodepoints(int *codepoints);                           // Unload codepoints data from memory

int GetCodepointCount(const char *text);                          // Get total number of codepoints in a UTF-8 encoded string

int GetCodepoint(const char *text, int *codepointSize);           // Get next codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure

int GetCodepointNext(const char *text, int *codepointSize);       // Get next codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure

int GetCodepointPrevious(const char *text, int *codepointSize);   // Get previous codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure

const char *CodepointToUTF8(int codepoint, int *utf8Size);        // Encode one codepoint into UTF-8 byte array (array length returned as parameter)

int TextCopy(char *dst, const char *src);                                             // Copy one string to another, returns bytes copied

bool TextIsEqual(const char *text1, const char *text2);                               // Check if two text string are equal

unsigned int TextLength(const char *text);                                            // Get text length, checks for '\0' ending

const char *TextFormat(const char *text, ...);                                        // Text formatting with variables (sprintf() style)

const char *TextSubtext(const char *text, int position, int length);                  // Get a piece of a text string

char *TextReplace(const char *text, const char *replace, const char *by);             // Replace text string (WARNING: memory must be freed!)

char *TextInsert(const char *text, const char *insert, int position);                 // Insert text in a position (WARNING: memory must be freed!)

const char *TextJoin(const char **textList, int count, const char *delimiter);        // Join text strings with delimiter

const char **TextSplit(const char *text, char delimiter, int *count);                 // Split text into multiple strings

void TextAppend(char *text, const char *append, int *position);                       // Append text at specific position and move cursor!

int TextFindIndex(const char *text, const char *find);                                // Find first text occurrence within a string

const char *TextToUpper(const char *text);                      // Get upper case version of provided string

const char *TextToLower(const char *text);                      // Get lower case version of provided string

const char *TextToPascal(const char *text);                     // Get Pascal case notation version of provided string

const char *TextToSnake(const char *text);                      // Get Snake case notation version of provided string

const char *TextToCamel(const char *text);                      // Get Camel case notation version of provided string

int TextToInteger(const char *text);                            // Get integer value from text (negative values not supported)

float TextToFloat(const char *text);                            // Get float value from text (negative values not supported)

void DrawLine3D(Vector3 startPos, Vector3 endPos, Color color);                                    // Draw a line in 3D world space

void DrawPoint3D(Vector3 position, Color color);                                                   // Draw a point in 3D space, actually a small line

void DrawCircle3D(Vector3 center, float radius, Vector3 rotationAxis, float rotationAngle, Color color); // Draw a circle in 3D world space

void DrawTriangle3D(Vector3 v1, Vector3 v2, Vector3 v3, Color color);                              // Draw a color-filled triangle (vertex in counter-clockwise order!)

void DrawTriangleStrip3D(const Vector3 *points, int pointCount, Color color);                      // Draw a triangle strip defined by points

void DrawCube(Vector3 position, float width, float height, float length, Color color);             // Draw cube

void DrawCubeV(Vector3 position, Vector3 size, Color color);                                       // Draw cube (Vector version)

void DrawCubeWires(Vector3 position, float width, float height, float length, Color color);        // Draw cube wires

void DrawCubeWiresV(Vector3 position, Vector3 size, Color color);                                  // Draw cube wires (Vector version)

void DrawSphere(Vector3 centerPos, float radius, Color color);                                     // Draw sphere

void DrawSphereEx(Vector3 centerPos, float radius, int rings, int slices, Color color);            // Draw sphere with extended parameters

void DrawSphereWires(Vector3 centerPos, float radius, int rings, int slices, Color color);         // Draw sphere wires

void DrawCylinder(Vector3 position, float radiusTop, float radiusBottom, float height, int slices, Color color); // Draw a cylinder/cone

void DrawCylinderEx(Vector3 startPos, Vector3 endPos, float startRadius, float endRadius, int sides, Color color); // Draw a cylinder with base at startPos and top at endPos

void DrawCylinderWires(Vector3 position, float radiusTop, float radiusBottom, float height, int slices, Color color); // Draw a cylinder/cone wires

void DrawCylinderWiresEx(Vector3 startPos, Vector3 endPos, float startRadius, float endRadius, int sides, Color color); // Draw a cylinder wires with base at startPos and top at endPos

void DrawCapsule(Vector3 startPos, Vector3 endPos, float radius, int slices, int rings, Color color); // Draw a capsule with the center of its sphere caps at startPos and endPos

void DrawCapsuleWires(Vector3 startPos, Vector3 endPos, float radius, int slices, int rings, Color color); // Draw capsule wireframe with the center of its sphere caps at startPos and endPos

void DrawPlane(Vector3 centerPos, Vector2 size, Color color);                                      // Draw a plane XZ

void DrawRay(Ray ray, Color color);                                                                // Draw a ray line

void DrawGrid(int slices, float spacing);                                                          // Draw a grid (centered at (0, 0, 0))

Model LoadModel(const char *fileName);                                                // Load model from files (meshes and materials)

Model LoadModelFromMesh(Mesh mesh);                                                   // Load model from generated mesh (default material)

bool IsModelValid(Model model);                                                       // Check if a model is valid (loaded in GPU, VAO/VBOs)

void UnloadModel(Model model);                                                        // Unload model (including meshes) from memory (RAM and/or VRAM)

BoundingBox GetModelBoundingBox(Model model);                                         // Compute model bounding box limits (considers all meshes)

void DrawModel(Model model, Vector3 position, float scale, Color tint);               // Draw a model (with texture if set)

void DrawModelEx(Model model, Vector3 position, Vector3 rotationAxis, float rotationAngle, Vector3 scale, Color tint); // Draw a model with extended parameters

void DrawModelWires(Model model, Vector3 position, float scale, Color tint);          // Draw a model wires (with texture if set)

void DrawModelWiresEx(Model model, Vector3 position, Vector3 rotationAxis, float rotationAngle, Vector3 scale, Color tint); // Draw a model wires (with texture if set) with extended parameters

void DrawModelPoints(Model model, Vector3 position, float scale, Color tint); // Draw a model as points

void DrawModelPointsEx(Model model, Vector3 position, Vector3 rotationAxis, float rotationAngle, Vector3 scale, Color tint); // Draw a model as points with extended parameters

void DrawBoundingBox(BoundingBox box, Color color);                                   // Draw bounding box (wires)

void DrawBillboard(Camera camera, Texture2D texture, Vector3 position, float scale, Color tint);   // Draw a billboard texture

void DrawBillboardRec(Camera camera, Texture2D texture, Rectangle source, Vector3 position, Vector2 size, Color tint); // Draw a billboard texture defined by source

void DrawBillboardPro(Camera camera, Texture2D texture, Rectangle source, Vector3 position, Vector3 up, Vector2 size, Vector2 origin, float rotation, Color tint); // Draw a billboard texture defined by source and rotation

void UploadMesh(Mesh *mesh, bool dynamic);                                            // Upload mesh vertex data in GPU and provide VAO/VBO ids

void UpdateMeshBuffer(Mesh mesh, int index, const void *data, int dataSize, int offset); // Update mesh vertex data in GPU for a specific buffer index

void UnloadMesh(Mesh mesh);                                                           // Unload mesh data from CPU and GPU

void DrawMesh(Mesh mesh, Material material, Matrix transform);                        // Draw a 3d mesh with material and transform

void DrawMeshInstanced(Mesh mesh, Material material, const Matrix *transforms, int instances); // Draw multiple mesh instances with material and different transforms

BoundingBox GetMeshBoundingBox(Mesh mesh);                                            // Compute mesh bounding box limits

void GenMeshTangents(Mesh *mesh);                                                     // Compute mesh tangents

bool ExportMesh(Mesh mesh, const char *fileName);                                     // Export mesh data to file, returns true on success

bool ExportMeshAsCode(Mesh mesh, const char *fileName);                               // Export mesh as code file (.h) defining multiple arrays of vertex attributes

Mesh GenMeshPoly(int sides, float radius);                                            // Generate polygonal mesh

Mesh GenMeshPlane(float width, float length, int resX, int resZ);                     // Generate plane mesh (with subdivisions)

Mesh GenMeshCube(float width, float height, float length);                            // Generate cuboid mesh

Mesh GenMeshSphere(float radius, int rings, int slices);                              // Generate sphere mesh (standard sphere)

Mesh GenMeshHemiSphere(float radius, int rings, int slices);                          // Generate half-sphere mesh (no bottom cap)

Mesh GenMeshCylinder(float radius, float height, int slices);                         // Generate cylinder mesh

Mesh GenMeshCone(float radius, float height, int slices);                             // Generate cone/pyramid mesh

Mesh GenMeshTorus(float radius, float size, int radSeg, int sides);                   // Generate torus mesh

Mesh GenMeshKnot(float radius, float size, int radSeg, int sides);                    // Generate trefoil knot mesh

Mesh GenMeshHeightmap(Image heightmap, Vector3 size);                                 // Generate heightmap mesh from image data

Mesh GenMeshCubicmap(Image cubicmap, Vector3 cubeSize);                               // Generate cubes-based map mesh from image data

Material *LoadMaterials(const char *fileName, int *materialCount);                    // Load materials from model file

Material LoadMaterialDefault(void);                                                   // Load default material (Supports: DIFFUSE, SPECULAR, NORMAL maps)

bool IsMaterialValid(Material material);                                              // Check if a material is valid (shader assigned, map textures loaded in GPU)

void UnloadMaterial(Material material);                                               // Unload material from GPU memory (VRAM)

void SetMaterialTexture(Material *material, int mapType, Texture2D texture);          // Set texture for a material map type (MATERIAL_MAP_DIFFUSE, MATERIAL_MAP_SPECULAR...)

void SetModelMeshMaterial(Model *model, int meshId, int materialId);                  // Set material for a mesh

ModelAnimation *LoadModelAnimations(const char *fileName, int *animCount);            // Load model animations from file

void UpdateModelAnimation(Model model, ModelAnimation anim, int frame);               // Update model animation pose (CPU)

void UpdateModelAnimationBones(Model model, ModelAnimation anim, int frame);          // Update model animation mesh bone matrices (GPU skinning)

void UnloadModelAnimation(ModelAnimation anim);                                       // Unload animation data

void UnloadModelAnimations(ModelAnimation *animations, int animCount);                // Unload animation array data

bool IsModelAnimationValid(Model model, ModelAnimation anim);                         // Check model animation skeleton match

bool CheckCollisionSpheres(Vector3 center1, float radius1, Vector3 center2, float radius2);   // Check collision between two spheres

bool CheckCollisionBoxes(BoundingBox box1, BoundingBox box2);                                 // Check collision between two bounding boxes

bool CheckCollisionBoxSphere(BoundingBox box, Vector3 center, float radius);                  // Check collision between box and sphere

RayCollision GetRayCollisionSphere(Ray ray, Vector3 center, float radius);                    // Get collision info between ray and sphere

RayCollision GetRayCollisionBox(Ray ray, BoundingBox box);                                    // Get collision info between ray and box

RayCollision GetRayCollisionMesh(Ray ray, Mesh mesh, Matrix transform);                       // Get collision info between ray and mesh

RayCollision GetRayCollisionTriangle(Ray ray, Vector3 p1, Vector3 p2, Vector3 p3);            // Get collision info between ray and triangle

RayCollision GetRayCollisionQuad(Ray ray, Vector3 p1, Vector3 p2, Vector3 p3, Vector3 p4);    // Get collision info between ray and quad

void InitAudioDevice(void);                                     // Initialize audio device and context

void CloseAudioDevice(void);                                    // Close the audio device and context

bool IsAudioDeviceReady(void);                                  // Check if audio device has been initialized successfully

void SetMasterVolume(float volume);                             // Set master volume (listener)

float GetMasterVolume(void);                                    // Get master volume (listener)

Wave LoadWave(const char *fileName);                            // Load wave data from file

Wave LoadWaveFromMemory(const char *fileType, const unsigned char *fileData, int dataSize); // Load wave from memory buffer, fileType refers to extension: i.e. '.wav'

bool IsWaveValid(Wave wave);                                    // Checks if wave data is valid (data loaded and parameters)

Sound LoadSound(const char *fileName);                          // Load sound from file

Sound LoadSoundFromWave(Wave wave);                             // Load sound from wave data

Sound LoadSoundAlias(Sound source);                             // Create a new sound that shares the same sample data as the source sound, does not own the sound data

bool IsSoundValid(Sound sound);                                 // Checks if a sound is valid (data loaded and buffers initialized)

void UpdateSound(Sound sound, const void *data, int sampleCount); // Update sound buffer with new data

void UnloadWave(Wave wave);                                     // Unload wave data

void UnloadSound(Sound sound);                                  // Unload sound

void UnloadSoundAlias(Sound alias);                             // Unload a sound alias (does not deallocate sample data)

bool ExportWave(Wave wave, const char *fileName);               // Export wave data to file, returns true on success

bool ExportWaveAsCode(Wave wave, const char *fileName);         // Export wave sample data to code (.h), returns true on success

void PlaySound(Sound sound);                                    // Play a sound

void StopSound(Sound sound);                                    // Stop playing a sound

void PauseSound(Sound sound);                                   // Pause a sound

void ResumeSound(Sound sound);                                  // Resume a paused sound

bool IsSoundPlaying(Sound sound);                               // Check if a sound is currently playing

void SetSoundVolume(Sound sound, float volume);                 // Set volume for a sound (1.0 is max level)

void SetSoundPitch(Sound sound, float pitch);                   // Set pitch for a sound (1.0 is base level)

void SetSoundPan(Sound sound, float pan);                       // Set pan for a sound (0.5 is center)

Wave WaveCopy(Wave wave);                                       // Copy a wave to a new wave

void WaveCrop(Wave *wave, int initFrame, int finalFrame);       // Crop a wave to defined frames range

void WaveFormat(Wave *wave, int sampleRate, int sampleSize, int channels); // Convert wave data to desired format

float *LoadWaveSamples(Wave wave);                              // Load samples data from wave as a 32bit float data array

void UnloadWaveSamples(float *samples);                         // Unload samples data loaded with LoadWaveSamples()

Music LoadMusicStream(const char *fileName);                    // Load music stream from file

Music LoadMusicStreamFromMemory(const char *fileType, const unsigned char *data, int dataSize); // Load music stream from data

bool IsMusicValid(Music music);                                 // Checks if a music stream is valid (context and buffers initialized)

void UnloadMusicStream(Music music);                            // Unload music stream

void PlayMusicStream(Music music);                              // Start music playing

bool IsMusicStreamPlaying(Music music);                         // Check if music is playing

void UpdateMusicStream(Music music);                            // Updates buffers for music streaming

void StopMusicStream(Music music);                              // Stop music playing

void PauseMusicStream(Music music);                             // Pause music playing

void ResumeMusicStream(Music music);                            // Resume playing paused music

void SeekMusicStream(Music music, float position);              // Seek music to a position (in seconds)

void SetMusicVolume(Music music, float volume);                 // Set volume for music (1.0 is max level)

void SetMusicPitch(Music music, float pitch);                   // Set pitch for a music (1.0 is base level)

void SetMusicPan(Music music, float pan);                       // Set pan for a music (0.5 is center)

float GetMusicTimeLength(Music music);                          // Get music time length (in seconds)

float GetMusicTimePlayed(Music music);                          // Get current music time played (in seconds)

AudioStream LoadAudioStream(unsigned int sampleRate, unsigned int sampleSize, unsigned int channels); // Load audio stream (to stream raw audio pcm data)

bool IsAudioStreamValid(AudioStream stream);                    // Checks if an audio stream is valid (buffers initialized)

void UnloadAudioStream(AudioStream stream);                     // Unload audio stream and free memory

void UpdateAudioStream(AudioStream stream, const void *data, int frameCount); // Update audio stream buffers with data

bool IsAudioStreamProcessed(AudioStream stream);                // Check if any audio stream buffers requires refill

void PlayAudioStream(AudioStream stream);                       // Play audio stream

void PauseAudioStream(AudioStream stream);                      // Pause audio stream

void ResumeAudioStream(AudioStream stream);                     // Resume audio stream

bool IsAudioStreamPlaying(AudioStream stream);                  // Check if audio stream is playing

void StopAudioStream(AudioStream stream);                       // Stop audio stream

void SetAudioStreamVolume(AudioStream stream, float volume);    // Set volume for audio stream (1.0 is max level)

void SetAudioStreamPitch(AudioStream stream, float pitch);      // Set pitch for audio stream (1.0 is base level)

void SetAudioStreamPan(AudioStream stream, float pan);          // Set pan for audio stream (0.5 is centered)

void SetAudioStreamBufferSizeDefault(int size);                 // Default size for new audio streams

void SetAudioStreamCallback(AudioStream stream, AudioCallback callback); // Audio thread callback to request new data

void AttachAudioStreamProcessor(AudioStream stream, AudioCallback processor); // Attach audio stream processor to stream, receives the samples as 'float'

void DetachAudioStreamProcessor(AudioStream stream, AudioCallback processor); // Detach audio stream processor from stream

void AttachAudioMixedProcessor(AudioCallback processor); // Attach audio stream processor to the entire audio pipeline, receives the samples as 'float'

void DetachAudioMixedProcessor(AudioCallback processor); // Detach audio stream processor from the entire audio pipeline

")

; CONSTRUCTS BLOCK
; Function specifiers in case library is build/used as a shared library
; NOTE: Microsoft specifiers to tell compiler that symbols are imported/exported from a .dll
; NOTE: visibility("default") attribute makes symbols "visible" when compiled with -fvisibility=hidden
;----------------------------------------------------------------------------------
; Some basic Defines
;----------------------------------------------------------------------------------
; Allow custom memory allocators
; NOTE: Require recompiling raylib sources
; NOTE: MSVC C++ compiler does not support compound literals (C99 feature)
; Plain structures in C++ (without constructors) can be initialized with { }
; This is called aggregate initialization (C++11 feature)
; Some compilers (mostly macos clang) default to C++98,
; where aggregate initialization can't be used
; So, give a more clear error stating how to fix this
; NOTE: We set some defines with some data types declared by raylib
; Other modules (raymath, rlgl) also require some of those types, so,
; to be able to use those other modules as standalone (not depending on raylib)
; this defines are very useful for internal check and avoid type (re)definitions
; Some Basic Colors
; NOTE: Custom raylib color palette for amazing visuals on WHITE background
;----------------------------------------------------------------------------------
; Structures Definition
;----------------------------------------------------------------------------------
; Boolean type
; Vector2, 2 components
(fn Vector2 [x y] (ffi.new :Vector2 [x y]))
; Vector3, 3 components
(fn Vector3 [x y z] (ffi.new :Vector3 [x y z]))
; Vector4, 4 components
(fn Vector4 [x y z w] (ffi.new :Vector4 [x y z w]))
; Quaternion, 4 components (Vector4 alias)
(fn Quaternion [x y z w] (ffi.new :Quaternion [x y z w])); Matrix, 4x4 components, column major, OpenGL style, right-handed
(fn Matrix [m0 m4 m8 m12 m1 m5 m9 m13 m2 m6 m10 m14 m3 m7 m11 m15] (ffi.new :Matrix [m0 m4 m8 m12 m1 m5 m9 m13 m2 m6 m10 m14 m3 m7 m11 m15]))
; Color, 4 components, R8G8B8A8 (32bit)
(fn Color [r g b a] (ffi.new :Color [r g b a]))
; Rectangle, 4 components
(fn Rectangle [x y width height] (ffi.new :Rectangle [x y width height]))
; Image, pixel data stored in CPU memory (RAM)
(fn Image [data width height mipmaps format] (ffi.new :Image [data width height mipmaps format]))
; Texture, tex data stored in GPU memory (VRAM)
(fn Texture [id width height mipmaps format] (ffi.new :Texture [id width height mipmaps format]))
; Texture2D, same as Texture
(fn Texture2D [id width height mipmaps format] (ffi.new :Texture2D [id width height mipmaps format])); TextureCubemap, same as Texture
(fn TextureCubemap [id width height mipmaps format] (ffi.new :TextureCubemap [id width height mipmaps format])); RenderTexture, fbo for texture rendering
(fn RenderTexture [id texture depth] (ffi.new :RenderTexture [id texture depth]))
; RenderTexture2D, same as RenderTexture
(fn RenderTexture2D [id texture depth] (ffi.new :RenderTexture2D [id texture depth])); NPatchInfo, n-patch layout info
(fn NPatchInfo [source left top right bottom layout] (ffi.new :NPatchInfo [source left top right bottom layout]))
; GlyphInfo, font characters glyphs info
(fn GlyphInfo [value offset-x offset-y advance-x image] (ffi.new :GlyphInfo [value offset-x offset-y advance-x image]))
; Font, font texture and GlyphInfo array data
(fn Font [base-size glyph-count glyph-padding texture recs glyphs] (ffi.new :Font [base-size glyph-count glyph-padding texture recs glyphs]))
; Camera, defines position/orientation in 3d space
(fn Camera3D [position target up fovy projection] (ffi.new :Camera3D [position target up fovy projection]))
(fn Camera [position target up fovy projection] (ffi.new :Camera [position target up fovy projection])); Camera2D, defines position/orientation in 2d space
(fn Camera2D [offset target rotation zoom] (ffi.new :Camera2D [offset target rotation zoom]))
; Mesh, vertex data and vao/vbo
(fn Mesh [vertex-count triangle-count vertices texcoords texcoords2 normals tangents colors indices anim-vertices anim-normals char-bone-ids bone-weights bone-matrices bone-count vao-id vbo-id] (ffi.new :Mesh [vertex-count triangle-count vertices texcoords texcoords2 normals tangents colors indices anim-vertices anim-normals char-bone-ids bone-weights bone-matrices bone-count vao-id vbo-id]))
; Shader
(fn Shader [id locs] (ffi.new :Shader [id locs]))
; MaterialMap
(fn MaterialMap [texture color value] (ffi.new :MaterialMap [texture color value]))
; Material, includes shader and maps
(fn Material [shader maps params] (ffi.new :Material [shader maps params]))
; Transform, vertex transformation data
(fn Transform [translation rotation scale] (ffi.new :Transform [translation rotation scale]))
; Bone, skeletal animation bone
(fn BoneInfo [name parent] (ffi.new :BoneInfo [name parent]))
; Model, meshes, materials and animation data
(fn Model [transform mesh-count material-count meshes materials mesh-material bone-count bones bind-pose] (ffi.new :Model [transform mesh-count material-count meshes materials mesh-material bone-count bones bind-pose]))
; ModelAnimation
(fn ModelAnimation [bone-count frame-count bones frame-poses name] (ffi.new :ModelAnimation [bone-count frame-count bones frame-poses name]))
; Ray, ray for raycasting
(fn Ray [position direction] (ffi.new :Ray [position direction]))
; RayCollision, ray hit information
(fn RayCollision [hit distance point normal] (ffi.new :RayCollision [hit distance point normal]))
; BoundingBox
(fn BoundingBox [min max] (ffi.new :BoundingBox [min max]))
; Wave, audio wave data
(fn Wave [frame-count sample-rate int-sample-size int-channels data] (ffi.new :Wave [frame-count sample-rate int-sample-size int-channels data]))
; Opaque structs declaration
; NOTE: Actual structs are defined internally in raudio module
; AudioStream, custom audio stream
(fn AudioStream [buffer processor sample-rate int-sample-size int-channels] (ffi.new :AudioStream [buffer processor sample-rate int-sample-size int-channels]))
; Sound
(fn Sound [stream frame-count] (ffi.new :Sound [stream frame-count]))
; Music, audio stream, anything longer than ~10 seconds should be streamed
(fn Music [stream frame-count looping ctx-type ctx-data] (ffi.new :Music [stream frame-count looping ctx-type ctx-data]))
; VrDeviceInfo, Head-Mounted-Display device parameters
(fn VrDeviceInfo [h-resolution v-resolution h-screen-size v-screen-size eye-to-screen-distance lens-separation-distance interpupillary-distance lens-distortion-values chroma-ab-correction] (ffi.new :VrDeviceInfo [h-resolution v-resolution h-screen-size v-screen-size eye-to-screen-distance lens-separation-distance interpupillary-distance lens-distortion-values chroma-ab-correction]))
; VrStereoConfig, VR stereo rendering configuration for simulator
(fn VrStereoConfig [projection view-offset left-lens-center right-lens-center left-screen-center right-screen-center scale scale-in] (ffi.new :VrStereoConfig [projection view-offset left-lens-center right-lens-center left-screen-center right-screen-center scale scale-in]))
; File path list
(fn FilePathList [capacity count paths] (ffi.new :FilePathList [capacity count paths]))
; Automation event
(fn AutomationEvent [frame type params] (ffi.new :AutomationEvent [frame type params]))
; Automation event list
(fn AutomationEventList [capacity count events] (ffi.new :AutomationEventList [capacity count events]))


; ENUMS BLOCK
;----------------------------------------------------------------------------------
; Enumerators Definition
;----------------------------------------------------------------------------------
; System/Window config flags
; NOTE: Every bit registers one state (use it with bit masks)
; By default all flags are set to 0
(local flag-vsync-hint 64)
(local flag-fullscreen-mode 2)
(local flag-window-resizable 4)
(local flag-window-undecorated 8)
(local flag-window-hidden 128)
(local flag-window-minimized 512)
(local flag-window-maximized 1024)
(local flag-window-unfocused 2048)
(local flag-window-topmost 4096)
(local flag-window-always-run 256)
(local flag-window-transparent 16)
(local flag-window-highdpi 8192)
(local flag-window-mouse-passthrough 16384)
(local flag-borderless-windowed-mode 32768)
(local flag-msaa-4x-hint 32)
(local flag-interlaced-hint 65536)
; Trace log level
; NOTE: Organized by priority level
(local log-all 0)
(local log-trace 1)
(local log-debug 2)
(local log-info 3)
(local log-warning 4)
(local log-error 5)
(local log-fatal 6)
(local log-none 7)
; Keyboard keys (US keyboard layout)
; NOTE: Use GetKeyPressed() to allow redefining
; required keys for alternative layouts
(local key-null 0)
(local key-apostrophe 39)
(local key-comma 44)
(local key-minus 45)
(local key-period 46)
(local key-slash 47)
(local key-zero 48)
(local key-one 49)
(local key-two 50)
(local key-three 51)
(local key-four 52)
(local key-five 53)
(local key-six 54)
(local key-seven 55)
(local key-eight 56)
(local key-nine 57)
(local key-semicolon 59)
(local key-equal 61)
(local key-a 65)
(local key-b 66)
(local key-c 67)
(local key-d 68)
(local key-e 69)
(local key-f 70)
(local key-g 71)
(local key-h 72)
(local key-i 73)
(local key-j 74)
(local key-k 75)
(local key-l 76)
(local key-m 77)
(local key-n 78)
(local key-o 79)
(local key-p 80)
(local key-q 81)
(local key-r 82)
(local key-s 83)
(local key-t 84)
(local key-u 85)
(local key-v 86)
(local key-w 87)
(local key-x 88)
(local key-y 89)
(local key-z 90)
(local key-left-bracket 91)
(local key-backslash 92)
(local key-right-bracket 93)
(local key-grave 96)
(local key-space 32)
(local key-escape 256)
(local key-enter 257)
(local key-tab 258)
(local key-backspace 259)
(local key-insert 260)
(local key-delete 261)
(local key-right 262)
(local key-left 263)
(local key-down 264)
(local key-up 265)
(local key-page-up 266)
(local key-page-down 267)
(local key-home 268)
(local key-end 269)
(local key-caps-lock 280)
(local key-scroll-lock 281)
(local key-num-lock 282)
(local key-print-screen 283)
(local key-pause 284)
(local key-f1 290)
(local key-f2 291)
(local key-f3 292)
(local key-f4 293)
(local key-f5 294)
(local key-f6 295)
(local key-f7 296)
(local key-f8 297)
(local key-f9 298)
(local key-f10 299)
(local key-f11 300)
(local key-f12 301)
(local key-left-shift 340)
(local key-left-control 341)
(local key-left-alt 342)
(local key-left-super 343)
(local key-right-shift 344)
(local key-right-control 345)
(local key-right-alt 346)
(local key-right-super 347)
(local key-kb-menu 348)
(local key-kp-0 320)
(local key-kp-1 321)
(local key-kp-2 322)
(local key-kp-3 323)
(local key-kp-4 324)
(local key-kp-5 325)
(local key-kp-6 326)
(local key-kp-7 327)
(local key-kp-8 328)
(local key-kp-9 329)
(local key-kp-decimal 330)
(local key-kp-divide 331)
(local key-kp-multiply 332)
(local key-kp-subtract 333)
(local key-kp-add 334)
(local key-kp-enter 335)
(local key-kp-equal 336)
(local key-back 4)
(local key-menu 5)
(local key-volume-up 24)
(local key-volume-down 25)
; Add backwards compatibility support for deprecated names
; Mouse buttons
(local mouse-button-left 0)
(local mouse-button-right 1)
(local mouse-button-middle 2)
(local mouse-button-side 3)
(local mouse-button-extra 4)
(local mouse-button-forward 5)
(local mouse-button-back 6)
; Mouse cursor
(local mouse-cursor-default 0)
(local mouse-cursor-arrow 1)
(local mouse-cursor-ibeam 2)
(local mouse-cursor-crosshair 3)
(local mouse-cursor-pointing-hand 4)
(local mouse-cursor-resize-ew 5)
(local mouse-cursor-resize-ns 6)
(local mouse-cursor-resize-nwse 7)
(local mouse-cursor-resize-nesw 8)
(local mouse-cursor-resize-all 9)
(local mouse-cursor-not-allowed 10)
; Gamepad buttons
(local gamepad-button-unknown 0)
(local gamepad-button-left-face-up 1)
(local gamepad-button-left-face-right 2)
(local gamepad-button-left-face-down 3)
(local gamepad-button-left-face-left 4)
(local gamepad-button-right-face-up 5)
(local gamepad-button-right-face-right 6)
(local gamepad-button-right-face-down 7)
(local gamepad-button-right-face-left 8)
(local gamepad-button-left-trigger-1 9)
(local gamepad-button-left-trigger-2 10)
(local gamepad-button-right-trigger-1 11)
(local gamepad-button-right-trigger-2 12)
(local gamepad-button-middle-left 13)
(local gamepad-button-middle 14)
(local gamepad-button-middle-right 15)
(local gamepad-button-left-thumb 16)
(local gamepad-button-right-thumb 17)
; Gamepad axis
(local gamepad-axis-left-x 0)
(local gamepad-axis-left-y 1)
(local gamepad-axis-right-x 2)
(local gamepad-axis-right-y 3)
(local gamepad-axis-left-trigger 4)
(local gamepad-axis-right-trigger 5)
; Material map index
(local material-map-albedo 0)
(local material-map-metalness 1)
(local material-map-normal 2)
(local material-map-roughness 3)
(local material-map-occlusion 4)
(local material-map-emission 5)
(local material-map-height 6)
(local material-map-cubemap 7)
(local material-map-irradiance 8)
(local material-map-prefilter 9)
(local material-map-brdf 10)
; Shader location index
(local shader-loc-vertex-position 0)
(local shader-loc-vertex-texcoord01 1)
(local shader-loc-vertex-texcoord02 2)
(local shader-loc-vertex-normal 3)
(local shader-loc-vertex-tangent 4)
(local shader-loc-vertex-color 5)
(local shader-loc-matrix-mvp 6)
(local shader-loc-matrix-view 7)
(local shader-loc-matrix-projection 8)
(local shader-loc-matrix-model 9)
(local shader-loc-matrix-normal 10)
(local shader-loc-vector-view 11)
(local shader-loc-color-diffuse 12)
(local shader-loc-color-specular 13)
(local shader-loc-color-ambient 14)
(local shader-loc-map-albedo 15)
(local shader-loc-map-metalness 16)
(local shader-loc-map-normal 17)
(local shader-loc-map-roughness 18)
(local shader-loc-map-occlusion 19)
(local shader-loc-map-emission 20)
(local shader-loc-map-height 21)
(local shader-loc-map-cubemap 22)
(local shader-loc-map-irradiance 23)
(local shader-loc-map-prefilter 24)
(local shader-loc-map-brdf 25)
(local shader-loc-vertex-boneids 26)
(local shader-loc-vertex-boneweights 27)
(local shader-loc-bone-matrices 28)
; Shader uniform data type
(local shader-uniform-float 0)
(local shader-uniform-vec2 1)
(local shader-uniform-vec3 2)
(local shader-uniform-vec4 3)
(local shader-uniform-int 4)
(local shader-uniform-ivec2 5)
(local shader-uniform-ivec3 6)
(local shader-uniform-ivec4 7)
(local shader-uniform-sampler2d 8)
; Shader attribute data types
(local shader-attrib-float 0)
(local shader-attrib-vec2 1)
(local shader-attrib-vec3 2)
(local shader-attrib-vec4 3)
; Pixel formats
; NOTE: Support depends on OpenGL version and platform
(local pixelformat-uncompressed-grayscale 1)
(local pixelformat-uncompressed-gray-alpha 2)
(local pixelformat-uncompressed-r5g6b5 3)
(local pixelformat-uncompressed-r8g8b8 4)
(local pixelformat-uncompressed-r5g5b5a1 5)
(local pixelformat-uncompressed-r4g4b4a4 6)
(local pixelformat-uncompressed-r8g8b8a8 7)
(local pixelformat-uncompressed-r32 8)
(local pixelformat-uncompressed-r32g32b32 9)
(local pixelformat-uncompressed-r32g32b32a32 10)
(local pixelformat-uncompressed-r16 11)
(local pixelformat-uncompressed-r16g16b16 12)
(local pixelformat-uncompressed-r16g16b16a16 13)
(local pixelformat-compressed-dxt1-rgb 14)
(local pixelformat-compressed-dxt1-rgba 15)
(local pixelformat-compressed-dxt3-rgba 16)
(local pixelformat-compressed-dxt5-rgba 17)
(local pixelformat-compressed-etc1-rgb 18)
(local pixelformat-compressed-etc2-rgb 19)
(local pixelformat-compressed-etc2-eac-rgba 20)
(local pixelformat-compressed-pvrt-rgb 21)
(local pixelformat-compressed-pvrt-rgba 22)
(local pixelformat-compressed-astc-4x4-rgba 23)
(local pixelformat-compressed-astc-8x8-rgba 24)
; Texture parameters: filter mode
; NOTE 1: Filtering considers mipmaps if available in the texture
; NOTE 2: Filter is accordingly set for minification and magnification
(local texture-filter-point 0)
(local texture-filter-bilinear 1)
(local texture-filter-trilinear 2)
(local texture-filter-anisotropic-4x 3)
(local texture-filter-anisotropic-8x 4)
(local texture-filter-anisotropic-16x 5)
; Texture parameters: wrap mode
(local texture-wrap-repeat 0)
(local texture-wrap-clamp 1)
(local texture-wrap-mirror-repeat 2)
(local texture-wrap-mirror-clamp 3)
; Cubemap layouts
(local cubemap-layout-auto-detect 0)
(local cubemap-layout-line-vertical 1)
(local cubemap-layout-line-horizontal 2)
(local cubemap-layout-cross-three-by-four 3)
(local cubemap-layout-cross-four-by-three 4)
; Font type, defines generation method
(local font-default 0)
(local font-bitmap 1)
(local font-sdf 2)
; Color blending modes (pre-defined)
(local blend-alpha 0)
(local blend-additive 1)
(local blend-multiplied 2)
(local blend-add-colors 3)
(local blend-subtract-colors 4)
(local blend-alpha-premultiply 5)
(local blend-custom 6)
(local blend-custom-separate 7)
; Gesture
; NOTE: Provided as bit-wise flags to enable only desired gestures
(local gesture-none 0)
(local gesture-tap 1)
(local gesture-doubletap 2)
(local gesture-hold 4)
(local gesture-drag 8)
(local gesture-swipe-right 16)
(local gesture-swipe-left 32)
(local gesture-swipe-up 64)
(local gesture-swipe-down 128)
(local gesture-pinch-in 256)
(local gesture-pinch-out 512)
; Camera system modes
(local camera-custom 0)
(local camera-free 1)
(local camera-orbital 2)
(local camera-first-person 3)
(local camera-third-person 4)
; Camera projection
(local camera-perspective 0)
(local camera-orthographic 1)
; N-patch layout
(local npatch-nine-patch 0)
(local npatch-three-patch-vertical 1)
(local npatch-three-patch-horizontal 2)


; FUNCTIONS BLOCK
;------------------------------------------------------------------------------------
; Global Variables Definition
;------------------------------------------------------------------------------------
; It's lonely here...
;------------------------------------------------------------------------------------
; Window and Graphics Device Functions (Module: core)
;------------------------------------------------------------------------------------
; Window-related functions
(fn init-window [width height title]
	"Initialize window and OpenGL context"
	(rl.InitWindow width height title))

(fn close-window []
	"Close window and unload OpenGL context"
	(rl.CloseWindow ))

(fn window-should-close []
	"Check if application should close (KEY_ESCAPE pressed or windows close icon clicked)"
	(rl.WindowShouldClose ))

(fn is-window-ready []
	"Check if window has been initialized successfully"
	(rl.IsWindowReady ))

(fn is-window-fullscreen []
	"Check if window is currently fullscreen"
	(rl.IsWindowFullscreen ))

(fn is-window-hidden []
	"Check if window is currently hidden"
	(rl.IsWindowHidden ))

(fn is-window-minimized []
	"Check if window is currently minimized"
	(rl.IsWindowMinimized ))

(fn is-window-maximized []
	"Check if window is currently maximized"
	(rl.IsWindowMaximized ))

(fn is-window-focused []
	"Check if window is currently focused"
	(rl.IsWindowFocused ))

(fn is-window-resized []
	"Check if window has been resized last frame"
	(rl.IsWindowResized ))

(fn is-window-state [flag]
	"Check if one specific window flag is enabled"
	(rl.IsWindowState flag))

(fn set-window-state [flags]
	"Set window configuration state using flags"
	(rl.SetWindowState flags))

(fn clear-window-state [flags]
	"Clear window configuration state flags"
	(rl.ClearWindowState flags))

(fn toggle-fullscreen []
	"Toggle window state: fullscreen/windowed, resizes monitor to match window resolution"
	(rl.ToggleFullscreen ))

(fn toggle-borderless-windowed []
	"Toggle window state: borderless windowed, resizes window to match monitor resolution"
	(rl.ToggleBorderlessWindowed ))

(fn maximize-window []
	"Set window state: maximized, if resizable"
	(rl.MaximizeWindow ))

(fn minimize-window []
	"Set window state: minimized, if resizable"
	(rl.MinimizeWindow ))

(fn restore-window []
	"Set window state: not minimized/maximized"
	(rl.RestoreWindow ))

(fn set-window-icon [image]
	"Set icon for window (single image, RGBA 32bit)"
	(rl.SetWindowIcon image))

(fn set-window-icons [images count]
	"Set icon for window (multiple images, RGBA 32bit)"
	(rl.SetWindowIcons images count))

(fn set-window-title [title]
	"Set title for window"
	(rl.SetWindowTitle title))

(fn set-window-position [x y]
	"Set window position on screen"
	(rl.SetWindowPosition x y))

(fn set-window-monitor [monitor]
	"Set monitor for the current window"
	(rl.SetWindowMonitor monitor))

(fn set-window-min-size [width height]
	"Set window minimum dimensions (for FLAG_WINDOW_RESIZABLE)"
	(rl.SetWindowMinSize width height))

(fn set-window-max-size [width height]
	"Set window maximum dimensions (for FLAG_WINDOW_RESIZABLE)"
	(rl.SetWindowMaxSize width height))

(fn set-window-size [width height]
	"Set window dimensions"
	(rl.SetWindowSize width height))

(fn set-window-opacity [opacity]
	"Set window opacity [0.0f..1.0f]"
	(rl.SetWindowOpacity opacity))

(fn set-window-focused []
	"Set window focused"
	(rl.SetWindowFocused ))

(fn get-window-handle []
	"Get native window handle"
	(rl.GetWindowHandle ))

(fn get-screen-width []
	"Get current screen width"
	(rl.GetScreenWidth ))

(fn get-screen-height []
	"Get current screen height"
	(rl.GetScreenHeight ))

(fn get-render-width []
	"Get current render width (it considers HiDPI)"
	(rl.GetRenderWidth ))

(fn get-render-height []
	"Get current render height (it considers HiDPI)"
	(rl.GetRenderHeight ))

(fn get-monitor-count []
	"Get number of connected monitors"
	(rl.GetMonitorCount ))

(fn get-current-monitor []
	"Get current monitor where window is placed"
	(rl.GetCurrentMonitor ))

(fn get-monitor-position [monitor]
	"Get specified monitor position"
	(rl.GetMonitorPosition monitor))

(fn get-monitor-width [monitor]
	"Get specified monitor width (current video mode used by monitor)"
	(rl.GetMonitorWidth monitor))

(fn get-monitor-height [monitor]
	"Get specified monitor height (current video mode used by monitor)"
	(rl.GetMonitorHeight monitor))

(fn get-monitor-physical-width [monitor]
	"Get specified monitor physical width in millimetres"
	(rl.GetMonitorPhysicalWidth monitor))

(fn get-monitor-physical-height [monitor]
	"Get specified monitor physical height in millimetres"
	(rl.GetMonitorPhysicalHeight monitor))

(fn get-monitor-refresh-rate [monitor]
	"Get specified monitor refresh rate"
	(rl.GetMonitorRefreshRate monitor))

(fn get-window-position []
	"Get window position XY on monitor"
	(rl.GetWindowPosition ))

(fn get-window-scale-dpi []
	"Get window scale DPI factor"
	(rl.GetWindowScaleDPI ))

(fn get-monitor-name [monitor]
	"Get the human-readable, UTF-8 encoded name of the specified monitor"
	(rl.GetMonitorName monitor))

(fn set-clipboard-text [text]
	"Set clipboard text content"
	(rl.SetClipboardText text))

(fn get-clipboard-text []
	"Get clipboard text content"
	(rl.GetClipboardText ))

(fn get-clipboard-image []
	"Get clipboard image content"
	(rl.GetClipboardImage ))

(fn enable-event-waiting []
	"Enable waiting for events on EndDrawing(), no automatic event polling"
	(rl.EnableEventWaiting ))

(fn disable-event-waiting []
	"Disable waiting for events on EndDrawing(), automatic events polling"
	(rl.DisableEventWaiting ))

; Cursor-related functions
(fn show-cursor []
	"Shows cursor"
	(rl.ShowCursor ))

(fn hide-cursor []
	"Hides cursor"
	(rl.HideCursor ))

(fn is-cursor-hidden []
	"Check if cursor is not visible"
	(rl.IsCursorHidden ))

(fn enable-cursor []
	"Enables cursor (unlock cursor)"
	(rl.EnableCursor ))

(fn disable-cursor []
	"Disables cursor (lock cursor)"
	(rl.DisableCursor ))

(fn is-cursor-on-screen []
	"Check if cursor is on the screen"
	(rl.IsCursorOnScreen ))

; Drawing-related functions
(fn clear-background [color]
	"Set background color (framebuffer clear color)"
	(rl.ClearBackground color))

(fn begin-drawing []
	"Setup canvas (framebuffer) to start drawing"
	(rl.BeginDrawing ))

(fn end-drawing []
	"End canvas drawing and swap buffers (double buffering)"
	(rl.EndDrawing ))

(fn begin-mode2d [camera]
	"Begin 2D mode with custom camera (2D)"
	(rl.BeginMode2D camera))

(fn end-mode2d []
	"Ends 2D mode with custom camera"
	(rl.EndMode2D ))

(fn begin-mode3d [camera]
	"Begin 3D mode with custom camera (3D)"
	(rl.BeginMode3D camera))

(fn end-mode3d []
	"Ends 3D mode and returns to default 2D orthographic mode"
	(rl.EndMode3D ))

(fn begin-texture-mode [target]
	"Begin drawing to render texture"
	(rl.BeginTextureMode target))

(fn end-texture-mode []
	"Ends drawing to render texture"
	(rl.EndTextureMode ))

(fn begin-shader-mode [shader]
	"Begin custom shader drawing"
	(rl.BeginShaderMode shader))

(fn end-shader-mode []
	"End custom shader drawing (use default shader)"
	(rl.EndShaderMode ))

(fn begin-blend-mode [mode]
	"Begin blending mode (alpha, additive, multiplied, subtract, custom)"
	(rl.BeginBlendMode mode))

(fn end-blend-mode []
	"End blending mode (reset to default: alpha blending)"
	(rl.EndBlendMode ))

(fn begin-scissor-mode [x y width height]
	"Begin scissor mode (define screen area for following drawing)"
	(rl.BeginScissorMode x y width height))

(fn end-scissor-mode []
	"End scissor mode"
	(rl.EndScissorMode ))

(fn begin-vr-stereo-mode [config]
	"Begin stereo rendering (requires VR simulator)"
	(rl.BeginVrStereoMode config))

(fn end-vr-stereo-mode []
	"End stereo rendering (requires VR simulator)"
	(rl.EndVrStereoMode ))

; VR stereo config functions for VR simulator
(fn load-vr-stereo-config [device]
	"Load VR stereo config for VR simulator device parameters"
	(rl.LoadVrStereoConfig device))

(fn unload-vr-stereo-config [config]
	"Unload VR stereo config"
	(rl.UnloadVrStereoConfig config))

; Shader management functions
; NOTE: Shader functionality is not available on OpenGL 1.1
(fn load-shader [vs-file-name fs-file-name]
	"Load shader from files and bind default locations"
	(rl.LoadShader vs-file-name fs-file-name))

(fn load-shader-from-memory [vs-code fs-code]
	"Load shader from code strings and bind default locations"
	(rl.LoadShaderFromMemory vs-code fs-code))

(fn is-shader-valid [shader]
	"Check if a shader is valid (loaded on GPU)"
	(rl.IsShaderValid shader))

(fn get-shader-location [shader uniform-name]
	"Get shader uniform location"
	(rl.GetShaderLocation shader uniform-name))

(fn get-shader-location-attrib [shader attrib-name]
	"Get shader attribute location"
	(rl.GetShaderLocationAttrib shader attrib-name))

(fn set-shader-value [shader loc-index value uniform-type]
	"Set shader uniform value"
	(rl.SetShaderValue shader loc-index value uniform-type))

(fn set-shader-value-v [shader loc-index value uniform-type count]
	"Set shader uniform value vector"
	(rl.SetShaderValueV shader loc-index value uniform-type count))

(fn set-shader-value-matrix [shader loc-index mat]
	"Set shader uniform value (matrix 4x4)"
	(rl.SetShaderValueMatrix shader loc-index mat))

(fn set-shader-value-texture [shader loc-index texture]
	"Set shader uniform value for texture (sampler2d)"
	(rl.SetShaderValueTexture shader loc-index texture))

(fn unload-shader [shader]
	"Unload shader from GPU memory (VRAM)"
	(rl.UnloadShader shader))

; Screen-space-related functions
(fn get-screen-to-world-ray [position camera]
	"Get a ray trace from screen position (i.e mouse)"
	(rl.GetScreenToWorldRay position camera))

(fn get-screen-to-world-ray-ex [position camera width height]
	"Get a ray trace from screen position (i.e mouse) in a viewport"
	(rl.GetScreenToWorldRayEx position camera width height))

(fn get-world-to-screen [position camera]
	"Get the screen space position for a 3d world space position"
	(rl.GetWorldToScreen position camera))

(fn get-world-to-screen-ex [position camera width height]
	"Get size position for a 3d world space position"
	(rl.GetWorldToScreenEx position camera width height))

(fn get-world-to-screen2d [position camera]
	"Get the screen space position for a 2d camera world space position"
	(rl.GetWorldToScreen2D position camera))

(fn get-screen-to-world2d [position camera]
	"Get the world space position for a 2d camera screen space position"
	(rl.GetScreenToWorld2D position camera))

(fn get-camera-matrix [camera]
	"Get camera transform matrix (view matrix)"
	(rl.GetCameraMatrix camera))

(fn get-camera-matrix2d [camera]
	"Get camera 2d transform matrix"
	(rl.GetCameraMatrix2D camera))

; Timing-related functions
(fn set-target-fps [fps]
	"Set target FPS (maximum)"
	(rl.SetTargetFPS fps))

(fn get-frame-time []
	"Get time in seconds for last frame drawn (delta time)"
	(rl.GetFrameTime ))

(fn get-time []
	"Get elapsed time in seconds since InitWindow()"
	(rl.GetTime ))

(fn get-fps []
	"Get current FPS"
	(rl.GetFPS ))

; Custom frame control functions
; NOTE: Those functions are intended for advanced users that want full control over the frame processing
; By default EndDrawing() does this job: draws everything + SwapScreenBuffer() + manage frame timing + PollInputEvents()
; To avoid that behaviour and control frame processes manually, enable in config.h: SUPPORT_CUSTOM_FRAME_CONTROL
(fn swap-screen-buffer []
	"Swap back buffer with front buffer (screen drawing)"
	(rl.SwapScreenBuffer ))

(fn poll-input-events []
	"Register all input events"
	(rl.PollInputEvents ))

(fn wait-time [seconds]
	"Wait for some time (halt program execution)"
	(rl.WaitTime seconds))

; Random values generation functions
(fn set-random-seed [seed]
	"Set the seed for the random number generator"
	(rl.SetRandomSeed seed))

(fn get-random-value [min max]
	"Get a random value between min and max (both included)"
	(rl.GetRandomValue min max))

(fn load-random-sequence [count min max]
	"Load random values sequence, no values repeated"
	(rl.LoadRandomSequence count min max))

(fn unload-random-sequence [sequence]
	"Unload random values sequence"
	(rl.UnloadRandomSequence sequence))

; Misc. functions
(fn take-screenshot [file-name]
	"Takes a screenshot of current screen (filename extension defines format)"
	(rl.TakeScreenshot file-name))

(fn set-config-flags [flags]
	"Setup init configuration flags (view FLAGS)"
	(rl.SetConfigFlags flags))

(fn open-url [url]
	"Open URL with default system browser (if available)"
	(rl.OpenURL url))

; NOTE: Following functions implemented in module [utils]
;------------------------------------------------------------------
(fn trace-log [log-level text ]
	"Show trace log messages (LOG_DEBUG, LOG_INFO, LOG_WARNING, LOG_ERROR...)"
	(rl.TraceLog log-level text ))

(fn set-trace-log-level [log-level]
	"Set the current threshold (minimum) log level"
	(rl.SetTraceLogLevel log-level))

(fn mem-alloc [size]
	"Internal memory allocator"
	(rl.MemAlloc size))

(fn mem-realloc [ptr size]
	"Internal memory reallocator"
	(rl.MemRealloc ptr size))

(fn mem-free [ptr]
	"Internal memory free"
	(rl.MemFree ptr))

; Set custom callbacks
; WARNING: Callbacks setup is intended for advanced users
(fn set-trace-log-callback [callback]
	"Set custom trace log"
	(rl.SetTraceLogCallback callback))

(fn set-load-file-data-callback [callback]
	"Set custom file binary data loader"
	(rl.SetLoadFileDataCallback callback))

(fn set-save-file-data-callback [callback]
	"Set custom file binary data saver"
	(rl.SetSaveFileDataCallback callback))

(fn set-load-file-text-callback [callback]
	"Set custom file text data loader"
	(rl.SetLoadFileTextCallback callback))

(fn set-save-file-text-callback [callback]
	"Set custom file text data saver"
	(rl.SetSaveFileTextCallback callback))

; Files management functions
(fn load-file-data [file-name data-size]
	"Load file data as byte array (read)"
	(rl.LoadFileData file-name data-size))

(fn unload-file-data [data]
	"Unload file data allocated by LoadFileData()"
	(rl.UnloadFileData data))

(fn save-file-data [file-name data data-size]
	"Save data to file from byte array (write), returns true on success"
	(rl.SaveFileData file-name data data-size))

(fn export-data-as-code [data data-size file-name]
	"Export data to code (.h), returns true on success"
	(rl.ExportDataAsCode data data-size file-name))

(fn load-file-text [file-name]
	"Load text data from file (read), returns a '\0' terminated string"
	(rl.LoadFileText file-name))

(fn unload-file-text [text]
	"Unload file text data allocated by LoadFileText()"
	(rl.UnloadFileText text))

(fn save-file-text [file-name text]
	"Save text data to file (write), string must be '\0' terminated, returns true on success"
	(rl.SaveFileText file-name text))

;------------------------------------------------------------------
; File system functions
(fn file-exists [file-name]
	"Check if file exists"
	(rl.FileExists file-name))

(fn directory-exists [dir-path]
	"Check if a directory path exists"
	(rl.DirectoryExists dir-path))

(fn is-file-extension [file-name ext]
	"Check file extension (including point: .png, .wav)"
	(rl.IsFileExtension file-name ext))

(fn get-file-length [file-name]
	"Get file length in bytes (NOTE: GetFileSize() conflicts with windows.h)"
	(rl.GetFileLength file-name))

(fn get-file-extension [file-name]
	"Get pointer to extension for a filename string (includes dot: '.png')"
	(rl.GetFileExtension file-name))

(fn get-file-name [file-path]
	"Get pointer to filename for a path string"
	(rl.GetFileName file-path))

(fn get-file-name-without-ext [file-path]
	"Get filename string without extension (uses static string)"
	(rl.GetFileNameWithoutExt file-path))

(fn get-directory-path [file-path]
	"Get full path for a given fileName with path (uses static string)"
	(rl.GetDirectoryPath file-path))

(fn get-prev-directory-path [dir-path]
	"Get previous directory path for a given path (uses static string)"
	(rl.GetPrevDirectoryPath dir-path))

(fn get-working-directory []
	"Get current working directory (uses static string)"
	(rl.GetWorkingDirectory ))

(fn get-application-directory []
	"Get the directory of the running application (uses static string)"
	(rl.GetApplicationDirectory ))

(fn make-directory [dir-path]
	"Create directories (including full path requested), returns 0 on success"
	(rl.MakeDirectory dir-path))

(fn change-directory [dir]
	"Change working directory, return true on success"
	(rl.ChangeDirectory dir))

(fn is-path-file [path]
	"Check if a given path is a file or a directory"
	(rl.IsPathFile path))

(fn is-file-name-valid [file-name]
	"Check if fileName is valid for the platform/OS"
	(rl.IsFileNameValid file-name))

(fn load-directory-files [dir-path]
	"Load directory filepaths"
	(rl.LoadDirectoryFiles dir-path))

(fn load-directory-files-ex [base-path filter scan-subdirs]
	"Load directory filepaths with extension filtering and recursive directory scan. Use 'DIR' in the filter string to include directories in the result"
	(rl.LoadDirectoryFilesEx base-path filter scan-subdirs))

(fn unload-directory-files [files]
	"Unload filepaths"
	(rl.UnloadDirectoryFiles files))

(fn is-file-dropped []
	"Check if a file has been dropped into window"
	(rl.IsFileDropped ))

(fn load-dropped-files []
	"Load dropped filepaths"
	(rl.LoadDroppedFiles ))

(fn unload-dropped-files [files]
	"Unload dropped filepaths"
	(rl.UnloadDroppedFiles files))

(fn get-file-mod-time [file-name]
	"Get file modification time (last write time)"
	(rl.GetFileModTime file-name))

; Compression/Encoding functionality
(fn compress-data [data data-size comp-data-size]
	"Compress data (DEFLATE algorithm), memory must be MemFree()"
	(rl.CompressData data data-size comp-data-size))

(fn decompress-data [comp-data comp-data-size data-size]
	"Decompress data (DEFLATE algorithm), memory must be MemFree()"
	(rl.DecompressData comp-data comp-data-size data-size))

(fn encode-data-base64 [data data-size output-size]
	"Encode data to Base64 string, memory must be MemFree()"
	(rl.EncodeDataBase64 data data-size output-size))

(fn decode-data-base64 [data output-size]
	"Decode Base64 string data, memory must be MemFree()"
	(rl.DecodeDataBase64 data output-size))

(fn compute-crc32 [data data-size]
	"Compute CRC32 hash code"
	(rl.ComputeCRC32 data data-size))

(fn compute-md5 [data data-size]
	"Compute MD5 hash code, returns static int[4] (16 bytes)"
	(rl.ComputeMD5 data data-size))

(fn compute-sha1 [data data-size]
	"Compute SHA1 hash code, returns static int[5] (20 bytes)"
	(rl.ComputeSHA1 data data-size))

; Automation events functionality
(fn load-automation-event-list [file-name]
	"Load automation events list from file, NULL for empty list, capacity = MAX_AUTOMATION_EVENTS"
	(rl.LoadAutomationEventList file-name))

(fn unload-automation-event-list [list]
	"Unload automation events list from file"
	(rl.UnloadAutomationEventList list))

(fn export-automation-event-list [list file-name]
	"Export automation events list as text file"
	(rl.ExportAutomationEventList list file-name))

(fn set-automation-event-list [list]
	"Set automation event list to record to"
	(rl.SetAutomationEventList list))

(fn set-automation-event-base-frame [frame]
	"Set automation event internal base frame to start recording"
	(rl.SetAutomationEventBaseFrame frame))

(fn start-automation-event-recording []
	"Start recording automation events (AutomationEventList must be set)"
	(rl.StartAutomationEventRecording ))

(fn stop-automation-event-recording []
	"Stop recording automation events"
	(rl.StopAutomationEventRecording ))

(fn play-automation-event [event]
	"Play a recorded automation event"
	(rl.PlayAutomationEvent event))

;------------------------------------------------------------------------------------
; Input Handling Functions (Module: core)
;------------------------------------------------------------------------------------
; Input-related functions: keyboard
(fn is-key-pressed [key]
	"Check if a key has been pressed once"
	(rl.IsKeyPressed key))

(fn is-key-pressed-repeat [key]
	"Check if a key has been pressed again"
	(rl.IsKeyPressedRepeat key))

(fn is-key-down [key]
	"Check if a key is being pressed"
	(rl.IsKeyDown key))

(fn is-key-released [key]
	"Check if a key has been released once"
	(rl.IsKeyReleased key))

(fn is-key-up [key]
	"Check if a key is NOT being pressed"
	(rl.IsKeyUp key))

(fn get-key-pressed []
	"Get key pressed (keycode), call it multiple times for keys queued, returns 0 when the queue is empty"
	(rl.GetKeyPressed ))

(fn get-char-pressed []
	"Get char pressed (unicode), call it multiple times for chars queued, returns 0 when the queue is empty"
	(rl.GetCharPressed ))

(fn set-exit-key [key]
	"Set a custom key to exit program (default is ESC)"
	(rl.SetExitKey key))

; Input-related functions: gamepads
(fn is-gamepad-available [gamepad]
	"Check if a gamepad is available"
	(rl.IsGamepadAvailable gamepad))

(fn get-gamepad-name [gamepad]
	"Get gamepad internal name id"
	(rl.GetGamepadName gamepad))

(fn is-gamepad-button-pressed [gamepad button]
	"Check if a gamepad button has been pressed once"
	(rl.IsGamepadButtonPressed gamepad button))

(fn is-gamepad-button-down [gamepad button]
	"Check if a gamepad button is being pressed"
	(rl.IsGamepadButtonDown gamepad button))

(fn is-gamepad-button-released [gamepad button]
	"Check if a gamepad button has been released once"
	(rl.IsGamepadButtonReleased gamepad button))

(fn is-gamepad-button-up [gamepad button]
	"Check if a gamepad button is NOT being pressed"
	(rl.IsGamepadButtonUp gamepad button))

(fn get-gamepad-button-pressed []
	"Get the last gamepad button pressed"
	(rl.GetGamepadButtonPressed ))

(fn get-gamepad-axis-count [gamepad]
	"Get gamepad axis count for a gamepad"
	(rl.GetGamepadAxisCount gamepad))

(fn get-gamepad-axis-movement [gamepad axis]
	"Get axis movement value for a gamepad axis"
	(rl.GetGamepadAxisMovement gamepad axis))

(fn set-gamepad-mappings [mappings]
	"Set internal gamepad mappings (SDL_GameControllerDB)"
	(rl.SetGamepadMappings mappings))

(fn set-gamepad-vibration [gamepad left-motor right-motor duration]
	"Set gamepad vibration for both motors (duration in seconds)"
	(rl.SetGamepadVibration gamepad left-motor right-motor duration))

; Input-related functions: mouse
(fn is-mouse-button-pressed [button]
	"Check if a mouse button has been pressed once"
	(rl.IsMouseButtonPressed button))

(fn is-mouse-button-down [button]
	"Check if a mouse button is being pressed"
	(rl.IsMouseButtonDown button))

(fn is-mouse-button-released [button]
	"Check if a mouse button has been released once"
	(rl.IsMouseButtonReleased button))

(fn is-mouse-button-up [button]
	"Check if a mouse button is NOT being pressed"
	(rl.IsMouseButtonUp button))

(fn get-mouse-x []
	"Get mouse position X"
	(rl.GetMouseX ))

(fn get-mouse-y []
	"Get mouse position Y"
	(rl.GetMouseY ))

(fn get-mouse-position []
	"Get mouse position XY"
	(rl.GetMousePosition ))

(fn get-mouse-delta []
	"Get mouse delta between frames"
	(rl.GetMouseDelta ))

(fn set-mouse-position [x y]
	"Set mouse position XY"
	(rl.SetMousePosition x y))

(fn set-mouse-offset [offset-x offset-y]
	"Set mouse offset"
	(rl.SetMouseOffset offset-x offset-y))

(fn set-mouse-scale [scale-x scale-y]
	"Set mouse scaling"
	(rl.SetMouseScale scale-x scale-y))

(fn get-mouse-wheel-move []
	"Get mouse wheel movement for X or Y, whichever is larger"
	(rl.GetMouseWheelMove ))

(fn get-mouse-wheel-move-v []
	"Get mouse wheel movement for both X and Y"
	(rl.GetMouseWheelMoveV ))

(fn set-mouse-cursor [cursor]
	"Set mouse cursor"
	(rl.SetMouseCursor cursor))

; Input-related functions: touch
(fn get-touch-x []
	"Get touch position X for touch point 0 (relative to screen size)"
	(rl.GetTouchX ))

(fn get-touch-y []
	"Get touch position Y for touch point 0 (relative to screen size)"
	(rl.GetTouchY ))

(fn get-touch-position [index]
	"Get touch position XY for a touch point index (relative to screen size)"
	(rl.GetTouchPosition index))

(fn get-touch-point-id [index]
	"Get touch point identifier for given index"
	(rl.GetTouchPointId index))

(fn get-touch-point-count []
	"Get number of touch points"
	(rl.GetTouchPointCount ))

;------------------------------------------------------------------------------------
; Gestures and Touch Handling Functions (Module: rgestures)
;------------------------------------------------------------------------------------
(fn set-gestures-enabled [flags]
	"Enable a set of gestures using flags"
	(rl.SetGesturesEnabled flags))

(fn is-gesture-detected [gesture]
	"Check if a gesture have been detected"
	(rl.IsGestureDetected gesture))

(fn get-gesture-detected []
	"Get latest detected gesture"
	(rl.GetGestureDetected ))

(fn get-gesture-hold-duration []
	"Get gesture hold time in seconds"
	(rl.GetGestureHoldDuration ))

(fn get-gesture-drag-vector []
	"Get gesture drag vector"
	(rl.GetGestureDragVector ))

(fn get-gesture-drag-angle []
	"Get gesture drag angle"
	(rl.GetGestureDragAngle ))

(fn get-gesture-pinch-vector []
	"Get gesture pinch delta"
	(rl.GetGesturePinchVector ))

(fn get-gesture-pinch-angle []
	"Get gesture pinch angle"
	(rl.GetGesturePinchAngle ))

;------------------------------------------------------------------------------------
; Camera System Functions (Module: rcamera)
;------------------------------------------------------------------------------------
(fn update-camera [camera mode]
	"Update camera position for selected mode"
	(rl.UpdateCamera camera mode))

(fn update-camera-pro [camera movement rotation zoom]
	"Update camera movement/rotation"
	(rl.UpdateCameraPro camera movement rotation zoom))

;------------------------------------------------------------------------------------
; Basic Shapes Drawing Functions (Module: shapes)
;------------------------------------------------------------------------------------
; Set texture and rectangle to be used on shapes drawing
; NOTE: It can be useful when using basic shapes and one single font,
; defining a font char white rectangle would allow drawing everything in a single draw call
(fn set-shapes-texture [texture source]
	"Set texture and rectangle to be used on shapes drawing"
	(rl.SetShapesTexture texture source))

(fn get-shapes-texture []
	"Get texture that is used for shapes drawing"
	(rl.GetShapesTexture ))

(fn get-shapes-texture-rectangle []
	"Get texture source rectangle that is used for shapes drawing"
	(rl.GetShapesTextureRectangle ))

; Basic shapes drawing functions
(fn draw-pixel [pos-x pos-y color]
	"Draw a pixel using geometry [Can be slow, use with care]"
	(rl.DrawPixel pos-x pos-y color))

(fn draw-pixel-v [position color]
	"Draw a pixel using geometry (Vector version) [Can be slow, use with care]"
	(rl.DrawPixelV position color))

(fn draw-line [start-pos-x start-pos-y end-pos-x end-pos-y color]
	"Draw a line"
	(rl.DrawLine start-pos-x start-pos-y end-pos-x end-pos-y color))

(fn draw-line-v [start-pos end-pos color]
	"Draw a line (using gl lines)"
	(rl.DrawLineV start-pos end-pos color))

(fn draw-line-ex [start-pos end-pos thick color]
	"Draw a line (using triangles/quads)"
	(rl.DrawLineEx start-pos end-pos thick color))

(fn draw-line-strip [points point-count color]
	"Draw lines sequence (using gl lines)"
	(rl.DrawLineStrip points point-count color))

(fn draw-line-bezier [start-pos end-pos thick color]
	"Draw line segment cubic-bezier in-out interpolation"
	(rl.DrawLineBezier start-pos end-pos thick color))

(fn draw-circle [center-x center-y radius color]
	"Draw a color-filled circle"
	(rl.DrawCircle center-x center-y radius color))

(fn draw-circle-sector [center radius start-angle end-angle segments color]
	"Draw a piece of a circle"
	(rl.DrawCircleSector center radius start-angle end-angle segments color))

(fn draw-circle-sector-lines [center radius start-angle end-angle segments color]
	"Draw circle sector outline"
	(rl.DrawCircleSectorLines center radius start-angle end-angle segments color))

(fn draw-circle-gradient [center-x center-y radius inner outer]
	"Draw a gradient-filled circle"
	(rl.DrawCircleGradient center-x center-y radius inner outer))

(fn draw-circle-v [center radius color]
	"Draw a color-filled circle (Vector version)"
	(rl.DrawCircleV center radius color))

(fn draw-circle-lines [center-x center-y radius color]
	"Draw circle outline"
	(rl.DrawCircleLines center-x center-y radius color))

(fn draw-circle-lines-v [center radius color]
	"Draw circle outline (Vector version)"
	(rl.DrawCircleLinesV center radius color))

(fn draw-ellipse [center-x center-y radius-h radius-v color]
	"Draw ellipse"
	(rl.DrawEllipse center-x center-y radius-h radius-v color))

(fn draw-ellipse-lines [center-x center-y radius-h radius-v color]
	"Draw ellipse outline"
	(rl.DrawEllipseLines center-x center-y radius-h radius-v color))

(fn draw-ring [center inner-radius outer-radius start-angle end-angle segments color]
	"Draw ring"
	(rl.DrawRing center inner-radius outer-radius start-angle end-angle segments color))

(fn draw-ring-lines [center inner-radius outer-radius start-angle end-angle segments color]
	"Draw ring outline"
	(rl.DrawRingLines center inner-radius outer-radius start-angle end-angle segments color))

(fn draw-rectangle [pos-x pos-y width height color]
	"Draw a color-filled rectangle"
	(rl.DrawRectangle pos-x pos-y width height color))

(fn draw-rectangle-v [position size color]
	"Draw a color-filled rectangle (Vector version)"
	(rl.DrawRectangleV position size color))

(fn draw-rectangle-rec [rec color]
	"Draw a color-filled rectangle"
	(rl.DrawRectangleRec rec color))

(fn draw-rectangle-pro [rec origin rotation color]
	"Draw a color-filled rectangle with pro parameters"
	(rl.DrawRectanglePro rec origin rotation color))

(fn draw-rectangle-gradient-v [pos-x pos-y width height top bottom]
	"Draw a vertical-gradient-filled rectangle"
	(rl.DrawRectangleGradientV pos-x pos-y width height top bottom))

(fn draw-rectangle-gradient-h [pos-x pos-y width height left right]
	"Draw a horizontal-gradient-filled rectangle"
	(rl.DrawRectangleGradientH pos-x pos-y width height left right))

(fn draw-rectangle-gradient-ex [rec top-left bottom-left top-right bottom-right]
	"Draw a gradient-filled rectangle with custom vertex colors"
	(rl.DrawRectangleGradientEx rec top-left bottom-left top-right bottom-right))

(fn draw-rectangle-lines [pos-x pos-y width height color]
	"Draw rectangle outline"
	(rl.DrawRectangleLines pos-x pos-y width height color))

(fn draw-rectangle-lines-ex [rec line-thick color]
	"Draw rectangle outline with extended parameters"
	(rl.DrawRectangleLinesEx rec line-thick color))

(fn draw-rectangle-rounded [rec roundness segments color]
	"Draw rectangle with rounded edges"
	(rl.DrawRectangleRounded rec roundness segments color))

(fn draw-rectangle-rounded-lines [rec roundness segments color]
	"Draw rectangle lines with rounded edges"
	(rl.DrawRectangleRoundedLines rec roundness segments color))

(fn draw-rectangle-rounded-lines-ex [rec roundness segments line-thick color]
	"Draw rectangle with rounded edges outline"
	(rl.DrawRectangleRoundedLinesEx rec roundness segments line-thick color))

(fn draw-triangle [v1 v2 v3 color]
	"Draw a color-filled triangle (vertex in counter-clockwise order!)"
	(rl.DrawTriangle v1 v2 v3 color))

(fn draw-triangle-lines [v1 v2 v3 color]
	"Draw triangle outline (vertex in counter-clockwise order!)"
	(rl.DrawTriangleLines v1 v2 v3 color))

(fn draw-triangle-fan [points point-count color]
	"Draw a triangle fan defined by points (first vertex is the center)"
	(rl.DrawTriangleFan points point-count color))

(fn draw-triangle-strip [points point-count color]
	"Draw a triangle strip defined by points"
	(rl.DrawTriangleStrip points point-count color))

(fn draw-poly [center sides radius rotation color]
	"Draw a regular polygon (Vector version)"
	(rl.DrawPoly center sides radius rotation color))

(fn draw-poly-lines [center sides radius rotation color]
	"Draw a polygon outline of n sides"
	(rl.DrawPolyLines center sides radius rotation color))

(fn draw-poly-lines-ex [center sides radius rotation line-thick color]
	"Draw a polygon outline of n sides with extended parameters"
	(rl.DrawPolyLinesEx center sides radius rotation line-thick color))

; Splines drawing functions
(fn draw-spline-linear [points point-count thick color]
	"Draw spline: Linear, minimum 2 points"
	(rl.DrawSplineLinear points point-count thick color))

(fn draw-spline-basis [points point-count thick color]
	"Draw spline: B-Spline, minimum 4 points"
	(rl.DrawSplineBasis points point-count thick color))

(fn draw-spline-catmull-rom [points point-count thick color]
	"Draw spline: Catmull-Rom, minimum 4 points"
	(rl.DrawSplineCatmullRom points point-count thick color))

(fn draw-spline-bezier-quadratic [points point-count thick color]
	"Draw spline: Quadratic Bezier, minimum 3 points (1 control point): [p1, c2, p3, c4...]"
	(rl.DrawSplineBezierQuadratic points point-count thick color))

(fn draw-spline-bezier-cubic [points point-count thick color]
	"Draw spline: Cubic Bezier, minimum 4 points (2 control points): [p1, c2, c3, p4, c5, c6...]"
	(rl.DrawSplineBezierCubic points point-count thick color))

(fn draw-spline-segment-linear [p1 p2 thick color]
	"Draw spline segment: Linear, 2 points"
	(rl.DrawSplineSegmentLinear p1 p2 thick color))

(fn draw-spline-segment-basis [p1 p2 p3 p4 thick color]
	"Draw spline segment: B-Spline, 4 points"
	(rl.DrawSplineSegmentBasis p1 p2 p3 p4 thick color))

(fn draw-spline-segment-catmull-rom [p1 p2 p3 p4 thick color]
	"Draw spline segment: Catmull-Rom, 4 points"
	(rl.DrawSplineSegmentCatmullRom p1 p2 p3 p4 thick color))

(fn draw-spline-segment-bezier-quadratic [p1 c2 p3 thick color]
	"Draw spline segment: Quadratic Bezier, 2 points, 1 control point"
	(rl.DrawSplineSegmentBezierQuadratic p1 c2 p3 thick color))

(fn draw-spline-segment-bezier-cubic [p1 c2 c3 p4 thick color]
	"Draw spline segment: Cubic Bezier, 2 points, 2 control points"
	(rl.DrawSplineSegmentBezierCubic p1 c2 c3 p4 thick color))

; Spline segment point evaluation functions, for a given t [0.0f .. 1.0f]
(fn get-spline-point-linear [start-pos end-pos t]
	"Get (evaluate) spline point: Linear"
	(rl.GetSplinePointLinear start-pos end-pos t))

(fn get-spline-point-basis [p1 p2 p3 p4 t]
	"Get (evaluate) spline point: B-Spline"
	(rl.GetSplinePointBasis p1 p2 p3 p4 t))

(fn get-spline-point-catmull-rom [p1 p2 p3 p4 t]
	"Get (evaluate) spline point: Catmull-Rom"
	(rl.GetSplinePointCatmullRom p1 p2 p3 p4 t))

(fn get-spline-point-bezier-quad [p1 c2 p3 t]
	"Get (evaluate) spline point: Quadratic Bezier"
	(rl.GetSplinePointBezierQuad p1 c2 p3 t))

(fn get-spline-point-bezier-cubic [p1 c2 c3 p4 t]
	"Get (evaluate) spline point: Cubic Bezier"
	(rl.GetSplinePointBezierCubic p1 c2 c3 p4 t))

; Basic shapes collision detection functions
(fn check-collision-recs [rec1 rec2]
	"Check collision between two rectangles"
	(rl.CheckCollisionRecs rec1 rec2))

(fn check-collision-circles [center1 radius1 center2 radius2]
	"Check collision between two circles"
	(rl.CheckCollisionCircles center1 radius1 center2 radius2))

(fn check-collision-circle-rec [center radius rec]
	"Check collision between circle and rectangle"
	(rl.CheckCollisionCircleRec center radius rec))

(fn check-collision-circle-line [center radius p1 p2]
	"Check if circle collides with a line created betweeen two points [p1] and [p2]"
	(rl.CheckCollisionCircleLine center radius p1 p2))

(fn check-collision-point-rec [point rec]
	"Check if point is inside rectangle"
	(rl.CheckCollisionPointRec point rec))

(fn check-collision-point-circle [point center radius]
	"Check if point is inside circle"
	(rl.CheckCollisionPointCircle point center radius))

(fn check-collision-point-triangle [point p1 p2 p3]
	"Check if point is inside a triangle"
	(rl.CheckCollisionPointTriangle point p1 p2 p3))

(fn check-collision-point-line [point p1 p2 threshold]
	"Check if point belongs to line created between two points [p1] and [p2] with defined margin in pixels [threshold]"
	(rl.CheckCollisionPointLine point p1 p2 threshold))

(fn check-collision-point-poly [point points point-count]
	"Check if point is within a polygon described by array of vertices"
	(rl.CheckCollisionPointPoly point points point-count))

(fn check-collision-lines [start-pos1 end-pos1 start-pos2 end-pos2 collision-point]
	"Check the collision between two lines defined by two points each, returns collision point by reference"
	(rl.CheckCollisionLines start-pos1 end-pos1 start-pos2 end-pos2 collision-point))

(fn get-collision-rec [rec1 rec2]
	"Get collision rectangle for two rectangles collision"
	(rl.GetCollisionRec rec1 rec2))

;------------------------------------------------------------------------------------
; Texture Loading and Drawing Functions (Module: textures)
;------------------------------------------------------------------------------------
; Image loading functions
; NOTE: These functions do not require GPU access
(fn load-image [file-name]
	"Load image from file into CPU memory (RAM)"
	(rl.LoadImage file-name))

(fn load-image-raw [file-name width height format header-size]
	"Load image from RAW file data"
	(rl.LoadImageRaw file-name width height format header-size))

(fn load-image-anim [file-name frames]
	"Load image sequence from file (frames appended to image.data)"
	(rl.LoadImageAnim file-name frames))

(fn load-image-anim-from-memory [file-type file-data data-size frames]
	"Load image sequence from memory buffer"
	(rl.LoadImageAnimFromMemory file-type file-data data-size frames))

(fn load-image-from-memory [file-type file-data data-size]
	"Load image from memory buffer, fileType refers to extension: i.e. '.png'"
	(rl.LoadImageFromMemory file-type file-data data-size))

(fn load-image-from-texture [texture]
	"Load image from GPU texture data"
	(rl.LoadImageFromTexture texture))

(fn load-image-from-screen []
	"Load image from screen buffer and (screenshot)"
	(rl.LoadImageFromScreen ))

(fn is-image-valid [image]
	"Check if an image is valid (data and parameters)"
	(rl.IsImageValid image))

(fn unload-image [image]
	"Unload image from CPU memory (RAM)"
	(rl.UnloadImage image))

(fn export-image [image file-name]
	"Export image data to file, returns true on success"
	(rl.ExportImage image file-name))

(fn export-image-to-memory [image file-type file-size]
	"Export image to memory buffer"
	(rl.ExportImageToMemory image file-type file-size))

(fn export-image-as-code [image file-name]
	"Export image as code file defining an array of bytes, returns true on success"
	(rl.ExportImageAsCode image file-name))

; Image generation functions
(fn gen-image-color [width height color]
	"Generate image: plain color"
	(rl.GenImageColor width height color))

(fn gen-image-gradient-linear [width height direction start end]
	"Generate image: linear gradient, direction in degrees [0..360], 0=Vertical gradient"
	(rl.GenImageGradientLinear width height direction start end))

(fn gen-image-gradient-radial [width height density inner outer]
	"Generate image: radial gradient"
	(rl.GenImageGradientRadial width height density inner outer))

(fn gen-image-gradient-square [width height density inner outer]
	"Generate image: square gradient"
	(rl.GenImageGradientSquare width height density inner outer))

(fn gen-image-checked [width height checks-x checks-y col1 col2]
	"Generate image: checked"
	(rl.GenImageChecked width height checks-x checks-y col1 col2))

(fn gen-image-white-noise [width height factor]
	"Generate image: white noise"
	(rl.GenImageWhiteNoise width height factor))

(fn gen-image-perlin-noise [width height offset-x offset-y scale]
	"Generate image: perlin noise"
	(rl.GenImagePerlinNoise width height offset-x offset-y scale))

(fn gen-image-cellular [width height tile-size]
	"Generate image: cellular algorithm, bigger tileSize means bigger cells"
	(rl.GenImageCellular width height tile-size))

(fn gen-image-text [width height text]
	"Generate image: grayscale image from text data"
	(rl.GenImageText width height text))

; Image manipulation functions
(fn image-copy [image]
	"Create an image duplicate (useful for transformations)"
	(rl.ImageCopy image))

(fn image-from-image [image rec]
	"Create an image from another image piece"
	(rl.ImageFromImage image rec))

(fn image-from-channel [image selected-channel]
	"Create an image from a selected channel of another image (GRAYSCALE)"
	(rl.ImageFromChannel image selected-channel))

(fn image-text [text font-size color]
	"Create an image from text (default font)"
	(rl.ImageText text font-size color))

(fn image-text-ex [font text font-size spacing tint]
	"Create an image from text (custom sprite font)"
	(rl.ImageTextEx font text font-size spacing tint))

(fn image-format [image new-format]
	"Convert image data to desired format"
	(rl.ImageFormat image new-format))

(fn image-to-pot [image fill]
	"Convert image to POT (power-of-two)"
	(rl.ImageToPOT image fill))

(fn image-crop [image crop]
	"Crop an image to a defined rectangle"
	(rl.ImageCrop image crop))

(fn image-alpha-crop [image threshold]
	"Crop image depending on alpha value"
	(rl.ImageAlphaCrop image threshold))

(fn image-alpha-clear [image color threshold]
	"Clear alpha channel to desired color"
	(rl.ImageAlphaClear image color threshold))

(fn image-alpha-mask [image alpha-mask]
	"Apply alpha mask to image"
	(rl.ImageAlphaMask image alpha-mask))

(fn image-alpha-premultiply [image]
	"Premultiply alpha channel"
	(rl.ImageAlphaPremultiply image))

(fn image-blur-gaussian [image blur-size]
	"Apply Gaussian blur using a box blur approximation"
	(rl.ImageBlurGaussian image blur-size))

(fn image-kernel-convolution [image kernel kernel-size]
	"Apply custom square convolution kernel to image"
	(rl.ImageKernelConvolution image kernel kernel-size))

(fn image-resize [image new-width new-height]
	"Resize image (Bicubic scaling algorithm)"
	(rl.ImageResize image new-width new-height))

(fn image-resize-nn [image new-width new-height]
	"Resize image (Nearest-Neighbor scaling algorithm)"
	(rl.ImageResizeNN image new-width new-height))

(fn image-resize-canvas [image new-width new-height offset-x offset-y fill]
	"Resize canvas and fill with color"
	(rl.ImageResizeCanvas image new-width new-height offset-x offset-y fill))

(fn image-mipmaps [image]
	"Compute all mipmap levels for a provided image"
	(rl.ImageMipmaps image))

(fn image-dither [image r-bpp g-bpp b-bpp a-bpp]
	"Dither image data to 16bpp or lower (Floyd-Steinberg dithering)"
	(rl.ImageDither image r-bpp g-bpp b-bpp a-bpp))

(fn image-flip-vertical [image]
	"Flip image vertically"
	(rl.ImageFlipVertical image))

(fn image-flip-horizontal [image]
	"Flip image horizontally"
	(rl.ImageFlipHorizontal image))

(fn image-rotate [image degrees]
	"Rotate image by input angle in degrees (-359 to 359)"
	(rl.ImageRotate image degrees))

(fn image-rotate-cw [image]
	"Rotate image clockwise 90deg"
	(rl.ImageRotateCW image))

(fn image-rotate-ccw [image]
	"Rotate image counter-clockwise 90deg"
	(rl.ImageRotateCCW image))

(fn image-color-tint [image color]
	"Modify image color: tint"
	(rl.ImageColorTint image color))

(fn image-color-invert [image]
	"Modify image color: invert"
	(rl.ImageColorInvert image))

(fn image-color-grayscale [image]
	"Modify image color: grayscale"
	(rl.ImageColorGrayscale image))

(fn image-color-contrast [image contrast]
	"Modify image color: contrast (-100 to 100)"
	(rl.ImageColorContrast image contrast))

(fn image-color-brightness [image brightness]
	"Modify image color: brightness (-255 to 255)"
	(rl.ImageColorBrightness image brightness))

(fn image-color-replace [image color replace]
	"Modify image color: replace color"
	(rl.ImageColorReplace image color replace))

(fn load-image-colors [image]
	"Load color data from image as a Color array (RGBA - 32bit)"
	(rl.LoadImageColors image))

(fn load-image-palette [image max-palette-size color-count]
	"Load colors palette from image as a Color array (RGBA - 32bit)"
	(rl.LoadImagePalette image max-palette-size color-count))

(fn unload-image-colors [colors]
	"Unload color data loaded with LoadImageColors()"
	(rl.UnloadImageColors colors))

(fn unload-image-palette [colors]
	"Unload colors palette loaded with LoadImagePalette()"
	(rl.UnloadImagePalette colors))

(fn get-image-alpha-border [image threshold]
	"Get image alpha border rectangle"
	(rl.GetImageAlphaBorder image threshold))

(fn get-image-color [image x y]
	"Get image pixel color at (x, y) position"
	(rl.GetImageColor image x y))

; Image drawing functions
; NOTE: Image software-rendering functions (CPU)
(fn image-clear-background [dst color]
	"Clear image background with given color"
	(rl.ImageClearBackground dst color))

(fn image-draw-pixel [dst pos-x pos-y color]
	"Draw pixel within an image"
	(rl.ImageDrawPixel dst pos-x pos-y color))

(fn image-draw-pixel-v [dst position color]
	"Draw pixel within an image (Vector version)"
	(rl.ImageDrawPixelV dst position color))

(fn image-draw-line [dst start-pos-x start-pos-y end-pos-x end-pos-y color]
	"Draw line within an image"
	(rl.ImageDrawLine dst start-pos-x start-pos-y end-pos-x end-pos-y color))

(fn image-draw-line-v [dst start end color]
	"Draw line within an image (Vector version)"
	(rl.ImageDrawLineV dst start end color))

(fn image-draw-line-ex [dst start end thick color]
	"Draw a line defining thickness within an image"
	(rl.ImageDrawLineEx dst start end thick color))

(fn image-draw-circle [dst center-x center-y radius color]
	"Draw a filled circle within an image"
	(rl.ImageDrawCircle dst center-x center-y radius color))

(fn image-draw-circle-v [dst center radius color]
	"Draw a filled circle within an image (Vector version)"
	(rl.ImageDrawCircleV dst center radius color))

(fn image-draw-circle-lines [dst center-x center-y radius color]
	"Draw circle outline within an image"
	(rl.ImageDrawCircleLines dst center-x center-y radius color))

(fn image-draw-circle-lines-v [dst center radius color]
	"Draw circle outline within an image (Vector version)"
	(rl.ImageDrawCircleLinesV dst center radius color))

(fn image-draw-rectangle [dst pos-x pos-y width height color]
	"Draw rectangle within an image"
	(rl.ImageDrawRectangle dst pos-x pos-y width height color))

(fn image-draw-rectangle-v [dst position size color]
	"Draw rectangle within an image (Vector version)"
	(rl.ImageDrawRectangleV dst position size color))

(fn image-draw-rectangle-rec [dst rec color]
	"Draw rectangle within an image"
	(rl.ImageDrawRectangleRec dst rec color))

(fn image-draw-rectangle-lines [dst rec thick color]
	"Draw rectangle lines within an image"
	(rl.ImageDrawRectangleLines dst rec thick color))

(fn image-draw-triangle [dst v1 v2 v3 color]
	"Draw triangle within an image"
	(rl.ImageDrawTriangle dst v1 v2 v3 color))

(fn image-draw-triangle-ex [dst v1 v2 v3 c1 c2 c3]
	"Draw triangle with interpolated colors within an image"
	(rl.ImageDrawTriangleEx dst v1 v2 v3 c1 c2 c3))

(fn image-draw-triangle-lines [dst v1 v2 v3 color]
	"Draw triangle outline within an image"
	(rl.ImageDrawTriangleLines dst v1 v2 v3 color))

(fn image-draw-triangle-fan [dst points point-count color]
	"Draw a triangle fan defined by points within an image (first vertex is the center)"
	(rl.ImageDrawTriangleFan dst points point-count color))

(fn image-draw-triangle-strip [dst points point-count color]
	"Draw a triangle strip defined by points within an image"
	(rl.ImageDrawTriangleStrip dst points point-count color))

(fn image-draw [dst src src-rec dst-rec tint]
	"Draw a source image within a destination image (tint applied to source)"
	(rl.ImageDraw dst src src-rec dst-rec tint))

(fn image-draw-text [dst text pos-x pos-y font-size color]
	"Draw text (using default font) within an image (destination)"
	(rl.ImageDrawText dst text pos-x pos-y font-size color))

(fn image-draw-text-ex [dst font text position font-size spacing tint]
	"Draw text (custom sprite font) within an image (destination)"
	(rl.ImageDrawTextEx dst font text position font-size spacing tint))

; Texture loading functions
; NOTE: These functions require GPU access
(fn load-texture [file-name]
	"Load texture from file into GPU memory (VRAM)"
	(rl.LoadTexture file-name))

(fn load-texture-from-image [image]
	"Load texture from image data"
	(rl.LoadTextureFromImage image))

(fn load-texture-cubemap [image layout]
	"Load cubemap from image, multiple image cubemap layouts supported"
	(rl.LoadTextureCubemap image layout))

(fn load-render-texture [width height]
	"Load texture for rendering (framebuffer)"
	(rl.LoadRenderTexture width height))

(fn is-texture-valid [texture]
	"Check if a texture is valid (loaded in GPU)"
	(rl.IsTextureValid texture))

(fn unload-texture [texture]
	"Unload texture from GPU memory (VRAM)"
	(rl.UnloadTexture texture))

(fn is-render-texture-valid [target]
	"Check if a render texture is valid (loaded in GPU)"
	(rl.IsRenderTextureValid target))

(fn unload-render-texture [target]
	"Unload render texture from GPU memory (VRAM)"
	(rl.UnloadRenderTexture target))

(fn update-texture [texture pixels]
	"Update GPU texture with new data"
	(rl.UpdateTexture texture pixels))

(fn update-texture-rec [texture rec pixels]
	"Update GPU texture rectangle with new data"
	(rl.UpdateTextureRec texture rec pixels))

; Texture configuration functions
(fn gen-texture-mipmaps [texture]
	"Generate GPU mipmaps for a texture"
	(rl.GenTextureMipmaps texture))

(fn set-texture-filter [texture filter]
	"Set texture scaling filter mode"
	(rl.SetTextureFilter texture filter))

(fn set-texture-wrap [texture wrap]
	"Set texture wrapping mode"
	(rl.SetTextureWrap texture wrap))

; Texture drawing functions
(fn draw-texture [texture pos-x pos-y tint]
	"Draw a Texture2D"
	(rl.DrawTexture texture pos-x pos-y tint))

(fn draw-texture-v [texture position tint]
	"Draw a Texture2D with position defined as Vector2"
	(rl.DrawTextureV texture position tint))

(fn draw-texture-ex [texture position rotation scale tint]
	"Draw a Texture2D with extended parameters"
	(rl.DrawTextureEx texture position rotation scale tint))

(fn draw-texture-rec [texture source position tint]
	"Draw a part of a texture defined by a rectangle"
	(rl.DrawTextureRec texture source position tint))

(fn draw-texture-pro [texture source dest origin rotation tint]
	"Draw a part of a texture defined by a rectangle with 'pro' parameters"
	(rl.DrawTexturePro texture source dest origin rotation tint))

(fn draw-texture-npatch [texture n-patch-info dest origin rotation tint]
	"Draws a texture (or part of it) that stretches or shrinks nicely"
	(rl.DrawTextureNPatch texture n-patch-info dest origin rotation tint))

; Color/pixel related functions
(fn color-is-equal [col1 col2]
	"Check if two colors are equal"
	(rl.ColorIsEqual col1 col2))

(fn fade [color alpha]
	"Get color with alpha applied, alpha goes from 0.0f to 1.0f"
	(rl.Fade color alpha))

(fn color-to-int [color]
	"Get hexadecimal value for a Color (0xRRGGBBAA)"
	(rl.ColorToInt color))

(fn color-normalize [color]
	"Get Color normalized as float [0..1]"
	(rl.ColorNormalize color))

(fn color-from-normalized [normalized]
	"Get Color from normalized values [0..1]"
	(rl.ColorFromNormalized normalized))

(fn color-to-hsv [color]
	"Get HSV values for a Color, hue [0..360], saturation/value [0..1]"
	(rl.ColorToHSV color))

(fn color-from-hsv [hue saturation value]
	"Get a Color from HSV values, hue [0..360], saturation/value [0..1]"
	(rl.ColorFromHSV hue saturation value))

(fn color-tint [color tint]
	"Get color multiplied with another color"
	(rl.ColorTint color tint))

(fn color-brightness [color factor]
	"Get color with brightness correction, brightness factor goes from -1.0f to 1.0f"
	(rl.ColorBrightness color factor))

(fn color-contrast [color contrast]
	"Get color with contrast correction, contrast values between -1.0f and 1.0f"
	(rl.ColorContrast color contrast))

(fn color-alpha [color alpha]
	"Get color with alpha applied, alpha goes from 0.0f to 1.0f"
	(rl.ColorAlpha color alpha))

(fn color-alpha-blend [dst src tint]
	"Get src alpha-blended into dst color with tint"
	(rl.ColorAlphaBlend dst src tint))

(fn color-lerp [color1 color2 factor]
	"Get color lerp interpolation between two colors, factor [0.0f..1.0f]"
	(rl.ColorLerp color1 color2 factor))

(fn get-color [hex-value]
	"Get Color structure from hexadecimal value"
	(rl.GetColor hex-value))

(fn get-pixel-color [src-ptr format]
	"Get Color from a source pixel pointer of certain format"
	(rl.GetPixelColor src-ptr format))

(fn set-pixel-color [dst-ptr color format]
	"Set color formatted into destination pixel pointer"
	(rl.SetPixelColor dst-ptr color format))

(fn get-pixel-data-size [width height format]
	"Get pixel data size in bytes for certain format"
	(rl.GetPixelDataSize width height format))

;------------------------------------------------------------------------------------
; Font Loading and Text Drawing Functions (Module: text)
;------------------------------------------------------------------------------------
; Font loading/unloading functions
(fn get-font-default []
	"Get the default Font"
	(rl.GetFontDefault ))

(fn load-font [file-name]
	"Load font from file into GPU memory (VRAM)"
	(rl.LoadFont file-name))

(fn load-font-ex [file-name font-size codepoints codepoint-count]
	"Load font from file with extended parameters, use NULL for codepoints and 0 for codepointCount to load the default character set, font size is provided in pixels height"
	(rl.LoadFontEx file-name font-size codepoints codepoint-count))

(fn load-font-from-image [image key first-char]
	"Load font from Image (XNA style)"
	(rl.LoadFontFromImage image key first-char))

(fn load-font-from-memory [file-type file-data data-size font-size codepoints codepoint-count]
	"Load font from memory buffer, fileType refers to extension: i.e. '.ttf'"
	(rl.LoadFontFromMemory file-type file-data data-size font-size codepoints codepoint-count))

(fn is-font-valid [font]
	"Check if a font is valid (font data loaded, WARNING: GPU texture not checked)"
	(rl.IsFontValid font))

(fn load-font-data [file-data data-size font-size codepoints codepoint-count type]
	"Load font data for further use"
	(rl.LoadFontData file-data data-size font-size codepoints codepoint-count type))

(fn gen-image-font-atlas [glyphs glyph-recs glyph-count font-size padding pack-method]
	"Generate image font atlas using chars info"
	(rl.GenImageFontAtlas glyphs glyph-recs glyph-count font-size padding pack-method))

(fn unload-font-data [glyphs glyph-count]
	"Unload font chars info data (RAM)"
	(rl.UnloadFontData glyphs glyph-count))

(fn unload-font [font]
	"Unload font from GPU memory (VRAM)"
	(rl.UnloadFont font))

(fn export-font-as-code [font file-name]
	"Export font as code file, returns true on success"
	(rl.ExportFontAsCode font file-name))

; Text drawing functions
(fn draw-fps [pos-x pos-y]
	"Draw current FPS"
	(rl.DrawFPS pos-x pos-y))

(fn draw-text [text pos-x pos-y font-size color]
	"Draw text (using default font)"
	(rl.DrawText text pos-x pos-y font-size color))

(fn draw-text-ex [font text position font-size spacing tint]
	"Draw text using font and additional parameters"
	(rl.DrawTextEx font text position font-size spacing tint))

(fn draw-text-pro [font text position origin rotation font-size spacing tint]
	"Draw text using Font and pro parameters (rotation)"
	(rl.DrawTextPro font text position origin rotation font-size spacing tint))

(fn draw-text-codepoint [font codepoint position font-size tint]
	"Draw one character (codepoint)"
	(rl.DrawTextCodepoint font codepoint position font-size tint))

(fn draw-text-codepoints [font codepoints codepoint-count position font-size spacing tint]
	"Draw multiple character (codepoint)"
	(rl.DrawTextCodepoints font codepoints codepoint-count position font-size spacing tint))

; Text font info functions
(fn set-text-line-spacing [spacing]
	"Set vertical line spacing when drawing with line-breaks"
	(rl.SetTextLineSpacing spacing))

(fn measure-text [text font-size]
	"Measure string width for default font"
	(rl.MeasureText text font-size))

(fn measure-text-ex [font text font-size spacing]
	"Measure string size for Font"
	(rl.MeasureTextEx font text font-size spacing))

(fn get-glyph-index [font codepoint]
	"Get glyph index position in font for a codepoint (unicode character), fallback to '?' if not found"
	(rl.GetGlyphIndex font codepoint))

(fn get-glyph-info [font codepoint]
	"Get glyph font info data for a codepoint (unicode character), fallback to '?' if not found"
	(rl.GetGlyphInfo font codepoint))

(fn get-glyph-atlas-rec [font codepoint]
	"Get glyph rectangle in font atlas for a codepoint (unicode character), fallback to '?' if not found"
	(rl.GetGlyphAtlasRec font codepoint))

; Text codepoints management functions (unicode characters)
(fn load-utf8 [codepoints llength]
	"Load UTF-8 text encoded from codepoints array"
	(rl.LoadUTF8 codepoints llength))

(fn unload-utf8 [text]
	"Unload UTF-8 text encoded from codepoints array"
	(rl.UnloadUTF8 text))

(fn load-codepoints [text count]
	"Load all codepoints from a UTF-8 text string, codepoints count returned by parameter"
	(rl.LoadCodepoints text count))

(fn unload-codepoints [codepoints]
	"Unload codepoints data from memory"
	(rl.UnloadCodepoints codepoints))

(fn get-codepoint-count [text]
	"Get total number of codepoints in a UTF-8 encoded string"
	(rl.GetCodepointCount text))

(fn get-codepoint [text codepoint-size]
	"Get next codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure"
	(rl.GetCodepoint text codepoint-size))

(fn get-codepoint-next [text codepoint-size]
	"Get next codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure"
	(rl.GetCodepointNext text codepoint-size))

(fn get-codepoint-previous [text codepoint-size]
	"Get previous codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure"
	(rl.GetCodepointPrevious text codepoint-size))

(fn codepoint-to-utf8 [codepoint utf8size]
	"Encode one codepoint into UTF-8 byte array (array length returned as parameter)"
	(rl.CodepointToUTF8 codepoint utf8size))

; Text strings management functions (no UTF-8 strings, only byte chars)
; NOTE: Some strings allocate memory internally for returned strings, just be careful!
(fn text-copy [dst src]
	"Copy one string to another, returns bytes copied"
	(rl.TextCopy dst src))

(fn text-is-equal [text1 text2]
	"Check if two text string are equal"
	(rl.TextIsEqual text1 text2))

(fn text-length [text]
	"Get text length, checks for '\0' ending"
	(rl.TextLength text))

(fn text-format [text ]
	"Text formatting with variables (sprintf() style)"
	(rl.TextFormat text ))

(fn text-subtext [text position llength]
	"Get a piece of a text string"
	(rl.TextSubtext text position llength))

(fn text-replace [text replace by]
	"Replace text string (WARNING: memory must be freed!)"
	(rl.TextReplace text replace by))

(fn text-insert [text insert position]
	"Insert text in a position (WARNING: memory must be freed!)"
	(rl.TextInsert text insert position))

(fn text-join [text-list count delimiter]
	"Join text strings with delimiter"
	(rl.TextJoin text-list count delimiter))

(fn text-split [text delimiter count]
	"Split text into multiple strings"
	(rl.TextSplit text delimiter count))

(fn text-append [text append position]
	"Append text at specific position and move cursor!"
	(rl.TextAppend text append position))

(fn text-find-index [text find]
	"Find first text occurrence within a string"
	(rl.TextFindIndex text find))

(fn text-to-upper [text]
	"Get upper case version of provided string"
	(rl.TextToUpper text))

(fn text-to-lower [text]
	"Get lower case version of provided string"
	(rl.TextToLower text))

(fn text-to-pascal [text]
	"Get Pascal case notation version of provided string"
	(rl.TextToPascal text))

(fn text-to-snake [text]
	"Get Snake case notation version of provided string"
	(rl.TextToSnake text))

(fn text-to-camel [text]
	"Get Camel case notation version of provided string"
	(rl.TextToCamel text))

(fn text-to-integer [text]
	"Get integer value from text (negative values not supported)"
	(rl.TextToInteger text))

(fn text-to-float [text]
	"Get float value from text (negative values not supported)"
	(rl.TextToFloat text))

;------------------------------------------------------------------------------------
; Basic 3d Shapes Drawing Functions (Module: models)
;------------------------------------------------------------------------------------
; Basic geometric 3D shapes drawing functions
(fn draw-line3d [start-pos end-pos color]
	"Draw a line in 3D world space"
	(rl.DrawLine3D start-pos end-pos color))

(fn draw-point3d [position color]
	"Draw a point in 3D space, actually a small line"
	(rl.DrawPoint3D position color))

(fn draw-circle3d [center radius rotation-axis rotation-angle color]
	"Draw a circle in 3D world space"
	(rl.DrawCircle3D center radius rotation-axis rotation-angle color))

(fn draw-triangle3d [v1 v2 v3 color]
	"Draw a color-filled triangle (vertex in counter-clockwise order!)"
	(rl.DrawTriangle3D v1 v2 v3 color))

(fn draw-triangle-strip3d [points point-count color]
	"Draw a triangle strip defined by points"
	(rl.DrawTriangleStrip3D points point-count color))

(fn draw-cube [position width height llength color]
	"Draw cube"
	(rl.DrawCube position width height llength color))

(fn draw-cube-v [position size color]
	"Draw cube (Vector version)"
	(rl.DrawCubeV position size color))

(fn draw-cube-wires [position width height llength color]
	"Draw cube wires"
	(rl.DrawCubeWires position width height llength color))

(fn draw-cube-wires-v [position size color]
	"Draw cube wires (Vector version)"
	(rl.DrawCubeWiresV position size color))

(fn draw-sphere [center-pos radius color]
	"Draw sphere"
	(rl.DrawSphere center-pos radius color))

(fn draw-sphere-ex [center-pos radius rings slices color]
	"Draw sphere with extended parameters"
	(rl.DrawSphereEx center-pos radius rings slices color))

(fn draw-sphere-wires [center-pos radius rings slices color]
	"Draw sphere wires"
	(rl.DrawSphereWires center-pos radius rings slices color))

(fn draw-cylinder [position radius-top radius-bottom height slices color]
	"Draw a cylinder/cone"
	(rl.DrawCylinder position radius-top radius-bottom height slices color))

(fn draw-cylinder-ex [start-pos end-pos start-radius end-radius sides color]
	"Draw a cylinder with base at startPos and top at endPos"
	(rl.DrawCylinderEx start-pos end-pos start-radius end-radius sides color))

(fn draw-cylinder-wires [position radius-top radius-bottom height slices color]
	"Draw a cylinder/cone wires"
	(rl.DrawCylinderWires position radius-top radius-bottom height slices color))

(fn draw-cylinder-wires-ex [start-pos end-pos start-radius end-radius sides color]
	"Draw a cylinder wires with base at startPos and top at endPos"
	(rl.DrawCylinderWiresEx start-pos end-pos start-radius end-radius sides color))

(fn draw-capsule [start-pos end-pos radius slices rings color]
	"Draw a capsule with the center of its sphere caps at startPos and endPos"
	(rl.DrawCapsule start-pos end-pos radius slices rings color))

(fn draw-capsule-wires [start-pos end-pos radius slices rings color]
	"Draw capsule wireframe with the center of its sphere caps at startPos and endPos"
	(rl.DrawCapsuleWires start-pos end-pos radius slices rings color))

(fn draw-plane [center-pos size color]
	"Draw a plane XZ"
	(rl.DrawPlane center-pos size color))

(fn draw-ray [ray color]
	"Draw a ray line"
	(rl.DrawRay ray color))

(fn draw-grid [slices spacing]
	"Draw a grid (centered at (0, 0, 0))"
	(rl.DrawGrid slices spacing))

;------------------------------------------------------------------------------------
; Model 3d Loading and Drawing Functions (Module: models)
;------------------------------------------------------------------------------------
; Model management functions
(fn load-model [file-name]
	"Load model from files (meshes and materials)"
	(rl.LoadModel file-name))

(fn load-model-from-mesh [mesh]
	"Load model from generated mesh (default material)"
	(rl.LoadModelFromMesh mesh))

(fn is-model-valid [model]
	"Check if a model is valid (loaded in GPU, VAO/VBOs)"
	(rl.IsModelValid model))

(fn unload-model [model]
	"Unload model (including meshes) from memory (RAM and/or VRAM)"
	(rl.UnloadModel model))

(fn get-model-bounding-box [model]
	"Compute model bounding box limits (considers all meshes)"
	(rl.GetModelBoundingBox model))

; Model drawing functions
(fn draw-model [model position scale tint]
	"Draw a model (with texture if set)"
	(rl.DrawModel model position scale tint))

(fn draw-model-ex [model position rotation-axis rotation-angle scale tint]
	"Draw a model with extended parameters"
	(rl.DrawModelEx model position rotation-axis rotation-angle scale tint))

(fn draw-model-wires [model position scale tint]
	"Draw a model wires (with texture if set)"
	(rl.DrawModelWires model position scale tint))

(fn draw-model-wires-ex [model position rotation-axis rotation-angle scale tint]
	"Draw a model wires (with texture if set) with extended parameters"
	(rl.DrawModelWiresEx model position rotation-axis rotation-angle scale tint))

(fn draw-model-points [model position scale tint]
	"Draw a model as points"
	(rl.DrawModelPoints model position scale tint))

(fn draw-model-points-ex [model position rotation-axis rotation-angle scale tint]
	"Draw a model as points with extended parameters"
	(rl.DrawModelPointsEx model position rotation-axis rotation-angle scale tint))

(fn draw-bounding-box [box color]
	"Draw bounding box (wires)"
	(rl.DrawBoundingBox box color))

(fn draw-billboard [camera texture position scale tint]
	"Draw a billboard texture"
	(rl.DrawBillboard camera texture position scale tint))

(fn draw-billboard-rec [camera texture source position size tint]
	"Draw a billboard texture defined by source"
	(rl.DrawBillboardRec camera texture source position size tint))

(fn draw-billboard-pro [camera texture source position up size origin rotation tint]
	"Draw a billboard texture defined by source and rotation"
	(rl.DrawBillboardPro camera texture source position up size origin rotation tint))

; Mesh management functions
(fn upload-mesh [mesh dynamic]
	"Upload mesh vertex data in GPU and provide VAO/VBO ids"
	(rl.UploadMesh mesh dynamic))

(fn update-mesh-buffer [mesh index data data-size offset]
	"Update mesh vertex data in GPU for a specific buffer index"
	(rl.UpdateMeshBuffer mesh index data data-size offset))

(fn unload-mesh [mesh]
	"Unload mesh data from CPU and GPU"
	(rl.UnloadMesh mesh))

(fn draw-mesh [mesh material transform]
	"Draw a 3d mesh with material and transform"
	(rl.DrawMesh mesh material transform))

(fn draw-mesh-instanced [mesh material transforms instances]
	"Draw multiple mesh instances with material and different transforms"
	(rl.DrawMeshInstanced mesh material transforms instances))

(fn get-mesh-bounding-box [mesh]
	"Compute mesh bounding box limits"
	(rl.GetMeshBoundingBox mesh))

(fn gen-mesh-tangents [mesh]
	"Compute mesh tangents"
	(rl.GenMeshTangents mesh))

(fn export-mesh [mesh file-name]
	"Export mesh data to file, returns true on success"
	(rl.ExportMesh mesh file-name))

(fn export-mesh-as-code [mesh file-name]
	"Export mesh as code file (.h) defining multiple arrays of vertex attributes"
	(rl.ExportMeshAsCode mesh file-name))

; Mesh generation functions
(fn gen-mesh-poly [sides radius]
	"Generate polygonal mesh"
	(rl.GenMeshPoly sides radius))

(fn gen-mesh-plane [width llength res-x res-z]
	"Generate plane mesh (with subdivisions)"
	(rl.GenMeshPlane width llength res-x res-z))

(fn gen-mesh-cube [width height llength]
	"Generate cuboid mesh"
	(rl.GenMeshCube width height llength))

(fn gen-mesh-sphere [radius rings slices]
	"Generate sphere mesh (standard sphere)"
	(rl.GenMeshSphere radius rings slices))

(fn gen-mesh-hemi-sphere [radius rings slices]
	"Generate half-sphere mesh (no bottom cap)"
	(rl.GenMeshHemiSphere radius rings slices))

(fn gen-mesh-cylinder [radius height slices]
	"Generate cylinder mesh"
	(rl.GenMeshCylinder radius height slices))

(fn gen-mesh-cone [radius height slices]
	"Generate cone/pyramid mesh"
	(rl.GenMeshCone radius height slices))

(fn gen-mesh-torus [radius size rad-seg sides]
	"Generate torus mesh"
	(rl.GenMeshTorus radius size rad-seg sides))

(fn gen-mesh-knot [radius size rad-seg sides]
	"Generate trefoil knot mesh"
	(rl.GenMeshKnot radius size rad-seg sides))

(fn gen-mesh-heightmap [heightmap size]
	"Generate heightmap mesh from image data"
	(rl.GenMeshHeightmap heightmap size))

(fn gen-mesh-cubicmap [cubicmap cube-size]
	"Generate cubes-based map mesh from image data"
	(rl.GenMeshCubicmap cubicmap cube-size))

; Material loading/unloading functions
(fn load-materials [file-name material-count]
	"Load materials from model file"
	(rl.LoadMaterials file-name material-count))

(fn load-material-default []
	"Load default material (Supports: DIFFUSE, SPECULAR, NORMAL maps)"
	(rl.LoadMaterialDefault ))

(fn is-material-valid [material]
	"Check if a material is valid (shader assigned, map textures loaded in GPU)"
	(rl.IsMaterialValid material))

(fn unload-material [material]
	"Unload material from GPU memory (VRAM)"
	(rl.UnloadMaterial material))

(fn set-material-texture [material map-type texture]
	"Set texture for a material map type (MATERIAL_MAP_DIFFUSE, MATERIAL_MAP_SPECULAR...)"
	(rl.SetMaterialTexture material map-type texture))

(fn set-model-mesh-material [model mesh-id material-id]
	"Set material for a mesh"
	(rl.SetModelMeshMaterial model mesh-id material-id))

; Model animations loading/unloading functions
(fn load-model-animations [file-name anim-count]
	"Load model animations from file"
	(rl.LoadModelAnimations file-name anim-count))

(fn update-model-animation [model anim frame]
	"Update model animation pose (CPU)"
	(rl.UpdateModelAnimation model anim frame))

(fn update-model-animation-bones [model anim frame]
	"Update model animation mesh bone matrices (GPU skinning)"
	(rl.UpdateModelAnimationBones model anim frame))

(fn unload-model-animation [anim]
	"Unload animation data"
	(rl.UnloadModelAnimation anim))

(fn unload-model-animations [animations anim-count]
	"Unload animation array data"
	(rl.UnloadModelAnimations animations anim-count))

(fn is-model-animation-valid [model anim]
	"Check model animation skeleton match"
	(rl.IsModelAnimationValid model anim))

; Collision detection functions
(fn check-collision-spheres [center1 radius1 center2 radius2]
	"Check collision between two spheres"
	(rl.CheckCollisionSpheres center1 radius1 center2 radius2))

(fn check-collision-boxes [box1 box2]
	"Check collision between two bounding boxes"
	(rl.CheckCollisionBoxes box1 box2))

(fn check-collision-box-sphere [box center radius]
	"Check collision between box and sphere"
	(rl.CheckCollisionBoxSphere box center radius))

(fn get-ray-collision-sphere [ray center radius]
	"Get collision info between ray and sphere"
	(rl.GetRayCollisionSphere ray center radius))

(fn get-ray-collision-box [ray box]
	"Get collision info between ray and box"
	(rl.GetRayCollisionBox ray box))

(fn get-ray-collision-mesh [ray mesh transform]
	"Get collision info between ray and mesh"
	(rl.GetRayCollisionMesh ray mesh transform))

(fn get-ray-collision-triangle [ray p1 p2 p3]
	"Get collision info between ray and triangle"
	(rl.GetRayCollisionTriangle ray p1 p2 p3))

(fn get-ray-collision-quad [ray p1 p2 p3 p4]
	"Get collision info between ray and quad"
	(rl.GetRayCollisionQuad ray p1 p2 p3 p4))

;------------------------------------------------------------------------------------
; Audio Loading and Playing Functions (Module: audio)
;------------------------------------------------------------------------------------
; Audio device management functions
(fn init-audio-device []
	"Initialize audio device and context"
	(rl.InitAudioDevice ))

(fn close-audio-device []
	"Close the audio device and context"
	(rl.CloseAudioDevice ))

(fn is-audio-device-ready []
	"Check if audio device has been initialized successfully"
	(rl.IsAudioDeviceReady ))

(fn set-master-volume [volume]
	"Set master volume (listener)"
	(rl.SetMasterVolume volume))

(fn get-master-volume []
	"Get master volume (listener)"
	(rl.GetMasterVolume ))

; Wave/Sound loading/unloading functions
(fn load-wave [file-name]
	"Load wave data from file"
	(rl.LoadWave file-name))

(fn load-wave-from-memory [file-type file-data data-size]
	"Load wave from memory buffer, fileType refers to extension: i.e. '.wav'"
	(rl.LoadWaveFromMemory file-type file-data data-size))

(fn is-wave-valid [wave]
	"Checks if wave data is valid (data loaded and parameters)"
	(rl.IsWaveValid wave))

(fn load-sound [file-name]
	"Load sound from file"
	(rl.LoadSound file-name))

(fn load-sound-from-wave [wave]
	"Load sound from wave data"
	(rl.LoadSoundFromWave wave))

(fn load-sound-alias [source]
	"Create a new sound that shares the same sample data as the source sound, does not own the sound data"
	(rl.LoadSoundAlias source))

(fn is-sound-valid [sound]
	"Checks if a sound is valid (data loaded and buffers initialized)"
	(rl.IsSoundValid sound))

(fn update-sound [sound data sample-count]
	"Update sound buffer with new data"
	(rl.UpdateSound sound data sample-count))

(fn unload-wave [wave]
	"Unload wave data"
	(rl.UnloadWave wave))

(fn unload-sound [sound]
	"Unload sound"
	(rl.UnloadSound sound))

(fn unload-sound-alias [alias]
	"Unload a sound alias (does not deallocate sample data)"
	(rl.UnloadSoundAlias alias))

(fn export-wave [wave file-name]
	"Export wave data to file, returns true on success"
	(rl.ExportWave wave file-name))

(fn export-wave-as-code [wave file-name]
	"Export wave sample data to code (.h), returns true on success"
	(rl.ExportWaveAsCode wave file-name))

; Wave/Sound management functions
(fn play-sound [sound]
	"Play a sound"
	(rl.PlaySound sound))

(fn stop-sound [sound]
	"Stop playing a sound"
	(rl.StopSound sound))

(fn pause-sound [sound]
	"Pause a sound"
	(rl.PauseSound sound))

(fn resume-sound [sound]
	"Resume a paused sound"
	(rl.ResumeSound sound))

(fn is-sound-playing [sound]
	"Check if a sound is currently playing"
	(rl.IsSoundPlaying sound))

(fn set-sound-volume [sound volume]
	"Set volume for a sound (1.0 is max level)"
	(rl.SetSoundVolume sound volume))

(fn set-sound-pitch [sound pitch]
	"Set pitch for a sound (1.0 is base level)"
	(rl.SetSoundPitch sound pitch))

(fn set-sound-pan [sound pan]
	"Set pan for a sound (0.5 is center)"
	(rl.SetSoundPan sound pan))

(fn wave-copy [wave]
	"Copy a wave to a new wave"
	(rl.WaveCopy wave))

(fn wave-crop [wave init-frame final-frame]
	"Crop a wave to defined frames range"
	(rl.WaveCrop wave init-frame final-frame))

(fn wave-format [wave sample-rate sample-size channels]
	"Convert wave data to desired format"
	(rl.WaveFormat wave sample-rate sample-size channels))

(fn load-wave-samples [wave]
	"Load samples data from wave as a 32bit float data array"
	(rl.LoadWaveSamples wave))

(fn unload-wave-samples [samples]
	"Unload samples data loaded with LoadWaveSamples()"
	(rl.UnloadWaveSamples samples))

; Music management functions
(fn load-music-stream [file-name]
	"Load music stream from file"
	(rl.LoadMusicStream file-name))

(fn load-music-stream-from-memory [file-type data data-size]
	"Load music stream from data"
	(rl.LoadMusicStreamFromMemory file-type data data-size))

(fn is-music-valid [music]
	"Checks if a music stream is valid (context and buffers initialized)"
	(rl.IsMusicValid music))

(fn unload-music-stream [music]
	"Unload music stream"
	(rl.UnloadMusicStream music))

(fn play-music-stream [music]
	"Start music playing"
	(rl.PlayMusicStream music))

(fn is-music-stream-playing [music]
	"Check if music is playing"
	(rl.IsMusicStreamPlaying music))

(fn update-music-stream [music]
	"Updates buffers for music streaming"
	(rl.UpdateMusicStream music))

(fn stop-music-stream [music]
	"Stop music playing"
	(rl.StopMusicStream music))

(fn pause-music-stream [music]
	"Pause music playing"
	(rl.PauseMusicStream music))

(fn resume-music-stream [music]
	"Resume playing paused music"
	(rl.ResumeMusicStream music))

(fn seek-music-stream [music position]
	"Seek music to a position (in seconds)"
	(rl.SeekMusicStream music position))

(fn set-music-volume [music volume]
	"Set volume for music (1.0 is max level)"
	(rl.SetMusicVolume music volume))

(fn set-music-pitch [music pitch]
	"Set pitch for a music (1.0 is base level)"
	(rl.SetMusicPitch music pitch))

(fn set-music-pan [music pan]
	"Set pan for a music (0.5 is center)"
	(rl.SetMusicPan music pan))

(fn get-music-time-length [music]
	"Get music time length (in seconds)"
	(rl.GetMusicTimeLength music))

(fn get-music-time-played [music]
	"Get current music time played (in seconds)"
	(rl.GetMusicTimePlayed music))

; AudioStream management functions
(fn load-audio-stream [sample-rate sample-size channels]
	"Load audio stream (to stream raw audio pcm data)"
	(rl.LoadAudioStream sample-rate sample-size channels))

(fn is-audio-stream-valid [stream]
	"Checks if an audio stream is valid (buffers initialized)"
	(rl.IsAudioStreamValid stream))

(fn unload-audio-stream [stream]
	"Unload audio stream and free memory"
	(rl.UnloadAudioStream stream))

(fn update-audio-stream [stream data frame-count]
	"Update audio stream buffers with data"
	(rl.UpdateAudioStream stream data frame-count))

(fn is-audio-stream-processed [stream]
	"Check if any audio stream buffers requires refill"
	(rl.IsAudioStreamProcessed stream))

(fn play-audio-stream [stream]
	"Play audio stream"
	(rl.PlayAudioStream stream))

(fn pause-audio-stream [stream]
	"Pause audio stream"
	(rl.PauseAudioStream stream))

(fn resume-audio-stream [stream]
	"Resume audio stream"
	(rl.ResumeAudioStream stream))

(fn is-audio-stream-playing [stream]
	"Check if audio stream is playing"
	(rl.IsAudioStreamPlaying stream))

(fn stop-audio-stream [stream]
	"Stop audio stream"
	(rl.StopAudioStream stream))

(fn set-audio-stream-volume [stream volume]
	"Set volume for audio stream (1.0 is max level)"
	(rl.SetAudioStreamVolume stream volume))

(fn set-audio-stream-pitch [stream pitch]
	"Set pitch for audio stream (1.0 is base level)"
	(rl.SetAudioStreamPitch stream pitch))

(fn set-audio-stream-pan [stream pan]
	"Set pan for audio stream (0.5 is centered)"
	(rl.SetAudioStreamPan stream pan))

(fn set-audio-stream-buffer-size-default [size]
	"Default size for new audio streams"
	(rl.SetAudioStreamBufferSizeDefault size))

(fn set-audio-stream-callback [stream callback]
	"Audio thread callback to request new data"
	(rl.SetAudioStreamCallback stream callback))

(fn attach-audio-stream-processor [stream processor]
	"Attach audio stream processor to stream, receives the samples as 'float'"
	(rl.AttachAudioStreamProcessor stream processor))

(fn detach-audio-stream-processor [stream processor]
	"Detach audio stream processor from stream"
	(rl.DetachAudioStreamProcessor stream processor))

(fn attach-audio-mixed-processor [processor]
	"Attach audio stream processor to the entire audio pipeline, receives the samples as 'float'"
	(rl.AttachAudioMixedProcessor processor))

(fn detach-audio-mixed-processor [processor]
	"Detach audio stream processor from the entire audio pipeline"
	(rl.DetachAudioMixedProcessor processor))



; COLORS BLOCK
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


; EXPORT BLOCK
{: safe-mode
 : Vector2
 : Vector3
 : Vector4
 : Quaternion
 : Matrix
 : Color
 : Rectangle
 : Image
 : Texture
 : Texture2D
 : TextureCubemap
 : RenderTexture
 : RenderTexture2D
 : NPatchInfo
 : GlyphInfo
 : Font
 : Camera3D
 : Camera
 : Camera2D
 : Mesh
 : Shader
 : MaterialMap
 : Material
 : Transform
 : BoneInfo
 : Model
 : ModelAnimation
 : Ray
 : RayCollision
 : BoundingBox
 : Wave
 : AudioStream
 : Sound
 : Music
 : VrDeviceInfo
 : VrStereoConfig
 : FilePathList
 : AutomationEvent
 : AutomationEventList
 : flag-vsync-hint
 : flag-fullscreen-mode
 : flag-window-resizable
 : flag-window-undecorated
 : flag-window-hidden
 : flag-window-minimized
 : flag-window-maximized
 : flag-window-unfocused
 : flag-window-topmost
 : flag-window-always-run
 : flag-window-transparent
 : flag-window-highdpi
 : flag-window-mouse-passthrough
 : flag-borderless-windowed-mode
 : flag-msaa-4x-hint
 : flag-interlaced-hint
 : log-all
 : log-trace
 : log-debug
 : log-info
 : log-warning
 : log-error
 : log-fatal
 : log-none
 : key-null
 : key-apostrophe
 : key-comma
 : key-minus
 : key-period
 : key-slash
 : key-zero
 : key-one
 : key-two
 : key-three
 : key-four
 : key-five
 : key-six
 : key-seven
 : key-eight
 : key-nine
 : key-semicolon
 : key-equal
 : key-a
 : key-b
 : key-c
 : key-d
 : key-e
 : key-f
 : key-g
 : key-h
 : key-i
 : key-j
 : key-k
 : key-l
 : key-m
 : key-n
 : key-o
 : key-p
 : key-q
 : key-r
 : key-s
 : key-t
 : key-u
 : key-v
 : key-w
 : key-x
 : key-y
 : key-z
 : key-left-bracket
 : key-backslash
 : key-right-bracket
 : key-grave
 : key-space
 : key-escape
 : key-enter
 : key-tab
 : key-backspace
 : key-insert
 : key-delete
 : key-right
 : key-left
 : key-down
 : key-up
 : key-page-up
 : key-page-down
 : key-home
 : key-end
 : key-caps-lock
 : key-scroll-lock
 : key-num-lock
 : key-print-screen
 : key-pause
 : key-f1
 : key-f2
 : key-f3
 : key-f4
 : key-f5
 : key-f6
 : key-f7
 : key-f8
 : key-f9
 : key-f10
 : key-f11
 : key-f12
 : key-left-shift
 : key-left-control
 : key-left-alt
 : key-left-super
 : key-right-shift
 : key-right-control
 : key-right-alt
 : key-right-super
 : key-kb-menu
 : key-kp-0
 : key-kp-1
 : key-kp-2
 : key-kp-3
 : key-kp-4
 : key-kp-5
 : key-kp-6
 : key-kp-7
 : key-kp-8
 : key-kp-9
 : key-kp-decimal
 : key-kp-divide
 : key-kp-multiply
 : key-kp-subtract
 : key-kp-add
 : key-kp-enter
 : key-kp-equal
 : key-back
 : key-menu
 : key-volume-up
 : key-volume-down
 : mouse-button-left
 : mouse-button-right
 : mouse-button-middle
 : mouse-button-side
 : mouse-button-extra
 : mouse-button-forward
 : mouse-button-back
 : mouse-cursor-default
 : mouse-cursor-arrow
 : mouse-cursor-ibeam
 : mouse-cursor-crosshair
 : mouse-cursor-pointing-hand
 : mouse-cursor-resize-ew
 : mouse-cursor-resize-ns
 : mouse-cursor-resize-nwse
 : mouse-cursor-resize-nesw
 : mouse-cursor-resize-all
 : mouse-cursor-not-allowed
 : gamepad-button-unknown
 : gamepad-button-left-face-up
 : gamepad-button-left-face-right
 : gamepad-button-left-face-down
 : gamepad-button-left-face-left
 : gamepad-button-right-face-up
 : gamepad-button-right-face-right
 : gamepad-button-right-face-down
 : gamepad-button-right-face-left
 : gamepad-button-left-trigger-1
 : gamepad-button-left-trigger-2
 : gamepad-button-right-trigger-1
 : gamepad-button-right-trigger-2
 : gamepad-button-middle-left
 : gamepad-button-middle
 : gamepad-button-middle-right
 : gamepad-button-left-thumb
 : gamepad-button-right-thumb
 : gamepad-axis-left-x
 : gamepad-axis-left-y
 : gamepad-axis-right-x
 : gamepad-axis-right-y
 : gamepad-axis-left-trigger
 : gamepad-axis-right-trigger
 : material-map-albedo
 : material-map-metalness
 : material-map-normal
 : material-map-roughness
 : material-map-occlusion
 : material-map-emission
 : material-map-height
 : material-map-cubemap
 : material-map-irradiance
 : material-map-prefilter
 : material-map-brdf
 : shader-loc-vertex-position
 : shader-loc-vertex-texcoord01
 : shader-loc-vertex-texcoord02
 : shader-loc-vertex-normal
 : shader-loc-vertex-tangent
 : shader-loc-vertex-color
 : shader-loc-matrix-mvp
 : shader-loc-matrix-view
 : shader-loc-matrix-projection
 : shader-loc-matrix-model
 : shader-loc-matrix-normal
 : shader-loc-vector-view
 : shader-loc-color-diffuse
 : shader-loc-color-specular
 : shader-loc-color-ambient
 : shader-loc-map-albedo
 : shader-loc-map-metalness
 : shader-loc-map-normal
 : shader-loc-map-roughness
 : shader-loc-map-occlusion
 : shader-loc-map-emission
 : shader-loc-map-height
 : shader-loc-map-cubemap
 : shader-loc-map-irradiance
 : shader-loc-map-prefilter
 : shader-loc-map-brdf
 : shader-loc-vertex-boneids
 : shader-loc-vertex-boneweights
 : shader-loc-bone-matrices
 : shader-uniform-float
 : shader-uniform-vec2
 : shader-uniform-vec3
 : shader-uniform-vec4
 : shader-uniform-int
 : shader-uniform-ivec2
 : shader-uniform-ivec3
 : shader-uniform-ivec4
 : shader-uniform-sampler2d
 : shader-attrib-float
 : shader-attrib-vec2
 : shader-attrib-vec3
 : shader-attrib-vec4
 : pixelformat-uncompressed-grayscale
 : pixelformat-uncompressed-gray-alpha
 : pixelformat-uncompressed-r5g6b5
 : pixelformat-uncompressed-r8g8b8
 : pixelformat-uncompressed-r5g5b5a1
 : pixelformat-uncompressed-r4g4b4a4
 : pixelformat-uncompressed-r8g8b8a8
 : pixelformat-uncompressed-r32
 : pixelformat-uncompressed-r32g32b32
 : pixelformat-uncompressed-r32g32b32a32
 : pixelformat-uncompressed-r16
 : pixelformat-uncompressed-r16g16b16
 : pixelformat-uncompressed-r16g16b16a16
 : pixelformat-compressed-dxt1-rgb
 : pixelformat-compressed-dxt1-rgba
 : pixelformat-compressed-dxt3-rgba
 : pixelformat-compressed-dxt5-rgba
 : pixelformat-compressed-etc1-rgb
 : pixelformat-compressed-etc2-rgb
 : pixelformat-compressed-etc2-eac-rgba
 : pixelformat-compressed-pvrt-rgb
 : pixelformat-compressed-pvrt-rgba
 : pixelformat-compressed-astc-4x4-rgba
 : pixelformat-compressed-astc-8x8-rgba
 : texture-filter-point
 : texture-filter-bilinear
 : texture-filter-trilinear
 : texture-filter-anisotropic-4x
 : texture-filter-anisotropic-8x
 : texture-filter-anisotropic-16x
 : texture-wrap-repeat
 : texture-wrap-clamp
 : texture-wrap-mirror-repeat
 : texture-wrap-mirror-clamp
 : cubemap-layout-auto-detect
 : cubemap-layout-line-vertical
 : cubemap-layout-line-horizontal
 : cubemap-layout-cross-three-by-four
 : cubemap-layout-cross-four-by-three
 : font-default
 : font-bitmap
 : font-sdf
 : blend-alpha
 : blend-additive
 : blend-multiplied
 : blend-add-colors
 : blend-subtract-colors
 : blend-alpha-premultiply
 : blend-custom
 : blend-custom-separate
 : gesture-none
 : gesture-tap
 : gesture-doubletap
 : gesture-hold
 : gesture-drag
 : gesture-swipe-right
 : gesture-swipe-left
 : gesture-swipe-up
 : gesture-swipe-down
 : gesture-pinch-in
 : gesture-pinch-out
 : camera-custom
 : camera-free
 : camera-orbital
 : camera-first-person
 : camera-third-person
 : camera-perspective
 : camera-orthographic
 : npatch-nine-patch
 : npatch-three-patch-vertical
 : npatch-three-patch-horizontal
 : init-window
 : close-window
 : window-should-close
 : is-window-ready
 : is-window-fullscreen
 : is-window-hidden
 : is-window-minimized
 : is-window-maximized
 : is-window-focused
 : is-window-resized
 : is-window-state
 : set-window-state
 : clear-window-state
 : toggle-fullscreen
 : toggle-borderless-windowed
 : maximize-window
 : minimize-window
 : restore-window
 : set-window-icon
 : set-window-icons
 : set-window-title
 : set-window-position
 : set-window-monitor
 : set-window-min-size
 : set-window-max-size
 : set-window-size
 : set-window-opacity
 : set-window-focused
 : get-window-handle
 : get-screen-width
 : get-screen-height
 : get-render-width
 : get-render-height
 : get-monitor-count
 : get-current-monitor
 : get-monitor-position
 : get-monitor-width
 : get-monitor-height
 : get-monitor-physical-width
 : get-monitor-physical-height
 : get-monitor-refresh-rate
 : get-window-position
 : get-window-scale-dpi
 : get-monitor-name
 : set-clipboard-text
 : get-clipboard-text
 : get-clipboard-image
 : enable-event-waiting
 : disable-event-waiting
 : show-cursor
 : hide-cursor
 : is-cursor-hidden
 : enable-cursor
 : disable-cursor
 : is-cursor-on-screen
 : clear-background
 : begin-drawing
 : end-drawing
 : begin-mode2d
 : end-mode2d
 : begin-mode3d
 : end-mode3d
 : begin-texture-mode
 : end-texture-mode
 : begin-shader-mode
 : end-shader-mode
 : begin-blend-mode
 : end-blend-mode
 : begin-scissor-mode
 : end-scissor-mode
 : begin-vr-stereo-mode
 : end-vr-stereo-mode
 : load-vr-stereo-config
 : unload-vr-stereo-config
 : load-shader
 : load-shader-from-memory
 : is-shader-valid
 : get-shader-location
 : get-shader-location-attrib
 : set-shader-value
 : set-shader-value-v
 : set-shader-value-matrix
 : set-shader-value-texture
 : unload-shader
 : get-screen-to-world-ray
 : get-screen-to-world-ray-ex
 : get-world-to-screen
 : get-world-to-screen-ex
 : get-world-to-screen2d
 : get-screen-to-world2d
 : get-camera-matrix
 : get-camera-matrix2d
 : set-target-fps
 : get-frame-time
 : get-time
 : get-fps
 : swap-screen-buffer
 : poll-input-events
 : wait-time
 : set-random-seed
 : get-random-value
 : load-random-sequence
 : unload-random-sequence
 : take-screenshot
 : set-config-flags
 : open-url
 : trace-log
 : set-trace-log-level
 : mem-alloc
 : mem-realloc
 : mem-free
 : set-trace-log-callback
 : set-load-file-data-callback
 : set-save-file-data-callback
 : set-load-file-text-callback
 : set-save-file-text-callback
 : load-file-data
 : unload-file-data
 : save-file-data
 : export-data-as-code
 : load-file-text
 : unload-file-text
 : save-file-text
 : file-exists
 : directory-exists
 : is-file-extension
 : get-file-length
 : get-file-extension
 : get-file-name
 : get-file-name-without-ext
 : get-directory-path
 : get-prev-directory-path
 : get-working-directory
 : get-application-directory
 : make-directory
 : change-directory
 : is-path-file
 : is-file-name-valid
 : load-directory-files
 : load-directory-files-ex
 : unload-directory-files
 : is-file-dropped
 : load-dropped-files
 : unload-dropped-files
 : get-file-mod-time
 : compress-data
 : decompress-data
 : encode-data-base64
 : decode-data-base64
 : compute-crc32
 : compute-md5
 : compute-sha1
 : load-automation-event-list
 : unload-automation-event-list
 : export-automation-event-list
 : set-automation-event-list
 : set-automation-event-base-frame
 : start-automation-event-recording
 : stop-automation-event-recording
 : play-automation-event
 : is-key-pressed
 : is-key-pressed-repeat
 : is-key-down
 : is-key-released
 : is-key-up
 : get-key-pressed
 : get-char-pressed
 : set-exit-key
 : is-gamepad-available
 : get-gamepad-name
 : is-gamepad-button-pressed
 : is-gamepad-button-down
 : is-gamepad-button-released
 : is-gamepad-button-up
 : get-gamepad-button-pressed
 : get-gamepad-axis-count
 : get-gamepad-axis-movement
 : set-gamepad-mappings
 : set-gamepad-vibration
 : is-mouse-button-pressed
 : is-mouse-button-down
 : is-mouse-button-released
 : is-mouse-button-up
 : get-mouse-x
 : get-mouse-y
 : get-mouse-position
 : get-mouse-delta
 : set-mouse-position
 : set-mouse-offset
 : set-mouse-scale
 : get-mouse-wheel-move
 : get-mouse-wheel-move-v
 : set-mouse-cursor
 : get-touch-x
 : get-touch-y
 : get-touch-position
 : get-touch-point-id
 : get-touch-point-count
 : set-gestures-enabled
 : is-gesture-detected
 : get-gesture-detected
 : get-gesture-hold-duration
 : get-gesture-drag-vector
 : get-gesture-drag-angle
 : get-gesture-pinch-vector
 : get-gesture-pinch-angle
 : update-camera
 : update-camera-pro
 : set-shapes-texture
 : get-shapes-texture
 : get-shapes-texture-rectangle
 : draw-pixel
 : draw-pixel-v
 : draw-line
 : draw-line-v
 : draw-line-ex
 : draw-line-strip
 : draw-line-bezier
 : draw-circle
 : draw-circle-sector
 : draw-circle-sector-lines
 : draw-circle-gradient
 : draw-circle-v
 : draw-circle-lines
 : draw-circle-lines-v
 : draw-ellipse
 : draw-ellipse-lines
 : draw-ring
 : draw-ring-lines
 : draw-rectangle
 : draw-rectangle-v
 : draw-rectangle-rec
 : draw-rectangle-pro
 : draw-rectangle-gradient-v
 : draw-rectangle-gradient-h
 : draw-rectangle-gradient-ex
 : draw-rectangle-lines
 : draw-rectangle-lines-ex
 : draw-rectangle-rounded
 : draw-rectangle-rounded-lines
 : draw-rectangle-rounded-lines-ex
 : draw-triangle
 : draw-triangle-lines
 : draw-triangle-fan
 : draw-triangle-strip
 : draw-poly
 : draw-poly-lines
 : draw-poly-lines-ex
 : draw-spline-linear
 : draw-spline-basis
 : draw-spline-catmull-rom
 : draw-spline-bezier-quadratic
 : draw-spline-bezier-cubic
 : draw-spline-segment-linear
 : draw-spline-segment-basis
 : draw-spline-segment-catmull-rom
 : draw-spline-segment-bezier-quadratic
 : draw-spline-segment-bezier-cubic
 : get-spline-point-linear
 : get-spline-point-basis
 : get-spline-point-catmull-rom
 : get-spline-point-bezier-quad
 : get-spline-point-bezier-cubic
 : check-collision-recs
 : check-collision-circles
 : check-collision-circle-rec
 : check-collision-circle-line
 : check-collision-point-rec
 : check-collision-point-circle
 : check-collision-point-triangle
 : check-collision-point-line
 : check-collision-point-poly
 : check-collision-lines
 : get-collision-rec
 : load-image
 : load-image-raw
 : load-image-anim
 : load-image-anim-from-memory
 : load-image-from-memory
 : load-image-from-texture
 : load-image-from-screen
 : is-image-valid
 : unload-image
 : export-image
 : export-image-to-memory
 : export-image-as-code
 : gen-image-color
 : gen-image-gradient-linear
 : gen-image-gradient-radial
 : gen-image-gradient-square
 : gen-image-checked
 : gen-image-white-noise
 : gen-image-perlin-noise
 : gen-image-cellular
 : gen-image-text
 : image-copy
 : image-from-image
 : image-from-channel
 : image-text
 : image-text-ex
 : image-format
 : image-to-pot
 : image-crop
 : image-alpha-crop
 : image-alpha-clear
 : image-alpha-mask
 : image-alpha-premultiply
 : image-blur-gaussian
 : image-kernel-convolution
 : image-resize
 : image-resize-nn
 : image-resize-canvas
 : image-mipmaps
 : image-dither
 : image-flip-vertical
 : image-flip-horizontal
 : image-rotate
 : image-rotate-cw
 : image-rotate-ccw
 : image-color-tint
 : image-color-invert
 : image-color-grayscale
 : image-color-contrast
 : image-color-brightness
 : image-color-replace
 : load-image-colors
 : load-image-palette
 : unload-image-colors
 : unload-image-palette
 : get-image-alpha-border
 : get-image-color
 : image-clear-background
 : image-draw-pixel
 : image-draw-pixel-v
 : image-draw-line
 : image-draw-line-v
 : image-draw-line-ex
 : image-draw-circle
 : image-draw-circle-v
 : image-draw-circle-lines
 : image-draw-circle-lines-v
 : image-draw-rectangle
 : image-draw-rectangle-v
 : image-draw-rectangle-rec
 : image-draw-rectangle-lines
 : image-draw-triangle
 : image-draw-triangle-ex
 : image-draw-triangle-lines
 : image-draw-triangle-fan
 : image-draw-triangle-strip
 : image-draw
 : image-draw-text
 : image-draw-text-ex
 : load-texture
 : load-texture-from-image
 : load-texture-cubemap
 : load-render-texture
 : is-texture-valid
 : unload-texture
 : is-render-texture-valid
 : unload-render-texture
 : update-texture
 : update-texture-rec
 : gen-texture-mipmaps
 : set-texture-filter
 : set-texture-wrap
 : draw-texture
 : draw-texture-v
 : draw-texture-ex
 : draw-texture-rec
 : draw-texture-pro
 : draw-texture-npatch
 : color-is-equal
 : fade
 : color-to-int
 : color-normalize
 : color-from-normalized
 : color-to-hsv
 : color-from-hsv
 : color-tint
 : color-brightness
 : color-contrast
 : color-alpha
 : color-alpha-blend
 : color-lerp
 : get-color
 : get-pixel-color
 : set-pixel-color
 : get-pixel-data-size
 : get-font-default
 : load-font
 : load-font-ex
 : load-font-from-image
 : load-font-from-memory
 : is-font-valid
 : load-font-data
 : gen-image-font-atlas
 : unload-font-data
 : unload-font
 : export-font-as-code
 : draw-fps
 : draw-text
 : draw-text-ex
 : draw-text-pro
 : draw-text-codepoint
 : draw-text-codepoints
 : set-text-line-spacing
 : measure-text
 : measure-text-ex
 : get-glyph-index
 : get-glyph-info
 : get-glyph-atlas-rec
 : load-utf8
 : unload-utf8
 : load-codepoints
 : unload-codepoints
 : get-codepoint-count
 : get-codepoint
 : get-codepoint-next
 : get-codepoint-previous
 : codepoint-to-utf8
 : text-copy
 : text-is-equal
 : text-length
 : text-format
 : text-subtext
 : text-replace
 : text-insert
 : text-join
 : text-split
 : text-append
 : text-find-index
 : text-to-upper
 : text-to-lower
 : text-to-pascal
 : text-to-snake
 : text-to-camel
 : text-to-integer
 : text-to-float
 : draw-line3d
 : draw-point3d
 : draw-circle3d
 : draw-triangle3d
 : draw-triangle-strip3d
 : draw-cube
 : draw-cube-v
 : draw-cube-wires
 : draw-cube-wires-v
 : draw-sphere
 : draw-sphere-ex
 : draw-sphere-wires
 : draw-cylinder
 : draw-cylinder-ex
 : draw-cylinder-wires
 : draw-cylinder-wires-ex
 : draw-capsule
 : draw-capsule-wires
 : draw-plane
 : draw-ray
 : draw-grid
 : load-model
 : load-model-from-mesh
 : is-model-valid
 : unload-model
 : get-model-bounding-box
 : draw-model
 : draw-model-ex
 : draw-model-wires
 : draw-model-wires-ex
 : draw-model-points
 : draw-model-points-ex
 : draw-bounding-box
 : draw-billboard
 : draw-billboard-rec
 : draw-billboard-pro
 : upload-mesh
 : update-mesh-buffer
 : unload-mesh
 : draw-mesh
 : draw-mesh-instanced
 : get-mesh-bounding-box
 : gen-mesh-tangents
 : export-mesh
 : export-mesh-as-code
 : gen-mesh-poly
 : gen-mesh-plane
 : gen-mesh-cube
 : gen-mesh-sphere
 : gen-mesh-hemi-sphere
 : gen-mesh-cylinder
 : gen-mesh-cone
 : gen-mesh-torus
 : gen-mesh-knot
 : gen-mesh-heightmap
 : gen-mesh-cubicmap
 : load-materials
 : load-material-default
 : is-material-valid
 : unload-material
 : set-material-texture
 : set-model-mesh-material
 : load-model-animations
 : update-model-animation
 : update-model-animation-bones
 : unload-model-animation
 : unload-model-animations
 : is-model-animation-valid
 : check-collision-spheres
 : check-collision-boxes
 : check-collision-box-sphere
 : get-ray-collision-sphere
 : get-ray-collision-box
 : get-ray-collision-mesh
 : get-ray-collision-triangle
 : get-ray-collision-quad
 : init-audio-device
 : close-audio-device
 : is-audio-device-ready
 : set-master-volume
 : get-master-volume
 : load-wave
 : load-wave-from-memory
 : is-wave-valid
 : load-sound
 : load-sound-from-wave
 : load-sound-alias
 : is-sound-valid
 : update-sound
 : unload-wave
 : unload-sound
 : unload-sound-alias
 : export-wave
 : export-wave-as-code
 : play-sound
 : stop-sound
 : pause-sound
 : resume-sound
 : is-sound-playing
 : set-sound-volume
 : set-sound-pitch
 : set-sound-pan
 : wave-copy
 : wave-crop
 : wave-format
 : load-wave-samples
 : unload-wave-samples
 : load-music-stream
 : load-music-stream-from-memory
 : is-music-valid
 : unload-music-stream
 : play-music-stream
 : is-music-stream-playing
 : update-music-stream
 : stop-music-stream
 : pause-music-stream
 : resume-music-stream
 : seek-music-stream
 : set-music-volume
 : set-music-pitch
 : set-music-pan
 : get-music-time-length
 : get-music-time-played
 : load-audio-stream
 : is-audio-stream-valid
 : unload-audio-stream
 : update-audio-stream
 : is-audio-stream-processed
 : play-audio-stream
 : pause-audio-stream
 : resume-audio-stream
 : is-audio-stream-playing
 : stop-audio-stream
 : set-audio-stream-volume
 : set-audio-stream-pitch
 : set-audio-stream-pan
 : set-audio-stream-buffer-size-default
 : set-audio-stream-callback
 : attach-audio-stream-processor
 : detach-audio-stream-processor
 : attach-audio-mixed-processor
 : detach-audio-mixed-processor
 : raywhite
 : lightgray
 : maroon
 : darkblue
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
 : rl}