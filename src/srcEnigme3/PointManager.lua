local PointManager = {}

PointManager.lstPoint = {}

PointManager.CreatePoint = function(pName, pColor, pX, pY)
  local point = {}  
  
  point.name = pName
  point.color = pColor
  
  point.x = pX
  point.y = pY
  point.rad = 26
  
  point.piece = ""
  
  point.lstLink = {}
  point.AddLink = function(pPoint)
    table.insert(point.lstLink, pPoint)
  end
  
  table.insert(PointManager.lstPoint, point)
  return point
end

PointManager.Draw = function()
  for nPoint = #PointManager.lstPoint, 1, -1 do
    local point = PointManager.lstPoint[nPoint]
    love.graphics.circle("fill", point.x, point.y, 15)
    for nLink = #point.lstLink, 1, -1 do
      link = point.lstLink[nLink]
      love.graphics.line(point.x, point.y, link.x, link.y)
    end
  end
end

return PointManager