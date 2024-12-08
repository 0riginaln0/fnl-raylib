; raymath.h bindigs are placed here because they have the same struct typedefs as the struct module
; splitting up those two modules will produce "attempt to refedine" error
(print "LOAD: STRUCTS & MATH")

(local dll (require :lib.dll))
(local ffi (. dll :ffi))
(local rl (. dll :rl))

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

// Utils math
float Clamp(float value, float min, float max);                             // Clamp float value
float Lerp(float start, float end, float amount);                           // Calculate linear interpolation between two floats
float Normalize(float value, float start, float end);                       // Normalize input value within input range
float Remap(float value, float inputStart, float inputEnd, float outputStart, float outputEnd); // Remap input value within input range to output range
float Wrap(float value, float min, float max);                              // Wrap input value from min to max
int FloatEquals(float x, float y);                                          // Check whether two given floats are almost equal

// Vector2 math
Vector2 Vector2Zero(void);                                                  // Vector with components value 0.0f
Vector2 Vector2One(void);                                                   // Vector with components value 1.0f
Vector2 Vector2Add(Vector2 v1, Vector2 v2);                                 // Add two vectors (v1 + v2)
Vector2 Vector2AddValue(Vector2 v, float add);                              // Add vector and float value
Vector2 Vector2Subtract(Vector2 v1, Vector2 v2);                            // Subtract two vectors (v1 - v2)
Vector2 Vector2SubtractValue(Vector2 v, float sub);                         // Subtract vector by float value
float Vector2Length(Vector2 v);                                             // Calculate vector length
float Vector2LengthSqr(Vector2 v);                                          // Calculate vector square length
float Vector2DotProduct(Vector2 v1, Vector2 v2);                            // Calculate two vectors dot product
float Vector2Distance(Vector2 v1, Vector2 v2);                              // Calculate distance between two vectors
float Vector2DistanceSqr(Vector2 v1, Vector2 v2);                           // Calculate square distance between two vectors
float Vector2Angle(Vector2 v1, Vector2 v2);                                 // Calculate angle from two vectors
Vector2 Vector2Scale(Vector2 v, float scale);                               // Scale vector (multiply by value)
Vector2 Vector2Multiply(Vector2 v1, Vector2 v2);                            // Multiply vector by vector
Vector2 Vector2Negate(Vector2 v);                                           // Negate vector
Vector2 Vector2Divide(Vector2 v1, Vector2 v2);                              // Divide vector by vector
Vector2 Vector2Normalize(Vector2 v);                                        // Normalize provided vector
Vector2 Vector2Transform(Vector2 v, Matrix mat);                            // Transforms a Vector2 by a given Matrix
Vector2 Vector2Lerp(Vector2 v1, Vector2 v2, float amount);                  // Calculate linear interpolation between two vectors
Vector2 Vector2Reflect(Vector2 v, Vector2 normal);                          // Calculate reflected vector to normal
Vector2 Vector2Rotate(Vector2 v, float angle);                              // Rotate vector by angle
Vector2 Vector2MoveTowards(Vector2 v, Vector2 target, float maxDistance);   // Move Vector towards target
Vector2 Vector2Invert(Vector2 v);                                           // Invert the given vector
Vector2 Vector2Clamp(Vector2 v, Vector2 min, Vector2 max);                  // Clamp the components of the vector between min and max values specified by the given vectors
Vector2 Vector2ClampValue(Vector2 v, float min, float max);                 // Clamp the magnitude of the vector between two min and max values
int Vector2Equals(Vector2 p, Vector2 q);                                    // Check whether two given vectors are almost equal

// Vector3 math
Vector3 Vector3Zero(void);                                                  // Vector with components value 0.0f
Vector3 Vector3One(void);                                                   // Vector with components value 1.0f
Vector3 Vector3Add(Vector3 v1, Vector3 v2);                                 // Add two vectors
Vector3 Vector3AddValue(Vector3 v, float add);                              // Add vector and float value
Vector3 Vector3Subtract(Vector3 v1, Vector3 v2);                            // Subtract two vectors
Vector3 Vector3SubtractValue(Vector3 v, float sub);                         // Subtract vector by float value
Vector3 Vector3Scale(Vector3 v, float scalar);                              // Multiply vector by scalar
Vector3 Vector3Multiply(Vector3 v1, Vector3 v2);                            // Multiply vector by vector
Vector3 Vector3CrossProduct(Vector3 v1, Vector3 v2);                        // Calculate two vectors cross product
Vector3 Vector3Perpendicular(Vector3 v);                                    // Calculate one vector perpendicular vector
float Vector3Length(const Vector3 v);                                       // Calculate vector length
float Vector3LengthSqr(const Vector3 v);                                    // Calculate vector square length
float Vector3DotProduct(Vector3 v1, Vector3 v2);                            // Calculate two vectors dot product
float Vector3Distance(Vector3 v1, Vector3 v2);                              // Calculate distance between two vectors
float Vector3DistanceSqr(Vector3 v1, Vector3 v2);                           // Calculate square distance between two vectors
float Vector3Angle(Vector3 v1, Vector3 v2);                                 // Calculate angle between two vectors
Vector3 Vector3Negate(Vector3 v);                                           // Negate provided vector (invert direction)
Vector3 Vector3Divide(Vector3 v1, Vector3 v2);                              // Divide vector by vector
Vector3 Vector3Normalize(Vector3 v);                                        // Normalize provided vector
void Vector3OrthoNormalize(Vector3 *v1, Vector3 *v2);                       // Orthonormalize provided vectors Makes vectors normalized and orthogonal to each other Gram-Schmidt function implementation
Vector3 Vector3Transform(Vector3 v, Matrix mat);                            // Transforms a Vector3 by a given Matrix
Vector3 Vector3RotateByQuaternion(Vector3 v, Quaternion q);                 // Transform a vector by quaternion rotation
Vector3 Vector3RotateByAxisAngle(Vector3 v, Vector3 axis, float angle);     // Rotates a vector around an axis
Vector3 Vector3Lerp(Vector3 v1, Vector3 v2, float amount);                  // Calculate linear interpolation between two vectors
Vector3 Vector3Reflect(Vector3 v, Vector3 normal);                          // Calculate reflected vector to normal
Vector3 Vector3Min(Vector3 v1, Vector3 v2);                                 // Get min value for each pair of components
Vector3 Vector3Max(Vector3 v1, Vector3 v2);                                 // Get max value for each pair of components
Vector3 Vector3Barycenter(Vector3 p, Vector3 a, Vector3 b, Vector3 c);      // Compute barycenter coordinates (u, v, w) for point p with respect to triangle (a, b, c) NOTE: Assumes P is on the plane of the triangle
Vector3 Vector3Unproject(Vector3 source, Matrix projection, Matrix view);   // Projects a Vector3 from screen space into object space NOTE: We are avoiding calling other raymath functions despite available

typedef struct float3 {
    float v[3];
} float3;

float3 Vector3ToFloatV(Vector3 v);                                          // Get Vector3 as float array
Vector3 Vector3Invert(Vector3 v);                                           // Invert the given vector
Vector3 Vector3Clamp(Vector3 v, Vector3 min, Vector3 max);                  // Clamp the components of the vector between min and max values specified by the given vectors
Vector3 Vector3ClampValue(Vector3 v, float min, float max);                 // Clamp the magnitude of the vector between two values
int Vector3Equals(Vector3 p, Vector3 q);                                    // Check whether two given vectors are almost equal
Vector3 Vector3Refract(Vector3 v, Vector3 n, float r);                      // Compute the direction of a refracted ray where v specifies the normalized direction of the incoming ray, n specifies the normalized normal vector of the interface of two optical media, and r specifies the ratio of the refractive index of the medium from where the ray comes to the refractive index of the medium on the other side of the surface

// Matrix math
float MatrixDeterminant(Matrix mat);                                        // Compute matrix determinant
float MatrixTrace(Matrix mat);                                              // Get the trace of the matrix (sum of the values along the diagonal)
Matrix MatrixTranspose(Matrix mat);                                         // Transposes provided matrix
Matrix MatrixInvert(Matrix mat);                                            // Invert provided matrix
Matrix MatrixIdentity(void);                                                // Get identity matrix
Matrix MatrixAdd(Matrix left, Matrix right);                                // Add two matrices
Matrix MatrixSubtract(Matrix left, Matrix right);                           // Subtract two matrices (left - right)
Matrix MatrixMultiply(Matrix left, Matrix right);                           // Get two matrix multiplication NOTE: When multiplying matrices... the order matters!
Matrix MatrixTranslate(float x, float y, float z);                          // Get translation matrix
Matrix MatrixRotate(Vector3 axis, float angle);                             // Create rotation matrix from axis and angle NOTE: Angle should be provided in radians
Matrix MatrixRotateX(float angle);                                          // Get x-rotation matrix NOTE: Angle must be provided in radians
Matrix MatrixRotateY(float angle);                                          // Get y-rotation matrix NOTE: Angle must be provided in radians
Matrix MatrixRotateZ(float angle);                                          // Get z-rotation matrix NOTE: Angle must be provided in radians
Matrix MatrixRotateXYZ(Vector3 angle);                                      // Get xyz-rotation matrix NOTE: Angle must be provided in radians
Matrix MatrixRotateZYX(Vector3 angle);                                      // Get zyx-rotation matrix NOTE: Angle must be provided in radians
Matrix MatrixScale(float x, float y, float z);                              // Get scaling matrix
Matrix MatrixFrustum(double left, double right, double bottom, double top, double near, double far); // Get perspective projection matrix
Matrix MatrixPerspective(double fovy, double aspect, double near, double far); // Get perspective projection matrix NOTE: Fovy angle must be provided in radians
Matrix MatrixOrtho(double left, double right, double bottom, double top, double near, double far); // Get orthographic projection matrix
Matrix MatrixLookAt(Vector3 eye, Vector3 target, Vector3 up);               // Get camera look-at matrix (view matrix)

typedef struct float16 {
    float v[16];
} float16;
float16 MatrixToFloatV(Matrix mat);                                         // Get float array of matrix data

// Quaternion math
Quaternion QuaternionAdd(Quaternion q1, Quaternion q2);                     // Add two quaternions
Quaternion QuaternionAddValue(Quaternion q, float add);                     // Add quaternion and float value
Quaternion QuaternionSubtract(Quaternion q1, Quaternion q2);                // Subtract two quaternions
Quaternion QuaternionSubtractValue(Quaternion q, float sub);                // Subtract quaternion and float value
Quaternion QuaternionIdentity(void);                                        // Get identity quaternion
float QuaternionLength(Quaternion q);                                       // Computes the length of a quaternion
Quaternion QuaternionNormalize(Quaternion q);                               // Normalize provided quaternion
Quaternion QuaternionInvert(Quaternion q);                                  // Invert provided quaternion
Quaternion QuaternionMultiply(Quaternion q1, Quaternion q2);                // Calculate two quaternion multiplication
Quaternion QuaternionScale(Quaternion q, float mul);                        // Scale quaternion by float value
Quaternion QuaternionDivide(Quaternion q1, Quaternion q2);                  // Divide two quaternions
Quaternion QuaternionLerp(Quaternion q1, Quaternion q2, float amount);      // Calculate linear interpolation between two quaternions
Quaternion QuaternionNlerp(Quaternion q1, Quaternion q2, float amount);     // Calculate slerp-optimized interpolation between two quaternions
Quaternion QuaternionSlerp(Quaternion q1, Quaternion q2, float amount);     // Calculates spherical linear interpolation between two quaternions
Quaternion QuaternionFromVector3ToVector3(Vector3 from, Vector3 to);        // Calculate quaternion based on the rotation from one vector to another
Quaternion QuaternionFromMatrix(Matrix mat);                                // Get a quaternion for a given rotation matrix
Matrix QuaternionToMatrix(Quaternion q);                                    // Get a matrix for a given quaternion
Quaternion QuaternionFromAxisAngle(Vector3 axis, float angle);              // Get rotation quaternion for an angle and axis NOTE: Angle must be provided in radians
void QuaternionToAxisAngle(Quaternion q, Vector3 *outAxis, float *outAngle); // Get the rotation angle and axis for a given quaternion
Quaternion QuaternionFromEuler(float pitch, float yaw, float roll);         // Get the quaternion equivalent to Euler angles NOTE: Rotation order is ZYX
Vector3 QuaternionToEuler(Quaternion q);                                    // Get the Euler angles equivalent to quaternion (roll, pitch, yaw) NOTE: Angles are returned in a Vector3 struct in radians
Quaternion QuaternionTransform(Quaternion q, Matrix mat);                   // Transform a quaternion given a transformation matrix
int QuaternionEquals(Quaternion p, Quaternion q);                           // Check whether two given quaternions are almost equal

")


; Structures Definition
;----------------------------------------------------------------------------------
; Boolean type
; Vector2, 2 components
(fn Vector2 [x y] (ffi.new :Vector2 [x y]))
(local Vector2-mt
  {
   :__eq (fn [vec1 vec2] (= (rl.Vector2Equals vec1 vec2) 1))
   :__tostring (fn [vec] (.. "[x: " vec.x "\ty:" vec.y "]"))
   :__add (fn [vec1 vec2] (rl.Vector2Add vec1 vec2))
   :__sub (fn [vec1 vec2] (rl.Vector2Subtract vec1 vec2))
   :__mul (fn [vec1 vec2] (rl.Vector2Multiply vec1 vec2))
   :__div (fn [vec1 vec2] (rl.Vector2Divide vec1 vec2))
   :__unm (fn [vec] (rl.Vector2Negate vec))})
(local Vector2-ctype (ffi.metatype :Vector2 Vector2-mt))
(fn Vector2 [x y] (Vector2-ctype x y))



; Vector3, 3 components
(fn Vector3 [x y z] (ffi.new :Vector3 [x y z]))
(local Vector3-mt 
  {:__eq (fn [vec1 vec2] (= (rl.Vector3Equals vec1 vec2) 1))
   :__tostring (fn [vec] (.. "[x: " vec.x "\ty:" vec.y "\tz:" vec.z "]"))
   :__add (fn [vec1 vec2] (rl.Vector3Add vec1 vec2))
   :__sub (fn [vec1 vec2] (rl.Vector3Subtract vec1 vec2))
   :__mul (fn [vec1 vec2] (rl.Vector3Multiply vec1 vec2))
   :__div (fn [vec1 vec2] (rl.Vector3Divide vec1 vec2))
   :__unm (fn [vec] (rl.Vector3Negate vec))})
(local Vector3-ctype (ffi.metatype :Vector3 Vector3-mt))
(fn Vector3 [x y z] (Vector3-ctype x y z))

; Vector4, 4 components
(fn Vector4 [x y z w] (ffi.new :Vector3 [x y z w]))
(local Vector4-mt 
  {:__eq (fn [vec1 vec2] (and (= vec1.x vec2.x) (= vec1.y vec2.y) 
                              (= vec1.z vec2.z) (= vec1.w vec2.w)))
   :__tostring (fn [vec] (.. "[x: " vec.x "\ty:" vec.y "\tz:" vec.z "\tw: " vec.w "]"))})
(local Vector4-ctype (ffi.metatype :Vector4 Vector4-mt))
(fn Vector4 [x y z w] (Vector4-ctype [x y z w]))

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


; Utils math
(fn clamp [value min max]
  "Clamp float value"
  (rl.Clamp value min max))

(fn lerp [start end amount]
  "Calculate linear interpolation between two floats"
  (rl.Lerp start end amount))

(fn normalize [value start end]
  "Normalize input value within input range"
  (rl.Normalize value start end))

(fn remap [value input-start input-end output-start output-end]
  "Remap input value within input range to output range"
  (rl.Remap value input-start input-end output-start output-end))

(fn wrap [value min max]
  "Wrap input value from min to max"
  (rl.Wrap value min max))

(fn float-equals [x y]
  "Check whether two given floats are almost equal"
  (rl.FloatEquals x y))

;; Vector2 math
(fn vector2-zero []
  "Vector with components value 0.0f"
  (rl.Vector2Zero))

(fn vector2-one []
  "Vector with components value 1.0f"
  (rl.Vector2One))

(fn vector2-add [v1 v2]
  "Add two vectors (v1 + v2)"
  (rl.Vector2Add v1 v2))

(fn vector2-add-value [v add]
  "Add vector and float value"
  (rl.Vector2AddValue v add))

(fn vector2-subtract [v1 v2]
  "Subtract two vectors (v1 - v2)"
  (rl.Vector2Subtract v1 v2))

(fn vector2-subtract-value [v sub]
  "Subtract vector by float value"
  (rl.Vector2SubtractValue v sub))

(fn vector2-length [v]
  "Calculate vector length"
  (rl.Vector2Length v))

(fn vector2-length-sqr [v]
  "Calculate vector square length"
  (rl.Vector2LengthSqr v))

(fn vector2-dot-product [v1 v2]
  "Calculate two vectors dot product"
  (rl.Vector2DotProduct v1 v2))

(fn vector2-distance [v1 v2]
  "Calculate distance between two vectors"
  (rl.Vector2Distance v1 v2))

(fn vector2-distance-sqr [v1 v2]
  "Calculate square distance between two vectors"
  (rl.Vector2DistanceSqr v1 v2))

(fn vector2-angle [v1 v2]
  "Calculate angle from two vectors"
  (rl.Vector2Angle v1 v2))

(fn vector2-scale [v scale]
  "Scale vector (multiply by value)"
  (rl.Vector2Scale v scale))

(fn vector2-multiply [v1 v2]
  "Multiply vector by vector"
  (rl.Vector2Multiply v1 v2))

(fn vector2-negate [v]
  "Negate vector"
  (rl.Vector2Negate v))

(fn vector2-divide [v1 v2]
  "Divide vector by vector"
  (rl.Vector2Divide v1 v2))

(fn vector2-normalize [v]
  "Normalize provided vector"
  (rl.Vector2Normalize v))

(fn vector2-transform [v mat]
  "Transforms a Vector2 by a given Matrix"
  (rl.Vector2Transform v mat))

(fn vector2-lerp [v1 v2 amount]
  "Calculate linear interpolation between two vectors"
  (rl.Vector2Lerp v1 v2 amount))

(fn vector2-reflect [v normal]
  "Calculate reflected vector to normal"
  (rl.Vector2Reflect v normal))

(fn vector2-rotate [v angle]
  "Rotate vector by angle"
  (rl.Vector2Rotate v angle))

(fn vector2-move-towards [v target max-distance]
  "Move Vector towards target"
  (rl.Vector2MoveTowards v target max-distance))

(fn vector2-invert [v]
  "Invert the given vector"
  (rl.Vector2Invert v))

(fn vector2-clamp [v min max]
  "Clamp the components of the vector between min and max values specified by the given vectors"
  (rl.Vector2Clamp v min max))

(fn vector2-clamp-value [v min max]
  "Clamp the magnitude of the vector between two min and max values"
  (rl.Vector2ClampValue v min max))

(fn vector2-equals [p q]
  "Check whether two given vectors are almost equal"
  (rl.Vector2Equals p q))

;; Vector3 math
(fn vector3-zero []
  "Vector with components value 0.0f"
  (rl.Vector3Zero))

(fn vector3-one []
  "Vector with components value 1.0f"
  (rl.Vector3One))

(fn vector3-add [v1 v2]
  "Add two vectors"
  (rl.Vector3Add v1 v2))

(fn vector3-add-value [v add]
  "Add vector and float value"
  (rl.Vector3AddValue v add))

(fn vector3-subtract [v1 v2]
  "Subtract two vectors"
  (rl.Vector3Subtract v1 v2))

(fn vector3-subtract-value [v sub]
  "Subtract vector by float value"
  (rl.Vector3SubtractValue v sub))

(fn vector3-scale [v scalar]
  "Multiply vector by scalar"
  (rl.Vector3Scale v scalar))

(fn vector3-multiply [v1 v2]
  "Multiply vector by vector"
  (rl.Vector3Multiply v1 v2))

(fn vector3-cross-product [v1 v2]
  "Calculate two vectors cross product"
  (rl.Vector3CrossProduct v1 v2))

(fn vector3-perpendicular [v]
  "Calculate one vector perpendicular vector"
  (rl.Vector3Perpendicular v))

(fn vector3-length [v]
  "Calculate vector length"
  (rl.Vector3Length v))

(fn vector3-length-sqr [v]
  "Calculate vector square length"
  (rl.Vector3LengthSqr v))

(fn vector3-dot-product [v1 v2]
  "Calculate two vectors dot product"
  (rl.Vector3DotProduct v1 v2))

(fn vector3-distance [v1 v2]
  "Calculate distance between two vectors"
  (rl.Vector3Distance v1 v2))

(fn vector3-distance-sqr [v1 v2]
  "Calculate square distance between two vectors"
  (rl.Vector3DistanceSqr v1 v2))

(fn vector3-angle [v1 v2]
  "Calculate angle between two vectors"
  (rl.Vector3Angle v1 v2))

(fn vector3-negate [v]
  "Negate provided vector (invert direction)"
  (rl.Vector3Negate v))

(fn vector3-divide [v1 v2]
  "Divide vector by vector"
  (rl.Vector3Divide v1 v2))

(fn vector3-normalize [v]
  "Normalize provided vector"
  (rl.Vector3Normalize v))

(fn vector3-ortho-normalize [v1 v2]
  "Orthonormalize provided vectors Makes vectors normalized and orthogonal to each other Gram-Schmidt function implementation"
  (rl.Vector3OrthoNormalize v1 v2))

(fn vector3-transform [v mat]
  "Transforms a Vector3 by a given Matrix"
  (rl.Vector3Transform v mat))

(fn vector3-rotate-by-quaternion [v q]
  "Transform a vector by quaternion rotation"
  (rl.Vector3RotateByQuaternion v q))

(fn vector3-rotate-by-axis-angle [v axis angle]
  "Rotates a vector around an axis"
  (rl.Vector3RotateByAxisAngle v axis angle))

(fn vector3-lerp [v1 v2 amount]
  "Calculate linear interpolation between two vectors"
  (rl.Vector3Lerp v1 v2 amount))

(fn vector3-reflect [v normal]
  "Calculate reflected vector to normal"
  (rl.Vector3Reflect v normal))

(fn vector3-min [v1 v2]
  "Get min value for each pair of components"
  (rl.Vector3Min v1 v2))

(fn vector3-max [v1 v2]
  "Get max value for each pair of components"
  (rl.Vector3Max v1 v2))

(fn vector3-barycenter [p a b c]
  "Compute barycenter coordinates (u, v, w) for point p with respect to triangle (a, b, c) NOTE: Assumes P is on the plane of the triangle"
  (rl.Vector3Barycenter p a b c))

(fn vector3-unproject [source projection view]
  "Projects a Vector3 from screen space into object space NOTE: We are avoiding calling other raymath functions despite available"
  (rl.Vector3Unproject source projection view))

(fn vector3-to-float-v [v]
  "Get Vector3 as float array"
  (rl.Vector3ToFloatV v))

(fn vector3-invert [v]
  "Invert the given vector"
  (rl.Vector3Invert v))

(fn vector3-clamp [v min max]
  "Clamp the components of the vector between min and max values specified by the given vectors"
  (rl.Vector3Clamp v min max))

(fn vector3-clamp-value [v min max]
  "Clamp the magnitude of the vector between two values"
  (rl.Vector3ClampValue v min max))

(fn vector3-equals [p q]
  "Check whether two given vectors are almost equal"
  (rl.Vector3Equals p q))

(fn vector3-refract [v n r]
  "Compute the direction of a refracted ray where v specifies the normalized direction of the incoming ray, n specifies the normalized normal vector of the interface of two optical media, and r specifies the ratio of the refractive index of the medium from where the ray comes to the refractive index of the medium on the other side of the surface"
  (rl.Vector3Refract v n r))

;; Matrix math
(fn matrix-determinant [mat]
  "Compute matrix determinant"
  (rl.MatrixDeterminant mat))

(fn matrix-trace [mat]
  "Get the trace of the matrix (sum of the values along the diagonal)"
  (rl.MatrixTrace mat))

(fn matrix-transpose [mat]
  "Transposes provided matrix"
  (rl.MatrixTranspose mat))

(fn matrix-invert [mat]
  "Invert provided matrix"
  (rl.MatrixInvert mat))

(fn matrix-identity []
  "Get identity matrix"
  (rl.MatrixIdentity))

(fn matrix-add [left right]
  "Add two matrices"
  (rl.MatrixAdd left right))

(fn matrix-subtract [left right]
  "Subtract two matrices (left - right)"
  (rl.MatrixSubtract left right))

(fn matrix-multiply [left right]
  "Get two matrix multiplication NOTE: When multiplying matrices... the order matters!"
  (rl.MatrixMultiply left right))

(fn matrix-translate [x y z]
  "Get translation matrix"
  (rl.MatrixTranslate x y z))

(fn matrix-rotate [axis angle]
  "Create rotation matrix from axis and angle NOTE: Angle should be provided in radians"
  (rl.MatrixRotate axis angle))

(fn matrix-rotate-x [angle]
  "Get x-rotation matrix NOTE: Angle must be provided in radians"
  (rl.MatrixRotateX angle))

(fn matrix-rotate-y [angle]
  "Get y-rotation matrix NOTE: Angle must be provided in radians"
  (rl.MatrixRotateY angle))

(fn matrix-rotate-z [angle]
  "Get z-rotation matrix NOTE: Angle must be provided in radians"
  (rl.MatrixRotateZ angle))

(fn matrix-rotate-xyz [angle]
  "Get xyz-rotation matrix NOTE: Angle must be provided in radians"
  (rl.MatrixRotateXYZ angle))

(fn matrix-rotate-zyx [angle]
  "Get zyx-rotation matrix NOTE: Angle must be provided in radians"
  (rl.MatrixRotateZYX angle))

(fn matrix-scale [x y z]
  "Get scaling matrix"
  (rl.MatrixScale x y z))

(fn matrix-frustum [left right bottom top near far]
  "Get perspective projection matrix"
  (rl.MatrixFrustum left right bottom top near far))

(fn matrix-perspective [fovy aspect near far]
  "Get perspective projection matrix NOTE: Fovy angle must be provided in radians"
  (rl.MatrixPerspective fovy aspect near far))

(fn matrix-ortho [left right bottom top near far]
  "Get orthographic projection matrix"
  (rl.MatrixOrtho left right bottom top near far))

(fn matrix-look-at [eye target up]
  "Get camera look-at matrix (view matrix)"
  (rl.MatrixLookAt eye target up))

(fn matrix-to-float-v [mat]
  "Get float array of matrix data"
  (rl.MatrixToFloatV mat))

;; Quaternion math
(fn quaternion-add [q1 q2]
  "Add two quaternions"
  (rl.QuaternionAdd q1 q2))

(fn quaternion-add-value [q add]
  "Add quaternion and float value"
  (rl.QuaternionAddValue q add))

(fn quaternion-subtract [q1 q2]
  "Subtract two quaternions"
  (rl.QuaternionSubtract q1 q2))

(fn quaternion-subtract-value [q sub]
  "Subtract quaternion and float value"
  (rl.QuaternionSubtractValue q sub))

(fn quaternion-identity []
  "Get identity quaternion"
  (rl.QuaternionIdentity))

(fn quaternion-length [q]
  "Computes the length of a quaternion"
  (rl.QuaternionLength q))

(fn quaternion-normalize [q]
  "Normalize provided quaternion"
  (rl.QuaternionNormalize q))

(fn quaternion-invert [q]
  "Invert provided quaternion"
  (rl.QuaternionInvert q))

(fn quaternion-multiply [q1 q2]
  "Calculate two quaternion multiplication"
  (rl.QuaternionMultiply q1 q2))

(fn quaternion-scale [q mul]
  "Scale quaternion by float value"
  (rl.QuaternionScale q mul))

(fn quaternion-divide [q1 q2]
  "Divide two quaternions"
  (rl.QuaternionDivide q1 q2))

(fn quaternion-lerp [q1 q2 amount]
  "Calculate linear interpolation between two quaternions"
  (rl.QuaternionLerp q1 q2 amount))

(fn quaternion-nlerp [q1 q2 amount]
  "Calculate slerp-optimized interpolation between two quaternions"
  (rl.QuaternionNlerp q1 q2 amount))

(fn quaternion-slerp [q1 q2 amount]
  "Calculates spherical linear interpolation between two quaternions"
  (rl.QuaternionSlerp q1 q2 amount))

(fn quaternion-from-vector3-to-vector3 [from to]
  "Calculate quaternion based on the rotation from one vector to another"
  (rl.QuaternionFromVector3ToVector3 from to))

(fn quaternion-from-matrix [mat]
  "Get a quaternion for a given rotation matrix"
  (rl.QuaternionFromMatrix mat))

(fn quaternion-to-matrix [q]
  "Get a matrix for a given quaternion"
  (rl.QuaternionToMatrix q))

(fn quaternion-from-axis-angle [axis angle]
  "Get rotation quaternion for an angle and axis NOTE: Angle must be provided in radians"
  (rl.QuaternionFromAxisAngle axis angle))

(fn quaternion-to-axis-angle [q out-axis out-angle]
  "Get the rotation angle and axis for a given quaternion"
  (rl.QuaternionToAxisAngle q out-axis out-angle))

(fn quaternion-from-euler [pitch yaw roll]
  "Get the quaternion equivalent to Euler angles NOTE: Rotation order is ZYX"
  (rl.QuaternionFromEuler pitch yaw roll))

(fn quaternion-to-euler [q]
  "Get the Euler angles equivalent to quaternion (roll, pitch, yaw) NOTE: Angles are returned in a Vector3 struct in radians"
  (rl.QuaternionToEuler q))

(fn quaternion-transform [q mat]
  "Transform a quaternion given a transformation matrix"
  (rl.QuaternionTransform q mat))

(fn quaternion-equals [p q]
  "Check whether two given quaternions are almost equal"
  (rl.QuaternionEquals p q))



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
 : AutomationEventList
 : clamp
 : lerp
 : normalize
 : remap
 : wrap
 : float-equals
 : vector2-zero
 : vector2-one
 : vector2-add
 : vector2-add-value
 : vector2-subtract
 : vector2-subtract-value
 : vector2-length
 : vector2-length-sqr
 : vector2-dot-product
 : vector2-distance
 : vector2-distance-sqr
 : vector2-angle
 : vector2-scale
 : vector2-multiply
 : vector2-negate
 : vector2-divide
 : vector2-normalize
 : vector2-transform
 : vector2-lerp
 : vector2-reflect
 : vector2-rotate
 : vector2-move-towards
 : vector2-invert
 : vector2-clamp
 : vector2-clamp-value
 : vector2-equals
 : vector3-zero
 : vector3-one
 : vector3-add
 : vector3-add-value
 : vector3-subtract
 : vector3-subtract-value
 : vector3-scale
 : vector3-multiply
 : vector3-cross-product
 : vector3-perpendicular
 : vector3-length
 : vector3-length-sqr
 : vector3-dot-product
 : vector3-distance
 : vector3-distance-sqr
 : vector3-angle
 : vector3-negate
 : vector3-divide
 : vector3-normalize
 : vector3-ortho-normalize
 : vector3-transform
 : vector3-rotate-by-quaternion
 : vector3-rotate-by-axis-angle
 : vector3-lerp
 : vector3-reflect
 : vector3-min
 : vector3-max
 : vector3-barycenter
 : vector3-unproject
 : vector3-to-float-v
 : vector3-invert
 : vector3-clamp
 : vector3-clamp-value
 : vector3-equals
 : vector3-refract
 : matrix-determinant
 : matrix-trace
 : matrix-transpose
 : matrix-invert
 : matrix-identity
 : matrix-add
 : matrix-subtract
 : matrix-multiply
 : matrix-translate
 : matrix-rotate
 : matrix-rotate-x
 : matrix-rotate-y
 : matrix-rotate-z
 : matrix-rotate-xyz
 : matrix-rotate-zyx
 : matrix-scale
 : matrix-frustum
 : matrix-perspective
 : matrix-ortho
 : matrix-look-at
 : matrix-to-float-v
 : quaternion-add
 : quaternion-add-value
 : quaternion-subtract
 : quaternion-subtract-value
 : quaternion-identity
 : quaternion-length
 : quaternion-normalize
 : quaternion-invert
 : quaternion-multiply
 : quaternion-scale
 : quaternion-divide
 : quaternion-lerp
 : quaternion-nlerp
 : quaternion-slerp
 : quaternion-from-vector3-to-vector3
 : quaternion-from-matrix
 : quaternion-to-matrix
 : quaternion-from-axis-angle
 : quaternion-to-axis-angle
 : quaternion-from-euler
 : quaternion-to-euler
 : quaternion-transform
 : quaternion-equals}