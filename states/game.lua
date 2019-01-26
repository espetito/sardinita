-- game state
local bump = require 'lib/bump'
local sti = require "lib/sti"
local Player = require("entities/player")
local Doormat = require('entities/Doormat')
local GameManager = require("entities/GameManager")

-- START LOAD --
-- Init game GameManager
local gameManager = GameManager:new()
-- Load map and collisions
map = sti("assets/maps/final/FinalMap.lua",{ "bump" })
world = bump.newWorld(16)
map:bump_init(world)
-- Initialize players
local players= {}
-- Get number of joysticks connected
local joysticks = love.joystick.getJoysticks()
local joysticksCount = love.joystick.getJoystickCount()
if joysticksCount > 0 then
  for i=1,joysticksCount do
    players[i] =Player:new(i)
  end
end

-- Initialize doormats
local doormats = {}
for i=1,1 do
  doormats[i] =Doormat:new()
end

-- END LOAD --

function st.update(dt)
  if not settings.global.pause then
    gameManager:update(dt)
    -- Update players
    for i=1,joysticksCount do
      local axisDir1, axisDir2, axisDir3 ,axisDir4, axisDir5 = joysticks[i]:getAxes()
      players[i]:updateDirection(axisDir4,axisDir5)
      players[i]:updateAnim(dt)
      players[i]:move(axisDir1 * dt,axisDir2 * dt)
      if joysticks[i]:getGamepadAxis("triggerright") ~= 0 then
        players[i]:throw(axisDir4,axisDir5)
      end
    end
    -- Update doormats
    for _,doormat in pairs(doormats) do
      doormat:update(dt)
    end
  end
end

function st.draw()
  map:draw()
  map:bump_draw(world)
  for _,player in pairs(players) do
    player:draw()
  end
  for _,doormat in pairs(doormats) do
    doormat:draw()
  end
  gameManager:draw()
  drawPause()
  if settings.global.debug then
    love.graphics.print("FPS:"..love.timer.getFPS(),0,0)
    love.graphics.print('Number of joysticks connected '..joysticksCount, 0, 50)
    local axisDir1, axisDir2, axisDir3 ,axisDir4, axisDir5 = joysticks[1]:getAxes()
    love.graphics.print('('..axisDir4..','..axisDir5..')',0,500)
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
