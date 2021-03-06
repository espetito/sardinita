-- game state
local bump = require 'lib/bump'
local sti = require "lib/sti"
local Player = require("entities/player")
local Doormat = require('entities/Doormat')
local GameManager = require("entities/GameManager")
local Camera = require('entities/Camera')

-- START LOAD --
-- resolution
local width = love.graphics.getWidth()
local height = love.graphics.getHeight()
local halfWidth = width/2
local halfHeight = height/2
-- Init game GameManager
local gameManager = GameManager:new()
-- Load map and collisions
local tileWidth = 16
map = sti("assets/maps/final2/FinalMap.lua",{ "bump" })
world = bump.newWorld(tileWidth)
map:bump_init(world)
-- Initialize Spawns
local playerSpawnsLayer = map.layers["Spawns"]
local playerSpawns={}
for k, object in pairs(playerSpawnsLayer["objects"]) do
  if object.properties.type == "Spawn" then
    table.insert(playerSpawns,object)
	end
end
-- Initialize players
local players={}
local cams={}
local bounds={
  {
    { x=0, y=0, w=width, h=height }
  },
  {
    { x=0,         y=0, w=halfWidth, h=height },
    { x=halfWidth, y=0, w=halfWidth, h=height }
  },
  {
    { x=0,         y=0,          w=halfWidth, h=halfHeight },
    { x=halfWidth, y=0,          w=halfWidth, h=halfHeight },
    { x=0,         y=halfHeight, w=halfWidth, h=halfHeight }
  },
  {
    { x=0,         y=0,          w=halfWidth, h=halfHeight },
    { x=halfWidth, y=0,          w=halfWidth, h=halfHeight },
    { x=0,         y=halfHeight, w=halfWidth, h=halfHeight },
    { x=halfWidth, y=halfHeight, w=halfWidth, h=halfHeight }
  }
}

-- Get number of joysticks connected
local joysticks = love.joystick.getJoysticks()
local joydebug = ''
local joysticksCount = love.joystick.getJoystickCount()
if joysticksCount > 0 then
  -- create players
  for i=1,joysticksCount do
    local playerSpawn = playerSpawns[i]
    table.insert(players, Player:new(i,playerSpawn.x,playerSpawn.y))
  end

  -- create cameras
  for i=1,#players do
    local cam = Camera:new(
      bounds[#players][i].w,
      bounds[#players][i].h,
      0, 0,
      map.layers[1].width*tileWidth,
      map.layers[1].height*tileWidth
    )
    table.insert(cams, cam)
  end
else
  state.switch('menu')
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

    for i=1,#players do
      local axisDir1, axisDir2, axisDir3 ,axisDir4, axisDir5 = joysticks[i]:getAxes()
      players[i]:updateDirection(axisDir4,axisDir5)
      players[i]:updateAnim(dt)
      players[i]:move(axisDir1 * dt, axisDir2 * dt)
      if joysticks[i]:getGamepadAxis("triggerright") ~= 0 then
        players[i]:throw(axisDir4,axisDir5)
      end

      cams[i]:update(dt, players[i].x, players[i].y)
    end
    -- Update doormats
    for _,doormat in pairs(doormats) do
      doormat:update(dt)
    end
  end
end

function st.draw()
  for i=1,#cams do
    cams[i]:begin()
      love.graphics.setColor(1,1,1,1)
      map:draw()
      for _,player in pairs(players) do
        player:draw()
      end
      for _,doormat in pairs(doormats) do
        doormat:draw()
      end
    cams[i]:finish()
    cams[i]:draw(bounds[#players][i].x, bounds[#players][i].y)
  end

  love.graphics.setColor(0, 0, 0, 1)
  love.graphics.line(halfWidth, 0, halfWidth, height)
  if #players > 2 then
    love.graphics.line(0, halfHeight, width, halfHeight)
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
  elseif button == 'back' then
    state.switch('menu')
  end

  for i=1,#joysticks do
    if joysticks[i]:getName() == joystick:getName() then
      joydebug = 'joy: ' .. i
    end
  end
end

function st.gamepadpressed(joystick, button) end
function st.gamepadaxis(joystick, axis, value) end
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
