assets = {
  dir = 'assets/',
  imgQueue = {},
  bgmQueue = {},
  sfxQueue = {},
  fntQueue = {},
  img = {},
  bgm = {},
  sfx = {},
  fnt = {}
}

function assets.init()
  assets.loadBgm('menu', 'menu.ogg')
  assets.loadFont('font', 'smart.ttf', 128)
  assets.load()
end

function assets.loadFont(name, src, size)
  assets.fntQueue[name] = { src, size }
end

function assets.loadImg(name, src)
  assets.imgQueue[name] = src
end

function assets.loadBgm(name, src)
  assets.bgmQueue[name] = src
end

function assets.loadSfx(name, src)
  assets.sfxQueue[name] = src
end

function assets.load(threaded)
  for name, pair in pairs(assets.fntQueue) do
    assets.fnt[name] = love.graphics.newFont(assets.dir .. 'fnt/' .. pair[1], pair[2])
    assets.fntQueue[name] = nil
  end

  for name, src in pairs(assets.imgQueue) do
    assets.img[name] = love.graphics.newImage(assets.dir .. 'img/' .. src)
    assets.imgQueue[name] = nil
  end

  for name, src in pairs(assets.bgmQueue) do
    assets.bgm[name] = love.audio.newSource(assets.dir .. 'bgm/' .. src, 'stream')
    assets.bgm[name]:setLooping(true)
    assets.bgmQueue[name] = nil
  end

  for name, src in pairs(assets.sfxQueue) do
    assets.sfx[name] = love.audio.newSource(assets.dir .. 'sfx/' .. src, 'static')
    assets.sfx[name]:setLooping(false)
    assets.sfxQueue[name] = nil
  end
end
