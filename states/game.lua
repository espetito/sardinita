-- game state
local bump = require 'lib/bump'
local sti = require "lib/sti"
local Player = require("Entities/player")

-- Load map and collisions
map = sti("assets/maps/test/TestMap.lua",{ "bump" })
world = bump.newWorld(16)
map:bump_init(world)

local players={}

-- LOAD --
-- Get number of joysticks connected
local joysticks = love.joystick.getJoysticks()
local joysticksCount = love.joystick.getJoystickCount()
if joysticksCount > 0 then
  for i=1,joysticksCount do
    players[joysticks[i]:getID()] =Player:new()
  end
end

function st.update(dt)
  if joysticksCount > 0 then
    for i=1,joysticksCount do
      local axisDir1, axisDir2, axisDir3 ,axisDir4, axisDir5 = joysticks[i]:getAxes()
      players[joysticks[i]:getID()]:move(axisDir1 * dt,axisDir2 * dt)
    end
  end

end

function st.draw()
  map:draw()
  map:bump_draw(world)
  for key,player in pairs(players) do
    player:draw()
  end
  love.graphics.print('hello from game', 0, 0)
  love.graphics.print('Number of joysticks connected '..joysticksCount, 100, 100)
end



function st.gamepadpressed(joystick, button) end
function st.gamepadreleased(joystick, button) end
function st.gamepadaxis(joystick, axis, value)end
function st.keypressed(k) end
function st.keyreleased(k) end
