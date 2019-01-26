settings = {
  global = {
    debug = false,
    borderless = true,
    width = 1920,
    height = 1080,
    screenWidth = 0,
    screenHeight = 0,
    hFullscreenScale = 1,
    vFullscreenScale = 1,
    scaledFullscreen = false,
    hScaleBefore = 1,
    vScaleBefore = 1,
    volume = 1,
    pause = false
  },
  prefs = {
    hScale = 1,
    vScale = 1,
    fullscreen = true,
    sound = true
  }
}

function settings.load()
  if not love.filesystem.getInfo('prefs.txt') then love.filesystem.write('prefs.txt', table.show(settings.prefs, 'prefs')) end
  settingsChunk = love.filesystem.load('prefs.txt')
  settingsChunk()
end

function settings.save()
  love.filesystem.write('prefs.txt', table.show(settings.prefs, 'prefs'))
end
