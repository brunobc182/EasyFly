
--CRIANDO O MENU DO JOGO

--------------------------------------------------------------------------------------------------------------

local composer = require("composer")
local scene = composer.newScene( )
local menuBG
local playBtn
local creditsBtn
local bestscoresBtn
local scroll = 1
local cloud1
local cloud2
local cloud3
local bg
local easyFlyLogo
local bgScroll = {}



function scene:create( event )
	local sceneGroup = self.view

	setupBG()
	setupGroups()
	
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	if (phase == "will") then		
	elseif (phase == "did") then
		playBtn:addEventListener( "tap", startGame )
		Runtime:addEventListener( "enterFrame", bgScroll )
	end
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase

	if (phase == "will") then
		playBtn:removeEventListener( "tap", startGame )
		Runtime:removeEventListener( "enterFrame", bgScroll )
		end
end

function setupGroups( )
  playerGroup = display.newGroup( )
  scene.view:insert( playerGroup )
end

function setupBG(  )
	bg = display.newImageRect("image/bgAzul.png", _W, _H)
	bg.x = _W2
	bg.y = _H2
	scene.view:insert( bg)

	cloud1 = display.newImage("image/nuvem.png", 300, 25)
	cloud1.x = _W2
	cloud1.y = 50
	scene.view:insert(cloud1)

	cloud2 = display.newImage("image/nuvem.png", 300, 25)
	cloud2.x = cloud1.x + _W
	cloud2.y = 50
	scene.view:insert(cloud2)	

	cloud3 = display.newImage("image/nuvem.png", 300, 25)
	cloud3.x = cloud2.x + _W
	cloud3.y = 50
	scene.view:insert(cloud3)

	easyFlyLogo = display.newImageRect("image/easyflyLogo.png", 300, 75)
	easyFlyLogo.x = _W2
	easyFlyLogo.y = _H2 - 100
	scene.view:insert(easyFlyLogo)
	

	menuBG = display.newImageRect( "image/mainscreenBG.png", _W, 100 )
	menuBG.x = _W2
	menuBG.y = _H - 30
	scene.view:insert(menuBG)	

	playBtn = display.newImageRect( "image/playBtn.png", 100, 25)
	playBtn.x = _W2
	playBtn.y = _H2
	scene.view:insert(playBtn)

	bestscoresBtn = display.newImageRect( "image/bestscoresBtn.png", 100, 25)
	bestscoresBtn.x = _W2
	bestscoresBtn.y = _H2 + 50
	scene.view:insert(bestscoresBtn)

	creditsBtn = display.newImageRect( "image/creditsBtn.png", 100, 25)
	creditsBtn.x = _W2
	creditsBtn.y = _H2 + 100
	scene.view:insert(creditsBtn)

end

function bgScroll (event)
cloud1.x = cloud1.x - scroll
cloud2.x = cloud2.x - scroll
end


--[[local options = {
	
	effect = "fade", time = 100
}--]]

function startGame( )
	composer.gotoScene( "game" )
cloud3.x = cloud3.x - scroll

  -- Movendo as imagens para o fim da tela
if (cloud1.x + cloud1.contentWidth) < 0 then
cloud1:translate( _W * 3, 0 )
  end
if (cloud2.x + cloud2.contentWidth) < 0 then
cloud2:translate( _W * 3, 0 )
  end
if (cloud3.x + cloud3.contentWidth) < 0 then
cloud3:translate( _W * 3, 0 )
  end
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )


return scene

