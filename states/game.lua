-- game state
local bump = require 'lib/bump'
local sti = require "lib/sti"
local Player = require("entities/player")
local GameManager = require("entities/GameManager")

-- START LOAD --
-- Init game GameManager
local gameManager = GameManager:new()
-- Load map and collisions
map = sti("assets/maps/test/TestMap.lua",{ "bump" })
world = bump.newWorld(16)
map:bump_init(world)
-- Initialize players
local players={}
-- Get number of joysticks connected
local joysticks = love.joystick.getJoysticks()
local joysticksCount = love.joystick.getJoystickCount()
if joysticksCount > 0 then
  for i=1,joysticksCount do
    players[joysticks[i]:getID()] =Player:new()
  end
end

-- END LOAD --

function st.update(dt)
  if not settings.global.pause then
    gameManager:update(dt)
    if joysticksCount > 0 then
      for i=1,joysticksCount do
        local axisDir1, axisDir2, axisDir3 ,axisDir4, axisDir5 = joysticks[i]:getAxes()
        players[joysticks[i]:getID()]:move(axisDir1 * dt,axisDir2 * dt)
      end
    end
  end
end

function st.draw()
  map:draw()
  map:bump_draw(world)
  for key,player in pairs(players) do
    player:draw()
  end
  gameManager:draw()

  drawPause()

  if settings.global.debug then
    love.graphics.setColor(1,0,1,1)
    love.graphics.print("FPS:"..love.timer.getFPS(),0,0)
    love.graphics.print('Number of joysticks connected '..joysticksCount, 0, 50)
  end
end

function st.gamepadreleased(joystick, button)
  if button == 'start' then
    settings.global.pause = not settings.global.pause
  elseif settings.global.pause and button == 'back' then
    state.switch('menu')
    love.event.push('quit')
  end
end


function st.gamepadpressed(joystick, button) end
function st.gamepadaxis(joystick, axis, value)end
function st.keypressed(k) end
function st.keyreleased(k) end


function drawPause()
  if settings.global.pause then
    love.graphics.setColor(0, 0, 0, 0.75)
    love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    palette.setColor(8)
    love.graphics.print('GAME PAUSED', 128, 128)
    love.graphics.print('PRESS BACK TO QUIT', 128, 256)
  end
end
