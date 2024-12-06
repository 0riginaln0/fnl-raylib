local rl = require("lib.raylib")
local screen_width = 800
local screen_height = 450
rl["init-window"](screen_width, screen_height, "I AM A WINDOW")
rl["set-target-fps"](60)
while not rl["window-should-close"]() do
  rl["begin-drawing"]()
  rl["clear-background"](rl.raywhite)
  rl["draw-text"]("Congrats! You created your first window!", 190, 200, 20, rl.lightgray)
  rl["end-drawing"]()
end
rl["close-window"]()
return print("That's all")
