(print "RAYLIB WINDOW MODULE INIT")

(local ffi (require :ffi))

(local os ffi.os)
; (print os)

(local rl 
  (case os 
    :Windows (ffi.load :lib\raylib-5.5_win64_mingw-w64\lib\raylib.dll) 
    :Linux   (ffi.load :lib/raylib-5.5_linux_amd64/lib/libraylib.so)))


(ffi.cdef "
void InitWindow(int width, int height, const char *title);  // Initialize window and OpenGL context

void CloseWindow(void);                                     // Close window and unload OpenGL context

bool WindowShouldClose(void);                               // Check if application should close (KEY_ESCAPE pressed or windows close icon clicked)

bool IsWindowReady(void);                                   // Check if window has been initialized successfully

bool IsWindowFullscreen(void);                              // Check if window is currently fullscreen

bool IsWindowHidden(void);                                  // Check if window is currently hidden

bool IsWindowMinimized(void);                               // Check if window is currently minimized

bool IsWindowMaximized(void);                               // Check if window is currently maximized

bool IsWindowFocused(void);                                 // Check if window is currently focused

bool IsWindowResized(void);                                 // Check if window has been resized last frame

bool IsWindowState(unsigned int flag);                      // Check if one specific window flag is enabled

void SetWindowState(unsigned int flags);                    // Set window configuration state using flags

void ClearWindowState(unsigned int flags);                  // Clear window configuration state flags

void ToggleFullscreen(void);                                // Toggle window state: fullscreen/windowed, resizes monitor to match window resolution

void ToggleBorderlessWindowed(void);                        // Toggle window state: borderless windowed, resizes window to match monitor resolution

void MaximizeWindow(void);                                  // Set window state: maximized, if resizable

void MinimizeWindow(void);                                  // Set window state: minimized, if resizable

void RestoreWindow(void);                                   // Set window state: not minimized/maximized

void SetWindowIcon(Image image);                            // Set icon for window (single image, RGBA 32bit)

void SetWindowIcons(Image *images, int count);              // Set icon for window (multiple images, RGBA 32bit)

void SetWindowTitle(const char *title);                     // Set title for window

void SetWindowPosition(int x, int y);                       // Set window position on screen

void SetWindowMonitor(int monitor);                         // Set monitor for the current window

void SetWindowMinSize(int width, int height);               // Set window minimum dimensions (for FLAG_WINDOW_RESIZABLE)

void SetWindowMaxSize(int width, int height);               // Set window maximum dimensions (for FLAG_WINDOW_RESIZABLE)

void SetWindowSize(int width, int height);                  // Set window dimensions

void SetWindowOpacity(float opacity);                       // Set window opacity [0.0f..1.0f]

void SetWindowFocused(void);                                // Set window focused

void *GetWindowHandle(void);                                // Get native window handle

int GetScreenWidth(void);                                   // Get current screen width

int GetScreenHeight(void);                                  // Get current screen height

int GetRenderWidth(void);                                   // Get current render width (it considers HiDPI)

int GetRenderHeight(void);                                  // Get current render height (it considers HiDPI)

int GetMonitorCount(void);                                  // Get number of connected monitors

int GetCurrentMonitor(void);                                // Get current monitor where window is placed

Vector2 GetMonitorPosition(int monitor);                    // Get specified monitor position

int GetMonitorWidth(int monitor);                           // Get specified monitor width (current video mode used by monitor)

int GetMonitorHeight(int monitor);                          // Get specified monitor height (current video mode used by monitor)

int GetMonitorPhysicalWidth(int monitor);                   // Get specified monitor physical width in millimetres

int GetMonitorPhysicalHeight(int monitor);                  // Get specified monitor physical height in millimetres

int GetMonitorRefreshRate(int monitor);                     // Get specified monitor refresh rate

Vector2 GetWindowPosition(void);                            // Get window position XY on monitor

Vector2 GetWindowScaleDPI(void);                            // Get window scale DPI factor

const char *GetMonitorName(int monitor);                    // Get the human-readable, UTF-8 encoded name of the specified monitor

void SetClipboardText(const char *text);                    // Set clipboard text content

const char *GetClipboardText(void);                         // Get clipboard text content

Image GetClipboardImage(void);                              // Get clipboard image content

void EnableEventWaiting(void);                              // Enable waiting for events on EndDrawing(), no automatic event polling

void DisableEventWaiting(void);                             // Disable waiting for events on EndDrawing(), automatic events polling

")

; Window-related functions
(fn init-window [width height title]
	"Initialize window and OpenGL context"
	(rl.InitWindow width height title))

(fn close-window []
	"Close window and unload OpenGL context"
	(rl.CloseWindow ))

(fn window-should-close []
	"Check if application should close (KEY_ESCAPE pressed or windows close icon clicked)"
	(rl.WindowShouldClose ))

(fn is-window-ready []
	"Check if window has been initialized successfully"
	(rl.IsWindowReady ))

(fn is-window-fullscreen []
	"Check if window is currently fullscreen"
	(rl.IsWindowFullscreen ))

(fn is-window-hidden []
	"Check if window is currently hidden"
	(rl.IsWindowHidden ))

(fn is-window-minimized []
	"Check if window is currently minimized"
	(rl.IsWindowMinimized ))

(fn is-window-maximized []
	"Check if window is currently maximized"
	(rl.IsWindowMaximized ))

(fn is-window-focused []
	"Check if window is currently focused"
	(rl.IsWindowFocused ))

(fn is-window-resized []
	"Check if window has been resized last frame"
	(rl.IsWindowResized ))

(fn is-window-state [flag]
	"Check if one specific window flag is enabled"
	(rl.IsWindowState flag))

(fn set-window-state [flags]
	"Set window configuration state using flags"
	(rl.SetWindowState flags))

(fn clear-window-state [flags]
	"Clear window configuration state flags"
	(rl.ClearWindowState flags))

(fn toggle-fullscreen []
	"Toggle window state: fullscreen/windowed, resizes monitor to match window resolution"
	(rl.ToggleFullscreen ))

(fn toggle-borderless-windowed []
	"Toggle window state: borderless windowed, resizes window to match monitor resolution"
	(rl.ToggleBorderlessWindowed ))

(fn maximize-window []
	"Set window state: maximized, if resizable"
	(rl.MaximizeWindow ))

(fn minimize-window []
	"Set window state: minimized, if resizable"
	(rl.MinimizeWindow ))

(fn restore-window []
	"Set window state: not minimized/maximized"
	(rl.RestoreWindow ))

(fn set-window-icon [image]
	"Set icon for window (single image, RGBA 32bit)"
	(rl.SetWindowIcon image))

(fn set-window-icons [images count]
	"Set icon for window (multiple images, RGBA 32bit)"
	(rl.SetWindowIcons images count))

(fn set-window-title [title]
	"Set title for window"
	(rl.SetWindowTitle title))

(fn set-window-position [x y]
	"Set window position on screen"
	(rl.SetWindowPosition x y))

(fn set-window-monitor [monitor]
	"Set monitor for the current window"
	(rl.SetWindowMonitor monitor))

(fn set-window-min-size [width height]
	"Set window minimum dimensions (for FLAG_WINDOW_RESIZABLE)"
	(rl.SetWindowMinSize width height))

(fn set-window-max-size [width height]
	"Set window maximum dimensions (for FLAG_WINDOW_RESIZABLE)"
	(rl.SetWindowMaxSize width height))

(fn set-window-size [width height]
	"Set window dimensions"
	(rl.SetWindowSize width height))

(fn set-window-opacity [opacity]
	"Set window opacity [0.0f..1.0f]"
	(rl.SetWindowOpacity opacity))

(fn set-window-focused []
	"Set window focused"
	(rl.SetWindowFocused ))

(fn get-window-handle []
	"Get native window handle"
	(rl.GetWindowHandle ))

(fn get-screen-width []
	"Get current screen width"
	(rl.GetScreenWidth ))

(fn get-screen-height []
	"Get current screen height"
	(rl.GetScreenHeight ))

(fn get-render-width []
	"Get current render width (it considers HiDPI)"
	(rl.GetRenderWidth ))

(fn get-render-height []
	"Get current render height (it considers HiDPI)"
	(rl.GetRenderHeight ))

(fn get-monitor-count []
	"Get number of connected monitors"
	(rl.GetMonitorCount ))

(fn get-current-monitor []
	"
	Get current monitor where window is placed. 
	Returns 0, 1, 2 or any other number according to the Monitor number
	"
	(rl.GetCurrentMonitor ))

(fn get-monitor-position [monitor]
	"Get specified monitor position"
	(rl.GetMonitorPosition monitor))

(fn get-monitor-width [monitor]
	"Get specified monitor width (current video mode used by monitor)"
	(rl.GetMonitorWidth monitor))

(fn get-monitor-height [monitor]
	"Get specified monitor height (current video mode used by monitor)"
	(rl.GetMonitorHeight monitor))

(fn get-monitor-physical-width [monitor]
	"Get specified monitor physical width in millimetres"
	(rl.GetMonitorPhysicalWidth monitor))

(fn get-monitor-physical-height [monitor]
	"Get specified monitor physical height in millimetres"
	(rl.GetMonitorPhysicalHeight monitor))

(fn get-monitor-refresh-rate [monitor]
	"Get specified monitor refresh rate"
	(rl.GetMonitorRefreshRate monitor))

(fn get-window-position []
	"Get window position XY on monitor"
	(rl.GetWindowPosition ))

(fn get-window-scale-dpi []
	"Get window scale DPI factor"
	(rl.GetWindowScaleDPI ))

(fn get-monitor-name [monitor]
	"Get the human-readable, UTF-8 encoded name of the specified monitor"
	(rl.GetMonitorName monitor))

(fn set-clipboard-text [text]
	"Set clipboard text content"
	(rl.SetClipboardText text))

(fn get-clipboard-text []
	"Get clipboard text content"
	(rl.GetClipboardText ))

(fn get-clipboard-image []
	"Get clipboard image content"
	(rl.GetClipboardImage ))

(fn enable-event-waiting []
	"Enable waiting for events on EndDrawing(), no automatic event polling"
	(rl.EnableEventWaiting ))

(fn disable-event-waiting []
	"Disable waiting for events on EndDrawing(), automatic events polling"
	(rl.DisableEventWaiting ))

{: init-window
 : close-window
 : window-should-close
 : is-window-ready
 : is-window-fullscreen
 : is-window-hidden
 : is-window-minimized
 : is-window-maximized
 : is-window-focused
 : is-window-resized
 : is-window-state
 : set-window-state
 : clear-window-state
 : toggle-fullscreen
 : toggle-borderless-windowed
 : maximize-window
 : minimize-window
 : restore-window
 : set-window-icon
 : set-window-icons
 : set-window-title
 : set-window-position
 : set-window-monitor
 : set-window-min-size
 : set-window-max-size
 : set-window-size
 : set-window-opacity
 : set-window-focused
 : get-window-handle
 : get-screen-width
 : get-screen-height
 : get-render-width
 : get-render-height
 : get-monitor-count
 : get-current-monitor
 : get-monitor-position
 : get-monitor-width
 : get-monitor-height
 : get-monitor-physical-width
 : get-monitor-physical-height
 : get-monitor-refresh-rate
 : get-window-position
 : get-window-scale-dpi
 : get-monitor-name
 : set-clipboard-text
 : get-clipboard-text
 : get-clipboard-image
 : enable-event-waiting
 : disable-event-waiting}