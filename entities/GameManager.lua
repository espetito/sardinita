local GameManager = class('GameManager')

function GameManager:initialize()
  self.scores = {}
  self.gameTime = 0
end

function GameManager:update(dt)
  self.gameTime = self.gameTime + dt
end

function GameManager:draw()
  love.graphics.setColor(0, 0, 1, 100)
  love.graphics.print('Time:'..self:formatTime(), 0, 100)
end

function GameManager:formatTime()
  local seconds = math.floor(self.gameTime)
  local mins = math.floor(seconds / 60)
  seconds = seconds - mins * 60
  return mins..':'..seconds
end

return GameManager
