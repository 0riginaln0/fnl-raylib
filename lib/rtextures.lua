print("RAYLIB TEXTURES INIT: STARTED")
local safe_mode = true
local ffi = require("ffi")
local os = ffi.os
print(os)
local rl
if (os == "Windows") then
  rl = ffi.load("lib\\raylib-5.5_win64_mingw-w64\\lib\\raylib.dll")
elseif (os == "Linux") then
  rl = ffi.load("lib/raylib-5.5_linux_amd64/lib/libraylib.so")
else
  rl = nil
end
assert((rl == nil), "Unknown OS. Sorry")
local function load_image(file_name)
  return rl.LoadImage(file_name)
end
local function load_image_raw(file_name, width, height, format, header_size)
  return rl.LoadImageRaw(file_name, width, height, format, header_size)
end
local function load_image_anim(file_name, frames)
  return rl.LoadImageAnim(file_name, frames)
end
local function load_image_anim_from_memory(file_type, file_data, data_size, frames)
  return rl.LoadImageAnimFromMemory(file_type, file_data, data_size, frames)
end
local function load_image_from_memory(file_type, file_data, data_size)
  return rl.LoadImageFromMemory(file_type, file_data, data_size)
end
local function load_image_from_texture(texture)
  return rl.LoadImageFromTexture(texture)
end
local function load_image_from_screen()
  return rl.LoadImageFromScreen()
end
local function is_image_valid(image)
  return rl.IsImageValid(image)
end
local function unload_image(image)
  return rl.UnloadImage(image)
end
local function export_image(image, file_name)
  return rl.ExportImage(image, file_name)
end
local function export_image_to_memory(image, file_type, file_size)
  return rl.ExportImageToMemory(image, file_type, file_size)
end
local function export_image_as_code(image, file_name)
  return rl.ExportImageAsCode(image, file_name)
end
local function gen_image_color(width, height, color)
  return rl.GenImageColor(width, height, color)
end
local function gen_image_gradient_linear(width, height, direction, start, _end)
  return rl.GenImageGradientLinear(width, height, direction, start, _end)
end
local function gen_image_gradient_radial(width, height, density, inner, outer)
  return rl.GenImageGradientRadial(width, height, density, inner, outer)
end
local function gen_image_gradient_square(width, height, density, inner, outer)
  return rl.GenImageGradientSquare(width, height, density, inner, outer)
end
local function gen_image_checked(width, height, checks_x, checks_y, col1, col2)
  return rl.GenImageChecked(width, height, checks_x, checks_y, col1, col2)
end
local function gen_image_white_noise(width, height, factor)
  return rl.GenImageWhiteNoise(width, height, factor)
end
local function gen_image_perlin_noise(width, height, offset_x, offset_y, scale)
  return rl.GenImagePerlinNoise(width, height, offset_x, offset_y, scale)
end
local function gen_image_cellular(width, height, tile_size)
  return rl.GenImageCellular(width, height, tile_size)
end
local function gen_image_text(width, height, text)
  return rl.GenImageText(width, height, text)
end
local function image_copy(image)
  return rl.ImageCopy(image)
end
local function image_from_image(image, rec)
  return rl.ImageFromImage(image, rec)
end
local function image_from_channel(image, selected_channel)
  return rl.ImageFromChannel(image, selected_channel)
end
local function image_text(text, font_size, color)
  return rl.ImageText(text, font_size, color)
end
local function image_text_ex(font, text, font_size, spacing, tint)
  return rl.ImageTextEx(font, text, font_size, spacing, tint)
end
local function image_format(image, new_format)
  return rl.ImageFormat(image, new_format)
end
local function image_to_pot(image, fill)
  return rl.ImageToPOT(image, fill)
end
local function image_crop(image, crop)
  return rl.ImageCrop(image, crop)
end
local function image_alpha_crop(image, threshold)
  return rl.ImageAlphaCrop(image, threshold)
end
local function image_alpha_clear(image, color, threshold)
  return rl.ImageAlphaClear(image, color, threshold)
end
local function image_alpha_mask(image, alpha_mask)
  return rl.ImageAlphaMask(image, alpha_mask)
end
local function image_alpha_premultiply(image)
  return rl.ImageAlphaPremultiply(image)
end
local function image_blur_gaussian(image, blur_size)
  return rl.ImageBlurGaussian(image, blur_size)
end
local function image_kernel_convolution(image, kernel, kernel_size)
  return rl.ImageKernelConvolution(image, kernel, kernel_size)
end
local function image_resize(image, new_width, new_height)
  return rl.ImageResize(image, new_width, new_height)
end
local function image_resize_nn(image, new_width, new_height)
  return rl.ImageResizeNN(image, new_width, new_height)
end
local function image_resize_canvas(image, new_width, new_height, offset_x, offset_y, fill)
  return rl.ImageResizeCanvas(image, new_width, new_height, offset_x, offset_y, fill)
end
local function image_mipmaps(image)
  return rl.ImageMipmaps(image)
end
local function image_dither(image, r_bpp, g_bpp, b_bpp, a_bpp)
  return rl.ImageDither(image, r_bpp, g_bpp, b_bpp, a_bpp)
end
local function image_flip_vertical(image)
  return rl.ImageFlipVertical(image)
end
local function image_flip_horizontal(image)
  return rl.ImageFlipHorizontal(image)
end
local function image_rotate(image, degrees)
  return rl.ImageRotate(image, degrees)
end
local function image_rotate_cw(image)
  return rl.ImageRotateCW(image)
end
local function image_rotate_ccw(image)
  return rl.ImageRotateCCW(image)
end
local function image_color_tint(image, color)
  return rl.ImageColorTint(image, color)
end
local function image_color_invert(image)
  return rl.ImageColorInvert(image)
end
local function image_color_grayscale(image)
  return rl.ImageColorGrayscale(image)
end
local function image_color_contrast(image, contrast)
  return rl.ImageColorContrast(image, contrast)
end
local function image_color_brightness(image, brightness)
  return rl.ImageColorBrightness(image, brightness)
end
local function image_color_replace(image, color, replace)
  return rl.ImageColorReplace(image, color, replace)
end
local function load_image_colors(image)
  return rl.LoadImageColors(image)
end
local function load_image_palette(image, max_palette_size, color_count)
  return rl.LoadImagePalette(image, max_palette_size, color_count)
end
local function unload_image_colors(colors)
  return rl.UnloadImageColors(colors)
end
local function unload_image_palette(colors)
  return rl.UnloadImagePalette(colors)
end
local function get_image_alpha_border(image, threshold)
  return rl.GetImageAlphaBorder(image, threshold)
end
local function get_image_color(image, x, y)
  return rl.GetImageColor(image, x, y)
end
local function image_clear_background(dst, color)
  return rl.ImageClearBackground(dst, color)
end
local function image_draw_pixel(dst, pos_x, pos_y, color)
  return rl.ImageDrawPixel(dst, pos_x, pos_y, color)
end
local function image_draw_pixel_v(dst, position, color)
  return rl.ImageDrawPixelV(dst, position, color)
end
local function image_draw_line(dst, start_pos_x, start_pos_y, end_pos_x, end_pos_y, color)
  return rl.ImageDrawLine(dst, start_pos_x, start_pos_y, end_pos_x, end_pos_y, color)
end
local function image_draw_line_v(dst, start, _end, color)
  return rl.ImageDrawLineV(dst, start, _end, color)
end
local function image_draw_line_ex(dst, start, _end, thick, color)
  return rl.ImageDrawLineEx(dst, start, _end, thick, color)
end
local function image_draw_circle(dst, center_x, center_y, radius, color)
  return rl.ImageDrawCircle(dst, center_x, center_y, radius, color)
end
local function image_draw_circle_v(dst, center, radius, color)
  return rl.ImageDrawCircleV(dst, center, radius, color)
end
local function image_draw_circle_lines(dst, center_x, center_y, radius, color)
  return rl.ImageDrawCircleLines(dst, center_x, center_y, radius, color)
end
local function image_draw_circle_lines_v(dst, center, radius, color)
  return rl.ImageDrawCircleLinesV(dst, center, radius, color)
end
local function image_draw_rectangle(dst, pos_x, pos_y, width, height, color)
  return rl.ImageDrawRectangle(dst, pos_x, pos_y, width, height, color)
end
local function image_draw_rectangle_v(dst, position, size, color)
  return rl.ImageDrawRectangleV(dst, position, size, color)
end
local function image_draw_rectangle_rec(dst, rec, color)
  return rl.ImageDrawRectangleRec(dst, rec, color)
end
local function image_draw_rectangle_lines(dst, rec, thick, color)
  return rl.ImageDrawRectangleLines(dst, rec, thick, color)
end
local function image_draw_triangle(dst, v1, v2, v3, color)
  return rl.ImageDrawTriangle(dst, v1, v2, v3, color)
end
local function image_draw_triangle_ex(dst, v1, v2, v3, c1, c2, c3)
  return rl.ImageDrawTriangleEx(dst, v1, v2, v3, c1, c2, c3)
end
local function image_draw_triangle_lines(dst, v1, v2, v3, color)
  return rl.ImageDrawTriangleLines(dst, v1, v2, v3, color)
end
local function image_draw_triangle_fan(dst, points, point_count, color)
  return rl.ImageDrawTriangleFan(dst, points, point_count, color)
end
local function image_draw_triangle_strip(dst, points, point_count, color)
  return rl.ImageDrawTriangleStrip(dst, points, point_count, color)
end
local function image_draw(dst, src, src_rec, dst_rec, tint)
  return rl.ImageDraw(dst, src, src_rec, dst_rec, tint)
end
local function image_draw_text(dst, text, pos_x, pos_y, font_size, color)
  return rl.ImageDrawText(dst, text, pos_x, pos_y, font_size, color)
end
local function image_draw_text_ex(dst, font, text, position, font_size, spacing, tint)
  return rl.ImageDrawTextEx(dst, font, text, position, font_size, spacing, tint)
end
local function load_texture(file_name)
  return rl.LoadTexture(file_name)
end
local function load_texture_from_image(image)
  return rl.LoadTextureFromImage(image)
end
local function load_texture_cubemap(image, layout)
  return rl.LoadTextureCubemap(image, layout)
end
local function load_render_texture(width, height)
  return rl.LoadRenderTexture(width, height)
end
local function is_texture_valid(texture)
  return rl.IsTextureValid(texture)
end
local function unload_texture(texture)
  return rl.UnloadTexture(texture)
end
local function is_render_texture_valid(target)
  return rl.IsRenderTextureValid(target)
end
local function unload_render_texture(target)
  return rl.UnloadRenderTexture(target)
end
local function update_texture(texture, pixels)
  return rl.UpdateTexture(texture, pixels)
end
local function update_texture_rec(texture, rec, pixels)
  return rl.UpdateTextureRec(texture, rec, pixels)
end
local function gen_texture_mipmaps(texture)
  return rl.GenTextureMipmaps(texture)
end
local function set_texture_filter(texture, filter)
  return rl.SetTextureFilter(texture, filter)
end
local function set_texture_wrap(texture, wrap)
  return rl.SetTextureWrap(texture, wrap)
end
local function draw_texture(texture, pos_x, pos_y, tint)
  return rl.DrawTexture(texture, pos_x, pos_y, tint)
end
local function draw_texture_v(texture, position, tint)
  return rl.DrawTextureV(texture, position, tint)
end
local function draw_texture_ex(texture, position, rotation, scale, tint)
  return rl.DrawTextureEx(texture, position, rotation, scale, tint)
end
local function draw_texture_rec(texture, source, position, tint)
  return rl.DrawTextureRec(texture, source, position, tint)
end
local function draw_texture_pro(texture, source, dest, origin, rotation, tint)
  return rl.DrawTexturePro(texture, source, dest, origin, rotation, tint)
end
local function draw_texture_npatch(texture, n_patch_info, dest, origin, rotation, tint)
  return rl.DrawTextureNPatch(texture, n_patch_info, dest, origin, rotation, tint)
end
local function color_is_equal(col1, col2)
  return rl.ColorIsEqual(col1, col2)
end
local function fade(color, alpha)
  return rl.Fade(color, alpha)
end
local function color_to_int(color)
  return rl.ColorToInt(color)
end
local function color_normalize(color)
  return rl.ColorNormalize(color)
end
local function color_from_normalized(normalized)
  return rl.ColorFromNormalized(normalized)
end
local function color_to_hsv(color)
  return rl.ColorToHSV(color)
end
local function color_from_hsv(hue, saturation, value)
  return rl.ColorFromHSV(hue, saturation, value)
end
local function color_tint(color, tint)
  return rl.ColorTint(color, tint)
end
local function color_brightness(color, factor)
  return rl.ColorBrightness(color, factor)
end
local function color_contrast(color, contrast)
  return rl.ColorContrast(color, contrast)
end
local function color_alpha(color, alpha)
  return rl.ColorAlpha(color, alpha)
end
local function color_alpha_blend(dst, src, tint)
  return rl.ColorAlphaBlend(dst, src, tint)
end
local function color_lerp(color1, color2, factor)
  return rl.ColorLerp(color1, color2, factor)
end
local function get_color(hex_value)
  return rl.GetColor(hex_value)
end
local function get_pixel_color(src_ptr, format)
  return rl.GetPixelColor(src_ptr, format)
end
local function set_pixel_color(dst_ptr, color, format)
  return rl.SetPixelColor(dst_ptr, color, format)
end
local function get_pixel_data_size(width, height, format)
  return rl.GetPixelDataSize(width, height, format)
end
return {["load-image"] = load_image, ["load-image-raw"] = load_image_raw, ["load-image-anim"] = load_image_anim, ["load-image-anim-from-memory"] = load_image_anim_from_memory, ["load-image-from-memory"] = load_image_from_memory, ["load-image-from-texture"] = load_image_from_texture, ["load-image-from-screen"] = load_image_from_screen, ["is-image-valid"] = is_image_valid, ["unload-image"] = unload_image, ["export-image"] = export_image, ["export-image-to-memory"] = export_image_to_memory, ["export-image-as-code"] = export_image_as_code, ["gen-image-color"] = gen_image_color, ["gen-image-gradient-linear"] = gen_image_gradient_linear, ["gen-image-gradient-radial"] = gen_image_gradient_radial, ["gen-image-gradient-square"] = gen_image_gradient_square, ["gen-image-checked"] = gen_image_checked, ["gen-image-white-noise"] = gen_image_white_noise, ["gen-image-perlin-noise"] = gen_image_perlin_noise, ["gen-image-cellular"] = gen_image_cellular, ["gen-image-text"] = gen_image_text, ["image-copy"] = image_copy, ["image-from-image"] = image_from_image, ["image-from-channel"] = image_from_channel, ["image-text"] = image_text, ["image-text-ex"] = image_text_ex, ["image-format"] = image_format, ["image-to-pot"] = image_to_pot, ["image-crop"] = image_crop, ["image-alpha-crop"] = image_alpha_crop, ["image-alpha-clear"] = image_alpha_clear, ["image-alpha-mask"] = image_alpha_mask, ["image-alpha-premultiply"] = image_alpha_premultiply, ["image-blur-gaussian"] = image_blur_gaussian, ["image-kernel-convolution"] = image_kernel_convolution, ["image-resize"] = image_resize, ["image-resize-nn"] = image_resize_nn, ["image-resize-canvas"] = image_resize_canvas, ["image-mipmaps"] = image_mipmaps, ["image-dither"] = image_dither, ["image-flip-vertical"] = image_flip_vertical, ["image-flip-horizontal"] = image_flip_horizontal, ["image-rotate"] = image_rotate, ["image-rotate-cw"] = image_rotate_cw, ["image-rotate-ccw"] = image_rotate_ccw, ["image-color-tint"] = image_color_tint, ["image-color-invert"] = image_color_invert, ["image-color-grayscale"] = image_color_grayscale, ["image-color-contrast"] = image_color_contrast, ["image-color-brightness"] = image_color_brightness, ["image-color-replace"] = image_color_replace, ["load-image-colors"] = load_image_colors, ["load-image-palette"] = load_image_palette, ["unload-image-colors"] = unload_image_colors, ["unload-image-palette"] = unload_image_palette, ["get-image-alpha-border"] = get_image_alpha_border, ["get-image-color"] = get_image_color, ["image-clear-background"] = image_clear_background, ["image-draw-pixel"] = image_draw_pixel, ["image-draw-pixel-v"] = image_draw_pixel_v, ["image-draw-line"] = image_draw_line, ["image-draw-line-v"] = image_draw_line_v, ["image-draw-line-ex"] = image_draw_line_ex, ["image-draw-circle"] = image_draw_circle, ["image-draw-circle-v"] = image_draw_circle_v, ["image-draw-circle-lines"] = image_draw_circle_lines, ["image-draw-circle-lines-v"] = image_draw_circle_lines_v, ["image-draw-rectangle"] = image_draw_rectangle, ["image-draw-rectangle-v"] = image_draw_rectangle_v, ["image-draw-rectangle-rec"] = image_draw_rectangle_rec, ["image-draw-rectangle-lines"] = image_draw_rectangle_lines, ["image-draw-triangle"] = image_draw_triangle, ["image-draw-triangle-ex"] = image_draw_triangle_ex, ["image-draw-triangle-lines"] = image_draw_triangle_lines, ["image-draw-triangle-fan"] = image_draw_triangle_fan, ["image-draw-triangle-strip"] = image_draw_triangle_strip, ["image-draw"] = image_draw, ["image-draw-text"] = image_draw_text, ["image-draw-text-ex"] = image_draw_text_ex, ["load-texture"] = load_texture, ["load-texture-from-image"] = load_texture_from_image, ["load-texture-cubemap"] = load_texture_cubemap, ["load-render-texture"] = load_render_texture, ["is-texture-valid"] = is_texture_valid, ["unload-texture"] = unload_texture, ["is-render-texture-valid"] = is_render_texture_valid, ["unload-render-texture"] = unload_render_texture, ["update-texture"] = update_texture, ["update-texture-rec"] = update_texture_rec, ["gen-texture-mipmaps"] = gen_texture_mipmaps, ["set-texture-filter"] = set_texture_filter, ["set-texture-wrap"] = set_texture_wrap, ["draw-texture"] = draw_texture, ["draw-texture-v"] = draw_texture_v, ["draw-texture-ex"] = draw_texture_ex, ["draw-texture-rec"] = draw_texture_rec, ["draw-texture-pro"] = draw_texture_pro, ["draw-texture-npatch"] = draw_texture_npatch, ["color-is-equal"] = color_is_equal, fade = fade, ["color-to-int"] = color_to_int, ["color-normalize"] = color_normalize, ["color-from-normalized"] = color_from_normalized, ["color-to-hsv"] = color_to_hsv, ["color-from-hsv"] = color_from_hsv, ["color-tint"] = color_tint, ["color-brightness"] = color_brightness, ["color-contrast"] = color_contrast, ["color-alpha"] = color_alpha, ["color-alpha-blend"] = color_alpha_blend, ["color-lerp"] = color_lerp, ["get-color"] = get_color, ["get-pixel-color"] = get_pixel_color, ["set-pixel-color"] = set_pixel_color, ["get-pixel-data-size"] = get_pixel_data_size}
