local Inventery = {}

ParticleManager = require("ParticleManager")

----Donnée de l'inventaire----
Inventery.sprite = love.graphics.newImage("img/Inventaire/icone_inventory.png")
Inventery.select = love.graphics.newImage("img/Inventaire/icone_select.png")
--Taile d'une case de l'inventaire
Inventery.cellWidth = Inventery.sprite:getWidth()
Inventery.cellHeight = Inventery.sprite:getHeight()

Inventery.ox = Inventery.cellWidth/2
Inventery.oy = Inventery.cellHeight/2

Inventery.x = 750 - Inventery.ox
Inventery.y = Inventery.oy

Inventery.nbCells = 6

Inventery.lstItem = {}

--Vide l'inventaire
Inventery.EmptyInventery = function()
  Inventery.lstItem = {}
end

--Ajoute un item
Inventery.AddItem = function(pItem)
  table.insert(Inventery.lstItem, pItem)
  if #Inventery.lstItem > Inventery.nbCells then
    Inventery.nbCells = Inventery.nbCells + 1
  end
  pItem.x = Inventery.x
  pItem.y = Inventery.oy + ((#Inventery.lstItem - 1) * Inventery.cellHeight)
  pItem.vx = 0
  pItem.vy = 0
  ParticleManager.CreeExplosion("pickup", pItem.x, pItem.y)
end

Inventery.Draw = function()
  local y = Inventery.y
  for n = 1, Inventery.nbCells, 1 do
    love.graphics.draw(Inventery.sprite, Inventery.x, y, 0, 1, 1, Inventery.ox, Inventery.oy)
    y = y + Inventery.cellHeight + 1 
  end
  for nItem = #Inventery.lstItem, 1, -1 do
    local item = Inventery.lstItem[nItem]
    if item.select then
      love.graphics.draw(Inventery.select, item.x + 4, item.y, 0, 1, 1, Inventery.select:getWidth()/2, Inventery.select:getHeight()/2)
    end
  end
end

return Inventery 