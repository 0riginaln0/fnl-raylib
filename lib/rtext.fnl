(print "INIT: TEXT")
(local safe-mode true)

(local dll (require :lib.dll))
(local ffi (. dll :ffi))
(local rl (. dll :rl))

(ffi.cdef "
Font GetFontDefault(void);                                                            // Get the default Font

Font LoadFont(const char *fileName);                                                  // Load font from file into GPU memory (VRAM)

Font LoadFontEx(const char *fileName, int fontSize, int *codepoints, int codepointCount); // Load font from file with extended parameters, use NULL for codepoints and 0 for codepointCount to load the default character set, font size is provided in pixels height

Font LoadFontFromImage(Image image, Color key, int firstChar);                        // Load font from Image (XNA style)

Font LoadFontFromMemory(const char *fileType, const unsigned char *fileData, int dataSize, int fontSize, int *codepoints, int codepointCount); // Load font from memory buffer, fileType refers to extension: i.e. '.ttf'

bool IsFontValid(Font font);                                                          // Check if a font is valid (font data loaded, WARNING: GPU texture not checked)

GlyphInfo *LoadFontData(const unsigned char *fileData, int dataSize, int fontSize, int *codepoints, int codepointCount, int type); // Load font data for further use

Image GenImageFontAtlas(const GlyphInfo *glyphs, Rectangle **glyphRecs, int glyphCount, int fontSize, int padding, int packMethod); // Generate image font atlas using chars info

void UnloadFontData(GlyphInfo *glyphs, int glyphCount);                               // Unload font chars info data (RAM)

void UnloadFont(Font font);                                                           // Unload font from GPU memory (VRAM)

bool ExportFontAsCode(Font font, const char *fileName);                               // Export font as code file, returns true on success

void DrawFPS(int posX, int posY);                                                     // Draw current FPS

void DrawText(const char *text, int posX, int posY, int fontSize, Color color);       // Draw text (using default font)

void DrawTextEx(Font font, const char *text, Vector2 position, float fontSize, float spacing, Color tint); // Draw text using font and additional parameters

void DrawTextPro(Font font, const char *text, Vector2 position, Vector2 origin, float rotation, float fontSize, float spacing, Color tint); // Draw text using Font and pro parameters (rotation)

void DrawTextCodepoint(Font font, int codepoint, Vector2 position, float fontSize, Color tint); // Draw one character (codepoint)

void DrawTextCodepoints(Font font, const int *codepoints, int codepointCount, Vector2 position, float fontSize, float spacing, Color tint); // Draw multiple character (codepoint)

void SetTextLineSpacing(int spacing);                                                 // Set vertical line spacing when drawing with line-breaks

int MeasureText(const char *text, int fontSize);                                      // Measure string width for default font

Vector2 MeasureTextEx(Font font, const char *text, float fontSize, float spacing);    // Measure string size for Font

int GetGlyphIndex(Font font, int codepoint);                                          // Get glyph index position in font for a codepoint (unicode character), fallback to '?' if not found

GlyphInfo GetGlyphInfo(Font font, int codepoint);                                     // Get glyph font info data for a codepoint (unicode character), fallback to '?' if not found

Rectangle GetGlyphAtlasRec(Font font, int codepoint);                                 // Get glyph rectangle in font atlas for a codepoint (unicode character), fallback to '?' if not found

char *LoadUTF8(const int *codepoints, int length);                // Load UTF-8 text encoded from codepoints array

void UnloadUTF8(char *text);                                      // Unload UTF-8 text encoded from codepoints array

int *LoadCodepoints(const char *text, int *count);                // Load all codepoints from a UTF-8 text string, codepoints count returned by parameter

void UnloadCodepoints(int *codepoints);                           // Unload codepoints data from memory

int GetCodepointCount(const char *text);                          // Get total number of codepoints in a UTF-8 encoded string

int GetCodepoint(const char *text, int *codepointSize);           // Get next codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure

int GetCodepointNext(const char *text, int *codepointSize);       // Get next codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure

int GetCodepointPrevious(const char *text, int *codepointSize);   // Get previous codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure

const char *CodepointToUTF8(int codepoint, int *utf8Size);        // Encode one codepoint into UTF-8 byte array (array length returned as parameter)

int TextCopy(char *dst, const char *src);                                             // Copy one string to another, returns bytes copied

bool TextIsEqual(const char *text1, const char *text2);                               // Check if two text string are equal

unsigned int TextLength(const char *text);                                            // Get text length, checks for '\0' ending

const char *TextFormat(const char *text, ...);                                        // Text formatting with variables (sprintf() style)

const char *TextSubtext(const char *text, int position, int length);                  // Get a piece of a text string

char *TextReplace(const char *text, const char *replace, const char *by);             // Replace text string (WARNING: memory must be freed!)

char *TextInsert(const char *text, const char *insert, int position);                 // Insert text in a position (WARNING: memory must be freed!)

const char *TextJoin(const char **textList, int count, const char *delimiter);        // Join text strings with delimiter

const char **TextSplit(const char *text, char delimiter, int *count);                 // Split text into multiple strings

void TextAppend(char *text, const char *append, int *position);                       // Append text at specific position and move cursor!

int TextFindIndex(const char *text, const char *find);                                // Find first text occurrence within a string

const char *TextToUpper(const char *text);                      // Get upper case version of provided string

const char *TextToLower(const char *text);                      // Get lower case version of provided string

const char *TextToPascal(const char *text);                     // Get Pascal case notation version of provided string

const char *TextToSnake(const char *text);                      // Get Snake case notation version of provided string

const char *TextToCamel(const char *text);                      // Get Camel case notation version of provided string

int TextToInteger(const char *text);                            // Get integer value from text (negative values not supported)

float TextToFloat(const char *text);                            // Get float value from text (negative values not supported)
")

;------------------------------------------------------------------------------------
; Font Loading and Text Drawing Functions (Module: text)
;------------------------------------------------------------------------------------
; Font loading/unloading functions
(fn get-font-default []
  "Get the default Font"
  (rl.GetFontDefault ))

(fn load-font [file-name]
  "Load font from file into GPU memory (VRAM)"
  (rl.LoadFont file-name))

(fn load-font-ex [file-name font-size codepoints codepoint-count]
  "Load font from file with extended parameters, use NULL for codepoints and 0 for codepointCount to load the default character set, font size is provided in pixels height"
  (rl.LoadFontEx file-name font-size codepoints codepoint-count))

(fn load-font-from-image [image key first-char]
  "Load font from Image (XNA style)"
  (rl.LoadFontFromImage image key first-char))

(fn load-font-from-memory [file-type file-data data-size font-size codepoints codepoint-count]
  "Load font from memory buffer, fileType refers to extension: i.e. '.ttf'"
  (rl.LoadFontFromMemory file-type file-data data-size font-size codepoints codepoint-count))

(fn is-font-valid [font]
  "Check if a font is valid (font data loaded, WARNING: GPU texture not checked)"
  (rl.IsFontValid font))

(fn load-font-data [file-data data-size font-size codepoints codepoint-count type]
  "Load font data for further use"
  (rl.LoadFontData file-data data-size font-size codepoints codepoint-count type))

(fn gen-image-font-atlas [glyphs glyph-recs glyph-count font-size padding pack-method]
  "Generate image font atlas using chars info"
  (rl.GenImageFontAtlas glyphs glyph-recs glyph-count font-size padding pack-method))

(fn unload-font-data [glyphs glyph-count]
  "Unload font chars info data (RAM)"
  (rl.UnloadFontData glyphs glyph-count))

(fn unload-font [font]
  "Unload font from GPU memory (VRAM)"
  (rl.UnloadFont font))

(fn export-font-as-code [font file-name]
  "Export font as code file, returns true on success"
  (rl.ExportFontAsCode font file-name))

; Text drawing functions
(fn draw-fps [pos-x pos-y]
  "Draw current FPS"
  (rl.DrawFPS pos-x pos-y))

(fn draw-text [text pos-x pos-y font-size color]
  "Draw text (using default font)"
  (rl.DrawText text pos-x pos-y font-size color))

(fn draw-text-ex [font text position font-size spacing tint]
  "Draw text using font and additional parameters"
  (rl.DrawTextEx font text position font-size spacing tint))

(fn draw-text-pro [font text position origin rotation font-size spacing tint]
  "Draw text using Font and pro parameters (rotation)"
  (rl.DrawTextPro font text position origin rotation font-size spacing tint))

(fn draw-text-codepoint [font codepoint position font-size tint]
  "Draw one character (codepoint)"
  (rl.DrawTextCodepoint font codepoint position font-size tint))

(fn draw-text-codepoints [font codepoints codepoint-count position font-size spacing tint]
  "Draw multiple character (codepoint)"
  (rl.DrawTextCodepoints font codepoints codepoint-count position font-size spacing tint))

; Text font info functions
(fn set-text-line-spacing [spacing]
  "Set vertical line spacing when drawing with line-breaks"
  (rl.SetTextLineSpacing spacing))

(fn measure-text [text font-size]
  "Measure string width for default font"
  (rl.MeasureText text font-size))

(fn measure-text-ex [font text font-size spacing]
  "Measure string size for Font"
  (rl.MeasureTextEx font text font-size spacing))

(fn get-glyph-index [font codepoint]
  "Get glyph index position in font for a codepoint (unicode character), fallback to '?' if not found"
  (rl.GetGlyphIndex font codepoint))

(fn get-glyph-info [font codepoint]
  "Get glyph font info data for a codepoint (unicode character), fallback to '?' if not found"
  (rl.GetGlyphInfo font codepoint))

(fn get-glyph-atlas-rec [font codepoint]
  "Get glyph rectangle in font atlas for a codepoint (unicode character), fallback to '?' if not found"
  (rl.GetGlyphAtlasRec font codepoint))

; Text codepoints management functions (unicode characters)
(fn load-utf8 [codepoints llength]
  "Load UTF-8 text encoded from codepoints array"
  (rl.LoadUTF8 codepoints llength))

(fn unload-utf8 [text]
  "Unload UTF-8 text encoded from codepoints array"
  (rl.UnloadUTF8 text))

(fn load-codepoints [text count]
  "Load all codepoints from a UTF-8 text string, codepoints count returned by parameter"
  (rl.LoadCodepoints text count))

(fn unload-codepoints [codepoints]
  "Unload codepoints data from memory"
  (rl.UnloadCodepoints codepoints))

(fn get-codepoint-count [text]
  "Get total number of codepoints in a UTF-8 encoded string"
  (rl.GetCodepointCount text))

(fn get-codepoint [text codepoint-size]
  "Get next codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure"
  (rl.GetCodepoint text codepoint-size))

(fn get-codepoint-next [text codepoint-size]
  "Get next codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure"
  (rl.GetCodepointNext text codepoint-size))

(fn get-codepoint-previous [text codepoint-size]
  "Get previous codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure"
  (rl.GetCodepointPrevious text codepoint-size))

(fn codepoint-to-utf8 [codepoint utf8size]
  "Encode one codepoint into UTF-8 byte array (array length returned as parameter)"
  (rl.CodepointToUTF8 codepoint utf8size))

; Text strings management functions (no UTF-8 strings, only byte chars)
; NOTE: Some strings allocate memory internally for returned strings, just be careful!
(fn text-copy [dst src]
  "Copy one string to another, returns bytes copied"
  (rl.TextCopy dst src))

(fn text-is-equal [text1 text2]
  "Check if two text string are equal"
  (rl.TextIsEqual text1 text2))

(fn text-length [text]
  "Get text length, checks for '\0' ending"
  (rl.TextLength text))

(fn text-format [text ]
  "Text formatting with variables (sprintf() style)"
  (rl.TextFormat text ))

(fn text-subtext [text position llength]
  "Get a piece of a text string"
  (rl.TextSubtext text position llength))

(fn text-replace [text replace by]
  "Replace text string (WARNING: memory must be freed!)"
  (rl.TextReplace text replace by))

(fn text-insert [text insert position]
  "Insert text in a position (WARNING: memory must be freed!)"
  (rl.TextInsert text insert position))

(fn text-join [text-list count delimiter]
  "Join text strings with delimiter"
  (rl.TextJoin text-list count delimiter))

(fn text-split [text delimiter count]
  "Split text into multiple strings"
  (rl.TextSplit text delimiter count))

(fn text-append [text append position]
  "Append text at specific position and move cursor!"
  (rl.TextAppend text append position))

(fn text-find-index [text find]
  "Find first text occurrence within a string"
  (rl.TextFindIndex text find))

(fn text-to-upper [text]
  "Get upper case version of provided string"
  (rl.TextToUpper text))

(fn text-to-lower [text]
  "Get lower case version of provided string"
  (rl.TextToLower text))

(fn text-to-pascal [text]
  "Get Pascal case notation version of provided string"
  (rl.TextToPascal text))

(fn text-to-snake [text]
  "Get Snake case notation version of provided string"
  (rl.TextToSnake text))

(fn text-to-camel [text]
  "Get Camel case notation version of provided string"
  (rl.TextToCamel text))

(fn text-to-integer [text]
  "Get integer value from text (negative values not supported)"
  (rl.TextToInteger text))

(fn text-to-float [text]
  "Get float value from text (negative values not supported)"
  (rl.TextToFloat text))


{: get-font-default
 : load-font
 : load-font-ex
 : load-font-from-image
 : load-font-from-memory
 : is-font-valid
 : load-font-data
 : gen-image-font-atlas
 : unload-font-data
 : unload-font
 : export-font-as-code
 : draw-fps
 : draw-text
 : draw-text-ex
 : draw-text-pro
 : draw-text-codepoint
 : draw-text-codepoints
 : set-text-line-spacing
 : measure-text
 : measure-text-ex
 : get-glyph-index
 : get-glyph-info
 : get-glyph-atlas-rec
 : load-utf8
 : unload-utf8
 : load-codepoints
 : unload-codepoints
 : get-codepoint-count
 : get-codepoint
 : get-codepoint-next
 : get-codepoint-previous
 : codepoint-to-utf8
 : text-copy
 : text-is-equal
 : text-length
 : text-format
 : text-subtext
 : text-replace
 : text-insert
 : text-join
 : text-split
 : text-append
 : text-find-index
 : text-to-upper
 : text-to-lower
 : text-to-pascal
 : text-to-snake
 : text-to-camel
 : text-to-integer
 : text-to-float}