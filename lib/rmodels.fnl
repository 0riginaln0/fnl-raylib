(print "RAYLIB MODELS INIT: STARTED")
(local safe-mode true)

(local ffi (require :ffi))

(local os ffi.os)
; (print os)

(local rl 
  (case os 
    :Windows (ffi.load :lib\raylib-5.5_win64_mingw-w64\lib\raylib.dll) 
    :Linux   (ffi.load :lib/raylib-5.5_linux_amd64/lib/libraylib.so)))

(ffi.cdef "
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

")


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

{: draw-line3d
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
 : get-ray-collision-quad}