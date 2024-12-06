print("RAYLIB WINDOW MODULE INIT")
local dll = require("lib.dll")
local ffi = dll.ffi
local rl = dll.rl
ffi.cdef("\13\nvoid InitWindow(int width, int height, const char *title);  // Initialize window and OpenGL context\13\n\13\nvoid CloseWindow(void);                                     // Close window and unload OpenGL context\13\n\13\nbool WindowShouldClose(void);                               // Check if application should close (KEY_ESCAPE pressed or windows close icon clicked)\13\n\13\nbool IsWindowReady(void);                                   // Check if window has been initialized successfully\13\n\13\nbool IsWindowFullscreen(void);                              // Check if window is currently fullscreen\13\n\13\nbool IsWindowHidden(void);                                  // Check if window is currently hidden\13\n\13\nbool IsWindowMinimized(void);                               // Check if window is currently minimized\13\n\13\nbool IsWindowMaximized(void);                               // Check if window is currently maximized\13\n\13\nbool IsWindowFocused(void);                                 // Check if window is currently focused\13\n\13\nbool IsWindowResized(void);                                 // Check if window has been resized last frame\13\n\13\nbool IsWindowState(unsigned int flag);                      // Check if one specific window flag is enabled\13\n\13\nvoid SetWindowState(unsigned int flags);                    // Set window configuration state using flags\13\n\13\nvoid ClearWindowState(unsigned int flags);                  // Clear window configuration state flags\13\n\13\nvoid ToggleFullscreen(void);                                // Toggle window state: fullscreen/windowed, resizes monitor to match window resolution\13\n\13\nvoid ToggleBorderlessWindowed(void);                        // Toggle window state: borderless windowed, resizes window to match monitor resolution\13\n\13\nvoid MaximizeWindow(void);                                  // Set window state: maximized, if resizable\13\n\13\nvoid MinimizeWindow(void);                                  // Set window state: minimized, if resizable\13\n\13\nvoid RestoreWindow(void);                                   // Set window state: not minimized/maximized\13\n\13\nvoid SetWindowIcon(Image image);                            // Set icon for window (single image, RGBA 32bit)\13\n\13\nvoid SetWindowIcons(Image *images, int count);              // Set icon for window (multiple images, RGBA 32bit)\13\n\13\nvoid SetWindowTitle(const char *title);                     // Set title for window\13\n\13\nvoid SetWindowPosition(int x, int y);                       // Set window position on screen\13\n\13\nvoid SetWindowMonitor(int monitor);                         // Set monitor for the current window\13\n\13\nvoid SetWindowMinSize(int width, int height);               // Set window minimum dimensions (for FLAG_WINDOW_RESIZABLE)\13\n\13\nvoid SetWindowMaxSize(int width, int height);               // Set window maximum dimensions (for FLAG_WINDOW_RESIZABLE)\13\n\13\nvoid SetWindowSize(int width, int height);                  // Set window dimensions\13\n\13\nvoid SetWindowOpacity(float opacity);                       // Set window opacity [0.0f..1.0f]\13\n\13\nvoid SetWindowFocused(void);                                // Set window focused\13\n\13\nvoid *GetWindowHandle(void);                                // Get native window handle\13\n\13\nint GetScreenWidth(void);                                   // Get current screen width\13\n\13\nint GetScreenHeight(void);                                  // Get current screen height\13\n\13\nint GetRenderWidth(void);                                   // Get current render width (it considers HiDPI)\13\n\13\nint GetRenderHeight(void);                                  // Get current render height (it considers HiDPI)\13\n\13\nint GetMonitorCount(void);                                  // Get number of connected monitors\13\n\13\nint GetCurrentMonitor(void);                                // Get current monitor where window is placed\13\n\13\nVector2 GetMonitorPosition(int monitor);                    // Get specified monitor position\13\n\13\nint GetMonitorWidth(int monitor);                           // Get specified monitor width (current video mode used by monitor)\13\n\13\nint GetMonitorHeight(int monitor);                          // Get specified monitor height (current video mode used by monitor)\13\n\13\nint GetMonitorPhysicalWidth(int monitor);                   // Get specified monitor physical width in millimetres\13\n\13\nint GetMonitorPhysicalHeight(int monitor);                  // Get specified monitor physical height in millimetres\13\n\13\nint GetMonitorRefreshRate(int monitor);                     // Get specified monitor refresh rate\13\n\13\nVector2 GetWindowPosition(void);                            // Get window position XY on monitor\13\n\13\nVector2 GetWindowScaleDPI(void);                            // Get window scale DPI factor\13\n\13\nconst char *GetMonitorName(int monitor);                    // Get the human-readable, UTF-8 encoded name of the specified monitor\13\n\13\nvoid SetClipboardText(const char *text);                    // Set clipboard text content\13\n\13\nconst char *GetClipboardText(void);                         // Get clipboard text content\13\n\13\nImage GetClipboardImage(void);                              // Get clipboard image content\13\n\13\nvoid EnableEventWaiting(void);                              // Enable waiting for events on EndDrawing(), no automatic event polling\13\n\13\nvoid DisableEventWaiting(void);                             // Disable waiting for events on EndDrawing(), automatic events polling\13\n\13\n")
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
