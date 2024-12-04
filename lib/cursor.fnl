; Cursor-related functions

(print "RAYLIB CURSOR MODULE INIT")

(local ffi (require :ffi))

(local os ffi.os)
(print os)

(local rl 
  (case os 
    :Windows (ffi.load :lib\raylib-5.5_win64_mingw-w64\lib\raylib.dll) 
    :Linux   (ffi.load :lib/raylib-5.5_linux_amd64/lib/libraylib.so)))
; (assert (= rl nil) "Unknown OS. Sorry")


(ffi.cdef "
void ShowCursor(void);                                      // Shows cursor

void HideCursor(void);                                      // Hides cursor

bool IsCursorHidden(void);                                  // Check if cursor is not visible

void EnableCursor(void);                                    // Enables cursor (unlock cursor)

void DisableCursor(void);                                   // Disables cursor (lock cursor)

bool IsCursorOnScreen(void);                                // Check if cursor is on the screen
")

(fn show-cursor []
	"Shows cursor"
	(rl.ShowCursor ))

(fn hide-cursor []
	"Hides cursor"
	(rl.HideCursor ))

(fn is-cursor-hidden []
	"Check if cursor is not visible"
	(rl.IsCursorHidden ))

(fn enable-cursor []
	"Enables cursor (unlock cursor)"
	(rl.EnableCursor ))

(fn disable-cursor []
	"Disables cursor (lock cursor)"
	(rl.DisableCursor ))

(fn is-cursor-on-screen []
	"Check if cursor is on the screen"
	(rl.IsCursorOnScreen ))

{: show-cursor
 : hide-cursor
 : is-cursor-hidden
 : enable-cursor
 : disable-cursor
 : is-cursor-on-screen}