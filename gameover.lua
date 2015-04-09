
--CRIANDO O MENU DO JOGO

--------------------------------------------------------------------------------------------------------------

local composer = require("composer")
local scene = composer.newScene( )
local gameoverBG
local retryBtn
local menuBtn

local function onSceneTouch( event )
	local phase = event.phase

	if "ended" == phase then		
		composer.gotoScene( "game", "fade", 500  )
	end
end

function scene:create( event )
	local sceneGroup = self.view

	gameoverBG = display.newImageRect( "image/gameoverBG.png", _W, _H )
	gameoverBG.x = _W2
	gameoverBG.y = _H2
	sceneGroup:insert(gameoverBG)

	menuBtn = display.newImageRect( "image/menuBtn.png", 100, 25)
	menuBtn.x = 70
	menuBtn.y = _H2
	sceneGroup:insert(menuBtn)

	retryBtn = display.newImageRect( "image/retryBtn.png", 100, 25)
	retryBtn.x = 120
	retryBtn.y = _H2 + 50
	sceneGroup:insert(retryBtn)

	bestscoresBtn = display.newImageRect( "image/bestscoresBtn.png", 100, 25)
	bestscoresBtn.x = 170
	bestscoresBtn.y = _H2 + 100
	sceneGroup:insert(bestscoresBtn)
	
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase

	local previousScene = composer.getSceneName( "previous" )
    composer.removeScene( previousScene )

	if (phase == "will") then
	end
		
	if (phase == "did") then
		menuBtn:addEventListener( "tap", menuGame )
		retryBtn:addEventListener( "tap", startGame )	
	end
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase

	if (phase == "will") then
		menuBtn:removeEventListener( "tap", menuGame )
		retryBtn:removeEventListener( "tap", startGame )
	end
end


function menuGame( )	
	composer.gotoScene( "menu" )
end

function startGame( )
	composer.gotoScene( "game" )
end


scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )


return scene

