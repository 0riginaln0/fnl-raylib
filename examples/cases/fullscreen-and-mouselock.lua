local rl = require("lib.raylib")
local lume = require("lib.lume")
local screen_width = 500
local screen_height = 500
rl["init-window"](screen_width, screen_height, "raylib [core] example - mouse input")
rl["set-target-fps"](60)
local cursor_pos = rl.Vector2(0, 0)
local cursor_color = rl.maroon
local current_screen = rl["get-current-monitor"]()
local function get_new_cursor_pos()
  local mouse_pos = rl["get-mouse-position"]()
  if rl["is-cursor-hidden"]() then
    local window_width = rl["get-render-width"]()
    local window_height = rl["get-render-height"]()
    local _1_ = mouse_pos.x
    local and_2_ = ((0 < _1_) and (_1_ < window_width))
    if and_2_ then
      local _3_ = mouse_pos.y
      and_2_ = ((0 < _3_) and (_3_ < window_height))
    end
    if and_2_ then
      return mouse_pos
    else
      local mouse_dt = rl["get-mouse-delta"]()
      local dt_x = lume.clamp((cursor_pos.x + mouse_dt.x), 0, window_width)
      local dt_y = lume.clamp((cursor_pos.y + mouse_dt.y), 0, window_height)
      local dt = rl.Vector2(dt_x, dt_y)
      rl["set-mouse-position"](dt.x, dt.y)
      return dt
    end
  else
    return mouse_pos
  end
end
local function toggle_fullscreen()
  current_screen = rl["get-current-monitor"]()
  if rl["is-window-fullscreen"]() then
    rl["set-window-size"](screen_width, screen_height)
    rl["enable-cursor"]()
  else
    rl["set-window-size"](rl["get-monitor-width"](current_screen), rl["get-monitor-height"](current_screen))
    rl["disable-cursor"]()
  end
  return rl["toggle-fullscreen"]()
end
local function toggle_mouselock()
  if rl["is-cursor-hidden"]() then
    return rl["enable-cursor"]()
  else
    return rl["disable-cursor"]()
  end
end
while not rl["window-should-close"]() do
  cursor_pos = get_new_cursor_pos()
  if rl["is-key-pressed"](rl["key-f11"]) then
    toggle_fullscreen()
  else
  end
  if rl["is-key-pressed"](rl["key-f10"]) then
    toggle_mouselock()
  else
  end
  rl["begin-drawing"]()
  rl["clear-background"](rl.darkgray)
  rl["draw-text"]("Press F11 to toggle full screen mode", 10, 10, 20, rl.lightgray)
  rl["draw-circle-v"](cursor_pos, 10, cursor_color)
  rl["draw-text"]("Press F10 to toggle mouse lock mode", 10, 40, 20, rl.lightgray)
  rl["draw-circle-v"](cursor_pos, 10, cursor_color)
  rl["end-drawing"]()
end
rl["close-window"]()
return print("That's all")
