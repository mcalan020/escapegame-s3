local PieceManager = {}

PieceManager.lstPiece = {}

PieceManager.CreatePiece = function(pName, pX, pY, pPoint)
  local piece = {}
  
  piece.name = pName
  piece.sprite = love.graphics.newImage("img/Enigme3/"..piece.name.."_ombre.png")
  piece.select = love.graphics.newImage("img/Enigme3/"..piece.name.."_Selected_ombre.png")
  piece.width = piece.sprite:getWidth()
  piece.height = piece.sprite:getHeight()
  piece.flip = 1
  
  piece.choice = love.graphics.newImage("img/Enigme3/Choice.png")
  piece.choice_flip = 0
  
  piece.x = pX
  piece.y = pY
  
  piece.vx = 0
  piece.vy = 0
  
  piece.isSelect = false
  piece.isMove = false
  
  piece.remove = false
  piece.waitSpeed = 1/6
  piece.waitTimer = piece.waitSpeed
  
  piece.point = pPoint
  piece.point.piece = piece
  piece.oldPoint = pPoint
  
  piece.shoot = false
  piece.shootSpeed = 1/6
  piece.shootTimer = piece.shootSpeed
  
  piece.enemy = ""
  
  table.insert(PieceManager.lstPiece, piece)
  return piece
end

PieceManager.Draw = function()
  for nPiece = #PieceManager.lstPiece, 1, -1 do
    local piece = PieceManager.lstPiece[nPiece]
    if piece.isSelect == true then
      love.graphics.draw(piece.select, piece.x, piece.y, 0, piece.flip, 1, piece.width/2, piece.height/2)
      for nLink = #piece.point.lstLink, 1, -1 do
        local link = piece.point.lstLink[nLink]
        if link.piece == "" then
          love.graphics.draw(piece.choice, link.x, link.y, piece.choice_flip, 1, 1, piece.choice:getWidth()/2, piece.choice:getHeight()/2)
        end
      end
    else
      love.graphics.draw(piece.sprite, piece.x, piece.y, 0, piece.flip, 1, piece.width/2, piece.height/2)
    end
  end
end

return PieceManager