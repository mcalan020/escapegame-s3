-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

-- Empèche Love de filtrer les contours des images quand elles sont redimentionnées
-- Indispensable pour du pixel art
love.graphics.setDefaultFilter("nearest")

-- Cette ligne permet de déboguer pas à pas dans ZeroBraneStudio
if arg[#arg] == "-debug" then require("mobdebug").start() end

require("menu")
local screenWidth = 750
local screenHeight = 500

local mouseX = 0
local mouseY = 0

-- Cette fonction s'execute qu'une seule fois et au démarage
-- Ici chargement des images/sons/musiques
function love.load()
  --Changement du titre du jeu
  love.window.setTitle("La dernière épreuve !")
  love.window.setMode(screenWidth,screenHeight)
  
  --Chargement du menu
  menuLoad()
  
  --Chargement d'une image : love.graphics.newImage()
end

-- Cette fonction s'execute en moyenne 60 fois/seconde
-- Ici fonctionnement du gameplay
-- Le paramètre 'dt -> deltatime' représente la durée écoulée depuis le dernier appel(en seconde)
function love.update(dt)
  mouseX = love.mouse.getX()
  mouseY = love.mouse.getY()
  
  --Update du menu
  menuUpdate(dt, mouseX, mouseY)
end

-- Cette fonction permet de dessiner
function love.draw()
  -- dessiner une image love.graphics.draw() 
  
  --affichage du menu
  menuDraw()
end

-- Cette fonction permet le gestion de la souris
-- Les paramètres : - x -> position x de la souris
--                  - y -> position y de la souris
--                  - button -> Bouton pressé (1:gauche, 2:droite, 3:centre)
function love.mousepressed(x, y, button)
  menuMousePressed(x, y, button)
end

-- Cette fonction permet la gestion du clavier
-- Le paramètre key -> touche du clavier pressée
function love.keypressed(key)
  menuKeyPressed(key)
  if key == 'escape' then
    love.event.quit()
  end
end