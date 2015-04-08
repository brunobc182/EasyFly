local composer = require("composer")
local scene = composer.newScene( )
local physycs = require( "physics")
physics.start( )
physics.setDrawMode( "hybrid")

local aviao
local bg1
local bg2
local bg3
local blocks --criação de blocos
local scroll = 2 --velocidade do BG
local impulse = - 60 --faz o aviao subir
local up = false --determinina se o aviao vai para cima
local blockTime -- tempo do block
local speed = 1 -- velocidade os obstaculos
local tm --cancelar a criação de Blocos
local speedTm -- amumentar velocidade dos passaros
local numberOfLives = 1

--add funções
local bgScroll = {}
local movePlayer = {}
local createBlocks = {}
local velocidade = {}
local update = {}
local scoreUp = {}
local gameOver = {}
local onCollision = {}



function scene:create( event )
  local sceneGroup = self.view
  setupBG()
  setupGroups()
  setupPlayer()
  setupIns()
  setupScore()
  --add som do aviao
  --[[local somAviao = audio.loadStream( "sound/biplaneflying01.mp3" )
  local somAviaoLoop = audio.play( somAviao, {channel=1, loops=-1} )--]]

  --Som do BG
  local somBG = audio.loadStream( "sound/Jumpshot _Eric Skiff.mp3" )
  audio.play(somBG, {loops = -1, channel = 1})  

end 


function scene:show( event )
  local sceneGroup = self.view
  local phase = event.phase

  
    local previousScene = composer.getSceneName( "previous" )
    composer.removeScene( previousScene )
   
    if (phase == "did") then    
      bg1:addEventListener( 'touch', movePlayer )
      bg2:addEventListener( 'touch', movePlayer )
      bg3:addEventListener( 'touch', movePlayer )
      tm = timer.performWithDelay( 1500, createBlocks, 0 )
      Runtime:addEventListener("enterFrame", gameLoop)
      Runtime:addEventListener("collision", onCollision)
      speedTm = timer.performWithDelay( 5000, velocidade, 0 )
      end
end

function scene:hide( event )
  local sceneGroup = self.view
  local phase = event.phase

  if (phase == "will") then 
    bg1:removeEventListener( 'touch', movePlayer )
    bg2:removeEventListener( 'touch', movePlayer )
    bg3:removeEventListener( 'touch', movePlayer )
    Runtime:removeEventListener('enterFrame',gameLoop)
    Runtime:removeEventListener('collision', onCollision) 
    timer.cancel(tm)
    tm = nil
    timer.cancel( speedTm )
    speedTm = nil 
    elseif (phase == "did") then
    end
end

function setupBG( )
  --add Imagens do BG
bg1 = display.newImageRect("image/bg02.png", _W, _H)
bg1.x = 0 
bg1.y = _H2
scene.view:insert( bg1 )

bg2 = display.newImageRect("image/bg02.png", _W, _H)
bg2.x = bg1.x + _W
bg2.y = _H2
scene.view:insert( bg2 )

bg3 = display.newImageRect("image/bg02.png", _W, _H)
bg3.x = bg2.x + _W
bg3.y = _H2
scene.view:insert( bg3 )
--add Teto e piso
teto = display.newRect( _W2, -1, _W+100, 1 )
teto:setFillColor( 0,0,0 )
physics.addBody( teto, "static" )
teto.name = "teto"
scene.view:insert( teto )

piso = display.newRect( _W2, _H, _W+100, 0.1 )
piso:setFillColor( 0, 0, 0 )
physics.addBody( piso, "static" )
piso.name = "piso"
scene.view:insert( piso )
end

function setupGroups( )
  blocks = display.newGroup()
  aviaoGroup = display.newGroup( )
  scene.view:insert( blocks )
  scene.view:insert( aviaoGroup )
end

function setupPlayer( )
  aviao = display.newImage( "image/aviao.png")
  physics.addBody(aviao)
  aviao.x = 50
  aviao.y = _H2
  aviao.name = "aviao"
  scene.view:insert( aviao )
end

function setupIns( )
  ins = display.newImage('image/ins.png', _W2, _H2)
  transition.from(ins, {time = 200, alpha = 0.1, onComplete = function() timer.performWithDelay(2000, function() 
    transition.to(ins, {time = 200, alpha = 0.1, onComplete = function() display.remove(ins) ins = nil end}) end) end})
  scene.view:insert( ins)
end

function setupScore( )
  score = display.newText('0', _W2, 300, native.systemFontBold, 20)
  score:setTextColor(255, 255, 255)
  scene.view:insert( score )
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
end


  function moveBlocks()  
   --move os obstaculos
  if(blocks ~= nil)then
    for i = 1, blocks.numChildren do
      blocks[i].x = blocks[i].x - speed
    end
  end
end

  function scoreUp()
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


--função de colisão que chama o gameOver quando o avião colide em algum objeto
function onCollision(event)
    --SNIP--
    if ( event.phase == "began" ) then
        --SNIP--
        
        if(event.object1.name == "aviao" and event.object2.name == "passaro") then            
            gameOver()
        end
         
         if(event.object1.name == "passaro" and event.object2.name == "aviao") then            
            gameOver()
        end
         if(event.object1.name == "aviao" and event.object2.name == "teto") then         
            gameOver()
        end
        if(event.object1.name == "aviao" and event.object2.name == "piso") then            
            gameOver()
        end
        if(event.object1.name == "teto" and event.object2.name == "aviao") then            
            gameOver()
        end
        if(event.object1.name == "piso" and event.object2.name == "aviao") then            
            gameOver()
        end
    end
end


function gameOver(  )
  audio.stop( 1 )
  composer.gotoScene( "gameover" )
end

function gameLoop()
  update()
  moveBlocks()
  scoreUp()
  bgScroll()  
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )

return scene

    
