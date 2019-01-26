-- game state
local bump = require 'lib/bump'
local sti = require "lib/sti"
local Player = require("Entities/player")

local players={}

function love.load()
  --map = sti("maps/TestMap.lua",{ "bump" })
  --world = bump.newWorld(64)
  --map:bump_init(world)

  -- Get player spawn
  --local playerSpawn
  --  for k, object in pairs(map.objects) do
  --      if object.name == "Player" then
  --          playerSpawn = object
  --          break
  --      end
  --  end
  players.p1 =Player:new()
end

function love.update(dt)

end

function love.draw()
  love.graphics.print('hello from game', 0, 0)
  --map:draw()
  for player in players do
    player.draw()
  end
end


function spawnPlayer()

  -- Add player to bump world
  --world:add(players.p1.collision, playerSpawn.y, 0, 32,32)

end
