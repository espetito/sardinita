flux = require('lib/flux')
class = require('lib/middleclass')
state = require('lib/stateswitcher')

require('modules/settings')
require('modules/assets')
require('modules/palette')
require('modules/transition')
require('modules/window')
require('modules/utils')

st = {}
function st.update(dt) end
function st.draw() end

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
  st.update(dt)
  transition.update(dt)
end

function love.draw()
  st.draw()
  transition.draw()
end

function love.gamepadpressed(joystick, button)
  st.gamepadpressed(joystick, button)
end

function love.gamepadreleased(joystick, button)
  st.gamepadreleased(joystick, button)
end

function love.keypressed(k)
  window.keypressed(k)
end

function love.keyreleased(k)
  st.keyreleased(k)
end

function love.quit()
  window.save()
  settings.save()
end
