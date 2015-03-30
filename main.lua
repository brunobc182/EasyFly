
display.setStatusBar( display.HiddenStatusBar )
math.randomseed( os.time() )

--Variaveis
_W = display.contentWidth
_H = display.contentHeight
_W2 = display.contentCenterX
_H2 = display.contentCenterY

local titleBg
local playBtn
local titleView
local aviao
local bg1
local bg2
local bg3
local blocks
local scroll = 2 --velocidade do BG
local impulse = - 60 --faz o aviao subir
local up = false --determinina se o aviao vai para cima
local blockTime -- tempo do block
local speed = 1 -- velocidade os obstaculos
local tm --cancelar a criação de Blocos
local speedTm -- amumentar velocidade dos passaros

--add funções

local Main = {}
local startButtonListeners = {}
local showGameView = {}
local bgScroll = {}
local movePlayer = {}
local createBlocks = {}
local velocidade = {}
local update = {}
local alert = {}


--add som do aviao
--[[local somAviao = audio.loadStream( "sound/biplaneflying01.mp3" )
local somAviaoLoop = audio.play( somAviao, {channel=1, loops=-1} )--]]

--Som do BG
local somBG = audio.loadStream( "sound/Jumpshot _Eric Skiff.mp3" )

--Iniciando a Fisica
local physics = require( "physics")
physics.start()
--physics.setDrawMode("hybrid")

function Main()

  titleBg = display.newImageRect('image/mainscreen.png', _W, _H)
  titleBg.x = _W2
  titleBg.y = _H2
  
  playBtn = display.newImage('image/play.png')
  playBtn.x = _W2
  playBtn.y = 200
  titleView = display.newGroup(titleBg, playBtn)  
  startButtonListeners('add')
end

function startButtonListeners(action)
  if(action == 'add') then
    playBtn:addEventListener('tap', showGameView)
  else
    playBtn:removeEventListener('tap', showGameView)
  end
end

function showGameView:tap(e)
  transition.to(titleView, {time = 300, x = -titleView.height, onComplete = function() startButtonListeners('rmv') 
    display.remove(titleView) titleView = nil end})
  
--add Imagens do BG
bg1 = display.newImageRect("image/bg02.png", _W, _H)
bg1.x = 0 
bg1.y = _H2
 
bg2 = display.newImageRect("image/bg02.png", _W, _H)
bg2.x = bg1.x + _W
bg2.y = _H2

bg3 = display.newImageRect("image/bg02.png", _W, _H)
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
aviao = display.newImage( "image/aviao.png")
physics.addBody(aviao)
aviao.x = 50
aviao.y = _H2

--Criando o Score
score = display.newText('0', _W2, 300, native.systemFontBold, 20)
score:setTextColor(255, 255, 255)

blocks = display.newGroup()
gameListeners('add')
audio.play(somBG, {loops = -1, channel = 1})

--msg de intrução
ins = display.newImage('image/ins.png', _W2, _H2)
  transition.from(ins, {time = 200, alpha = 0.1, onComplete = function() timer.performWithDelay(2000, function() 
    transition.to(ins, {time = 200, alpha = 0.1, onComplete = function() display.remove(ins) ins = nil end}) end) end})
end 

function gameListeners(action)
  if(action == 'add') then
    bg1:addEventListener( 'touch', movePlayer )
    bg2:addEventListener( 'touch', movePlayer )
    bg3:addEventListener( 'touch', movePlayer )
    Runtime:addEventListener( 'enterFrame', update )
    Runtime:addEventListener( 'enterFrame', bgScroll )
    aviao:addEventListener( 'collision', onCollision )
    tm = timer.performWithDelay( 1300, createBlocks, 0 )   
    speedTm = timer.performWithDelay( 5000, velocidade, 5 )
  
  else
    bg1:removeEventListener( 'touch', movePlayer )
    bg2:removeEventListener( 'touch', movePlayer )
    bg3:removeEventListener( 'touch', movePlayer )
    Runtime:removeEventListener('enterFrame', update)
    Runtime:removeEventListener( 'enterFrame', bgScroll )
    timer.cancel(tm)
    tm = nil
    timer.cancel( speedTm )
    speedTm = nil
    aviao:removeEventListener('collision', onCollision)
  end
end

function bgScroll (event)

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
function movePlayer(event)
  if(event.phase == 'began') then
    up = true
  end
  if(event.phase == 'ended') then
    up = false
    impulse = - 50
  end
end

--cria os obstaculos
function createBlocks(event)

 local passaro = display.newImage("image/passaro.png")    
  passaro.x = _W
  passaro.y = math.random( _H - 20 )
  passaro.name = 'passaro'
  physics.addBody(passaro, "kinematic") 
  passaro.isSensor = true
  blocks:insert( passaro )
end

function update(event)
  
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

function velocidade()
  speed = speed + 1

  --Icon
  local icon = display.newImage('image/speed.png', _W2 , _H2)
  transition.from(icon, {time = 200, alpha = 0.1, onComplete = function() timer.performWithDelay(500, function() 
    transition.to(icon, {time = 200, alpha = 0.1, onComplete = function() display.remove(icon) icon = nil end}) end) end})
end



local function alert()
  local gameover = display.newText( "GAME OVER", _W2, _H2, native.systemFontBold, 50)
  gameover.x = _W2
  gameover.y = _H2 
  gameListeners('rmv')
  --para a fisica depois de um tempo
  
end 

-- função que para o audio, remove o avião e mostra o GAME OVER ao colidir em algo
function onCollision(event)
  audio.stop( 1 )
  display.remove( aviao )
  alert()
end

Main()



    

