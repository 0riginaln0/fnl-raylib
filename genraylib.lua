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
ffi.cdef("\ntypedef struct Vector2 {\n    float x;                // Vector x component\n    float y;                // Vector y component\n    } Vector2;\n\ntypedef struct Vector3 {\n    float x;                // Vector x component\n    float y;                // Vector y component\n    float z;                // Vector z component\n    } Vector3;\n\ntypedef struct Vector4 {\n    float x;                // Vector x component\n    float y;                // Vector y component\n    float z;                // Vector z component\n    float w;                // Vector w component\n    } Vector4;\n\ntypedef Vector4 Quaternion;\ntypedef struct Matrix {\n    float m0, m4, m8, m12;  // Matrix first row (4 components)\n    float m1, m5, m9, m13;  // Matrix second row (4 components)\n    float m2, m6, m10, m14; // Matrix third row (4 components)\n    float m3, m7, m11, m15; // Matrix fourth row (4 components)\n    } Matrix;\n\ntypedef struct Color {\n    unsigned char r;        // Color red value\n    unsigned char g;        // Color green value\n    unsigned char b;        // Color blue value\n    unsigned char a;        // Color alpha value\n    } Color;\n\ntypedef struct Rectangle {\n    float x;                // Rectangle top-left corner position x\n    float y;                // Rectangle top-left corner position y\n    float width;            // Rectangle width\n    float height;           // Rectangle height\n    } Rectangle;\n\ntypedef struct Image {\n    void *data;             // Image raw data\n    int width;              // Image base width\n    int height;             // Image base height\n    int mipmaps;            // Mipmap levels, 1 by default\n    int format;             // Data format (PixelFormat type)\n    } Image;\n\ntypedef struct Texture {\n    unsigned int id;        // OpenGL texture id\n    int width;              // Texture base width\n    int height;             // Texture base height\n    int mipmaps;            // Mipmap levels, 1 by default\n    int format;             // Data format (PixelFormat type)\n    } Texture;\n\ntypedef Texture Texture2D;\ntypedef Texture TextureCubemap;\ntypedef struct RenderTexture {\n    unsigned int id;        // OpenGL framebuffer object id\n    Texture texture;        // Color buffer attachment texture\n    Texture depth;          // Depth buffer attachment texture\n    } RenderTexture;\n\ntypedef RenderTexture RenderTexture2D;\ntypedef struct NPatchInfo {\n    Rectangle source;       // Texture source rectangle\n    int left;               // Left border offset\n    int top;                // Top border offset\n    int right;              // Right border offset\n    int bottom;             // Bottom border offset\n    int layout;             // Layout of the n-patch: 3x3, 1x3 or 3x1\n    } NPatchInfo;\n\ntypedef struct GlyphInfo {\n    int value;              // Character value (Unicode)\n    int offsetX;            // Character offset X when drawing\n    int offsetY;            // Character offset Y when drawing\n    int advanceX;           // Character advance position X\n    Image image;            // Character image data\n    } GlyphInfo;\n\ntypedef struct Font {\n    int baseSize;           // Base size (default chars height)\n    int glyphCount;         // Number of glyph characters\n    int glyphPadding;       // Padding around the glyph characters\n    Texture2D texture;      // Texture atlas containing the glyphs\n    Rectangle *recs;        // Rectangles in texture for the glyphs\n    GlyphInfo *glyphs;      // Glyphs info data\n    } Font;\n\ntypedef struct Camera3D {\n    Vector3 position;       // Camera position\n    Vector3 target;         // Camera target it looks-at\n    Vector3 up;             // Camera up vector (rotation over its axis)\n    float fovy;             // Camera field-of-view aperture in Y (degrees) in perspective, used as near plane width in orthographic\n    int projection;         // Camera projection: CAMERA_PERSPECTIVE or CAMERA_ORTHOGRAPHIC\n    } Camera3D;\n\ntypedef Camera3D Camera;    // Camera type fallback, defaults to Camera3D\ntypedef struct Camera2D {\n    Vector2 offset;         // Camera offset (displacement from target)\n    Vector2 target;         // Camera target (rotation and zoom origin)\n    float rotation;         // Camera rotation in degrees\n    float zoom;             // Camera zoom (scaling), should be 1.0f by default\n    } Camera2D;\n\ntypedef struct Mesh {\n    int vertexCount;        // Number of vertices stored in arrays\n    int triangleCount;      // Number of triangles stored (indexed or not)\n    \n    // Vertex attributes data\n    float *vertices;        // Vertex position (XYZ - 3 components per vertex) (shader-location = 0)\n    float *texcoords;       // Vertex texture coordinates (UV - 2 components per vertex) (shader-location = 1)\n    float *texcoords2;      // Vertex texture second coordinates (UV - 2 components per vertex) (shader-location = 5)\n    float *normals;         // Vertex normals (XYZ - 3 components per vertex) (shader-location = 2)\n    float *tangents;        // Vertex tangents (XYZW - 4 components per vertex) (shader-location = 4)\n    unsigned char *colors;      // Vertex colors (RGBA - 4 components per vertex) (shader-location = 3)\n    unsigned short *indices;    // Vertex indices (in case vertex data comes indexed)\n    \n    // Animation vertex data\n    float *animVertices;    // Animated vertex positions (after bones transformations)\n    float *animNormals;     // Animated normals (after bones transformations)\n    unsigned char *boneIds; // Vertex bone ids, max 255 bone ids, up to 4 bones influence by vertex (skinning) (shader-location = 6)\n    float *boneWeights;     // Vertex bone weight, up to 4 bones influence by vertex (skinning) (shader-location = 7)\n    Matrix *boneMatrices;   // Bones animated transformation matrices\n    int boneCount;          // Number of bones\n    \n    // OpenGL identifiers\n    unsigned int vaoId;     // OpenGL Vertex Array Object id\n    unsigned int *vboId;    // OpenGL Vertex Buffer Objects id (default vertex data)\n    } Mesh;\n\ntypedef struct Shader {\n    unsigned int id;        // Shader program id\n    int *locs;              // Shader locations array (RL_MAX_SHADER_LOCATIONS)\n    } Shader;\n\ntypedef struct MaterialMap {\n    Texture2D texture;      // Material map texture\n    Color color;            // Material map color\n    float value;            // Material map value\n    } MaterialMap;\n\ntypedef struct Material {\n    Shader shader;          // Material shader\n    MaterialMap *maps;      // Material maps array (MAX_MATERIAL_MAPS)\n    float params[4];        // Material generic parameters (if required)\n    } Material;\n\ntypedef struct Transform {\n    Vector3 translation;    // Translation\n    Quaternion rotation;    // Rotation\n    Vector3 scale;          // Scale\n    } Transform;\n\ntypedef struct BoneInfo {\n    char name[32];          // Bone name\n    int parent;             // Bone parent\n    } BoneInfo;\n\ntypedef struct Model {\n    Matrix transform;       // Local transform matrix\n    \n    int meshCount;          // Number of meshes\n    int materialCount;      // Number of materials\n    Mesh *meshes;           // Meshes array\n    Material *materials;    // Materials array\n    int *meshMaterial;      // Mesh material number\n    \n    // Animation data\n    int boneCount;          // Number of bones\n    BoneInfo *bones;        // Bones information (skeleton)\n    Transform *bindPose;    // Bones base transformation (pose)\n    } Model;\n\ntypedef struct ModelAnimation {\n    int boneCount;          // Number of bones\n    int frameCount;         // Number of animation frames\n    BoneInfo *bones;        // Bones information (skeleton)\n    Transform **framePoses; // Poses array by frame\n    char name[32];          // Animation name\n    } ModelAnimation;\n\ntypedef struct Ray {\n    Vector3 position;       // Ray position (origin)\n    Vector3 direction;      // Ray direction (normalized)\n    } Ray;\n\ntypedef struct RayCollision {\n    bool hit;               // Did the ray hit something?\n    float distance;         // Distance to the nearest hit\n    Vector3 point;          // Point of the nearest hit\n    Vector3 normal;         // Surface normal of hit\n    } RayCollision;\n\ntypedef struct BoundingBox {\n    Vector3 min;            // Minimum vertex box-corner\n    Vector3 max;            // Maximum vertex box-corner\n    } BoundingBox;\n\ntypedef struct Wave {\n    unsigned int frameCount;    // Total number of frames (considering channels)\n    unsigned int sampleRate;    // Frequency (samples per second)\n    unsigned int sampleSize;    // Bit depth (bits per sample): 8, 16, 32 (24 not supported)\n    unsigned int channels;      // Number of channels (1-mono, 2-stereo, ...)\n    void *data;                 // Buffer data pointer\n    } Wave;\n\ntypedef struct rAudioBuffer rAudioBuffer;\n    typedef struct rAudioProcessor rAudioProcessor;\n\ntypedef struct AudioStream {\n    rAudioBuffer *buffer;       // Pointer to internal data used by the audio system\n    rAudioProcessor *processor; // Pointer to internal data processor, useful for audio effects\n    \n    unsigned int sampleRate;    // Frequency (samples per second)\n    unsigned int sampleSize;    // Bit depth (bits per sample): 8, 16, 32 (24 not supported)\n    unsigned int channels;      // Number of channels (1-mono, 2-stereo, ...)\n    } AudioStream;\n\ntypedef struct Sound {\n    AudioStream stream;         // Audio stream\n    unsigned int frameCount;    // Total number of frames (considering channels)\n    } Sound;\n\ntypedef struct Music {\n    AudioStream stream;         // Audio stream\n    unsigned int frameCount;    // Total number of frames (considering channels)\n    bool looping;               // Music looping enable\n    \n    int ctxType;                // Type of music context (audio filetype)\n    void *ctxData;              // Audio context data, depends on type\n    } Music;\n\ntypedef struct VrDeviceInfo {\n    int hResolution;                // Horizontal resolution in pixels\n    int vResolution;                // Vertical resolution in pixels\n    float hScreenSize;              // Horizontal size in meters\n    float vScreenSize;              // Vertical size in meters\n    float eyeToScreenDistance;      // Distance between eye and display in meters\n    float lensSeparationDistance;   // Lens separation distance in meters\n    float interpupillaryDistance;   // IPD (distance between pupils) in meters\n    float lensDistortionValues[4];  // Lens distortion constant parameters\n    float chromaAbCorrection[4];    // Chromatic aberration correction parameters\n    } VrDeviceInfo;\n\ntypedef struct VrStereoConfig {\n    Matrix projection[2];           // VR projection matrices (per eye)\n    Matrix viewOffset[2];           // VR view offset matrices (per eye)\n    float leftLensCenter[2];        // VR left lens center\n    float rightLensCenter[2];       // VR right lens center\n    float leftScreenCenter[2];      // VR left screen center\n    float rightScreenCenter[2];     // VR right screen center\n    float scale[2];                 // VR distortion scale\n    float scaleIn[2];               // VR distortion scale in\n    } VrStereoConfig;\n\ntypedef struct FilePathList {\n    unsigned int capacity;          // Filepaths max entries\n    unsigned int count;             // Filepaths entries count\n    char **paths;                   // Filepaths entries\n    } FilePathList;\n\ntypedef struct AutomationEvent {\n    unsigned int frame;             // Event frame\n    unsigned int type;              // Event type (AutomationEventType)\n    int params[4];                  // Event parameters (if required)\n    } AutomationEvent;\n\ntypedef struct AutomationEventList {\n    unsigned int capacity;          // Events max entries (MAX_AUTOMATION_EVENTS)\n    unsigned int count;             // Events entries count\n    AutomationEvent *events;        // Events entries\n    } AutomationEventList;\n\ntypedef void (*TraceLogCallback)(int logLevel, const char *text, va_list args);  // Logging: Redirect trace log messages\ntypedef unsigned char *(*LoadFileDataCallback)(const char *fileName, int *dataSize);    // FileIO: Load binary data\ntypedef bool (*SaveFileDataCallback)(const char *fileName, void *data, int dataSize);   // FileIO: Save binary data\ntypedef char *(*LoadFileTextCallback)(const char *fileName);            // FileIO: Load text data\ntypedef bool (*SaveFileTextCallback)(const char *fileName, char *text); // FileIO: Save text data\nvoid InitWindow(int width, int height, const char *title);  // Initialize window and OpenGL context\n\nvoid CloseWindow(void);                                     // Close window and unload OpenGL context\n\nbool WindowShouldClose(void);                               // Check if application should close (KEY_ESCAPE pressed or windows close icon clicked)\n\nbool IsWindowReady(void);                                   // Check if window has been initialized successfully\n\nbool IsWindowFullscreen(void);                              // Check if window is currently fullscreen\n\nbool IsWindowHidden(void);                                  // Check if window is currently hidden\n\nbool IsWindowMinimized(void);                               // Check if window is currently minimized\n\nbool IsWindowMaximized(void);                               // Check if window is currently maximized\n\nbool IsWindowFocused(void);                                 // Check if window is currently focused\n\nbool IsWindowResized(void);                                 // Check if window has been resized last frame\n\nbool IsWindowState(unsigned int flag);                      // Check if one specific window flag is enabled\n\nvoid SetWindowState(unsigned int flags);                    // Set window configuration state using flags\n\nvoid ClearWindowState(unsigned int flags);                  // Clear window configuration state flags\n\nvoid ToggleFullscreen(void);                                // Toggle window state: fullscreen/windowed, resizes monitor to match window resolution\n\nvoid ToggleBorderlessWindowed(void);                        // Toggle window state: borderless windowed, resizes window to match monitor resolution\n\nvoid MaximizeWindow(void);                                  // Set window state: maximized, if resizable\n\nvoid MinimizeWindow(void);                                  // Set window state: minimized, if resizable\n\nvoid RestoreWindow(void);                                   // Set window state: not minimized/maximized\n\nvoid SetWindowIcon(Image image);                            // Set icon for window (single image, RGBA 32bit)\n\nvoid SetWindowIcons(Image *images, int count);              // Set icon for window (multiple images, RGBA 32bit)\n\nvoid SetWindowTitle(const char *title);                     // Set title for window\n\nvoid SetWindowPosition(int x, int y);                       // Set window position on screen\n\nvoid SetWindowMonitor(int monitor);                         // Set monitor for the current window\n\nvoid SetWindowMinSize(int width, int height);               // Set window minimum dimensions (for FLAG_WINDOW_RESIZABLE)\n\nvoid SetWindowMaxSize(int width, int height);               // Set window maximum dimensions (for FLAG_WINDOW_RESIZABLE)\n\nvoid SetWindowSize(int width, int height);                  // Set window dimensions\n\nvoid SetWindowOpacity(float opacity);                       // Set window opacity [0.0f..1.0f]\n\nvoid SetWindowFocused(void);                                // Set window focused\n\nvoid *GetWindowHandle(void);                                // Get native window handle\n\nint GetScreenWidth(void);                                   // Get current screen width\n\nint GetScreenHeight(void);                                  // Get current screen height\n\nint GetRenderWidth(void);                                   // Get current render width (it considers HiDPI)\n\nint GetRenderHeight(void);                                  // Get current render height (it considers HiDPI)\n\nint GetMonitorCount(void);                                  // Get number of connected monitors\n\nint GetCurrentMonitor(void);                                // Get current monitor where window is placed\n\nVector2 GetMonitorPosition(int monitor);                    // Get specified monitor position\n\nint GetMonitorWidth(int monitor);                           // Get specified monitor width (current video mode used by monitor)\n\nint GetMonitorHeight(int monitor);                          // Get specified monitor height (current video mode used by monitor)\n\nint GetMonitorPhysicalWidth(int monitor);                   // Get specified monitor physical width in millimetres\n\nint GetMonitorPhysicalHeight(int monitor);                  // Get specified monitor physical height in millimetres\n\nint GetMonitorRefreshRate(int monitor);                     // Get specified monitor refresh rate\n\nVector2 GetWindowPosition(void);                            // Get window position XY on monitor\n\nVector2 GetWindowScaleDPI(void);                            // Get window scale DPI factor\n\nconst char *GetMonitorName(int monitor);                    // Get the human-readable, UTF-8 encoded name of the specified monitor\n\nvoid SetClipboardText(const char *text);                    // Set clipboard text content\n\nconst char *GetClipboardText(void);                         // Get clipboard text content\n\nImage GetClipboardImage(void);                              // Get clipboard image content\n\nvoid EnableEventWaiting(void);                              // Enable waiting for events on EndDrawing(), no automatic event polling\n\nvoid DisableEventWaiting(void);                             // Disable waiting for events on EndDrawing(), automatic events polling\n\nvoid ShowCursor(void);                                      // Shows cursor\n\nvoid HideCursor(void);                                      // Hides cursor\n\nbool IsCursorHidden(void);                                  // Check if cursor is not visible\n\nvoid EnableCursor(void);                                    // Enables cursor (unlock cursor)\n\nvoid DisableCursor(void);                                   // Disables cursor (lock cursor)\n\nbool IsCursorOnScreen(void);                                // Check if cursor is on the screen\n\nvoid ClearBackground(Color color);                          // Set background color (framebuffer clear color)\n\nvoid BeginDrawing(void);                                    // Setup canvas (framebuffer) to start drawing\n\nvoid EndDrawing(void);                                      // End canvas drawing and swap buffers (double buffering)\n\nvoid BeginMode2D(Camera2D camera);                          // Begin 2D mode with custom camera (2D)\n\nvoid EndMode2D(void);                                       // Ends 2D mode with custom camera\n\nvoid BeginMode3D(Camera3D camera);                          // Begin 3D mode with custom camera (3D)\n\nvoid EndMode3D(void);                                       // Ends 3D mode and returns to default 2D orthographic mode\n\nvoid BeginTextureMode(RenderTexture2D target);              // Begin drawing to render texture\n\nvoid EndTextureMode(void);                                  // Ends drawing to render texture\n\nvoid BeginShaderMode(Shader shader);                        // Begin custom shader drawing\n\nvoid EndShaderMode(void);                                   // End custom shader drawing (use default shader)\n\nvoid BeginBlendMode(int mode);                              // Begin blending mode (alpha, additive, multiplied, subtract, custom)\n\nvoid EndBlendMode(void);                                    // End blending mode (reset to default: alpha blending)\n\nvoid BeginScissorMode(int x, int y, int width, int height); // Begin scissor mode (define screen area for following drawing)\n\nvoid EndScissorMode(void);                                  // End scissor mode\n\nvoid BeginVrStereoMode(VrStereoConfig config);              // Begin stereo rendering (requires VR simulator)\n\nvoid EndVrStereoMode(void);                                 // End stereo rendering (requires VR simulator)\n\nVrStereoConfig LoadVrStereoConfig(VrDeviceInfo device);     // Load VR stereo config for VR simulator device parameters\n\nvoid UnloadVrStereoConfig(VrStereoConfig config);           // Unload VR stereo config\n\nShader LoadShader(const char *vsFileName, const char *fsFileName);   // Load shader from files and bind default locations\n\nShader LoadShaderFromMemory(const char *vsCode, const char *fsCode); // Load shader from code strings and bind default locations\n\nbool IsShaderValid(Shader shader);                                   // Check if a shader is valid (loaded on GPU)\n\nint GetShaderLocation(Shader shader, const char *uniformName);       // Get shader uniform location\n\nint GetShaderLocationAttrib(Shader shader, const char *attribName);  // Get shader attribute location\n\nvoid SetShaderValue(Shader shader, int locIndex, const void *value, int uniformType);               // Set shader uniform value\n\nvoid SetShaderValueV(Shader shader, int locIndex, const void *value, int uniformType, int count);   // Set shader uniform value vector\n\nvoid SetShaderValueMatrix(Shader shader, int locIndex, Matrix mat);         // Set shader uniform value (matrix 4x4)\n\nvoid SetShaderValueTexture(Shader shader, int locIndex, Texture2D texture); // Set shader uniform value for texture (sampler2d)\n\nvoid UnloadShader(Shader shader);                                    // Unload shader from GPU memory (VRAM)\n\nRay GetScreenToWorldRay(Vector2 position, Camera camera);         // Get a ray trace from screen position (i.e mouse)\n\nRay GetScreenToWorldRayEx(Vector2 position, Camera camera, int width, int height); // Get a ray trace from screen position (i.e mouse) in a viewport\n\nVector2 GetWorldToScreen(Vector3 position, Camera camera);        // Get the screen space position for a 3d world space position\n\nVector2 GetWorldToScreenEx(Vector3 position, Camera camera, int width, int height); // Get size position for a 3d world space position\n\nVector2 GetWorldToScreen2D(Vector2 position, Camera2D camera);    // Get the screen space position for a 2d camera world space position\n\nVector2 GetScreenToWorld2D(Vector2 position, Camera2D camera);    // Get the world space position for a 2d camera screen space position\n\nMatrix GetCameraMatrix(Camera camera);                            // Get camera transform matrix (view matrix)\n\nMatrix GetCameraMatrix2D(Camera2D camera);                        // Get camera 2d transform matrix\n\nvoid SetTargetFPS(int fps);                                 // Set target FPS (maximum)\n\nfloat GetFrameTime(void);                                   // Get time in seconds for last frame drawn (delta time)\n\ndouble GetTime(void);                                       // Get elapsed time in seconds since InitWindow()\n\nint GetFPS(void);                                           // Get current FPS\n\nvoid SwapScreenBuffer(void);                                // Swap back buffer with front buffer (screen drawing)\n\nvoid PollInputEvents(void);                                 // Register all input events\n\nvoid WaitTime(double seconds);                              // Wait for some time (halt program execution)\n\nvoid SetRandomSeed(unsigned int seed);                      // Set the seed for the random number generator\n\nint GetRandomValue(int min, int max);                       // Get a random value between min and max (both included)\n\nint *LoadRandomSequence(unsigned int count, int min, int max); // Load random values sequence, no values repeated\n\nvoid UnloadRandomSequence(int *sequence);                   // Unload random values sequence\n\nvoid TakeScreenshot(const char *fileName);                  // Takes a screenshot of current screen (filename extension defines format)\n\nvoid SetConfigFlags(unsigned int flags);                    // Setup init configuration flags (view FLAGS)\n\nvoid OpenURL(const char *url);                              // Open URL with default system browser (if available)\n\nvoid TraceLog(int logLevel, const char *text, ...);         // Show trace log messages (LOG_DEBUG, LOG_INFO, LOG_WARNING, LOG_ERROR...)\n\nvoid SetTraceLogLevel(int logLevel);                        // Set the current threshold (minimum) log level\n\nvoid *MemAlloc(unsigned int size);                          // Internal memory allocator\n\nvoid *MemRealloc(void *ptr, unsigned int size);             // Internal memory reallocator\n\nvoid MemFree(void *ptr);                                    // Internal memory free\n\nvoid SetTraceLogCallback(TraceLogCallback callback);         // Set custom trace log\n\nvoid SetLoadFileDataCallback(LoadFileDataCallback callback); // Set custom file binary data loader\n\nvoid SetSaveFileDataCallback(SaveFileDataCallback callback); // Set custom file binary data saver\n\nvoid SetLoadFileTextCallback(LoadFileTextCallback callback); // Set custom file text data loader\n\nvoid SetSaveFileTextCallback(SaveFileTextCallback callback); // Set custom file text data saver\n\nunsigned char *LoadFileData(const char *fileName, int *dataSize); // Load file data as byte array (read)\n\nvoid UnloadFileData(unsigned char *data);                   // Unload file data allocated by LoadFileData()\n\nbool SaveFileData(const char *fileName, void *data, int dataSize); // Save data to file from byte array (write), returns true on success\n\nbool ExportDataAsCode(const unsigned char *data, int dataSize, const char *fileName); // Export data to code (.h), returns true on success\n\nchar *LoadFileText(const char *fileName);                   // Load text data from file (read), returns a '\0' terminated string\n\nvoid UnloadFileText(char *text);                            // Unload file text data allocated by LoadFileText()\n\nbool SaveFileText(const char *fileName, char *text);        // Save text data to file (write), string must be '\0' terminated, returns true on success\n\nbool FileExists(const char *fileName);                      // Check if file exists\n\nbool DirectoryExists(const char *dirPath);                  // Check if a directory path exists\n\nbool IsFileExtension(const char *fileName, const char *ext); // Check file extension (including point: .png, .wav)\n\nint GetFileLength(const char *fileName);                    // Get file length in bytes (NOTE: GetFileSize() conflicts with windows.h)\n\nconst char *GetFileExtension(const char *fileName);         // Get pointer to extension for a filename string (includes dot: '.png')\n\nconst char *GetFileName(const char *filePath);              // Get pointer to filename for a path string\n\nconst char *GetFileNameWithoutExt(const char *filePath);    // Get filename string without extension (uses static string)\n\nconst char *GetDirectoryPath(const char *filePath);         // Get full path for a given fileName with path (uses static string)\n\nconst char *GetPrevDirectoryPath(const char *dirPath);      // Get previous directory path for a given path (uses static string)\n\nconst char *GetWorkingDirectory(void);                      // Get current working directory (uses static string)\n\nconst char *GetApplicationDirectory(void);                  // Get the directory of the running application (uses static string)\n\nint MakeDirectory(const char *dirPath);                     // Create directories (including full path requested), returns 0 on success\n\nbool ChangeDirectory(const char *dir);                      // Change working directory, return true on success\n\nbool IsPathFile(const char *path);                          // Check if a given path is a file or a directory\n\nbool IsFileNameValid(const char *fileName);                 // Check if fileName is valid for the platform/OS\n\nFilePathList LoadDirectoryFiles(const char *dirPath);       // Load directory filepaths\n\nFilePathList LoadDirectoryFilesEx(const char *basePath, const char *filter, bool scanSubdirs); // Load directory filepaths with extension filtering and recursive directory scan. Use 'DIR' in the filter string to include directories in the result\n\nvoid UnloadDirectoryFiles(FilePathList files);              // Unload filepaths\n\nbool IsFileDropped(void);                                   // Check if a file has been dropped into window\n\nFilePathList LoadDroppedFiles(void);                        // Load dropped filepaths\n\nvoid UnloadDroppedFiles(FilePathList files);                // Unload dropped filepaths\n\nlong GetFileModTime(const char *fileName);                  // Get file modification time (last write time)\n\nunsigned char *CompressData(const unsigned char *data, int dataSize, int *compDataSize);        // Compress data (DEFLATE algorithm), memory must be MemFree()\n\nunsigned char *DecompressData(const unsigned char *compData, int compDataSize, int *dataSize);  // Decompress data (DEFLATE algorithm), memory must be MemFree()\n\nchar *EncodeDataBase64(const unsigned char *data, int dataSize, int *outputSize);               // Encode data to Base64 string, memory must be MemFree()\n\nunsigned char *DecodeDataBase64(const unsigned char *data, int *outputSize);                    // Decode Base64 string data, memory must be MemFree()\n\nunsigned int ComputeCRC32(unsigned char *data, int dataSize);     // Compute CRC32 hash code\n\nunsigned int *ComputeMD5(unsigned char *data, int dataSize);      // Compute MD5 hash code, returns static int[4] (16 bytes)\n\nunsigned int *ComputeSHA1(unsigned char *data, int dataSize);      // Compute SHA1 hash code, returns static int[5] (20 bytes)\n\nAutomationEventList LoadAutomationEventList(const char *fileName);                // Load automation events list from file, NULL for empty list, capacity = MAX_AUTOMATION_EVENTS\n\nvoid UnloadAutomationEventList(AutomationEventList list);                         // Unload automation events list from file\n\nbool ExportAutomationEventList(AutomationEventList list, const char *fileName);   // Export automation events list as text file\n\nvoid SetAutomationEventList(AutomationEventList *list);                           // Set automation event list to record to\n\nvoid SetAutomationEventBaseFrame(int frame);                                      // Set automation event internal base frame to start recording\n\nvoid StartAutomationEventRecording(void);                                         // Start recording automation events (AutomationEventList must be set)\n\nvoid StopAutomationEventRecording(void);                                          // Stop recording automation events\n\nvoid PlayAutomationEvent(AutomationEvent event);                                  // Play a recorded automation event\n\nbool IsKeyPressed(int key);                             // Check if a key has been pressed once\n\nbool IsKeyPressedRepeat(int key);                       // Check if a key has been pressed again\n\nbool IsKeyDown(int key);                                // Check if a key is being pressed\n\nbool IsKeyReleased(int key);                            // Check if a key has been released once\n\nbool IsKeyUp(int key);                                  // Check if a key is NOT being pressed\n\nint GetKeyPressed(void);                                // Get key pressed (keycode), call it multiple times for keys queued, returns 0 when the queue is empty\n\nint GetCharPressed(void);                               // Get char pressed (unicode), call it multiple times for chars queued, returns 0 when the queue is empty\n\nvoid SetExitKey(int key);                               // Set a custom key to exit program (default is ESC)\n\nbool IsGamepadAvailable(int gamepad);                                        // Check if a gamepad is available\n\nconst char *GetGamepadName(int gamepad);                                     // Get gamepad internal name id\n\nbool IsGamepadButtonPressed(int gamepad, int button);                        // Check if a gamepad button has been pressed once\n\nbool IsGamepadButtonDown(int gamepad, int button);                           // Check if a gamepad button is being pressed\n\nbool IsGamepadButtonReleased(int gamepad, int button);                       // Check if a gamepad button has been released once\n\nbool IsGamepadButtonUp(int gamepad, int button);                             // Check if a gamepad button is NOT being pressed\n\nint GetGamepadButtonPressed(void);                                           // Get the last gamepad button pressed\n\nint GetGamepadAxisCount(int gamepad);                                        // Get gamepad axis count for a gamepad\n\nfloat GetGamepadAxisMovement(int gamepad, int axis);                         // Get axis movement value for a gamepad axis\n\nint SetGamepadMappings(const char *mappings);                                // Set internal gamepad mappings (SDL_GameControllerDB)\n\nvoid SetGamepadVibration(int gamepad, float leftMotor, float rightMotor, float duration); // Set gamepad vibration for both motors (duration in seconds)\n\nbool IsMouseButtonPressed(int button);                  // Check if a mouse button has been pressed once\n\nbool IsMouseButtonDown(int button);                     // Check if a mouse button is being pressed\n\nbool IsMouseButtonReleased(int button);                 // Check if a mouse button has been released once\n\nbool IsMouseButtonUp(int button);                       // Check if a mouse button is NOT being pressed\n\nint GetMouseX(void);                                    // Get mouse position X\n\nint GetMouseY(void);                                    // Get mouse position Y\n\nVector2 GetMousePosition(void);                         // Get mouse position XY\n\nVector2 GetMouseDelta(void);                            // Get mouse delta between frames\n\nvoid SetMousePosition(int x, int y);                    // Set mouse position XY\n\nvoid SetMouseOffset(int offsetX, int offsetY);          // Set mouse offset\n\nvoid SetMouseScale(float scaleX, float scaleY);         // Set mouse scaling\n\nfloat GetMouseWheelMove(void);                          // Get mouse wheel movement for X or Y, whichever is larger\n\nVector2 GetMouseWheelMoveV(void);                       // Get mouse wheel movement for both X and Y\n\nvoid SetMouseCursor(int cursor);                        // Set mouse cursor\n\nint GetTouchX(void);                                    // Get touch position X for touch point 0 (relative to screen size)\n\nint GetTouchY(void);                                    // Get touch position Y for touch point 0 (relative to screen size)\n\nVector2 GetTouchPosition(int index);                    // Get touch position XY for a touch point index (relative to screen size)\n\nint GetTouchPointId(int index);                         // Get touch point identifier for given index\n\nint GetTouchPointCount(void);                           // Get number of touch points\n\nvoid SetGesturesEnabled(unsigned int flags);      // Enable a set of gestures using flags\n\nbool IsGestureDetected(unsigned int gesture);     // Check if a gesture have been detected\n\nint GetGestureDetected(void);                     // Get latest detected gesture\n\nfloat GetGestureHoldDuration(void);               // Get gesture hold time in seconds\n\nVector2 GetGestureDragVector(void);               // Get gesture drag vector\n\nfloat GetGestureDragAngle(void);                  // Get gesture drag angle\n\nVector2 GetGesturePinchVector(void);              // Get gesture pinch delta\n\nfloat GetGesturePinchAngle(void);                 // Get gesture pinch angle\n\nvoid UpdateCamera(Camera *camera, int mode);      // Update camera position for selected mode\n\nvoid UpdateCameraPro(Camera *camera, Vector3 movement, Vector3 rotation, float zoom); // Update camera movement/rotation\n\nvoid SetShapesTexture(Texture2D texture, Rectangle source);       // Set texture and rectangle to be used on shapes drawing\n\nTexture2D GetShapesTexture(void);                                 // Get texture that is used for shapes drawing\n\nRectangle GetShapesTextureRectangle(void);                        // Get texture source rectangle that is used for shapes drawing\n\nvoid DrawPixel(int posX, int posY, Color color);                                                   // Draw a pixel using geometry [Can be slow, use with care]\n\nvoid DrawPixelV(Vector2 position, Color color);                                                    // Draw a pixel using geometry (Vector version) [Can be slow, use with care]\n\nvoid DrawLine(int startPosX, int startPosY, int endPosX, int endPosY, Color color);                // Draw a line\n\nvoid DrawLineV(Vector2 startPos, Vector2 endPos, Color color);                                     // Draw a line (using gl lines)\n\nvoid DrawLineEx(Vector2 startPos, Vector2 endPos, float thick, Color color);                       // Draw a line (using triangles/quads)\n\nvoid DrawLineStrip(const Vector2 *points, int pointCount, Color color);                            // Draw lines sequence (using gl lines)\n\nvoid DrawLineBezier(Vector2 startPos, Vector2 endPos, float thick, Color color);                   // Draw line segment cubic-bezier in-out interpolation\n\nvoid DrawCircle(int centerX, int centerY, float radius, Color color);                              // Draw a color-filled circle\n\nvoid DrawCircleSector(Vector2 center, float radius, float startAngle, float endAngle, int segments, Color color);      // Draw a piece of a circle\n\nvoid DrawCircleSectorLines(Vector2 center, float radius, float startAngle, float endAngle, int segments, Color color); // Draw circle sector outline\n\nvoid DrawCircleGradient(int centerX, int centerY, float radius, Color inner, Color outer);         // Draw a gradient-filled circle\n\nvoid DrawCircleV(Vector2 center, float radius, Color color);                                       // Draw a color-filled circle (Vector version)\n\nvoid DrawCircleLines(int centerX, int centerY, float radius, Color color);                         // Draw circle outline\n\nvoid DrawCircleLinesV(Vector2 center, float radius, Color color);                                  // Draw circle outline (Vector version)\n\nvoid DrawEllipse(int centerX, int centerY, float radiusH, float radiusV, Color color);             // Draw ellipse\n\nvoid DrawEllipseLines(int centerX, int centerY, float radiusH, float radiusV, Color color);        // Draw ellipse outline\n\nvoid DrawRing(Vector2 center, float innerRadius, float outerRadius, float startAngle, float endAngle, int segments, Color color); // Draw ring\n\nvoid DrawRingLines(Vector2 center, float innerRadius, float outerRadius, float startAngle, float endAngle, int segments, Color color);    // Draw ring outline\n\nvoid DrawRectangle(int posX, int posY, int width, int height, Color color);                        // Draw a color-filled rectangle\n\nvoid DrawRectangleV(Vector2 position, Vector2 size, Color color);                                  // Draw a color-filled rectangle (Vector version)\n\nvoid DrawRectangleRec(Rectangle rec, Color color);                                                 // Draw a color-filled rectangle\n\nvoid DrawRectanglePro(Rectangle rec, Vector2 origin, float rotation, Color color);                 // Draw a color-filled rectangle with pro parameters\n\nvoid DrawRectangleGradientV(int posX, int posY, int width, int height, Color top, Color bottom);   // Draw a vertical-gradient-filled rectangle\n\nvoid DrawRectangleGradientH(int posX, int posY, int width, int height, Color left, Color right);   // Draw a horizontal-gradient-filled rectangle\n\nvoid DrawRectangleGradientEx(Rectangle rec, Color topLeft, Color bottomLeft, Color topRight, Color bottomRight); // Draw a gradient-filled rectangle with custom vertex colors\n\nvoid DrawRectangleLines(int posX, int posY, int width, int height, Color color);                   // Draw rectangle outline\n\nvoid DrawRectangleLinesEx(Rectangle rec, float lineThick, Color color);                            // Draw rectangle outline with extended parameters\n\nvoid DrawRectangleRounded(Rectangle rec, float roundness, int segments, Color color);              // Draw rectangle with rounded edges\n\nvoid DrawRectangleRoundedLines(Rectangle rec, float roundness, int segments, Color color);         // Draw rectangle lines with rounded edges\n\nvoid DrawRectangleRoundedLinesEx(Rectangle rec, float roundness, int segments, float lineThick, Color color); // Draw rectangle with rounded edges outline\n\nvoid DrawTriangle(Vector2 v1, Vector2 v2, Vector2 v3, Color color);                                // Draw a color-filled triangle (vertex in counter-clockwise order!)\n\nvoid DrawTriangleLines(Vector2 v1, Vector2 v2, Vector2 v3, Color color);                           // Draw triangle outline (vertex in counter-clockwise order!)\n\nvoid DrawTriangleFan(const Vector2 *points, int pointCount, Color color);                          // Draw a triangle fan defined by points (first vertex is the center)\n\nvoid DrawTriangleStrip(const Vector2 *points, int pointCount, Color color);                        // Draw a triangle strip defined by points\n\nvoid DrawPoly(Vector2 center, int sides, float radius, float rotation, Color color);               // Draw a regular polygon (Vector version)\n\nvoid DrawPolyLines(Vector2 center, int sides, float radius, float rotation, Color color);          // Draw a polygon outline of n sides\n\nvoid DrawPolyLinesEx(Vector2 center, int sides, float radius, float rotation, float lineThick, Color color); // Draw a polygon outline of n sides with extended parameters\n\nvoid DrawSplineLinear(const Vector2 *points, int pointCount, float thick, Color color);                  // Draw spline: Linear, minimum 2 points\n\nvoid DrawSplineBasis(const Vector2 *points, int pointCount, float thick, Color color);                   // Draw spline: B-Spline, minimum 4 points\n\nvoid DrawSplineCatmullRom(const Vector2 *points, int pointCount, float thick, Color color);              // Draw spline: Catmull-Rom, minimum 4 points\n\nvoid DrawSplineBezierQuadratic(const Vector2 *points, int pointCount, float thick, Color color);         // Draw spline: Quadratic Bezier, minimum 3 points (1 control point): [p1, c2, p3, c4...]\n\nvoid DrawSplineBezierCubic(const Vector2 *points, int pointCount, float thick, Color color);             // Draw spline: Cubic Bezier, minimum 4 points (2 control points): [p1, c2, c3, p4, c5, c6...]\n\nvoid DrawSplineSegmentLinear(Vector2 p1, Vector2 p2, float thick, Color color);                    // Draw spline segment: Linear, 2 points\n\nvoid DrawSplineSegmentBasis(Vector2 p1, Vector2 p2, Vector2 p3, Vector2 p4, float thick, Color color); // Draw spline segment: B-Spline, 4 points\n\nvoid DrawSplineSegmentCatmullRom(Vector2 p1, Vector2 p2, Vector2 p3, Vector2 p4, float thick, Color color); // Draw spline segment: Catmull-Rom, 4 points\n\nvoid DrawSplineSegmentBezierQuadratic(Vector2 p1, Vector2 c2, Vector2 p3, float thick, Color color); // Draw spline segment: Quadratic Bezier, 2 points, 1 control point\n\nvoid DrawSplineSegmentBezierCubic(Vector2 p1, Vector2 c2, Vector2 c3, Vector2 p4, float thick, Color color); // Draw spline segment: Cubic Bezier, 2 points, 2 control points\n\nVector2 GetSplinePointLinear(Vector2 startPos, Vector2 endPos, float t);                           // Get (evaluate) spline point: Linear\n\nVector2 GetSplinePointBasis(Vector2 p1, Vector2 p2, Vector2 p3, Vector2 p4, float t);              // Get (evaluate) spline point: B-Spline\n\nVector2 GetSplinePointCatmullRom(Vector2 p1, Vector2 p2, Vector2 p3, Vector2 p4, float t);         // Get (evaluate) spline point: Catmull-Rom\n\nVector2 GetSplinePointBezierQuad(Vector2 p1, Vector2 c2, Vector2 p3, float t);                     // Get (evaluate) spline point: Quadratic Bezier\n\nVector2 GetSplinePointBezierCubic(Vector2 p1, Vector2 c2, Vector2 c3, Vector2 p4, float t);        // Get (evaluate) spline point: Cubic Bezier\n\nbool CheckCollisionRecs(Rectangle rec1, Rectangle rec2);                                           // Check collision between two rectangles\n\nbool CheckCollisionCircles(Vector2 center1, float radius1, Vector2 center2, float radius2);        // Check collision between two circles\n\nbool CheckCollisionCircleRec(Vector2 center, float radius, Rectangle rec);                         // Check collision between circle and rectangle\n\nbool CheckCollisionCircleLine(Vector2 center, float radius, Vector2 p1, Vector2 p2);               // Check if circle collides with a line created betweeen two points [p1] and [p2]\n\nbool CheckCollisionPointRec(Vector2 point, Rectangle rec);                                         // Check if point is inside rectangle\n\nbool CheckCollisionPointCircle(Vector2 point, Vector2 center, float radius);                       // Check if point is inside circle\n\nbool CheckCollisionPointTriangle(Vector2 point, Vector2 p1, Vector2 p2, Vector2 p3);               // Check if point is inside a triangle\n\nbool CheckCollisionPointLine(Vector2 point, Vector2 p1, Vector2 p2, int threshold);                // Check if point belongs to line created between two points [p1] and [p2] with defined margin in pixels [threshold]\n\nbool CheckCollisionPointPoly(Vector2 point, const Vector2 *points, int pointCount);                // Check if point is within a polygon described by array of vertices\n\nbool CheckCollisionLines(Vector2 startPos1, Vector2 endPos1, Vector2 startPos2, Vector2 endPos2, Vector2 *collisionPoint); // Check the collision between two lines defined by two points each, returns collision point by reference\n\nRectangle GetCollisionRec(Rectangle rec1, Rectangle rec2);                                         // Get collision rectangle for two rectangles collision\n\nImage LoadImage(const char *fileName);                                                             // Load image from file into CPU memory (RAM)\n\nImage LoadImageRaw(const char *fileName, int width, int height, int format, int headerSize);       // Load image from RAW file data\n\nImage LoadImageAnim(const char *fileName, int *frames);                                            // Load image sequence from file (frames appended to image.data)\n\nImage LoadImageAnimFromMemory(const char *fileType, const unsigned char *fileData, int dataSize, int *frames); // Load image sequence from memory buffer\n\nImage LoadImageFromMemory(const char *fileType, const unsigned char *fileData, int dataSize);      // Load image from memory buffer, fileType refers to extension: i.e. '.png'\n\nImage LoadImageFromTexture(Texture2D texture);                                                     // Load image from GPU texture data\n\nImage LoadImageFromScreen(void);                                                                   // Load image from screen buffer and (screenshot)\n\nbool IsImageValid(Image image);                                                                    // Check if an image is valid (data and parameters)\n\nvoid UnloadImage(Image image);                                                                     // Unload image from CPU memory (RAM)\n\nbool ExportImage(Image image, const char *fileName);                                               // Export image data to file, returns true on success\n\nunsigned char *ExportImageToMemory(Image image, const char *fileType, int *fileSize);              // Export image to memory buffer\n\nbool ExportImageAsCode(Image image, const char *fileName);                                         // Export image as code file defining an array of bytes, returns true on success\n\nImage GenImageColor(int width, int height, Color color);                                           // Generate image: plain color\n\nImage GenImageGradientLinear(int width, int height, int direction, Color start, Color end);        // Generate image: linear gradient, direction in degrees [0..360], 0=Vertical gradient\n\nImage GenImageGradientRadial(int width, int height, float density, Color inner, Color outer);      // Generate image: radial gradient\n\nImage GenImageGradientSquare(int width, int height, float density, Color inner, Color outer);      // Generate image: square gradient\n\nImage GenImageChecked(int width, int height, int checksX, int checksY, Color col1, Color col2);    // Generate image: checked\n\nImage GenImageWhiteNoise(int width, int height, float factor);                                     // Generate image: white noise\n\nImage GenImagePerlinNoise(int width, int height, int offsetX, int offsetY, float scale);           // Generate image: perlin noise\n\nImage GenImageCellular(int width, int height, int tileSize);                                       // Generate image: cellular algorithm, bigger tileSize means bigger cells\n\nImage GenImageText(int width, int height, const char *text);                                       // Generate image: grayscale image from text data\n\nImage ImageCopy(Image image);                                                                      // Create an image duplicate (useful for transformations)\n\nImage ImageFromImage(Image image, Rectangle rec);                                                  // Create an image from another image piece\n\nImage ImageFromChannel(Image image, int selectedChannel);                                          // Create an image from a selected channel of another image (GRAYSCALE)\n\nImage ImageText(const char *text, int fontSize, Color color);                                      // Create an image from text (default font)\n\nImage ImageTextEx(Font font, const char *text, float fontSize, float spacing, Color tint);         // Create an image from text (custom sprite font)\n\nvoid ImageFormat(Image *image, int newFormat);                                                     // Convert image data to desired format\n\nvoid ImageToPOT(Image *image, Color fill);                                                         // Convert image to POT (power-of-two)\n\nvoid ImageCrop(Image *image, Rectangle crop);                                                      // Crop an image to a defined rectangle\n\nvoid ImageAlphaCrop(Image *image, float threshold);                                                // Crop image depending on alpha value\n\nvoid ImageAlphaClear(Image *image, Color color, float threshold);                                  // Clear alpha channel to desired color\n\nvoid ImageAlphaMask(Image *image, Image alphaMask);                                                // Apply alpha mask to image\n\nvoid ImageAlphaPremultiply(Image *image);                                                          // Premultiply alpha channel\n\nvoid ImageBlurGaussian(Image *image, int blurSize);                                                // Apply Gaussian blur using a box blur approximation\n\nvoid ImageKernelConvolution(Image *image, const float *kernel, int kernelSize);                    // Apply custom square convolution kernel to image\n\nvoid ImageResize(Image *image, int newWidth, int newHeight);                                       // Resize image (Bicubic scaling algorithm)\n\nvoid ImageResizeNN(Image *image, int newWidth,int newHeight);                                      // Resize image (Nearest-Neighbor scaling algorithm)\n\nvoid ImageResizeCanvas(Image *image, int newWidth, int newHeight, int offsetX, int offsetY, Color fill); // Resize canvas and fill with color\n\nvoid ImageMipmaps(Image *image);                                                                   // Compute all mipmap levels for a provided image\n\nvoid ImageDither(Image *image, int rBpp, int gBpp, int bBpp, int aBpp);                            // Dither image data to 16bpp or lower (Floyd-Steinberg dithering)\n\nvoid ImageFlipVertical(Image *image);                                                              // Flip image vertically\n\nvoid ImageFlipHorizontal(Image *image);                                                            // Flip image horizontally\n\nvoid ImageRotate(Image *image, int degrees);                                                       // Rotate image by input angle in degrees (-359 to 359)\n\nvoid ImageRotateCW(Image *image);                                                                  // Rotate image clockwise 90deg\n\nvoid ImageRotateCCW(Image *image);                                                                 // Rotate image counter-clockwise 90deg\n\nvoid ImageColorTint(Image *image, Color color);                                                    // Modify image color: tint\n\nvoid ImageColorInvert(Image *image);                                                               // Modify image color: invert\n\nvoid ImageColorGrayscale(Image *image);                                                            // Modify image color: grayscale\n\nvoid ImageColorContrast(Image *image, float contrast);                                             // Modify image color: contrast (-100 to 100)\n\nvoid ImageColorBrightness(Image *image, int brightness);                                           // Modify image color: brightness (-255 to 255)\n\nvoid ImageColorReplace(Image *image, Color color, Color replace);                                  // Modify image color: replace color\n\nColor *LoadImageColors(Image image);                                                               // Load color data from image as a Color array (RGBA - 32bit)\n\nColor *LoadImagePalette(Image image, int maxPaletteSize, int *colorCount);                         // Load colors palette from image as a Color array (RGBA - 32bit)\n\nvoid UnloadImageColors(Color *colors);                                                             // Unload color data loaded with LoadImageColors()\n\nvoid UnloadImagePalette(Color *colors);                                                            // Unload colors palette loaded with LoadImagePalette()\n\nRectangle GetImageAlphaBorder(Image image, float threshold);                                       // Get image alpha border rectangle\n\nColor GetImageColor(Image image, int x, int y);                                                    // Get image pixel color at (x, y) position\n\nvoid ImageClearBackground(Image *dst, Color color);                                                // Clear image background with given color\n\nvoid ImageDrawPixel(Image *dst, int posX, int posY, Color color);                                  // Draw pixel within an image\n\nvoid ImageDrawPixelV(Image *dst, Vector2 position, Color color);                                   // Draw pixel within an image (Vector version)\n\nvoid ImageDrawLine(Image *dst, int startPosX, int startPosY, int endPosX, int endPosY, Color color); // Draw line within an image\n\nvoid ImageDrawLineV(Image *dst, Vector2 start, Vector2 end, Color color);                          // Draw line within an image (Vector version)\n\nvoid ImageDrawLineEx(Image *dst, Vector2 start, Vector2 end, int thick, Color color);              // Draw a line defining thickness within an image\n\nvoid ImageDrawCircle(Image *dst, int centerX, int centerY, int radius, Color color);               // Draw a filled circle within an image\n\nvoid ImageDrawCircleV(Image *dst, Vector2 center, int radius, Color color);                        // Draw a filled circle within an image (Vector version)\n\nvoid ImageDrawCircleLines(Image *dst, int centerX, int centerY, int radius, Color color);          // Draw circle outline within an image\n\nvoid ImageDrawCircleLinesV(Image *dst, Vector2 center, int radius, Color color);                   // Draw circle outline within an image (Vector version)\n\nvoid ImageDrawRectangle(Image *dst, int posX, int posY, int width, int height, Color color);       // Draw rectangle within an image\n\nvoid ImageDrawRectangleV(Image *dst, Vector2 position, Vector2 size, Color color);                 // Draw rectangle within an image (Vector version)\n\nvoid ImageDrawRectangleRec(Image *dst, Rectangle rec, Color color);                                // Draw rectangle within an image\n\nvoid ImageDrawRectangleLines(Image *dst, Rectangle rec, int thick, Color color);                   // Draw rectangle lines within an image\n\nvoid ImageDrawTriangle(Image *dst, Vector2 v1, Vector2 v2, Vector2 v3, Color color);               // Draw triangle within an image\n\nvoid ImageDrawTriangleEx(Image *dst, Vector2 v1, Vector2 v2, Vector2 v3, Color c1, Color c2, Color c3); // Draw triangle with interpolated colors within an image\n\nvoid ImageDrawTriangleLines(Image *dst, Vector2 v1, Vector2 v2, Vector2 v3, Color color);          // Draw triangle outline within an image\n\nvoid ImageDrawTriangleFan(Image *dst, Vector2 *points, int pointCount, Color color);               // Draw a triangle fan defined by points within an image (first vertex is the center)\n\nvoid ImageDrawTriangleStrip(Image *dst, Vector2 *points, int pointCount, Color color);             // Draw a triangle strip defined by points within an image\n\nvoid ImageDraw(Image *dst, Image src, Rectangle srcRec, Rectangle dstRec, Color tint);             // Draw a source image within a destination image (tint applied to source)\n\nvoid ImageDrawText(Image *dst, const char *text, int posX, int posY, int fontSize, Color color);   // Draw text (using default font) within an image (destination)\n\nvoid ImageDrawTextEx(Image *dst, Font font, const char *text, Vector2 position, float fontSize, float spacing, Color tint); // Draw text (custom sprite font) within an image (destination)\n\nTexture2D LoadTexture(const char *fileName);                                                       // Load texture from file into GPU memory (VRAM)\n\nTexture2D LoadTextureFromImage(Image image);                                                       // Load texture from image data\n\nTextureCubemap LoadTextureCubemap(Image image, int layout);                                        // Load cubemap from image, multiple image cubemap layouts supported\n\nRenderTexture2D LoadRenderTexture(int width, int height);                                          // Load texture for rendering (framebuffer)\n\nbool IsTextureValid(Texture2D texture);                                                            // Check if a texture is valid (loaded in GPU)\n\nvoid UnloadTexture(Texture2D texture);                                                             // Unload texture from GPU memory (VRAM)\n\nbool IsRenderTextureValid(RenderTexture2D target);                                                 // Check if a render texture is valid (loaded in GPU)\n\nvoid UnloadRenderTexture(RenderTexture2D target);                                                  // Unload render texture from GPU memory (VRAM)\n\nvoid UpdateTexture(Texture2D texture, const void *pixels);                                         // Update GPU texture with new data\n\nvoid UpdateTextureRec(Texture2D texture, Rectangle rec, const void *pixels);                       // Update GPU texture rectangle with new data\n\nvoid GenTextureMipmaps(Texture2D *texture);                                                        // Generate GPU mipmaps for a texture\n\nvoid SetTextureFilter(Texture2D texture, int filter);                                              // Set texture scaling filter mode\n\nvoid SetTextureWrap(Texture2D texture, int wrap);                                                  // Set texture wrapping mode\n\nvoid DrawTexture(Texture2D texture, int posX, int posY, Color tint);                               // Draw a Texture2D\n\nvoid DrawTextureV(Texture2D texture, Vector2 position, Color tint);                                // Draw a Texture2D with position defined as Vector2\n\nvoid DrawTextureEx(Texture2D texture, Vector2 position, float rotation, float scale, Color tint);  // Draw a Texture2D with extended parameters\n\nvoid DrawTextureRec(Texture2D texture, Rectangle source, Vector2 position, Color tint);            // Draw a part of a texture defined by a rectangle\n\nvoid DrawTexturePro(Texture2D texture, Rectangle source, Rectangle dest, Vector2 origin, float rotation, Color tint); // Draw a part of a texture defined by a rectangle with 'pro' parameters\n\nvoid DrawTextureNPatch(Texture2D texture, NPatchInfo nPatchInfo, Rectangle dest, Vector2 origin, float rotation, Color tint); // Draws a texture (or part of it) that stretches or shrinks nicely\n\nbool ColorIsEqual(Color col1, Color col2);                            // Check if two colors are equal\n\nColor Fade(Color color, float alpha);                                 // Get color with alpha applied, alpha goes from 0.0f to 1.0f\n\nint ColorToInt(Color color);                                          // Get hexadecimal value for a Color (0xRRGGBBAA)\n\nVector4 ColorNormalize(Color color);                                  // Get Color normalized as float [0..1]\n\nColor ColorFromNormalized(Vector4 normalized);                        // Get Color from normalized values [0..1]\n\nVector3 ColorToHSV(Color color);                                      // Get HSV values for a Color, hue [0..360], saturation/value [0..1]\n\nColor ColorFromHSV(float hue, float saturation, float value);         // Get a Color from HSV values, hue [0..360], saturation/value [0..1]\n\nColor ColorTint(Color color, Color tint);                             // Get color multiplied with another color\n\nColor ColorBrightness(Color color, float factor);                     // Get color with brightness correction, brightness factor goes from -1.0f to 1.0f\n\nColor ColorContrast(Color color, float contrast);                     // Get color with contrast correction, contrast values between -1.0f and 1.0f\n\nColor ColorAlpha(Color color, float alpha);                           // Get color with alpha applied, alpha goes from 0.0f to 1.0f\n\nColor ColorAlphaBlend(Color dst, Color src, Color tint);              // Get src alpha-blended into dst color with tint\n\nColor ColorLerp(Color color1, Color color2, float factor);            // Get color lerp interpolation between two colors, factor [0.0f..1.0f]\n\nColor GetColor(unsigned int hexValue);                                // Get Color structure from hexadecimal value\n\nColor GetPixelColor(void *srcPtr, int format);                        // Get Color from a source pixel pointer of certain format\n\nvoid SetPixelColor(void *dstPtr, Color color, int format);            // Set color formatted into destination pixel pointer\n\nint GetPixelDataSize(int width, int height, int format);              // Get pixel data size in bytes for certain format\n\nFont GetFontDefault(void);                                                            // Get the default Font\n\nFont LoadFont(const char *fileName);                                                  // Load font from file into GPU memory (VRAM)\n\nFont LoadFontEx(const char *fileName, int fontSize, int *codepoints, int codepointCount); // Load font from file with extended parameters, use NULL for codepoints and 0 for codepointCount to load the default character set, font size is provided in pixels height\n\nFont LoadFontFromImage(Image image, Color key, int firstChar);                        // Load font from Image (XNA style)\n\nFont LoadFontFromMemory(const char *fileType, const unsigned char *fileData, int dataSize, int fontSize, int *codepoints, int codepointCount); // Load font from memory buffer, fileType refers to extension: i.e. '.ttf'\n\nbool IsFontValid(Font font);                                                          // Check if a font is valid (font data loaded, WARNING: GPU texture not checked)\n\nGlyphInfo *LoadFontData(const unsigned char *fileData, int dataSize, int fontSize, int *codepoints, int codepointCount, int type); // Load font data for further use\n\nImage GenImageFontAtlas(const GlyphInfo *glyphs, Rectangle **glyphRecs, int glyphCount, int fontSize, int padding, int packMethod); // Generate image font atlas using chars info\n\nvoid UnloadFontData(GlyphInfo *glyphs, int glyphCount);                               // Unload font chars info data (RAM)\n\nvoid UnloadFont(Font font);                                                           // Unload font from GPU memory (VRAM)\n\nbool ExportFontAsCode(Font font, const char *fileName);                               // Export font as code file, returns true on success\n\nvoid DrawFPS(int posX, int posY);                                                     // Draw current FPS\n\nvoid DrawText(const char *text, int posX, int posY, int fontSize, Color color);       // Draw text (using default font)\n\nvoid DrawTextEx(Font font, const char *text, Vector2 position, float fontSize, float spacing, Color tint); // Draw text using font and additional parameters\n\nvoid DrawTextPro(Font font, const char *text, Vector2 position, Vector2 origin, float rotation, float fontSize, float spacing, Color tint); // Draw text using Font and pro parameters (rotation)\n\nvoid DrawTextCodepoint(Font font, int codepoint, Vector2 position, float fontSize, Color tint); // Draw one character (codepoint)\n\nvoid DrawTextCodepoints(Font font, const int *codepoints, int codepointCount, Vector2 position, float fontSize, float spacing, Color tint); // Draw multiple character (codepoint)\n\nvoid SetTextLineSpacing(int spacing);                                                 // Set vertical line spacing when drawing with line-breaks\n\nint MeasureText(const char *text, int fontSize);                                      // Measure string width for default font\n\nVector2 MeasureTextEx(Font font, const char *text, float fontSize, float spacing);    // Measure string size for Font\n\nint GetGlyphIndex(Font font, int codepoint);                                          // Get glyph index position in font for a codepoint (unicode character), fallback to '?' if not found\n\nGlyphInfo GetGlyphInfo(Font font, int codepoint);                                     // Get glyph font info data for a codepoint (unicode character), fallback to '?' if not found\n\nRectangle GetGlyphAtlasRec(Font font, int codepoint);                                 // Get glyph rectangle in font atlas for a codepoint (unicode character), fallback to '?' if not found\n\nchar *LoadUTF8(const int *codepoints, int length);                // Load UTF-8 text encoded from codepoints array\n\nvoid UnloadUTF8(char *text);                                      // Unload UTF-8 text encoded from codepoints array\n\nint *LoadCodepoints(const char *text, int *count);                // Load all codepoints from a UTF-8 text string, codepoints count returned by parameter\n\nvoid UnloadCodepoints(int *codepoints);                           // Unload codepoints data from memory\n\nint GetCodepointCount(const char *text);                          // Get total number of codepoints in a UTF-8 encoded string\n\nint GetCodepoint(const char *text, int *codepointSize);           // Get next codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure\n\nint GetCodepointNext(const char *text, int *codepointSize);       // Get next codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure\n\nint GetCodepointPrevious(const char *text, int *codepointSize);   // Get previous codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure\n\nconst char *CodepointToUTF8(int codepoint, int *utf8Size);        // Encode one codepoint into UTF-8 byte array (array length returned as parameter)\n\nint TextCopy(char *dst, const char *src);                                             // Copy one string to another, returns bytes copied\n\nbool TextIsEqual(const char *text1, const char *text2);                               // Check if two text string are equal\n\nunsigned int TextLength(const char *text);                                            // Get text length, checks for '\0' ending\n\nconst char *TextFormat(const char *text, ...);                                        // Text formatting with variables (sprintf() style)\n\nconst char *TextSubtext(const char *text, int position, int length);                  // Get a piece of a text string\n\nchar *TextReplace(const char *text, const char *replace, const char *by);             // Replace text string (WARNING: memory must be freed!)\n\nchar *TextInsert(const char *text, const char *insert, int position);                 // Insert text in a position (WARNING: memory must be freed!)\n\nconst char *TextJoin(const char **textList, int count, const char *delimiter);        // Join text strings with delimiter\n\nconst char **TextSplit(const char *text, char delimiter, int *count);                 // Split text into multiple strings\n\nvoid TextAppend(char *text, const char *append, int *position);                       // Append text at specific position and move cursor!\n\nint TextFindIndex(const char *text, const char *find);                                // Find first text occurrence within a string\n\nconst char *TextToUpper(const char *text);                      // Get upper case version of provided string\n\nconst char *TextToLower(const char *text);                      // Get lower case version of provided string\n\nconst char *TextToPascal(const char *text);                     // Get Pascal case notation version of provided string\n\nconst char *TextToSnake(const char *text);                      // Get Snake case notation version of provided string\n\nconst char *TextToCamel(const char *text);                      // Get Camel case notation version of provided string\n\nint TextToInteger(const char *text);                            // Get integer value from text (negative values not supported)\n\nfloat TextToFloat(const char *text);                            // Get float value from text (negative values not supported)\n\nvoid DrawLine3D(Vector3 startPos, Vector3 endPos, Color color);                                    // Draw a line in 3D world space\n\nvoid DrawPoint3D(Vector3 position, Color color);                                                   // Draw a point in 3D space, actually a small line\n\nvoid DrawCircle3D(Vector3 center, float radius, Vector3 rotationAxis, float rotationAngle, Color color); // Draw a circle in 3D world space\n\nvoid DrawTriangle3D(Vector3 v1, Vector3 v2, Vector3 v3, Color color);                              // Draw a color-filled triangle (vertex in counter-clockwise order!)\n\nvoid DrawTriangleStrip3D(const Vector3 *points, int pointCount, Color color);                      // Draw a triangle strip defined by points\n\nvoid DrawCube(Vector3 position, float width, float height, float length, Color color);             // Draw cube\n\nvoid DrawCubeV(Vector3 position, Vector3 size, Color color);                                       // Draw cube (Vector version)\n\nvoid DrawCubeWires(Vector3 position, float width, float height, float length, Color color);        // Draw cube wires\n\nvoid DrawCubeWiresV(Vector3 position, Vector3 size, Color color);                                  // Draw cube wires (Vector version)\n\nvoid DrawSphere(Vector3 centerPos, float radius, Color color);                                     // Draw sphere\n\nvoid DrawSphereEx(Vector3 centerPos, float radius, int rings, int slices, Color color);            // Draw sphere with extended parameters\n\nvoid DrawSphereWires(Vector3 centerPos, float radius, int rings, int slices, Color color);         // Draw sphere wires\n\nvoid DrawCylinder(Vector3 position, float radiusTop, float radiusBottom, float height, int slices, Color color); // Draw a cylinder/cone\n\nvoid DrawCylinderEx(Vector3 startPos, Vector3 endPos, float startRadius, float endRadius, int sides, Color color); // Draw a cylinder with base at startPos and top at endPos\n\nvoid DrawCylinderWires(Vector3 position, float radiusTop, float radiusBottom, float height, int slices, Color color); // Draw a cylinder/cone wires\n\nvoid DrawCylinderWiresEx(Vector3 startPos, Vector3 endPos, float startRadius, float endRadius, int sides, Color color); // Draw a cylinder wires with base at startPos and top at endPos\n\nvoid DrawCapsule(Vector3 startPos, Vector3 endPos, float radius, int slices, int rings, Color color); // Draw a capsule with the center of its sphere caps at startPos and endPos\n\nvoid DrawCapsuleWires(Vector3 startPos, Vector3 endPos, float radius, int slices, int rings, Color color); // Draw capsule wireframe with the center of its sphere caps at startPos and endPos\n\nvoid DrawPlane(Vector3 centerPos, Vector2 size, Color color);                                      // Draw a plane XZ\n\nvoid DrawRay(Ray ray, Color color);                                                                // Draw a ray line\n\nvoid DrawGrid(int slices, float spacing);                                                          // Draw a grid (centered at (0, 0, 0))\n\nModel LoadModel(const char *fileName);                                                // Load model from files (meshes and materials)\n\nModel LoadModelFromMesh(Mesh mesh);                                                   // Load model from generated mesh (default material)\n\nbool IsModelValid(Model model);                                                       // Check if a model is valid (loaded in GPU, VAO/VBOs)\n\nvoid UnloadModel(Model model);                                                        // Unload model (including meshes) from memory (RAM and/or VRAM)\n\nBoundingBox GetModelBoundingBox(Model model);                                         // Compute model bounding box limits (considers all meshes)\n\nvoid DrawModel(Model model, Vector3 position, float scale, Color tint);               // Draw a model (with texture if set)\n\nvoid DrawModelEx(Model model, Vector3 position, Vector3 rotationAxis, float rotationAngle, Vector3 scale, Color tint); // Draw a model with extended parameters\n\nvoid DrawModelWires(Model model, Vector3 position, float scale, Color tint);          // Draw a model wires (with texture if set)\n\nvoid DrawModelWiresEx(Model model, Vector3 position, Vector3 rotationAxis, float rotationAngle, Vector3 scale, Color tint); // Draw a model wires (with texture if set) with extended parameters\n\nvoid DrawModelPoints(Model model, Vector3 position, float scale, Color tint); // Draw a model as points\n\nvoid DrawModelPointsEx(Model model, Vector3 position, Vector3 rotationAxis, float rotationAngle, Vector3 scale, Color tint); // Draw a model as points with extended parameters\n\nvoid DrawBoundingBox(BoundingBox box, Color color);                                   // Draw bounding box (wires)\n\nvoid DrawBillboard(Camera camera, Texture2D texture, Vector3 position, float scale, Color tint);   // Draw a billboard texture\n\nvoid DrawBillboardRec(Camera camera, Texture2D texture, Rectangle source, Vector3 position, Vector2 size, Color tint); // Draw a billboard texture defined by source\n\nvoid DrawBillboardPro(Camera camera, Texture2D texture, Rectangle source, Vector3 position, Vector3 up, Vector2 size, Vector2 origin, float rotation, Color tint); // Draw a billboard texture defined by source and rotation\n\nvoid UploadMesh(Mesh *mesh, bool dynamic);                                            // Upload mesh vertex data in GPU and provide VAO/VBO ids\n\nvoid UpdateMeshBuffer(Mesh mesh, int index, const void *data, int dataSize, int offset); // Update mesh vertex data in GPU for a specific buffer index\n\nvoid UnloadMesh(Mesh mesh);                                                           // Unload mesh data from CPU and GPU\n\nvoid DrawMesh(Mesh mesh, Material material, Matrix transform);                        // Draw a 3d mesh with material and transform\n\nvoid DrawMeshInstanced(Mesh mesh, Material material, const Matrix *transforms, int instances); // Draw multiple mesh instances with material and different transforms\n\nBoundingBox GetMeshBoundingBox(Mesh mesh);                                            // Compute mesh bounding box limits\n\nvoid GenMeshTangents(Mesh *mesh);                                                     // Compute mesh tangents\n\nbool ExportMesh(Mesh mesh, const char *fileName);                                     // Export mesh data to file, returns true on success\n\nbool ExportMeshAsCode(Mesh mesh, const char *fileName);                               // Export mesh as code file (.h) defining multiple arrays of vertex attributes\n\nMesh GenMeshPoly(int sides, float radius);                                            // Generate polygonal mesh\n\nMesh GenMeshPlane(float width, float length, int resX, int resZ);                     // Generate plane mesh (with subdivisions)\n\nMesh GenMeshCube(float width, float height, float length);                            // Generate cuboid mesh\n\nMesh GenMeshSphere(float radius, int rings, int slices);                              // Generate sphere mesh (standard sphere)\n\nMesh GenMeshHemiSphere(float radius, int rings, int slices);                          // Generate half-sphere mesh (no bottom cap)\n\nMesh GenMeshCylinder(float radius, float height, int slices);                         // Generate cylinder mesh\n\nMesh GenMeshCone(float radius, float height, int slices);                             // Generate cone/pyramid mesh\n\nMesh GenMeshTorus(float radius, float size, int radSeg, int sides);                   // Generate torus mesh\n\nMesh GenMeshKnot(float radius, float size, int radSeg, int sides);                    // Generate trefoil knot mesh\n\nMesh GenMeshHeightmap(Image heightmap, Vector3 size);                                 // Generate heightmap mesh from image data\n\nMesh GenMeshCubicmap(Image cubicmap, Vector3 cubeSize);                               // Generate cubes-based map mesh from image data\n\nMaterial *LoadMaterials(const char *fileName, int *materialCount);                    // Load materials from model file\n\nMaterial LoadMaterialDefault(void);                                                   // Load default material (Supports: DIFFUSE, SPECULAR, NORMAL maps)\n\nbool IsMaterialValid(Material material);                                              // Check if a material is valid (shader assigned, map textures loaded in GPU)\n\nvoid UnloadMaterial(Material material);                                               // Unload material from GPU memory (VRAM)\n\nvoid SetMaterialTexture(Material *material, int mapType, Texture2D texture);          // Set texture for a material map type (MATERIAL_MAP_DIFFUSE, MATERIAL_MAP_SPECULAR...)\n\nvoid SetModelMeshMaterial(Model *model, int meshId, int materialId);                  // Set material for a mesh\n\nModelAnimation *LoadModelAnimations(const char *fileName, int *animCount);            // Load model animations from file\n\nvoid UpdateModelAnimation(Model model, ModelAnimation anim, int frame);               // Update model animation pose (CPU)\n\nvoid UpdateModelAnimationBones(Model model, ModelAnimation anim, int frame);          // Update model animation mesh bone matrices (GPU skinning)\n\nvoid UnloadModelAnimation(ModelAnimation anim);                                       // Unload animation data\n\nvoid UnloadModelAnimations(ModelAnimation *animations, int animCount);                // Unload animation array data\n\nbool IsModelAnimationValid(Model model, ModelAnimation anim);                         // Check model animation skeleton match\n\nbool CheckCollisionSpheres(Vector3 center1, float radius1, Vector3 center2, float radius2);   // Check collision between two spheres\n\nbool CheckCollisionBoxes(BoundingBox box1, BoundingBox box2);                                 // Check collision between two bounding boxes\n\nbool CheckCollisionBoxSphere(BoundingBox box, Vector3 center, float radius);                  // Check collision between box and sphere\n\nRayCollision GetRayCollisionSphere(Ray ray, Vector3 center, float radius);                    // Get collision info between ray and sphere\n\nRayCollision GetRayCollisionBox(Ray ray, BoundingBox box);                                    // Get collision info between ray and box\n\nRayCollision GetRayCollisionMesh(Ray ray, Mesh mesh, Matrix transform);                       // Get collision info between ray and mesh\n\nRayCollision GetRayCollisionTriangle(Ray ray, Vector3 p1, Vector3 p2, Vector3 p3);            // Get collision info between ray and triangle\n\nRayCollision GetRayCollisionQuad(Ray ray, Vector3 p1, Vector3 p2, Vector3 p3, Vector3 p4);    // Get collision info between ray and quad\n\ntypedef void (*AudioCallback)(void *bufferData, unsigned int frames);\nvoid InitAudioDevice(void);                                     // Initialize audio device and context\n\nvoid CloseAudioDevice(void);                                    // Close the audio device and context\n\nbool IsAudioDeviceReady(void);                                  // Check if audio device has been initialized successfully\n\nvoid SetMasterVolume(float volume);                             // Set master volume (listener)\n\nfloat GetMasterVolume(void);                                    // Get master volume (listener)\n\nWave LoadWave(const char *fileName);                            // Load wave data from file\n\nWave LoadWaveFromMemory(const char *fileType, const unsigned char *fileData, int dataSize); // Load wave from memory buffer, fileType refers to extension: i.e. '.wav'\n\nbool IsWaveValid(Wave wave);                                    // Checks if wave data is valid (data loaded and parameters)\n\nSound LoadSound(const char *fileName);                          // Load sound from file\n\nSound LoadSoundFromWave(Wave wave);                             // Load sound from wave data\n\nSound LoadSoundAlias(Sound source);                             // Create a new sound that shares the same sample data as the source sound, does not own the sound data\n\nbool IsSoundValid(Sound sound);                                 // Checks if a sound is valid (data loaded and buffers initialized)\n\nvoid UpdateSound(Sound sound, const void *data, int sampleCount); // Update sound buffer with new data\n\nvoid UnloadWave(Wave wave);                                     // Unload wave data\n\nvoid UnloadSound(Sound sound);                                  // Unload sound\n\nvoid UnloadSoundAlias(Sound alias);                             // Unload a sound alias (does not deallocate sample data)\n\nbool ExportWave(Wave wave, const char *fileName);               // Export wave data to file, returns true on success\n\nbool ExportWaveAsCode(Wave wave, const char *fileName);         // Export wave sample data to code (.h), returns true on success\n\nvoid PlaySound(Sound sound);                                    // Play a sound\n\nvoid StopSound(Sound sound);                                    // Stop playing a sound\n\nvoid PauseSound(Sound sound);                                   // Pause a sound\n\nvoid ResumeSound(Sound sound);                                  // Resume a paused sound\n\nbool IsSoundPlaying(Sound sound);                               // Check if a sound is currently playing\n\nvoid SetSoundVolume(Sound sound, float volume);                 // Set volume for a sound (1.0 is max level)\n\nvoid SetSoundPitch(Sound sound, float pitch);                   // Set pitch for a sound (1.0 is base level)\n\nvoid SetSoundPan(Sound sound, float pan);                       // Set pan for a sound (0.5 is center)\n\nWave WaveCopy(Wave wave);                                       // Copy a wave to a new wave\n\nvoid WaveCrop(Wave *wave, int initFrame, int finalFrame);       // Crop a wave to defined frames range\n\nvoid WaveFormat(Wave *wave, int sampleRate, int sampleSize, int channels); // Convert wave data to desired format\n\nfloat *LoadWaveSamples(Wave wave);                              // Load samples data from wave as a 32bit float data array\n\nvoid UnloadWaveSamples(float *samples);                         // Unload samples data loaded with LoadWaveSamples()\n\nMusic LoadMusicStream(const char *fileName);                    // Load music stream from file\n\nMusic LoadMusicStreamFromMemory(const char *fileType, const unsigned char *data, int dataSize); // Load music stream from data\n\nbool IsMusicValid(Music music);                                 // Checks if a music stream is valid (context and buffers initialized)\n\nvoid UnloadMusicStream(Music music);                            // Unload music stream\n\nvoid PlayMusicStream(Music music);                              // Start music playing\n\nbool IsMusicStreamPlaying(Music music);                         // Check if music is playing\n\nvoid UpdateMusicStream(Music music);                            // Updates buffers for music streaming\n\nvoid StopMusicStream(Music music);                              // Stop music playing\n\nvoid PauseMusicStream(Music music);                             // Pause music playing\n\nvoid ResumeMusicStream(Music music);                            // Resume playing paused music\n\nvoid SeekMusicStream(Music music, float position);              // Seek music to a position (in seconds)\n\nvoid SetMusicVolume(Music music, float volume);                 // Set volume for music (1.0 is max level)\n\nvoid SetMusicPitch(Music music, float pitch);                   // Set pitch for a music (1.0 is base level)\n\nvoid SetMusicPan(Music music, float pan);                       // Set pan for a music (0.5 is center)\n\nfloat GetMusicTimeLength(Music music);                          // Get music time length (in seconds)\n\nfloat GetMusicTimePlayed(Music music);                          // Get current music time played (in seconds)\n\nAudioStream LoadAudioStream(unsigned int sampleRate, unsigned int sampleSize, unsigned int channels); // Load audio stream (to stream raw audio pcm data)\n\nbool IsAudioStreamValid(AudioStream stream);                    // Checks if an audio stream is valid (buffers initialized)\n\nvoid UnloadAudioStream(AudioStream stream);                     // Unload audio stream and free memory\n\nvoid UpdateAudioStream(AudioStream stream, const void *data, int frameCount); // Update audio stream buffers with data\n\nbool IsAudioStreamProcessed(AudioStream stream);                // Check if any audio stream buffers requires refill\n\nvoid PlayAudioStream(AudioStream stream);                       // Play audio stream\n\nvoid PauseAudioStream(AudioStream stream);                      // Pause audio stream\n\nvoid ResumeAudioStream(AudioStream stream);                     // Resume audio stream\n\nbool IsAudioStreamPlaying(AudioStream stream);                  // Check if audio stream is playing\n\nvoid StopAudioStream(AudioStream stream);                       // Stop audio stream\n\nvoid SetAudioStreamVolume(AudioStream stream, float volume);    // Set volume for audio stream (1.0 is max level)\n\nvoid SetAudioStreamPitch(AudioStream stream, float pitch);      // Set pitch for audio stream (1.0 is base level)\n\nvoid SetAudioStreamPan(AudioStream stream, float pan);          // Set pan for audio stream (0.5 is centered)\n\nvoid SetAudioStreamBufferSizeDefault(int size);                 // Default size for new audio streams\n\nvoid SetAudioStreamCallback(AudioStream stream, AudioCallback callback); // Audio thread callback to request new data\n\nvoid AttachAudioStreamProcessor(AudioStream stream, AudioCallback processor); // Attach audio stream processor to stream, receives the samples as 'float'\n\nvoid DetachAudioStreamProcessor(AudioStream stream, AudioCallback processor); // Detach audio stream processor from stream\n\nvoid AttachAudioMixedProcessor(AudioCallback processor); // Attach audio stream processor to the entire audio pipeline, receives the samples as 'float'\n\nvoid DetachAudioMixedProcessor(AudioCallback processor); // Detach audio stream processor from the entire audio pipeline\n\n")
local function Vector2(x, y)
  return ffi.new("Vector2", {x, y})
end
local function Vector3(x, y, z)
  return ffi.new("Vector3", {x, y, z})
end
local function Vector4(x, y, z, w)
  return ffi.new("Vector4", {x, y, z, w})
end
local function Quaternion(x, y, z, w)
  return ffi.new("Quaternion", {x, y, z, w})
end
local function Matrix(m0, m4, m8, m12, m1, m5, m9, m13, m2, m6, m10, m14, m3, m7, m11, m15)
  return ffi.new("Matrix", {m0, m4, m8, m12, m1, m5, m9, m13, m2, m6, m10, m14, m3, m7, m11, m15})
end
local function Color(r, g, b, a)
  return ffi.new("Color", {r, g, b, a})
end
local function Rectangle(x, y, width, height)
  return ffi.new("Rectangle", {x, y, width, height})
end
local function Image(data, width, height, mipmaps, format)
  return ffi.new("Image", {data, width, height, mipmaps, format})
end
local function Texture(id, width, height, mipmaps, format)
  return ffi.new("Texture", {id, width, height, mipmaps, format})
end
local function Texture2D(id, width, height, mipmaps, format)
  return ffi.new("Texture2D", {id, width, height, mipmaps, format})
end
local function TextureCubemap(id, width, height, mipmaps, format)
  return ffi.new("TextureCubemap", {id, width, height, mipmaps, format})
end
local function RenderTexture(id, texture, depth)
  return ffi.new("RenderTexture", {id, texture, depth})
end
local function RenderTexture2D(id, texture, depth)
  return ffi.new("RenderTexture2D", {id, texture, depth})
end
local function NPatchInfo(source, left, top, right, bottom, layout)
  return ffi.new("NPatchInfo", {source, left, top, right, bottom, layout})
end
local function GlyphInfo(value, offset_x, offset_y, advance_x, image)
  return ffi.new("GlyphInfo", {value, offset_x, offset_y, advance_x, image})
end
local function Font(base_size, glyph_count, glyph_padding, texture, recs, glyphs)
  return ffi.new("Font", {base_size, glyph_count, glyph_padding, texture, recs, glyphs})
end
local function Camera3D(position, target, up, fovy, projection)
  return ffi.new("Camera3D", {position, target, up, fovy, projection})
end
local function Camera(position, target, up, fovy, projection)
  return ffi.new("Camera", {position, target, up, fovy, projection})
end
local function Camera2D(offset, target, rotation, zoom)
  return ffi.new("Camera2D", {offset, target, rotation, zoom})
end
local function Mesh(vertex_count, triangle_count, vertices, texcoords, texcoords2, normals, tangents, colors, indices, anim_vertices, anim_normals, char_bone_ids, bone_weights, bone_matrices, bone_count, vao_id, vbo_id)
  return ffi.new("Mesh", {vertex_count, triangle_count, vertices, texcoords, texcoords2, normals, tangents, colors, indices, anim_vertices, anim_normals, char_bone_ids, bone_weights, bone_matrices, bone_count, vao_id, vbo_id})
end
local function Shader(id, locs)
  return ffi.new("Shader", {id, locs})
end
local function MaterialMap(texture, color, value)
  return ffi.new("MaterialMap", {texture, color, value})
end
local function Material(shader, maps, params)
  return ffi.new("Material", {shader, maps, params})
end
local function Transform(translation, rotation, scale)
  return ffi.new("Transform", {translation, rotation, scale})
end
local function BoneInfo(name, parent)
  return ffi.new("BoneInfo", {name, parent})
end
local function Model(transform, mesh_count, material_count, meshes, materials, mesh_material, bone_count, bones, bind_pose)
  return ffi.new("Model", {transform, mesh_count, material_count, meshes, materials, mesh_material, bone_count, bones, bind_pose})
end
local function ModelAnimation(bone_count, frame_count, bones, frame_poses, name)
  return ffi.new("ModelAnimation", {bone_count, frame_count, bones, frame_poses, name})
end
local function Ray(position, direction)
  return ffi.new("Ray", {position, direction})
end
local function RayCollision(hit, distance, point, normal)
  return ffi.new("RayCollision", {hit, distance, point, normal})
end
local function BoundingBox(min, max)
  return ffi.new("BoundingBox", {min, max})
end
local function Wave(frame_count, sample_rate, int_sample_size, int_channels, data)
  return ffi.new("Wave", {frame_count, sample_rate, int_sample_size, int_channels, data})
end
local function AudioStream(buffer, processor, sample_rate, int_sample_size, int_channels)
  return ffi.new("AudioStream", {buffer, processor, sample_rate, int_sample_size, int_channels})
end
local function Sound(stream, frame_count)
  return ffi.new("Sound", {stream, frame_count})
end
local function Music(stream, frame_count, looping, ctx_type, ctx_data)
  return ffi.new("Music", {stream, frame_count, looping, ctx_type, ctx_data})
end
local function VrDeviceInfo(h_resolution, v_resolution, h_screen_size, v_screen_size, eye_to_screen_distance, lens_separation_distance, interpupillary_distance, lens_distortion_values, chroma_ab_correction)
  return ffi.new("VrDeviceInfo", {h_resolution, v_resolution, h_screen_size, v_screen_size, eye_to_screen_distance, lens_separation_distance, interpupillary_distance, lens_distortion_values, chroma_ab_correction})
end
local function VrStereoConfig(projection, view_offset, left_lens_center, right_lens_center, left_screen_center, right_screen_center, scale, scale_in)
  return ffi.new("VrStereoConfig", {projection, view_offset, left_lens_center, right_lens_center, left_screen_center, right_screen_center, scale, scale_in})
end
local function FilePathList(capacity, count, paths)
  return ffi.new("FilePathList", {capacity, count, paths})
end
local function AutomationEvent(frame, type, params)
  return ffi.new("AutomationEvent", {frame, type, params})
end
local function AutomationEventList(capacity, count, events)
  return ffi.new("AutomationEventList", {capacity, count, events})
end
local flag_vsync_hint = 64
local flag_fullscreen_mode = 2
local flag_window_resizable = 4
local flag_window_undecorated = 8
local flag_window_hidden = 128
local flag_window_minimized = 512
local flag_window_maximized = 1024
local flag_window_unfocused = 2048
local flag_window_topmost = 4096
local flag_window_always_run = 256
local flag_window_transparent = 16
local flag_window_highdpi = 8192
local flag_window_mouse_passthrough = 16384
local flag_borderless_windowed_mode = 32768
local flag_msaa_4x_hint = 32
local flag_interlaced_hint = 65536
local log_all = 0
local log_trace = 1
local log_debug = 2
local log_info = 3
local log_warning = 4
local log_error = 5
local log_fatal = 6
local log_none = 7
local key_null = 0
local key_apostrophe = 39
local key_comma = 44
local key_minus = 45
local key_period = 46
local key_slash = 47
local key_zero = 48
local key_one = 49
local key_two = 50
local key_three = 51
local key_four = 52
local key_five = 53
local key_six = 54
local key_seven = 55
local key_eight = 56
local key_nine = 57
local key_semicolon = 59
local key_equal = 61
local key_a = 65
local key_b = 66
local key_c = 67
local key_d = 68
local key_e = 69
local key_f = 70
local key_g = 71
local key_h = 72
local key_i = 73
local key_j = 74
local key_k = 75
local key_l = 76
local key_m = 77
local key_n = 78
local key_o = 79
local key_p = 80
local key_q = 81
local key_r = 82
local key_s = 83
local key_t = 84
local key_u = 85
local key_v = 86
local key_w = 87
local key_x = 88
local key_y = 89
local key_z = 90
local key_left_bracket = 91
local key_backslash = 92
local key_right_bracket = 93
local key_grave = 96
local key_space = 32
local key_escape = 256
local key_enter = 257
local key_tab = 258
local key_backspace = 259
local key_insert = 260
local key_delete = 261
local key_right = 262
local key_left = 263
local key_down = 264
local key_up = 265
local key_page_up = 266
local key_page_down = 267
local key_home = 268
local key_end = 269
local key_caps_lock = 280
local key_scroll_lock = 281
local key_num_lock = 282
local key_print_screen = 283
local key_pause = 284
local key_f1 = 290
local key_f2 = 291
local key_f3 = 292
local key_f4 = 293
local key_f5 = 294
local key_f6 = 295
local key_f7 = 296
local key_f8 = 297
local key_f9 = 298
local key_f10 = 299
local key_f11 = 300
local key_f12 = 301
local key_left_shift = 340
local key_left_control = 341
local key_left_alt = 342
local key_left_super = 343
local key_right_shift = 344
local key_right_control = 345
local key_right_alt = 346
local key_right_super = 347
local key_kb_menu = 348
local key_kp_0 = 320
local key_kp_1 = 321
local key_kp_2 = 322
local key_kp_3 = 323
local key_kp_4 = 324
local key_kp_5 = 325
local key_kp_6 = 326
local key_kp_7 = 327
local key_kp_8 = 328
local key_kp_9 = 329
local key_kp_decimal = 330
local key_kp_divide = 331
local key_kp_multiply = 332
local key_kp_subtract = 333
local key_kp_add = 334
local key_kp_enter = 335
local key_kp_equal = 336
local key_back = 4
local key_menu = 5
local key_volume_up = 24
local key_volume_down = 25
local mouse_button_left = 0
local mouse_button_right = 1
local mouse_button_middle = 2
local mouse_button_side = 3
local mouse_button_extra = 4
local mouse_button_forward = 5
local mouse_button_back = 6
local mouse_cursor_default = 0
local mouse_cursor_arrow = 1
local mouse_cursor_ibeam = 2
local mouse_cursor_crosshair = 3
local mouse_cursor_pointing_hand = 4
local mouse_cursor_resize_ew = 5
local mouse_cursor_resize_ns = 6
local mouse_cursor_resize_nwse = 7
local mouse_cursor_resize_nesw = 8
local mouse_cursor_resize_all = 9
local mouse_cursor_not_allowed = 10
local gamepad_button_unknown = 0
local gamepad_button_left_face_up = 1
local gamepad_button_left_face_right = 2
local gamepad_button_left_face_down = 3
local gamepad_button_left_face_left = 4
local gamepad_button_right_face_up = 5
local gamepad_button_right_face_right = 6
local gamepad_button_right_face_down = 7
local gamepad_button_right_face_left = 8
local gamepad_button_left_trigger_1 = 9
local gamepad_button_left_trigger_2 = 10
local gamepad_button_right_trigger_1 = 11
local gamepad_button_right_trigger_2 = 12
local gamepad_button_middle_left = 13
local gamepad_button_middle = 14
local gamepad_button_middle_right = 15
local gamepad_button_left_thumb = 16
local gamepad_button_right_thumb = 17
local gamepad_axis_left_x = 0
local gamepad_axis_left_y = 1
local gamepad_axis_right_x = 2
local gamepad_axis_right_y = 3
local gamepad_axis_left_trigger = 4
local gamepad_axis_right_trigger = 5
local material_map_albedo = 0
local material_map_metalness = 1
local material_map_normal = 2
local material_map_roughness = 3
local material_map_occlusion = 4
local material_map_emission = 5
local material_map_height = 6
local material_map_cubemap = 7
local material_map_irradiance = 8
local material_map_prefilter = 9
local material_map_brdf = 10
local shader_loc_vertex_position = 0
local shader_loc_vertex_texcoord01 = 1
local shader_loc_vertex_texcoord02 = 2
local shader_loc_vertex_normal = 3
local shader_loc_vertex_tangent = 4
local shader_loc_vertex_color = 5
local shader_loc_matrix_mvp = 6
local shader_loc_matrix_view = 7
local shader_loc_matrix_projection = 8
local shader_loc_matrix_model = 9
local shader_loc_matrix_normal = 10
local shader_loc_vector_view = 11
local shader_loc_color_diffuse = 12
local shader_loc_color_specular = 13
local shader_loc_color_ambient = 14
local shader_loc_map_albedo = 15
local shader_loc_map_metalness = 16
local shader_loc_map_normal = 17
local shader_loc_map_roughness = 18
local shader_loc_map_occlusion = 19
local shader_loc_map_emission = 20
local shader_loc_map_height = 21
local shader_loc_map_cubemap = 22
local shader_loc_map_irradiance = 23
local shader_loc_map_prefilter = 24
local shader_loc_map_brdf = 25
local shader_loc_vertex_boneids = 26
local shader_loc_vertex_boneweights = 27
local shader_loc_bone_matrices = 28
local shader_uniform_float = 0
local shader_uniform_vec2 = 1
local shader_uniform_vec3 = 2
local shader_uniform_vec4 = 3
local shader_uniform_int = 4
local shader_uniform_ivec2 = 5
local shader_uniform_ivec3 = 6
local shader_uniform_ivec4 = 7
local shader_uniform_sampler2d = 8
local shader_attrib_float = 0
local shader_attrib_vec2 = 1
local shader_attrib_vec3 = 2
local shader_attrib_vec4 = 3
local pixelformat_uncompressed_grayscale = 1
local pixelformat_uncompressed_gray_alpha = 2
local pixelformat_uncompressed_r5g6b5 = 3
local pixelformat_uncompressed_r8g8b8 = 4
local pixelformat_uncompressed_r5g5b5a1 = 5
local pixelformat_uncompressed_r4g4b4a4 = 6
local pixelformat_uncompressed_r8g8b8a8 = 7
local pixelformat_uncompressed_r32 = 8
local pixelformat_uncompressed_r32g32b32 = 9
local pixelformat_uncompressed_r32g32b32a32 = 10
local pixelformat_uncompressed_r16 = 11
local pixelformat_uncompressed_r16g16b16 = 12
local pixelformat_uncompressed_r16g16b16a16 = 13
local pixelformat_compressed_dxt1_rgb = 14
local pixelformat_compressed_dxt1_rgba = 15
local pixelformat_compressed_dxt3_rgba = 16
local pixelformat_compressed_dxt5_rgba = 17
local pixelformat_compressed_etc1_rgb = 18
local pixelformat_compressed_etc2_rgb = 19
local pixelformat_compressed_etc2_eac_rgba = 20
local pixelformat_compressed_pvrt_rgb = 21
local pixelformat_compressed_pvrt_rgba = 22
local pixelformat_compressed_astc_4x4_rgba = 23
local pixelformat_compressed_astc_8x8_rgba = 24
local texture_filter_point = 0
local texture_filter_bilinear = 1
local texture_filter_trilinear = 2
local texture_filter_anisotropic_4x = 3
local texture_filter_anisotropic_8x = 4
local texture_filter_anisotropic_16x = 5
local texture_wrap_repeat = 0
local texture_wrap_clamp = 1
local texture_wrap_mirror_repeat = 2
local texture_wrap_mirror_clamp = 3
local cubemap_layout_auto_detect = 0
local cubemap_layout_line_vertical = 1
local cubemap_layout_line_horizontal = 2
local cubemap_layout_cross_three_by_four = 3
local cubemap_layout_cross_four_by_three = 4
local font_default = 0
local font_bitmap = 1
local font_sdf = 2
local blend_alpha = 0
local blend_additive = 1
local blend_multiplied = 2
local blend_add_colors = 3
local blend_subtract_colors = 4
local blend_alpha_premultiply = 5
local blend_custom = 6
local blend_custom_separate = 7
local gesture_none = 0
local gesture_tap = 1
local gesture_doubletap = 2
local gesture_hold = 4
local gesture_drag = 8
local gesture_swipe_right = 16
local gesture_swipe_left = 32
local gesture_swipe_up = 64
local gesture_swipe_down = 128
local gesture_pinch_in = 256
local gesture_pinch_out = 512
local camera_custom = 0
local camera_free = 1
local camera_orbital = 2
local camera_first_person = 3
local camera_third_person = 4
local camera_perspective = 0
local camera_orthographic = 1
local npatch_nine_patch = 0
local npatch_three_patch_vertical = 1
local npatch_three_patch_horizontal = 2
local function init_window(width, height, title)
  return rl.InitWindow(width, height, title)
end
local function close_window()
  return rl.CloseWindow()
end
local function window_should_close()
  return rl.WindowShouldClose()
end
local function is_window_ready()
  return rl.IsWindowReady()
end
local function is_window_fullscreen()
  return rl.IsWindowFullscreen()
end
local function is_window_hidden()
  return rl.IsWindowHidden()
end
local function is_window_minimized()
  return rl.IsWindowMinimized()
end
local function is_window_maximized()
  return rl.IsWindowMaximized()
end
local function is_window_focused()
  return rl.IsWindowFocused()
end
local function is_window_resized()
  return rl.IsWindowResized()
end
local function is_window_state(flag)
  return rl.IsWindowState(flag)
end
local function set_window_state(flags)
  return rl.SetWindowState(flags)
end
local function clear_window_state(flags)
  return rl.ClearWindowState(flags)
end
local function toggle_fullscreen()
  return rl.ToggleFullscreen()
end
local function toggle_borderless_windowed()
  return rl.ToggleBorderlessWindowed()
end
local function maximize_window()
  return rl.MaximizeWindow()
end
local function minimize_window()
  return rl.MinimizeWindow()
end
local function restore_window()
  return rl.RestoreWindow()
end
local function set_window_icon(image)
  return rl.SetWindowIcon(image)
end
local function set_window_icons(images, count)
  return rl.SetWindowIcons(images, count)
end
local function set_window_title(title)
  return rl.SetWindowTitle(title)
end
local function set_window_position(x, y)
  return rl.SetWindowPosition(x, y)
end
local function set_window_monitor(monitor)
  return rl.SetWindowMonitor(monitor)
end
local function set_window_min_size(width, height)
  return rl.SetWindowMinSize(width, height)
end
local function set_window_max_size(width, height)
  return rl.SetWindowMaxSize(width, height)
end
local function set_window_size(width, height)
  return rl.SetWindowSize(width, height)
end
local function set_window_opacity(opacity)
  return rl.SetWindowOpacity(opacity)
end
local function set_window_focused()
  return rl.SetWindowFocused()
end
local function get_window_handle()
  return rl.GetWindowHandle()
end
local function get_screen_width()
  return rl.GetScreenWidth()
end
local function get_screen_height()
  return rl.GetScreenHeight()
end
local function get_render_width()
  return rl.GetRenderWidth()
end
local function get_render_height()
  return rl.GetRenderHeight()
end
local function get_monitor_count()
  return rl.GetMonitorCount()
end
local function get_current_monitor()
  return rl.GetCurrentMonitor()
end
local function get_monitor_position(monitor)
  return rl.GetMonitorPosition(monitor)
end
local function get_monitor_width(monitor)
  return rl.GetMonitorWidth(monitor)
end
local function get_monitor_height(monitor)
  return rl.GetMonitorHeight(monitor)
end
local function get_monitor_physical_width(monitor)
  return rl.GetMonitorPhysicalWidth(monitor)
end
local function get_monitor_physical_height(monitor)
  return rl.GetMonitorPhysicalHeight(monitor)
end
local function get_monitor_refresh_rate(monitor)
  return rl.GetMonitorRefreshRate(monitor)
end
local function get_window_position()
  return rl.GetWindowPosition()
end
local function get_window_scale_dpi()
  return rl.GetWindowScaleDPI()
end
local function get_monitor_name(monitor)
  return rl.GetMonitorName(monitor)
end
local function set_clipboard_text(text)
  return rl.SetClipboardText(text)
end
local function get_clipboard_text()
  return rl.GetClipboardText()
end
local function get_clipboard_image()
  return rl.GetClipboardImage()
end
local function enable_event_waiting()
  return rl.EnableEventWaiting()
end
local function disable_event_waiting()
  return rl.DisableEventWaiting()
end
local function show_cursor()
  return rl.ShowCursor()
end
local function hide_cursor()
  return rl.HideCursor()
end
local function is_cursor_hidden()
  return rl.IsCursorHidden()
end
local function enable_cursor()
  return rl.EnableCursor()
end
local function disable_cursor()
  return rl.DisableCursor()
end
local function is_cursor_on_screen()
  return rl.IsCursorOnScreen()
end
local function clear_background(color)
  return rl.ClearBackground(color)
end
local function begin_drawing()
  return rl.BeginDrawing()
end
local function end_drawing()
  return rl.EndDrawing()
end
local function begin_mode2d(camera)
  return rl.BeginMode2D(camera)
end
local function end_mode2d()
  return rl.EndMode2D()
end
local function begin_mode3d(camera)
  return rl.BeginMode3D(camera)
end
local function end_mode3d()
  return rl.EndMode3D()
end
local function begin_texture_mode(target)
  return rl.BeginTextureMode(target)
end
local function end_texture_mode()
  return rl.EndTextureMode()
end
local function begin_shader_mode(shader)
  return rl.BeginShaderMode(shader)
end
local function end_shader_mode()
  return rl.EndShaderMode()
end
local function begin_blend_mode(mode)
  return rl.BeginBlendMode(mode)
end
local function end_blend_mode()
  return rl.EndBlendMode()
end
local function begin_scissor_mode(x, y, width, height)
  return rl.BeginScissorMode(x, y, width, height)
end
local function end_scissor_mode()
  return rl.EndScissorMode()
end
local function begin_vr_stereo_mode(config)
  return rl.BeginVrStereoMode(config)
end
local function end_vr_stereo_mode()
  return rl.EndVrStereoMode()
end
local function load_vr_stereo_config(device)
  return rl.LoadVrStereoConfig(device)
end
local function unload_vr_stereo_config(config)
  return rl.UnloadVrStereoConfig(config)
end
local function load_shader(vs_file_name, fs_file_name)
  return rl.LoadShader(vs_file_name, fs_file_name)
end
local function load_shader_from_memory(vs_code, fs_code)
  return rl.LoadShaderFromMemory(vs_code, fs_code)
end
local function is_shader_valid(shader)
  return rl.IsShaderValid(shader)
end
local function get_shader_location(shader, uniform_name)
  return rl.GetShaderLocation(shader, uniform_name)
end
local function get_shader_location_attrib(shader, attrib_name)
  return rl.GetShaderLocationAttrib(shader, attrib_name)
end
local function set_shader_value(shader, loc_index, value, uniform_type)
  return rl.SetShaderValue(shader, loc_index, value, uniform_type)
end
local function set_shader_value_v(shader, loc_index, value, uniform_type, count)
  return rl.SetShaderValueV(shader, loc_index, value, uniform_type, count)
end
local function set_shader_value_matrix(shader, loc_index, mat)
  return rl.SetShaderValueMatrix(shader, loc_index, mat)
end
local function set_shader_value_texture(shader, loc_index, texture)
  return rl.SetShaderValueTexture(shader, loc_index, texture)
end
local function unload_shader(shader)
  return rl.UnloadShader(shader)
end
local function get_screen_to_world_ray(position, camera)
  return rl.GetScreenToWorldRay(position, camera)
end
local function get_screen_to_world_ray_ex(position, camera, width, height)
  return rl.GetScreenToWorldRayEx(position, camera, width, height)
end
local function get_world_to_screen(position, camera)
  return rl.GetWorldToScreen(position, camera)
end
local function get_world_to_screen_ex(position, camera, width, height)
  return rl.GetWorldToScreenEx(position, camera, width, height)
end
local function get_world_to_screen2d(position, camera)
  return rl.GetWorldToScreen2D(position, camera)
end
local function get_screen_to_world2d(position, camera)
  return rl.GetScreenToWorld2D(position, camera)
end
local function get_camera_matrix(camera)
  return rl.GetCameraMatrix(camera)
end
local function get_camera_matrix2d(camera)
  return rl.GetCameraMatrix2D(camera)
end
local function set_target_fps(fps)
  return rl.SetTargetFPS(fps)
end
local function get_frame_time()
  return rl.GetFrameTime()
end
local function get_time()
  return rl.GetTime()
end
local function get_fps()
  return rl.GetFPS()
end
local function swap_screen_buffer()
  return rl.SwapScreenBuffer()
end
local function poll_input_events()
  return rl.PollInputEvents()
end
local function wait_time(seconds)
  return rl.WaitTime(seconds)
end
local function set_random_seed(seed)
  return rl.SetRandomSeed(seed)
end
local function get_random_value(min, max)
  return rl.GetRandomValue(min, max)
end
local function load_random_sequence(count, min, max)
  return rl.LoadRandomSequence(count, min, max)
end
local function unload_random_sequence(sequence)
  return rl.UnloadRandomSequence(sequence)
end
local function take_screenshot(file_name)
  return rl.TakeScreenshot(file_name)
end
local function set_config_flags(flags)
  return rl.SetConfigFlags(flags)
end
local function open_url(url)
  return rl.OpenURL(url)
end
local function trace_log(log_level, text)
  return rl.TraceLog(log_level, text)
end
local function set_trace_log_level(log_level)
  return rl.SetTraceLogLevel(log_level)
end
local function mem_alloc(size)
  return rl.MemAlloc(size)
end
local function mem_realloc(ptr, size)
  return rl.MemRealloc(ptr, size)
end
local function mem_free(ptr)
  return rl.MemFree(ptr)
end
local function set_trace_log_callback(callback)
  return rl.SetTraceLogCallback(callback)
end
local function set_load_file_data_callback(callback)
  return rl.SetLoadFileDataCallback(callback)
end
local function set_save_file_data_callback(callback)
  return rl.SetSaveFileDataCallback(callback)
end
local function set_load_file_text_callback(callback)
  return rl.SetLoadFileTextCallback(callback)
end
local function set_save_file_text_callback(callback)
  return rl.SetSaveFileTextCallback(callback)
end
local function load_file_data(file_name, data_size)
  return rl.LoadFileData(file_name, data_size)
end
local function unload_file_data(data)
  return rl.UnloadFileData(data)
end
local function save_file_data(file_name, data, data_size)
  return rl.SaveFileData(file_name, data, data_size)
end
local function export_data_as_code(data, data_size, file_name)
  return rl.ExportDataAsCode(data, data_size, file_name)
end
local function load_file_text(file_name)
  return rl.LoadFileText(file_name)
end
local function unload_file_text(text)
  return rl.UnloadFileText(text)
end
local function save_file_text(file_name, text)
  return rl.SaveFileText(file_name, text)
end
local function file_exists(file_name)
  return rl.FileExists(file_name)
end
local function directory_exists(dir_path)
  return rl.DirectoryExists(dir_path)
end
local function is_file_extension(file_name, ext)
  return rl.IsFileExtension(file_name, ext)
end
local function get_file_length(file_name)
  return rl.GetFileLength(file_name)
end
local function get_file_extension(file_name)
  return rl.GetFileExtension(file_name)
end
local function get_file_name(file_path)
  return rl.GetFileName(file_path)
end
local function get_file_name_without_ext(file_path)
  return rl.GetFileNameWithoutExt(file_path)
end
local function get_directory_path(file_path)
  return rl.GetDirectoryPath(file_path)
end
local function get_prev_directory_path(dir_path)
  return rl.GetPrevDirectoryPath(dir_path)
end
local function get_working_directory()
  return rl.GetWorkingDirectory()
end
local function get_application_directory()
  return rl.GetApplicationDirectory()
end
local function make_directory(dir_path)
  return rl.MakeDirectory(dir_path)
end
local function change_directory(dir)
  return rl.ChangeDirectory(dir)
end
local function is_path_file(path)
  return rl.IsPathFile(path)
end
local function is_file_name_valid(file_name)
  return rl.IsFileNameValid(file_name)
end
local function load_directory_files(dir_path)
  return rl.LoadDirectoryFiles(dir_path)
end
local function load_directory_files_ex(base_path, filter, scan_subdirs)
  return rl.LoadDirectoryFilesEx(base_path, filter, scan_subdirs)
end
local function unload_directory_files(files)
  return rl.UnloadDirectoryFiles(files)
end
local function is_file_dropped()
  return rl.IsFileDropped()
end
local function load_dropped_files()
  return rl.LoadDroppedFiles()
end
local function unload_dropped_files(files)
  return rl.UnloadDroppedFiles(files)
end
local function get_file_mod_time(file_name)
  return rl.GetFileModTime(file_name)
end
local function compress_data(data, data_size, comp_data_size)
  return rl.CompressData(data, data_size, comp_data_size)
end
local function decompress_data(comp_data, comp_data_size, data_size)
  return rl.DecompressData(comp_data, comp_data_size, data_size)
end
local function encode_data_base64(data, data_size, output_size)
  return rl.EncodeDataBase64(data, data_size, output_size)
end
local function decode_data_base64(data, output_size)
  return rl.DecodeDataBase64(data, output_size)
end
local function compute_crc32(data, data_size)
  return rl.ComputeCRC32(data, data_size)
end
local function compute_md5(data, data_size)
  return rl.ComputeMD5(data, data_size)
end
local function compute_sha1(data, data_size)
  return rl.ComputeSHA1(data, data_size)
end
local function load_automation_event_list(file_name)
  return rl.LoadAutomationEventList(file_name)
end
local function unload_automation_event_list(list)
  return rl.UnloadAutomationEventList(list)
end
local function export_automation_event_list(list, file_name)
  return rl.ExportAutomationEventList(list, file_name)
end
local function set_automation_event_list(list)
  return rl.SetAutomationEventList(list)
end
local function set_automation_event_base_frame(frame)
  return rl.SetAutomationEventBaseFrame(frame)
end
local function start_automation_event_recording()
  return rl.StartAutomationEventRecording()
end
local function stop_automation_event_recording()
  return rl.StopAutomationEventRecording()
end
local function play_automation_event(event)
  return rl.PlayAutomationEvent(event)
end
local function is_key_pressed(key)
  return rl.IsKeyPressed(key)
end
local function is_key_pressed_repeat(key)
  return rl.IsKeyPressedRepeat(key)
end
local function is_key_down(key)
  return rl.IsKeyDown(key)
end
local function is_key_released(key)
  return rl.IsKeyReleased(key)
end
local function is_key_up(key)
  return rl.IsKeyUp(key)
end
local function get_key_pressed()
  return rl.GetKeyPressed()
end
local function get_char_pressed()
  return rl.GetCharPressed()
end
local function set_exit_key(key)
  return rl.SetExitKey(key)
end
local function is_gamepad_available(gamepad)
  return rl.IsGamepadAvailable(gamepad)
end
local function get_gamepad_name(gamepad)
  return rl.GetGamepadName(gamepad)
end
local function is_gamepad_button_pressed(gamepad, button)
  return rl.IsGamepadButtonPressed(gamepad, button)
end
local function is_gamepad_button_down(gamepad, button)
  return rl.IsGamepadButtonDown(gamepad, button)
end
local function is_gamepad_button_released(gamepad, button)
  return rl.IsGamepadButtonReleased(gamepad, button)
end
local function is_gamepad_button_up(gamepad, button)
  return rl.IsGamepadButtonUp(gamepad, button)
end
local function get_gamepad_button_pressed()
  return rl.GetGamepadButtonPressed()
end
local function get_gamepad_axis_count(gamepad)
  return rl.GetGamepadAxisCount(gamepad)
end
local function get_gamepad_axis_movement(gamepad, axis)
  return rl.GetGamepadAxisMovement(gamepad, axis)
end
local function set_gamepad_mappings(mappings)
  return rl.SetGamepadMappings(mappings)
end
local function set_gamepad_vibration(gamepad, left_motor, right_motor, duration)
  return rl.SetGamepadVibration(gamepad, left_motor, right_motor, duration)
end
local function is_mouse_button_pressed(button)
  return rl.IsMouseButtonPressed(button)
end
local function is_mouse_button_down(button)
  return rl.IsMouseButtonDown(button)
end
local function is_mouse_button_released(button)
  return rl.IsMouseButtonReleased(button)
end
local function is_mouse_button_up(button)
  return rl.IsMouseButtonUp(button)
end
local function get_mouse_x()
  return rl.GetMouseX()
end
local function get_mouse_y()
  return rl.GetMouseY()
end
local function get_mouse_position()
  return rl.GetMousePosition()
end
local function get_mouse_delta()
  return rl.GetMouseDelta()
end
local function set_mouse_position(x, y)
  return rl.SetMousePosition(x, y)
end
local function set_mouse_offset(offset_x, offset_y)
  return rl.SetMouseOffset(offset_x, offset_y)
end
local function set_mouse_scale(scale_x, scale_y)
  return rl.SetMouseScale(scale_x, scale_y)
end
local function get_mouse_wheel_move()
  return rl.GetMouseWheelMove()
end
local function get_mouse_wheel_move_v()
  return rl.GetMouseWheelMoveV()
end
local function set_mouse_cursor(cursor)
  return rl.SetMouseCursor(cursor)
end
local function get_touch_x()
  return rl.GetTouchX()
end
local function get_touch_y()
  return rl.GetTouchY()
end
local function get_touch_position(index)
  return rl.GetTouchPosition(index)
end
local function get_touch_point_id(index)
  return rl.GetTouchPointId(index)
end
local function get_touch_point_count()
  return rl.GetTouchPointCount()
end
local function set_gestures_enabled(flags)
  return rl.SetGesturesEnabled(flags)
end
local function is_gesture_detected(gesture)
  return rl.IsGestureDetected(gesture)
end
local function get_gesture_detected()
  return rl.GetGestureDetected()
end
local function get_gesture_hold_duration()
  return rl.GetGestureHoldDuration()
end
local function get_gesture_drag_vector()
  return rl.GetGestureDragVector()
end
local function get_gesture_drag_angle()
  return rl.GetGestureDragAngle()
end
local function get_gesture_pinch_vector()
  return rl.GetGesturePinchVector()
end
local function get_gesture_pinch_angle()
  return rl.GetGesturePinchAngle()
end
local function update_camera(camera, mode)
  return rl.UpdateCamera(camera, mode)
end
local function update_camera_pro(camera, movement, rotation, zoom)
  return rl.UpdateCameraPro(camera, movement, rotation, zoom)
end
local function set_shapes_texture(texture, source)
  return rl.SetShapesTexture(texture, source)
end
local function get_shapes_texture()
  return rl.GetShapesTexture()
end
local function get_shapes_texture_rectangle()
  return rl.GetShapesTextureRectangle()
end
local function draw_pixel(pos_x, pos_y, color)
  return rl.DrawPixel(pos_x, pos_y, color)
end
local function draw_pixel_v(position, color)
  return rl.DrawPixelV(position, color)
end
local function draw_line(start_pos_x, start_pos_y, end_pos_x, end_pos_y, color)
  return rl.DrawLine(start_pos_x, start_pos_y, end_pos_x, end_pos_y, color)
end
local function draw_line_v(start_pos, end_pos, color)
  return rl.DrawLineV(start_pos, end_pos, color)
end
local function draw_line_ex(start_pos, end_pos, thick, color)
  return rl.DrawLineEx(start_pos, end_pos, thick, color)
end
local function draw_line_strip(points, point_count, color)
  return rl.DrawLineStrip(points, point_count, color)
end
local function draw_line_bezier(start_pos, end_pos, thick, color)
  return rl.DrawLineBezier(start_pos, end_pos, thick, color)
end
local function draw_circle(center_x, center_y, radius, color)
  return rl.DrawCircle(center_x, center_y, radius, color)
end
local function draw_circle_sector(center, radius, start_angle, end_angle, segments, color)
  return rl.DrawCircleSector(center, radius, start_angle, end_angle, segments, color)
end
local function draw_circle_sector_lines(center, radius, start_angle, end_angle, segments, color)
  return rl.DrawCircleSectorLines(center, radius, start_angle, end_angle, segments, color)
end
local function draw_circle_gradient(center_x, center_y, radius, inner, outer)
  return rl.DrawCircleGradient(center_x, center_y, radius, inner, outer)
end
local function draw_circle_v(center, radius, color)
  return rl.DrawCircleV(center, radius, color)
end
local function draw_circle_lines(center_x, center_y, radius, color)
  return rl.DrawCircleLines(center_x, center_y, radius, color)
end
local function draw_circle_lines_v(center, radius, color)
  return rl.DrawCircleLinesV(center, radius, color)
end
local function draw_ellipse(center_x, center_y, radius_h, radius_v, color)
  return rl.DrawEllipse(center_x, center_y, radius_h, radius_v, color)
end
local function draw_ellipse_lines(center_x, center_y, radius_h, radius_v, color)
  return rl.DrawEllipseLines(center_x, center_y, radius_h, radius_v, color)
end
local function draw_ring(center, inner_radius, outer_radius, start_angle, end_angle, segments, color)
  return rl.DrawRing(center, inner_radius, outer_radius, start_angle, end_angle, segments, color)
end
local function draw_ring_lines(center, inner_radius, outer_radius, start_angle, end_angle, segments, color)
  return rl.DrawRingLines(center, inner_radius, outer_radius, start_angle, end_angle, segments, color)
end
local function draw_rectangle(pos_x, pos_y, width, height, color)
  return rl.DrawRectangle(pos_x, pos_y, width, height, color)
end
local function draw_rectangle_v(position, size, color)
  return rl.DrawRectangleV(position, size, color)
end
local function draw_rectangle_rec(rec, color)
  return rl.DrawRectangleRec(rec, color)
end
local function draw_rectangle_pro(rec, origin, rotation, color)
  return rl.DrawRectanglePro(rec, origin, rotation, color)
end
local function draw_rectangle_gradient_v(pos_x, pos_y, width, height, top, bottom)
  return rl.DrawRectangleGradientV(pos_x, pos_y, width, height, top, bottom)
end
local function draw_rectangle_gradient_h(pos_x, pos_y, width, height, left, right)
  return rl.DrawRectangleGradientH(pos_x, pos_y, width, height, left, right)
end
local function draw_rectangle_gradient_ex(rec, top_left, bottom_left, top_right, bottom_right)
  return rl.DrawRectangleGradientEx(rec, top_left, bottom_left, top_right, bottom_right)
end
local function draw_rectangle_lines(pos_x, pos_y, width, height, color)
  return rl.DrawRectangleLines(pos_x, pos_y, width, height, color)
end
local function draw_rectangle_lines_ex(rec, line_thick, color)
  return rl.DrawRectangleLinesEx(rec, line_thick, color)
end
local function draw_rectangle_rounded(rec, roundness, segments, color)
  return rl.DrawRectangleRounded(rec, roundness, segments, color)
end
local function draw_rectangle_rounded_lines(rec, roundness, segments, color)
  return rl.DrawRectangleRoundedLines(rec, roundness, segments, color)
end
local function draw_rectangle_rounded_lines_ex(rec, roundness, segments, line_thick, color)
  return rl.DrawRectangleRoundedLinesEx(rec, roundness, segments, line_thick, color)
end
local function draw_triangle(v1, v2, v3, color)
  return rl.DrawTriangle(v1, v2, v3, color)
end
local function draw_triangle_lines(v1, v2, v3, color)
  return rl.DrawTriangleLines(v1, v2, v3, color)
end
local function draw_triangle_fan(points, point_count, color)
  return rl.DrawTriangleFan(points, point_count, color)
end
local function draw_triangle_strip(points, point_count, color)
  return rl.DrawTriangleStrip(points, point_count, color)
end
local function draw_poly(center, sides, radius, rotation, color)
  return rl.DrawPoly(center, sides, radius, rotation, color)
end
local function draw_poly_lines(center, sides, radius, rotation, color)
  return rl.DrawPolyLines(center, sides, radius, rotation, color)
end
local function draw_poly_lines_ex(center, sides, radius, rotation, line_thick, color)
  return rl.DrawPolyLinesEx(center, sides, radius, rotation, line_thick, color)
end
local function draw_spline_linear(points, point_count, thick, color)
  return rl.DrawSplineLinear(points, point_count, thick, color)
end
local function draw_spline_basis(points, point_count, thick, color)
  return rl.DrawSplineBasis(points, point_count, thick, color)
end
local function draw_spline_catmull_rom(points, point_count, thick, color)
  return rl.DrawSplineCatmullRom(points, point_count, thick, color)
end
local function draw_spline_bezier_quadratic(points, point_count, thick, color)
  return rl.DrawSplineBezierQuadratic(points, point_count, thick, color)
end
local function draw_spline_bezier_cubic(points, point_count, thick, color)
  return rl.DrawSplineBezierCubic(points, point_count, thick, color)
end
local function draw_spline_segment_linear(p1, p2, thick, color)
  return rl.DrawSplineSegmentLinear(p1, p2, thick, color)
end
local function draw_spline_segment_basis(p1, p2, p3, p4, thick, color)
  return rl.DrawSplineSegmentBasis(p1, p2, p3, p4, thick, color)
end
local function draw_spline_segment_catmull_rom(p1, p2, p3, p4, thick, color)
  return rl.DrawSplineSegmentCatmullRom(p1, p2, p3, p4, thick, color)
end
local function draw_spline_segment_bezier_quadratic(p1, c2, p3, thick, color)
  return rl.DrawSplineSegmentBezierQuadratic(p1, c2, p3, thick, color)
end
local function draw_spline_segment_bezier_cubic(p1, c2, c3, p4, thick, color)
  return rl.DrawSplineSegmentBezierCubic(p1, c2, c3, p4, thick, color)
end
local function get_spline_point_linear(start_pos, end_pos, t)
  return rl.GetSplinePointLinear(start_pos, end_pos, t)
end
local function get_spline_point_basis(p1, p2, p3, p4, t)
  return rl.GetSplinePointBasis(p1, p2, p3, p4, t)
end
local function get_spline_point_catmull_rom(p1, p2, p3, p4, t)
  return rl.GetSplinePointCatmullRom(p1, p2, p3, p4, t)
end
local function get_spline_point_bezier_quad(p1, c2, p3, t)
  return rl.GetSplinePointBezierQuad(p1, c2, p3, t)
end
local function get_spline_point_bezier_cubic(p1, c2, c3, p4, t)
  return rl.GetSplinePointBezierCubic(p1, c2, c3, p4, t)
end
local function check_collision_recs(rec1, rec2)
  return rl.CheckCollisionRecs(rec1, rec2)
end
local function check_collision_circles(center1, radius1, center2, radius2)
  return rl.CheckCollisionCircles(center1, radius1, center2, radius2)
end
local function check_collision_circle_rec(center, radius, rec)
  return rl.CheckCollisionCircleRec(center, radius, rec)
end
local function check_collision_circle_line(center, radius, p1, p2)
  return rl.CheckCollisionCircleLine(center, radius, p1, p2)
end
local function check_collision_point_rec(point, rec)
  return rl.CheckCollisionPointRec(point, rec)
end
local function check_collision_point_circle(point, center, radius)
  return rl.CheckCollisionPointCircle(point, center, radius)
end
local function check_collision_point_triangle(point, p1, p2, p3)
  return rl.CheckCollisionPointTriangle(point, p1, p2, p3)
end
local function check_collision_point_line(point, p1, p2, threshold)
  return rl.CheckCollisionPointLine(point, p1, p2, threshold)
end
local function check_collision_point_poly(point, points, point_count)
  return rl.CheckCollisionPointPoly(point, points, point_count)
end
local function check_collision_lines(start_pos1, end_pos1, start_pos2, end_pos2, collision_point)
  return rl.CheckCollisionLines(start_pos1, end_pos1, start_pos2, end_pos2, collision_point)
end
local function get_collision_rec(rec1, rec2)
  return rl.GetCollisionRec(rec1, rec2)
end
local function load_image(file_name)
  return rl.LoadImage(file_name)
end
local function load_image_raw(file_name, width, height, format, header_size)
  return rl.LoadImageRaw(file_name, width, height, format, header_size)
end
local function load_image_anim(file_name, frames)
  return rl.LoadImageAnim(file_name, frames)
end
local function load_image_anim_from_memory(file_type, file_data, data_size, frames)
  return rl.LoadImageAnimFromMemory(file_type, file_data, data_size, frames)
end
local function load_image_from_memory(file_type, file_data, data_size)
  return rl.LoadImageFromMemory(file_type, file_data, data_size)
end
local function load_image_from_texture(texture)
  return rl.LoadImageFromTexture(texture)
end
local function load_image_from_screen()
  return rl.LoadImageFromScreen()
end
local function is_image_valid(image)
  return rl.IsImageValid(image)
end
local function unload_image(image)
  return rl.UnloadImage(image)
end
local function export_image(image, file_name)
  return rl.ExportImage(image, file_name)
end
local function export_image_to_memory(image, file_type, file_size)
  return rl.ExportImageToMemory(image, file_type, file_size)
end
local function export_image_as_code(image, file_name)
  return rl.ExportImageAsCode(image, file_name)
end
local function gen_image_color(width, height, color)
  return rl.GenImageColor(width, height, color)
end
local function gen_image_gradient_linear(width, height, direction, start, _end)
  return rl.GenImageGradientLinear(width, height, direction, start, _end)
end
local function gen_image_gradient_radial(width, height, density, inner, outer)
  return rl.GenImageGradientRadial(width, height, density, inner, outer)
end
local function gen_image_gradient_square(width, height, density, inner, outer)
  return rl.GenImageGradientSquare(width, height, density, inner, outer)
end
local function gen_image_checked(width, height, checks_x, checks_y, col1, col2)
  return rl.GenImageChecked(width, height, checks_x, checks_y, col1, col2)
end
local function gen_image_white_noise(width, height, factor)
  return rl.GenImageWhiteNoise(width, height, factor)
end
local function gen_image_perlin_noise(width, height, offset_x, offset_y, scale)
  return rl.GenImagePerlinNoise(width, height, offset_x, offset_y, scale)
end
local function gen_image_cellular(width, height, tile_size)
  return rl.GenImageCellular(width, height, tile_size)
end
local function gen_image_text(width, height, text)
  return rl.GenImageText(width, height, text)
end
local function image_copy(image)
  return rl.ImageCopy(image)
end
local function image_from_image(image, rec)
  return rl.ImageFromImage(image, rec)
end
local function image_from_channel(image, selected_channel)
  return rl.ImageFromChannel(image, selected_channel)
end
local function image_text(text, font_size, color)
  return rl.ImageText(text, font_size, color)
end
local function image_text_ex(font, text, font_size, spacing, tint)
  return rl.ImageTextEx(font, text, font_size, spacing, tint)
end
local function image_format(image, new_format)
  return rl.ImageFormat(image, new_format)
end
local function image_to_pot(image, fill)
  return rl.ImageToPOT(image, fill)
end
local function image_crop(image, crop)
  return rl.ImageCrop(image, crop)
end
local function image_alpha_crop(image, threshold)
  return rl.ImageAlphaCrop(image, threshold)
end
local function image_alpha_clear(image, color, threshold)
  return rl.ImageAlphaClear(image, color, threshold)
end
local function image_alpha_mask(image, alpha_mask)
  return rl.ImageAlphaMask(image, alpha_mask)
end
local function image_alpha_premultiply(image)
  return rl.ImageAlphaPremultiply(image)
end
local function image_blur_gaussian(image, blur_size)
  return rl.ImageBlurGaussian(image, blur_size)
end
local function image_kernel_convolution(image, kernel, kernel_size)
  return rl.ImageKernelConvolution(image, kernel, kernel_size)
end
local function image_resize(image, new_width, new_height)
  return rl.ImageResize(image, new_width, new_height)
end
local function image_resize_nn(image, new_width, new_height)
  return rl.ImageResizeNN(image, new_width, new_height)
end
local function image_resize_canvas(image, new_width, new_height, offset_x, offset_y, fill)
  return rl.ImageResizeCanvas(image, new_width, new_height, offset_x, offset_y, fill)
end
local function image_mipmaps(image)
  return rl.ImageMipmaps(image)
end
local function image_dither(image, r_bpp, g_bpp, b_bpp, a_bpp)
  return rl.ImageDither(image, r_bpp, g_bpp, b_bpp, a_bpp)
end
local function image_flip_vertical(image)
  return rl.ImageFlipVertical(image)
end
local function image_flip_horizontal(image)
  return rl.ImageFlipHorizontal(image)
end
local function image_rotate(image, degrees)
  return rl.ImageRotate(image, degrees)
end
local function image_rotate_cw(image)
  return rl.ImageRotateCW(image)
end
local function image_rotate_ccw(image)
  return rl.ImageRotateCCW(image)
end
local function image_color_tint(image, color)
  return rl.ImageColorTint(image, color)
end
local function image_color_invert(image)
  return rl.ImageColorInvert(image)
end
local function image_color_grayscale(image)
  return rl.ImageColorGrayscale(image)
end
local function image_color_contrast(image, contrast)
  return rl.ImageColorContrast(image, contrast)
end
local function image_color_brightness(image, brightness)
  return rl.ImageColorBrightness(image, brightness)
end
local function image_color_replace(image, color, replace)
  return rl.ImageColorReplace(image, color, replace)
end
local function load_image_colors(image)
  return rl.LoadImageColors(image)
end
local function load_image_palette(image, max_palette_size, color_count)
  return rl.LoadImagePalette(image, max_palette_size, color_count)
end
local function unload_image_colors(colors)
  return rl.UnloadImageColors(colors)
end
local function unload_image_palette(colors)
  return rl.UnloadImagePalette(colors)
end
local function get_image_alpha_border(image, threshold)
  return rl.GetImageAlphaBorder(image, threshold)
end
local function get_image_color(image, x, y)
  return rl.GetImageColor(image, x, y)
end
local function image_clear_background(dst, color)
  return rl.ImageClearBackground(dst, color)
end
local function image_draw_pixel(dst, pos_x, pos_y, color)
  return rl.ImageDrawPixel(dst, pos_x, pos_y, color)
end
local function image_draw_pixel_v(dst, position, color)
  return rl.ImageDrawPixelV(dst, position, color)
end
local function image_draw_line(dst, start_pos_x, start_pos_y, end_pos_x, end_pos_y, color)
  return rl.ImageDrawLine(dst, start_pos_x, start_pos_y, end_pos_x, end_pos_y, color)
end
local function image_draw_line_v(dst, start, _end, color)
  return rl.ImageDrawLineV(dst, start, _end, color)
end
local function image_draw_line_ex(dst, start, _end, thick, color)
  return rl.ImageDrawLineEx(dst, start, _end, thick, color)
end
local function image_draw_circle(dst, center_x, center_y, radius, color)
  return rl.ImageDrawCircle(dst, center_x, center_y, radius, color)
end
local function image_draw_circle_v(dst, center, radius, color)
  return rl.ImageDrawCircleV(dst, center, radius, color)
end
local function image_draw_circle_lines(dst, center_x, center_y, radius, color)
  return rl.ImageDrawCircleLines(dst, center_x, center_y, radius, color)
end
local function image_draw_circle_lines_v(dst, center, radius, color)
  return rl.ImageDrawCircleLinesV(dst, center, radius, color)
end
local function image_draw_rectangle(dst, pos_x, pos_y, width, height, color)
  return rl.ImageDrawRectangle(dst, pos_x, pos_y, width, height, color)
end
local function image_draw_rectangle_v(dst, position, size, color)
  return rl.ImageDrawRectangleV(dst, position, size, color)
end
local function image_draw_rectangle_rec(dst, rec, color)
  return rl.ImageDrawRectangleRec(dst, rec, color)
end
local function image_draw_rectangle_lines(dst, rec, thick, color)
  return rl.ImageDrawRectangleLines(dst, rec, thick, color)
end
local function image_draw_triangle(dst, v1, v2, v3, color)
  return rl.ImageDrawTriangle(dst, v1, v2, v3, color)
end
local function image_draw_triangle_ex(dst, v1, v2, v3, c1, c2, c3)
  return rl.ImageDrawTriangleEx(dst, v1, v2, v3, c1, c2, c3)
end
local function image_draw_triangle_lines(dst, v1, v2, v3, color)
  return rl.ImageDrawTriangleLines(dst, v1, v2, v3, color)
end
local function image_draw_triangle_fan(dst, points, point_count, color)
  return rl.ImageDrawTriangleFan(dst, points, point_count, color)
end
local function image_draw_triangle_strip(dst, points, point_count, color)
  return rl.ImageDrawTriangleStrip(dst, points, point_count, color)
end
local function image_draw(dst, src, src_rec, dst_rec, tint)
  return rl.ImageDraw(dst, src, src_rec, dst_rec, tint)
end
local function image_draw_text(dst, text, pos_x, pos_y, font_size, color)
  return rl.ImageDrawText(dst, text, pos_x, pos_y, font_size, color)
end
local function image_draw_text_ex(dst, font, text, position, font_size, spacing, tint)
  return rl.ImageDrawTextEx(dst, font, text, position, font_size, spacing, tint)
end
local function load_texture(file_name)
  return rl.LoadTexture(file_name)
end
local function load_texture_from_image(image)
  return rl.LoadTextureFromImage(image)
end
local function load_texture_cubemap(image, layout)
  return rl.LoadTextureCubemap(image, layout)
end
local function load_render_texture(width, height)
  return rl.LoadRenderTexture(width, height)
end
local function is_texture_valid(texture)
  return rl.IsTextureValid(texture)
end
local function unload_texture(texture)
  return rl.UnloadTexture(texture)
end
local function is_render_texture_valid(target)
  return rl.IsRenderTextureValid(target)
end
local function unload_render_texture(target)
  return rl.UnloadRenderTexture(target)
end
local function update_texture(texture, pixels)
  return rl.UpdateTexture(texture, pixels)
end
local function update_texture_rec(texture, rec, pixels)
  return rl.UpdateTextureRec(texture, rec, pixels)
end
local function gen_texture_mipmaps(texture)
  return rl.GenTextureMipmaps(texture)
end
local function set_texture_filter(texture, filter)
  return rl.SetTextureFilter(texture, filter)
end
local function set_texture_wrap(texture, wrap)
  return rl.SetTextureWrap(texture, wrap)
end
local function draw_texture(texture, pos_x, pos_y, tint)
  return rl.DrawTexture(texture, pos_x, pos_y, tint)
end
local function draw_texture_v(texture, position, tint)
  return rl.DrawTextureV(texture, position, tint)
end
local function draw_texture_ex(texture, position, rotation, scale, tint)
  return rl.DrawTextureEx(texture, position, rotation, scale, tint)
end
local function draw_texture_rec(texture, source, position, tint)
  return rl.DrawTextureRec(texture, source, position, tint)
end
local function draw_texture_pro(texture, source, dest, origin, rotation, tint)
  return rl.DrawTexturePro(texture, source, dest, origin, rotation, tint)
end
local function draw_texture_npatch(texture, n_patch_info, dest, origin, rotation, tint)
  return rl.DrawTextureNPatch(texture, n_patch_info, dest, origin, rotation, tint)
end
local function color_is_equal(col1, col2)
  return rl.ColorIsEqual(col1, col2)
end
local function fade(color, alpha)
  return rl.Fade(color, alpha)
end
local function color_to_int(color)
  return rl.ColorToInt(color)
end
local function color_normalize(color)
  return rl.ColorNormalize(color)
end
local function color_from_normalized(normalized)
  return rl.ColorFromNormalized(normalized)
end
local function color_to_hsv(color)
  return rl.ColorToHSV(color)
end
local function color_from_hsv(hue, saturation, value)
  return rl.ColorFromHSV(hue, saturation, value)
end
local function color_tint(color, tint)
  return rl.ColorTint(color, tint)
end
local function color_brightness(color, factor)
  return rl.ColorBrightness(color, factor)
end
local function color_contrast(color, contrast)
  return rl.ColorContrast(color, contrast)
end
local function color_alpha(color, alpha)
  return rl.ColorAlpha(color, alpha)
end
local function color_alpha_blend(dst, src, tint)
  return rl.ColorAlphaBlend(dst, src, tint)
end
local function color_lerp(color1, color2, factor)
  return rl.ColorLerp(color1, color2, factor)
end
local function get_color(hex_value)
  return rl.GetColor(hex_value)
end
local function get_pixel_color(src_ptr, format)
  return rl.GetPixelColor(src_ptr, format)
end
local function set_pixel_color(dst_ptr, color, format)
  return rl.SetPixelColor(dst_ptr, color, format)
end
local function get_pixel_data_size(width, height, format)
  return rl.GetPixelDataSize(width, height, format)
end
local function get_font_default()
  return rl.GetFontDefault()
end
local function load_font(file_name)
  return rl.LoadFont(file_name)
end
local function load_font_ex(file_name, font_size, codepoints, codepoint_count)
  return rl.LoadFontEx(file_name, font_size, codepoints, codepoint_count)
end
local function load_font_from_image(image, key, first_char)
  return rl.LoadFontFromImage(image, key, first_char)
end
local function load_font_from_memory(file_type, file_data, data_size, font_size, codepoints, codepoint_count)
  return rl.LoadFontFromMemory(file_type, file_data, data_size, font_size, codepoints, codepoint_count)
end
local function is_font_valid(font)
  return rl.IsFontValid(font)
end
local function load_font_data(file_data, data_size, font_size, codepoints, codepoint_count, type)
  return rl.LoadFontData(file_data, data_size, font_size, codepoints, codepoint_count, type)
end
local function gen_image_font_atlas(glyphs, glyph_recs, glyph_count, font_size, padding, pack_method)
  return rl.GenImageFontAtlas(glyphs, glyph_recs, glyph_count, font_size, padding, pack_method)
end
local function unload_font_data(glyphs, glyph_count)
  return rl.UnloadFontData(glyphs, glyph_count)
end
local function unload_font(font)
  return rl.UnloadFont(font)
end
local function export_font_as_code(font, file_name)
  return rl.ExportFontAsCode(font, file_name)
end
local function draw_fps(pos_x, pos_y)
  return rl.DrawFPS(pos_x, pos_y)
end
local function draw_text(text, pos_x, pos_y, font_size, color)
  return rl.DrawText(text, pos_x, pos_y, font_size, color)
end
local function draw_text_ex(font, text, position, font_size, spacing, tint)
  return rl.DrawTextEx(font, text, position, font_size, spacing, tint)
end
local function draw_text_pro(font, text, position, origin, rotation, font_size, spacing, tint)
  return rl.DrawTextPro(font, text, position, origin, rotation, font_size, spacing, tint)
end
local function draw_text_codepoint(font, codepoint, position, font_size, tint)
  return rl.DrawTextCodepoint(font, codepoint, position, font_size, tint)
end
local function draw_text_codepoints(font, codepoints, codepoint_count, position, font_size, spacing, tint)
  return rl.DrawTextCodepoints(font, codepoints, codepoint_count, position, font_size, spacing, tint)
end
local function set_text_line_spacing(spacing)
  return rl.SetTextLineSpacing(spacing)
end
local function measure_text(text, font_size)
  return rl.MeasureText(text, font_size)
end
local function measure_text_ex(font, text, font_size, spacing)
  return rl.MeasureTextEx(font, text, font_size, spacing)
end
local function get_glyph_index(font, codepoint)
  return rl.GetGlyphIndex(font, codepoint)
end
local function get_glyph_info(font, codepoint)
  return rl.GetGlyphInfo(font, codepoint)
end
local function get_glyph_atlas_rec(font, codepoint)
  return rl.GetGlyphAtlasRec(font, codepoint)
end
local function load_utf8(codepoints, llength)
  return rl.LoadUTF8(codepoints, llength)
end
local function unload_utf8(text)
  return rl.UnloadUTF8(text)
end
local function load_codepoints(text, count)
  return rl.LoadCodepoints(text, count)
end
local function unload_codepoints(codepoints)
  return rl.UnloadCodepoints(codepoints)
end
local function get_codepoint_count(text)
  return rl.GetCodepointCount(text)
end
local function get_codepoint(text, codepoint_size)
  return rl.GetCodepoint(text, codepoint_size)
end
local function get_codepoint_next(text, codepoint_size)
  return rl.GetCodepointNext(text, codepoint_size)
end
local function get_codepoint_previous(text, codepoint_size)
  return rl.GetCodepointPrevious(text, codepoint_size)
end
local function codepoint_to_utf8(codepoint, utf8size)
  return rl.CodepointToUTF8(codepoint, utf8size)
end
local function text_copy(dst, src)
  return rl.TextCopy(dst, src)
end
local function text_is_equal(text1, text2)
  return rl.TextIsEqual(text1, text2)
end
local function text_length(text)
  return rl.TextLength(text)
end
local function text_format(text)
  return rl.TextFormat(text)
end
local function text_subtext(text, position, llength)
  return rl.TextSubtext(text, position, llength)
end
local function text_replace(text, replace, by)
  return rl.TextReplace(text, replace, by)
end
local function text_insert(text, insert, position)
  return rl.TextInsert(text, insert, position)
end
local function text_join(text_list, count, delimiter)
  return rl.TextJoin(text_list, count, delimiter)
end
local function text_split(text, delimiter, count)
  return rl.TextSplit(text, delimiter, count)
end
local function text_append(text, append, position)
  return rl.TextAppend(text, append, position)
end
local function text_find_index(text, find)
  return rl.TextFindIndex(text, find)
end
local function text_to_upper(text)
  return rl.TextToUpper(text)
end
local function text_to_lower(text)
  return rl.TextToLower(text)
end
local function text_to_pascal(text)
  return rl.TextToPascal(text)
end
local function text_to_snake(text)
  return rl.TextToSnake(text)
end
local function text_to_camel(text)
  return rl.TextToCamel(text)
end
local function text_to_integer(text)
  return rl.TextToInteger(text)
end
local function text_to_float(text)
  return rl.TextToFloat(text)
end
local function draw_line3d(start_pos, end_pos, color)
  return rl.DrawLine3D(start_pos, end_pos, color)
end
local function draw_point3d(position, color)
  return rl.DrawPoint3D(position, color)
end
local function draw_circle3d(center, radius, rotation_axis, rotation_angle, color)
  return rl.DrawCircle3D(center, radius, rotation_axis, rotation_angle, color)
end
local function draw_triangle3d(v1, v2, v3, color)
  return rl.DrawTriangle3D(v1, v2, v3, color)
end
local function draw_triangle_strip3d(points, point_count, color)
  return rl.DrawTriangleStrip3D(points, point_count, color)
end
local function draw_cube(position, width, height, llength, color)
  return rl.DrawCube(position, width, height, llength, color)
end
local function draw_cube_v(position, size, color)
  return rl.DrawCubeV(position, size, color)
end
local function draw_cube_wires(position, width, height, llength, color)
  return rl.DrawCubeWires(position, width, height, llength, color)
end
local function draw_cube_wires_v(position, size, color)
  return rl.DrawCubeWiresV(position, size, color)
end
local function draw_sphere(center_pos, radius, color)
  return rl.DrawSphere(center_pos, radius, color)
end
local function draw_sphere_ex(center_pos, radius, rings, slices, color)
  return rl.DrawSphereEx(center_pos, radius, rings, slices, color)
end
local function draw_sphere_wires(center_pos, radius, rings, slices, color)
  return rl.DrawSphereWires(center_pos, radius, rings, slices, color)
end
local function draw_cylinder(position, radius_top, radius_bottom, height, slices, color)
  return rl.DrawCylinder(position, radius_top, radius_bottom, height, slices, color)
end
local function draw_cylinder_ex(start_pos, end_pos, start_radius, end_radius, sides, color)
  return rl.DrawCylinderEx(start_pos, end_pos, start_radius, end_radius, sides, color)
end
local function draw_cylinder_wires(position, radius_top, radius_bottom, height, slices, color)
  return rl.DrawCylinderWires(position, radius_top, radius_bottom, height, slices, color)
end
local function draw_cylinder_wires_ex(start_pos, end_pos, start_radius, end_radius, sides, color)
  return rl.DrawCylinderWiresEx(start_pos, end_pos, start_radius, end_radius, sides, color)
end
local function draw_capsule(start_pos, end_pos, radius, slices, rings, color)
  return rl.DrawCapsule(start_pos, end_pos, radius, slices, rings, color)
end
local function draw_capsule_wires(start_pos, end_pos, radius, slices, rings, color)
  return rl.DrawCapsuleWires(start_pos, end_pos, radius, slices, rings, color)
end
local function draw_plane(center_pos, size, color)
  return rl.DrawPlane(center_pos, size, color)
end
local function draw_ray(ray, color)
  return rl.DrawRay(ray, color)
end
local function draw_grid(slices, spacing)
  return rl.DrawGrid(slices, spacing)
end
local function load_model(file_name)
  return rl.LoadModel(file_name)
end
local function load_model_from_mesh(mesh)
  return rl.LoadModelFromMesh(mesh)
end
local function is_model_valid(model)
  return rl.IsModelValid(model)
end
local function unload_model(model)
  return rl.UnloadModel(model)
end
local function get_model_bounding_box(model)
  return rl.GetModelBoundingBox(model)
end
local function draw_model(model, position, scale, tint)
  return rl.DrawModel(model, position, scale, tint)
end
local function draw_model_ex(model, position, rotation_axis, rotation_angle, scale, tint)
  return rl.DrawModelEx(model, position, rotation_axis, rotation_angle, scale, tint)
end
local function draw_model_wires(model, position, scale, tint)
  return rl.DrawModelWires(model, position, scale, tint)
end
local function draw_model_wires_ex(model, position, rotation_axis, rotation_angle, scale, tint)
  return rl.DrawModelWiresEx(model, position, rotation_axis, rotation_angle, scale, tint)
end
local function draw_model_points(model, position, scale, tint)
  return rl.DrawModelPoints(model, position, scale, tint)
end
local function draw_model_points_ex(model, position, rotation_axis, rotation_angle, scale, tint)
  return rl.DrawModelPointsEx(model, position, rotation_axis, rotation_angle, scale, tint)
end
local function draw_bounding_box(box, color)
  return rl.DrawBoundingBox(box, color)
end
local function draw_billboard(camera, texture, position, scale, tint)
  return rl.DrawBillboard(camera, texture, position, scale, tint)
end
local function draw_billboard_rec(camera, texture, source, position, size, tint)
  return rl.DrawBillboardRec(camera, texture, source, position, size, tint)
end
local function draw_billboard_pro(camera, texture, source, position, up, size, origin, rotation, tint)
  return rl.DrawBillboardPro(camera, texture, source, position, up, size, origin, rotation, tint)
end
local function upload_mesh(mesh, dynamic)
  return rl.UploadMesh(mesh, dynamic)
end
local function update_mesh_buffer(mesh, index, data, data_size, offset)
  return rl.UpdateMeshBuffer(mesh, index, data, data_size, offset)
end
local function unload_mesh(mesh)
  return rl.UnloadMesh(mesh)
end
local function draw_mesh(mesh, material, transform)
  return rl.DrawMesh(mesh, material, transform)
end
local function draw_mesh_instanced(mesh, material, transforms, instances)
  return rl.DrawMeshInstanced(mesh, material, transforms, instances)
end
local function get_mesh_bounding_box(mesh)
  return rl.GetMeshBoundingBox(mesh)
end
local function gen_mesh_tangents(mesh)
  return rl.GenMeshTangents(mesh)
end
local function export_mesh(mesh, file_name)
  return rl.ExportMesh(mesh, file_name)
end
local function export_mesh_as_code(mesh, file_name)
  return rl.ExportMeshAsCode(mesh, file_name)
end
local function gen_mesh_poly(sides, radius)
  return rl.GenMeshPoly(sides, radius)
end
local function gen_mesh_plane(width, llength, res_x, res_z)
  return rl.GenMeshPlane(width, llength, res_x, res_z)
end
local function gen_mesh_cube(width, height, llength)
  return rl.GenMeshCube(width, height, llength)
end
local function gen_mesh_sphere(radius, rings, slices)
  return rl.GenMeshSphere(radius, rings, slices)
end
local function gen_mesh_hemi_sphere(radius, rings, slices)
  return rl.GenMeshHemiSphere(radius, rings, slices)
end
local function gen_mesh_cylinder(radius, height, slices)
  return rl.GenMeshCylinder(radius, height, slices)
end
local function gen_mesh_cone(radius, height, slices)
  return rl.GenMeshCone(radius, height, slices)
end
local function gen_mesh_torus(radius, size, rad_seg, sides)
  return rl.GenMeshTorus(radius, size, rad_seg, sides)
end
local function gen_mesh_knot(radius, size, rad_seg, sides)
  return rl.GenMeshKnot(radius, size, rad_seg, sides)
end
local function gen_mesh_heightmap(heightmap, size)
  return rl.GenMeshHeightmap(heightmap, size)
end
local function gen_mesh_cubicmap(cubicmap, cube_size)
  return rl.GenMeshCubicmap(cubicmap, cube_size)
end
local function load_materials(file_name, material_count)
  return rl.LoadMaterials(file_name, material_count)
end
local function load_material_default()
  return rl.LoadMaterialDefault()
end
local function is_material_valid(material)
  return rl.IsMaterialValid(material)
end
local function unload_material(material)
  return rl.UnloadMaterial(material)
end
local function set_material_texture(material, map_type, texture)
  return rl.SetMaterialTexture(material, map_type, texture)
end
local function set_model_mesh_material(model, mesh_id, material_id)
  return rl.SetModelMeshMaterial(model, mesh_id, material_id)
end
local function load_model_animations(file_name, anim_count)
  return rl.LoadModelAnimations(file_name, anim_count)
end
local function update_model_animation(model, anim, frame)
  return rl.UpdateModelAnimation(model, anim, frame)
end
local function update_model_animation_bones(model, anim, frame)
  return rl.UpdateModelAnimationBones(model, anim, frame)
end
local function unload_model_animation(anim)
  return rl.UnloadModelAnimation(anim)
end
local function unload_model_animations(animations, anim_count)
  return rl.UnloadModelAnimations(animations, anim_count)
end
local function is_model_animation_valid(model, anim)
  return rl.IsModelAnimationValid(model, anim)
end
local function check_collision_spheres(center1, radius1, center2, radius2)
  return rl.CheckCollisionSpheres(center1, radius1, center2, radius2)
end
local function check_collision_boxes(box1, box2)
  return rl.CheckCollisionBoxes(box1, box2)
end
local function check_collision_box_sphere(box, center, radius)
  return rl.CheckCollisionBoxSphere(box, center, radius)
end
local function get_ray_collision_sphere(ray, center, radius)
  return rl.GetRayCollisionSphere(ray, center, radius)
end
local function get_ray_collision_box(ray, box)
  return rl.GetRayCollisionBox(ray, box)
end
local function get_ray_collision_mesh(ray, mesh, transform)
  return rl.GetRayCollisionMesh(ray, mesh, transform)
end
local function get_ray_collision_triangle(ray, p1, p2, p3)
  return rl.GetRayCollisionTriangle(ray, p1, p2, p3)
end
local function get_ray_collision_quad(ray, p1, p2, p3, p4)
  return rl.GetRayCollisionQuad(ray, p1, p2, p3, p4)
end
local function init_audio_device()
  return rl.InitAudioDevice()
end
local function close_audio_device()
  return rl.CloseAudioDevice()
end
local function is_audio_device_ready()
  return rl.IsAudioDeviceReady()
end
local function set_master_volume(volume)
  return rl.SetMasterVolume(volume)
end
local function get_master_volume()
  return rl.GetMasterVolume()
end
local function load_wave(file_name)
  return rl.LoadWave(file_name)
end
local function load_wave_from_memory(file_type, file_data, data_size)
  return rl.LoadWaveFromMemory(file_type, file_data, data_size)
end
local function is_wave_valid(wave)
  return rl.IsWaveValid(wave)
end
local function load_sound(file_name)
  return rl.LoadSound(file_name)
end
local function load_sound_from_wave(wave)
  return rl.LoadSoundFromWave(wave)
end
local function load_sound_alias(source)
  return rl.LoadSoundAlias(source)
end
local function is_sound_valid(sound)
  return rl.IsSoundValid(sound)
end
local function update_sound(sound, data, sample_count)
  return rl.UpdateSound(sound, data, sample_count)
end
local function unload_wave(wave)
  return rl.UnloadWave(wave)
end
local function unload_sound(sound)
  return rl.UnloadSound(sound)
end
local function unload_sound_alias(alias)
  return rl.UnloadSoundAlias(alias)
end
local function export_wave(wave, file_name)
  return rl.ExportWave(wave, file_name)
end
local function export_wave_as_code(wave, file_name)
  return rl.ExportWaveAsCode(wave, file_name)
end
local function play_sound(sound)
  return rl.PlaySound(sound)
end
local function stop_sound(sound)
  return rl.StopSound(sound)
end
local function pause_sound(sound)
  return rl.PauseSound(sound)
end
local function resume_sound(sound)
  return rl.ResumeSound(sound)
end
local function is_sound_playing(sound)
  return rl.IsSoundPlaying(sound)
end
local function set_sound_volume(sound, volume)
  return rl.SetSoundVolume(sound, volume)
end
local function set_sound_pitch(sound, pitch)
  return rl.SetSoundPitch(sound, pitch)
end
local function set_sound_pan(sound, pan)
  return rl.SetSoundPan(sound, pan)
end
local function wave_copy(wave)
  return rl.WaveCopy(wave)
end
local function wave_crop(wave, init_frame, final_frame)
  return rl.WaveCrop(wave, init_frame, final_frame)
end
local function wave_format(wave, sample_rate, sample_size, channels)
  return rl.WaveFormat(wave, sample_rate, sample_size, channels)
end
local function load_wave_samples(wave)
  return rl.LoadWaveSamples(wave)
end
local function unload_wave_samples(samples)
  return rl.UnloadWaveSamples(samples)
end
local function load_music_stream(file_name)
  return rl.LoadMusicStream(file_name)
end
local function load_music_stream_from_memory(file_type, data, data_size)
  return rl.LoadMusicStreamFromMemory(file_type, data, data_size)
end
local function is_music_valid(music)
  return rl.IsMusicValid(music)
end
local function unload_music_stream(music)
  return rl.UnloadMusicStream(music)
end
local function play_music_stream(music)
  return rl.PlayMusicStream(music)
end
local function is_music_stream_playing(music)
  return rl.IsMusicStreamPlaying(music)
end
local function update_music_stream(music)
  return rl.UpdateMusicStream(music)
end
local function stop_music_stream(music)
  return rl.StopMusicStream(music)
end
local function pause_music_stream(music)
  return rl.PauseMusicStream(music)
end
local function resume_music_stream(music)
  return rl.ResumeMusicStream(music)
end
local function seek_music_stream(music, position)
  return rl.SeekMusicStream(music, position)
end
local function set_music_volume(music, volume)
  return rl.SetMusicVolume(music, volume)
end
local function set_music_pitch(music, pitch)
  return rl.SetMusicPitch(music, pitch)
end
local function set_music_pan(music, pan)
  return rl.SetMusicPan(music, pan)
end
local function get_music_time_length(music)
  return rl.GetMusicTimeLength(music)
end
local function get_music_time_played(music)
  return rl.GetMusicTimePlayed(music)
end
local function load_audio_stream(sample_rate, sample_size, channels)
  return rl.LoadAudioStream(sample_rate, sample_size, channels)
end
local function is_audio_stream_valid(stream)
  return rl.IsAudioStreamValid(stream)
end
local function unload_audio_stream(stream)
  return rl.UnloadAudioStream(stream)
end
local function update_audio_stream(stream, data, frame_count)
  return rl.UpdateAudioStream(stream, data, frame_count)
end
local function is_audio_stream_processed(stream)
  return rl.IsAudioStreamProcessed(stream)
end
local function play_audio_stream(stream)
  return rl.PlayAudioStream(stream)
end
local function pause_audio_stream(stream)
  return rl.PauseAudioStream(stream)
end
local function resume_audio_stream(stream)
  return rl.ResumeAudioStream(stream)
end
local function is_audio_stream_playing(stream)
  return rl.IsAudioStreamPlaying(stream)
end
local function stop_audio_stream(stream)
  return rl.StopAudioStream(stream)
end
local function set_audio_stream_volume(stream, volume)
  return rl.SetAudioStreamVolume(stream, volume)
end
local function set_audio_stream_pitch(stream, pitch)
  return rl.SetAudioStreamPitch(stream, pitch)
end
local function set_audio_stream_pan(stream, pan)
  return rl.SetAudioStreamPan(stream, pan)
end
local function set_audio_stream_buffer_size_default(size)
  return rl.SetAudioStreamBufferSizeDefault(size)
end
local function set_audio_stream_callback(stream, callback)
  return rl.SetAudioStreamCallback(stream, callback)
end
local function attach_audio_stream_processor(stream, processor)
  return rl.AttachAudioStreamProcessor(stream, processor)
end
local function detach_audio_stream_processor(stream, processor)
  return rl.DetachAudioStreamProcessor(stream, processor)
end
local function attach_audio_mixed_processor(processor)
  return rl.AttachAudioMixedProcessor(processor)
end
local function detach_audio_mixed_processor(processor)
  return rl.DetachAudioMixedProcessor(processor)
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
return {["safe-mode"] = safe_mode, Vector2 = Vector2, Vector3 = Vector3, Vector4 = Vector4, Quaternion = Quaternion, Matrix = Matrix, Color = Color, Rectangle = Rectangle, Image = Image, Texture = Texture, Texture2D = Texture2D, TextureCubemap = TextureCubemap, RenderTexture = RenderTexture, RenderTexture2D = RenderTexture2D, NPatchInfo = NPatchInfo, GlyphInfo = GlyphInfo, Font = Font, Camera3D = Camera3D, Camera = Camera, Camera2D = Camera2D, Mesh = Mesh, Shader = Shader, MaterialMap = MaterialMap, Material = Material, Transform = Transform, BoneInfo = BoneInfo, Model = Model, ModelAnimation = ModelAnimation, Ray = Ray, RayCollision = RayCollision, BoundingBox = BoundingBox, Wave = Wave, AudioStream = AudioStream, Sound = Sound, Music = Music, VrDeviceInfo = VrDeviceInfo, VrStereoConfig = VrStereoConfig, FilePathList = FilePathList, AutomationEvent = AutomationEvent, AutomationEventList = AutomationEventList, ["flag-vsync-hint"] = flag_vsync_hint, ["flag-fullscreen-mode"] = flag_fullscreen_mode, ["flag-window-resizable"] = flag_window_resizable, ["flag-window-undecorated"] = flag_window_undecorated, ["flag-window-hidden"] = flag_window_hidden, ["flag-window-minimized"] = flag_window_minimized, ["flag-window-maximized"] = flag_window_maximized, ["flag-window-unfocused"] = flag_window_unfocused, ["flag-window-topmost"] = flag_window_topmost, ["flag-window-always-run"] = flag_window_always_run, ["flag-window-transparent"] = flag_window_transparent, ["flag-window-highdpi"] = flag_window_highdpi, ["flag-window-mouse-passthrough"] = flag_window_mouse_passthrough, ["flag-borderless-windowed-mode"] = flag_borderless_windowed_mode, ["flag-msaa-4x-hint"] = flag_msaa_4x_hint, ["flag-interlaced-hint"] = flag_interlaced_hint, ["log-all"] = log_all, ["log-trace"] = log_trace, ["log-debug"] = log_debug, ["log-info"] = log_info, ["log-warning"] = log_warning, ["log-error"] = log_error, ["log-fatal"] = log_fatal, ["log-none"] = log_none, ["key-null"] = key_null, ["key-apostrophe"] = key_apostrophe, ["key-comma"] = key_comma, ["key-minus"] = key_minus, ["key-period"] = key_period, ["key-slash"] = key_slash, ["key-zero"] = key_zero, ["key-one"] = key_one, ["key-two"] = key_two, ["key-three"] = key_three, ["key-four"] = key_four, ["key-five"] = key_five, ["key-six"] = key_six, ["key-seven"] = key_seven, ["key-eight"] = key_eight, ["key-nine"] = key_nine, ["key-semicolon"] = key_semicolon, ["key-equal"] = key_equal, ["key-a"] = key_a, ["key-b"] = key_b, ["key-c"] = key_c, ["key-d"] = key_d, ["key-e"] = key_e, ["key-f"] = key_f, ["key-g"] = key_g, ["key-h"] = key_h, ["key-i"] = key_i, ["key-j"] = key_j, ["key-k"] = key_k, ["key-l"] = key_l, ["key-m"] = key_m, ["key-n"] = key_n, ["key-o"] = key_o, ["key-p"] = key_p, ["key-q"] = key_q, ["key-r"] = key_r, ["key-s"] = key_s, ["key-t"] = key_t, ["key-u"] = key_u, ["key-v"] = key_v, ["key-w"] = key_w, ["key-x"] = key_x, ["key-y"] = key_y, ["key-z"] = key_z, ["key-left-bracket"] = key_left_bracket, ["key-backslash"] = key_backslash, ["key-right-bracket"] = key_right_bracket, ["key-grave"] = key_grave, ["key-space"] = key_space, ["key-escape"] = key_escape, ["key-enter"] = key_enter, ["key-tab"] = key_tab, ["key-backspace"] = key_backspace, ["key-insert"] = key_insert, ["key-delete"] = key_delete, ["key-right"] = key_right, ["key-left"] = key_left, ["key-down"] = key_down, ["key-up"] = key_up, ["key-page-up"] = key_page_up, ["key-page-down"] = key_page_down, ["key-home"] = key_home, ["key-end"] = key_end, ["key-caps-lock"] = key_caps_lock, ["key-scroll-lock"] = key_scroll_lock, ["key-num-lock"] = key_num_lock, ["key-print-screen"] = key_print_screen, ["key-pause"] = key_pause, ["key-f1"] = key_f1, ["key-f2"] = key_f2, ["key-f3"] = key_f3, ["key-f4"] = key_f4, ["key-f5"] = key_f5, ["key-f6"] = key_f6, ["key-f7"] = key_f7, ["key-f8"] = key_f8, ["key-f9"] = key_f9, ["key-f10"] = key_f10, ["key-f11"] = key_f11, ["key-f12"] = key_f12, ["key-left-shift"] = key_left_shift, ["key-left-control"] = key_left_control, ["key-left-alt"] = key_left_alt, ["key-left-super"] = key_left_super, ["key-right-shift"] = key_right_shift, ["key-right-control"] = key_right_control, ["key-right-alt"] = key_right_alt, ["key-right-super"] = key_right_super, ["key-kb-menu"] = key_kb_menu, ["key-kp-0"] = key_kp_0, ["key-kp-1"] = key_kp_1, ["key-kp-2"] = key_kp_2, ["key-kp-3"] = key_kp_3, ["key-kp-4"] = key_kp_4, ["key-kp-5"] = key_kp_5, ["key-kp-6"] = key_kp_6, ["key-kp-7"] = key_kp_7, ["key-kp-8"] = key_kp_8, ["key-kp-9"] = key_kp_9, ["key-kp-decimal"] = key_kp_decimal, ["key-kp-divide"] = key_kp_divide, ["key-kp-multiply"] = key_kp_multiply, ["key-kp-subtract"] = key_kp_subtract, ["key-kp-add"] = key_kp_add, ["key-kp-enter"] = key_kp_enter, ["key-kp-equal"] = key_kp_equal, ["key-back"] = key_back, ["key-menu"] = key_menu, ["key-volume-up"] = key_volume_up, ["key-volume-down"] = key_volume_down, ["mouse-button-left"] = mouse_button_left, ["mouse-button-right"] = mouse_button_right, ["mouse-button-middle"] = mouse_button_middle, ["mouse-button-side"] = mouse_button_side, ["mouse-button-extra"] = mouse_button_extra, ["mouse-button-forward"] = mouse_button_forward, ["mouse-button-back"] = mouse_button_back, ["mouse-cursor-default"] = mouse_cursor_default, ["mouse-cursor-arrow"] = mouse_cursor_arrow, ["mouse-cursor-ibeam"] = mouse_cursor_ibeam, ["mouse-cursor-crosshair"] = mouse_cursor_crosshair, ["mouse-cursor-pointing-hand"] = mouse_cursor_pointing_hand, ["mouse-cursor-resize-ew"] = mouse_cursor_resize_ew, ["mouse-cursor-resize-ns"] = mouse_cursor_resize_ns, ["mouse-cursor-resize-nwse"] = mouse_cursor_resize_nwse, ["mouse-cursor-resize-nesw"] = mouse_cursor_resize_nesw, ["mouse-cursor-resize-all"] = mouse_cursor_resize_all, ["mouse-cursor-not-allowed"] = mouse_cursor_not_allowed, ["gamepad-button-unknown"] = gamepad_button_unknown, ["gamepad-button-left-face-up"] = gamepad_button_left_face_up, ["gamepad-button-left-face-right"] = gamepad_button_left_face_right, ["gamepad-button-left-face-down"] = gamepad_button_left_face_down, ["gamepad-button-left-face-left"] = gamepad_button_left_face_left, ["gamepad-button-right-face-up"] = gamepad_button_right_face_up, ["gamepad-button-right-face-right"] = gamepad_button_right_face_right, ["gamepad-button-right-face-down"] = gamepad_button_right_face_down, ["gamepad-button-right-face-left"] = gamepad_button_right_face_left, ["gamepad-button-left-trigger-1"] = gamepad_button_left_trigger_1, ["gamepad-button-left-trigger-2"] = gamepad_button_left_trigger_2, ["gamepad-button-right-trigger-1"] = gamepad_button_right_trigger_1, ["gamepad-button-right-trigger-2"] = gamepad_button_right_trigger_2, ["gamepad-button-middle-left"] = gamepad_button_middle_left, ["gamepad-button-middle"] = gamepad_button_middle, ["gamepad-button-middle-right"] = gamepad_button_middle_right, ["gamepad-button-left-thumb"] = gamepad_button_left_thumb, ["gamepad-button-right-thumb"] = gamepad_button_right_thumb, ["gamepad-axis-left-x"] = gamepad_axis_left_x, ["gamepad-axis-left-y"] = gamepad_axis_left_y, ["gamepad-axis-right-x"] = gamepad_axis_right_x, ["gamepad-axis-right-y"] = gamepad_axis_right_y, ["gamepad-axis-left-trigger"] = gamepad_axis_left_trigger, ["gamepad-axis-right-trigger"] = gamepad_axis_right_trigger, ["material-map-albedo"] = material_map_albedo, ["material-map-metalness"] = material_map_metalness, ["material-map-normal"] = material_map_normal, ["material-map-roughness"] = material_map_roughness, ["material-map-occlusion"] = material_map_occlusion, ["material-map-emission"] = material_map_emission, ["material-map-height"] = material_map_height, ["material-map-cubemap"] = material_map_cubemap, ["material-map-irradiance"] = material_map_irradiance, ["material-map-prefilter"] = material_map_prefilter, ["material-map-brdf"] = material_map_brdf, ["shader-loc-vertex-position"] = shader_loc_vertex_position, ["shader-loc-vertex-texcoord01"] = shader_loc_vertex_texcoord01, ["shader-loc-vertex-texcoord02"] = shader_loc_vertex_texcoord02, ["shader-loc-vertex-normal"] = shader_loc_vertex_normal, ["shader-loc-vertex-tangent"] = shader_loc_vertex_tangent, ["shader-loc-vertex-color"] = shader_loc_vertex_color, ["shader-loc-matrix-mvp"] = shader_loc_matrix_mvp, ["shader-loc-matrix-view"] = shader_loc_matrix_view, ["shader-loc-matrix-projection"] = shader_loc_matrix_projection, ["shader-loc-matrix-model"] = shader_loc_matrix_model, ["shader-loc-matrix-normal"] = shader_loc_matrix_normal, ["shader-loc-vector-view"] = shader_loc_vector_view, ["shader-loc-color-diffuse"] = shader_loc_color_diffuse, ["shader-loc-color-specular"] = shader_loc_color_specular, ["shader-loc-color-ambient"] = shader_loc_color_ambient, ["shader-loc-map-albedo"] = shader_loc_map_albedo, ["shader-loc-map-metalness"] = shader_loc_map_metalness, ["shader-loc-map-normal"] = shader_loc_map_normal, ["shader-loc-map-roughness"] = shader_loc_map_roughness, ["shader-loc-map-occlusion"] = shader_loc_map_occlusion, ["shader-loc-map-emission"] = shader_loc_map_emission, ["shader-loc-map-height"] = shader_loc_map_height, ["shader-loc-map-cubemap"] = shader_loc_map_cubemap, ["shader-loc-map-irradiance"] = shader_loc_map_irradiance, ["shader-loc-map-prefilter"] = shader_loc_map_prefilter, ["shader-loc-map-brdf"] = shader_loc_map_brdf, ["shader-loc-vertex-boneids"] = shader_loc_vertex_boneids, ["shader-loc-vertex-boneweights"] = shader_loc_vertex_boneweights, ["shader-loc-bone-matrices"] = shader_loc_bone_matrices, ["shader-uniform-float"] = shader_uniform_float, ["shader-uniform-vec2"] = shader_uniform_vec2, ["shader-uniform-vec3"] = shader_uniform_vec3, ["shader-uniform-vec4"] = shader_uniform_vec4, ["shader-uniform-int"] = shader_uniform_int, ["shader-uniform-ivec2"] = shader_uniform_ivec2, ["shader-uniform-ivec3"] = shader_uniform_ivec3, ["shader-uniform-ivec4"] = shader_uniform_ivec4, ["shader-uniform-sampler2d"] = shader_uniform_sampler2d, ["shader-attrib-float"] = shader_attrib_float, ["shader-attrib-vec2"] = shader_attrib_vec2, ["shader-attrib-vec3"] = shader_attrib_vec3, ["shader-attrib-vec4"] = shader_attrib_vec4, ["pixelformat-uncompressed-grayscale"] = pixelformat_uncompressed_grayscale, ["pixelformat-uncompressed-gray-alpha"] = pixelformat_uncompressed_gray_alpha, ["pixelformat-uncompressed-r5g6b5"] = pixelformat_uncompressed_r5g6b5, ["pixelformat-uncompressed-r8g8b8"] = pixelformat_uncompressed_r8g8b8, ["pixelformat-uncompressed-r5g5b5a1"] = pixelformat_uncompressed_r5g5b5a1, ["pixelformat-uncompressed-r4g4b4a4"] = pixelformat_uncompressed_r4g4b4a4, ["pixelformat-uncompressed-r8g8b8a8"] = pixelformat_uncompressed_r8g8b8a8, ["pixelformat-uncompressed-r32"] = pixelformat_uncompressed_r32, ["pixelformat-uncompressed-r32g32b32"] = pixelformat_uncompressed_r32g32b32, ["pixelformat-uncompressed-r32g32b32a32"] = pixelformat_uncompressed_r32g32b32a32, ["pixelformat-uncompressed-r16"] = pixelformat_uncompressed_r16, ["pixelformat-uncompressed-r16g16b16"] = pixelformat_uncompressed_r16g16b16, ["pixelformat-uncompressed-r16g16b16a16"] = pixelformat_uncompressed_r16g16b16a16, ["pixelformat-compressed-dxt1-rgb"] = pixelformat_compressed_dxt1_rgb, ["pixelformat-compressed-dxt1-rgba"] = pixelformat_compressed_dxt1_rgba, ["pixelformat-compressed-dxt3-rgba"] = pixelformat_compressed_dxt3_rgba, ["pixelformat-compressed-dxt5-rgba"] = pixelformat_compressed_dxt5_rgba, ["pixelformat-compressed-etc1-rgb"] = pixelformat_compressed_etc1_rgb, ["pixelformat-compressed-etc2-rgb"] = pixelformat_compressed_etc2_rgb, ["pixelformat-compressed-etc2-eac-rgba"] = pixelformat_compressed_etc2_eac_rgba, ["pixelformat-compressed-pvrt-rgb"] = pixelformat_compressed_pvrt_rgb, ["pixelformat-compressed-pvrt-rgba"] = pixelformat_compressed_pvrt_rgba, ["pixelformat-compressed-astc-4x4-rgba"] = pixelformat_compressed_astc_4x4_rgba, ["pixelformat-compressed-astc-8x8-rgba"] = pixelformat_compressed_astc_8x8_rgba, ["texture-filter-point"] = texture_filter_point, ["texture-filter-bilinear"] = texture_filter_bilinear, ["texture-filter-trilinear"] = texture_filter_trilinear, ["texture-filter-anisotropic-4x"] = texture_filter_anisotropic_4x, ["texture-filter-anisotropic-8x"] = texture_filter_anisotropic_8x, ["texture-filter-anisotropic-16x"] = texture_filter_anisotropic_16x, ["texture-wrap-repeat"] = texture_wrap_repeat, ["texture-wrap-clamp"] = texture_wrap_clamp, ["texture-wrap-mirror-repeat"] = texture_wrap_mirror_repeat, ["texture-wrap-mirror-clamp"] = texture_wrap_mirror_clamp, ["cubemap-layout-auto-detect"] = cubemap_layout_auto_detect, ["cubemap-layout-line-vertical"] = cubemap_layout_line_vertical, ["cubemap-layout-line-horizontal"] = cubemap_layout_line_horizontal, ["cubemap-layout-cross-three-by-four"] = cubemap_layout_cross_three_by_four, ["cubemap-layout-cross-four-by-three"] = cubemap_layout_cross_four_by_three, ["font-default"] = font_default, ["font-bitmap"] = font_bitmap, ["font-sdf"] = font_sdf, ["blend-alpha"] = blend_alpha, ["blend-additive"] = blend_additive, ["blend-multiplied"] = blend_multiplied, ["blend-add-colors"] = blend_add_colors, ["blend-subtract-colors"] = blend_subtract_colors, ["blend-alpha-premultiply"] = blend_alpha_premultiply, ["blend-custom"] = blend_custom, ["blend-custom-separate"] = blend_custom_separate, ["gesture-none"] = gesture_none, ["gesture-tap"] = gesture_tap, ["gesture-doubletap"] = gesture_doubletap, ["gesture-hold"] = gesture_hold, ["gesture-drag"] = gesture_drag, ["gesture-swipe-right"] = gesture_swipe_right, ["gesture-swipe-left"] = gesture_swipe_left, ["gesture-swipe-up"] = gesture_swipe_up, ["gesture-swipe-down"] = gesture_swipe_down, ["gesture-pinch-in"] = gesture_pinch_in, ["gesture-pinch-out"] = gesture_pinch_out, ["camera-custom"] = camera_custom, ["camera-free"] = camera_free, ["camera-orbital"] = camera_orbital, ["camera-first-person"] = camera_first_person, ["camera-third-person"] = camera_third_person, ["camera-perspective"] = camera_perspective, ["camera-orthographic"] = camera_orthographic, ["npatch-nine-patch"] = npatch_nine_patch, ["npatch-three-patch-vertical"] = npatch_three_patch_vertical, ["npatch-three-patch-horizontal"] = npatch_three_patch_horizontal, ["init-window"] = init_window, ["close-window"] = close_window, ["window-should-close"] = window_should_close, ["is-window-ready"] = is_window_ready, ["is-window-fullscreen"] = is_window_fullscreen, ["is-window-hidden"] = is_window_hidden, ["is-window-minimized"] = is_window_minimized, ["is-window-maximized"] = is_window_maximized, ["is-window-focused"] = is_window_focused, ["is-window-resized"] = is_window_resized, ["is-window-state"] = is_window_state, ["set-window-state"] = set_window_state, ["clear-window-state"] = clear_window_state, ["toggle-fullscreen"] = toggle_fullscreen, ["toggle-borderless-windowed"] = toggle_borderless_windowed, ["maximize-window"] = maximize_window, ["minimize-window"] = minimize_window, ["restore-window"] = restore_window, ["set-window-icon"] = set_window_icon, ["set-window-icons"] = set_window_icons, ["set-window-title"] = set_window_title, ["set-window-position"] = set_window_position, ["set-window-monitor"] = set_window_monitor, ["set-window-min-size"] = set_window_min_size, ["set-window-max-size"] = set_window_max_size, ["set-window-size"] = set_window_size, ["set-window-opacity"] = set_window_opacity, ["set-window-focused"] = set_window_focused, ["get-window-handle"] = get_window_handle, ["get-screen-width"] = get_screen_width, ["get-screen-height"] = get_screen_height, ["get-render-width"] = get_render_width, ["get-render-height"] = get_render_height, ["get-monitor-count"] = get_monitor_count, ["get-current-monitor"] = get_current_monitor, ["get-monitor-position"] = get_monitor_position, ["get-monitor-width"] = get_monitor_width, ["get-monitor-height"] = get_monitor_height, ["get-monitor-physical-width"] = get_monitor_physical_width, ["get-monitor-physical-height"] = get_monitor_physical_height, ["get-monitor-refresh-rate"] = get_monitor_refresh_rate, ["get-window-position"] = get_window_position, ["get-window-scale-dpi"] = get_window_scale_dpi, ["get-monitor-name"] = get_monitor_name, ["set-clipboard-text"] = set_clipboard_text, ["get-clipboard-text"] = get_clipboard_text, ["get-clipboard-image"] = get_clipboard_image, ["enable-event-waiting"] = enable_event_waiting, ["disable-event-waiting"] = disable_event_waiting, ["show-cursor"] = show_cursor, ["hide-cursor"] = hide_cursor, ["is-cursor-hidden"] = is_cursor_hidden, ["enable-cursor"] = enable_cursor, ["disable-cursor"] = disable_cursor, ["is-cursor-on-screen"] = is_cursor_on_screen, ["clear-background"] = clear_background, ["begin-drawing"] = begin_drawing, ["end-drawing"] = end_drawing, ["begin-mode2d"] = begin_mode2d, ["end-mode2d"] = end_mode2d, ["begin-mode3d"] = begin_mode3d, ["end-mode3d"] = end_mode3d, ["begin-texture-mode"] = begin_texture_mode, ["end-texture-mode"] = end_texture_mode, ["begin-shader-mode"] = begin_shader_mode, ["end-shader-mode"] = end_shader_mode, ["begin-blend-mode"] = begin_blend_mode, ["end-blend-mode"] = end_blend_mode, ["begin-scissor-mode"] = begin_scissor_mode, ["end-scissor-mode"] = end_scissor_mode, ["begin-vr-stereo-mode"] = begin_vr_stereo_mode, ["end-vr-stereo-mode"] = end_vr_stereo_mode, ["load-vr-stereo-config"] = load_vr_stereo_config, ["unload-vr-stereo-config"] = unload_vr_stereo_config, ["load-shader"] = load_shader, ["load-shader-from-memory"] = load_shader_from_memory, ["is-shader-valid"] = is_shader_valid, ["get-shader-location"] = get_shader_location, ["get-shader-location-attrib"] = get_shader_location_attrib, ["set-shader-value"] = set_shader_value, ["set-shader-value-v"] = set_shader_value_v, ["set-shader-value-matrix"] = set_shader_value_matrix, ["set-shader-value-texture"] = set_shader_value_texture, ["unload-shader"] = unload_shader, ["get-screen-to-world-ray"] = get_screen_to_world_ray, ["get-screen-to-world-ray-ex"] = get_screen_to_world_ray_ex, ["get-world-to-screen"] = get_world_to_screen, ["get-world-to-screen-ex"] = get_world_to_screen_ex, ["get-world-to-screen2d"] = get_world_to_screen2d, ["get-screen-to-world2d"] = get_screen_to_world2d, ["get-camera-matrix"] = get_camera_matrix, ["get-camera-matrix2d"] = get_camera_matrix2d, ["set-target-fps"] = set_target_fps, ["get-frame-time"] = get_frame_time, ["get-time"] = get_time, ["get-fps"] = get_fps, ["swap-screen-buffer"] = swap_screen_buffer, ["poll-input-events"] = poll_input_events, ["wait-time"] = wait_time, ["set-random-seed"] = set_random_seed, ["get-random-value"] = get_random_value, ["load-random-sequence"] = load_random_sequence, ["unload-random-sequence"] = unload_random_sequence, ["take-screenshot"] = take_screenshot, ["set-config-flags"] = set_config_flags, ["open-url"] = open_url, ["trace-log"] = trace_log, ["set-trace-log-level"] = set_trace_log_level, ["mem-alloc"] = mem_alloc, ["mem-realloc"] = mem_realloc, ["mem-free"] = mem_free, ["set-trace-log-callback"] = set_trace_log_callback, ["set-load-file-data-callback"] = set_load_file_data_callback, ["set-save-file-data-callback"] = set_save_file_data_callback, ["set-load-file-text-callback"] = set_load_file_text_callback, ["set-save-file-text-callback"] = set_save_file_text_callback, ["load-file-data"] = load_file_data, ["unload-file-data"] = unload_file_data, ["save-file-data"] = save_file_data, ["export-data-as-code"] = export_data_as_code, ["load-file-text"] = load_file_text, ["unload-file-text"] = unload_file_text, ["save-file-text"] = save_file_text, ["file-exists"] = file_exists, ["directory-exists"] = directory_exists, ["is-file-extension"] = is_file_extension, ["get-file-length"] = get_file_length, ["get-file-extension"] = get_file_extension, ["get-file-name"] = get_file_name, ["get-file-name-without-ext"] = get_file_name_without_ext, ["get-directory-path"] = get_directory_path, ["get-prev-directory-path"] = get_prev_directory_path, ["get-working-directory"] = get_working_directory, ["get-application-directory"] = get_application_directory, ["make-directory"] = make_directory, ["change-directory"] = change_directory, ["is-path-file"] = is_path_file, ["is-file-name-valid"] = is_file_name_valid, ["load-directory-files"] = load_directory_files, ["load-directory-files-ex"] = load_directory_files_ex, ["unload-directory-files"] = unload_directory_files, ["is-file-dropped"] = is_file_dropped, ["load-dropped-files"] = load_dropped_files, ["unload-dropped-files"] = unload_dropped_files, ["get-file-mod-time"] = get_file_mod_time, ["compress-data"] = compress_data, ["decompress-data"] = decompress_data, ["encode-data-base64"] = encode_data_base64, ["decode-data-base64"] = decode_data_base64, ["compute-crc32"] = compute_crc32, ["compute-md5"] = compute_md5, ["compute-sha1"] = compute_sha1, ["load-automation-event-list"] = load_automation_event_list, ["unload-automation-event-list"] = unload_automation_event_list, ["export-automation-event-list"] = export_automation_event_list, ["set-automation-event-list"] = set_automation_event_list, ["set-automation-event-base-frame"] = set_automation_event_base_frame, ["start-automation-event-recording"] = start_automation_event_recording, ["stop-automation-event-recording"] = stop_automation_event_recording, ["play-automation-event"] = play_automation_event, ["is-key-pressed"] = is_key_pressed, ["is-key-pressed-repeat"] = is_key_pressed_repeat, ["is-key-down"] = is_key_down, ["is-key-released"] = is_key_released, ["is-key-up"] = is_key_up, ["get-key-pressed"] = get_key_pressed, ["get-char-pressed"] = get_char_pressed, ["set-exit-key"] = set_exit_key, ["is-gamepad-available"] = is_gamepad_available, ["get-gamepad-name"] = get_gamepad_name, ["is-gamepad-button-pressed"] = is_gamepad_button_pressed, ["is-gamepad-button-down"] = is_gamepad_button_down, ["is-gamepad-button-released"] = is_gamepad_button_released, ["is-gamepad-button-up"] = is_gamepad_button_up, ["get-gamepad-button-pressed"] = get_gamepad_button_pressed, ["get-gamepad-axis-count"] = get_gamepad_axis_count, ["get-gamepad-axis-movement"] = get_gamepad_axis_movement, ["set-gamepad-mappings"] = set_gamepad_mappings, ["set-gamepad-vibration"] = set_gamepad_vibration, ["is-mouse-button-pressed"] = is_mouse_button_pressed, ["is-mouse-button-down"] = is_mouse_button_down, ["is-mouse-button-released"] = is_mouse_button_released, ["is-mouse-button-up"] = is_mouse_button_up, ["get-mouse-x"] = get_mouse_x, ["get-mouse-y"] = get_mouse_y, ["get-mouse-position"] = get_mouse_position, ["get-mouse-delta"] = get_mouse_delta, ["set-mouse-position"] = set_mouse_position, ["set-mouse-offset"] = set_mouse_offset, ["set-mouse-scale"] = set_mouse_scale, ["get-mouse-wheel-move"] = get_mouse_wheel_move, ["get-mouse-wheel-move-v"] = get_mouse_wheel_move_v, ["set-mouse-cursor"] = set_mouse_cursor, ["get-touch-x"] = get_touch_x, ["get-touch-y"] = get_touch_y, ["get-touch-position"] = get_touch_position, ["get-touch-point-id"] = get_touch_point_id, ["get-touch-point-count"] = get_touch_point_count, ["set-gestures-enabled"] = set_gestures_enabled, ["is-gesture-detected"] = is_gesture_detected, ["get-gesture-detected"] = get_gesture_detected, ["get-gesture-hold-duration"] = get_gesture_hold_duration, ["get-gesture-drag-vector"] = get_gesture_drag_vector, ["get-gesture-drag-angle"] = get_gesture_drag_angle, ["get-gesture-pinch-vector"] = get_gesture_pinch_vector, ["get-gesture-pinch-angle"] = get_gesture_pinch_angle, ["update-camera"] = update_camera, ["update-camera-pro"] = update_camera_pro, ["set-shapes-texture"] = set_shapes_texture, ["get-shapes-texture"] = get_shapes_texture, ["get-shapes-texture-rectangle"] = get_shapes_texture_rectangle, ["draw-pixel"] = draw_pixel, ["draw-pixel-v"] = draw_pixel_v, ["draw-line"] = draw_line, ["draw-line-v"] = draw_line_v, ["draw-line-ex"] = draw_line_ex, ["draw-line-strip"] = draw_line_strip, ["draw-line-bezier"] = draw_line_bezier, ["draw-circle"] = draw_circle, ["draw-circle-sector"] = draw_circle_sector, ["draw-circle-sector-lines"] = draw_circle_sector_lines, ["draw-circle-gradient"] = draw_circle_gradient, ["draw-circle-v"] = draw_circle_v, ["draw-circle-lines"] = draw_circle_lines, ["draw-circle-lines-v"] = draw_circle_lines_v, ["draw-ellipse"] = draw_ellipse, ["draw-ellipse-lines"] = draw_ellipse_lines, ["draw-ring"] = draw_ring, ["draw-ring-lines"] = draw_ring_lines, ["draw-rectangle"] = draw_rectangle, ["draw-rectangle-v"] = draw_rectangle_v, ["draw-rectangle-rec"] = draw_rectangle_rec, ["draw-rectangle-pro"] = draw_rectangle_pro, ["draw-rectangle-gradient-v"] = draw_rectangle_gradient_v, ["draw-rectangle-gradient-h"] = draw_rectangle_gradient_h, ["draw-rectangle-gradient-ex"] = draw_rectangle_gradient_ex, ["draw-rectangle-lines"] = draw_rectangle_lines, ["draw-rectangle-lines-ex"] = draw_rectangle_lines_ex, ["draw-rectangle-rounded"] = draw_rectangle_rounded, ["draw-rectangle-rounded-lines"] = draw_rectangle_rounded_lines, ["draw-rectangle-rounded-lines-ex"] = draw_rectangle_rounded_lines_ex, ["draw-triangle"] = draw_triangle, ["draw-triangle-lines"] = draw_triangle_lines, ["draw-triangle-fan"] = draw_triangle_fan, ["draw-triangle-strip"] = draw_triangle_strip, ["draw-poly"] = draw_poly, ["draw-poly-lines"] = draw_poly_lines, ["draw-poly-lines-ex"] = draw_poly_lines_ex, ["draw-spline-linear"] = draw_spline_linear, ["draw-spline-basis"] = draw_spline_basis, ["draw-spline-catmull-rom"] = draw_spline_catmull_rom, ["draw-spline-bezier-quadratic"] = draw_spline_bezier_quadratic, ["draw-spline-bezier-cubic"] = draw_spline_bezier_cubic, ["draw-spline-segment-linear"] = draw_spline_segment_linear, ["draw-spline-segment-basis"] = draw_spline_segment_basis, ["draw-spline-segment-catmull-rom"] = draw_spline_segment_catmull_rom, ["draw-spline-segment-bezier-quadratic"] = draw_spline_segment_bezier_quadratic, ["draw-spline-segment-bezier-cubic"] = draw_spline_segment_bezier_cubic, ["get-spline-point-linear"] = get_spline_point_linear, ["get-spline-point-basis"] = get_spline_point_basis, ["get-spline-point-catmull-rom"] = get_spline_point_catmull_rom, ["get-spline-point-bezier-quad"] = get_spline_point_bezier_quad, ["get-spline-point-bezier-cubic"] = get_spline_point_bezier_cubic, ["check-collision-recs"] = check_collision_recs, ["check-collision-circles"] = check_collision_circles, ["check-collision-circle-rec"] = check_collision_circle_rec, ["check-collision-circle-line"] = check_collision_circle_line, ["check-collision-point-rec"] = check_collision_point_rec, ["check-collision-point-circle"] = check_collision_point_circle, ["check-collision-point-triangle"] = check_collision_point_triangle, ["check-collision-point-line"] = check_collision_point_line, ["check-collision-point-poly"] = check_collision_point_poly, ["check-collision-lines"] = check_collision_lines, ["get-collision-rec"] = get_collision_rec, ["load-image"] = load_image, ["load-image-raw"] = load_image_raw, ["load-image-anim"] = load_image_anim, ["load-image-anim-from-memory"] = load_image_anim_from_memory, ["load-image-from-memory"] = load_image_from_memory, ["load-image-from-texture"] = load_image_from_texture, ["load-image-from-screen"] = load_image_from_screen, ["is-image-valid"] = is_image_valid, ["unload-image"] = unload_image, ["export-image"] = export_image, ["export-image-to-memory"] = export_image_to_memory, ["export-image-as-code"] = export_image_as_code, ["gen-image-color"] = gen_image_color, ["gen-image-gradient-linear"] = gen_image_gradient_linear, ["gen-image-gradient-radial"] = gen_image_gradient_radial, ["gen-image-gradient-square"] = gen_image_gradient_square, ["gen-image-checked"] = gen_image_checked, ["gen-image-white-noise"] = gen_image_white_noise, ["gen-image-perlin-noise"] = gen_image_perlin_noise, ["gen-image-cellular"] = gen_image_cellular, ["gen-image-text"] = gen_image_text, ["image-copy"] = image_copy, ["image-from-image"] = image_from_image, ["image-from-channel"] = image_from_channel, ["image-text"] = image_text, ["image-text-ex"] = image_text_ex, ["image-format"] = image_format, ["image-to-pot"] = image_to_pot, ["image-crop"] = image_crop, ["image-alpha-crop"] = image_alpha_crop, ["image-alpha-clear"] = image_alpha_clear, ["image-alpha-mask"] = image_alpha_mask, ["image-alpha-premultiply"] = image_alpha_premultiply, ["image-blur-gaussian"] = image_blur_gaussian, ["image-kernel-convolution"] = image_kernel_convolution, ["image-resize"] = image_resize, ["image-resize-nn"] = image_resize_nn, ["image-resize-canvas"] = image_resize_canvas, ["image-mipmaps"] = image_mipmaps, ["image-dither"] = image_dither, ["image-flip-vertical"] = image_flip_vertical, ["image-flip-horizontal"] = image_flip_horizontal, ["image-rotate"] = image_rotate, ["image-rotate-cw"] = image_rotate_cw, ["image-rotate-ccw"] = image_rotate_ccw, ["image-color-tint"] = image_color_tint, ["image-color-invert"] = image_color_invert, ["image-color-grayscale"] = image_color_grayscale, ["image-color-contrast"] = image_color_contrast, ["image-color-brightness"] = image_color_brightness, ["image-color-replace"] = image_color_replace, ["load-image-colors"] = load_image_colors, ["load-image-palette"] = load_image_palette, ["unload-image-colors"] = unload_image_colors, ["unload-image-palette"] = unload_image_palette, ["get-image-alpha-border"] = get_image_alpha_border, ["get-image-color"] = get_image_color, ["image-clear-background"] = image_clear_background, ["image-draw-pixel"] = image_draw_pixel, ["image-draw-pixel-v"] = image_draw_pixel_v, ["image-draw-line"] = image_draw_line, ["image-draw-line-v"] = image_draw_line_v, ["image-draw-line-ex"] = image_draw_line_ex, ["image-draw-circle"] = image_draw_circle, ["image-draw-circle-v"] = image_draw_circle_v, ["image-draw-circle-lines"] = image_draw_circle_lines, ["image-draw-circle-lines-v"] = image_draw_circle_lines_v, ["image-draw-rectangle"] = image_draw_rectangle, ["image-draw-rectangle-v"] = image_draw_rectangle_v, ["image-draw-rectangle-rec"] = image_draw_rectangle_rec, ["image-draw-rectangle-lines"] = image_draw_rectangle_lines, ["image-draw-triangle"] = image_draw_triangle, ["image-draw-triangle-ex"] = image_draw_triangle_ex, ["image-draw-triangle-lines"] = image_draw_triangle_lines, ["image-draw-triangle-fan"] = image_draw_triangle_fan, ["image-draw-triangle-strip"] = image_draw_triangle_strip, ["image-draw"] = image_draw, ["image-draw-text"] = image_draw_text, ["image-draw-text-ex"] = image_draw_text_ex, ["load-texture"] = load_texture, ["load-texture-from-image"] = load_texture_from_image, ["load-texture-cubemap"] = load_texture_cubemap, ["load-render-texture"] = load_render_texture, ["is-texture-valid"] = is_texture_valid, ["unload-texture"] = unload_texture, ["is-render-texture-valid"] = is_render_texture_valid, ["unload-render-texture"] = unload_render_texture, ["update-texture"] = update_texture, ["update-texture-rec"] = update_texture_rec, ["gen-texture-mipmaps"] = gen_texture_mipmaps, ["set-texture-filter"] = set_texture_filter, ["set-texture-wrap"] = set_texture_wrap, ["draw-texture"] = draw_texture, ["draw-texture-v"] = draw_texture_v, ["draw-texture-ex"] = draw_texture_ex, ["draw-texture-rec"] = draw_texture_rec, ["draw-texture-pro"] = draw_texture_pro, ["draw-texture-npatch"] = draw_texture_npatch, ["color-is-equal"] = color_is_equal, fade = fade, ["color-to-int"] = color_to_int, ["color-normalize"] = color_normalize, ["color-from-normalized"] = color_from_normalized, ["color-to-hsv"] = color_to_hsv, ["color-from-hsv"] = color_from_hsv, ["color-tint"] = color_tint, ["color-brightness"] = color_brightness, ["color-contrast"] = color_contrast, ["color-alpha"] = color_alpha, ["color-alpha-blend"] = color_alpha_blend, ["color-lerp"] = color_lerp, ["get-color"] = get_color, ["get-pixel-color"] = get_pixel_color, ["set-pixel-color"] = set_pixel_color, ["get-pixel-data-size"] = get_pixel_data_size, ["get-font-default"] = get_font_default, ["load-font"] = load_font, ["load-font-ex"] = load_font_ex, ["load-font-from-image"] = load_font_from_image, ["load-font-from-memory"] = load_font_from_memory, ["is-font-valid"] = is_font_valid, ["load-font-data"] = load_font_data, ["gen-image-font-atlas"] = gen_image_font_atlas, ["unload-font-data"] = unload_font_data, ["unload-font"] = unload_font, ["export-font-as-code"] = export_font_as_code, ["draw-fps"] = draw_fps, ["draw-text"] = draw_text, ["draw-text-ex"] = draw_text_ex, ["draw-text-pro"] = draw_text_pro, ["draw-text-codepoint"] = draw_text_codepoint, ["draw-text-codepoints"] = draw_text_codepoints, ["set-text-line-spacing"] = set_text_line_spacing, ["measure-text"] = measure_text, ["measure-text-ex"] = measure_text_ex, ["get-glyph-index"] = get_glyph_index, ["get-glyph-info"] = get_glyph_info, ["get-glyph-atlas-rec"] = get_glyph_atlas_rec, ["load-utf8"] = load_utf8, ["unload-utf8"] = unload_utf8, ["load-codepoints"] = load_codepoints, ["unload-codepoints"] = unload_codepoints, ["get-codepoint-count"] = get_codepoint_count, ["get-codepoint"] = get_codepoint, ["get-codepoint-next"] = get_codepoint_next, ["get-codepoint-previous"] = get_codepoint_previous, ["codepoint-to-utf8"] = codepoint_to_utf8, ["text-copy"] = text_copy, ["text-is-equal"] = text_is_equal, ["text-length"] = text_length, ["text-format"] = text_format, ["text-subtext"] = text_subtext, ["text-replace"] = text_replace, ["text-insert"] = text_insert, ["text-join"] = text_join, ["text-split"] = text_split, ["text-append"] = text_append, ["text-find-index"] = text_find_index, ["text-to-upper"] = text_to_upper, ["text-to-lower"] = text_to_lower, ["text-to-pascal"] = text_to_pascal, ["text-to-snake"] = text_to_snake, ["text-to-camel"] = text_to_camel, ["text-to-integer"] = text_to_integer, ["text-to-float"] = text_to_float, ["draw-line3d"] = draw_line3d, ["draw-point3d"] = draw_point3d, ["draw-circle3d"] = draw_circle3d, ["draw-triangle3d"] = draw_triangle3d, ["draw-triangle-strip3d"] = draw_triangle_strip3d, ["draw-cube"] = draw_cube, ["draw-cube-v"] = draw_cube_v, ["draw-cube-wires"] = draw_cube_wires, ["draw-cube-wires-v"] = draw_cube_wires_v, ["draw-sphere"] = draw_sphere, ["draw-sphere-ex"] = draw_sphere_ex, ["draw-sphere-wires"] = draw_sphere_wires, ["draw-cylinder"] = draw_cylinder, ["draw-cylinder-ex"] = draw_cylinder_ex, ["draw-cylinder-wires"] = draw_cylinder_wires, ["draw-cylinder-wires-ex"] = draw_cylinder_wires_ex, ["draw-capsule"] = draw_capsule, ["draw-capsule-wires"] = draw_capsule_wires, ["draw-plane"] = draw_plane, ["draw-ray"] = draw_ray, ["draw-grid"] = draw_grid, ["load-model"] = load_model, ["load-model-from-mesh"] = load_model_from_mesh, ["is-model-valid"] = is_model_valid, ["unload-model"] = unload_model, ["get-model-bounding-box"] = get_model_bounding_box, ["draw-model"] = draw_model, ["draw-model-ex"] = draw_model_ex, ["draw-model-wires"] = draw_model_wires, ["draw-model-wires-ex"] = draw_model_wires_ex, ["draw-model-points"] = draw_model_points, ["draw-model-points-ex"] = draw_model_points_ex, ["draw-bounding-box"] = draw_bounding_box, ["draw-billboard"] = draw_billboard, ["draw-billboard-rec"] = draw_billboard_rec, ["draw-billboard-pro"] = draw_billboard_pro, ["upload-mesh"] = upload_mesh, ["update-mesh-buffer"] = update_mesh_buffer, ["unload-mesh"] = unload_mesh, ["draw-mesh"] = draw_mesh, ["draw-mesh-instanced"] = draw_mesh_instanced, ["get-mesh-bounding-box"] = get_mesh_bounding_box, ["gen-mesh-tangents"] = gen_mesh_tangents, ["export-mesh"] = export_mesh, ["export-mesh-as-code"] = export_mesh_as_code, ["gen-mesh-poly"] = gen_mesh_poly, ["gen-mesh-plane"] = gen_mesh_plane, ["gen-mesh-cube"] = gen_mesh_cube, ["gen-mesh-sphere"] = gen_mesh_sphere, ["gen-mesh-hemi-sphere"] = gen_mesh_hemi_sphere, ["gen-mesh-cylinder"] = gen_mesh_cylinder, ["gen-mesh-cone"] = gen_mesh_cone, ["gen-mesh-torus"] = gen_mesh_torus, ["gen-mesh-knot"] = gen_mesh_knot, ["gen-mesh-heightmap"] = gen_mesh_heightmap, ["gen-mesh-cubicmap"] = gen_mesh_cubicmap, ["load-materials"] = load_materials, ["load-material-default"] = load_material_default, ["is-material-valid"] = is_material_valid, ["unload-material"] = unload_material, ["set-material-texture"] = set_material_texture, ["set-model-mesh-material"] = set_model_mesh_material, ["load-model-animations"] = load_model_animations, ["update-model-animation"] = update_model_animation, ["update-model-animation-bones"] = update_model_animation_bones, ["unload-model-animation"] = unload_model_animation, ["unload-model-animations"] = unload_model_animations, ["is-model-animation-valid"] = is_model_animation_valid, ["check-collision-spheres"] = check_collision_spheres, ["check-collision-boxes"] = check_collision_boxes, ["check-collision-box-sphere"] = check_collision_box_sphere, ["get-ray-collision-sphere"] = get_ray_collision_sphere, ["get-ray-collision-box"] = get_ray_collision_box, ["get-ray-collision-mesh"] = get_ray_collision_mesh, ["get-ray-collision-triangle"] = get_ray_collision_triangle, ["get-ray-collision-quad"] = get_ray_collision_quad, ["init-audio-device"] = init_audio_device, ["close-audio-device"] = close_audio_device, ["is-audio-device-ready"] = is_audio_device_ready, ["set-master-volume"] = set_master_volume, ["get-master-volume"] = get_master_volume, ["load-wave"] = load_wave, ["load-wave-from-memory"] = load_wave_from_memory, ["is-wave-valid"] = is_wave_valid, ["load-sound"] = load_sound, ["load-sound-from-wave"] = load_sound_from_wave, ["load-sound-alias"] = load_sound_alias, ["is-sound-valid"] = is_sound_valid, ["update-sound"] = update_sound, ["unload-wave"] = unload_wave, ["unload-sound"] = unload_sound, ["unload-sound-alias"] = unload_sound_alias, ["export-wave"] = export_wave, ["export-wave-as-code"] = export_wave_as_code, ["play-sound"] = play_sound, ["stop-sound"] = stop_sound, ["pause-sound"] = pause_sound, ["resume-sound"] = resume_sound, ["is-sound-playing"] = is_sound_playing, ["set-sound-volume"] = set_sound_volume, ["set-sound-pitch"] = set_sound_pitch, ["set-sound-pan"] = set_sound_pan, ["wave-copy"] = wave_copy, ["wave-crop"] = wave_crop, ["wave-format"] = wave_format, ["load-wave-samples"] = load_wave_samples, ["unload-wave-samples"] = unload_wave_samples, ["load-music-stream"] = load_music_stream, ["load-music-stream-from-memory"] = load_music_stream_from_memory, ["is-music-valid"] = is_music_valid, ["unload-music-stream"] = unload_music_stream, ["play-music-stream"] = play_music_stream, ["is-music-stream-playing"] = is_music_stream_playing, ["update-music-stream"] = update_music_stream, ["stop-music-stream"] = stop_music_stream, ["pause-music-stream"] = pause_music_stream, ["resume-music-stream"] = resume_music_stream, ["seek-music-stream"] = seek_music_stream, ["set-music-volume"] = set_music_volume, ["set-music-pitch"] = set_music_pitch, ["set-music-pan"] = set_music_pan, ["get-music-time-length"] = get_music_time_length, ["get-music-time-played"] = get_music_time_played, ["load-audio-stream"] = load_audio_stream, ["is-audio-stream-valid"] = is_audio_stream_valid, ["unload-audio-stream"] = unload_audio_stream, ["update-audio-stream"] = update_audio_stream, ["is-audio-stream-processed"] = is_audio_stream_processed, ["play-audio-stream"] = play_audio_stream, ["pause-audio-stream"] = pause_audio_stream, ["resume-audio-stream"] = resume_audio_stream, ["is-audio-stream-playing"] = is_audio_stream_playing, ["stop-audio-stream"] = stop_audio_stream, ["set-audio-stream-volume"] = set_audio_stream_volume, ["set-audio-stream-pitch"] = set_audio_stream_pitch, ["set-audio-stream-pan"] = set_audio_stream_pan, ["set-audio-stream-buffer-size-default"] = set_audio_stream_buffer_size_default, ["set-audio-stream-callback"] = set_audio_stream_callback, ["attach-audio-stream-processor"] = attach_audio_stream_processor, ["detach-audio-stream-processor"] = detach_audio_stream_processor, ["attach-audio-mixed-processor"] = attach_audio_mixed_processor, ["detach-audio-mixed-processor"] = detach_audio_mixed_processor, raywhite = raywhite, lightgray = lightgray, maroon = maroon, darkblue = darkblue, darkgray = darkgray, yellow = yellow, gray = gray, gold = gold, orange = orange, pink = pink, red = red, green = green, lime = lime, darkgreen = darkgreen, skyblue = skyblue, blue = blue, purple = purple, violet = violet, darkpurple = darkpurple, beige = beige, brown = brown, darkbrown = darkbrown, white = white, black = black, blank = blank, magenta = magenta, rl = rl}
