print("RAYLIB MODELS INIT: STARTED")
local safe_mode = true
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
ffi.cdef("\nvoid DrawLine3D(Vector3 startPos, Vector3 endPos, Color color);                                    // Draw a line in 3D world space\n\nvoid DrawPoint3D(Vector3 position, Color color);                                                   // Draw a point in 3D space, actually a small line\n\nvoid DrawCircle3D(Vector3 center, float radius, Vector3 rotationAxis, float rotationAngle, Color color); // Draw a circle in 3D world space\n\nvoid DrawTriangle3D(Vector3 v1, Vector3 v2, Vector3 v3, Color color);                              // Draw a color-filled triangle (vertex in counter-clockwise order!)\n\nvoid DrawTriangleStrip3D(const Vector3 *points, int pointCount, Color color);                      // Draw a triangle strip defined by points\n\nvoid DrawCube(Vector3 position, float width, float height, float length, Color color);             // Draw cube\n\nvoid DrawCubeV(Vector3 position, Vector3 size, Color color);                                       // Draw cube (Vector version)\n\nvoid DrawCubeWires(Vector3 position, float width, float height, float length, Color color);        // Draw cube wires\n\nvoid DrawCubeWiresV(Vector3 position, Vector3 size, Color color);                                  // Draw cube wires (Vector version)\n\nvoid DrawSphere(Vector3 centerPos, float radius, Color color);                                     // Draw sphere\n\nvoid DrawSphereEx(Vector3 centerPos, float radius, int rings, int slices, Color color);            // Draw sphere with extended parameters\n\nvoid DrawSphereWires(Vector3 centerPos, float radius, int rings, int slices, Color color);         // Draw sphere wires\n\nvoid DrawCylinder(Vector3 position, float radiusTop, float radiusBottom, float height, int slices, Color color); // Draw a cylinder/cone\n\nvoid DrawCylinderEx(Vector3 startPos, Vector3 endPos, float startRadius, float endRadius, int sides, Color color); // Draw a cylinder with base at startPos and top at endPos\n\nvoid DrawCylinderWires(Vector3 position, float radiusTop, float radiusBottom, float height, int slices, Color color); // Draw a cylinder/cone wires\n\nvoid DrawCylinderWiresEx(Vector3 startPos, Vector3 endPos, float startRadius, float endRadius, int sides, Color color); // Draw a cylinder wires with base at startPos and top at endPos\n\nvoid DrawCapsule(Vector3 startPos, Vector3 endPos, float radius, int slices, int rings, Color color); // Draw a capsule with the center of its sphere caps at startPos and endPos\n\nvoid DrawCapsuleWires(Vector3 startPos, Vector3 endPos, float radius, int slices, int rings, Color color); // Draw capsule wireframe with the center of its sphere caps at startPos and endPos\n\nvoid DrawPlane(Vector3 centerPos, Vector2 size, Color color);                                      // Draw a plane XZ\n\nvoid DrawRay(Ray ray, Color color);                                                                // Draw a ray line\n\nvoid DrawGrid(int slices, float spacing);                                                          // Draw a grid (centered at (0, 0, 0))\n\nModel LoadModel(const char *fileName);                                                // Load model from files (meshes and materials)\n\nModel LoadModelFromMesh(Mesh mesh);                                                   // Load model from generated mesh (default material)\n\nbool IsModelValid(Model model);                                                       // Check if a model is valid (loaded in GPU, VAO/VBOs)\n\nvoid UnloadModel(Model model);                                                        // Unload model (including meshes) from memory (RAM and/or VRAM)\n\nBoundingBox GetModelBoundingBox(Model model);                                         // Compute model bounding box limits (considers all meshes)\n\nvoid DrawModel(Model model, Vector3 position, float scale, Color tint);               // Draw a model (with texture if set)\n\nvoid DrawModelEx(Model model, Vector3 position, Vector3 rotationAxis, float rotationAngle, Vector3 scale, Color tint); // Draw a model with extended parameters\n\nvoid DrawModelWires(Model model, Vector3 position, float scale, Color tint);          // Draw a model wires (with texture if set)\n\nvoid DrawModelWiresEx(Model model, Vector3 position, Vector3 rotationAxis, float rotationAngle, Vector3 scale, Color tint); // Draw a model wires (with texture if set) with extended parameters\n\nvoid DrawModelPoints(Model model, Vector3 position, float scale, Color tint); // Draw a model as points\n\nvoid DrawModelPointsEx(Model model, Vector3 position, Vector3 rotationAxis, float rotationAngle, Vector3 scale, Color tint); // Draw a model as points with extended parameters\n\nvoid DrawBoundingBox(BoundingBox box, Color color);                                   // Draw bounding box (wires)\n\nvoid DrawBillboard(Camera camera, Texture2D texture, Vector3 position, float scale, Color tint);   // Draw a billboard texture\n\nvoid DrawBillboardRec(Camera camera, Texture2D texture, Rectangle source, Vector3 position, Vector2 size, Color tint); // Draw a billboard texture defined by source\n\nvoid DrawBillboardPro(Camera camera, Texture2D texture, Rectangle source, Vector3 position, Vector3 up, Vector2 size, Vector2 origin, float rotation, Color tint); // Draw a billboard texture defined by source and rotation\n\nvoid UploadMesh(Mesh *mesh, bool dynamic);                                            // Upload mesh vertex data in GPU and provide VAO/VBO ids\n\nvoid UpdateMeshBuffer(Mesh mesh, int index, const void *data, int dataSize, int offset); // Update mesh vertex data in GPU for a specific buffer index\n\nvoid UnloadMesh(Mesh mesh);                                                           // Unload mesh data from CPU and GPU\n\nvoid DrawMesh(Mesh mesh, Material material, Matrix transform);                        // Draw a 3d mesh with material and transform\n\nvoid DrawMeshInstanced(Mesh mesh, Material material, const Matrix *transforms, int instances); // Draw multiple mesh instances with material and different transforms\n\nBoundingBox GetMeshBoundingBox(Mesh mesh);                                            // Compute mesh bounding box limits\n\nvoid GenMeshTangents(Mesh *mesh);                                                     // Compute mesh tangents\n\nbool ExportMesh(Mesh mesh, const char *fileName);                                     // Export mesh data to file, returns true on success\n\nbool ExportMeshAsCode(Mesh mesh, const char *fileName);                               // Export mesh as code file (.h) defining multiple arrays of vertex attributes\n\nMesh GenMeshPoly(int sides, float radius);                                            // Generate polygonal mesh\n\nMesh GenMeshPlane(float width, float length, int resX, int resZ);                     // Generate plane mesh (with subdivisions)\n\nMesh GenMeshCube(float width, float height, float length);                            // Generate cuboid mesh\n\nMesh GenMeshSphere(float radius, int rings, int slices);                              // Generate sphere mesh (standard sphere)\n\nMesh GenMeshHemiSphere(float radius, int rings, int slices);                          // Generate half-sphere mesh (no bottom cap)\n\nMesh GenMeshCylinder(float radius, float height, int slices);                         // Generate cylinder mesh\n\nMesh GenMeshCone(float radius, float height, int slices);                             // Generate cone/pyramid mesh\n\nMesh GenMeshTorus(float radius, float size, int radSeg, int sides);                   // Generate torus mesh\n\nMesh GenMeshKnot(float radius, float size, int radSeg, int sides);                    // Generate trefoil knot mesh\n\nMesh GenMeshHeightmap(Image heightmap, Vector3 size);                                 // Generate heightmap mesh from image data\n\nMesh GenMeshCubicmap(Image cubicmap, Vector3 cubeSize);                               // Generate cubes-based map mesh from image data\n\nMaterial *LoadMaterials(const char *fileName, int *materialCount);                    // Load materials from model file\n\nMaterial LoadMaterialDefault(void);                                                   // Load default material (Supports: DIFFUSE, SPECULAR, NORMAL maps)\n\nbool IsMaterialValid(Material material);                                              // Check if a material is valid (shader assigned, map textures loaded in GPU)\n\nvoid UnloadMaterial(Material material);                                               // Unload material from GPU memory (VRAM)\n\nvoid SetMaterialTexture(Material *material, int mapType, Texture2D texture);          // Set texture for a material map type (MATERIAL_MAP_DIFFUSE, MATERIAL_MAP_SPECULAR...)\n\nvoid SetModelMeshMaterial(Model *model, int meshId, int materialId);                  // Set material for a mesh\n\nModelAnimation *LoadModelAnimations(const char *fileName, int *animCount);            // Load model animations from file\n\nvoid UpdateModelAnimation(Model model, ModelAnimation anim, int frame);               // Update model animation pose (CPU)\n\nvoid UpdateModelAnimationBones(Model model, ModelAnimation anim, int frame);          // Update model animation mesh bone matrices (GPU skinning)\n\nvoid UnloadModelAnimation(ModelAnimation anim);                                       // Unload animation data\n\nvoid UnloadModelAnimations(ModelAnimation *animations, int animCount);                // Unload animation array data\n\nbool IsModelAnimationValid(Model model, ModelAnimation anim);                         // Check model animation skeleton match\n\nbool CheckCollisionSpheres(Vector3 center1, float radius1, Vector3 center2, float radius2);   // Check collision between two spheres\n\nbool CheckCollisionBoxes(BoundingBox box1, BoundingBox box2);                                 // Check collision between two bounding boxes\n\nbool CheckCollisionBoxSphere(BoundingBox box, Vector3 center, float radius);                  // Check collision between box and sphere\n\nRayCollision GetRayCollisionSphere(Ray ray, Vector3 center, float radius);                    // Get collision info between ray and sphere\n\nRayCollision GetRayCollisionBox(Ray ray, BoundingBox box);                                    // Get collision info between ray and box\n\nRayCollision GetRayCollisionMesh(Ray ray, Mesh mesh, Matrix transform);                       // Get collision info between ray and mesh\n\nRayCollision GetRayCollisionTriangle(Ray ray, Vector3 p1, Vector3 p2, Vector3 p3);            // Get collision info between ray and triangle\n\nRayCollision GetRayCollisionQuad(Ray ray, Vector3 p1, Vector3 p2, Vector3 p3, Vector3 p4);    // Get collision info between ray and quad\n\n")
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
return {["draw-line3d"] = draw_line3d, ["draw-point3d"] = draw_point3d, ["draw-circle3d"] = draw_circle3d, ["draw-triangle3d"] = draw_triangle3d, ["draw-triangle-strip3d"] = draw_triangle_strip3d, ["draw-cube"] = draw_cube, ["draw-cube-v"] = draw_cube_v, ["draw-cube-wires"] = draw_cube_wires, ["draw-cube-wires-v"] = draw_cube_wires_v, ["draw-sphere"] = draw_sphere, ["draw-sphere-ex"] = draw_sphere_ex, ["draw-sphere-wires"] = draw_sphere_wires, ["draw-cylinder"] = draw_cylinder, ["draw-cylinder-ex"] = draw_cylinder_ex, ["draw-cylinder-wires"] = draw_cylinder_wires, ["draw-cylinder-wires-ex"] = draw_cylinder_wires_ex, ["draw-capsule"] = draw_capsule, ["draw-capsule-wires"] = draw_capsule_wires, ["draw-plane"] = draw_plane, ["draw-ray"] = draw_ray, ["draw-grid"] = draw_grid, ["load-model"] = load_model, ["load-model-from-mesh"] = load_model_from_mesh, ["is-model-valid"] = is_model_valid, ["unload-model"] = unload_model, ["get-model-bounding-box"] = get_model_bounding_box, ["draw-model"] = draw_model, ["draw-model-ex"] = draw_model_ex, ["draw-model-wires"] = draw_model_wires, ["draw-model-wires-ex"] = draw_model_wires_ex, ["draw-model-points"] = draw_model_points, ["draw-model-points-ex"] = draw_model_points_ex, ["draw-bounding-box"] = draw_bounding_box, ["draw-billboard"] = draw_billboard, ["draw-billboard-rec"] = draw_billboard_rec, ["draw-billboard-pro"] = draw_billboard_pro, ["upload-mesh"] = upload_mesh, ["update-mesh-buffer"] = update_mesh_buffer, ["unload-mesh"] = unload_mesh, ["draw-mesh"] = draw_mesh, ["draw-mesh-instanced"] = draw_mesh_instanced, ["get-mesh-bounding-box"] = get_mesh_bounding_box, ["gen-mesh-tangents"] = gen_mesh_tangents, ["export-mesh"] = export_mesh, ["export-mesh-as-code"] = export_mesh_as_code, ["gen-mesh-poly"] = gen_mesh_poly, ["gen-mesh-plane"] = gen_mesh_plane, ["gen-mesh-cube"] = gen_mesh_cube, ["gen-mesh-sphere"] = gen_mesh_sphere, ["gen-mesh-hemi-sphere"] = gen_mesh_hemi_sphere, ["gen-mesh-cylinder"] = gen_mesh_cylinder, ["gen-mesh-cone"] = gen_mesh_cone, ["gen-mesh-torus"] = gen_mesh_torus, ["gen-mesh-knot"] = gen_mesh_knot, ["gen-mesh-heightmap"] = gen_mesh_heightmap, ["gen-mesh-cubicmap"] = gen_mesh_cubicmap, ["load-materials"] = load_materials, ["load-material-default"] = load_material_default, ["is-material-valid"] = is_material_valid, ["unload-material"] = unload_material, ["set-material-texture"] = set_material_texture, ["set-model-mesh-material"] = set_model_mesh_material, ["load-model-animations"] = load_model_animations, ["update-model-animation"] = update_model_animation, ["update-model-animation-bones"] = update_model_animation_bones, ["unload-model-animation"] = unload_model_animation, ["unload-model-animations"] = unload_model_animations, ["is-model-animation-valid"] = is_model_animation_valid, ["check-collision-spheres"] = check_collision_spheres, ["check-collision-boxes"] = check_collision_boxes, ["check-collision-box-sphere"] = check_collision_box_sphere, ["get-ray-collision-sphere"] = get_ray_collision_sphere, ["get-ray-collision-box"] = get_ray_collision_box, ["get-ray-collision-mesh"] = get_ray_collision_mesh, ["get-ray-collision-triangle"] = get_ray_collision_triangle, ["get-ray-collision-quad"] = get_ray_collision_quad}
