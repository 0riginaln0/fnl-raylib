(print "RAYLIB TEXTURES INIT: STARTED")
(local safe-mode true)

(local ffi (require :ffi))

(local os ffi.os)
(print os)

(local rl 
  (case os 
    :Windows (ffi.load :lib\raylib-5.5_win64_mingw-w64\lib\raylib.dll) 
    :Linux   (ffi.load :lib/raylib-5.5_linux_amd64/lib/libraylib.so)))
(assert (= rl nil) "Unknown OS. Sorry")

;------------------------------------------------------------------------------------
; Texture Loading and Drawing Functions (Module: textures)
;------------------------------------------------------------------------------------
; Image loading functions
; NOTE: These functions do not require GPU access
(fn load-image [file-name]
	"Load image from file into CPU memory (RAM)"
	(rl.LoadImage file-name))

(fn load-image-raw [file-name width height format header-size]
	"Load image from RAW file data"
	(rl.LoadImageRaw file-name width height format header-size))

(fn load-image-anim [file-name frames]
	"Load image sequence from file (frames appended to image.data)"
	(rl.LoadImageAnim file-name frames))

(fn load-image-anim-from-memory [file-type file-data data-size frames]
	"Load image sequence from memory buffer"
	(rl.LoadImageAnimFromMemory file-type file-data data-size frames))

(fn load-image-from-memory [file-type file-data data-size]
	"Load image from memory buffer, fileType refers to extension: i.e. '.png'"
	(rl.LoadImageFromMemory file-type file-data data-size))

(fn load-image-from-texture [texture]
	"Load image from GPU texture data"
	(rl.LoadImageFromTexture texture))

(fn load-image-from-screen []
	"Load image from screen buffer and (screenshot)"
	(rl.LoadImageFromScreen ))

(fn is-image-valid [image]
	"Check if an image is valid (data and parameters)"
	(rl.IsImageValid image))

(fn unload-image [image]
	"Unload image from CPU memory (RAM)"
	(rl.UnloadImage image))

(fn export-image [image file-name]
	"Export image data to file, returns true on success"
	(rl.ExportImage image file-name))

(fn export-image-to-memory [image file-type file-size]
	"Export image to memory buffer"
	(rl.ExportImageToMemory image file-type file-size))

(fn export-image-as-code [image file-name]
	"Export image as code file defining an array of bytes, returns true on success"
	(rl.ExportImageAsCode image file-name))

; Image generation functions
(fn gen-image-color [width height color]
	"Generate image: plain color"
	(rl.GenImageColor width height color))

(fn gen-image-gradient-linear [width height direction start end]
	"Generate image: linear gradient, direction in degrees [0..360], 0=Vertical gradient"
	(rl.GenImageGradientLinear width height direction start end))

(fn gen-image-gradient-radial [width height density inner outer]
	"Generate image: radial gradient"
	(rl.GenImageGradientRadial width height density inner outer))

(fn gen-image-gradient-square [width height density inner outer]
	"Generate image: square gradient"
	(rl.GenImageGradientSquare width height density inner outer))

(fn gen-image-checked [width height checks-x checks-y col1 col2]
	"Generate image: checked"
	(rl.GenImageChecked width height checks-x checks-y col1 col2))

(fn gen-image-white-noise [width height factor]
	"Generate image: white noise"
	(rl.GenImageWhiteNoise width height factor))

(fn gen-image-perlin-noise [width height offset-x offset-y scale]
	"Generate image: perlin noise"
	(rl.GenImagePerlinNoise width height offset-x offset-y scale))

(fn gen-image-cellular [width height tile-size]
	"Generate image: cellular algorithm, bigger tileSize means bigger cells"
	(rl.GenImageCellular width height tile-size))

(fn gen-image-text [width height text]
	"Generate image: grayscale image from text data"
	(rl.GenImageText width height text))

; Image manipulation functions
(fn image-copy [image]
	"Create an image duplicate (useful for transformations)"
	(rl.ImageCopy image))

(fn image-from-image [image rec]
	"Create an image from another image piece"
	(rl.ImageFromImage image rec))

(fn image-from-channel [image selected-channel]
	"Create an image from a selected channel of another image (GRAYSCALE)"
	(rl.ImageFromChannel image selected-channel))

(fn image-text [text font-size color]
	"Create an image from text (default font)"
	(rl.ImageText text font-size color))

(fn image-text-ex [font text font-size spacing tint]
	"Create an image from text (custom sprite font)"
	(rl.ImageTextEx font text font-size spacing tint))

(fn image-format [image new-format]
	"Convert image data to desired format"
	(rl.ImageFormat image new-format))

(fn image-to-pot [image fill]
	"Convert image to POT (power-of-two)"
	(rl.ImageToPOT image fill))

(fn image-crop [image crop]
	"Crop an image to a defined rectangle"
	(rl.ImageCrop image crop))

(fn image-alpha-crop [image threshold]
	"Crop image depending on alpha value"
	(rl.ImageAlphaCrop image threshold))

(fn image-alpha-clear [image color threshold]
	"Clear alpha channel to desired color"
	(rl.ImageAlphaClear image color threshold))

(fn image-alpha-mask [image alpha-mask]
	"Apply alpha mask to image"
	(rl.ImageAlphaMask image alpha-mask))

(fn image-alpha-premultiply [image]
	"Premultiply alpha channel"
	(rl.ImageAlphaPremultiply image))

(fn image-blur-gaussian [image blur-size]
	"Apply Gaussian blur using a box blur approximation"
	(rl.ImageBlurGaussian image blur-size))

(fn image-kernel-convolution [image kernel kernel-size]
	"Apply custom square convolution kernel to image"
	(rl.ImageKernelConvolution image kernel kernel-size))

(fn image-resize [image new-width new-height]
	"Resize image (Bicubic scaling algorithm)"
	(rl.ImageResize image new-width new-height))

(fn image-resize-nn [image new-width new-height]
	"Resize image (Nearest-Neighbor scaling algorithm)"
	(rl.ImageResizeNN image new-width new-height))

(fn image-resize-canvas [image new-width new-height offset-x offset-y fill]
	"Resize canvas and fill with color"
	(rl.ImageResizeCanvas image new-width new-height offset-x offset-y fill))

(fn image-mipmaps [image]
	"Compute all mipmap levels for a provided image"
	(rl.ImageMipmaps image))

(fn image-dither [image r-bpp g-bpp b-bpp a-bpp]
	"Dither image data to 16bpp or lower (Floyd-Steinberg dithering)"
	(rl.ImageDither image r-bpp g-bpp b-bpp a-bpp))

(fn image-flip-vertical [image]
	"Flip image vertically"
	(rl.ImageFlipVertical image))

(fn image-flip-horizontal [image]
	"Flip image horizontally"
	(rl.ImageFlipHorizontal image))

(fn image-rotate [image degrees]
	"Rotate image by input angle in degrees (-359 to 359)"
	(rl.ImageRotate image degrees))

(fn image-rotate-cw [image]
	"Rotate image clockwise 90deg"
	(rl.ImageRotateCW image))

(fn image-rotate-ccw [image]
	"Rotate image counter-clockwise 90deg"
	(rl.ImageRotateCCW image))

(fn image-color-tint [image color]
	"Modify image color: tint"
	(rl.ImageColorTint image color))

(fn image-color-invert [image]
	"Modify image color: invert"
	(rl.ImageColorInvert image))

(fn image-color-grayscale [image]
	"Modify image color: grayscale"
	(rl.ImageColorGrayscale image))

(fn image-color-contrast [image contrast]
	"Modify image color: contrast (-100 to 100)"
	(rl.ImageColorContrast image contrast))

(fn image-color-brightness [image brightness]
	"Modify image color: brightness (-255 to 255)"
	(rl.ImageColorBrightness image brightness))

(fn image-color-replace [image color replace]
	"Modify image color: replace color"
	(rl.ImageColorReplace image color replace))

(fn load-image-colors [image]
	"Load color data from image as a Color array (RGBA - 32bit)"
	(rl.LoadImageColors image))

(fn load-image-palette [image max-palette-size color-count]
	"Load colors palette from image as a Color array (RGBA - 32bit)"
	(rl.LoadImagePalette image max-palette-size color-count))

(fn unload-image-colors [colors]
	"Unload color data loaded with LoadImageColors()"
	(rl.UnloadImageColors colors))

(fn unload-image-palette [colors]
	"Unload colors palette loaded with LoadImagePalette()"
	(rl.UnloadImagePalette colors))

(fn get-image-alpha-border [image threshold]
	"Get image alpha border rectangle"
	(rl.GetImageAlphaBorder image threshold))

(fn get-image-color [image x y]
	"Get image pixel color at (x, y) position"
	(rl.GetImageColor image x y))

; Image drawing functions
; NOTE: Image software-rendering functions (CPU)
(fn image-clear-background [dst color]
	"Clear image background with given color"
	(rl.ImageClearBackground dst color))

(fn image-draw-pixel [dst pos-x pos-y color]
	"Draw pixel within an image"
	(rl.ImageDrawPixel dst pos-x pos-y color))

(fn image-draw-pixel-v [dst position color]
	"Draw pixel within an image (Vector version)"
	(rl.ImageDrawPixelV dst position color))

(fn image-draw-line [dst start-pos-x start-pos-y end-pos-x end-pos-y color]
	"Draw line within an image"
	(rl.ImageDrawLine dst start-pos-x start-pos-y end-pos-x end-pos-y color))

(fn image-draw-line-v [dst start end color]
	"Draw line within an image (Vector version)"
	(rl.ImageDrawLineV dst start end color))

(fn image-draw-line-ex [dst start end thick color]
	"Draw a line defining thickness within an image"
	(rl.ImageDrawLineEx dst start end thick color))

(fn image-draw-circle [dst center-x center-y radius color]
	"Draw a filled circle within an image"
	(rl.ImageDrawCircle dst center-x center-y radius color))

(fn image-draw-circle-v [dst center radius color]
	"Draw a filled circle within an image (Vector version)"
	(rl.ImageDrawCircleV dst center radius color))

(fn image-draw-circle-lines [dst center-x center-y radius color]
	"Draw circle outline within an image"
	(rl.ImageDrawCircleLines dst center-x center-y radius color))

(fn image-draw-circle-lines-v [dst center radius color]
	"Draw circle outline within an image (Vector version)"
	(rl.ImageDrawCircleLinesV dst center radius color))

(fn image-draw-rectangle [dst pos-x pos-y width height color]
	"Draw rectangle within an image"
	(rl.ImageDrawRectangle dst pos-x pos-y width height color))

(fn image-draw-rectangle-v [dst position size color]
	"Draw rectangle within an image (Vector version)"
	(rl.ImageDrawRectangleV dst position size color))

(fn image-draw-rectangle-rec [dst rec color]
	"Draw rectangle within an image"
	(rl.ImageDrawRectangleRec dst rec color))

(fn image-draw-rectangle-lines [dst rec thick color]
	"Draw rectangle lines within an image"
	(rl.ImageDrawRectangleLines dst rec thick color))

(fn image-draw-triangle [dst v1 v2 v3 color]
	"Draw triangle within an image"
	(rl.ImageDrawTriangle dst v1 v2 v3 color))

(fn image-draw-triangle-ex [dst v1 v2 v3 c1 c2 c3]
	"Draw triangle with interpolated colors within an image"
	(rl.ImageDrawTriangleEx dst v1 v2 v3 c1 c2 c3))

(fn image-draw-triangle-lines [dst v1 v2 v3 color]
	"Draw triangle outline within an image"
	(rl.ImageDrawTriangleLines dst v1 v2 v3 color))

(fn image-draw-triangle-fan [dst points point-count color]
	"Draw a triangle fan defined by points within an image (first vertex is the center)"
	(rl.ImageDrawTriangleFan dst points point-count color))

(fn image-draw-triangle-strip [dst points point-count color]
	"Draw a triangle strip defined by points within an image"
	(rl.ImageDrawTriangleStrip dst points point-count color))

(fn image-draw [dst src src-rec dst-rec tint]
	"Draw a source image within a destination image (tint applied to source)"
	(rl.ImageDraw dst src src-rec dst-rec tint))

(fn image-draw-text [dst text pos-x pos-y font-size color]
	"Draw text (using default font) within an image (destination)"
	(rl.ImageDrawText dst text pos-x pos-y font-size color))

(fn image-draw-text-ex [dst font text position font-size spacing tint]
	"Draw text (custom sprite font) within an image (destination)"
	(rl.ImageDrawTextEx dst font text position font-size spacing tint))

; Texture loading functions
; NOTE: These functions require GPU access
(fn load-texture [file-name]
	"Load texture from file into GPU memory (VRAM)"
	(rl.LoadTexture file-name))

(fn load-texture-from-image [image]
	"Load texture from image data"
	(rl.LoadTextureFromImage image))

(fn load-texture-cubemap [image layout]
	"Load cubemap from image, multiple image cubemap layouts supported"
	(rl.LoadTextureCubemap image layout))

(fn load-render-texture [width height]
	"Load texture for rendering (framebuffer)"
	(rl.LoadRenderTexture width height))

(fn is-texture-valid [texture]
	"Check if a texture is valid (loaded in GPU)"
	(rl.IsTextureValid texture))

(fn unload-texture [texture]
	"Unload texture from GPU memory (VRAM)"
	(rl.UnloadTexture texture))

(fn is-render-texture-valid [target]
	"Check if a render texture is valid (loaded in GPU)"
	(rl.IsRenderTextureValid target))

(fn unload-render-texture [target]
	"Unload render texture from GPU memory (VRAM)"
	(rl.UnloadRenderTexture target))

(fn update-texture [texture pixels]
	"Update GPU texture with new data"
	(rl.UpdateTexture texture pixels))

(fn update-texture-rec [texture rec pixels]
	"Update GPU texture rectangle with new data"
	(rl.UpdateTextureRec texture rec pixels))

; Texture configuration functions
(fn gen-texture-mipmaps [texture]
	"Generate GPU mipmaps for a texture"
	(rl.GenTextureMipmaps texture))

(fn set-texture-filter [texture filter]
	"Set texture scaling filter mode"
	(rl.SetTextureFilter texture filter))

(fn set-texture-wrap [texture wrap]
	"Set texture wrapping mode"
	(rl.SetTextureWrap texture wrap))

; Texture drawing functions
(fn draw-texture [texture pos-x pos-y tint]
	"Draw a Texture2D"
	(rl.DrawTexture texture pos-x pos-y tint))

(fn draw-texture-v [texture position tint]
	"Draw a Texture2D with position defined as Vector2"
	(rl.DrawTextureV texture position tint))

(fn draw-texture-ex [texture position rotation scale tint]
	"Draw a Texture2D with extended parameters"
	(rl.DrawTextureEx texture position rotation scale tint))

(fn draw-texture-rec [texture source position tint]
	"Draw a part of a texture defined by a rectangle"
	(rl.DrawTextureRec texture source position tint))

(fn draw-texture-pro [texture source dest origin rotation tint]
	"Draw a part of a texture defined by a rectangle with 'pro' parameters"
	(rl.DrawTexturePro texture source dest origin rotation tint))

(fn draw-texture-npatch [texture n-patch-info dest origin rotation tint]
	"Draws a texture (or part of it) that stretches or shrinks nicely"
	(rl.DrawTextureNPatch texture n-patch-info dest origin rotation tint))

; Color/pixel related functions
(fn color-is-equal [col1 col2]
	"Check if two colors are equal"
	(rl.ColorIsEqual col1 col2))

(fn fade [color alpha]
	"Get color with alpha applied, alpha goes from 0.0f to 1.0f"
	(rl.Fade color alpha))

(fn color-to-int [color]
	"Get hexadecimal value for a Color (0xRRGGBBAA)"
	(rl.ColorToInt color))

(fn color-normalize [color]
	"Get Color normalized as float [0..1]"
	(rl.ColorNormalize color))

(fn color-from-normalized [normalized]
	"Get Color from normalized values [0..1]"
	(rl.ColorFromNormalized normalized))

(fn color-to-hsv [color]
	"Get HSV values for a Color, hue [0..360], saturation/value [0..1]"
	(rl.ColorToHSV color))

(fn color-from-hsv [hue saturation value]
	"Get a Color from HSV values, hue [0..360], saturation/value [0..1]"
	(rl.ColorFromHSV hue saturation value))

(fn color-tint [color tint]
	"Get color multiplied with another color"
	(rl.ColorTint color tint))

(fn color-brightness [color factor]
	"Get color with brightness correction, brightness factor goes from -1.0f to 1.0f"
	(rl.ColorBrightness color factor))

(fn color-contrast [color contrast]
	"Get color with contrast correction, contrast values between -1.0f and 1.0f"
	(rl.ColorContrast color contrast))

(fn color-alpha [color alpha]
	"Get color with alpha applied, alpha goes from 0.0f to 1.0f"
	(rl.ColorAlpha color alpha))

(fn color-alpha-blend [dst src tint]
	"Get src alpha-blended into dst color with tint"
	(rl.ColorAlphaBlend dst src tint))

(fn color-lerp [color1 color2 factor]
	"Get color lerp interpolation between two colors, factor [0.0f..1.0f]"
	(rl.ColorLerp color1 color2 factor))

(fn get-color [hex-value]
	"Get Color structure from hexadecimal value"
	(rl.GetColor hex-value))

(fn get-pixel-color [src-ptr format]
	"Get Color from a source pixel pointer of certain format"
	(rl.GetPixelColor src-ptr format))

(fn set-pixel-color [dst-ptr color format]
	"Set color formatted into destination pixel pointer"
	(rl.SetPixelColor dst-ptr color format))

(fn get-pixel-data-size [width height format]
	"Get pixel data size in bytes for certain format"
	(rl.GetPixelDataSize width height format))


{: load-image
 : load-image-raw
 : load-image-anim
 : load-image-anim-from-memory
 : load-image-from-memory
 : load-image-from-texture
 : load-image-from-screen
 : is-image-valid
 : unload-image
 : export-image
 : export-image-to-memory
 : export-image-as-code
 : gen-image-color
 : gen-image-gradient-linear
 : gen-image-gradient-radial
 : gen-image-gradient-square
 : gen-image-checked
 : gen-image-white-noise
 : gen-image-perlin-noise
 : gen-image-cellular
 : gen-image-text
 : image-copy
 : image-from-image
 : image-from-channel
 : image-text
 : image-text-ex
 : image-format
 : image-to-pot
 : image-crop
 : image-alpha-crop
 : image-alpha-clear
 : image-alpha-mask
 : image-alpha-premultiply
 : image-blur-gaussian
 : image-kernel-convolution
 : image-resize
 : image-resize-nn
 : image-resize-canvas
 : image-mipmaps
 : image-dither
 : image-flip-vertical
 : image-flip-horizontal
 : image-rotate
 : image-rotate-cw
 : image-rotate-ccw
 : image-color-tint
 : image-color-invert
 : image-color-grayscale
 : image-color-contrast
 : image-color-brightness
 : image-color-replace
 : load-image-colors
 : load-image-palette
 : unload-image-colors
 : unload-image-palette
 : get-image-alpha-border
 : get-image-color
 : image-clear-background
 : image-draw-pixel
 : image-draw-pixel-v
 : image-draw-line
 : image-draw-line-v
 : image-draw-line-ex
 : image-draw-circle
 : image-draw-circle-v
 : image-draw-circle-lines
 : image-draw-circle-lines-v
 : image-draw-rectangle
 : image-draw-rectangle-v
 : image-draw-rectangle-rec
 : image-draw-rectangle-lines
 : image-draw-triangle
 : image-draw-triangle-ex
 : image-draw-triangle-lines
 : image-draw-triangle-fan
 : image-draw-triangle-strip
 : image-draw
 : image-draw-text
 : image-draw-text-ex
 : load-texture
 : load-texture-from-image
 : load-texture-cubemap
 : load-render-texture
 : is-texture-valid
 : unload-texture
 : is-render-texture-valid
 : unload-render-texture
 : update-texture
 : update-texture-rec
 : gen-texture-mipmaps
 : set-texture-filter
 : set-texture-wrap
 : draw-texture
 : draw-texture-v
 : draw-texture-ex
 : draw-texture-rec
 : draw-texture-pro
 : draw-texture-npatch
 : color-is-equal
 : fade
 : color-to-int
 : color-normalize
 : color-from-normalized
 : color-to-hsv
 : color-from-hsv
 : color-tint
 : color-brightness
 : color-contrast
 : color-alpha
 : color-alpha-blend
 : color-lerp
 : get-color
 : get-pixel-color
 : set-pixel-color
 : get-pixel-data-size}