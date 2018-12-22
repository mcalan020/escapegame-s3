require("Useful")

local ItemManager = {}

InventeryManager = require("InventeryManager")

ItemManager.lstItem = {}

ItemManager.Reset = function()
  ItemManager.lstItem = {}
end

--Créer un item et initialise ses données
ItemManager.CreateItem = function(pName, pSprite, pX, pY, pEnigme, pTake)
  local item = {}
  
  item.name = pName
  item.sprite = love.graphics.newImage(pSprite)
  item.width = item.sprite:getWidth()
  item.height = item.sprite:getHeight()
  
  item.enigme = pEnigme
  
  item.x = pX
  item.y = pY
  item.vx = 0
  item.vy = 0
  item.friction = false
  item.supprime = false
  item.pickup = false
  item.inInventery = false
  item.select = false
  item.iTake= pTake

  table.insert(ItemManager.lstItem, item)
  
  return item
end
local isSelect = false
ItemManager.Update = function(dt, mouseX, mouseY)
  for nItem=#ItemManager.lstItem,1,-1 do
    local item = ItemManager.lstItem[nItem]
    if item.supprime == true then
      table.remove(ItemManager.lstItem,nItem)
    end
    --Si clique bouton gauche l'item est envoyer vers l'inventaire
    if love.mouse.isDown(1) and item.enigme == etatEnigme and item.iTake then
      for nOtherItem = #ItemManager.lstItem, 1, -1 do
        local otherItem = ItemManager.lstItem[nOtherItem]
        if otherItem ~= item and otherItem.pickup == false then
          if mouseX > item.x - (item.width/2) and mouseX < (item.x + item.width/2) and mouseY > (item.y - item.height/2) and mouseY < (item.y + item.height/2) then
            if item.inInventery == false then
              local oy = InventeryManager.oy + (#InventeryManager.lstItem)*InventeryManager.cellHeight
              local angle = math.angle(item.x, item.y, InventeryManager.x, oy)
              local vitesse = 300
              item.vx = vitesse * math.cos(angle)
              item.vy = vitesse * math.sin(angle)
              item.pickup = true
            end
          end
        end
      end
    end
    -- L'item est en route vers l'inventaire
    if item.pickup == true then
        item.x = item.x + item.vx*dt
        item.y = item.y + item.vy*dt
        local oy = InventeryManager.oy + (#InventeryManager.lstItem)*InventeryManager.cellHeight
        if item.x > InventeryManager.x - InventeryManager.cellWidth/2 and item.x < InventeryManager.x + InventeryManager.cellWidth/2
          and item.y > oy - InventeryManager.cellHeight/2 and item.y < oy + InventeryManager.cellHeight/2 then
          item.pickup = false
          item.inInventery = true
          InventeryManager.AddItem(item)
        end
    end
    
  end
end

ItemManager.Draw = function()
  for nitem=#ItemManager.lstItem,1,-1 do
    local item = ItemManager.lstItem[nitem]
    --Dessine l'image de l'objet
    love.graphics.draw(item.sprite, item.x, item.y, 0, 1, 1, item.width/2, item.height/2)
  end
end

ItemManager.DrawOneItem = function(pName)
  for nitem=#ItemManager.lstItem,1,-1 do
    local item = ItemManager.lstItem[nitem]
    --Dessine l'image de l'objet
    if pName == item.name then
      love.graphics.draw(item.sprite, item.x, item.y, 0, 1, 1, item.width/2, item.height/2)
    end
  end
end

ItemManager.Mousepressed = function(x, y, button)
  if button == 1 then
    for nItem = 1, #ItemManager.lstItem do
      local item = ItemManager.lstItem[nItem]
      if x > item.x - (item.width/2) and x < (item.x + item.width/2) and y > (item.y - item.height/2) and y < (item.y + item.height/2) then
        if item.inInventery then
          if item.select == true then
            
            item.select = false
          else
            print(item.name)
            item.select = true
          end
        end
      end
    end
  end
end

return ItemManager