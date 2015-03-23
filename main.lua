
display.setStatusBar( display.HiddenStatusBar )
math.randomseed( os.time() )


--Variaveis
_W = display.contentWidth
_H = display.contentHeight
_W2 = display.contentCenterX
_H2 = display.contentCenterY
local scroll = 3 --velocidade do BG
local impulse = - 50 --faz o aviao subir
local up = false --determinina se o aviao vai para cima
local blockTime -- tempo do block
local speed = 1 -- velocidade os obstaculos
local tm -- Mé Henrique cancelar a criação de Blocos


--Iniciando a Fisica
local physics = require( "physics")
physics.start()
--physics.setDrawMode("hybrid")


--add Imagens do BG
local bg1 = display.newImageRect("image/bg02.png", _W, _H)
bg1.x = _W2 
bg1.y = _H2
 
local bg2 = display.newImageRect("image/bg02.png", _W, _H)
bg2.x = bg1.x + _W
bg2.y = _H2

local bg3 = display.newImageRect("image/bg02.png", _W, _H)
bg3.x = bg2.x + _W
bg3.y = _H2


--add Teto e piso
local teto = display.newRect( _W2, -1, _W+100, 1 )
teto:setFillColor( 0,0,0 )
physics.addBody( teto, "static" )

local piso = display.newRect( _W2, _H, _W+100, 0.1 )
piso:setFillColor( 0, 0, 0 )
physics.addBody( piso, "static" )

-- add o avião
local aviao = display.newImage( "image/aviao.png")
physics.addBody(aviao)
aviao.x = 50
aviao.y = _H2

--Criando o Score
local score = display.newText('0', 300, 300, native.systemFontBold, 14)
score:setTextColor(255, 255, 255)

local blocks = display.newGroup()

--add som do aviao
--[[local somAviao = audio.loadStream( "sound/biplaneflying01.mp3" )
local somAviaoLoop = audio.play( somAviao, {channel=1, loops=-1} )--]]

--Som do BG
local somBG = audio.loadStream( "sound/Jumpshot _Eric Skiff.mp3" )
local somBGLoop = audio.play( somBG, {channel=2, loops=-1} )

local function bgScroll (event)

bg1.x = bg1.x - scroll
bg2.x = bg2.x - scroll
bg3.x = bg3.x - scroll

	-- Movendo as imagens para o fim da tela
if (bg1.x + bg1.contentWidth) < 0 then
bg1:translate( _W * 3, 0 )
end
if (bg2.x + bg2.contentWidth) < 0 then
bg2:translate( _W * 3, 0 )
end
if (bg3.x + bg3.contentWidth) < 0 then
bg3:translate( _W * 3, 0 )
end
end

--Função que ataulizada o movimento para cima
local function movePlayer(event)
  if(event.phase == 'began') then
    up = true
  end
  if(event.phase == 'ended') then
    up = false
    impulse = - 50
  end
end

--cria os obstaculos
local function createBlocks(event)

 local passaro = display.newImage("image/passaro.png")    
  passaro.x = _W
  passaro.y = math.random( _H - 20 )
  passaro.name = 'passaro'
  physics.addBody(passaro, "kinematic") 
  passaro.isSensor = true
  blocks:insert( passaro )
end


local function update(event)
  -- Move o avião para cima
  if(up) then
    impulse = impulse - 3
    aviao:setLinearVelocity(0, impulse)
  end
  --move os obstaculos
    if(blocks ~= nil)then
    for i = 1, blocks.numChildren do
      blocks[i].x = blocks[i].x - speed
    end
  end
  --incrementando o score
  score.text = tostring(tonumber(score.text) + 1)
end

local function velocidade()

  speed = speed + 1

  
end

local function alert()
  local gameover = display.newText( "GAME OVER", _W2, _H2, native.systemFontBold, 40)
  gameover.x = _W2
  gameover.y = _H2  
  --para a fisica depois de um tempo
  
end 


local function onCollision(event)
  display.remove(aviao)
  bg1:removeEventListener( 'touch', movePlayer )
  bg2:removeEventListener( 'touch', movePlayer )
  bg3:removeEventListener( 'touch', movePlayer )
  Runtime:removeEventListener( 'enterFrame', bgScroll )
  Runtime:removeEventListener( 'enterFrame', update )
  timer.cancel( tm )
  audio.stop( 2 )
  display.remove(passaro)
  alert()
end


bg1:addEventListener( 'touch', movePlayer )
bg2:addEventListener( 'touch', movePlayer )
bg3:addEventListener( 'touch', movePlayer )
Runtime:addEventListener( 'enterFrame', update )
Runtime:addEventListener( 'enterFrame', bgScroll )
tm = timer.performWithDelay( 1500, createBlocks, 0 )
aviao:addEventListener( 'collision', onCollision )
timer.performWithDelay( 5000, velocidade, 0 )


    

