(print "RAYLIB INPUT HANDLING MODULE INIT")

(local ffi (require :ffi))

(local os ffi.os)
(print os)

(local rl 
  (case os 
    :Windows (ffi.load :lib\raylib-5.5_win64_mingw-w64\lib\raylib.dll) 
    :Linux   (ffi.load :lib/raylib-5.5_linux_amd64/lib/libraylib.so)))
(assert (= rl nil) "Unknown OS. Sorry")

(ffi.cdef "
bool IsKeyPressed(int key);                             // Check if a key has been pressed once

bool IsKeyPressedRepeat(int key);                       // Check if a key has been pressed again

bool IsKeyDown(int key);                                // Check if a key is being pressed

bool IsKeyReleased(int key);                            // Check if a key has been released once

bool IsKeyUp(int key);                                  // Check if a key is NOT being pressed

int GetKeyPressed(void);                                // Get key pressed (keycode), call it multiple times for keys queued, returns 0 when the queue is empty

int GetCharPressed(void);                               // Get char pressed (unicode), call it multiple times for chars queued, returns 0 when the queue is empty

void SetExitKey(int key);                               // Set a custom key to exit program (default is ESC)

bool IsGamepadAvailable(int gamepad);                                        // Check if a gamepad is available

const char *GetGamepadName(int gamepad);                                     // Get gamepad internal name id

bool IsGamepadButtonPressed(int gamepad, int button);                        // Check if a gamepad button has been pressed once

bool IsGamepadButtonDown(int gamepad, int button);                           // Check if a gamepad button is being pressed

bool IsGamepadButtonReleased(int gamepad, int button);                       // Check if a gamepad button has been released once

bool IsGamepadButtonUp(int gamepad, int button);                             // Check if a gamepad button is NOT being pressed

int GetGamepadButtonPressed(void);                                           // Get the last gamepad button pressed

int GetGamepadAxisCount(int gamepad);                                        // Get gamepad axis count for a gamepad

float GetGamepadAxisMovement(int gamepad, int axis);                         // Get axis movement value for a gamepad axis

int SetGamepadMappings(const char *mappings);                                // Set internal gamepad mappings (SDL_GameControllerDB)

void SetGamepadVibration(int gamepad, float leftMotor, float rightMotor, float duration); // Set gamepad vibration for both motors (duration in seconds)

bool IsMouseButtonPressed(int button);                  // Check if a mouse button has been pressed once

bool IsMouseButtonDown(int button);                     // Check if a mouse button is being pressed

bool IsMouseButtonReleased(int button);                 // Check if a mouse button has been released once

bool IsMouseButtonUp(int button);                       // Check if a mouse button is NOT being pressed

int GetMouseX(void);                                    // Get mouse position X

int GetMouseY(void);                                    // Get mouse position Y

Vector2 GetMousePosition(void);                         // Get mouse position XY

Vector2 GetMouseDelta(void);                            // Get mouse delta between frames

void SetMousePosition(int x, int y);                    // Set mouse position XY

void SetMouseOffset(int offsetX, int offsetY);          // Set mouse offset

void SetMouseScale(float scaleX, float scaleY);         // Set mouse scaling

float GetMouseWheelMove(void);                          // Get mouse wheel movement for X or Y, whichever is larger

Vector2 GetMouseWheelMoveV(void);                       // Get mouse wheel movement for both X and Y

void SetMouseCursor(int cursor);                        // Set mouse cursor

int GetTouchX(void);                                    // Get touch position X for touch point 0 (relative to screen size)

int GetTouchY(void);                                    // Get touch position Y for touch point 0 (relative to screen size)

Vector2 GetTouchPosition(int index);                    // Get touch position XY for a touch point index (relative to screen size)

int GetTouchPointId(int index);                         // Get touch point identifier for given index

int GetTouchPointCount(void);                           // Get number of touch points

void SetGesturesEnabled(unsigned int flags);      // Enable a set of gestures using flags

bool IsGestureDetected(unsigned int gesture);     // Check if a gesture have been detected

int GetGestureDetected(void);                     // Get latest detected gesture

float GetGestureHoldDuration(void);               // Get gesture hold time in seconds

Vector2 GetGestureDragVector(void);               // Get gesture drag vector

float GetGestureDragAngle(void);                  // Get gesture drag angle

Vector2 GetGesturePinchVector(void);              // Get gesture pinch delta

float GetGesturePinchAngle(void);                 // Get gesture pinch angle

void UpdateCamera(Camera *camera, int mode);      // Update camera position for selected mode

void UpdateCameraPro(Camera *camera, Vector3 movement, Vector3 rotation, float zoom); // Update camera movement/rotation

")


;------------------------------------------------------------------------------------
; Input Handling Functions (Module: core)
;------------------------------------------------------------------------------------
; Input-related functions: keyboard
(fn is-key-pressed [key]
	"Check if a key has been pressed once"
	(rl.IsKeyPressed key))

(fn is-key-pressed-repeat [key]
	"Check if a key has been pressed again"
	(rl.IsKeyPressedRepeat key))

(fn is-key-down [key]
	"Check if a key is being pressed"
	(rl.IsKeyDown key))

(fn is-key-released [key]
	"Check if a key has been released once"
	(rl.IsKeyReleased key))

(fn is-key-up [key]
	"Check if a key is NOT being pressed"
	(rl.IsKeyUp key))

(fn get-key-pressed []
	"Get key pressed (keycode), call it multiple times for keys queued, returns 0 when the queue is empty"
	(rl.GetKeyPressed ))

(fn get-char-pressed []
	"Get char pressed (unicode), call it multiple times for chars queued, returns 0 when the queue is empty"
	(rl.GetCharPressed ))

(fn set-exit-key [key]
	"Set a custom key to exit program (default is ESC)"
	(rl.SetExitKey key))

; Input-related functions: gamepads
(fn is-gamepad-available [gamepad]
	"Check if a gamepad is available"
	(rl.IsGamepadAvailable gamepad))

(fn get-gamepad-name [gamepad]
	"Get gamepad internal name id"
	(rl.GetGamepadName gamepad))

(fn is-gamepad-button-pressed [gamepad button]
	"Check if a gamepad button has been pressed once"
	(rl.IsGamepadButtonPressed gamepad button))

(fn is-gamepad-button-down [gamepad button]
	"Check if a gamepad button is being pressed"
	(rl.IsGamepadButtonDown gamepad button))

(fn is-gamepad-button-released [gamepad button]
	"Check if a gamepad button has been released once"
	(rl.IsGamepadButtonReleased gamepad button))

(fn is-gamepad-button-up [gamepad button]
	"Check if a gamepad button is NOT being pressed"
	(rl.IsGamepadButtonUp gamepad button))

(fn get-gamepad-button-pressed []
	"Get the last gamepad button pressed"
	(rl.GetGamepadButtonPressed ))

(fn get-gamepad-axis-count [gamepad]
	"Get gamepad axis count for a gamepad"
	(rl.GetGamepadAxisCount gamepad))

(fn get-gamepad-axis-movement [gamepad axis]
	"Get axis movement value for a gamepad axis"
	(rl.GetGamepadAxisMovement gamepad axis))

(fn set-gamepad-mappings [mappings]
	"Set internal gamepad mappings (SDL_GameControllerDB)"
	(rl.SetGamepadMappings mappings))

(fn set-gamepad-vibration [gamepad left-motor right-motor duration]
	"Set gamepad vibration for both motors (duration in seconds)"
	(rl.SetGamepadVibration gamepad left-motor right-motor duration))

; Input-related functions: mouse
(fn is-mouse-button-pressed [button]
	"Check if a mouse button has been pressed once"
	(rl.IsMouseButtonPressed button))

(fn is-mouse-button-down [button]
	"Check if a mouse button is being pressed"
	(rl.IsMouseButtonDown button))

(fn is-mouse-button-released [button]
	"Check if a mouse button has been released once"
	(rl.IsMouseButtonReleased button))

(fn is-mouse-button-up [button]
	"Check if a mouse button is NOT being pressed"
	(rl.IsMouseButtonUp button))

(fn get-mouse-x []
	"Get mouse position X"
	(rl.GetMouseX ))

(fn get-mouse-y []
	"Get mouse position Y"
	(rl.GetMouseY ))

(fn get-mouse-position []
	"Get mouse position XY"
	(rl.GetMousePosition ))

(fn get-mouse-delta []
	"Get mouse delta between frames"
	(rl.GetMouseDelta ))

(fn set-mouse-position [x y]
	"Set mouse position XY"
	(rl.SetMousePosition x y))

(fn set-mouse-offset [offset-x offset-y]
	"Set mouse offset"
	(rl.SetMouseOffset offset-x offset-y))

(fn set-mouse-scale [scale-x scale-y]
	"Set mouse scaling"
	(rl.SetMouseScale scale-x scale-y))

(fn get-mouse-wheel-move []
	"Get mouse wheel movement for X or Y, whichever is larger"
	(rl.GetMouseWheelMove ))

(fn get-mouse-wheel-move-v []
	"Get mouse wheel movement for both X and Y"
	(rl.GetMouseWheelMoveV ))

(fn set-mouse-cursor [cursor]
	"Set mouse cursor"
	(rl.SetMouseCursor cursor))

; Input-related functions: touch
(fn get-touch-x []
	"Get touch position X for touch point 0 (relative to screen size)"
	(rl.GetTouchX ))

(fn get-touch-y []
	"Get touch position Y for touch point 0 (relative to screen size)"
	(rl.GetTouchY ))

(fn get-touch-position [index]
	"Get touch position XY for a touch point index (relative to screen size)"
	(rl.GetTouchPosition index))

(fn get-touch-point-id [index]
	"Get touch point identifier for given index"
	(rl.GetTouchPointId index))

(fn get-touch-point-count []
	"Get number of touch points"
	(rl.GetTouchPointCount ))

;------------------------------------------------------------------------------------
; Gestures and Touch Handling Functions (Module: rgestures)
;------------------------------------------------------------------------------------
(fn set-gestures-enabled [flags]
	"Enable a set of gestures using flags"
	(rl.SetGesturesEnabled flags))

(fn is-gesture-detected [gesture]
	"Check if a gesture have been detected"
	(rl.IsGestureDetected gesture))

(fn get-gesture-detected []
	"Get latest detected gesture"
	(rl.GetGestureDetected ))

(fn get-gesture-hold-duration []
	"Get gesture hold time in seconds"
	(rl.GetGestureHoldDuration ))

(fn get-gesture-drag-vector []
	"Get gesture drag vector"
	(rl.GetGestureDragVector ))

(fn get-gesture-drag-angle []
	"Get gesture drag angle"
	(rl.GetGestureDragAngle ))

(fn get-gesture-pinch-vector []
	"Get gesture pinch delta"
	(rl.GetGesturePinchVector ))

(fn get-gesture-pinch-angle []
	"Get gesture pinch angle"
	(rl.GetGesturePinchAngle ))

;------------------------------------------------------------------------------------
; Camera System Functions (Module: rcamera)
;------------------------------------------------------------------------------------
(fn update-camera [camera mode]
	"Update camera position for selected mode"
	(rl.UpdateCamera camera mode))

(fn update-camera-pro [camera movement rotation zoom]
	"Update camera movement/rotation"
	(rl.UpdateCameraPro camera movement rotation zoom))




{: is-key-pressed
 : is-key-pressed-repeat
 : is-key-down
 : is-key-released
 : is-key-up
 : get-key-pressed
 : get-char-pressed
 : set-exit-key
 : is-gamepad-available
 : get-gamepad-name
 : is-gamepad-button-pressed
 : is-gamepad-button-down
 : is-gamepad-button-released
 : is-gamepad-button-up
 : get-gamepad-button-pressed
 : get-gamepad-axis-count
 : get-gamepad-axis-movement
 : set-gamepad-mappings
 : set-gamepad-vibration
 : is-mouse-button-pressed
 : is-mouse-button-down
 : is-mouse-button-released
 : is-mouse-button-up
 : get-mouse-x
 : get-mouse-y
 : get-mouse-position
 : get-mouse-delta
 : set-mouse-position
 : set-mouse-offset
 : set-mouse-scale
 : get-mouse-wheel-move
 : get-mouse-wheel-move-v
 : set-mouse-cursor
 : get-touch-x
 : get-touch-y
 : get-touch-position
 : get-touch-point-id
 : get-touch-point-count
 : set-gestures-enabled
 : is-gesture-detected
 : get-gesture-detected
 : get-gesture-hold-duration
 : get-gesture-drag-vector
 : get-gesture-drag-angle
 : get-gesture-pinch-vector
 : get-gesture-pinch-angle
 : update-camera
 : update-camera-pro}