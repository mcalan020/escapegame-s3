seconde = 0
minute = 0
heure = 0

local tmp = 0
local timer = ""

function Timer(dt)
  tmp = tmp + 1
  if tmp > 60 then
    seconde = seconde + 1
    if seconde > 59 then
      minute = minute + 1
        if minute > 59 then
          heure = heure + 1
          minute = 0
        end
      seconde = 0
    end
    tmp = 0
  end
end

function DrawTimer()
  love.graphics.setColor(0, 0, 0)
  love.graphics.rectangle("fill", 0, 0, 110, 50)
  love.graphics.setColor(255, 255, 255)
  if seconde < 10 then
    timer = "0"..heure..":"..minute..":0"..seconde
  elseif minute < 10 then
    timer = "0"..heure..":0"..minute..":"..seconde
  elseif seconde < 10 and minute < 10 then
    timer = "0"..heure..":0"..minute..":0"..seconde
  end
  love.graphics.print(timer, 10, 10)
end