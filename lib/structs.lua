print("RAYLIB STRUCT MODULE INIT")
local dll = require("lib.dll")
local ffi = dll.ffi
local rl = dll.rl
ffi.cdef("\13\ntypedef struct Vector2 {\13\n    float x;                // Vector x component\13\n    float y;                // Vector y component\13\n    } Vector2;\13\n\13\ntypedef struct Vector3 {\13\n    float x;                // Vector x component\13\n    float y;                // Vector y component\13\n    float z;                // Vector z component\13\n    } Vector3;\13\n\13\ntypedef struct Vector4 {\13\n    float x;                // Vector x component\13\n    float y;                // Vector y component\13\n    float z;                // Vector z component\13\n    float w;                // Vector w component\13\n    } Vector4;\13\n\13\ntypedef Vector4 Quaternion;\13\ntypedef struct Matrix {\13\n    float m0, m4, m8, m12;  // Matrix first row (4 components)\13\n    float m1, m5, m9, m13;  // Matrix second row (4 components)\13\n    float m2, m6, m10, m14; // Matrix third row (4 components)\13\n    float m3, m7, m11, m15; // Matrix fourth row (4 components)\13\n    } Matrix;\13\n\13\ntypedef struct Color {\13\n    unsigned char r;        // Color red value\13\n    unsigned char g;        // Color green value\13\n    unsigned char b;        // Color blue value\13\n    unsigned char a;        // Color alpha value\13\n    } Color;\13\n\13\ntypedef struct Rectangle {\13\n    float x;                // Rectangle top-left corner position x\13\n    float y;                // Rectangle top-left corner position y\13\n    float width;            // Rectangle width\13\n    float height;           // Rectangle height\13\n    } Rectangle;\13\n\13\ntypedef struct Image {\13\n    void *data;             // Image raw data\13\n    int width;              // Image base width\13\n    int height;             // Image base height\13\n    int mipmaps;            // Mipmap levels, 1 by default\13\n    int format;             // Data format (PixelFormat type)\13\n    } Image;\13\n\13\ntypedef struct Texture {\13\n    unsigned int id;        // OpenGL texture id\13\n    int width;              // Texture base width\13\n    int height;             // Texture base height\13\n    int mipmaps;            // Mipmap levels, 1 by default\13\n    int format;             // Data format (PixelFormat type)\13\n    } Texture;\13\n\13\ntypedef Texture Texture2D;\13\ntypedef Texture TextureCubemap;\13\ntypedef struct RenderTexture {\13\n    unsigned int id;        // OpenGL framebuffer object id\13\n    Texture texture;        // Color buffer attachment texture\13\n    Texture depth;          // Depth buffer attachment texture\13\n    } RenderTexture;\13\n\13\ntypedef RenderTexture RenderTexture2D;\13\ntypedef struct NPatchInfo {\13\n    Rectangle source;       // Texture source rectangle\13\n    int left;               // Left border offset\13\n    int top;                // Top border offset\13\n    int right;              // Right border offset\13\n    int bottom;             // Bottom border offset\13\n    int layout;             // Layout of the n-patch: 3x3, 1x3 or 3x1\13\n    } NPatchInfo;\13\n\13\ntypedef struct GlyphInfo {\13\n    int value;              // Character value (Unicode)\13\n    int offsetX;            // Character offset X when drawing\13\n    int offsetY;            // Character offset Y when drawing\13\n    int advanceX;           // Character advance position X\13\n    Image image;            // Character image data\13\n    } GlyphInfo;\13\n\13\ntypedef struct Font {\13\n    int baseSize;           // Base size (default chars height)\13\n    int glyphCount;         // Number of glyph characters\13\n    int glyphPadding;       // Padding around the glyph characters\13\n    Texture2D texture;      // Texture atlas containing the glyphs\13\n    Rectangle *recs;        // Rectangles in texture for the glyphs\13\n    GlyphInfo *glyphs;      // Glyphs info data\13\n    } Font;\13\n\13\ntypedef struct Camera3D {\13\n    Vector3 position;       // Camera position\13\n    Vector3 target;         // Camera target it looks-at\13\n    Vector3 up;             // Camera up vector (rotation over its axis)\13\n    float fovy;             // Camera field-of-view aperture in Y (degrees) in perspective, used as near plane width in orthographic\13\n    int projection;         // Camera projection: CAMERA_PERSPECTIVE or CAMERA_ORTHOGRAPHIC\13\n    } Camera3D;\13\n\13\ntypedef Camera3D Camera;    // Camera type fallback, defaults to Camera3D\13\ntypedef struct Camera2D {\13\n    Vector2 offset;         // Camera offset (displacement from target)\13\n    Vector2 target;         // Camera target (rotation and zoom origin)\13\n    float rotation;         // Camera rotation in degrees\13\n    float zoom;             // Camera zoom (scaling), should be 1.0f by default\13\n    } Camera2D;\13\n\13\ntypedef struct Mesh {\13\n    int vertexCount;        // Number of vertices stored in arrays\13\n    int triangleCount;      // Number of triangles stored (indexed or not)\13\n    \13\n    // Vertex attributes data\13\n    float *vertices;        // Vertex position (XYZ - 3 components per vertex) (shader-location = 0)\13\n    float *texcoords;       // Vertex texture coordinates (UV - 2 components per vertex) (shader-location = 1)\13\n    float *texcoords2;      // Vertex texture second coordinates (UV - 2 components per vertex) (shader-location = 5)\13\n    float *normals;         // Vertex normals (XYZ - 3 components per vertex) (shader-location = 2)\13\n    float *tangents;        // Vertex tangents (XYZW - 4 components per vertex) (shader-location = 4)\13\n    unsigned char *colors;      // Vertex colors (RGBA - 4 components per vertex) (shader-location = 3)\13\n    unsigned short *indices;    // Vertex indices (in case vertex data comes indexed)\13\n    \13\n    // Animation vertex data\13\n    float *animVertices;    // Animated vertex positions (after bones transformations)\13\n    float *animNormals;     // Animated normals (after bones transformations)\13\n    unsigned char *boneIds; // Vertex bone ids, max 255 bone ids, up to 4 bones influence by vertex (skinning) (shader-location = 6)\13\n    float *boneWeights;     // Vertex bone weight, up to 4 bones influence by vertex (skinning) (shader-location = 7)\13\n    Matrix *boneMatrices;   // Bones animated transformation matrices\13\n    int boneCount;          // Number of bones\13\n    \13\n    // OpenGL identifiers\13\n    unsigned int vaoId;     // OpenGL Vertex Array Object id\13\n    unsigned int *vboId;    // OpenGL Vertex Buffer Objects id (default vertex data)\13\n    } Mesh;\13\n\13\ntypedef struct Shader {\13\n    unsigned int id;        // Shader program id\13\n    int *locs;              // Shader locations array (RL_MAX_SHADER_LOCATIONS)\13\n    } Shader;\13\n\13\ntypedef struct MaterialMap {\13\n    Texture2D texture;      // Material map texture\13\n    Color color;            // Material map color\13\n    float value;            // Material map value\13\n    } MaterialMap;\13\n\13\ntypedef struct Material {\13\n    Shader shader;          // Material shader\13\n    MaterialMap *maps;      // Material maps array (MAX_MATERIAL_MAPS)\13\n    float params[4];        // Material generic parameters (if required)\13\n    } Material;\13\n\13\ntypedef struct Transform {\13\n    Vector3 translation;    // Translation\13\n    Quaternion rotation;    // Rotation\13\n    Vector3 scale;          // Scale\13\n    } Transform;\13\n\13\ntypedef struct BoneInfo {\13\n    char name[32];          // Bone name\13\n    int parent;             // Bone parent\13\n    } BoneInfo;\13\n\13\ntypedef struct Model {\13\n    Matrix transform;       // Local transform matrix\13\n    \13\n    int meshCount;          // Number of meshes\13\n    int materialCount;      // Number of materials\13\n    Mesh *meshes;           // Meshes array\13\n    Material *materials;    // Materials array\13\n    int *meshMaterial;      // Mesh material number\13\n    \13\n    // Animation data\13\n    int boneCount;          // Number of bones\13\n    BoneInfo *bones;        // Bones information (skeleton)\13\n    Transform *bindPose;    // Bones base transformation (pose)\13\n    } Model;\13\n\13\ntypedef struct ModelAnimation {\13\n    int boneCount;          // Number of bones\13\n    int frameCount;         // Number of animation frames\13\n    BoneInfo *bones;        // Bones information (skeleton)\13\n    Transform **framePoses; // Poses array by frame\13\n    char name[32];          // Animation name\13\n    } ModelAnimation;\13\n\13\ntypedef struct Ray {\13\n    Vector3 position;       // Ray position (origin)\13\n    Vector3 direction;      // Ray direction (normalized)\13\n    } Ray;\13\n\13\ntypedef struct RayCollision {\13\n    bool hit;               // Did the ray hit something?\13\n    float distance;         // Distance to the nearest hit\13\n    Vector3 point;          // Point of the nearest hit\13\n    Vector3 normal;         // Surface normal of hit\13\n    } RayCollision;\13\n\13\ntypedef struct BoundingBox {\13\n    Vector3 min;            // Minimum vertex box-corner\13\n    Vector3 max;            // Maximum vertex box-corner\13\n    } BoundingBox;\13\n\13\ntypedef struct Wave {\13\n    unsigned int frameCount;    // Total number of frames (considering channels)\13\n    unsigned int sampleRate;    // Frequency (samples per second)\13\n    unsigned int sampleSize;    // Bit depth (bits per sample): 8, 16, 32 (24 not supported)\13\n    unsigned int channels;      // Number of channels (1-mono, 2-stereo, ...)\13\n    void *data;                 // Buffer data pointer\13\n    } Wave;\13\n\13\ntypedef struct rAudioBuffer rAudioBuffer;\13\n    typedef struct rAudioProcessor rAudioProcessor;\13\n\13\ntypedef struct AudioStream {\13\n    rAudioBuffer *buffer;       // Pointer to internal data used by the audio system\13\n    rAudioProcessor *processor; // Pointer to internal data processor, useful for audio effects\13\n    \13\n    unsigned int sampleRate;    // Frequency (samples per second)\13\n    unsigned int sampleSize;    // Bit depth (bits per sample): 8, 16, 32 (24 not supported)\13\n    unsigned int channels;      // Number of channels (1-mono, 2-stereo, ...)\13\n    } AudioStream;\13\n\13\ntypedef struct Sound {\13\n    AudioStream stream;         // Audio stream\13\n    unsigned int frameCount;    // Total number of frames (considering channels)\13\n    } Sound;\13\n\13\ntypedef struct Music {\13\n    AudioStream stream;         // Audio stream\13\n    unsigned int frameCount;    // Total number of frames (considering channels)\13\n    bool looping;               // Music looping enable\13\n    \13\n    int ctxType;                // Type of music context (audio filetype)\13\n    void *ctxData;              // Audio context data, depends on type\13\n    } Music;\13\n\13\ntypedef struct VrDeviceInfo {\13\n    int hResolution;                // Horizontal resolution in pixels\13\n    int vResolution;                // Vertical resolution in pixels\13\n    float hScreenSize;              // Horizontal size in meters\13\n    float vScreenSize;              // Vertical size in meters\13\n    float eyeToScreenDistance;      // Distance between eye and display in meters\13\n    float lensSeparationDistance;   // Lens separation distance in meters\13\n    float interpupillaryDistance;   // IPD (distance between pupils) in meters\13\n    float lensDistortionValues[4];  // Lens distortion constant parameters\13\n    float chromaAbCorrection[4];    // Chromatic aberration correction parameters\13\n    } VrDeviceInfo;\13\n\13\ntypedef struct VrStereoConfig {\13\n    Matrix projection[2];           // VR projection matrices (per eye)\13\n    Matrix viewOffset[2];           // VR view offset matrices (per eye)\13\n    float leftLensCenter[2];        // VR left lens center\13\n    float rightLensCenter[2];       // VR right lens center\13\n    float leftScreenCenter[2];      // VR left screen center\13\n    float rightScreenCenter[2];     // VR right screen center\13\n    float scale[2];                 // VR distortion scale\13\n    float scaleIn[2];               // VR distortion scale in\13\n    } VrStereoConfig;\13\n\13\ntypedef struct FilePathList {\13\n    unsigned int capacity;          // Filepaths max entries\13\n    unsigned int count;             // Filepaths entries count\13\n    char **paths;                   // Filepaths entries\13\n    } FilePathList;\13\n\13\ntypedef struct AutomationEvent {\13\n    unsigned int frame;             // Event frame\13\n    unsigned int type;              // Event type (AutomationEventType)\13\n    int params[4];                  // Event parameters (if required)\13\n    } AutomationEvent;\13\n\13\ntypedef struct AutomationEventList {\13\n    unsigned int capacity;          // Events max entries (MAX_AUTOMATION_EVENTS)\13\n    unsigned int count;             // Events entries count\13\n    AutomationEvent *events;        // Events entries\13\n    } AutomationEventList;\13\n")
local function Vector2(x, y)
  return ffi.new("Vector2", {x, y})
end
local Vector2_mt
local function _1_(vec1, vec2)
  return ((vec1.x == vec2.x) and (vec1.y == vec2.y))
end
local function _2_(vec)
  return ("[x: " .. vec.x .. "\ty:" .. vec.y .. "]")
end
local function _3_(vec1, vec2)
  return Vector2((vec1.x + vec2.x), (vec1.y + vec2.y))
end
Vector2_mt = {__eq = _1_, __tostring = _2_, __add = _3_}
local Vector2_ctype = ffi.metatype("Vector2", Vector2_mt)
local function Vector20(x, y)
  return Vector2_ctype(x, y)
end
local function Vector3(x, y, z)
  return ffi.new("Vector3", {x, y, z})
end
local Vector3_mt
local function _4_(vec1, vec2)
  return ((vec1.x == vec2.x) and (vec1.y == vec2.y) and (vec1.z == vec2.z))
end
local function _5_(vec)
  return ("[x: " .. vec.x .. "\ty:" .. vec.y .. "\tz:" .. vec.z .. "]")
end
Vector3_mt = {__eq = _4_, __tostring = _5_}
local Vector3_ctype = ffi.metatype("Vector3", Vector3_mt)
local function Vector30(x, y, z)
  return Vector3_ctype(x, y, z)
end
local function Vector4(x, y, z, w)
  return ffi.new("Vector3", {x, y, z, w})
end
local Vector4_mt
local function _6_(vec1, vec2)
  return ((vec1.x == vec2.x) and (vec1.y == vec2.y) and (vec1.z == vec2.z) and (vec1.w == vec2.w))
end
local function _7_(vec)
  return ("[x: " .. vec.x .. "\ty:" .. vec.y .. "\tz:" .. vec.z .. "\tw: " .. vec.w .. "]")
end
Vector4_mt = {__eq = _6_, __tostring = _7_}
local Vector4_ctype = ffi.metatype("Vector4", Vector4_mt)
local function Vector40(x, y, z, w)
  return Vector4_ctype({x, y, z, w})
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
return {Vector2 = Vector20, Vector3 = Vector30, Vector4 = Vector40, Quaternion = Quaternion, Matrix = Matrix, Color = Color, Rectangle = Rectangle, Image = Image, Texture = Texture, Texture2D = Texture2D, TextureCubemap = TextureCubemap, RenderTexture = RenderTexture, RenderTexture2D = RenderTexture2D, NPatchInfo = NPatchInfo, GlyphInfo = GlyphInfo, Font = Font, Camera3D = Camera3D, Camera = Camera, Camera2D = Camera2D, Mesh = Mesh, Shader = Shader, MaterialMap = MaterialMap, Material = Material, Transform = Transform, BoneInfo = BoneInfo, Model = Model, ModelAnimation = ModelAnimation, Ray = Ray, RayCollision = RayCollision, BoundingBox = BoundingBox, Wave = Wave, AudioStream = AudioStream, Sound = Sound, Music = Music, VrDeviceInfo = VrDeviceInfo, VrStereoConfig = VrStereoConfig, FilePathList = FilePathList, AutomationEvent = AutomationEvent, AutomationEventList = AutomationEventList}
