flux = require('lib/flux')
class = require('lib/middleclass')
state = require('lib/stateswitcher')
moonshine = require('lib/moonshine')

require('modules/settings')
require('modules/assets')
require('modules/palette')
require('modules/transition')
require('modules/window')
require('modules/utils')

st = {}
function st.update(dt) end
function st.draw() end
function st.gamepadpressed(joystick, button) end
function st.gamepadreleased(joystick, button) end
function st.gamepadaxis(joystick, axis, value) end
function st.keypressed(k) end
function st.keyreleased(k) end

function love.load()
  math.randomseed(os.time())
  love.graphics.setDefaultFilter('nearest', 'nearest')
  assets.init()
  shader = moonshine(moonshine.effects.crt).chain(moonshine.effects.scanlines).chain(moonshine.effects.chromasep)
  love.graphics.setFont(assets.fnt.font)
  state.switch('menu')
end

function love.update(dt)
  flux.update(dt)
  st.update(dt)
  transition.update(dt)
end

function love.draw()
  shader(function()
    -- st.draw()
    -- transition.draw()
  end)

  st.draw()
  transition.draw()
end

function love.gamepadpressed(joystick, button)
  st.gamepadpressed(joystick, button)
end

function love.gamepadreleased(joystick, button)
  if button == 'rightstick' then
    settings.global.debug = not settings.global.debug
  end

  st.gamepadreleased(joystick, button)
end

function love.gamepadaxis(joystick, axis, value)
  st.gamepadaxis(joystick, axis, value)
end

function love.keypressed(k)
  if k == 'escape' then
    love.event.push('quit')
  end

  st.keypressed(k)
  window.keypressed(k)
end

function love.keyreleased(k)
  st.keyreleased(k)
end

function love.focus(f)
  settings.global.pause = not f
end

function love.quit()
  window.save()
  settings.save()
end
