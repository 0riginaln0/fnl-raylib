(print "RAYLIB SHAPES INIT: STARTED")
(local safe-mode true)

(local ffi (require :ffi))

(local os ffi.os)
(print os)

(local rl 
  (case os 
    :Windows (ffi.load :lib\raylib-5.5_win64_mingw-w64\lib\raylib.dll) 
    :Linux   (ffi.load :lib/raylib-5.5_linux_amd64/lib/libraylib.so)))
; (assert (= rl nil) "Unknown OS. Sorry")

(ffi.cdef "
void SetShapesTexture(Texture2D texture, Rectangle source);       // Set texture and rectangle to be used on shapes drawing

Texture2D GetShapesTexture(void);                                 // Get texture that is used for shapes drawing

Rectangle GetShapesTextureRectangle(void);                        // Get texture source rectangle that is used for shapes drawing

void DrawPixel(int posX, int posY, Color color);                                                   // Draw a pixel using geometry [Can be slow, use with care]

void DrawPixelV(Vector2 position, Color color);                                                    // Draw a pixel using geometry (Vector version) [Can be slow, use with care]

void DrawLine(int startPosX, int startPosY, int endPosX, int endPosY, Color color);                // Draw a line

void DrawLineV(Vector2 startPos, Vector2 endPos, Color color);                                     // Draw a line (using gl lines)

void DrawLineEx(Vector2 startPos, Vector2 endPos, float thick, Color color);                       // Draw a line (using triangles/quads)

void DrawLineStrip(const Vector2 *points, int pointCount, Color color);                            // Draw lines sequence (using gl lines)

void DrawLineBezier(Vector2 startPos, Vector2 endPos, float thick, Color color);                   // Draw line segment cubic-bezier in-out interpolation

void DrawCircle(int centerX, int centerY, float radius, Color color);                              // Draw a color-filled circle

void DrawCircleSector(Vector2 center, float radius, float startAngle, float endAngle, int segments, Color color);      // Draw a piece of a circle

void DrawCircleSectorLines(Vector2 center, float radius, float startAngle, float endAngle, int segments, Color color); // Draw circle sector outline

void DrawCircleGradient(int centerX, int centerY, float radius, Color inner, Color outer);         // Draw a gradient-filled circle

void DrawCircleV(Vector2 center, float radius, Color color);                                       // Draw a color-filled circle (Vector version)

void DrawCircleLines(int centerX, int centerY, float radius, Color color);                         // Draw circle outline

void DrawCircleLinesV(Vector2 center, float radius, Color color);                                  // Draw circle outline (Vector version)

void DrawEllipse(int centerX, int centerY, float radiusH, float radiusV, Color color);             // Draw ellipse

void DrawEllipseLines(int centerX, int centerY, float radiusH, float radiusV, Color color);        // Draw ellipse outline

void DrawRing(Vector2 center, float innerRadius, float outerRadius, float startAngle, float endAngle, int segments, Color color); // Draw ring

void DrawRingLines(Vector2 center, float innerRadius, float outerRadius, float startAngle, float endAngle, int segments, Color color);    // Draw ring outline

void DrawRectangle(int posX, int posY, int width, int height, Color color);                        // Draw a color-filled rectangle

void DrawRectangleV(Vector2 position, Vector2 size, Color color);                                  // Draw a color-filled rectangle (Vector version)

void DrawRectangleRec(Rectangle rec, Color color);                                                 // Draw a color-filled rectangle

void DrawRectanglePro(Rectangle rec, Vector2 origin, float rotation, Color color);                 // Draw a color-filled rectangle with pro parameters

void DrawRectangleGradientV(int posX, int posY, int width, int height, Color top, Color bottom);   // Draw a vertical-gradient-filled rectangle

void DrawRectangleGradientH(int posX, int posY, int width, int height, Color left, Color right);   // Draw a horizontal-gradient-filled rectangle

void DrawRectangleGradientEx(Rectangle rec, Color topLeft, Color bottomLeft, Color topRight, Color bottomRight); // Draw a gradient-filled rectangle with custom vertex colors

void DrawRectangleLines(int posX, int posY, int width, int height, Color color);                   // Draw rectangle outline

void DrawRectangleLinesEx(Rectangle rec, float lineThick, Color color);                            // Draw rectangle outline with extended parameters

void DrawRectangleRounded(Rectangle rec, float roundness, int segments, Color color);              // Draw rectangle with rounded edges

void DrawRectangleRoundedLines(Rectangle rec, float roundness, int segments, Color color);         // Draw rectangle lines with rounded edges

void DrawRectangleRoundedLinesEx(Rectangle rec, float roundness, int segments, float lineThick, Color color); // Draw rectangle with rounded edges outline

void DrawTriangle(Vector2 v1, Vector2 v2, Vector2 v3, Color color);                                // Draw a color-filled triangle (vertex in counter-clockwise order!)

void DrawTriangleLines(Vector2 v1, Vector2 v2, Vector2 v3, Color color);                           // Draw triangle outline (vertex in counter-clockwise order!)

void DrawTriangleFan(const Vector2 *points, int pointCount, Color color);                          // Draw a triangle fan defined by points (first vertex is the center)

void DrawTriangleStrip(const Vector2 *points, int pointCount, Color color);                        // Draw a triangle strip defined by points

void DrawPoly(Vector2 center, int sides, float radius, float rotation, Color color);               // Draw a regular polygon (Vector version)

void DrawPolyLines(Vector2 center, int sides, float radius, float rotation, Color color);          // Draw a polygon outline of n sides

void DrawPolyLinesEx(Vector2 center, int sides, float radius, float rotation, float lineThick, Color color); // Draw a polygon outline of n sides with extended parameters

void DrawSplineLinear(const Vector2 *points, int pointCount, float thick, Color color);                  // Draw spline: Linear, minimum 2 points

void DrawSplineBasis(const Vector2 *points, int pointCount, float thick, Color color);                   // Draw spline: B-Spline, minimum 4 points

void DrawSplineCatmullRom(const Vector2 *points, int pointCount, float thick, Color color);              // Draw spline: Catmull-Rom, minimum 4 points

void DrawSplineBezierQuadratic(const Vector2 *points, int pointCount, float thick, Color color);         // Draw spline: Quadratic Bezier, minimum 3 points (1 control point): [p1, c2, p3, c4...]

void DrawSplineBezierCubic(const Vector2 *points, int pointCount, float thick, Color color);             // Draw spline: Cubic Bezier, minimum 4 points (2 control points): [p1, c2, c3, p4, c5, c6...]

void DrawSplineSegmentLinear(Vector2 p1, Vector2 p2, float thick, Color color);                    // Draw spline segment: Linear, 2 points

void DrawSplineSegmentBasis(Vector2 p1, Vector2 p2, Vector2 p3, Vector2 p4, float thick, Color color); // Draw spline segment: B-Spline, 4 points

void DrawSplineSegmentCatmullRom(Vector2 p1, Vector2 p2, Vector2 p3, Vector2 p4, float thick, Color color); // Draw spline segment: Catmull-Rom, 4 points

void DrawSplineSegmentBezierQuadratic(Vector2 p1, Vector2 c2, Vector2 p3, float thick, Color color); // Draw spline segment: Quadratic Bezier, 2 points, 1 control point

void DrawSplineSegmentBezierCubic(Vector2 p1, Vector2 c2, Vector2 c3, Vector2 p4, float thick, Color color); // Draw spline segment: Cubic Bezier, 2 points, 2 control points

Vector2 GetSplinePointLinear(Vector2 startPos, Vector2 endPos, float t);                           // Get (evaluate) spline point: Linear

Vector2 GetSplinePointBasis(Vector2 p1, Vector2 p2, Vector2 p3, Vector2 p4, float t);              // Get (evaluate) spline point: B-Spline

Vector2 GetSplinePointCatmullRom(Vector2 p1, Vector2 p2, Vector2 p3, Vector2 p4, float t);         // Get (evaluate) spline point: Catmull-Rom

Vector2 GetSplinePointBezierQuad(Vector2 p1, Vector2 c2, Vector2 p3, float t);                     // Get (evaluate) spline point: Quadratic Bezier

Vector2 GetSplinePointBezierCubic(Vector2 p1, Vector2 c2, Vector2 c3, Vector2 p4, float t);        // Get (evaluate) spline point: Cubic Bezier

bool CheckCollisionRecs(Rectangle rec1, Rectangle rec2);                                           // Check collision between two rectangles

bool CheckCollisionCircles(Vector2 center1, float radius1, Vector2 center2, float radius2);        // Check collision between two circles

bool CheckCollisionCircleRec(Vector2 center, float radius, Rectangle rec);                         // Check collision between circle and rectangle

bool CheckCollisionCircleLine(Vector2 center, float radius, Vector2 p1, Vector2 p2);               // Check if circle collides with a line created betweeen two points [p1] and [p2]

bool CheckCollisionPointRec(Vector2 point, Rectangle rec);                                         // Check if point is inside rectangle

bool CheckCollisionPointCircle(Vector2 point, Vector2 center, float radius);                       // Check if point is inside circle

bool CheckCollisionPointTriangle(Vector2 point, Vector2 p1, Vector2 p2, Vector2 p3);               // Check if point is inside a triangle

bool CheckCollisionPointLine(Vector2 point, Vector2 p1, Vector2 p2, int threshold);                // Check if point belongs to line created between two points [p1] and [p2] with defined margin in pixels [threshold]

bool CheckCollisionPointPoly(Vector2 point, const Vector2 *points, int pointCount);                // Check if point is within a polygon described by array of vertices

bool CheckCollisionLines(Vector2 startPos1, Vector2 endPos1, Vector2 startPos2, Vector2 endPos2, Vector2 *collisionPoint); // Check the collision between two lines defined by two points each, returns collision point by reference

Rectangle GetCollisionRec(Rectangle rec1, Rectangle rec2);                                         // Get collision rectangle for two rectangles collision

")


;------------------------------------------------------------------------------------
; Basic Shapes Drawing Functions (Module: shapes)
;------------------------------------------------------------------------------------
; Set texture and rectangle to be used on shapes drawing
; NOTE: It can be useful when using basic shapes and one single font,
; defining a font char white rectangle would allow drawing everything in a single draw call
(fn set-shapes-texture [texture source]
	"Set texture and rectangle to be used on shapes drawing"
	(rl.SetShapesTexture texture source))

(fn get-shapes-texture []
	"Get texture that is used for shapes drawing"
	(rl.GetShapesTexture ))

(fn get-shapes-texture-rectangle []
	"Get texture source rectangle that is used for shapes drawing"
	(rl.GetShapesTextureRectangle ))

; Basic shapes drawing functions
(fn draw-pixel [pos-x pos-y color]
	"Draw a pixel using geometry [Can be slow, use with care]"
	(rl.DrawPixel pos-x pos-y color))

(fn draw-pixel-v [position color]
	"Draw a pixel using geometry (Vector version) [Can be slow, use with care]"
	(rl.DrawPixelV position color))

(fn draw-line [start-pos-x start-pos-y end-pos-x end-pos-y color]
	"Draw a line"
	(rl.DrawLine start-pos-x start-pos-y end-pos-x end-pos-y color))

(fn draw-line-v [start-pos end-pos color]
	"Draw a line (using gl lines)"
	(rl.DrawLineV start-pos end-pos color))

(fn draw-line-ex [start-pos end-pos thick color]
	"Draw a line (using triangles/quads)"
	(rl.DrawLineEx start-pos end-pos thick color))

(fn draw-line-strip [points point-count color]
	"Draw lines sequence (using gl lines)"
	(rl.DrawLineStrip points point-count color))

(fn draw-line-bezier [start-pos end-pos thick color]
	"Draw line segment cubic-bezier in-out interpolation"
	(rl.DrawLineBezier start-pos end-pos thick color))

(fn draw-circle [center-x center-y radius color]
	"Draw a color-filled circle"
	(rl.DrawCircle center-x center-y radius color))

(fn draw-circle-sector [center radius start-angle end-angle segments color]
	"Draw a piece of a circle"
	(rl.DrawCircleSector center radius start-angle end-angle segments color))

(fn draw-circle-sector-lines [center radius start-angle end-angle segments color]
	"Draw circle sector outline"
	(rl.DrawCircleSectorLines center radius start-angle end-angle segments color))

(fn draw-circle-gradient [center-x center-y radius inner outer]
	"Draw a gradient-filled circle"
	(rl.DrawCircleGradient center-x center-y radius inner outer))

(fn draw-circle-v [center radius color]
	"Draw a color-filled circle (Vector version)"
	(rl.DrawCircleV center radius color))

(fn draw-circle-lines [center-x center-y radius color]
	"Draw circle outline"
	(rl.DrawCircleLines center-x center-y radius color))

(fn draw-circle-lines-v [center radius color]
	"Draw circle outline (Vector version)"
	(rl.DrawCircleLinesV center radius color))

(fn draw-ellipse [center-x center-y radius-h radius-v color]
	"Draw ellipse"
	(rl.DrawEllipse center-x center-y radius-h radius-v color))

(fn draw-ellipse-lines [center-x center-y radius-h radius-v color]
	"Draw ellipse outline"
	(rl.DrawEllipseLines center-x center-y radius-h radius-v color))

(fn draw-ring [center inner-radius outer-radius start-angle end-angle segments color]
	"Draw ring"
	(rl.DrawRing center inner-radius outer-radius start-angle end-angle segments color))

(fn draw-ring-lines [center inner-radius outer-radius start-angle end-angle segments color]
	"Draw ring outline"
	(rl.DrawRingLines center inner-radius outer-radius start-angle end-angle segments color))

(fn draw-rectangle [pos-x pos-y width height color]
	"Draw a color-filled rectangle"
	(rl.DrawRectangle pos-x pos-y width height color))

(fn draw-rectangle-v [position size color]
	"Draw a color-filled rectangle (Vector version)"
	(rl.DrawRectangleV position size color))

(fn draw-rectangle-rec [rec color]
	"Draw a color-filled rectangle"
	(rl.DrawRectangleRec rec color))

(fn draw-rectangle-pro [rec origin rotation color]
	"Draw a color-filled rectangle with pro parameters"
	(rl.DrawRectanglePro rec origin rotation color))

(fn draw-rectangle-gradient-v [pos-x pos-y width height top bottom]
	"Draw a vertical-gradient-filled rectangle"
	(rl.DrawRectangleGradientV pos-x pos-y width height top bottom))

(fn draw-rectangle-gradient-h [pos-x pos-y width height left right]
	"Draw a horizontal-gradient-filled rectangle"
	(rl.DrawRectangleGradientH pos-x pos-y width height left right))

(fn draw-rectangle-gradient-ex [rec top-left bottom-left top-right bottom-right]
	"Draw a gradient-filled rectangle with custom vertex colors"
	(rl.DrawRectangleGradientEx rec top-left bottom-left top-right bottom-right))

(fn draw-rectangle-lines [pos-x pos-y width height color]
	"Draw rectangle outline"
	(rl.DrawRectangleLines pos-x pos-y width height color))

(fn draw-rectangle-lines-ex [rec line-thick color]
	"Draw rectangle outline with extended parameters"
	(rl.DrawRectangleLinesEx rec line-thick color))

(fn draw-rectangle-rounded [rec roundness segments color]
	"Draw rectangle with rounded edges"
	(rl.DrawRectangleRounded rec roundness segments color))

(fn draw-rectangle-rounded-lines [rec roundness segments color]
	"Draw rectangle lines with rounded edges"
	(rl.DrawRectangleRoundedLines rec roundness segments color))

(fn draw-rectangle-rounded-lines-ex [rec roundness segments line-thick color]
	"Draw rectangle with rounded edges outline"
	(rl.DrawRectangleRoundedLinesEx rec roundness segments line-thick color))

(fn draw-triangle [v1 v2 v3 color]
	"Draw a color-filled triangle (vertex in counter-clockwise order!)"
	(rl.DrawTriangle v1 v2 v3 color))

(fn draw-triangle-lines [v1 v2 v3 color]
	"Draw triangle outline (vertex in counter-clockwise order!)"
	(rl.DrawTriangleLines v1 v2 v3 color))

(fn draw-triangle-fan [points point-count color]
	"Draw a triangle fan defined by points (first vertex is the center)"
	(rl.DrawTriangleFan points point-count color))

(fn draw-triangle-strip [points point-count color]
	"Draw a triangle strip defined by points"
	(rl.DrawTriangleStrip points point-count color))

(fn draw-poly [center sides radius rotation color]
	"Draw a regular polygon (Vector version)"
	(rl.DrawPoly center sides radius rotation color))

(fn draw-poly-lines [center sides radius rotation color]
	"Draw a polygon outline of n sides"
	(rl.DrawPolyLines center sides radius rotation color))

(fn draw-poly-lines-ex [center sides radius rotation line-thick color]
	"Draw a polygon outline of n sides with extended parameters"
	(rl.DrawPolyLinesEx center sides radius rotation line-thick color))

; Splines drawing functions
(fn draw-spline-linear [points point-count thick color]
	"Draw spline: Linear, minimum 2 points"
	(rl.DrawSplineLinear points point-count thick color))

(fn draw-spline-basis [points point-count thick color]
	"Draw spline: B-Spline, minimum 4 points"
	(rl.DrawSplineBasis points point-count thick color))

(fn draw-spline-catmull-rom [points point-count thick color]
	"Draw spline: Catmull-Rom, minimum 4 points"
	(rl.DrawSplineCatmullRom points point-count thick color))

(fn draw-spline-bezier-quadratic [points point-count thick color]
	"Draw spline: Quadratic Bezier, minimum 3 points (1 control point): [p1, c2, p3, c4...]"
	(rl.DrawSplineBezierQuadratic points point-count thick color))

(fn draw-spline-bezier-cubic [points point-count thick color]
	"Draw spline: Cubic Bezier, minimum 4 points (2 control points): [p1, c2, c3, p4, c5, c6...]"
	(rl.DrawSplineBezierCubic points point-count thick color))

(fn draw-spline-segment-linear [p1 p2 thick color]
	"Draw spline segment: Linear, 2 points"
	(rl.DrawSplineSegmentLinear p1 p2 thick color))

(fn draw-spline-segment-basis [p1 p2 p3 p4 thick color]
	"Draw spline segment: B-Spline, 4 points"
	(rl.DrawSplineSegmentBasis p1 p2 p3 p4 thick color))

(fn draw-spline-segment-catmull-rom [p1 p2 p3 p4 thick color]
	"Draw spline segment: Catmull-Rom, 4 points"
	(rl.DrawSplineSegmentCatmullRom p1 p2 p3 p4 thick color))

(fn draw-spline-segment-bezier-quadratic [p1 c2 p3 thick color]
	"Draw spline segment: Quadratic Bezier, 2 points, 1 control point"
	(rl.DrawSplineSegmentBezierQuadratic p1 c2 p3 thick color))

(fn draw-spline-segment-bezier-cubic [p1 c2 c3 p4 thick color]
	"Draw spline segment: Cubic Bezier, 2 points, 2 control points"
	(rl.DrawSplineSegmentBezierCubic p1 c2 c3 p4 thick color))

; Spline segment point evaluation functions, for a given t [0.0f .. 1.0f]
(fn get-spline-point-linear [start-pos end-pos t]
	"Get (evaluate) spline point: Linear"
	(rl.GetSplinePointLinear start-pos end-pos t))

(fn get-spline-point-basis [p1 p2 p3 p4 t]
	"Get (evaluate) spline point: B-Spline"
	(rl.GetSplinePointBasis p1 p2 p3 p4 t))

(fn get-spline-point-catmull-rom [p1 p2 p3 p4 t]
	"Get (evaluate) spline point: Catmull-Rom"
	(rl.GetSplinePointCatmullRom p1 p2 p3 p4 t))

(fn get-spline-point-bezier-quad [p1 c2 p3 t]
	"Get (evaluate) spline point: Quadratic Bezier"
	(rl.GetSplinePointBezierQuad p1 c2 p3 t))

(fn get-spline-point-bezier-cubic [p1 c2 c3 p4 t]
	"Get (evaluate) spline point: Cubic Bezier"
	(rl.GetSplinePointBezierCubic p1 c2 c3 p4 t))

; Basic shapes collision detection functions
(fn check-collision-recs [rec1 rec2]
	"Check collision between two rectangles"
	(rl.CheckCollisionRecs rec1 rec2))

(fn check-collision-circles [center1 radius1 center2 radius2]
	"Check collision between two circles"
	(rl.CheckCollisionCircles center1 radius1 center2 radius2))

(fn check-collision-circle-rec [center radius rec]
	"Check collision between circle and rectangle"
	(rl.CheckCollisionCircleRec center radius rec))

(fn check-collision-circle-line [center radius p1 p2]
	"Check if circle collides with a line created betweeen two points [p1] and [p2]"
	(rl.CheckCollisionCircleLine center radius p1 p2))

(fn check-collision-point-rec [point rec]
	"Check if point is inside rectangle"
	(rl.CheckCollisionPointRec point rec))

(fn check-collision-point-circle [point center radius]
	"Check if point is inside circle"
	(rl.CheckCollisionPointCircle point center radius))

(fn check-collision-point-triangle [point p1 p2 p3]
	"Check if point is inside a triangle"
	(rl.CheckCollisionPointTriangle point p1 p2 p3))

(fn check-collision-point-line [point p1 p2 threshold]
	"Check if point belongs to line created between two points [p1] and [p2] with defined margin in pixels [threshold]"
	(rl.CheckCollisionPointLine point p1 p2 threshold))

(fn check-collision-point-poly [point points point-count]
	"Check if point is within a polygon described by array of vertices"
	(rl.CheckCollisionPointPoly point points point-count))

(fn check-collision-lines [start-pos1 end-pos1 start-pos2 end-pos2 collision-point]
	"Check the collision between two lines defined by two points each, returns collision point by reference"
	(rl.CheckCollisionLines start-pos1 end-pos1 start-pos2 end-pos2 collision-point))

(fn get-collision-rec [rec1 rec2]
	"Get collision rectangle for two rectangles collision"
	(rl.GetCollisionRec rec1 rec2))

{: set-shapes-texture
 : get-shapes-texture
 : get-shapes-texture-rectangle
 : draw-pixel
 : draw-pixel-v
 : draw-line
 : draw-line-v
 : draw-line-ex
 : draw-line-strip
 : draw-line-bezier
 : draw-circle
 : draw-circle-sector
 : draw-circle-sector-lines
 : draw-circle-gradient
 : draw-circle-v
 : draw-circle-lines
 : draw-circle-lines-v
 : draw-ellipse
 : draw-ellipse-lines
 : draw-ring
 : draw-ring-lines
 : draw-rectangle
 : draw-rectangle-v
 : draw-rectangle-rec
 : draw-rectangle-pro
 : draw-rectangle-gradient-v
 : draw-rectangle-gradient-h
 : draw-rectangle-gradient-ex
 : draw-rectangle-lines
 : draw-rectangle-lines-ex
 : draw-rectangle-rounded
 : draw-rectangle-rounded-lines
 : draw-rectangle-rounded-lines-ex
 : draw-triangle
 : draw-triangle-lines
 : draw-triangle-fan
 : draw-triangle-strip
 : draw-poly
 : draw-poly-lines
 : draw-poly-lines-ex
 : draw-spline-linear
 : draw-spline-basis
 : draw-spline-catmull-rom
 : draw-spline-bezier-quadratic
 : draw-spline-bezier-cubic
 : draw-spline-segment-linear
 : draw-spline-segment-basis
 : draw-spline-segment-catmull-rom
 : draw-spline-segment-bezier-quadratic
 : draw-spline-segment-bezier-cubic
 : get-spline-point-linear
 : get-spline-point-basis
 : get-spline-point-catmull-rom
 : get-spline-point-bezier-quad
 : get-spline-point-bezier-cubic
 : check-collision-recs
 : check-collision-circles
 : check-collision-circle-rec
 : check-collision-circle-line
 : check-collision-point-rec
 : check-collision-point-circle
 : check-collision-point-triangle
 : check-collision-point-line
 : check-collision-point-poly
 : check-collision-lines
 : get-collision-rec}