local Object = require("classic")
local Paddle = Object:extend()

function Paddle:new(x, y, width, height, left_key, right_key)
  self.x = x
  self.y = y
  self.width = width
  self.height = height
  self.speed = 240
  self.left_key = left_key
  self.right_key = right_key
end

function Paddle:update(dt)
  -- left-right movement
  if love.keyboard.isDown(self.left_key) then
    self.x = self.x - self.speed * dt
  elseif love.keyboard.isDown(self.right_key) then
    self.x = self.x + self.speed * dt
  end

  self:check_boundaries()
end

function Paddle:check_boundaries()
  if self.x < 0 then
    self.x = 0
  end
  if self.x + self.width > love.graphics.getWidth() then
    self.x = love.graphics.getWidth() - self.width
  end
end

function Paddle:draw(mode)
  love.graphics.rectangle(mode, self.x, self.y, self.width, self.height)
end

return Paddle
