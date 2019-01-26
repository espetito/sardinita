local class = require('../lib/middleclass')
local Player = class('Player')

function Player:initialize()
  self.x = 0
  self.y = 0
  self.dx = 0
  self.dy = 0
  self.speed = 20
  self.collision = {name="A"}
  world:add(self.collision, self.x, self.y, 16,16)
end

function Player:draw()
  love.graphics.setColor(0, 1, 0, 100)
  love.graphics.rectangle( "fill", self.x, self.y, 16, 16 )
end

function Player:move(x,y)
  self.dx = self.dx - self.dx * 0.05
  self.dy = self.dy - self.dy * 0.05
  self.dx = self.dx + (self.speed - self.dx) * x
  self.dy = self.dy + (self.speed - self.dy) * y
  local intendedX = self.x + self.dx
  local intendedY = self.y + self.dy
  local actualX, actualY, cols, len = world:move(self.collision, intendedX,intendedY)
  self.x = actualX
  self.y = actualY
end

return Player
