print("RAYLIB SHAPES INIT: STARTED")
local safe_mode = true
local dll = require("lib.dll")
local ffi = dll.ffi
local rl = dll.rl
ffi.cdef("\13\nvoid SetShapesTexture(Texture2D texture, Rectangle source);       // Set texture and rectangle to be used on shapes drawing\13\n\13\nTexture2D GetShapesTexture(void);                                 // Get texture that is used for shapes drawing\13\n\13\nRectangle GetShapesTextureRectangle(void);                        // Get texture source rectangle that is used for shapes drawing\13\n\13\nvoid DrawPixel(int posX, int posY, Color color);                                                   // Draw a pixel using geometry [Can be slow, use with care]\13\n\13\nvoid DrawPixelV(Vector2 position, Color color);                                                    // Draw a pixel using geometry (Vector version) [Can be slow, use with care]\13\n\13\nvoid DrawLine(int startPosX, int startPosY, int endPosX, int endPosY, Color color);                // Draw a line\13\n\13\nvoid DrawLineV(Vector2 startPos, Vector2 endPos, Color color);                                     // Draw a line (using gl lines)\13\n\13\nvoid DrawLineEx(Vector2 startPos, Vector2 endPos, float thick, Color color);                       // Draw a line (using triangles/quads)\13\n\13\nvoid DrawLineStrip(const Vector2 *points, int pointCount, Color color);                            // Draw lines sequence (using gl lines)\13\n\13\nvoid DrawLineBezier(Vector2 startPos, Vector2 endPos, float thick, Color color);                   // Draw line segment cubic-bezier in-out interpolation\13\n\13\nvoid DrawCircle(int centerX, int centerY, float radius, Color color);                              // Draw a color-filled circle\13\n\13\nvoid DrawCircleSector(Vector2 center, float radius, float startAngle, float endAngle, int segments, Color color);      // Draw a piece of a circle\13\n\13\nvoid DrawCircleSectorLines(Vector2 center, float radius, float startAngle, float endAngle, int segments, Color color); // Draw circle sector outline\13\n\13\nvoid DrawCircleGradient(int centerX, int centerY, float radius, Color inner, Color outer);         // Draw a gradient-filled circle\13\n\13\nvoid DrawCircleV(Vector2 center, float radius, Color color);                                       // Draw a color-filled circle (Vector version)\13\n\13\nvoid DrawCircleLines(int centerX, int centerY, float radius, Color color);                         // Draw circle outline\13\n\13\nvoid DrawCircleLinesV(Vector2 center, float radius, Color color);                                  // Draw circle outline (Vector version)\13\n\13\nvoid DrawEllipse(int centerX, int centerY, float radiusH, float radiusV, Color color);             // Draw ellipse\13\n\13\nvoid DrawEllipseLines(int centerX, int centerY, float radiusH, float radiusV, Color color);        // Draw ellipse outline\13\n\13\nvoid DrawRing(Vector2 center, float innerRadius, float outerRadius, float startAngle, float endAngle, int segments, Color color); // Draw ring\13\n\13\nvoid DrawRingLines(Vector2 center, float innerRadius, float outerRadius, float startAngle, float endAngle, int segments, Color color);    // Draw ring outline\13\n\13\nvoid DrawRectangle(int posX, int posY, int width, int height, Color color);                        // Draw a color-filled rectangle\13\n\13\nvoid DrawRectangleV(Vector2 position, Vector2 size, Color color);                                  // Draw a color-filled rectangle (Vector version)\13\n\13\nvoid DrawRectangleRec(Rectangle rec, Color color);                                                 // Draw a color-filled rectangle\13\n\13\nvoid DrawRectanglePro(Rectangle rec, Vector2 origin, float rotation, Color color);                 // Draw a color-filled rectangle with pro parameters\13\n\13\nvoid DrawRectangleGradientV(int posX, int posY, int width, int height, Color top, Color bottom);   // Draw a vertical-gradient-filled rectangle\13\n\13\nvoid DrawRectangleGradientH(int posX, int posY, int width, int height, Color left, Color right);   // Draw a horizontal-gradient-filled rectangle\13\n\13\nvoid DrawRectangleGradientEx(Rectangle rec, Color topLeft, Color bottomLeft, Color topRight, Color bottomRight); // Draw a gradient-filled rectangle with custom vertex colors\13\n\13\nvoid DrawRectangleLines(int posX, int posY, int width, int height, Color color);                   // Draw rectangle outline\13\n\13\nvoid DrawRectangleLinesEx(Rectangle rec, float lineThick, Color color);                            // Draw rectangle outline with extended parameters\13\n\13\nvoid DrawRectangleRounded(Rectangle rec, float roundness, int segments, Color color);              // Draw rectangle with rounded edges\13\n\13\nvoid DrawRectangleRoundedLines(Rectangle rec, float roundness, int segments, Color color);         // Draw rectangle lines with rounded edges\13\n\13\nvoid DrawRectangleRoundedLinesEx(Rectangle rec, float roundness, int segments, float lineThick, Color color); // Draw rectangle with rounded edges outline\13\n\13\nvoid DrawTriangle(Vector2 v1, Vector2 v2, Vector2 v3, Color color);                                // Draw a color-filled triangle (vertex in counter-clockwise order!)\13\n\13\nvoid DrawTriangleLines(Vector2 v1, Vector2 v2, Vector2 v3, Color color);                           // Draw triangle outline (vertex in counter-clockwise order!)\13\n\13\nvoid DrawTriangleFan(const Vector2 *points, int pointCount, Color color);                          // Draw a triangle fan defined by points (first vertex is the center)\13\n\13\nvoid DrawTriangleStrip(const Vector2 *points, int pointCount, Color color);                        // Draw a triangle strip defined by points\13\n\13\nvoid DrawPoly(Vector2 center, int sides, float radius, float rotation, Color color);               // Draw a regular polygon (Vector version)\13\n\13\nvoid DrawPolyLines(Vector2 center, int sides, float radius, float rotation, Color color);          // Draw a polygon outline of n sides\13\n\13\nvoid DrawPolyLinesEx(Vector2 center, int sides, float radius, float rotation, float lineThick, Color color); // Draw a polygon outline of n sides with extended parameters\13\n\13\nvoid DrawSplineLinear(const Vector2 *points, int pointCount, float thick, Color color);                  // Draw spline: Linear, minimum 2 points\13\n\13\nvoid DrawSplineBasis(const Vector2 *points, int pointCount, float thick, Color color);                   // Draw spline: B-Spline, minimum 4 points\13\n\13\nvoid DrawSplineCatmullRom(const Vector2 *points, int pointCount, float thick, Color color);              // Draw spline: Catmull-Rom, minimum 4 points\13\n\13\nvoid DrawSplineBezierQuadratic(const Vector2 *points, int pointCount, float thick, Color color);         // Draw spline: Quadratic Bezier, minimum 3 points (1 control point): [p1, c2, p3, c4...]\13\n\13\nvoid DrawSplineBezierCubic(const Vector2 *points, int pointCount, float thick, Color color);             // Draw spline: Cubic Bezier, minimum 4 points (2 control points): [p1, c2, c3, p4, c5, c6...]\13\n\13\nvoid DrawSplineSegmentLinear(Vector2 p1, Vector2 p2, float thick, Color color);                    // Draw spline segment: Linear, 2 points\13\n\13\nvoid DrawSplineSegmentBasis(Vector2 p1, Vector2 p2, Vector2 p3, Vector2 p4, float thick, Color color); // Draw spline segment: B-Spline, 4 points\13\n\13\nvoid DrawSplineSegmentCatmullRom(Vector2 p1, Vector2 p2, Vector2 p3, Vector2 p4, float thick, Color color); // Draw spline segment: Catmull-Rom, 4 points\13\n\13\nvoid DrawSplineSegmentBezierQuadratic(Vector2 p1, Vector2 c2, Vector2 p3, float thick, Color color); // Draw spline segment: Quadratic Bezier, 2 points, 1 control point\13\n\13\nvoid DrawSplineSegmentBezierCubic(Vector2 p1, Vector2 c2, Vector2 c3, Vector2 p4, float thick, Color color); // Draw spline segment: Cubic Bezier, 2 points, 2 control points\13\n\13\nVector2 GetSplinePointLinear(Vector2 startPos, Vector2 endPos, float t);                           // Get (evaluate) spline point: Linear\13\n\13\nVector2 GetSplinePointBasis(Vector2 p1, Vector2 p2, Vector2 p3, Vector2 p4, float t);              // Get (evaluate) spline point: B-Spline\13\n\13\nVector2 GetSplinePointCatmullRom(Vector2 p1, Vector2 p2, Vector2 p3, Vector2 p4, float t);         // Get (evaluate) spline point: Catmull-Rom\13\n\13\nVector2 GetSplinePointBezierQuad(Vector2 p1, Vector2 c2, Vector2 p3, float t);                     // Get (evaluate) spline point: Quadratic Bezier\13\n\13\nVector2 GetSplinePointBezierCubic(Vector2 p1, Vector2 c2, Vector2 c3, Vector2 p4, float t);        // Get (evaluate) spline point: Cubic Bezier\13\n\13\nbool CheckCollisionRecs(Rectangle rec1, Rectangle rec2);                                           // Check collision between two rectangles\13\n\13\nbool CheckCollisionCircles(Vector2 center1, float radius1, Vector2 center2, float radius2);        // Check collision between two circles\13\n\13\nbool CheckCollisionCircleRec(Vector2 center, float radius, Rectangle rec);                         // Check collision between circle and rectangle\13\n\13\nbool CheckCollisionCircleLine(Vector2 center, float radius, Vector2 p1, Vector2 p2);               // Check if circle collides with a line created betweeen two points [p1] and [p2]\13\n\13\nbool CheckCollisionPointRec(Vector2 point, Rectangle rec);                                         // Check if point is inside rectangle\13\n\13\nbool CheckCollisionPointCircle(Vector2 point, Vector2 center, float radius);                       // Check if point is inside circle\13\n\13\nbool CheckCollisionPointTriangle(Vector2 point, Vector2 p1, Vector2 p2, Vector2 p3);               // Check if point is inside a triangle\13\n\13\nbool CheckCollisionPointLine(Vector2 point, Vector2 p1, Vector2 p2, int threshold);                // Check if point belongs to line created between two points [p1] and [p2] with defined margin in pixels [threshold]\13\n\13\nbool CheckCollisionPointPoly(Vector2 point, const Vector2 *points, int pointCount);                // Check if point is within a polygon described by array of vertices\13\n\13\nbool CheckCollisionLines(Vector2 startPos1, Vector2 endPos1, Vector2 startPos2, Vector2 endPos2, Vector2 *collisionPoint); // Check the collision between two lines defined by two points each, returns collision point by reference\13\n\13\nRectangle GetCollisionRec(Rectangle rec1, Rectangle rec2);                                         // Get collision rectangle for two rectangles collision\13\n\13\n")
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
return {["set-shapes-texture"] = set_shapes_texture, ["get-shapes-texture"] = get_shapes_texture, ["get-shapes-texture-rectangle"] = get_shapes_texture_rectangle, ["draw-pixel"] = draw_pixel, ["draw-pixel-v"] = draw_pixel_v, ["draw-line"] = draw_line, ["draw-line-v"] = draw_line_v, ["draw-line-ex"] = draw_line_ex, ["draw-line-strip"] = draw_line_strip, ["draw-line-bezier"] = draw_line_bezier, ["draw-circle"] = draw_circle, ["draw-circle-sector"] = draw_circle_sector, ["draw-circle-sector-lines"] = draw_circle_sector_lines, ["draw-circle-gradient"] = draw_circle_gradient, ["draw-circle-v"] = draw_circle_v, ["draw-circle-lines"] = draw_circle_lines, ["draw-circle-lines-v"] = draw_circle_lines_v, ["draw-ellipse"] = draw_ellipse, ["draw-ellipse-lines"] = draw_ellipse_lines, ["draw-ring"] = draw_ring, ["draw-ring-lines"] = draw_ring_lines, ["draw-rectangle"] = draw_rectangle, ["draw-rectangle-v"] = draw_rectangle_v, ["draw-rectangle-rec"] = draw_rectangle_rec, ["draw-rectangle-pro"] = draw_rectangle_pro, ["draw-rectangle-gradient-v"] = draw_rectangle_gradient_v, ["draw-rectangle-gradient-h"] = draw_rectangle_gradient_h, ["draw-rectangle-gradient-ex"] = draw_rectangle_gradient_ex, ["draw-rectangle-lines"] = draw_rectangle_lines, ["draw-rectangle-lines-ex"] = draw_rectangle_lines_ex, ["draw-rectangle-rounded"] = draw_rectangle_rounded, ["draw-rectangle-rounded-lines"] = draw_rectangle_rounded_lines, ["draw-rectangle-rounded-lines-ex"] = draw_rectangle_rounded_lines_ex, ["draw-triangle"] = draw_triangle, ["draw-triangle-lines"] = draw_triangle_lines, ["draw-triangle-fan"] = draw_triangle_fan, ["draw-triangle-strip"] = draw_triangle_strip, ["draw-poly"] = draw_poly, ["draw-poly-lines"] = draw_poly_lines, ["draw-poly-lines-ex"] = draw_poly_lines_ex, ["draw-spline-linear"] = draw_spline_linear, ["draw-spline-basis"] = draw_spline_basis, ["draw-spline-catmull-rom"] = draw_spline_catmull_rom, ["draw-spline-bezier-quadratic"] = draw_spline_bezier_quadratic, ["draw-spline-bezier-cubic"] = draw_spline_bezier_cubic, ["draw-spline-segment-linear"] = draw_spline_segment_linear, ["draw-spline-segment-basis"] = draw_spline_segment_basis, ["draw-spline-segment-catmull-rom"] = draw_spline_segment_catmull_rom, ["draw-spline-segment-bezier-quadratic"] = draw_spline_segment_bezier_quadratic, ["draw-spline-segment-bezier-cubic"] = draw_spline_segment_bezier_cubic, ["get-spline-point-linear"] = get_spline_point_linear, ["get-spline-point-basis"] = get_spline_point_basis, ["get-spline-point-catmull-rom"] = get_spline_point_catmull_rom, ["get-spline-point-bezier-quad"] = get_spline_point_bezier_quad, ["get-spline-point-bezier-cubic"] = get_spline_point_bezier_cubic, ["check-collision-recs"] = check_collision_recs, ["check-collision-circles"] = check_collision_circles, ["check-collision-circle-rec"] = check_collision_circle_rec, ["check-collision-circle-line"] = check_collision_circle_line, ["check-collision-point-rec"] = check_collision_point_rec, ["check-collision-point-circle"] = check_collision_point_circle, ["check-collision-point-triangle"] = check_collision_point_triangle, ["check-collision-point-line"] = check_collision_point_line, ["check-collision-point-poly"] = check_collision_point_poly, ["check-collision-lines"] = check_collision_lines, ["get-collision-rec"] = get_collision_rec}
