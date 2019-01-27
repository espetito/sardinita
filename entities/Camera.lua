local Camera = class('Camera')
local Cam = require('lib/Camera')

function Camera:initialize(w, h, bx, by, bw, bh)
  self.canvas = love.graphics.newCanvas(w, h)
  self.cam = Cam(0, 0, w, h)
  self.cam:setBounds(bx, by, bw, bh)
  -- self.cam:setDeadzone(bx+bw/2, by+bh/2, 0, 0)
  self.cam:setFollowStyle('NO_DEADZONE')
end

function Camera:update(dt, x, y)
  self.cam:update(dt)
  self.cam:follow(x, y)
end

function Camera:begin()
  love.graphics.setCanvas(self.canvas)
  self.cam:attach()
  love.graphics.setColor(1, 1, 1, 1)
end

function Camera:finish()
  self.cam:detach()
  self.cam:draw()
  love.graphics.setCanvas()
end

function Camera:draw(x, y)
  love.graphics.draw(self.canvas, x, y)
end

return Camera
