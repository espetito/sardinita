local Player = class('Player')
local walt = require('../lib/walt')

function Player:initialize(id)
  self.type = "Player"
  self.id = id
  self.x = 0
  self.y = 0
  self.dx = 0
  self.dy = 0
  self.directionX = 0
  self.directionY = 1
  self.speed = 20
  self.life = 3
  self.doormats = {}
  self.canThrow = true
  self.isAiming = false
  self.animDirs = {}
  self:loadAnimations()
  world:add(self, self.x, self.y, 16,16)
end

function Player:draw()
  love.graphics.setColor(1, 1, 1, 100)
  --love.graphics.rectangle( "fill", self.x, self.y, 16, 16 )
  love.graphics.print(self.type.."-"..self.id.." has "..length(self.doormats).." doormats.",0,275)
  self.animDirs[self:getAnimIndex()]:draw(self.x,self.y)
  --if self.isAiming then
    local startX = self.x
    local startY = self.y
    local endX = self.x + self.directionX * 30
    local endY = self.y + self.directionY * 30
    love.graphics.line(startX,startY,endX,endY)
  --end
  if not self.canThrow then
    love.graphics.print(self.type.."-"..self.id.." can't shoot anymore ",0,300)
  end
end

function Player:updateAnim(dt)
  self.animDirs[self:getAnimIndex()]:update(dt)
end

function Player:move(x,y)
  self.dx = self.dx - self.dx * 0.05
  self.dy = self.dy - self.dy * 0.05
  self.dx = self.dx + (self.speed - self.dx) * x
  self.dy = self.dy + (self.speed - self.dy) * y
  local intendedX = self.x + self.dx
  local intendedY = self.y + self.dy
  local actualX, actualY, cols, len = world:move(self, intendedX,intendedY)
  self.x = actualX
  self.y = actualY

  for i=1,len do
    local collision = cols[i]
    if collision.other.type == 'Doormat' then
      self:pickup(collision.other)
    end
  end

end

function Player:pickup(doormat)
  doormat:pick()
  table.insert(self.doormats,doormat)
end

function Player:throw(x,y) -- This means direction of throw
  if length(self.doormats) > 0 then
    self.doormats[1]:throw(self.x,self.y,x,y)
    table.remove(self.doormats,1)
    self.canThrow = false
  end
end

function Player:updateDirection(dirX,dirY)
  if dirX ~= 0 then
    self.directionX = dirX
  end
  if dirY ~= 0 then
    self.directionY = dirY
  end
end

function Player:loadAnimations()
  local downSprites = love.graphics.newImage( 'assets/anims/oldMan/down.png' )
  local upSprites = love.graphics.newImage( 'assets/anims/oldMan/up.png' )
  local leftSprites = love.graphics.newImage( 'assets/anims/oldMan/left.png' )
  local rightSprites = love.graphics.newImage( 'assets/anims/oldMan/right.png' )

  local one = love.graphics.newQuad( 0, 0, 16, 16, 48, 16 )
  local two = love.graphics.newQuad( 16, 0, 16, 16, 48, 16 )
  local three = love.graphics.newQuad( 32, 0, 16, 16, 48, 16 )

  local animSpeed = 0.25
  local downAnim = walt.newAnimation( { one,two,three }, {animSpeed,animSpeed,animSpeed}, downSprites )
  downAnim:setLooping()
  local upAnim = walt.newAnimation( { one,two,three }, {animSpeed,animSpeed,animSpeed}, upSprites )
  upAnim:setLooping()
  local leftAnim = walt.newAnimation( { one,two,three }, {animSpeed,animSpeed,animSpeed}, leftSprites )
  leftAnim:setLooping()
  local rightAnim = walt.newAnimation( { one,two,three }, {animSpeed,animSpeed,animSpeed}, rightSprites )
  rightAnim:setLooping()

  self.animDirs = {rightAnim,rightAnim,downAnim,leftAnim,leftAnim,leftAnim,upAnim,rightAnim}
end

function Player:getAnimIndex()
  local angle = math.atan2(self.directionX, self.directionY)
  if angle < 0 then
    angle = angle + 2 * math.pi
  end
  return round(angle / math.pi * 4) + 1
end

return Player
