-- menu state

local bg = {
  num = 25,
  frames = 180,
  theta = 0
}

local title = {}
title.text = 'HOLY DOORMATS !'
title.scale = 1.0
title.scaleDown = nil
title.scaleUp = function()
  flux.to(title, 1, { scale = 1.1 }):oncomplete(title.scaleDown)
end
title.scaleDown = function()
  flux.to(title, 1, { scale = 1.0 }):oncomplete(title.scaleUp)
end
title.scaleUp()

local selection = 0
local t = 0
local buttons = {}
buttons[0] = 'PLAY'
buttons[1] = 'QUIT'

palette.setBackgroundColor(1)

if settings.prefs.sound then
  assets.bgm.menu:play()
end

-- -----------------------------------------

function st.update(dt)
  t = t + dt*4
end

function st.draw()
  drawBG()
  local col = 9
  local w = assets.fnt.font:getWidth('A')
  for c = 1, #title.text do
    palette.setColor(col)
    love.graphics.print(title.text:sub(c,c), 128+w*c, 128, 0, title.scale)
    col = col + 1
    if col > 16 then col = 9 end
  end
  drawButton(0, 128, 500)
  drawButton(1, 128, 700)
end

function st.gamepadreleased(joystick, button)
  if button == 'dpdown' then
    selection = (selection + 1) % 2
  elseif button == 'dpup' then
    selection = (selection - 1) % 2
  elseif button == 'a' then
    if selection == 0 then
      state.switch('game')
    elseif selection == 1 then
      transition.exit()
    end
  end
end

function st.gamepadpressed(joystick, button) end
function st.gamepadaxis(joystick, axis, value) end
function st.keypressed(k) end
function st.keyreleased(k) end

function drawButton(i, x, y)
  if selection == i then
    local w = assets.fnt.font:getWidth('A')
    for c = 0, #buttons[i] do
      for col = 16, 9, -1 do
        local yy = y + math.cos(t+c*4-col*2)*20
        palette.setColor(col)
        love.graphics.print(buttons[i]:sub(c,c), x+c*w*1.5, yy)
      end
    end
  else
    palette.setColor(8)
    love.graphics.print(buttons[i], x, y)
  end
end

function drawBG()
  local hUnit = love.graphics.getWidth() / bg.num
  local vUnit = love.graphics.getHeight() / bg.num
  for y=0,bg.num do
    for x=0,bg.num do
      local distance = math.sqrt(math.pow((love.graphics.getWidth() / 2) - (x * hUnit), 2) + math.pow((love.graphics.getHeight() / 2) - (y * vUnit), 2))
      local offset = map(distance, 0, math.sqrt(math.pow(love.graphics.getWidth() / 2, 2) + math.pow(love.graphics.getHeight() / 2, 2)), 0, math.pi * 2)
      local sz = map(math.sin(bg.theta + offset), -1, 1, hUnit * 0.2, vUnit * 0.1)
      local angle = math.atan2(y * vUnit - love.graphics.getHeight() / 2, x * hUnit - love.graphics.getWidth() / 2)

      love.graphics.push()
      love.graphics.translate(x * hUnit, y * vUnit)
      love.graphics.rotate(angle)
      love.graphics.ellipse("fill", map(math.sin(bg.theta + offset), -1, 1, 0, 50), 0, sz / 2, sz / 2)
      love.graphics.pop()
    end
  end

  bg.theta = bg.theta - (math.pi * 2 / bg.frames)
end
