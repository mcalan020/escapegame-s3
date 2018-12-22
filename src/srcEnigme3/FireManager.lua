local FireManager = {}

FireManager.lstFire = {}

FireManager.CreateFire = function(pType, pX, pY, pVx, pVy, pSound)
  local fire = {}
  
  fire.type = pType
  fire.sprite = love.graphics.newImage("img/Enigme3/Fire_"..fire.type..".png")
  
  fire.frame = 1
  fire.animationSpeed = 1/6
  fire.animationTimer = fire.animationSpeed
  
  fire.quad = {}
  local y = 0
  for n=1, 4 do
    fire.quad[n] = love.graphics.newQuad(0, y, 32, 32, 32, 128)
    y = y + 32
  end
  
  fire.x = pX
  fire.y = pY
  fire.vx = pVx
  fire.vy = pVy
  
  fire.life = 100
  
  pSound:play()
  
  table.insert(FireManager.lstFire, fire)
  return fire
end

FireManager.Update = function(dt)
  for nFire = #FireManager.lstFire, 1, -1 do
    local fire = FireManager.lstFire[nFire]
    
    fire.x = fire.x + fire.vx*dt
    fire.y = fire.y + fire.vy*dt
    
    fire.animationTimer = fire.animationTimer - dt
    if fire.animationTimer <= 0 then
      fire.frame = fire.frame + 1
      fire.animationTimer = fire.animationSpeed 
      if fire.frame == 4 then
        fire.frame = 1
      end
    end
    
    fire.life = fire.life - 1
    if fire.life <= 0 then
      table.remove(FireManager.lstFire, nFire)
    end
  end
end

FireManager.Draw = function()
  for nFire = 1, #FireManager.lstFire do
    local fire = FireManager.lstFire[nFire]
    love.graphics.draw(fire.sprite, fire.quad[fire.frame], fire.x, fire.y - 25)
  end
end

return FireManager