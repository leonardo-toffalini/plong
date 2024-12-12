local Object = require("classic")
local Ball = Object:extend()

function Ball:new(x, y, width, height)
  self.x = x
  self.y = y
  self.width = width
  self.height = height
  -- 2 * math.random(0, 1) - 1 generates -1 or 1 with 0.5 - 0.5 probability
  self.x_speed = math.random(100, 250) * (2 * math.random(0, 1) - 1)
  self.y_speed = math.random(100, 250) * (2 * math.random(0, 1) - 1)
end

function Ball:update(dt)
  self.x = self.x + self.x_speed * dt
  self.y = self.y + self.y_speed * dt

  self:check_boundaries()
end

function Ball:paddle_hit(player1, player2)
  if self:check_collision(player1) or self:check_collision(player2) then
    self.y_speed = -self.y_speed
  end
end

function Ball:check_boundaries()
  if self.x < 0 then
    self.x_speed = -self.x_speed
    self.x = 0
  end
  if self.x + self.width > love.graphics.getWidth() then
    self.x_speed = -self.x_speed
    self.x = love.graphics.getWidth() - self.width
  end
  if self.y < 0 then
    self.y_speed = -self.y_speed
    self.y = 0
  end
  if self.y + self.height > love.graphics.getHeight() then
    self.y_speed = -self.y_speed
    self.y = love.graphics.getHeight() - self.height
  end
end

function Ball:check_collision(other)
  return self.x + self.width > other.x
    and self.x < other.x + other.width
    and self.y + self.height > other.y
    and self.y < other.y + other.height
end

function Ball:check_score()
  if self.y < 10 then
    return 2
  elseif self.y > love.graphics.getHeight() - 10 then
    return 1
  end
  return 0
end

function Ball:draw()
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

return Ball
