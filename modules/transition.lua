transition = {
  colour = {
    red = 32,
    green = 32,
    blue = 32,
    alpha = 0
  },
  timer = {
    time = 1.0,
    elapsed = 0.0,
    to = nil,
    exit = false
  }
}

function transition.start(to)
  transition.timer.to = to
  flux.to(transition.colour, 0.5, { alpha = 255 }):after(transition.colour, 0.5, { alpha = 0 })
end

function transition.exit()
  function _quit()
    love.event.push('quit')
  end

  flux.to(settings.global, 1, { volume = 0 })
  flux.to(transition.colour, 1, { red = 0, green = 0, blue = 0, alpha = 255 }):oncomplete(_quit)
end

function transition.draw()
  love.graphics.setColor(transition.colour.red, transition.colour.green, transition.colour.blue, transition.colour.alpha)
  love.graphics.rectangle('fill', 0, 0, settings.global.width * settings.prefs.hScale, settings.global.height * settings.prefs.vScale)
  love.graphics.setColor(255, 255, 255, 255)
end

function transition.update(dt)
  if transition.timer.exit then
    assets.bgm.music:setVolume(settings.global.volume)
    transition.timer.elapsed = transition.timer.elapsed + dt
  elseif transition.timer.to then
    transition.timer.elapsed = transition.timer.elapsed + dt
    if transition.timer.elapsed > transition.timer.time / 2 then
      state.switch(transition.to)
      transition.to = nil
    end
  end
end
