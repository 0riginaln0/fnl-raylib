(print "RAYLIB STRUCT MODULE INIT")

(local ffi (require :ffi))

(local os ffi.os)

; (print os)
; (print "hey")

(local rl 
  (case os 
    :Windows (ffi.load :lib\raylib-5.5_win64_mingw-w64\lib\raylib.dll) 
    :Linux   (ffi.load :lib/raylib-5.5_linux_amd64/lib/libraylib.so)))

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

; Structures Definition
;----------------------------------------------------------------------------------
; Boolean type
; Vector2, 2 components
(local Vector2-mt {:__eq (fn [vec1 vec2] (and (= vec1.x vec2.x) (= vec1.y vec2.y)))})
(local Vector2-ctype (ffi.metatype :Vector2 Vector2-mt))
(fn Vector2 [x y] (Vector2-ctype x y))

; Vector3, 3 components
(local Vector3-mt {:__eq (fn [vec1 vec2] (and (= vec1.x vec2.x) 
                                              (= vec1.y vec2.y)
                                              (= vec1.z vec2.z)))})
(local Vector3-ctype (ffi.metatype :Vector2 Vector3-mt))
(fn Vector3 [x y z] (Vector3-ctype [x y z]))
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

{: Vector2
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
 : AutomationEventList}