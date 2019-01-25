local class = require('../lib/middleclass')
local Player = class('Player')

function Player:initialize()
  self.x = 0
  self.y = 0
  self.dx = 0
  self.dy = 0
  self.speed = 40
  self.weight = 10
end

function Player:draw()
  love.graphics.setColor(0, 1, 0, 100)
  love.graphics.rectangle( "fill", self.x, self.y, 32, 32 )
end

function Player:move(x,y)
  self.dx = self.dx - self.dx * 0.05
  self.dy = self.dy - self.dy * 0.05
  self.dx = self.dx + (self.speed - self.dx) * x
  self.dy = self.dy + (self.speed - self.dy) * y
  self.x = self.x + self.dx
  self.y = self.y + self.dy
end

return Player
