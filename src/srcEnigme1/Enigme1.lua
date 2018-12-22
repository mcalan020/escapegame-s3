require("srcEnigme2/Enigme2")

local codeFind = false
local chiffre0 = {}
local chiffre1 = {}
local chiffre2 = {}
local chiffre3 = {}
local chiffre4 = {}
local chiffre5 = {}
local chiffre6 = {}
local chiffre7 = {}
local chiffre8 = {}
local chiffre9 = {}

local code_cadenas1 ={}
code_cadenas1.largeur=60
code_cadenas1.hauteur=50
code_cadenas1.X=300
code_cadenas1.Y=290
code_cadenas1.valeur=0

local code_cadenas2 ={}
code_cadenas2.largeur=60
code_cadenas2.hauteur=50
code_cadenas2.X= 385
code_cadenas2.Y=290
code_cadenas2.valeur=0

local code_cadenas3 ={}
code_cadenas3.largeur=60
code_cadenas3.hauteur=50
code_cadenas3.X=470
code_cadenas3.Y=290
code_cadenas3.valeur=0

local image_main = {}
image_main.largeur = 0
image_main.hauteur = 0

local table_de_chevet = {}
table_de_chevet.largeur = 90
table_de_chevet.hauteur = 15
table_de_chevet.X = 380
table_de_chevet.Y = 230

local porte = {}
porte.largeur = 100
porte.hauteur = 255
porte.X = 100
porte.Y = 71

local digit1 = {}
digit1.largeur = 122
digit1.hauteur = 134
digit1.X = 171
digit1.Y = 247

local digit2 = {}
digit2.largeur = 130
digit2.hauteur = 140
digit2.X = 320
digit2.Y = 250

local digit3 = {}
digit3.largeur = 125
digit3.hauteur = 140
digit3.X = 495
digit3.Y = 250


local porte_ouverte = {}
porte_ouverte.largeur = 100
porte_ouverte.hauteur = 255
porte_ouverte.X = 100
porte_ouverte.Y = 71
porte_ouverte.etat = false

local table_de_chevet_dessus = {}
table_de_chevet_dessus.etat = false

local cadenas = {}
cadenas.X = 375
cadenas.Y = 220
cadenas.largeur = 400
cadenas.hauteur = 267
cadenas.etat = false

local bibliotheque = {}
bibliotheque.largeur = 130
bibliotheque.hauteur = 70
bibliotheque.X= 450
bibliotheque.Y= 130
bibliotheque.etat = false

local cercueil = {}
cercueil.largeur = 85
cercueil.hauteur = 240
cercueil.X= 250
cercueil.Y= 78

local cercueil_ouvert = {}
cercueil_ouvert.etat = false

local carte_angleterre = {}
carte_angleterre.largeur = 80
carte_angleterre.hauteur = 100
carte_angleterre.X= 370
carte_angleterre.Y= 30

local carte_angleterre_zoom = {}
carte_angleterre_zoom.etat = false

local bouton_retour = {}
bouton_retour.largeur = 180
bouton_retour.hauteur = 80
bouton_retour.X= 60
bouton_retour.Y= 370
bouton_retour.draw = false
  
local Livres = {}
Livres.largeur = 35
Livres.hauteur = 73
Livres.X= 543
Livres.Y= 135
Livres.etat = false

local DVD = {}
DVD.largeur = 35
DVD.hauteur = 73
DVD.X= 471
DVD.Y= 138
DVD.etat = false

local Valider = {}
Valider.largeur = 85
Valider.hauteur = 90
Valider.X= 650
Valider.Y= 400
Valider.etat = false

local msg = ""
local msg1 = ""

function Enigme1Load()
  main_image = love.graphics.newImage("img/imgEnigme1/chambre.png")
  cercueil.sprite= love.graphics.newImage("img/imgEnigme1/cercueil.png")
  table_de_chevet_dessus.sprite = love.graphics.newImage("img/imgEnigme1/table_de_chevet_dessus.png")
  table_de_chevet.sprite = love.graphics.newImage("img/imgEnigme1/table_de_chevet.png")
  porte.sprite = love.graphics.newImage("img/imgEnigme1/porte.png")
  porte_ouverte.sprite = love.graphics.newImage("img/imgEnigme1/porte_ouverte.png")
  bibliotheque.sprite = love.graphics.newImage("img/imgEnigme1/bibliotheque.png")
  carte_angleterre.sprite = love.graphics.newImage("img/imgEnigme1/carte_angleterre.png")
  carte_angleterre_zoom.sprite = love.graphics.newImage("img/imgEnigme1/carte_angleterre_zoom.png")
  cadenas.sprite = love.graphics.newImage("img/imgEnigme1/cadenas_fond.png")
  DVD.sprite = love.graphics.newImage("img/imgEnigme1/DVD.png")
  Livres.sprite = love.graphics.newImage("img/imgEnigme1/Livres.png")
  code_cadenas1.sprite = love.graphics.newImage("img/imgEnigme1/num_cadena_0.png")
  code_cadenas2.sprite = love.graphics.newImage("img/imgEnigme1/num_cadena_0.png")
  code_cadenas3.sprite = love.graphics.newImage("img/imgEnigme1/num_cadena_0.png")
  cercueil_ouvert.sprite = love.graphics.newImage("img/imgEnigme1/cercueil_ouvert.png")
  bouton_retour.sprite = love.graphics.newImage("img/retour_180_80.png")
  
  chiffre0.sprite= love.graphics.newImage("img/imgEnigme1/num_cadena_0.png")
  chiffre1.sprite= love.graphics.newImage("img/imgEnigme1/num_cadena_1.png")
  chiffre2.sprite= love.graphics.newImage("img/imgEnigme1/num_cadena_2.png")
  chiffre3.sprite= love.graphics.newImage("img/imgEnigme1/num_cadena_3.png")
  chiffre4.sprite= love.graphics.newImage("img/imgEnigme1/num_cadena_4.png")
  chiffre5.sprite= love.graphics.newImage("img/imgEnigme1/num_cadena_5.png")
  chiffre6.sprite= love.graphics.newImage("img/imgEnigme1/num_cadena_6.png")
  chiffre7.sprite= love.graphics.newImage("img/imgEnigme1/num_cadena_7.png")
  chiffre8.sprite= love.graphics.newImage("img/imgEnigme1/num_cadena_8.png")
  chiffre9.sprite= love.graphics.newImage("img/imgEnigme1/num_cadena_9.png")
  
  ItemManager.CreateItem("boulette1", "img/Enigme5/papier_boulette.png", 400, 200, "Enigme 1", false)
  
  msg = "Cette décoration me rappelle de vagues souvenirs."
  msg1 = ""
end


local rx = bouton_retour.X
local ry = bouton_retour.Y
function Enigme1Update(dt, souris_x, souris_y)
  
  if souris_x > bouton_retour.X - bouton_retour.largeur/2 and souris_x < bouton_retour.X + bouton_retour.largeur/2 and 
     souris_y > bouton_retour.Y - bouton_retour.hauteur/2 and souris_y < bouton_retour.Y + bouton_retour.hauteur/2 then
    if bouton_retour.X < rx + 2 and bouton_retour.Y > ry - 2  then
      bouton_retour.X = bouton_retour.X + 2
      bouton_retour.Y = bouton_retour.Y - 2
    end
  else
    bouton_retour.X = rx
    bouton_retour.Y = ry
  end
  
  if love.mouse.isDown(1) then
    if cercueil_ouvert.etat == false and carte_angleterre_zoom.etat == false and cadenas.etat == false and DVD.etat == false and Livres.etat == false then
      if  souris_x > table_de_chevet.X and souris_x < (table_de_chevet.X+table_de_chevet.largeur) and
          souris_y > (table_de_chevet.Y) and souris_y < (table_de_chevet.Y+table_de_chevet.hauteur) then
            table_de_chevet_dessus.etat = true
            bouton_retour.draw = true
      end
    end
    
    if table_de_chevet_dessus.etat == false and carte_angleterre_zoom.etat == false and cadenas.etat == false and DVD.etat == false and Livres.etat == false then
      if  souris_x > cercueil.X and souris_x < (cercueil.X+cercueil.largeur) and
          souris_y > (cercueil.Y) and souris_y < (cercueil.Y+cercueil.hauteur) then 
            bouton_retour.draw = true
            cercueil_ouvert.etat = true
      end
    end
    
    if table_de_chevet_dessus.etat == false and cercueil_ouvert.etat == false and cadenas.etat == false and DVD.etat == false and Livres.etat == false then
      if  souris_x > carte_angleterre.X and souris_x < (carte_angleterre.X+carte_angleterre.largeur) and
          souris_y > (carte_angleterre.Y) and souris_y < (carte_angleterre.Y+carte_angleterre.hauteur) then 
            bouton_retour.draw = true
            carte_angleterre_zoom.etat = true
      end
    end
    
    if table_de_chevet_dessus.etat == false and cercueil_ouvert.etat == false and carte_angleterre_zoom.etat == false
    and DVD.etat == false and Livres.etat == false and porte_ouverte.etat==false then
      if  souris_x > 183 and souris_x < 183 + 25 and
          souris_y > 210 and souris_y < 210 + 25 then
            bouton_retour.draw = true
            cadenas.etat = true
      end
    end
    
    if table_de_chevet_dessus.etat == false and cercueil_ouvert.etat == false and carte_angleterre_zoom.etat == false and cadenas.etat == false and Livres.etat == false then
      if  souris_x > DVD.X and souris_x < (DVD.X+DVD.largeur) and
          souris_y > (DVD.Y) and souris_y < (DVD.Y+DVD.hauteur) then
            bouton_retour.draw = true
            DVD.etat = true
      end
    end
    
    if table_de_chevet_dessus.etat == false and cercueil_ouvert.etat == false and carte_angleterre_zoom.etat == false and cadenas.etat == false and DVD.etat == false then
      if  souris_x > Livres.X and souris_x < (Livres.X+Livres.largeur) and
          souris_y > (Livres.Y) and souris_y < (Livres.Y+Livres.hauteur) then
            bouton_retour.draw = true
            Livres.etat = true
      end
    end
    
    if souris_x > porte_ouverte.X and souris_x < porte_ouverte.X + porte_ouverte.largeur and
       souris_y > porte_ouverte.Y and souris_y < porte_ouverte.Y + porte_ouverte.hauteur and
       porte_ouverte.etat then
      etatEnigme = "Enigme 2"
      if enigme2dejavu == false then
        Enigme2Load()
        enigme2dejavu = true
      end
    end
    
    if souris_x > bouton_retour.X - bouton_retour.largeur/2 and souris_x < bouton_retour.X + bouton_retour.largeur/2 and
       souris_y > bouton_retour.Y - bouton_retour.hauteur/2 and souris_y < bouton_retour.Y + bouton_retour.hauteur/2
       and bouton_retour.draw==true then
        bibliotheque.etat=false
        DVD.etat=false
        cadenas.etat=false
        Livres.etat=false
        carte_angleterre_zoom.etat=false
        table_de_chevet_dessus.etat=false
        cercueil_ouvert.etat=false
        bouton_retour.draw = false
    end
  end
  
  for nItem=#ItemManager.lstItem, 1, -1 do
    local item = ItemManager.lstItem[nItem]
    if item.name == "boulette1" and table_de_chevet_dessus.etat then
      item.iTake = true
    end
  end
  
  if cadenas.etat then
    msg = "Un code ! Il doit être lié à cette décoration."
    msg1 = ""
  elseif cercueil_ouvert.etat then
    msg = "Ce costume ressemble étrangement à celui"
    msg1 = "des agents secrets anglais."
  elseif Livres.etat then
    msg = "Ces livres me rappellent mon enfance!"
    msg1 = "Ils parlent d'un agent secret londonnien."
  elseif DVD.etat then
    msg = "Ah ! Ces fameux film joués par Daniel Craig."
    msg1 = ""
  elseif carte_angleterre_zoom.etat then
    msg = "L'Angleterre, le repaire de M s'y trouve."
    msg1 = ""
  elseif table_de_chevet_dessus.etat then
    msg = "'Military Intelligence, section 6',"
    msg1 = "c'est le service de renseignements extérieurs du Royaume-Uni."
  elseif porte_ouverte.etat then
    msg = "Oh ! La porte est ouverte !"
    msg1 = ""
  else
    msg = "Cette décoration me rappelle de vagues souvenirs."
    msg1 = ""
  end
end

function Enigme1Draw()
  
    love.graphics.draw(main_image)
    love.graphics.draw(carte_angleterre.sprite,carte_angleterre.X,carte_angleterre.Y)
    love.graphics.draw(porte.sprite,porte.X,porte.Y)
    love.graphics.draw(table_de_chevet.sprite,table_de_chevet.X,table_de_chevet.Y)
    love.graphics.draw(bibliotheque.sprite,bibliotheque.X,bibliotheque.Y)
    love.graphics.draw(cercueil.sprite,cercueil.X,cercueil.Y)

    if table_de_chevet_dessus.etat == true then
      love.graphics.draw(table_de_chevet_dessus.sprite)
      ItemManager.DrawOneItem("boulette1")
    end 
    if carte_angleterre_zoom.etat == true then
      love.graphics.draw(carte_angleterre_zoom.sprite)
    end
    if cercueil_ouvert.etat == true then
      love.graphics.draw(cercueil_ouvert.sprite)
    end
    if DVD.etat == true then
      love.graphics.draw(DVD.sprite)
    end 
    if Livres.etat == true then
      love.graphics.draw(Livres.sprite)
    end 
    if bouton_retour.draw == true then
      love.graphics.draw(bouton_retour.sprite, bouton_retour.X, bouton_retour.Y, 0, 0.5, 0.5, bouton_retour.sprite:getWidth()/2, bouton_retour.sprite:getHeight()/2)
    end
    
    if code_cadenas1.valeur==0 and
        code_cadenas2.valeur==0 and
        code_cadenas3.valeur==7 then
          cadenas.etat=false
          porte_ouverte.etat = true
          bouton_retour.draw = false
          code_cadenas3.valeur=0
    end
    if porte_ouverte.etat==true and table_de_chevet_dessus.etat == false and cercueil_ouvert.etat == false and 
    carte_angleterre_zoom.etat == false and cadenas.etat == false and DVD.etat == false and Livres.etat == false then
      love.graphics.draw(porte_ouverte.sprite,porte_ouverte.X,porte_ouverte.Y)
    end
    
    if cadenas.etat == true then
      love.graphics.draw(cadenas.sprite, cadenas.X, cadenas.Y, 0, 1, 1, cadenas.sprite:getWidth()/2, cadenas.sprite:getHeight()/2)
      love.graphics.draw(code_cadenas1.sprite,code_cadenas1.X,code_cadenas1.Y, 0, 0.5, 0.5, code_cadenas1.sprite:getWidth()/2, code_cadenas1.sprite:getHeight()/2)
      love.graphics.draw(code_cadenas2.sprite,code_cadenas2.X,code_cadenas2.Y, 0, 0.5, 0.5, code_cadenas2.sprite:getWidth()/2, code_cadenas2.sprite:getHeight()/2)
      love.graphics.draw(code_cadenas3.sprite,code_cadenas3.X,code_cadenas3.Y, 0, 0.5, 0.5, code_cadenas3.sprite:getWidth()/2, code_cadenas3.sprite:getHeight()/2)
    end
end

function Enigme1DrawPrint()
  love.graphics.setColor(0, 0, 0)
  love.graphics.print(msg, 20, 410)
  love.graphics.print(msg1, 20, 440)
  love.graphics.setColor(255, 255, 255)
end

function Enigme1MousePressed( x, y, button)
  if button==1 then
    if  x > code_cadenas1.X - code_cadenas1.largeur/2 and x < code_cadenas1.X + code_cadenas1.largeur/2 and
        y > code_cadenas1.Y - code_cadenas1.hauteur/2 and y < code_cadenas1.Y + code_cadenas1.hauteur/2 and cadenas.etat == true  then 
          code_cadenas1.valeur=code_cadenas1.valeur+1
          if code_cadenas1.valeur==1 then code_cadenas1.sprite=chiffre1.sprite end
          if code_cadenas1.valeur==2 then code_cadenas1.sprite=chiffre2.sprite end
          if code_cadenas1.valeur==3 then code_cadenas1.sprite=chiffre3.sprite end
          if code_cadenas1.valeur==4 then code_cadenas1.sprite=chiffre4.sprite end
          if code_cadenas1.valeur==5 then code_cadenas1.sprite=chiffre5.sprite end
          if code_cadenas1.valeur==6 then code_cadenas1.sprite=chiffre6.sprite end
          if code_cadenas1.valeur==7 then code_cadenas1.sprite=chiffre7.sprite end
          if code_cadenas1.valeur==8 then code_cadenas1.sprite=chiffre8.sprite end
          if code_cadenas1.valeur==9 then code_cadenas1.sprite=chiffre9.sprite end
          if code_cadenas1.valeur==10 then code_cadenas1.sprite=chiffre0.sprite end
          if code_cadenas1.valeur==10 then code_cadenas1.valeur=0 end
    end
    
    if  x > code_cadenas2.X - code_cadenas2.largeur/2 and x < code_cadenas2.X + code_cadenas2.largeur/2 and
        y > code_cadenas2.Y - code_cadenas2.hauteur/2 and y < code_cadenas2.Y + code_cadenas2.hauteur/2 and cadenas.etat == true  then 
          code_cadenas2.valeur=code_cadenas2.valeur+1
          if code_cadenas2.valeur==1 then code_cadenas2.sprite=chiffre1.sprite end
          if code_cadenas2.valeur==2 then code_cadenas2.sprite=chiffre2.sprite end
          if code_cadenas2.valeur==3 then code_cadenas2.sprite=chiffre3.sprite end
          if code_cadenas2.valeur==4 then code_cadenas2.sprite=chiffre4.sprite end
          if code_cadenas2.valeur==5 then code_cadenas2.sprite=chiffre5.sprite end
          if code_cadenas2.valeur==6 then code_cadenas2.sprite=chiffre6.sprite end
          if code_cadenas2.valeur==7 then code_cadenas2.sprite=chiffre7.sprite end
          if code_cadenas2.valeur==8 then code_cadenas2.sprite=chiffre8.sprite end
          if code_cadenas2.valeur==9 then code_cadenas2.sprite=chiffre9.sprite end
          if code_cadenas2.valeur==10 then code_cadenas2.sprite=chiffre0.sprite end
          if code_cadenas2.valeur==10 then code_cadenas2.valeur=0 end
    end
    
    if  x > code_cadenas3.X - code_cadenas3.largeur/2 and x < code_cadenas3.X + code_cadenas3.largeur/2 and
        y > code_cadenas3.Y - code_cadenas3.hauteur/2 and y < code_cadenas3.Y + code_cadenas3.hauteur/2 and cadenas.etat == true  then 
          code_cadenas3.valeur=code_cadenas3.valeur+1
          if code_cadenas3.valeur==1 then code_cadenas3.sprite=chiffre1.sprite end
          if code_cadenas3.valeur==2 then code_cadenas3.sprite=chiffre2.sprite end
          if code_cadenas3.valeur==3 then code_cadenas3.sprite=chiffre3.sprite end
          if code_cadenas3.valeur==4 then code_cadenas3.sprite=chiffre4.sprite end
          if code_cadenas3.valeur==5 then code_cadenas3.sprite=chiffre5.sprite end
          if code_cadenas3.valeur==6 then code_cadenas3.sprite=chiffre6.sprite end
          if code_cadenas3.valeur==7 then code_cadenas3.sprite=chiffre7.sprite end
          if code_cadenas3.valeur==8 then code_cadenas3.sprite=chiffre8.sprite end
          if code_cadenas3.valeur==9 then code_cadenas3.sprite=chiffre9.sprite end
          if code_cadenas3.valeur==10 then code_cadenas3.sprite=chiffre0.sprite end
          if code_cadenas3.valeur==10 then code_cadenas3.valeur=0 end
    end
  end
end