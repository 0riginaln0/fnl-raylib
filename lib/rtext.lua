print("RAYLIB TEXT INIT: STARTED")
local safe_mode = true
local dll = require("lib.dll")
local ffi = dll.ffi
local rl = dll.rl
ffi.cdef("\13\nFont GetFontDefault(void);                                                            // Get the default Font\13\n\13\nFont LoadFont(const char *fileName);                                                  // Load font from file into GPU memory (VRAM)\13\n\13\nFont LoadFontEx(const char *fileName, int fontSize, int *codepoints, int codepointCount); // Load font from file with extended parameters, use NULL for codepoints and 0 for codepointCount to load the default character set, font size is provided in pixels height\13\n\13\nFont LoadFontFromImage(Image image, Color key, int firstChar);                        // Load font from Image (XNA style)\13\n\13\nFont LoadFontFromMemory(const char *fileType, const unsigned char *fileData, int dataSize, int fontSize, int *codepoints, int codepointCount); // Load font from memory buffer, fileType refers to extension: i.e. '.ttf'\13\n\13\nbool IsFontValid(Font font);                                                          // Check if a font is valid (font data loaded, WARNING: GPU texture not checked)\13\n\13\nGlyphInfo *LoadFontData(const unsigned char *fileData, int dataSize, int fontSize, int *codepoints, int codepointCount, int type); // Load font data for further use\13\n\13\nImage GenImageFontAtlas(const GlyphInfo *glyphs, Rectangle **glyphRecs, int glyphCount, int fontSize, int padding, int packMethod); // Generate image font atlas using chars info\13\n\13\nvoid UnloadFontData(GlyphInfo *glyphs, int glyphCount);                               // Unload font chars info data (RAM)\13\n\13\nvoid UnloadFont(Font font);                                                           // Unload font from GPU memory (VRAM)\13\n\13\nbool ExportFontAsCode(Font font, const char *fileName);                               // Export font as code file, returns true on success\13\n\13\nvoid DrawFPS(int posX, int posY);                                                     // Draw current FPS\13\n\13\nvoid DrawText(const char *text, int posX, int posY, int fontSize, Color color);       // Draw text (using default font)\13\n\13\nvoid DrawTextEx(Font font, const char *text, Vector2 position, float fontSize, float spacing, Color tint); // Draw text using font and additional parameters\13\n\13\nvoid DrawTextPro(Font font, const char *text, Vector2 position, Vector2 origin, float rotation, float fontSize, float spacing, Color tint); // Draw text using Font and pro parameters (rotation)\13\n\13\nvoid DrawTextCodepoint(Font font, int codepoint, Vector2 position, float fontSize, Color tint); // Draw one character (codepoint)\13\n\13\nvoid DrawTextCodepoints(Font font, const int *codepoints, int codepointCount, Vector2 position, float fontSize, float spacing, Color tint); // Draw multiple character (codepoint)\13\n\13\nvoid SetTextLineSpacing(int spacing);                                                 // Set vertical line spacing when drawing with line-breaks\13\n\13\nint MeasureText(const char *text, int fontSize);                                      // Measure string width for default font\13\n\13\nVector2 MeasureTextEx(Font font, const char *text, float fontSize, float spacing);    // Measure string size for Font\13\n\13\nint GetGlyphIndex(Font font, int codepoint);                                          // Get glyph index position in font for a codepoint (unicode character), fallback to '?' if not found\13\n\13\nGlyphInfo GetGlyphInfo(Font font, int codepoint);                                     // Get glyph font info data for a codepoint (unicode character), fallback to '?' if not found\13\n\13\nRectangle GetGlyphAtlasRec(Font font, int codepoint);                                 // Get glyph rectangle in font atlas for a codepoint (unicode character), fallback to '?' if not found\13\n\13\nchar *LoadUTF8(const int *codepoints, int length);                // Load UTF-8 text encoded from codepoints array\13\n\13\nvoid UnloadUTF8(char *text);                                      // Unload UTF-8 text encoded from codepoints array\13\n\13\nint *LoadCodepoints(const char *text, int *count);                // Load all codepoints from a UTF-8 text string, codepoints count returned by parameter\13\n\13\nvoid UnloadCodepoints(int *codepoints);                           // Unload codepoints data from memory\13\n\13\nint GetCodepointCount(const char *text);                          // Get total number of codepoints in a UTF-8 encoded string\13\n\13\nint GetCodepoint(const char *text, int *codepointSize);           // Get next codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure\13\n\13\nint GetCodepointNext(const char *text, int *codepointSize);       // Get next codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure\13\n\13\nint GetCodepointPrevious(const char *text, int *codepointSize);   // Get previous codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure\13\n\13\nconst char *CodepointToUTF8(int codepoint, int *utf8Size);        // Encode one codepoint into UTF-8 byte array (array length returned as parameter)\13\n\13\nint TextCopy(char *dst, const char *src);                                             // Copy one string to another, returns bytes copied\13\n\13\nbool TextIsEqual(const char *text1, const char *text2);                               // Check if two text string are equal\13\n\13\nunsigned int TextLength(const char *text);                                            // Get text length, checks for '\0' ending\13\n\13\nconst char *TextFormat(const char *text, ...);                                        // Text formatting with variables (sprintf() style)\13\n\13\nconst char *TextSubtext(const char *text, int position, int length);                  // Get a piece of a text string\13\n\13\nchar *TextReplace(const char *text, const char *replace, const char *by);             // Replace text string (WARNING: memory must be freed!)\13\n\13\nchar *TextInsert(const char *text, const char *insert, int position);                 // Insert text in a position (WARNING: memory must be freed!)\13\n\13\nconst char *TextJoin(const char **textList, int count, const char *delimiter);        // Join text strings with delimiter\13\n\13\nconst char **TextSplit(const char *text, char delimiter, int *count);                 // Split text into multiple strings\13\n\13\nvoid TextAppend(char *text, const char *append, int *position);                       // Append text at specific position and move cursor!\13\n\13\nint TextFindIndex(const char *text, const char *find);                                // Find first text occurrence within a string\13\n\13\nconst char *TextToUpper(const char *text);                      // Get upper case version of provided string\13\n\13\nconst char *TextToLower(const char *text);                      // Get lower case version of provided string\13\n\13\nconst char *TextToPascal(const char *text);                     // Get Pascal case notation version of provided string\13\n\13\nconst char *TextToSnake(const char *text);                      // Get Snake case notation version of provided string\13\n\13\nconst char *TextToCamel(const char *text);                      // Get Camel case notation version of provided string\13\n\13\nint TextToInteger(const char *text);                            // Get integer value from text (negative values not supported)\13\n\13\nfloat TextToFloat(const char *text);                            // Get float value from text (negative values not supported)\13\n")
local function get_font_default()
  return rl.GetFontDefault()
end
local function load_font(file_name)
  return rl.LoadFont(file_name)
end
local function load_font_ex(file_name, font_size, codepoints, codepoint_count)
  return rl.LoadFontEx(file_name, font_size, codepoints, codepoint_count)
end
local function load_font_from_image(image, key, first_char)
  return rl.LoadFontFromImage(image, key, first_char)
end
local function load_font_from_memory(file_type, file_data, data_size, font_size, codepoints, codepoint_count)
  return rl.LoadFontFromMemory(file_type, file_data, data_size, font_size, codepoints, codepoint_count)
end
local function is_font_valid(font)
  return rl.IsFontValid(font)
end
local function load_font_data(file_data, data_size, font_size, codepoints, codepoint_count, type)
  return rl.LoadFontData(file_data, data_size, font_size, codepoints, codepoint_count, type)
end
local function gen_image_font_atlas(glyphs, glyph_recs, glyph_count, font_size, padding, pack_method)
  return rl.GenImageFontAtlas(glyphs, glyph_recs, glyph_count, font_size, padding, pack_method)
end
local function unload_font_data(glyphs, glyph_count)
  return rl.UnloadFontData(glyphs, glyph_count)
end
local function unload_font(font)
  return rl.UnloadFont(font)
end
local function export_font_as_code(font, file_name)
  return rl.ExportFontAsCode(font, file_name)
end
local function draw_fps(pos_x, pos_y)
  return rl.DrawFPS(pos_x, pos_y)
end
local function draw_text(text, pos_x, pos_y, font_size, color)
  return rl.DrawText(text, pos_x, pos_y, font_size, color)
end
local function draw_text_ex(font, text, position, font_size, spacing, tint)
  return rl.DrawTextEx(font, text, position, font_size, spacing, tint)
end
local function draw_text_pro(font, text, position, origin, rotation, font_size, spacing, tint)
  return rl.DrawTextPro(font, text, position, origin, rotation, font_size, spacing, tint)
end
local function draw_text_codepoint(font, codepoint, position, font_size, tint)
  return rl.DrawTextCodepoint(font, codepoint, position, font_size, tint)
end
local function draw_text_codepoints(font, codepoints, codepoint_count, position, font_size, spacing, tint)
  return rl.DrawTextCodepoints(font, codepoints, codepoint_count, position, font_size, spacing, tint)
end
local function set_text_line_spacing(spacing)
  return rl.SetTextLineSpacing(spacing)
end
local function measure_text(text, font_size)
  return rl.MeasureText(text, font_size)
end
local function measure_text_ex(font, text, font_size, spacing)
  return rl.MeasureTextEx(font, text, font_size, spacing)
end
local function get_glyph_index(font, codepoint)
  return rl.GetGlyphIndex(font, codepoint)
end
local function get_glyph_info(font, codepoint)
  return rl.GetGlyphInfo(font, codepoint)
end
local function get_glyph_atlas_rec(font, codepoint)
  return rl.GetGlyphAtlasRec(font, codepoint)
end
local function load_utf8(codepoints, llength)
  return rl.LoadUTF8(codepoints, llength)
end
local function unload_utf8(text)
  return rl.UnloadUTF8(text)
end
local function load_codepoints(text, count)
  return rl.LoadCodepoints(text, count)
end
local function unload_codepoints(codepoints)
  return rl.UnloadCodepoints(codepoints)
end
local function get_codepoint_count(text)
  return rl.GetCodepointCount(text)
end
local function get_codepoint(text, codepoint_size)
  return rl.GetCodepoint(text, codepoint_size)
end
local function get_codepoint_next(text, codepoint_size)
  return rl.GetCodepointNext(text, codepoint_size)
end
local function get_codepoint_previous(text, codepoint_size)
  return rl.GetCodepointPrevious(text, codepoint_size)
end
local function codepoint_to_utf8(codepoint, utf8size)
  return rl.CodepointToUTF8(codepoint, utf8size)
end
local function text_copy(dst, src)
  return rl.TextCopy(dst, src)
end
local function text_is_equal(text1, text2)
  return rl.TextIsEqual(text1, text2)
end
local function text_length(text)
  return rl.TextLength(text)
end
local function text_format(text)
  return rl.TextFormat(text)
end
local function text_subtext(text, position, llength)
  return rl.TextSubtext(text, position, llength)
end
local function text_replace(text, replace, by)
  return rl.TextReplace(text, replace, by)
end
local function text_insert(text, insert, position)
  return rl.TextInsert(text, insert, position)
end
local function text_join(text_list, count, delimiter)
  return rl.TextJoin(text_list, count, delimiter)
end
local function text_split(text, delimiter, count)
  return rl.TextSplit(text, delimiter, count)
end
local function text_append(text, append, position)
  return rl.TextAppend(text, append, position)
end
local function text_find_index(text, find)
  return rl.TextFindIndex(text, find)
end
local function text_to_upper(text)
  return rl.TextToUpper(text)
end
local function text_to_lower(text)
  return rl.TextToLower(text)
end
local function text_to_pascal(text)
  return rl.TextToPascal(text)
end
local function text_to_snake(text)
  return rl.TextToSnake(text)
end
local function text_to_camel(text)
  return rl.TextToCamel(text)
end
local function text_to_integer(text)
  return rl.TextToInteger(text)
end
local function text_to_float(text)
  return rl.TextToFloat(text)
end
return {["get-font-default"] = get_font_default, ["load-font"] = load_font, ["load-font-ex"] = load_font_ex, ["load-font-from-image"] = load_font_from_image, ["load-font-from-memory"] = load_font_from_memory, ["is-font-valid"] = is_font_valid, ["load-font-data"] = load_font_data, ["gen-image-font-atlas"] = gen_image_font_atlas, ["unload-font-data"] = unload_font_data, ["unload-font"] = unload_font, ["export-font-as-code"] = export_font_as_code, ["draw-fps"] = draw_fps, ["draw-text"] = draw_text, ["draw-text-ex"] = draw_text_ex, ["draw-text-pro"] = draw_text_pro, ["draw-text-codepoint"] = draw_text_codepoint, ["draw-text-codepoints"] = draw_text_codepoints, ["set-text-line-spacing"] = set_text_line_spacing, ["measure-text"] = measure_text, ["measure-text-ex"] = measure_text_ex, ["get-glyph-index"] = get_glyph_index, ["get-glyph-info"] = get_glyph_info, ["get-glyph-atlas-rec"] = get_glyph_atlas_rec, ["load-utf8"] = load_utf8, ["unload-utf8"] = unload_utf8, ["load-codepoints"] = load_codepoints, ["unload-codepoints"] = unload_codepoints, ["get-codepoint-count"] = get_codepoint_count, ["get-codepoint"] = get_codepoint, ["get-codepoint-next"] = get_codepoint_next, ["get-codepoint-previous"] = get_codepoint_previous, ["codepoint-to-utf8"] = codepoint_to_utf8, ["text-copy"] = text_copy, ["text-is-equal"] = text_is_equal, ["text-length"] = text_length, ["text-format"] = text_format, ["text-subtext"] = text_subtext, ["text-replace"] = text_replace, ["text-insert"] = text_insert, ["text-join"] = text_join, ["text-split"] = text_split, ["text-append"] = text_append, ["text-find-index"] = text_find_index, ["text-to-upper"] = text_to_upper, ["text-to-lower"] = text_to_lower, ["text-to-pascal"] = text_to_pascal, ["text-to-snake"] = text_to_snake, ["text-to-camel"] = text_to_camel, ["text-to-integer"] = text_to_integer, ["text-to-float"] = text_to_float}
