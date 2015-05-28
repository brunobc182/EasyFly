
local composer = require("composer")
local scene = composer.newScene( )
local menuBG
local playBtn
local creditsBtn
local howtoplayBtn
local scroll = 1
local cloud1
local cloud2
local cloud3
local iconMainScreen
local bg
local easyFlyLogo
local bgScroll = {}
local setupPlayer = {}
local howToPlay = {}




function scene:create( event )
	local sceneGroup = self.view
	local somBG = audio.loadStream( "sound/DST-AmbientKingdom.mp3" )
  	audio.play(somBG, {loops = -1, channel = 1})

	setupBG()
	setupGroups()
		
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	composer.removeScene( "howtoplay1")
	composer.removeScene( "howtoplay2")
	composer.removeScene( "credits1")
	composer.removeScene( "credits2")
	composer.removeScene( "credits3")
	if (phase == "will") then		
	elseif (phase == "did") then
		playBtn:addEventListener( "tap", startGame )
		howtoplayBtn:addEventListener( "tap", howToPlay )
		creditsBtn:addEventListener( "tap", credits )
		Runtime:addEventListener( "enterFrame", bgScroll )
	end
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase

	if (phase == "will") then
		playBtn:removeEventListener( "tap", startGame )
		howtoplayBtn:removeEventListener( "tap", howToPlay )
		creditsBtn:removeEventListener( "tap", credits )
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

	easyFlyLogo = display.newImage("image/mainscreenBG01.png")
	easyFlyLogo.x = _W2
	easyFlyLogo.y = _H2 - 100
	scene.view:insert(easyFlyLogo)
	
	menuBG = display.newImageRect("image/mainscreenBG.png", _W, 100 )
	menuBG.x = _W2
	menuBG.y = _H - 30
	scene.view:insert(menuBG)

	iconMainScreen = display.newImage("image/iconMainScreen.png")
	iconMainScreen.x = _W2
	iconMainScreen.y = _H2 + 10
	scene.view:insert(iconMainScreen)	
	

	playBtn = display.newImage( "image/playBtn.png")
	playBtn.x = _W2 - 150
	playBtn.y = _H2 + 120
	scene.view:insert(playBtn)

	howtoplayBtn = display.newImage( "image/howtoplayBtn.png")
	howtoplayBtn.x = _W2
	howtoplayBtn.y = _H2 + 120
	scene.view:insert(howtoplayBtn)

	creditsBtn = display.newImage( "image/creditsBtn.png")
	creditsBtn.x = _W2 + 150
	creditsBtn.y = _H2 + 120
	scene.view:insert(creditsBtn)

end

function bgScroll (event)
cloud1.x = cloud1.x - scroll
cloud2.x = cloud2.x - scroll
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

local options = {
	
	effect = "fade", time = 500
}

function startGame( )
		
	composer.gotoScene( "stage", options)
end

function howToPlay( )
	audio.stop(1)
	composer.gotoScene( "howtoplay1", options)
end

function credits( )
	audio.stop(1)
	composer.gotoScene( "credits1", options)
end


scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )


return scene

