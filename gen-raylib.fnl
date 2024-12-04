
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
(assert (= rl nil) "Unknown OS. Sorry")


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