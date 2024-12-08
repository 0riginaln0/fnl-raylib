; Cursor-related functions

(print "LOAD: CURSOR")

(local dll (require :lib.dll))
(local ffi (. dll :ffi))
(local rl (. dll :rl))

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