print("RAYLIB INPUT HANDLING MODULE INIT")
local dll = require("lib.dll")
local ffi = dll.ffi
local rl = dll.rl
ffi.cdef("\13\nbool IsKeyPressed(int key);                             // Check if a key has been pressed once\13\n\13\nbool IsKeyPressedRepeat(int key);                       // Check if a key has been pressed again\13\n\13\nbool IsKeyDown(int key);                                // Check if a key is being pressed\13\n\13\nbool IsKeyReleased(int key);                            // Check if a key has been released once\13\n\13\nbool IsKeyUp(int key);                                  // Check if a key is NOT being pressed\13\n\13\nint GetKeyPressed(void);                                // Get key pressed (keycode), call it multiple times for keys queued, returns 0 when the queue is empty\13\n\13\nint GetCharPressed(void);                               // Get char pressed (unicode), call it multiple times for chars queued, returns 0 when the queue is empty\13\n\13\nvoid SetExitKey(int key);                               // Set a custom key to exit program (default is ESC)\13\n\13\nbool IsGamepadAvailable(int gamepad);                                        // Check if a gamepad is available\13\n\13\nconst char *GetGamepadName(int gamepad);                                     // Get gamepad internal name id\13\n\13\nbool IsGamepadButtonPressed(int gamepad, int button);                        // Check if a gamepad button has been pressed once\13\n\13\nbool IsGamepadButtonDown(int gamepad, int button);                           // Check if a gamepad button is being pressed\13\n\13\nbool IsGamepadButtonReleased(int gamepad, int button);                       // Check if a gamepad button has been released once\13\n\13\nbool IsGamepadButtonUp(int gamepad, int button);                             // Check if a gamepad button is NOT being pressed\13\n\13\nint GetGamepadButtonPressed(void);                                           // Get the last gamepad button pressed\13\n\13\nint GetGamepadAxisCount(int gamepad);                                        // Get gamepad axis count for a gamepad\13\n\13\nfloat GetGamepadAxisMovement(int gamepad, int axis);                         // Get axis movement value for a gamepad axis\13\n\13\nint SetGamepadMappings(const char *mappings);                                // Set internal gamepad mappings (SDL_GameControllerDB)\13\n\13\nvoid SetGamepadVibration(int gamepad, float leftMotor, float rightMotor, float duration); // Set gamepad vibration for both motors (duration in seconds)\13\n\13\nbool IsMouseButtonPressed(int button);                  // Check if a mouse button has been pressed once\13\n\13\nbool IsMouseButtonDown(int button);                     // Check if a mouse button is being pressed\13\n\13\nbool IsMouseButtonReleased(int button);                 // Check if a mouse button has been released once\13\n\13\nbool IsMouseButtonUp(int button);                       // Check if a mouse button is NOT being pressed\13\n\13\nint GetMouseX(void);                                    // Get mouse position X\13\n\13\nint GetMouseY(void);                                    // Get mouse position Y\13\n\13\nVector2 GetMousePosition(void);                         // Get mouse position XY\13\n\13\nVector2 GetMouseDelta(void);                            // Get mouse delta between frames\13\n\13\nvoid SetMousePosition(int x, int y);                    // Set mouse position XY\13\n\13\nvoid SetMouseOffset(int offsetX, int offsetY);          // Set mouse offset\13\n\13\nvoid SetMouseScale(float scaleX, float scaleY);         // Set mouse scaling\13\n\13\nfloat GetMouseWheelMove(void);                          // Get mouse wheel movement for X or Y, whichever is larger\13\n\13\nVector2 GetMouseWheelMoveV(void);                       // Get mouse wheel movement for both X and Y\13\n\13\nvoid SetMouseCursor(int cursor);                        // Set mouse cursor\13\n\13\nint GetTouchX(void);                                    // Get touch position X for touch point 0 (relative to screen size)\13\n\13\nint GetTouchY(void);                                    // Get touch position Y for touch point 0 (relative to screen size)\13\n\13\nVector2 GetTouchPosition(int index);                    // Get touch position XY for a touch point index (relative to screen size)\13\n\13\nint GetTouchPointId(int index);                         // Get touch point identifier for given index\13\n\13\nint GetTouchPointCount(void);                           // Get number of touch points\13\n\13\nvoid SetGesturesEnabled(unsigned int flags);      // Enable a set of gestures using flags\13\n\13\nbool IsGestureDetected(unsigned int gesture);     // Check if a gesture have been detected\13\n\13\nint GetGestureDetected(void);                     // Get latest detected gesture\13\n\13\nfloat GetGestureHoldDuration(void);               // Get gesture hold time in seconds\13\n\13\nVector2 GetGestureDragVector(void);               // Get gesture drag vector\13\n\13\nfloat GetGestureDragAngle(void);                  // Get gesture drag angle\13\n\13\nVector2 GetGesturePinchVector(void);              // Get gesture pinch delta\13\n\13\nfloat GetGesturePinchAngle(void);                 // Get gesture pinch angle\13\n\13\nvoid UpdateCamera(Camera *camera, int mode);      // Update camera position for selected mode\13\n\13\nvoid UpdateCameraPro(Camera *camera, Vector3 movement, Vector3 rotation, float zoom); // Update camera movement/rotation\13\n\13\n")
local function is_key_pressed(key)
  return rl.IsKeyPressed(key)
end
local function is_key_pressed_repeat(key)
  return rl.IsKeyPressedRepeat(key)
end
local function is_key_down(key)
  return rl.IsKeyDown(key)
end
local function is_key_released(key)
  return rl.IsKeyReleased(key)
end
local function is_key_up(key)
  return rl.IsKeyUp(key)
end
local function get_key_pressed()
  return rl.GetKeyPressed()
end
local function get_char_pressed()
  return rl.GetCharPressed()
end
local function set_exit_key(key)
  return rl.SetExitKey(key)
end
local function is_gamepad_available(gamepad)
  return rl.IsGamepadAvailable(gamepad)
end
local function get_gamepad_name(gamepad)
  return rl.GetGamepadName(gamepad)
end
local function is_gamepad_button_pressed(gamepad, button)
  return rl.IsGamepadButtonPressed(gamepad, button)
end
local function is_gamepad_button_down(gamepad, button)
  return rl.IsGamepadButtonDown(gamepad, button)
end
local function is_gamepad_button_released(gamepad, button)
  return rl.IsGamepadButtonReleased(gamepad, button)
end
local function is_gamepad_button_up(gamepad, button)
  return rl.IsGamepadButtonUp(gamepad, button)
end
local function get_gamepad_button_pressed()
  return rl.GetGamepadButtonPressed()
end
local function get_gamepad_axis_count(gamepad)
  return rl.GetGamepadAxisCount(gamepad)
end
local function get_gamepad_axis_movement(gamepad, axis)
  return rl.GetGamepadAxisMovement(gamepad, axis)
end
local function set_gamepad_mappings(mappings)
  return rl.SetGamepadMappings(mappings)
end
local function set_gamepad_vibration(gamepad, left_motor, right_motor, duration)
  return rl.SetGamepadVibration(gamepad, left_motor, right_motor, duration)
end
local function is_mouse_button_pressed(button)
  return rl.IsMouseButtonPressed(button)
end
local function is_mouse_button_down(button)
  return rl.IsMouseButtonDown(button)
end
local function is_mouse_button_released(button)
  return rl.IsMouseButtonReleased(button)
end
local function is_mouse_button_up(button)
  return rl.IsMouseButtonUp(button)
end
local function get_mouse_x()
  return rl.GetMouseX()
end
local function get_mouse_y()
  return rl.GetMouseY()
end
local function get_mouse_position()
  return rl.GetMousePosition()
end
local function get_mouse_delta()
  return rl.GetMouseDelta()
end
local function set_mouse_position(x, y)
  return rl.SetMousePosition(x, y)
end
local function set_mouse_offset(offset_x, offset_y)
  return rl.SetMouseOffset(offset_x, offset_y)
end
local function set_mouse_scale(scale_x, scale_y)
  return rl.SetMouseScale(scale_x, scale_y)
end
local function get_mouse_wheel_move()
  return rl.GetMouseWheelMove()
end
local function get_mouse_wheel_move_v()
  return rl.GetMouseWheelMoveV()
end
local function set_mouse_cursor(cursor)
  return rl.SetMouseCursor(cursor)
end
local function get_touch_x()
  return rl.GetTouchX()
end
local function get_touch_y()
  return rl.GetTouchY()
end
local function get_touch_position(index)
  return rl.GetTouchPosition(index)
end
local function get_touch_point_id(index)
  return rl.GetTouchPointId(index)
end
local function get_touch_point_count()
  return rl.GetTouchPointCount()
end
local function set_gestures_enabled(flags)
  return rl.SetGesturesEnabled(flags)
end
local function is_gesture_detected(gesture)
  return rl.IsGestureDetected(gesture)
end
local function get_gesture_detected()
  return rl.GetGestureDetected()
end
local function get_gesture_hold_duration()
  return rl.GetGestureHoldDuration()
end
local function get_gesture_drag_vector()
  return rl.GetGestureDragVector()
end
local function get_gesture_drag_angle()
  return rl.GetGestureDragAngle()
end
local function get_gesture_pinch_vector()
  return rl.GetGesturePinchVector()
end
local function get_gesture_pinch_angle()
  return rl.GetGesturePinchAngle()
end
local function update_camera(camera, mode)
  return rl.UpdateCamera(camera, mode)
end
local function update_camera_pro(camera, movement, rotation, zoom)
  return rl.UpdateCameraPro(camera, movement, rotation, zoom)
end
return {["is-key-pressed"] = is_key_pressed, ["is-key-pressed-repeat"] = is_key_pressed_repeat, ["is-key-down"] = is_key_down, ["is-key-released"] = is_key_released, ["is-key-up"] = is_key_up, ["get-key-pressed"] = get_key_pressed, ["get-char-pressed"] = get_char_pressed, ["set-exit-key"] = set_exit_key, ["is-gamepad-available"] = is_gamepad_available, ["get-gamepad-name"] = get_gamepad_name, ["is-gamepad-button-pressed"] = is_gamepad_button_pressed, ["is-gamepad-button-down"] = is_gamepad_button_down, ["is-gamepad-button-released"] = is_gamepad_button_released, ["is-gamepad-button-up"] = is_gamepad_button_up, ["get-gamepad-button-pressed"] = get_gamepad_button_pressed, ["get-gamepad-axis-count"] = get_gamepad_axis_count, ["get-gamepad-axis-movement"] = get_gamepad_axis_movement, ["set-gamepad-mappings"] = set_gamepad_mappings, ["set-gamepad-vibration"] = set_gamepad_vibration, ["is-mouse-button-pressed"] = is_mouse_button_pressed, ["is-mouse-button-down"] = is_mouse_button_down, ["is-mouse-button-released"] = is_mouse_button_released, ["is-mouse-button-up"] = is_mouse_button_up, ["get-mouse-x"] = get_mouse_x, ["get-mouse-y"] = get_mouse_y, ["get-mouse-position"] = get_mouse_position, ["get-mouse-delta"] = get_mouse_delta, ["set-mouse-position"] = set_mouse_position, ["set-mouse-offset"] = set_mouse_offset, ["set-mouse-scale"] = set_mouse_scale, ["get-mouse-wheel-move"] = get_mouse_wheel_move, ["get-mouse-wheel-move-v"] = get_mouse_wheel_move_v, ["set-mouse-cursor"] = set_mouse_cursor, ["get-touch-x"] = get_touch_x, ["get-touch-y"] = get_touch_y, ["get-touch-position"] = get_touch_position, ["get-touch-point-id"] = get_touch_point_id, ["get-touch-point-count"] = get_touch_point_count, ["set-gestures-enabled"] = set_gestures_enabled, ["is-gesture-detected"] = is_gesture_detected, ["get-gesture-detected"] = get_gesture_detected, ["get-gesture-hold-duration"] = get_gesture_hold_duration, ["get-gesture-drag-vector"] = get_gesture_drag_vector, ["get-gesture-drag-angle"] = get_gesture_drag_angle, ["get-gesture-pinch-vector"] = get_gesture_pinch_vector, ["get-gesture-pinch-angle"] = get_gesture_pinch_angle, ["update-camera"] = update_camera, ["update-camera-pro"] = update_camera_pro}
