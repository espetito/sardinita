settings = {
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
    volume = 1
  },
  prefs = {
    hScale = 1,
    vScale = 1,
    fullscreen = false,
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
