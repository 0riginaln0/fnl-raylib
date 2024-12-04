print("RAYLIB Drawing Vr Shader Screenspace and others MODULE INIT")
local ffi = require("ffi")
local os = ffi.os
local rl
if (os == "Windows") then
  rl = ffi.load("lib\\raylib-5.5_win64_mingw-w64\\lib\\raylib.dll")
elseif (os == "Linux") then
  rl = ffi.load("lib/raylib-5.5_linux_amd64/lib/libraylib.so")
else
  rl = nil
end
ffi.cdef("\nvoid ClearBackground(Color color);                          // Set background color (framebuffer clear color)\n\nvoid BeginDrawing(void);                                    // Setup canvas (framebuffer) to start drawing\n\nvoid EndDrawing(void);                                      // End canvas drawing and swap buffers (double buffering)\n\nvoid BeginMode2D(Camera2D camera);                          // Begin 2D mode with custom camera (2D)\n\nvoid EndMode2D(void);                                       // Ends 2D mode with custom camera\n\nvoid BeginMode3D(Camera3D camera);                          // Begin 3D mode with custom camera (3D)\n\nvoid EndMode3D(void);                                       // Ends 3D mode and returns to default 2D orthographic mode\n\nvoid BeginTextureMode(RenderTexture2D target);              // Begin drawing to render texture\n\nvoid EndTextureMode(void);                                  // Ends drawing to render texture\n\nvoid BeginShaderMode(Shader shader);                        // Begin custom shader drawing\n\nvoid EndShaderMode(void);                                   // End custom shader drawing (use default shader)\n\nvoid BeginBlendMode(int mode);                              // Begin blending mode (alpha, additive, multiplied, subtract, custom)\n\nvoid EndBlendMode(void);                                    // End blending mode (reset to default: alpha blending)\n\nvoid BeginScissorMode(int x, int y, int width, int height); // Begin scissor mode (define screen area for following drawing)\n\nvoid EndScissorMode(void);                                  // End scissor mode\n\nvoid BeginVrStereoMode(VrStereoConfig config);              // Begin stereo rendering (requires VR simulator)\n\nvoid EndVrStereoMode(void);                                 // End stereo rendering (requires VR simulator)\n\nVrStereoConfig LoadVrStereoConfig(VrDeviceInfo device);     // Load VR stereo config for VR simulator device parameters\n\nvoid UnloadVrStereoConfig(VrStereoConfig config);           // Unload VR stereo config\n\nShader LoadShader(const char *vsFileName, const char *fsFileName);   // Load shader from files and bind default locations\n\nShader LoadShaderFromMemory(const char *vsCode, const char *fsCode); // Load shader from code strings and bind default locations\n\nbool IsShaderValid(Shader shader);                                   // Check if a shader is valid (loaded on GPU)\n\nint GetShaderLocation(Shader shader, const char *uniformName);       // Get shader uniform location\n\nint GetShaderLocationAttrib(Shader shader, const char *attribName);  // Get shader attribute location\n\nvoid SetShaderValue(Shader shader, int locIndex, const void *value, int uniformType);               // Set shader uniform value\n\nvoid SetShaderValueV(Shader shader, int locIndex, const void *value, int uniformType, int count);   // Set shader uniform value vector\n\nvoid SetShaderValueMatrix(Shader shader, int locIndex, Matrix mat);         // Set shader uniform value (matrix 4x4)\n\nvoid SetShaderValueTexture(Shader shader, int locIndex, Texture2D texture); // Set shader uniform value for texture (sampler2d)\n\nvoid UnloadShader(Shader shader);                                    // Unload shader from GPU memory (VRAM)\n\nRay GetScreenToWorldRay(Vector2 position, Camera camera);         // Get a ray trace from screen position (i.e mouse)\n\nRay GetScreenToWorldRayEx(Vector2 position, Camera camera, int width, int height); // Get a ray trace from screen position (i.e mouse) in a viewport\n\nVector2 GetWorldToScreen(Vector3 position, Camera camera);        // Get the screen space position for a 3d world space position\n\nVector2 GetWorldToScreenEx(Vector3 position, Camera camera, int width, int height); // Get size position for a 3d world space position\n\nVector2 GetWorldToScreen2D(Vector2 position, Camera2D camera);    // Get the screen space position for a 2d camera world space position\n\nVector2 GetScreenToWorld2D(Vector2 position, Camera2D camera);    // Get the world space position for a 2d camera screen space position\n\nMatrix GetCameraMatrix(Camera camera);                            // Get camera transform matrix (view matrix)\n\nMatrix GetCameraMatrix2D(Camera2D camera);                        // Get camera 2d transform matrix\n\nvoid SetTargetFPS(int fps);                                 // Set target FPS (maximum)\n\nfloat GetFrameTime(void);                                   // Get time in seconds for last frame drawn (delta time)\n\ndouble GetTime(void);                                       // Get elapsed time in seconds since InitWindow()\n\nint GetFPS(void);                                           // Get current FPS\n\nvoid SwapScreenBuffer(void);                                // Swap back buffer with front buffer (screen drawing)\n\nvoid PollInputEvents(void);                                 // Register all input events\n\nvoid WaitTime(double seconds);                              // Wait for some time (halt program execution)\n\nvoid SetRandomSeed(unsigned int seed);                      // Set the seed for the random number generator\n\nint GetRandomValue(int min, int max);                       // Get a random value between min and max (both included)\n\nint *LoadRandomSequence(unsigned int count, int min, int max); // Load random values sequence, no values repeated\n\nvoid UnloadRandomSequence(int *sequence);                   // Unload random values sequence\n\nvoid TakeScreenshot(const char *fileName);                  // Takes a screenshot of current screen (filename extension defines format)\n\nvoid SetConfigFlags(unsigned int flags);                    // Setup init configuration flags (view FLAGS)\n\nvoid OpenURL(const char *url);                              // Open URL with default system browser (if available)\n\nvoid TraceLog(int logLevel, const char *text, ...);         // Show trace log messages (LOG_DEBUG, LOG_INFO, LOG_WARNING, LOG_ERROR...)\n\nvoid SetTraceLogLevel(int logLevel);                        // Set the current threshold (minimum) log level\n\nvoid *MemAlloc(unsigned int size);                          // Internal memory allocator\n\nvoid *MemRealloc(void *ptr, unsigned int size);             // Internal memory reallocator\n\nvoid MemFree(void *ptr);                                    // Internal memory free\ntypedef void (*TraceLogCallback)(int logLevel, const char *text, va_list args);  // Logging: Redirect trace log messages\n\nvoid SetTraceLogCallback(TraceLogCallback callback);         // Set custom trace log\n\ntypedef unsigned char *(*LoadFileDataCallback)(const char *fileName, int *dataSize);    // FileIO: Load binary data\nvoid SetLoadFileDataCallback(LoadFileDataCallback callback); // Set custom file binary data loader\n\ntypedef bool (*SaveFileDataCallback)(const char *fileName, void *data, int dataSize);   // FileIO: Save binary data\nvoid SetSaveFileDataCallback(SaveFileDataCallback callback); // Set custom file binary data saver\n\ntypedef char *(*LoadFileTextCallback)(const char *fileName);            // FileIO: Load text data\nvoid SetLoadFileTextCallback(LoadFileTextCallback callback); // Set custom file text data loader\n\ntypedef bool (*SaveFileTextCallback)(const char *fileName, char *text); // FileIO: Save text data\nvoid SetSaveFileTextCallback(SaveFileTextCallback callback); // Set custom file text data saver\n\nunsigned char *LoadFileData(const char *fileName, int *dataSize); // Load file data as byte array (read)\n\nvoid UnloadFileData(unsigned char *data);                   // Unload file data allocated by LoadFileData()\n\nbool SaveFileData(const char *fileName, void *data, int dataSize); // Save data to file from byte array (write), returns true on success\n\nbool ExportDataAsCode(const unsigned char *data, int dataSize, const char *fileName); // Export data to code (.h), returns true on success\n\nchar *LoadFileText(const char *fileName);                   // Load text data from file (read), returns a '\0' terminated string\n\nvoid UnloadFileText(char *text);                            // Unload file text data allocated by LoadFileText()\n\nbool SaveFileText(const char *fileName, char *text);        // Save text data to file (write), string must be '\0' terminated, returns true on success\n\nbool FileExists(const char *fileName);                      // Check if file exists\n\nbool DirectoryExists(const char *dirPath);                  // Check if a directory path exists\n\nbool IsFileExtension(const char *fileName, const char *ext); // Check file extension (including point: .png, .wav)\n\nint GetFileLength(const char *fileName);                    // Get file length in bytes (NOTE: GetFileSize() conflicts with windows.h)\n\nconst char *GetFileExtension(const char *fileName);         // Get pointer to extension for a filename string (includes dot: '.png')\n\nconst char *GetFileName(const char *filePath);              // Get pointer to filename for a path string\n\nconst char *GetFileNameWithoutExt(const char *filePath);    // Get filename string without extension (uses static string)\n\nconst char *GetDirectoryPath(const char *filePath);         // Get full path for a given fileName with path (uses static string)\n\nconst char *GetPrevDirectoryPath(const char *dirPath);      // Get previous directory path for a given path (uses static string)\n\nconst char *GetWorkingDirectory(void);                      // Get current working directory (uses static string)\n\nconst char *GetApplicationDirectory(void);                  // Get the directory of the running application (uses static string)\n\nint MakeDirectory(const char *dirPath);                     // Create directories (including full path requested), returns 0 on success\n\nbool ChangeDirectory(const char *dir);                      // Change working directory, return true on success\n\nbool IsPathFile(const char *path);                          // Check if a given path is a file or a directory\n\nbool IsFileNameValid(const char *fileName);                 // Check if fileName is valid for the platform/OS\n\nFilePathList LoadDirectoryFiles(const char *dirPath);       // Load directory filepaths\n\nFilePathList LoadDirectoryFilesEx(const char *basePath, const char *filter, bool scanSubdirs); // Load directory filepaths with extension filtering and recursive directory scan. Use 'DIR' in the filter string to include directories in the result\n\nvoid UnloadDirectoryFiles(FilePathList files);              // Unload filepaths\n\nbool IsFileDropped(void);                                   // Check if a file has been dropped into window\n\nFilePathList LoadDroppedFiles(void);                        // Load dropped filepaths\n\nvoid UnloadDroppedFiles(FilePathList files);                // Unload dropped filepaths\n\nlong GetFileModTime(const char *fileName);                  // Get file modification time (last write time)\n\nunsigned char *CompressData(const unsigned char *data, int dataSize, int *compDataSize);        // Compress data (DEFLATE algorithm), memory must be MemFree()\n\nunsigned char *DecompressData(const unsigned char *compData, int compDataSize, int *dataSize);  // Decompress data (DEFLATE algorithm), memory must be MemFree()\n\nchar *EncodeDataBase64(const unsigned char *data, int dataSize, int *outputSize);               // Encode data to Base64 string, memory must be MemFree()\n\nunsigned char *DecodeDataBase64(const unsigned char *data, int *outputSize);                    // Decode Base64 string data, memory must be MemFree()\n\nunsigned int ComputeCRC32(unsigned char *data, int dataSize);     // Compute CRC32 hash code\n\nunsigned int *ComputeMD5(unsigned char *data, int dataSize);      // Compute MD5 hash code, returns static int[4] (16 bytes)\n\nunsigned int *ComputeSHA1(unsigned char *data, int dataSize);      // Compute SHA1 hash code, returns static int[5] (20 bytes)\n\nAutomationEventList LoadAutomationEventList(const char *fileName);                // Load automation events list from file, NULL for empty list, capacity = MAX_AUTOMATION_EVENTS\n\nvoid UnloadAutomationEventList(AutomationEventList list);                         // Unload automation events list from file\n\nbool ExportAutomationEventList(AutomationEventList list, const char *fileName);   // Export automation events list as text file\n\nvoid SetAutomationEventList(AutomationEventList *list);                           // Set automation event list to record to\n\nvoid SetAutomationEventBaseFrame(int frame);                                      // Set automation event internal base frame to start recording\n\nvoid StartAutomationEventRecording(void);                                         // Start recording automation events (AutomationEventList must be set)\n\nvoid StopAutomationEventRecording(void);                                          // Stop recording automation events\n\nvoid PlayAutomationEvent(AutomationEvent event);                                  // Play a recorded automation event\n\n")
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
return {["clear-background"] = clear_background, ["begin-drawing"] = begin_drawing, ["end-drawing"] = end_drawing, ["begin-mode2d"] = begin_mode2d, ["end-mode2d"] = end_mode2d, ["begin-mode3d"] = begin_mode3d, ["end-mode3d"] = end_mode3d, ["begin-texture-mode"] = begin_texture_mode, ["end-texture-mode"] = end_texture_mode, ["begin-shader-mode"] = begin_shader_mode, ["end-shader-mode"] = end_shader_mode, ["begin-blend-mode"] = begin_blend_mode, ["end-blend-mode"] = end_blend_mode, ["begin-scissor-mode"] = begin_scissor_mode, ["end-scissor-mode"] = end_scissor_mode, ["begin-vr-stereo-mode"] = begin_vr_stereo_mode, ["end-vr-stereo-mode"] = end_vr_stereo_mode, ["load-vr-stereo-config"] = load_vr_stereo_config, ["unload-vr-stereo-config"] = unload_vr_stereo_config, ["load-shader"] = load_shader, ["load-shader-from-memory"] = load_shader_from_memory, ["is-shader-valid"] = is_shader_valid, ["get-shader-location"] = get_shader_location, ["get-shader-location-attrib"] = get_shader_location_attrib, ["set-shader-value"] = set_shader_value, ["set-shader-value-v"] = set_shader_value_v, ["set-shader-value-matrix"] = set_shader_value_matrix, ["set-shader-value-texture"] = set_shader_value_texture, ["unload-shader"] = unload_shader, ["get-screen-to-world-ray"] = get_screen_to_world_ray, ["get-screen-to-world-ray-ex"] = get_screen_to_world_ray_ex, ["get-world-to-screen"] = get_world_to_screen, ["get-world-to-screen-ex"] = get_world_to_screen_ex, ["get-world-to-screen2d"] = get_world_to_screen2d, ["get-screen-to-world2d"] = get_screen_to_world2d, ["get-camera-matrix"] = get_camera_matrix, ["get-camera-matrix2d"] = get_camera_matrix2d, ["set-target-fps"] = set_target_fps, ["get-frame-time"] = get_frame_time, ["get-time"] = get_time, ["get-fps"] = get_fps, ["swap-screen-buffer"] = swap_screen_buffer, ["poll-input-events"] = poll_input_events, ["wait-time"] = wait_time, ["set-random-seed"] = set_random_seed, ["get-random-value"] = get_random_value, ["load-random-sequence"] = load_random_sequence, ["unload-random-sequence"] = unload_random_sequence, ["take-screenshot"] = take_screenshot, ["set-config-flags"] = set_config_flags, ["open-url"] = open_url, ["trace-log"] = trace_log, ["set-trace-log-level"] = set_trace_log_level, ["mem-alloc"] = mem_alloc, ["mem-realloc"] = mem_realloc, ["mem-free"] = mem_free, ["set-trace-log-callback"] = set_trace_log_callback, ["set-load-file-data-callback"] = set_load_file_data_callback, ["set-save-file-data-callback"] = set_save_file_data_callback, ["set-load-file-text-callback"] = set_load_file_text_callback, ["set-save-file-text-callback"] = set_save_file_text_callback, ["load-file-data"] = load_file_data, ["unload-file-data"] = unload_file_data, ["save-file-data"] = save_file_data, ["export-data-as-code"] = export_data_as_code, ["load-file-text"] = load_file_text, ["unload-file-text"] = unload_file_text, ["save-file-text"] = save_file_text, ["file-exists"] = file_exists, ["directory-exists"] = directory_exists, ["is-file-extension"] = is_file_extension, ["get-file-length"] = get_file_length, ["get-file-extension"] = get_file_extension, ["get-file-name"] = get_file_name, ["get-file-name-without-ext"] = get_file_name_without_ext, ["get-directory-path"] = get_directory_path, ["get-prev-directory-path"] = get_prev_directory_path, ["get-working-directory"] = get_working_directory, ["get-application-directory"] = get_application_directory, ["make-directory"] = make_directory, ["change-directory"] = change_directory, ["is-path-file"] = is_path_file, ["is-file-name-valid"] = is_file_name_valid, ["load-directory-files"] = load_directory_files, ["load-directory-files-ex"] = load_directory_files_ex, ["unload-directory-files"] = unload_directory_files, ["is-file-dropped"] = is_file_dropped, ["load-dropped-files"] = load_dropped_files, ["unload-dropped-files"] = unload_dropped_files, ["get-file-mod-time"] = get_file_mod_time, ["compress-data"] = compress_data, ["decompress-data"] = decompress_data, ["encode-data-base64"] = encode_data_base64, ["decode-data-base64"] = decode_data_base64, ["compute-crc32"] = compute_crc32, ["compute-md5"] = compute_md5, ["compute-sha1"] = compute_sha1, ["load-automation-event-list"] = load_automation_event_list, ["unload-automation-event-list"] = unload_automation_event_list, ["export-automation-event-list"] = export_automation_event_list, ["set-automation-event-list"] = set_automation_event_list, ["set-automation-event-base-frame"] = set_automation_event_base_frame, ["start-automation-event-recording"] = start_automation_event_recording, ["stop-automation-event-recording"] = stop_automation_event_recording, ["play-automation-event"] = play_automation_event}
