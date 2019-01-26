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
    inTransition = false,
    exit = false
  }
}

function transition.start(to)
  function switch()
    state.switch(to)
  end

  flux.to(transition.colour, 0.5, { alpha = 255 }):after(transition.colour, 0.5, { alpha = 0 }):oncomplete(switch)
end

function transition.exit()
  function quit()
    love.event.push('quit')
  end

  flux.to(settings.global, 1, { volume = 0 })
  flux.to(transition.colour, 1, { red = 0, green = 0, blue = 0, alpha = 255 }):oncomplete(quit)
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
    if transition.timer.elapsed > transition.timer.time then
      transition.timer.elapsed = 0
      transition.timer.exit = false
      transition.timer.inTransition = false
      love.event.push('quit')
    end
  elseif timer.toGame then
    transition.timer.toGameTime = transition.timer.toGameTime + dt

    if transition.timer.toGameTime > transition.timer.time / 2 then
      settings.global.inGame = true
    end

    if transition.timer.toGameTime > transition.timer.time then
      transition.timer.toGameTime = 0
      transition.timer.toGame = false
      transition.timer.inTransition = false
      resetLevel()
      transition.timer.resetting = true
      resetTransition()
    end
  end
end
