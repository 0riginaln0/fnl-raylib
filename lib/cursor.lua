print("RAYLIB CURSOR MODULE INIT")
local dll = require("lib.dll")
local ffi = dll.ffi
local rl = dll.rl
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
