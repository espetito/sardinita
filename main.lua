flux = require("lib/flux")
class = require("lib/middleclass")
state = require("lib/stateswitcher")

require("modules/resources")
require("modules/utils")
require("modules/window")
-- require("modules/transitions")

-- =============================================================
-- Variables

global = {
  debug = true,
  borderless = false,
  width = 960,
  height = 540,
  screenWidth = 0,
  screenHeight = 0,
  hFullscreenScale = 1,
  vFullscreenScale = 1,
  scaledFullscreen = false,
  hScaleBefore = 1,
  vScaleBefore = 1,
  volume = 1,
  inGame = false,
  inCredits = false,
  easing = "backout"
}

settings = {
  hScale = 1,
  vScale = 1,
  fullscreen = false,
  sound = true
}

-- =============================================================
-- Love2D main functions

function love.load()
  -- load settings
  if not love.filesystem.getInfo("data.bin") then love.filesystem.write("data.bin", table.show(settings, "settings")) end
  settingsChunk = love.filesystem.load("data.bin")
  settingsChunk()

  setupWindow()
  math.randomseed(os.time())

  -- load resources
  loadImg("menu", "menu.png")
  loadImg("credits", "credits.png")
  loadImg("game", "game.png")
  loadImg("btnPlayUp", "btn-play-up.png")
  loadImg("btnPlayDown", "btn-play-down.png")

  loadSfx("select_0", "select_0.ogg")
  loadSfx("select_1", "select_1.ogg")
  loadSfx("select_2", "select_2.ogg")
  loadSfx("select_3", "select_3.ogg")

  loadBgm("music", "music.mp3")
  loadSfx("yaay", "yaay.ogg")

  loadFont("font", "smart.ttf", 32)
  loadRes()

  love.graphics.setFont(res.fnt.font)
  if settings.sound then res.bgm.music:play() end
end

-- -------------------------------------------------------------

function love.update(dt)
  flux.update(dt)
end

-- -------------------------------------------------------------

function love.draw(dt)
end

-- -------------------------------------------------------------

function love.keypressed(k)
  if k == "=" then scaleUpWindow() return end
  if k == "-" then scaleDownWindow() return end
  if k == "return" and love.keyboard.isDown("lalt", "ralt") then
    toggleFullscreen()
    return
  end
end

-- -------------------------------------------------------------

function love.keyreleased(k)
end

-- -------------------------------------------------------------

function love.quit()
    storeWindowScale()
    love.filesystem.write("data.bin", table.show(settings, "settings"))
end
