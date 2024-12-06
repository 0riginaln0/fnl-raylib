local rl = require("lib.raylib")
local screen_width = 800
local screen_height = 450
rl["init-window"](screen_width, screen_height, "raylib [core] example - mouse input")
local ball_position = rl.Vector2(0, 0)
local ball_color = rl.darkblue
rl["set-target-fps"](60)
while not rl["window-should-close"]() do
  ball_position = rl["get-mouse-position"]()
  if rl["is-mouse-button-pressed"](rl["mouse-button-left"]) then
    ball_color = rl.maroon
  elseif rl["is-mouse-button-pressed"](rl["mouse-button-middle"]) then
    ball_color = rl.lime
  elseif rl["is-mouse-button-pressed"](rl["mouse-button-right"]) then
    ball_color = rl.darkblue
  elseif rl["is-mouse-button-pressed"](rl["mouse-button-side"]) then
    ball_color = rl.purple
  elseif rl["is-mouse-button-pressed"](rl["mouse-button-extra"]) then
    ball_color = rl.yellow
  elseif rl["is-mouse-button-pressed"](rl["mouse-button-forward"]) then
    ball_color = rl.orange
  elseif rl["is-mouse-button-pressed"](rl["mouse-button-back"]) then
    ball_color = rl.beige
  else
  end
  rl["begin-drawing"]()
  rl["clear-background"](rl.raywhite)
  rl["draw-text"]("move ball with mouse and click mouse button to change color", 10, 10, 20, rl.darkgray)
  rl["draw-circle-v"](ball_position, 40, ball_color)
  rl["end-drawing"]()
end
rl["close-window"]()
return print("That's all")
