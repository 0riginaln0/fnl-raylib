print("RAYLIB STRUCT MODULE INIT")
local dll = require("lib.dll")
local ffi = dll.ffi
local rl = dll.rl
ffi.cdef("\ntypedef struct Vector2 {\n    float x;                // Vector x component\n    float y;                // Vector y component\n    } Vector2;\n\ntypedef struct Vector3 {\n    float x;                // Vector x component\n    float y;                // Vector y component\n    float z;                // Vector z component\n    } Vector3;\n\ntypedef struct Vector4 {\n    float x;                // Vector x component\n    float y;                // Vector y component\n    float z;                // Vector z component\n    float w;                // Vector w component\n    } Vector4;\n\ntypedef Vector4 Quaternion;\ntypedef struct Matrix {\n    float m0, m4, m8, m12;  // Matrix first row (4 components)\n    float m1, m5, m9, m13;  // Matrix second row (4 components)\n    float m2, m6, m10, m14; // Matrix third row (4 components)\n    float m3, m7, m11, m15; // Matrix fourth row (4 components)\n    } Matrix;\n\ntypedef struct Color {\n    unsigned char r;        // Color red value\n    unsigned char g;        // Color green value\n    unsigned char b;        // Color blue value\n    unsigned char a;        // Color alpha value\n    } Color;\n\ntypedef struct Rectangle {\n    float x;                // Rectangle top-left corner position x\n    float y;                // Rectangle top-left corner position y\n    float width;            // Rectangle width\n    float height;           // Rectangle height\n    } Rectangle;\n\ntypedef struct Image {\n    void *data;             // Image raw data\n    int width;              // Image base width\n    int height;             // Image base height\n    int mipmaps;            // Mipmap levels, 1 by default\n    int format;             // Data format (PixelFormat type)\n    } Image;\n\ntypedef struct Texture {\n    unsigned int id;        // OpenGL texture id\n    int width;              // Texture base width\n    int height;             // Texture base height\n    int mipmaps;            // Mipmap levels, 1 by default\n    int format;             // Data format (PixelFormat type)\n    } Texture;\n\ntypedef Texture Texture2D;\ntypedef Texture TextureCubemap;\ntypedef struct RenderTexture {\n    unsigned int id;        // OpenGL framebuffer object id\n    Texture texture;        // Color buffer attachment texture\n    Texture depth;          // Depth buffer attachment texture\n    } RenderTexture;\n\ntypedef RenderTexture RenderTexture2D;\ntypedef struct NPatchInfo {\n    Rectangle source;       // Texture source rectangle\n    int left;               // Left border offset\n    int top;                // Top border offset\n    int right;              // Right border offset\n    int bottom;             // Bottom border offset\n    int layout;             // Layout of the n-patch: 3x3, 1x3 or 3x1\n    } NPatchInfo;\n\ntypedef struct GlyphInfo {\n    int value;              // Character value (Unicode)\n    int offsetX;            // Character offset X when drawing\n    int offsetY;            // Character offset Y when drawing\n    int advanceX;           // Character advance position X\n    Image image;            // Character image data\n    } GlyphInfo;\n\ntypedef struct Font {\n    int baseSize;           // Base size (default chars height)\n    int glyphCount;         // Number of glyph characters\n    int glyphPadding;       // Padding around the glyph characters\n    Texture2D texture;      // Texture atlas containing the glyphs\n    Rectangle *recs;        // Rectangles in texture for the glyphs\n    GlyphInfo *glyphs;      // Glyphs info data\n    } Font;\n\ntypedef struct Camera3D {\n    Vector3 position;       // Camera position\n    Vector3 target;         // Camera target it looks-at\n    Vector3 up;             // Camera up vector (rotation over its axis)\n    float fovy;             // Camera field-of-view aperture in Y (degrees) in perspective, used as near plane width in orthographic\n    int projection;         // Camera projection: CAMERA_PERSPECTIVE or CAMERA_ORTHOGRAPHIC\n    } Camera3D;\n\ntypedef Camera3D Camera;    // Camera type fallback, defaults to Camera3D\ntypedef struct Camera2D {\n    Vector2 offset;         // Camera offset (displacement from target)\n    Vector2 target;         // Camera target (rotation and zoom origin)\n    float rotation;         // Camera rotation in degrees\n    float zoom;             // Camera zoom (scaling), should be 1.0f by default\n    } Camera2D;\n\ntypedef struct Mesh {\n    int vertexCount;        // Number of vertices stored in arrays\n    int triangleCount;      // Number of triangles stored (indexed or not)\n    \n    // Vertex attributes data\n    float *vertices;        // Vertex position (XYZ - 3 components per vertex) (shader-location = 0)\n    float *texcoords;       // Vertex texture coordinates (UV - 2 components per vertex) (shader-location = 1)\n    float *texcoords2;      // Vertex texture second coordinates (UV - 2 components per vertex) (shader-location = 5)\n    float *normals;         // Vertex normals (XYZ - 3 components per vertex) (shader-location = 2)\n    float *tangents;        // Vertex tangents (XYZW - 4 components per vertex) (shader-location = 4)\n    unsigned char *colors;      // Vertex colors (RGBA - 4 components per vertex) (shader-location = 3)\n    unsigned short *indices;    // Vertex indices (in case vertex data comes indexed)\n    \n    // Animation vertex data\n    float *animVertices;    // Animated vertex positions (after bones transformations)\n    float *animNormals;     // Animated normals (after bones transformations)\n    unsigned char *boneIds; // Vertex bone ids, max 255 bone ids, up to 4 bones influence by vertex (skinning) (shader-location = 6)\n    float *boneWeights;     // Vertex bone weight, up to 4 bones influence by vertex (skinning) (shader-location = 7)\n    Matrix *boneMatrices;   // Bones animated transformation matrices\n    int boneCount;          // Number of bones\n    \n    // OpenGL identifiers\n    unsigned int vaoId;     // OpenGL Vertex Array Object id\n    unsigned int *vboId;    // OpenGL Vertex Buffer Objects id (default vertex data)\n    } Mesh;\n\ntypedef struct Shader {\n    unsigned int id;        // Shader program id\n    int *locs;              // Shader locations array (RL_MAX_SHADER_LOCATIONS)\n    } Shader;\n\ntypedef struct MaterialMap {\n    Texture2D texture;      // Material map texture\n    Color color;            // Material map color\n    float value;            // Material map value\n    } MaterialMap;\n\ntypedef struct Material {\n    Shader shader;          // Material shader\n    MaterialMap *maps;      // Material maps array (MAX_MATERIAL_MAPS)\n    float params[4];        // Material generic parameters (if required)\n    } Material;\n\ntypedef struct Transform {\n    Vector3 translation;    // Translation\n    Quaternion rotation;    // Rotation\n    Vector3 scale;          // Scale\n    } Transform;\n\ntypedef struct BoneInfo {\n    char name[32];          // Bone name\n    int parent;             // Bone parent\n    } BoneInfo;\n\ntypedef struct Model {\n    Matrix transform;       // Local transform matrix\n    \n    int meshCount;          // Number of meshes\n    int materialCount;      // Number of materials\n    Mesh *meshes;           // Meshes array\n    Material *materials;    // Materials array\n    int *meshMaterial;      // Mesh material number\n    \n    // Animation data\n    int boneCount;          // Number of bones\n    BoneInfo *bones;        // Bones information (skeleton)\n    Transform *bindPose;    // Bones base transformation (pose)\n    } Model;\n\ntypedef struct ModelAnimation {\n    int boneCount;          // Number of bones\n    int frameCount;         // Number of animation frames\n    BoneInfo *bones;        // Bones information (skeleton)\n    Transform **framePoses; // Poses array by frame\n    char name[32];          // Animation name\n    } ModelAnimation;\n\ntypedef struct Ray {\n    Vector3 position;       // Ray position (origin)\n    Vector3 direction;      // Ray direction (normalized)\n    } Ray;\n\ntypedef struct RayCollision {\n    bool hit;               // Did the ray hit something?\n    float distance;         // Distance to the nearest hit\n    Vector3 point;          // Point of the nearest hit\n    Vector3 normal;         // Surface normal of hit\n    } RayCollision;\n\ntypedef struct BoundingBox {\n    Vector3 min;            // Minimum vertex box-corner\n    Vector3 max;            // Maximum vertex box-corner\n    } BoundingBox;\n\ntypedef struct Wave {\n    unsigned int frameCount;    // Total number of frames (considering channels)\n    unsigned int sampleRate;    // Frequency (samples per second)\n    unsigned int sampleSize;    // Bit depth (bits per sample): 8, 16, 32 (24 not supported)\n    unsigned int channels;      // Number of channels (1-mono, 2-stereo, ...)\n    void *data;                 // Buffer data pointer\n    } Wave;\n\ntypedef struct rAudioBuffer rAudioBuffer;\n    typedef struct rAudioProcessor rAudioProcessor;\n\ntypedef struct AudioStream {\n    rAudioBuffer *buffer;       // Pointer to internal data used by the audio system\n    rAudioProcessor *processor; // Pointer to internal data processor, useful for audio effects\n    \n    unsigned int sampleRate;    // Frequency (samples per second)\n    unsigned int sampleSize;    // Bit depth (bits per sample): 8, 16, 32 (24 not supported)\n    unsigned int channels;      // Number of channels (1-mono, 2-stereo, ...)\n    } AudioStream;\n\ntypedef struct Sound {\n    AudioStream stream;         // Audio stream\n    unsigned int frameCount;    // Total number of frames (considering channels)\n    } Sound;\n\ntypedef struct Music {\n    AudioStream stream;         // Audio stream\n    unsigned int frameCount;    // Total number of frames (considering channels)\n    bool looping;               // Music looping enable\n    \n    int ctxType;                // Type of music context (audio filetype)\n    void *ctxData;              // Audio context data, depends on type\n    } Music;\n\ntypedef struct VrDeviceInfo {\n    int hResolution;                // Horizontal resolution in pixels\n    int vResolution;                // Vertical resolution in pixels\n    float hScreenSize;              // Horizontal size in meters\n    float vScreenSize;              // Vertical size in meters\n    float eyeToScreenDistance;      // Distance between eye and display in meters\n    float lensSeparationDistance;   // Lens separation distance in meters\n    float interpupillaryDistance;   // IPD (distance between pupils) in meters\n    float lensDistortionValues[4];  // Lens distortion constant parameters\n    float chromaAbCorrection[4];    // Chromatic aberration correction parameters\n    } VrDeviceInfo;\n\ntypedef struct VrStereoConfig {\n    Matrix projection[2];           // VR projection matrices (per eye)\n    Matrix viewOffset[2];           // VR view offset matrices (per eye)\n    float leftLensCenter[2];        // VR left lens center\n    float rightLensCenter[2];       // VR right lens center\n    float leftScreenCenter[2];      // VR left screen center\n    float rightScreenCenter[2];     // VR right screen center\n    float scale[2];                 // VR distortion scale\n    float scaleIn[2];               // VR distortion scale in\n    } VrStereoConfig;\n\ntypedef struct FilePathList {\n    unsigned int capacity;          // Filepaths max entries\n    unsigned int count;             // Filepaths entries count\n    char **paths;                   // Filepaths entries\n    } FilePathList;\n\ntypedef struct AutomationEvent {\n    unsigned int frame;             // Event frame\n    unsigned int type;              // Event type (AutomationEventType)\n    int params[4];                  // Event parameters (if required)\n    } AutomationEvent;\n\ntypedef struct AutomationEventList {\n    unsigned int capacity;          // Events max entries (MAX_AUTOMATION_EVENTS)\n    unsigned int count;             // Events entries count\n    AutomationEvent *events;        // Events entries\n    } AutomationEventList;\n")
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
