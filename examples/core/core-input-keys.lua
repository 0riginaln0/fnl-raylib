local rl = require("lib.raylib")
local screen_width = 800
local screen_height = 450
rl["init-window"](screen_width, screen_height, "raylib [core] example - keyboard input")
local ball_position = rl.Vector2((screen_width / 2), (screen_height / 2))
print(ball_position.x)
print(ball_position.y)
rl["set-target-fps"](60)
while not rl["window-should-close"]() do
  if rl["is-key-down"](rl["key-right"]) then
    ball_position.x = (ball_position.x + 2)
  else
  end
  if rl["is-key-down"](rl["key-left"]) then
    ball_position.x = (ball_position.x - 2)
  else
  end
  if rl["is-key-down"](rl["key-up"]) then
    ball_position.y = (ball_position.y - 2)
  else
  end
  if rl["is-key-down"](rl["key-down"]) then
    ball_position.y = (ball_position.y + 2)
  else
  end
  rl["begin-drawing"]()
  rl["clear-background"](rl.raywhite)
  rl["draw-text"]("move the ball with arrow keys", 10, 10, 20, rl.darkgray)
  rl["draw-circle-v"](ball_position, 50, rl.maroon)
  rl["end-drawing"]()
end
rl["close-window"]()
return print("That's all")
