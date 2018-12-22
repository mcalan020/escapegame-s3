local ParticleManager = {}

ParticleManager.lstParticle = {}

--Reset la liste des Particules
ParticleManager.Reset = function()
  ParticleManager.lstParticle = {}
end

ParticleManager.CreeExplosion = function(pType, pX, pY)
  if pType == "pickup" then
    for n=1,30 do
      ParticleManager.CreeParticle(pType, pX, pY, math.random(-30,30)/10,math.random(-30,30)/10,math.random(25,35))
    end
  end
end

ParticleManager.CreeParticle = function(pType, pX, pY, pVx, pVy, pLife)
  
  if pLife == nil then
    pLife = 50
  end
  
  local particle = {}
  particle.type = pType
  particle.x = pX
  particle.y = pY
  particle.vx = pVx
  particle.vy = pVy
  particle.life = pLife
  particle.supprime = false
  table.insert(ParticleManager.lstParticle, particle)
  
  particle.Anime = function(dt)
  end
  
  particle.Deplace = function(dt)
    -- Application de la vélocité
    particle.x = particle.x + particle.vx * (dt*20)
    particle.y = particle.y + particle.vy * (dt*20)
    particle.life = particle.life - 1
    if particle.life < 0 then
      particle.supprime = true
    end
  end
  
  return particle
  
end

ParticleManager.Update = function(dt)
  for nParticule=#ParticleManager.lstParticle,1,-1 do
    local particle = ParticleManager.lstParticle[nParticule]
       
    if particle.supprime == true then
      table.remove(ParticleManager.lstParticle,nParticule)
    end
    
    particle.Deplace(dt)
    particle.Anime(dt)
  end
end

ParticleManager.Draw = function()
  for nParticle=1,#ParticleManager.lstParticle do
    local particle = ParticleManager.lstParticle[nParticle]
    --love.graphics.draw(frame, s.x, s.y, 0, s.flip, 1, s.l/2, s.h/2)
    if particle.type == "pickup" then 
      love.graphics.setColor(255, 255, 255)
      love.graphics.circle("fill",particle.x,particle.y,1)
    end
    love.graphics.setColor(255, 255, 255)
  end
end

return ParticleManager