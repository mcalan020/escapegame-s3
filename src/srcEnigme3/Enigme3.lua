local PointManager = require("srcEnigme3/PointManager")
local PieceManager = require("srcEnigme3/PieceManager")
local FireManager = require("srcEnigme3/FireManager")
require("Useful")

local move = false

enigme3dejavu = false
finenigme3 = false

local retour = {}
retour.sprite = love.graphics.newImage("img/retour_180_80.png")
retour.w = 180
retour.h = 80
retour.x = 60
retour.y = 370

local msg1 = ""
local msg2 = ""

function InitPoint()
  ---- Init Point Bleu ----
  PB1 = PointManager.CreatePoint("Point Bleu 1", "Blue", 86, 87)
  PB2 = PointManager.CreatePoint("Point Bleu 2", "Blue", 86, 205)
  PB3 = PointManager.CreatePoint("Point Bleu 3", "Blue", 86, 323)  
  ---- Init Point Red ----
  PR1 = PointManager.CreatePoint("Point Red 1", "Red", 622, 87)
  PR2 = PointManager.CreatePoint("Point Red 2", "Red", 622, 205)
  PR3 = PointManager.CreatePoint("Point Red 3", "Red", 622, 323)
  ---- Init Point Grey ----
  P1 = PointManager.CreatePoint("Point 1", "Grey", 204, 130)
  P2 = PointManager.CreatePoint("Point 2", "Grey", 204, 280)
  P3 = PointManager.CreatePoint("Point 3", "Grey", 354, 87)
  P4 = PointManager.CreatePoint("Point 4", "Grey", 354, 205)
  P5 = PointManager.CreatePoint("Point 5", "Grey", 354, 323)
  P6 = PointManager.CreatePoint("Point 6", "Grey", 504, 130)
  P7 = PointManager.CreatePoint("Point 7", "Grey", 504, 280)

  
 ---- Link Point ----
  PB1.AddLink(P1)
  PB2.AddLink(P1)
  PB2.AddLink(P2)
  PB3.AddLink(P2)
  
  PR1.AddLink(P6)
  PR2.AddLink(P6)
  PR2.AddLink(P7)
  PR3.AddLink(P7)
  
  P1.AddLink(PB1)
  P1.AddLink(PB2)
  P1.AddLink(P3)
  P1.AddLink(P4)
  
  P2.AddLink(PB2)
  P2.AddLink(PB3)
  P2.AddLink(P4)
  P2.AddLink(P5)

  P3.AddLink(P1)
  P3.AddLink(P6)
  
  P4.AddLink(P1)
  P4.AddLink(P2)
  P4.AddLink(P6)
  P4.AddLink(P7)
  
  P5.AddLink(P2)
  P5.AddLink(P7)
  P5.AddLink(P2)
  P5.AddLink(P7)
  
  P6.AddLink(PR1)
  P6.AddLink(PR2)
  P6.AddLink(P3)
  P6.AddLink(P4)
  
  P7.AddLink(PR2)
  P7.AddLink(PR3)
  P7.AddLink(P4)
  P7.AddLink(P5)
end

function InitPiece()
  ---- Init Wolf ----
  w1 = PieceManager.CreatePiece("wolf", 622, 87, PR1)
  w2 = PieceManager.CreatePiece("wolf", 622, 205, PR2)
  w3 = PieceManager.CreatePiece("wolf", 622, 323, PR3)
  ----Init Griffon ----
  g1 = PieceManager.CreatePiece("Griffon", 86, 87, PB1)
  g2 = PieceManager.CreatePiece("Griffon", 86, 205, PB2)
  g3 = PieceManager.CreatePiece("Griffon", 86, 323, PB3)
end

function Enigme3Load()
  background = love.graphics.newImage("img/Enigme3/background.png")
  
  sndMark = love.audio.newSource("snd/Enigme3/Switch.wav", "stream")
  sndUnmark = love.audio.newSource("snd/Enigme3/Bomb Place.wav", "stream")
  sndFire = love.audio.newSource("snd/Enigme3/Missile Shoot.wav", "stream")
  
  InitPoint()
  InitPiece()
  
  msg1 = "La couleurs des pièces et des points de déplacement"
  msg2 = "doivent avoir un lien."
end

function Enigme3Update(dt)
  FireManager.Update(dt)
  
  for nPiece = #PieceManager.lstPiece, 1, -1 do
    local piece = PieceManager.lstPiece[nPiece]
    
    piece.choice_flip = piece.choice_flip + .1
    
    ---- Piece Move ----
    if piece.isMove == true then
      piece.x = piece.x + piece.vx * dt
      piece.y = piece.y + piece.vy * dt
      if piece.x >= piece.point.x - 5 and piece.x <= piece.point.x + 5  and piece.y >= piece.point.y - 5 and piece.y <= piece.point.y + 5 then
        move = false
        piece.x = piece.point.x
        piece.y = piece.point.y
        for nLink = #piece.point.lstLink, 1, -1 do
          local link = piece.point.lstLink[nLink]
          if piece.name == "Griffon" then
            if link.piece.name == "wolf" then
              piece.point.piece = ""
              local angle = math.angle(piece.x,piece.y,piece.oldPoint.x,piece.oldPoint.y)
              piece.vx = 200 * math.cos(angle)
              piece.vy = 200 * math.sin(angle)
              link.piece.enemy = piece
              link.piece.shoot = true
              if piece.x > link.piece.x then
                link.piece.flip = -1
              end
              piece.remove = true
              move = true
            end 
          end
          if piece.name == "wolf" then
            if link.piece.name == "Griffon" then
              piece.point.piece = ""
              local angle = math.angle(piece.x,piece.y,piece.oldPoint.x,piece.oldPoint.y)
              piece.vx = 200 * math.cos(angle)
              piece.vy = 200 * math.sin(angle)
              link.piece.enemy = piece
              link.piece.shoot = true
              if piece.x < link.piece.x then
                link.piece.flip = -1
              end
              piece.remove = true
              move = false
            end 
          end
        end
        piece.isMove = false
      end
    end
    
    ----- Piece Shoot ----
    if piece.shoot == true then
      piece.shootTimer = piece.shootTimer - dt
      if piece.shootTimer <= 0 then
        local angle = math.angle(piece.x,piece.y,piece.enemy.x,piece.enemy.y)
        vx = 100 * math.cos(angle)
        vy = 100 * math.sin(angle)
        if piece.name == "wolf" then
          FireManager.CreateFire("blue", piece.x - 30, piece.y, vx, vy, sndFire)
        else
          FireManager.CreateFire("red", piece.x + 10, piece.y, vx, vy, sndFire)
        end
        piece.shootTimer = piece.shootSpeed
      end
      if #FireManager.lstFire > 9 then
        piece.shoot = false
        move = false
        piece.flip = 1
      end
    end
    
    ---- Piece Remove ----
    if piece.remove == true and #FireManager.lstFire > 5 then
      piece.x = piece.x + piece.vx * dt
      piece.y = piece.y + piece.vy * dt
      if piece.x >= piece.oldPoint.x - 5 and piece.x <= piece.oldPoint.x + 5  and piece.y >= piece.oldPoint.y - 5 and piece.y <= piece.oldPoint.y then
        piece.x = piece.oldPoint.x
        piece.y = piece.oldPoint.y
        piece.point = piece.oldPoint
        piece.point.piece = piece
        piece.remove = false
      end
    end
  end
  
  if w1.point.color == "Blue" and w2.point.color == "Blue" and w3.point.color == "Blue" and g1.point.color == "Red" and g2.point.color == "Red" and g3.point.color == "Red" then
    etatEnigme = "Enigme 2"
    finenigme3 = true
  end
end

function Enigme3Draw()
  love.graphics.draw(background)
  --PointManager.Draw()
  PieceManager.Draw()
  FireManager.Draw()
  love.graphics.draw(retour.sprite, retour.x, retour.y, 0, 0.5, 0.5, retour.w/2, retour.h/2)
end
function Enigme3DrawPrint()
  love.graphics.setColor(0, 0, 0)
  love.graphics.print(msg1, 20, 410)
  love.graphics.print(msg2, 20, 440)
  love.graphics.setColor(255, 255, 255)
end

function Enigme3MousePressed(x, y, button)
  if button == 1 then
    if x > retour.x - retour.w/2 and x < retour.x + retour.w/2 and y > retour.y - retour.h/2 and y < retour.y + retour.h/2 then
      etatEnigme = "Enigme 2"
    end
    
    for nPoint = #PointManager.lstPoint, 1, -1 do
      local point = PointManager.lstPoint[nPoint]

      
      for nPiece = #PieceManager.lstPiece, 1, -1 do
        local piece = PieceManager.lstPiece[nPiece]
        
        ---- Moved Piece ----
        for nLink = #piece.point.lstLink, 1, -1 do
          local link = piece.point.lstLink[nLink]
          if link.name == point.name then
            --print("Nom lien = "..link.name.." Nom Point = "..point.name)
            if piece.isSelect and point.piece == "" and x >= point.x - point.rad and x <= point.x + point.rad and y >= point.y - point.rad and y <= point.y + point.rad then
              sndUnmark:play()
              piece.isMove = true
              local angle = math.angle(piece.x,piece.y,point.x,point.y)
              piece.vx = 200 * math.cos(angle)
              piece.vy = 200 * math.sin(angle)
              point.piece = piece
              piece.oldPoint = piece.point
              piece.point.piece = ""
              piece.point = point
              piece.isSelect = false
              
              move = true
            end
          end
        end
        
        ---- Selected Piece ----
        if move == false and x > piece.x - piece.width/2 and x < piece.x + piece.width/2 and y > piece.y - piece.height/2 and y < piece.y + piece.height/2 then
          if piece.isSelect == false then
            sndMark:play()
            piece.isSelect = true
          else
            piece.isSelect = false
          end
          for bPiece = #PieceManager.lstPiece, 1, -1 do
            local otherPiece = PieceManager.lstPiece[bPiece]
            if otherPiece ~= piece then
              otherPiece.isSelect = false
            end
          end
        end
      end
    end
  end
end