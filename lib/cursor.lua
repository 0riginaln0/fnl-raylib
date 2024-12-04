print("RAYLIB CURSOR MODULE INIT")
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
ffi.cdef("\nvoid ShowCursor(void);                                      // Shows cursor\n\nvoid HideCursor(void);                                      // Hides cursor\n\nbool IsCursorHidden(void);                                  // Check if cursor is not visible\n\nvoid EnableCursor(void);                                    // Enables cursor (unlock cursor)\n\nvoid DisableCursor(void);                                   // Disables cursor (lock cursor)\n\nbool IsCursorOnScreen(void);                                // Check if cursor is on the screen\n")
local function show_cursor()
  return rl.ShowCursor()
end
local function hide_cursor()
  return rl.HideCursor()
end
local function is_cursor_hidden()
  return rl.IsCursorHidden()
end
local function enable_cursor()
  return rl.EnableCursor()
end
local function disable_cursor()
  return rl.DisableCursor()
end
local function is_cursor_on_screen()
  return rl.IsCursorOnScreen()
end
return {["show-cursor"] = show_cursor, ["hide-cursor"] = hide_cursor, ["is-cursor-hidden"] = is_cursor_hidden, ["enable-cursor"] = enable_cursor, ["disable-cursor"] = disable_cursor, ["is-cursor-on-screen"] = is_cursor_on_screen}
