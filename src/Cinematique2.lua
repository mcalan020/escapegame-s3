require("Timer")

local background = love.graphics.newImage("img/menu/menu_background.png")
local agent = love.graphics.newImage("img/Transition/Agent A56.png")
local credit = love.graphics.newImage("img/Transition/creds.png")

local quitter = {}
  quitter.button = nil
  quitter.x = 200
  quitter.y = 280
  quitter.longeur = 270
  quitter.largeur = 102
  quitter.hovered = false
  
  local msg1 = ""
  local msg2 = ""

function Cinematique2Load()
  quitter.button = love.graphics.newImage("img/menu/btn_quitter.png")
  quitter.button_hovered = love.graphics.newImage("img/menu/btn_quitter_hover.png")
  
  msg1 = "Félicitation ! Vous avez réussi à sortir de cette maison."
  msg2 = "Vous avez mis "..heure..":"..minute..":"..seconde..". Vous êtes reçus."
  msg3 = "Vous avez mis "..heure..":"..minute..":"..seconde..". Désolé ! Vous n'êtes pas retenu."
end

function Cinematique2Update(dt, mouseX, mouseY)
   --Si la souris survole le bouton quitter
    if mouseX > quitter.x and mouseY > quitter.y and mouseX < (quitter.x + quitter.longeur) and mouseY < (quitter.y+quitter.largeur) then
      quitter.hovered = true
    else
      quitter.hovered = false
    end
end

function Cinematique2Draw()
  love.graphics.setColor(255, 255, 255, 50)
  love.graphics.draw(background)
  love.graphics.setColor(255, 255, 255)
  
  love.graphics.draw(credit)
  if quitter.hovered == false then
    love.graphics.draw(quitter.button, quitter.x, quitter.y, 0, 1, 1, 0, 0)
  else
    love.graphics.draw(quitter.button_hovered, quitter.x, quitter.y, 0, 1, 1, 0, 0)
  end
  
  love.graphics.draw(agent, 600, 350, 0, 0.5, 0.5, agent:getWidth()/2, agent:getHeight()/2)
end

function Cinematique2DrawPrint()
  love.graphics.setColor(0, 0, 0)
  if heure < 1 then
    love.graphics.print(msg1, 20, 410)
    love.graphics.print(msg2, 20, 440)
  else
    love.graphics.print(msg1, 20, 410)
    love.graphics.print(msg3, 20, 440)
  end
  love.graphics.setColor(255, 255, 255)
end

function Cinematique2Mousepressed(x, y, button)
  if button == 1 then
    if x > quitter.x and y > quitter.y and x < (quitter.x + quitter.longeur) and y < (quitter.y+quitter.largeur) then
      love.event.quit()
    end
  end
end