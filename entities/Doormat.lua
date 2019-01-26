local Doormat = class('Doormat')

function Doormat:initialize(id,x,y)
  self.id = id
  self.type = 'Doormat'
  self.x = math.random(0,500)
  self.y = math.random(0,500)
  self.directionX = 0
  self.directionY = 0
  self.speed = 5
  self.size = 8
  self.damage = 1
  self.isPicked = false
  self.isThrow = false
  world:add(self, self.x, self.y, self.size,self.size)
end

function Doormat:update(dt)
  if self.isThrown then
    self:move()
  end
end

function Doormat:draw()
  if not self.isPicked then
    love.graphics.setColor(1, 0, 0, 100)
    love.graphics.rectangle( "fill", self.x, self.y, self.size, self.size )
  end
end

function Doormat:pick()
  self.isPicked = true
  world:remove(self)
end

function Doormat:throw(x,y,dirX,dirY)
  self.isPicked = false
  self.isThrown = true
  self.x = x + dirX * self.speed + 20
  self.y = y + dirY * self.speed + 20
  self.directionX = dirX
  self.directionY = dirY
  world:add(self, self.x, self.y, self.size,self.size)
end

function Doormat:move() -- As projectile
  local intendedX, intendedY = self.x + self.directionX * self.speed, self.y + self.directionY * self.speed
  local actualX, actualY, cols, len = world:move(self, intendedX,intendedY)
  self.x = actualX
  self.y = actualY
end

return Doormat
