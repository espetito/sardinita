palette = {
  {r = 0, g = 0, b = 0},
  {r = 29, g = 43, b = 83},
  {r = 126, g = 37, b = 83},
  {r = 0, g = 136, b = 81},
  {r = 171, g = 82, b = 54},
  {r = 95, g = 87, b = 79},
  {r = 194, g = 195, b = 199},
  {r = 255, g = 241, b = 232},
  {r = 255, g = 0, b = 77},
  {r = 255, g = 163, b = 0},
  {r = 255, g = 236, b = 39},
  {r = 0, g = 228, b = 54},
  {r = 41, g = 173, b = 255},
  {r = 131, g = 118, b = 156},
  {r = 255, g = 119, b = 168},
  {r = 255, g = 204, b = 170}
}

function palette.setBackgroundColor(n)
  love.graphics.setBackgroundColor(palette[n].r, palette[n].g, palette[n].b, 255)
end

function palette.setColor(n)
  love.graphics.setColor(palette[n].r, palette[n].g, palette[n].b, 255)
end
