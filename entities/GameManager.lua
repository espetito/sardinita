local GameManager = class('GameManager')
local Doormat = require('entities/Doormat')

function GameManager:initialize()
  self.scores = {}
  self.time = 0
end

function GameManager:update(dt)
  self.time = self.time + dt
 --[[
  self.doormatsTimer = self.doormatsTimer + dt
   if self.doormatsTimer >= 5 then
       self:spawnDoormat()
       self.doormatsTimer = 0
   end]]--
end

function GameManager:draw()
  love.graphics.setColor(0, 0, 1, 100)
  local mins,secs = self:getTime()
  love.graphics.print('Time: '..mins..':'..secs, 0, 100)
end

function GameManager:getTime()
  local secs = math.floor(self.time)
  local mins = math.floor(secs / 60)
  secs = secs - mins * 60
  return mins,secs
end

function GameManager:spawnDoormat()
  local doormatIndex = length(self.doormats)
  self.doormats[doormatIndex] = Doormat:new()
  self.doormats[doormatIndex].x = math.random(0,500)
  self.doormats[doormatIndex].y = math.random(0,500)
end

return GameManager
