require("srcEnigme1/Enigme1")

local agent = love.graphics.newImage("img/Transition/Agent A56.png")

local msg1 = ""
local msg2 = ""
local msg3 = ""
local font = love.graphics.newFont("font/ariblk.ttf", 20)

local bouton = {}
bouton.img = love.graphics.newImage("img/Transition/btn_suivant.png")
bouton.x = 700
bouton.y = 470
bouton.w = bouton.img:getWidth()/2
bouton.h = bouton.img:getHeight()/2

local compt = 0

function Cinematique1Load()
  love.graphics.setFont(font)
  
  main_image = love.graphics.newImage("img/imgEnigme1/chambre.png")
  cercueil= love.graphics.newImage("img/imgEnigme1/cercueil.png")
  table_de_chevet = love.graphics.newImage("img/imgEnigme1/table_de_chevet.png")
  porte = love.graphics.newImage("img/imgEnigme1/porte.png")
  bibliotheque = love.graphics.newImage("img/imgEnigme1/bibliotheque.png")
  carte_angleterre = love.graphics.newImage("img/imgEnigme1/carte_angleterre.png")
  
  msg1 = "Bonjour ! Je suis l'agent A56."
  msg2 = " C'est moi qui m'occupe de la dernière épreuve du concours."
  msg3 = " C'est ici que tu vas devoir faire tes preuves... "
end
 local bx = bouton.x
  local by = bouton.y
function Cinematique1Update(dt, mouseX, mouseY)
 
  if mouseX > bouton.x - bouton.w/2 and mouseX < bouton.x + bouton.w/2 and mouseY > bouton.h/2 and mouseY < bouton.y + bouton.h/2 then
    if bouton.x < 702 and bouton.y > 468 then
      bouton.x = bouton.x + 2
      bouton.y = bouton.y - 2
    end
  else
    bouton.x = bx
    bouton.y = by
  end
end

function Cinematique1Draw()
  love.graphics.setColor(255, 255, 255, 25)
  love.graphics.draw(main_image)
  love.graphics.setColor(255, 255, 255, 100)
  love.graphics.draw(cercueil, 250, 78)
  love.graphics.draw(table_de_chevet, 380, 230)
  love.graphics.draw(porte, 100, 71)
  love.graphics.draw(bibliotheque, 450, 130)
  love.graphics.draw(carte_angleterre, 370, 30)
  
  love.graphics.setColor(255, 255, 255)
  
  love.graphics.draw(agent, 600, 350, 0, 0.5, 0.5, agent:getWidth()/2, agent:getHeight()/2)
end

function Cinematique1DrawPrint()
  love.graphics.setColor(0, 0, 0)
  love.graphics.print(msg1, 20, 410)
  love.graphics.print(msg2, 20, 440)
  love.graphics.setColor(255, 255, 255)
  
  love.graphics.draw(bouton.img, bouton.x, bouton.y, 0, 1, 1, bouton.w/2, bouton.h/2)
end

function Cinematique1Mousepressed(x, y, button)
  if button == 1 then
    if x > bouton.x - bouton.w and x < bouton.x + bouton.w and y > bouton.y - bouton.h and bouton. y < bouton.y + bouton.h then
      if compt == 0 then
        msg1 = "Durant cette épreuve, tu devras réaliser 5 énigmes "
        msg2 = "réparties sur 3 pièces dans la maison où nous sommes."
      elseif compt == 1 then
        msg1 = "C'est un jeu clickable auquel"
        msg2 = "Il faut intéragir avec l'environnement pour continuer"
        msg3 = "Bonne chance Agent "
      elseif compt == 2 then
        etatEnigme = "Enigme 1"
        Enigme1Load()
      end
      compt = compt + 1
    end
  end
end