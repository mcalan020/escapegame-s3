require("srcEnigme3/Enigme3")
require("srcEnigme4/Enigme4")

enigme2dejavu = false

local background = love.graphics.newImage("img/Enigme2/enigme_mevlut.png")

local tableau = {}
tableau.sprite = love.graphics.newImage("img/Enigme2/tableau_dab.png")
tableau.x = 507
tableau.y = 165
tableau.w = tableau.sprite:getWidth()/2
tableau.h = tableau.sprite:getHeight()/2
tableau.tombe = false
tableau.estTombe = false

--173 241
--7 13
local serrure = {}
serrure.x = 173
serrure.y = 241
serrure.w = 7
serrure.h = 13
serrure.view_sprite = love.graphics.newImage("img/Enigme2/serrure.png")
serrure.view = false
serrure.view_code_sprite = love.graphics.newImage("img/Enigme2/serrure_on.png")
serrure.view_code = false

--374 282
--37 47
local coffre = {}
coffre.x = 374
coffre.y = 281
coffre.w = 37
coffre.h = 47
coffre.view = false
coffre.view_sprite = love.graphics.newImage("img/Enigme2/Coffre.png")
coffre.roulette = love.graphics.newImage("img/Enigme2/roulette.png")
coffre.roulette_rotation = 0
coffre.roulette_socle = love.graphics.newImage("img/Enigme2/fleche-bas.png")
coffre.open = false
coffre.open_sprite = love.graphics.newImage("img/Enigme2/coffre_open.png")

local code = {}
code[1] = 0
code[2] = 0
code[3] = 0
code[4] = 0
code[5] = 0
code[6] = 0
local index = 0

local retour = {}
retour.sprite = love.graphics.newImage("img/retour_180_80.png")
retour.w = 180
retour.h = 80
retour.x = 60
retour.y = 370

local msg1 = ""
local msg2 = ""

function Enigme2Load()
  ItemManager.CreateItem("torche", "img/Enigme2/Torche.png", 530, 370, "Enigme 2", true)
  
  ItemManager.CreateItem("boulette2", "img/Enigme5/papier_boulette.png", 230, 250, "Enigme 2", false)
  ItemManager.CreateItem("marteau", "img/Enigme2/marteau.png", 320, 250, "Enigme 2", false)
  
  msg1 = "Cette commode m'intrigue !"
  msg2 = "Ce coffre fort également."
end

function Enigme2Update(dt, mouseX, mouseY)
  if coffre.view then
    if love.mouse.isDown(1) then
      if mouseX > 375 - coffre.roulette:getWidth()/2 and mouseX < 375 + coffre.roulette:getWidth()/2 and
        mouseY > 230 - coffre.roulette:getHeight()/2 and mouseY < 230 + coffre.roulette:getHeight()/2 then
          coffre.roulette_rotation = coffre.roulette_rotation + .01
          if coffre.roulette_rotation > 6.3 then
            coffre.roulette_rotation = 0
          end
      end
    else
      if coffre.roulette_rotation > 0 and coffre.roulette_rotation < 0.59 then code[index] = 0 end
      if coffre.roulette_rotation > 0.59 and coffre.roulette_rotation < 1.25 then code[index] = 1 end
      if coffre.roulette_rotation > 1.25 and coffre.roulette_rotation < 1.85 then code[index] = 2 end
      if coffre.roulette_rotation > 1.85 and coffre.roulette_rotation < 2.5 then code[index] = 3 end
      if coffre.roulette_rotation > 2.50 and coffre.roulette_rotation < 3.1 then code[index] = 4 end
      if coffre.roulette_rotation > 3.1 and coffre.roulette_rotation < 3.7 then code[index] = 5 end
      if coffre.roulette_rotation > 3.7 and coffre.roulette_rotation < 4.35 then code[index] = 6 end
      if coffre.roulette_rotation > 4.35 and coffre.roulette_rotation < 5 then code[index] = 7 end
      if coffre.roulette_rotation > 5 and coffre.roulette_rotation < 5.7 then code[index] = 8 end
      if coffre.roulette_rotation > 5.7 then code[index] = 9 end
    end
    
    if code[1] == 1 and code[2] == 2 and code[3] == 3 and code[4] == 4 and code[5] == 5 and code[6] == 6 then
      coffre.open = true
    end
  end
  
  if tableau.tombe and tableau.estTombe == false then
    tableau.y = tableau.y + 1
    if tableau.y > 275 then
      tableau.estTombe = true
    end
  end
  
  if serrure.view then
    msg1 = "Une lumière m'aiderai surement"
    msg2 = "à voir par cette serrure."
  elseif coffre.view then
    msg1 = "Le code doit se trouver dans cette pièce."
    msg2 = ""
  elseif codeTrouve then
    msg1 = "Oh ! la porte s'est déveroulliée !"
    msg2 = ""
  elseif tableau.estTombe then
    msg1 = "Il y a quelque chose dans ce trou!"
    msg2 = ""
  else
    msg1 = "Cette commode m'intrigue !"
    msg2 = "Ce coffre fort également."
  end
  for nItem = #ItemManager.lstItem, 1, -1 do
      local item = ItemManager.lstItem[nItem]
      if  coffre.open then
        item.iTake = true
      end
      if item.name == "marteau" and item.inInventery and tableau.estTombe == false then
        msg1 = "Ce tableau me parait suspect."
        msg2 = ""
      end
  end
end

function Enigme2Draw()
  love.graphics.draw(background)
  love.graphics.draw(tableau.sprite, tableau.x, tableau.y, 0, 1, 1, tableau.w, tableau.h)
  
  ItemManager.DrawOneItem("torche")
  
  if coffre.view then
    love.graphics.draw(coffre.view_sprite)
    love.graphics.draw(coffre.roulette_socle, 375, 230, 0, 1, 1, coffre.roulette_socle:getWidth()/2, coffre.roulette_socle:getHeight()/2)
    love.graphics.draw(coffre.roulette, 375, 230, coffre.roulette_rotation, 1, 1, coffre.roulette:getWidth()/2, coffre.roulette:getHeight()/2)
    
    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle("fill", 40, 220, 150, 50)
    love.graphics.setColor(0, 255, 0)
    love.graphics.print(code[1].." "..code[2].." "..code[3].." "..code[4].." "..code[5].." "..code[6], 50, 230)
    love.graphics.setColor(255, 255, 255)
    
    if coffre.open then
      love.graphics.draw(coffre.open_sprite)
      ItemManager.DrawOneItem("boulette2")
      ItemManager.DrawOneItem("marteau")
    end
  end
  
  if serrure.view_code then
    love.graphics.draw(serrure.view_code_sprite)    
  elseif serrure.view then
    love.graphics.draw(serrure.view_sprite)
  end
  
  love.graphics.draw(retour.sprite, retour.x, retour.y, 0, 0.5, 0.5, retour.w/2, retour.h/2)
end

function Enigme2DrawPrint()
  love.graphics.setColor(0, 0, 0)
  love.graphics.print(msg1, 20, 410)
  love.graphics.print(msg2, 20, 440)
  love.graphics.setColor(255, 255, 255)
end

function Enigme2MousePressed(x, y, button)
  if button == 1 then
    if x > retour.x - retour.w/2 and x < retour.x + retour.w/2 and y > retour.y - retour.h/2 and y < retour.y + retour.h/2 then
      if serrure.view then
        serrure.view = false
        serrure.view_code = false
      elseif coffre.view then
        coffre.view = false
        code[1] = 0
        code[2] = 0
        code[3] = 0
        code[4] = 0
        code[5] = 0
        code[6] = 0
      else
        etatEnigme = "Enigme 1"
      end
    end
    
    if tableau.estTombe and finenigme3 == false and x > 470 and x < 545 and y > 150 and y < 190 then
      etatEnigme = "Enigme 3"
      if enigme3dejavu == false then
        Enigme3Load()
        enigme3dejavu = true
      end
    end
    
    --605 110
    --106 250
    if finenigme3 and x > 605 and x < 710 and y > 110 and y < 360 then
      etatEnigme = "Enigme 4"
      if enigme4dejavu == false then
        Enigme4Load()
        enigme4dejavu = true
      end
    end
    
    if serrure.view == false and x > coffre.x and x < coffre.x + coffre.w and y > coffre.y and y < coffre.y + coffre.h then
      coffre.view = true
    end
    
    if coffre.view then
      if x > 375 - coffre.roulette:getWidth()/2 and x < 375 + coffre.roulette:getWidth()/2 and
        y > 230 - coffre.roulette:getHeight()/2 and y < 230 + coffre.roulette:getHeight()/2 then
        index = index + 1
        if index > 6 then
          index = 1
        end
      end
    end
    
    for nItem = #InventeryManager.lstItem, 1, -1 do
      local item = InventeryManager.lstItem[nItem]
      if tableau.tombe == false and tableau.estTombe == false and  item.name == "marteau" and item.select then
        if x > tableau.x - tableau.w/2 and x < tableau.x + tableau.w/2 and y > tableau.y - tableau.h/2 and y < tableau.y + tableau.h/2 then
          tableau.tombe = true
        end
      end
      
      if coffre.view == false and serrure.view and item.name == "torche" and item.select then
        serrure.view_code = true
      end
      if coffre.view == false and x > serrure.x and x < serrure.x + serrure.w and y > serrure.y and y < serrure.y + serrure.h then
        if item.name == "torche" and item.select then
          serrure.view_code = true
        end
      end
    end
    if coffre.view == false and x > serrure.x and x < serrure.x + serrure.w and y > serrure.y and y < serrure.y + serrure.h then
      serrure.view = true
    end
  end
end