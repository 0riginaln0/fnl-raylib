(print "INIT: Drawing, Vr, Shader, and others")

(local dll (require :lib.dll))
(local ffi (. dll :ffi))
(local rl (. dll :rl))

(ffi.cdef "
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
typedef void (*TraceLogCallback)(int logLevel, const char *text, va_list args);  // Logging: Redirect trace log messages

void SetTraceLogCallback(TraceLogCallback callback);         // Set custom trace log

typedef unsigned char *(*LoadFileDataCallback)(const char *fileName, int *dataSize);    // FileIO: Load binary data
void SetLoadFileDataCallback(LoadFileDataCallback callback); // Set custom file binary data loader

typedef bool (*SaveFileDataCallback)(const char *fileName, void *data, int dataSize);   // FileIO: Save binary data
void SetSaveFileDataCallback(SaveFileDataCallback callback); // Set custom file binary data saver

typedef char *(*LoadFileTextCallback)(const char *fileName);            // FileIO: Load text data
void SetLoadFileTextCallback(LoadFileTextCallback callback); // Set custom file text data loader

typedef bool (*SaveFileTextCallback)(const char *fileName, char *text); // FileIO: Save text data
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

")

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


{: clear-background
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
 : play-automation-event}