InventeryManager = require("InventeryManager")
ItemManager = require("ItemManager")
ParticleManager = require("ParticleManager")

require("Timer")
require("Cinematique1")
require("Cinematique2")

require("srcEnigme1/Enigme1")
require("srcEnigme2/Enigme2")
require("srcEnigme3/Enigme3")
require("srcEnigme4/Enigme4")
require("srcEnigme5/Enigme5")

etatEnigme = ""
local fondtxt = love.graphics.newImage("img/Fond_txt.png")

local papier1 = love.graphics.newImage("img/Enigme5/papier_378.png")
local drawPapier1 = false;
local papier2 = love.graphics.newImage("img/Enigme5/papier_151.png")
local drawPapier2 = false;
local papier3 = love.graphics.newImage("img/Enigme5/papier_717.png")
local drawPapier3 = false;

local retour = {}
retour.sprite = love.graphics.newImage("img/retour_180_80.png")
retour.w = 180
retour.h = 80
retour.x = 60
retour.y = 370

--Réinitialisation du jeu
function jeuReset()
  InventeryManager.EmptyInventery()
  ItemManager.Reset()
end

function jeuLoad()
  ItemManager.CreateItem("", "img/Enigme5/papier_boulette.png", 0, 0, "")
  etatEnigme = "Cinematique 1"
  --Enigme4Load()
  Cinematique1Load()
end

function jeuUpdate(dt, mouseX, mouseY)
  ParticleManager.Update(dt)
  ItemManager.Update(dt, mouseX, mouseY)
  Timer(dt)
  if etatEnigme == "Cinematique 1" then
    Cinematique1Update(dt, mouseX, mouseY)
  end
  if etatEnigme == "Cinematique 2" then
    Cinematique2Update(dt, mouseX, mouseY)
  end
  if etatEnigme == "Enigme 1"  and drawPapier1 == false and drawPapier2 == false and drawPapier3 == false then
    Enigme1Update(dt, mouseX, mouseY)
  end
  if etatEnigme == "Enigme 2"  and drawPapier1 == false and drawPapier2 == false and drawPapier3 == false then
    Enigme2Update(dt, mouseX, mouseY)
  end
  if etatEnigme == "Enigme 3"  and drawPapier1 == false and drawPapier2 == false and drawPapier3 == false then
    Enigme3Update(dt, mouseX, mouseY)
  end
  if etatEnigme == "Enigme 4"  and drawPapier1 == false and drawPapier2 == false and drawPapier3 == false then
    Enigme4Update(dt, mouseX, mouseY)
  end
  if etatEnigme == "Enigme 5"  and drawPapier1 == false and drawPapier2 == false and drawPapier3 == false then
    Enigme5Update(dt, mouseX, mouseY)
  end
  
  for nItem = #InventeryManager.lstItem, 1, -1 do
    local item = InventeryManager.lstItem[nItem]
    if item.select == true and item.name == "boulette1" then
      drawPapier1 = true
    elseif item.select == true and item.name == "boulette2" then
      drawPapier2 = true
    elseif item.select == true and item.name == "boulette3" then
      drawPapier3 = true
    end
  end
end

function jeuDraw()
  if etatEnigme == "Cinematique 1" then
    Cinematique1Draw()
  elseif etatEnigme == "Cinematique 2" then
    Cinematique2Draw()
  elseif etatEnigme == "Enigme 1" then
    Enigme1Draw()
  elseif etatEnigme == "Enigme 2" then
    Enigme2Draw()
  elseif etatEnigme == "Enigme 3" then
    Enigme3Draw()
  elseif etatEnigme == "Enigme 4" then
    Enigme4Draw()
  elseif etatEnigme == "Enigme 5" then
    Enigme5Draw()
  end
  if etatEnigme ~= "Cinematique 1" and etatEnigme ~= "Cinematique 2" then
    InventeryManager.Draw()
    DrawTimer()
  end
  
  --ItemManager.Draw()
  ParticleManager.Draw()
  love.graphics.draw(fondtxt, 0, 400)
  
  if etatEnigme == "Cinematique 1" then
    Cinematique1DrawPrint()
  elseif etatEnigme == "Cinematique 2" then
    Cinematique2DrawPrint()
  elseif etatEnigme == "Enigme 1" then
    Enigme1DrawPrint()
  elseif etatEnigme == "Enigme 2" then
    Enigme2DrawPrint()
  elseif etatEnigme == "Enigme 3" then
    Enigme3DrawPrint()
  elseif etatEnigme == "Enigme 4" then
    Enigme4DrawPrint()
  elseif etatEnigme == "Enigme 5" then
    Enigme5DrawPrint()
  end
  
  for nItem = #ItemManager.lstItem, 1, -1 do
    local item = ItemManager.lstItem[nItem]
    if item.inInventery == true then
      ItemManager.DrawOneItem(item.name)
    end
  end  
  
  if drawPapier1 then
    love.graphics.draw(papier1, 375, 230, 0, 0.5, .5, papier1:getWidth()/2, papier1:getHeight()/2)
    love.graphics.draw(retour.sprite, retour.x, retour.y, 0, 0.5, 0.5, retour.w/2, retour.h/2)
  elseif drawPapier2 then
    love.graphics.draw(papier2, 375, 230, 0, 0.5, .5, papier2:getWidth()/2, papier2:getHeight()/2)
    love.graphics.draw(retour.sprite, retour.x, retour.y, 0, 0.5, 0.5, retour.w/2, retour.h/2)
  elseif drawPapier3 then
    love.graphics.draw(papier3, 375, 230, 0, 0.5, .5, papier3:getWidth()/2, papier3:getHeight()/2)
    love.graphics.draw(retour.sprite, retour.x, retour.y, 0, 0.5, 0.5, retour.w/2, retour.h/2)
  end
end

function jeuMousepressed(x, y, button)
   ItemManager.Mousepressed(x,y,button)
  if etatEnigme == "Cinematique 1" then
    Cinematique1Mousepressed(x,y,button)
  elseif etatEnigme == "Cinematique 2" then
    Cinematique2Mousepressed(x,y,button)
  elseif etatEnigme == "Enigme 1" and drawPapier1 == false and drawPapier2 == false and drawPapier3 == false then
    Enigme1MousePressed(x, y, button)
  elseif etatEnigme == "Enigme 2" and drawPapier1 == false and drawPapier2 == false and drawPapier3 == false then
    Enigme2MousePressed(x, y, button)
  elseif etatEnigme == "Enigme 3" and drawPapier1 == false and drawPapier2 == false and drawPapier3 == false then
    Enigme3MousePressed(x, y, button)
  elseif etatEnigme == "Enigme 4" and drawPapier1 == false and drawPapier2 == false and drawPapier3 == false then
    Enigme4MousePressed(x, y, button)
  elseif etatEnigme == "Enigme 5" and drawPapier1 == false and drawPapier2 == false and drawPapier3 == false then
    Enigme5MousePressed(x, y, button)
  end
  if button == 1 then
    for nItem = #InventeryManager.lstItem, 1, -1 do
      local item = InventeryManager.lstItem[nItem]
      
      if x > retour.x - retour.w/2 and x < retour.x + retour.w/2 and y > retour.y - retour.h/2 and y < retour.y + retour.h/2 then
          drawPapier1 = false
          if item.select == true and item.name == "boulette1" then
            item.select = false
          end
          drawPapier2 = false
          if item.select == true and item.name == "boulette2" then
            item.select = false
          end
          drawPapier3 = false
          if item.select == true and item.name == "boulette3" then
            item.select = false
          end
      end
    end
  end
end