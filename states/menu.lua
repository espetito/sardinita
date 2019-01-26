-- menu state

local title = 'SPACE DOORMATS'
local selection = 0
local buttons = {
  'PLAY',
  'QUIT'
}

local justMoved = false

function st.update(dt)
end

function st.draw()
  -- love.graphics.print(title, love.window.getMode, y, r, sx, sy, ox, oy, kx, ky)
end

function st.gamepadreleased(joystick, button)
  if button == 'dpdown' then
    selection = (selection + 1) % 2
  elseif button == 'dpup' then
    selection = (selection - 1) % 2
  end
end