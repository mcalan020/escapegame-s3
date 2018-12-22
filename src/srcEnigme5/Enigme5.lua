enigme5dejavu = false
digitTrouve = false

local lstButton = {}
local lstDigit = {}
local list = {}
local codeFind = false

local background = love.graphics.newImage("img/Enigme5/background_digicode.png")

local light = {}
light.red = love.graphics.newImage("img/Enigme5/bouton.png")
light.green = love.graphics.newImage("img/Enigme5/bouton_vert.png")
light.x = 375
light.y = 120
light.w = light.red:getWidth()/2
light.h = light.red:getHeight()/2

local retour = {}
retour.sprite = love.graphics.newImage("img/retour_180_80.png")
retour.w = 180
retour.h = 80
retour.x = 60
retour.y = 370

local msg1 = ""
local msg2 = ""

--- Fonction qui crée les boutons au cordonnées x et y 
function CreateButton(pType, pDigit, pX, pY)
  local button = {}

  button.type = pType
  button.digit = pDigit
  
  if button.type == "plus" then
    button.img = love.graphics.newImage("img/Enigme5/up_button.png")
  elseif button.type == "moins" then
    button.img = love.graphics.newImage("img/Enigme5/down_button.png")
  end

  button.x = pX
  button.y = pY

  button.width = 75
  button.height = 50

  button.click = false

  button.Push = function()
    if button.type == 'plus' then
      button.digit.Add()
    elseif button.type == 'moins' then
      button.digit.Remove()
    end
  end

  table.insert(lstButton, button)
  return button
end

--- Fonction qui crée les digicodes au cordonnées x et y  
function CreateDigit(pX, pY,l)
  local digit = {}
  digit.index = 1
  digit.list=l 
  digit.number=digit.list[digit.index]
  digit.x = pX
  digit.y = pY

  digit.Add = function()
    digit.index = digit.index +1
    if digit.index > 10 then
      digit.index = 1 
    end
    digit.number = digit.list[digit.index]
  end

  digit.Remove = function()
    digit.index = digit.index - 1   
    if digit.index < 1 then
      digit.index = 10
    end
    digit.number = digit.list[digit.index]
  end

  table.insert(lstDigit, digit)

  return digit
end

--- Constructeur de la classe
function Enigme5Load()
    for n = 1, 10 do
      list[n] = love.graphics.newImage("img/Enigme5/"..(n-1)..".png")
    end    
    local x = 55
    for n=1,9 do
        CreateDigit(x, 256, list)
        x = x + 75
    end
    local x1= 55
    for n=1,9 do 
        CreateButton ('plus', lstDigit[n], x1, 180)
        CreateButton ('moins', lstDigit[n], x1, 331)
        x1 = x1 + 75
    end
    
    msg1 = "Comment trouver la combinaison ?"
    msg2 = ""
end

--- Fonction de validation de code 
function CheckCode(pLstDigit)
  --378 151 771
  if lstDigit[1].index == 4 and lstDigit[2].index == 8 and lstDigit[3].index == 9 and lstDigit[4].index == 2 and lstDigit[5].index == 6 
    and lstDigit[6].index == 2 and lstDigit[7].index == 8 and lstDigit[8].index == 2 and lstDigit[9].index == 8 then
    return true
  end
  return false
end

---Fonction qui permet interaction utilisateur jeu 
function Enigme5Update(dt, mouseX, mouseY)
  if CheckCode(lstDigit) then
    digitTrouve = true
  end
end

---Fonction qui permet d'afficher 
function Enigme5Draw()
  love.graphics.draw(background)
  
  for nButton = #lstButton, 1, -1 do
    local button = lstButton[nButton]    
    love.graphics.draw(button.img, button.x, button.y, 0, 1, 1, button.img:getWidth()/2, button.img:getHeight()/2)
  end
  
  if CheckCode() then
    love.graphics.draw(light.green, light.x, light.y, 0, 1, 1, light.w, light.h)
  else
    love.graphics.draw(light.red, light.x, light.y, 0, 1, 1, light.w, light.h)
  end

  for nDigit = #lstDigit, 1, -1 do
    local digit = lstDigit[nDigit]
    love.graphics.draw(digit.number, digit.x, digit.y, 0, 1, 1, digit.number:getWidth()/2, digit.number:getHeight()/2)
  end
  love.graphics.draw(retour.sprite, retour.x, retour.y, 0, 0.5, 0.5, retour.w/2, retour.h/2)
end

function Enigme5DrawPrint()
  love.graphics.setColor(0, 0, 0)
  love.graphics.print(msg1, 20, 410)
  love.graphics.print(msg2, 20, 440)
  love.graphics.setColor(255, 255, 255)
end

---Fonction qui quand on clique d'effectuer des actions avec l'utilisateur
function Enigme5MousePressed(x,y,button)
  if button == 1 then
    if x > retour.x - retour.w/2 and x < retour.x + retour.w/2 and y > retour.y - retour.h/2 and y < retour.y + retour.h/2 then
      etatEnigme = "Enigme 4"
    end
  
    for nButton = #lstButton, 1, -1 do
      local button = lstButton[nButton]
      if x > button.x - button.width/2 and x < button.x + button.width/2 and y > button.y - button.height/2 and  y < button.y + button.height/2 then
        button.Push()
        button.click = true
      end
    end
  end
end

---Fonction qui quand on relache les souris effectue une action
function love.mousereleased(x,y,button)
  if button == 1 then
    for nButton = #lstButton, 1, -1 do
      local button = lstButton[nButton]
      button.click = false
    end
  end
end
