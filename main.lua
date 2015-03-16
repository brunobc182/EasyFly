
display.setStatusBar( display.HiddenStatusBar )
math.randomseed( os.time() )


--Variaveis
_W = display.contentWidth
_H = display.contentHeight
local scroll = 3 --velocidade do BG
local impulse = - 50 --faz o aviao subir
local up = false --determinina se o aviao vai para cima
local blockTime -- tempo do block
local speed = 5 -- velocidade os obstaculos





--Iniciando a Fisica
local physics = require( "physics")
physics.start()
--physics.setDrawMode("hybrid")

--add Imagens do BG
local bg1 = display.newImageRect("image/bg02.png", _W, _H)
bg1.x = _W/2 
bg1.y = _H/2
 
local bg2 = display.newImageRect("image/bg02.png", _W, _H)
bg2.x = bg1.x + _W
bg2.y = _H/2

local bg3 = display.newImageRect("image/bg02.png", _W, _H)
bg3.x = bg2.x + _W
bg3.y = _H/2


--add Teto e piso
local teto = display.newRect( _W/2, 0, _W+50, 1 )
teto:setFillColor( 0,0,0 )
physics.addBody( teto, "static" )

local piso = display.newRect( _W/2, _H, _W+50, 0.1 )
piso:setFillColor( 0, 0, 0 )
physics.addBody( piso, "static" )

-- add o avião
local aviao = display.newImage( "image/aviao.png")
physics.addBody(aviao)
aviao.x = 50
aviao.y = _H / 2


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
 local passaro  
  passaro = display.newImage( "image/passaro.png ")
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
end

local function alert()
  local gameover = display.newText( "GAME OVER", _W/2, _H/2, native.systemFontBold, 40)
  gameover.x = _W/2
  gameover.y = _H/2  
  --para a fisica depois de um tempo
  timer.performWithDelay(1000, function() physics.stop() end, 1)
end 

local function onCollision(event)
  display.remove(aviao)
  alert()  
end




bg1:addEventListener( 'touch', movePlayer )
bg2:addEventListener( 'touch', movePlayer )
bg3:addEventListener( 'touch', movePlayer )
Runtime:addEventListener( 'enterFrame', update )
Runtime:addEventListener( 'enterFrame', bgScroll )
timer.performWithDelay(1300, createBlocks, 0)
aviao:addEventListener( 'collision', onCollision )


    

