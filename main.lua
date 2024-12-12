local window_width = love.graphics.getWidth()
local window_height = love.graphics.getHeight()
local Ball = require("ball")

function love.load()
  local Paddle = require("paddle")
  player1 = Paddle(window_width / 2, 10, 50, 10, "left", "right")
  player2 = Paddle(window_width / 2, window_height- 20, 50, 10, "a", "d")
  ball = Ball(window_width / 2, window_height / 2, 5, 5)
  score = {0, 0}
end

function love.update(dt)
  player1:update(dt)
  player2:update(dt)
  ball:update(dt)
  ball:paddle_hit(player1, player2)
  if ball:check_score() == 1 then
    ball = Ball(window_width / 2, window_height / 2, 5, 5)
    score[1] = score[1] + 1
  elseif ball:check_score() == 2 then
    ball = Ball(window_width / 2, window_height / 2, 5, 5)
    score[2] = score[2] + 1
  end
end

function love.draw()
  player1:draw("line")
  player2:draw("line")
  ball:draw()
  love.graphics.print(score[1] .. " - " .. score[2], 20, 60)
end
