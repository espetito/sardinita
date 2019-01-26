window = {}

function window.setup()
  love.window.setMode(0, 0, { fullscreen = false })
  settings.global.screenWidth = love.graphics.getWidth()
  settings.global.screenHeight = love.graphics.getHeight()

  if settings.global.scaledFullscreen then
    while settings.global.width * (settings.global.hFullscreenScale + 1) < settings.global.screenWidth and settings.global.height * (settings.global.vFullscreenScale + 1) < settings.global.screenHeight do
      settings.global.hFullscreenScale = settings.global.hFullscreenScale + 1
      settings.global.vFullscreenScale = settings.global.vFullscreenScale + 1
    end
  else
    settings.global.hFullscreenScale = settings.global.screenWidth / settings.global.width
    settings.global.vFullscreenScale = settings.global.screenHeight / settings.global.height
  end

  love.graphics.setBackgroundColor(88, 88, 88)
  if settings.prefs.fullscreen then
    settings.global.hScaleBefore = settings.prefs.hScale
    settings.global.vScaleBefore = settings.prefs.vScale
    settings.prefs.hScale = settings.global.hFullscreenScale
    settings.prefs.vScale = settings.global.vFullscreenScale
  end

  love.window.setMode(settings.global.width * settings.prefs.hScale, settings.global.height * settings.prefs.vScale, { fullscreen = settings.prefs.fullscreen, borderless = settings.global.borderless })
  love.graphics.setDefaultFilter("nearest", "nearest", 0)
end

function window.scaleUp()
  if not settings.prefs.fullscreen and settings.prefs.hScale < 5 and settings.prefs.vScale < 5 then
    settings.prefs.hScale = settings.prefs.hScale + 1
    settings.prefs.vScale = settings.prefs.vScale + 1
    love.window.setMode(settings.global.width * settings.prefs.hScale, settings.global.height * settings.prefs.vScale, { fullscreen = settings.prefs.fullscreen, borderless = settings.global.borderless })
  end
end

function window.scaleDown()
  if not settings.prefs.fullscreen and settings.prefs.hScale > 1 and settings.prefs.vScale > 1 then
    settings.prefs.hScale = settings.prefs.hScale - 1
    settings.prefs.vScale = settings.prefs.vScale - 1
    love.window.setMode(settings.global.width * settings.prefs.hScale, settings.global.height * settings.prefs.vScale, { fullscreen = settings.prefs.fullscreen, borderless = settings.global.borderless })
  end
end

function window.toggleFullscreen()
  settings.prefs.fullscreen = not settings.prefs.fullscreen
  if settings.prefs.fullscreen then
    settings.global.hScaleBefore = settings.prefs.hScale
    settings.global.vScaleBefore = settings.prefs.vScale
    settings.prefs.hScale = settings.global.hFullscreenScale
    settings.prefs.vScale = settings.global.vFullscreenScale
  else
    settings.prefs.hScale = settings.global.hScaleBefore
    settings.prefs.vScale = settings.global.vScaleBefore
  end

  love.window.setMode(settings.global.width * settings.prefs.hScale, settings.global.height * settings.prefs.vScale, { fullscreen = settings.prefs.fullscreen, borderless = settings.global.borderless })
end

function window.keypressed(k)
  if k == '=' then window.scaleUpWindow() return end
  if k == '-' then window.scaleDownWindow() return end
  if k == 'return' and love.keyboard.isDown('lalt', 'ralt') then
    window.toggleFullscreen()
    return
  end
end

function window.save()
  if settings.prefs.fullscreen then
    settings.prefs.hScale = settings.global.hScaleBefore
    settings.prefs.vScale = settings.global.vScaleBefore
  end
end
