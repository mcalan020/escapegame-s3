require("jeu")

local gamestate = ""

--bouton jouer
local jouer = {}
  jouer.button = nil
  jouer.x = 246
  jouer.y = 205
  jouer.longeur = 270
  jouer.largeur = 102
  jouer.hovered = false

--bouton quitter
local quitter = {}
  quitter.button = nil
  quitter.x = 246
  quitter.y = 311
  quitter.longeur = 270
  quitter.largeur = 102
  quitter.hovered = false
  
  sndMenu = love.audio.newSource("msc/neigequitombe.mp3", "stream") 
  sndJeu = love.audio.newSource("msc/Dark_Ambient_Playlist.mp3", "stream")
  volume = 0.5
  sndMenu:setVolume(volume)

--Chargement des images
function menuLoad()
  gamestate = "Menu"
    
  menu = love.graphics.newImage("img/menu/menu_background.png")
  title = love.graphics.newImage("img/menu/title_gold.png")
  
  jouer.button = love.graphics.newImage("img/menu/btn_jouer.png")
  jouer.button_hovered = love.graphics.newImage("img/menu/btn_jouer_hover.png")
  
  quitter.button = love.graphics.newImage("img/menu/btn_quitter.png")
  quitter.button_hovered = love.graphics.newImage("img/menu/btn_quitter_hover.png")
  
  sndMenu:play()
end

function menuUpdate(dt, mouseX, mouseY)
  
  if gamestate == "Menu" then
    --Si la souris survole le bouton jouer
    if mouseX > jouer.x and mouseY > jouer.y and mouseX < (jouer.x + jouer.longeur) and mouseY < (jouer.y+jouer.largeur) then
      jouer.hovered = true
    else
      jouer.hovered = false
    end
    --Si la souris survole le bouton quitter
    if mouseX > quitter.x and mouseY > quitter.y and mouseX < (quitter.x + quitter.longeur) and mouseY < (quitter.y+quitter.largeur) then
      quitter.hovered = true
    else
      quitter.hovered = false
    end
  elseif gamestate == "Jouer" then
    --Update du jeu
    jeuUpdate(dt, mouseX, mouseY)
    sndMenu:stop()
    sndJeu:play()
  end
end

function menuDraw()
  if gamestate == "Menu" then
    love.graphics.draw(menu) 
    love.graphics.draw(title,73,53)
    
    if quitter.hovered == false then
      love.graphics.draw(quitter.button, quitter.x, quitter.y, 0, 1, 1, 0, 0)
    else
      love.graphics.draw(quitter.button_hovered, quitter.x, quitter.y, 0, 1, 1, 0, 0)
    end
    
    if jouer.hovered == false then 
      love.graphics.draw(jouer.button, jouer.x, jouer.y, 0, 1, 1, 0, 0)
    else
      love.graphics.draw(jouer.button_hovered, jouer.x, jouer.y, 0, 1, 1, 0, 0)
    end
  elseif gamestate == "Jouer" then
    jeuDraw()
  end

end

function menuMousePressed(x, y, button)
  if button == 1 then
    if gamestate == "Menu" then
      if x > jouer.x and y > jouer.y and x < (jouer.x + jouer.longeur) and y < (jouer.y+jouer.largeur) then
        gamestate = "Jouer"
        jeuLoad()
      end
      
      if x > quitter.x and y > quitter.y and x < (quitter.x + quitter.longeur) and y < (quitter.y+quitter.largeur) then
        love.event.quit()
      end
    end
  end
  if gamestate == "Jouer" then
    jeuMousepressed(x,y,button)
  end
end

function menuKeyPressed(key)
  if key == "r" then
    gamestate = "Menu"
    jeuReset()
  end
end
