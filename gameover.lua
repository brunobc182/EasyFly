
--CRIANDO O MENU DO JOGO

-----------------------------------------------------------------------------------------------------------------------
--physics.setDrawMode( "hybrid")
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

	menuBtn = display.newImage( "image/menuBtn.png")
	menuBtn.x = 80
	menuBtn.y = _H2
	sceneGroup:insert(menuBtn)

	retryBtn = display.newImage( "image/retryBtn.png")
	retryBtn.x = 130
	retryBtn.y = _H2 + 50
	sceneGroup:insert(retryBtn)

	bestscoresBtn = display.newImage( "image/bestscoresBtn.png")
	bestscoresBtn.x = 180
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

