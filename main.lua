flux = require('lib/flux')
class = require('lib/middleclass')
state = require('lib/stateswitcher')

require('modules/settings')
require('modules/assets')
require('modules/transition')
require('modules/window')
require('modules/utils')

function love.load()
  math.randomseed(os.time())
  assets.init()
  love.graphics.setFont(assets.fnt.font)

  if settings.prefs.sound then
    assets.bgm.music:play()
  end

  state.switch('menu')
end

function love.update(dt)
end

function love.draw(dt)
end

function love.keypressed(k)
  window.keypressed(k)
end

function love.quit()
  window.save()
end
