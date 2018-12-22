require("srcEnigme5/Enigme5")
require("Cinematique2")

enigme4dejavu = false

local background = love.graphics.newImage("img/Enigme4/salle_fin_masson.png")

local codeTrouve = false

local cubecolor = {}
cubecolor.sprite = love.graphics.newImage("img/Enigme4/codebloc_mini.png")
cubecolor.y = 350

local papier = {}
papier.x = 600
papier.y = 320
papier.view = false
papier.sprite = love.graphics.newImage("img/Enigme4/oldpaper.png")
papier.sprite_mini = love.graphics.newImage("img/Enigme4/oldpaper_mini.png")
papier.w = papier.sprite_mini:getWidth()/2
papier.h = papier.sprite_mini:getHeight()/2

local digicode = {}
digicode.sprite_mini_off = love.graphics.newImage("img/Enigme4/digicode_mini_off.png")
digicode.sprite_mini_on = love.graphics.newImage("img/Enigme4/digicode_mini_on.png")
digicode.sprite_mini_on_good = love.graphics.newImage("img/Enigme4/digicode_mini_on_good.png")
digicode.sprite = love.graphics.newImage("img/Enigme5/background_digicode.png")
digicode.x = 221
digicode.y = 253
digicode.xm = 305
digicode.ym = 281
digicode.view = false
digicode.light = {}
digicode.light.sprite = love.graphics.newImage("img/Enigme5/bouton_noir.png")
digicode.light.x = 375
digicode.light.y = 160
digicode.light.w = digicode.light.sprite:getWidth()/2
digicode.light.h = digicode.light.sprite:getHeight()/2
digicode.digit = {}
digicode.digit.sprite = love.graphics.newImage("img/Enigme5/1.png")
digicode.digit.x = 55
digicode.digit.y = 256
digicode.digit.w = digicode.digit.sprite:getWidth()/2
digicode.digit.h = digicode.digit.sprite:getHeight()/2

local retour = {}
retour.sprite = love.graphics.newImage("img/retour_180_80.png")
retour.w = 180
retour.h = 80
retour.x = 60
retour.y = 370

local msg1 = ""
local msg2 = ""

local lstselector = {}

function CreateSelector(pX, pY, pColor)
  local selector = {}
  
  selector.view = false
  
  selector.sprite = love.graphics.newImage("img/Enigme4/fleche_codebloc.png")
  selector.background = love.graphics.newImage("img/Enigme4/codebloc.png")
  
  selector.x = pX
  selector.y = pY
  selector.width = selector.sprite:getWidth()/2
  selector.height = selector.sprite:getHeight()/2
  
  selector.color = "bleu"
  selector.goodColor = pColor
  selector.rotation = 0
  
  selector.Push = function()
    selector.rotation = selector.rotation + 1.5
    if selector.rotation > 4.5 then
      selector.rotation = 0
    end
    
    if selector.rotation == 0 then
      selector.color = "bleu"
    elseif selector.rotation == 1.5 then
      selector.color = "jaune"
    elseif selector.rotation == 3 then
      selector.color = "rouge"
    elseif selector.rotation == 4.5 then
      selector.color = "vert"
    end
  end
  
  table.insert(lstselector, selector)
  
  return selector
end

function Enigme4Load()
  sel1 = CreateSelector(375, 230, "vert")
  sel2 = CreateSelector(375, 230, "bleu")
  sel3 = CreateSelector(375, 230, "rouge")
  
  ItemManager.CreateItem("boulette3", "img/Enigme5/papier_boulette.png", 510, 380, "Enigme 4", true)
  
  msg1 = "Cette salle doit surement renfermer des secrets."
  msg2 = ""
end

function Enigme4Update(dt, mouseX, mouseY)
  if sel1.color == sel1.goodColor and sel2.color == sel2.goodColor and sel3.color == sel3.goodColor then
    codeTrouve = true
  end
  
  if digicode.view and codeTrouve == false then
    msg1 = "Ce digicode est éteint !"
    msg2 = ""
  elseif codeTrouve then
    msg1 = "Le digicode s'est allumé !"
    msg2 = ""
  elseif papier.view then
    msg1 = "Ces couleurs doivent être utiles."
    msg2 = ""
  else
    msg1 = "Cette salle doit surement renfermer des secrets."
    msg2 = ""
  end
  
  for nItem = #lstselector, 1, -1 do
    local selector = lstselector[nItem]
    if selector.view then
      msg1 = "Ces couleurs doivent être utiles."
      msg2 = ""
    end
  end
  
end

function Enigme4Draw()
  love.graphics.draw(background)
  if codeTrouve == false then
    love.graphics.draw(digicode.sprite_mini_off, digicode.x, digicode.y)
  elseif digitTrouve then
    love.graphics.draw(digicode.sprite_mini_on_good, digicode.x, digicode.y)
  else
    love.graphics.draw(digicode.sprite_mini_on, digicode.x, digicode.y)
  end
  love.graphics.draw(papier.sprite_mini, papier.x, papier.y, 0, 1, 1, papier.w, papier.h)
  local x = 170
  for n=1, 3 do
    love.graphics.draw(cubecolor.sprite, x, cubecolor.y, 0, 1, 1, cubecolor.sprite:getWidth()/2, cubecolor.sprite:getHeight()/2)
    x = x + 50
  end
  
  if sel1.view == false and sel2.view == false and sel3.view == false and digicode.view == false and papier.view == false then
    ItemManager.DrawOneItem("boulette3")
  end
  
  if papier.view and digicode.view == false then
    love.graphics.draw(papier.sprite, 375, 230, 0, 1, 1, papier.sprite:getWidth()/2, papier.sprite:getHeight()/2)
  end
  
  if digicode.view and papier.view == false then
    love.graphics.draw(digicode.sprite)
    love.graphics.draw(digicode.light.sprite, digicode.light.x, digicode.light.y, 0, 1, 1, digicode.light.w, digicode.light.h)
    x = 55
    for n=1,9 do
        love.graphics.draw(digicode.digit.sprite, x, digicode.digit.y, 0, 1, 1, digicode.digit.w, digicode.digit.h)
        x = x + 75
    end
  end
  
  for nItem = #lstselector, 1, -1 do
    local selector = lstselector[nItem]
    if selector.view then
      love.graphics.draw(selector.background, selector.x, selector.y, 0, .5, .5, selector.background:getWidth()/2, selector.background:getHeight()/2)
      love.graphics.draw(selector.sprite, selector.x, selector.y, selector.rotation, .5, .5, selector.sprite:getWidth()/2, selector.sprite:getHeight()/2)
    end
  end
  
  love.graphics.draw(retour.sprite, retour.x, retour.y, 0, 0.5, 0.5, retour.w/2, retour.h/2)
end

function Enigme4DrawPrint()
  love.graphics.setColor(0, 0, 0)
  love.graphics.print(msg1, 20, 410)
  love.graphics.print(msg2, 20, 440)
  love.graphics.setColor(255, 255, 255)
end

function Enigme4MousePressed(x, y, button)
  if button == 1 then
    if x > retour.x - retour.w/2 and x < retour.x + retour.w/2 and y > retour.y - retour.h/2 and y < retour.y + retour.h/2 then
      if digicode.view then
        digicode.view = false
      elseif papier.view then
        papier.view = false
      else
        if sel1 == false and selt2 == false and sel3 == false then
          etatEnigme = "Enigme 2"
        end
      end
    end
    
    if digitTrouve and x > 315 and x < 460 and y > 130 and y < 400 then
      etatEnigme = "Cinematique 2"
      Cinematique2Load()
    end
    
    if sel1.view == false and sel3.view == false and sel3.view == false and papier.view == false and x > digicode.x and x < digicode.xm and y > digicode.y and y < digicode.ym then
      if codeTrouve == false then
        digicode.view = true
      else
        etatEnigme = "Enigme 5"
        if enigme5dejavu == false then
          Enigme5Load()
          enigme5dejavu = true
        end
      end
    end
    
    if sel1.view == false and sel3.view == false and sel3.view == false and digicode.view == false and x > papier.x - papier.w and x < papier.x + papier.w and y > papier.y - papier.h and y < papier.y + papier.h then
      papier.view = true
    end
    
    if sel2.view == false and sel3.view == false and digicode.view == false and papier.view == false and x > 170 - 19 and x < 170 + 19 and y > cubecolor.y - 19 and cubecolor.y + 19 then
      sel1.view = true
    end
    if sel1.view == false and sel3.view == false and digicode.view == false and papier.view == false and x > 220 - 19 and x < 220 + 19 and y > cubecolor.y - 19 and cubecolor.y + 19 then
      sel2.view = true
    end
    if sel1.view == false and sel2.view == false and digicode.view == false and papier.view == false and x > 270 - 19 and x < 270 + 19 and y > cubecolor.y - 19 and cubecolor.y + 19 then
      sel3.view = true
    end
    
    for nSelector = #lstselector, 1, -1 do
      local selector = lstselector[nSelector]
      if x > retour.x - retour.w/2 and x < retour.x + retour.w/2 and y > retour.y - retour.h/2 and y < retour.y + retour.h/2 then
        if selector.view then
          selector.view = false
        end
      end
    
      if selector.view and x > selector.x - selector.width and x < selector.x + selector.width and y > selector.y - selector.height and y < selector.y + selector.height then
        selector.Push()
      end
    end
  end
end