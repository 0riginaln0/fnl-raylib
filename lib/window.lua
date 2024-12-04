print("RAYLIB WINDOW MODULE INIT")
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
ffi.cdef("\nvoid InitWindow(int width, int height, const char *title);  // Initialize window and OpenGL context\n\nvoid CloseWindow(void);                                     // Close window and unload OpenGL context\n\nbool WindowShouldClose(void);                               // Check if application should close (KEY_ESCAPE pressed or windows close icon clicked)\n\nbool IsWindowReady(void);                                   // Check if window has been initialized successfully\n\nbool IsWindowFullscreen(void);                              // Check if window is currently fullscreen\n\nbool IsWindowHidden(void);                                  // Check if window is currently hidden\n\nbool IsWindowMinimized(void);                               // Check if window is currently minimized\n\nbool IsWindowMaximized(void);                               // Check if window is currently maximized\n\nbool IsWindowFocused(void);                                 // Check if window is currently focused\n\nbool IsWindowResized(void);                                 // Check if window has been resized last frame\n\nbool IsWindowState(unsigned int flag);                      // Check if one specific window flag is enabled\n\nvoid SetWindowState(unsigned int flags);                    // Set window configuration state using flags\n\nvoid ClearWindowState(unsigned int flags);                  // Clear window configuration state flags\n\nvoid ToggleFullscreen(void);                                // Toggle window state: fullscreen/windowed, resizes monitor to match window resolution\n\nvoid ToggleBorderlessWindowed(void);                        // Toggle window state: borderless windowed, resizes window to match monitor resolution\n\nvoid MaximizeWindow(void);                                  // Set window state: maximized, if resizable\n\nvoid MinimizeWindow(void);                                  // Set window state: minimized, if resizable\n\nvoid RestoreWindow(void);                                   // Set window state: not minimized/maximized\n\nvoid SetWindowIcon(Image image);                            // Set icon for window (single image, RGBA 32bit)\n\nvoid SetWindowIcons(Image *images, int count);              // Set icon for window (multiple images, RGBA 32bit)\n\nvoid SetWindowTitle(const char *title);                     // Set title for window\n\nvoid SetWindowPosition(int x, int y);                       // Set window position on screen\n\nvoid SetWindowMonitor(int monitor);                         // Set monitor for the current window\n\nvoid SetWindowMinSize(int width, int height);               // Set window minimum dimensions (for FLAG_WINDOW_RESIZABLE)\n\nvoid SetWindowMaxSize(int width, int height);               // Set window maximum dimensions (for FLAG_WINDOW_RESIZABLE)\n\nvoid SetWindowSize(int width, int height);                  // Set window dimensions\n\nvoid SetWindowOpacity(float opacity);                       // Set window opacity [0.0f..1.0f]\n\nvoid SetWindowFocused(void);                                // Set window focused\n\nvoid *GetWindowHandle(void);                                // Get native window handle\n\nint GetScreenWidth(void);                                   // Get current screen width\n\nint GetScreenHeight(void);                                  // Get current screen height\n\nint GetRenderWidth(void);                                   // Get current render width (it considers HiDPI)\n\nint GetRenderHeight(void);                                  // Get current render height (it considers HiDPI)\n\nint GetMonitorCount(void);                                  // Get number of connected monitors\n\nint GetCurrentMonitor(void);                                // Get current monitor where window is placed\n\nVector2 GetMonitorPosition(int monitor);                    // Get specified monitor position\n\nint GetMonitorWidth(int monitor);                           // Get specified monitor width (current video mode used by monitor)\n\nint GetMonitorHeight(int monitor);                          // Get specified monitor height (current video mode used by monitor)\n\nint GetMonitorPhysicalWidth(int monitor);                   // Get specified monitor physical width in millimetres\n\nint GetMonitorPhysicalHeight(int monitor);                  // Get specified monitor physical height in millimetres\n\nint GetMonitorRefreshRate(int monitor);                     // Get specified monitor refresh rate\n\nVector2 GetWindowPosition(void);                            // Get window position XY on monitor\n\nVector2 GetWindowScaleDPI(void);                            // Get window scale DPI factor\n\nconst char *GetMonitorName(int monitor);                    // Get the human-readable, UTF-8 encoded name of the specified monitor\n\nvoid SetClipboardText(const char *text);                    // Set clipboard text content\n\nconst char *GetClipboardText(void);                         // Get clipboard text content\n\nImage GetClipboardImage(void);                              // Get clipboard image content\n\nvoid EnableEventWaiting(void);                              // Enable waiting for events on EndDrawing(), no automatic event polling\n\nvoid DisableEventWaiting(void);                             // Disable waiting for events on EndDrawing(), automatic events polling\n\n")
local function init_window(width, height, title)
  return rl.InitWindow(width, height, title)
end
local function close_window()
  return rl.CloseWindow()
end
local function window_should_close()
  return rl.WindowShouldClose()
end
local function is_window_ready()
  return rl.IsWindowReady()
end
local function is_window_fullscreen()
  return rl.IsWindowFullscreen()
end
local function is_window_hidden()
  return rl.IsWindowHidden()
end
local function is_window_minimized()
  return rl.IsWindowMinimized()
end
local function is_window_maximized()
  return rl.IsWindowMaximized()
end
local function is_window_focused()
  return rl.IsWindowFocused()
end
local function is_window_resized()
  return rl.IsWindowResized()
end
local function is_window_state(flag)
  return rl.IsWindowState(flag)
end
local function set_window_state(flags)
  return rl.SetWindowState(flags)
end
local function clear_window_state(flags)
  return rl.ClearWindowState(flags)
end
local function toggle_fullscreen()
  return rl.ToggleFullscreen()
end
local function toggle_borderless_windowed()
  return rl.ToggleBorderlessWindowed()
end
local function maximize_window()
  return rl.MaximizeWindow()
end
local function minimize_window()
  return rl.MinimizeWindow()
end
local function restore_window()
  return rl.RestoreWindow()
end
local function set_window_icon(image)
  return rl.SetWindowIcon(image)
end
local function set_window_icons(images, count)
  return rl.SetWindowIcons(images, count)
end
local function set_window_title(title)
  return rl.SetWindowTitle(title)
end
local function set_window_position(x, y)
  return rl.SetWindowPosition(x, y)
end
local function set_window_monitor(monitor)
  return rl.SetWindowMonitor(monitor)
end
local function set_window_min_size(width, height)
  return rl.SetWindowMinSize(width, height)
end
local function set_window_max_size(width, height)
  return rl.SetWindowMaxSize(width, height)
end
local function set_window_size(width, height)
  return rl.SetWindowSize(width, height)
end
local function set_window_opacity(opacity)
  return rl.SetWindowOpacity(opacity)
end
local function set_window_focused()
  return rl.SetWindowFocused()
end
local function get_window_handle()
  return rl.GetWindowHandle()
end
local function get_screen_width()
  return rl.GetScreenWidth()
end
local function get_screen_height()
  return rl.GetScreenHeight()
end
local function get_render_width()
  return rl.GetRenderWidth()
end
local function get_render_height()
  return rl.GetRenderHeight()
end
local function get_monitor_count()
  return rl.GetMonitorCount()
end
local function get_current_monitor()
  return rl.GetCurrentMonitor()
end
local function get_monitor_position(monitor)
  return rl.GetMonitorPosition(monitor)
end
local function get_monitor_width(monitor)
  return rl.GetMonitorWidth(monitor)
end
local function get_monitor_height(monitor)
  return rl.GetMonitorHeight(monitor)
end
local function get_monitor_physical_width(monitor)
  return rl.GetMonitorPhysicalWidth(monitor)
end
local function get_monitor_physical_height(monitor)
  return rl.GetMonitorPhysicalHeight(monitor)
end
local function get_monitor_refresh_rate(monitor)
  return rl.GetMonitorRefreshRate(monitor)
end
local function get_window_position()
  return rl.GetWindowPosition()
end
local function get_window_scale_dpi()
  return rl.GetWindowScaleDPI()
end
local function get_monitor_name(monitor)
  return rl.GetMonitorName(monitor)
end
local function set_clipboard_text(text)
  return rl.SetClipboardText(text)
end
local function get_clipboard_text()
  return rl.GetClipboardText()
end
local function get_clipboard_image()
  return rl.GetClipboardImage()
end
local function enable_event_waiting()
  return rl.EnableEventWaiting()
end
local function disable_event_waiting()
  return rl.DisableEventWaiting()
end
return {["init-window"] = init_window, ["close-window"] = close_window, ["window-should-close"] = window_should_close, ["is-window-ready"] = is_window_ready, ["is-window-fullscreen"] = is_window_fullscreen, ["is-window-hidden"] = is_window_hidden, ["is-window-minimized"] = is_window_minimized, ["is-window-maximized"] = is_window_maximized, ["is-window-focused"] = is_window_focused, ["is-window-resized"] = is_window_resized, ["is-window-state"] = is_window_state, ["set-window-state"] = set_window_state, ["clear-window-state"] = clear_window_state, ["toggle-fullscreen"] = toggle_fullscreen, ["toggle-borderless-windowed"] = toggle_borderless_windowed, ["maximize-window"] = maximize_window, ["minimize-window"] = minimize_window, ["restore-window"] = restore_window, ["set-window-icon"] = set_window_icon, ["set-window-icons"] = set_window_icons, ["set-window-title"] = set_window_title, ["set-window-position"] = set_window_position, ["set-window-monitor"] = set_window_monitor, ["set-window-min-size"] = set_window_min_size, ["set-window-max-size"] = set_window_max_size, ["set-window-size"] = set_window_size, ["set-window-opacity"] = set_window_opacity, ["set-window-focused"] = set_window_focused, ["get-window-handle"] = get_window_handle, ["get-screen-width"] = get_screen_width, ["get-screen-height"] = get_screen_height, ["get-render-width"] = get_render_width, ["get-render-height"] = get_render_height, ["get-monitor-count"] = get_monitor_count, ["get-current-monitor"] = get_current_monitor, ["get-monitor-position"] = get_monitor_position, ["get-monitor-width"] = get_monitor_width, ["get-monitor-height"] = get_monitor_height, ["get-monitor-physical-width"] = get_monitor_physical_width, ["get-monitor-physical-height"] = get_monitor_physical_height, ["get-monitor-refresh-rate"] = get_monitor_refresh_rate, ["get-window-position"] = get_window_position, ["get-window-scale-dpi"] = get_window_scale_dpi, ["get-monitor-name"] = get_monitor_name, ["set-clipboard-text"] = set_clipboard_text, ["get-clipboard-text"] = get_clipboard_text, ["get-clipboard-image"] = get_clipboard_image, ["enable-event-waiting"] = enable_event_waiting, ["disable-event-waiting"] = disable_event_waiting}
