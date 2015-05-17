
--CRIANDO O MENU DO JOGO

-----------------------------------------------------------------------------------------------------------------------
--physics.setDrawMode( "hybrid")
local composer = require("composer")
local scene = composer.newScene( )
local gameoverBG
local retryBtn
local menuBtn
local scoreTxt
local score1Txt
local scoreFinal
local scoreFinalTxT
local scoreInfo
local iconGameOver
local finalScore = {}



function scene:create( event )
	local sceneGroup = self.view	

	finalScore()

	gameoverBG = display.newImageRect( "image/gameoverBG.png", _W, _H )
	gameoverBG.x = _W2
	gameoverBG.y = _H2
	sceneGroup:insert(gameoverBG)	

	menuBtn = display.newImage( "image/menuBtn1.png")
	menuBtn.x = 80
	menuBtn.y = _H2 + 120
	sceneGroup:insert(menuBtn)

	retryBtn = display.newImage( "image/retryBtn1.png")
	retryBtn.x = 240
	retryBtn.y = _H2 + 120
	sceneGroup:insert(retryBtn)

	scoreInfo = display.newImage( "image/scoreInfo.png")
	scoreInfo.x = _W2 - 75
	scoreInfo.y = _H2 + 20
	scene.view:insert( scoreInfo )

	iconGameOver = display.newImage( "image/iconGameOver.png")
	iconGameOver.x = _W2 + 120
	iconGameOver.y = _H2 + 20
	sceneGroup:insert(iconGameOver)	

	scoreTxt = display.newText('' .. score, _W2 - 25, _H2 + 20, native.systemFontBold, 16)
  	scoreTxt:setTextColor(255, 255, 255)
  	scene.view:insert( scoreTxt )

  	scoreTxt1 = display.newText('' .. score1, _W2 - 25, _H2 - 25, native.systemFontBold, 16)
  	scoreTxt1:setTextColor(255, 255, 255)
 	scene.view:insert( scoreTxt1)

 	scoreFinalTxT= display.newText('' .. scoreFinal, _W2 - 25, _H2 + 67, native.systemFontBold, 16)
  	scoreFinalTxT:setTextColor(255, 255, 255)
 	scene.view:insert( scoreFinalTxT )

	--[[bestscoresBtn = display.newImage( "image/bestscoresBtn.png")
	bestscoresBtn.x = 180
	bestscoresBtn.y = _H2 + 100
	sceneGroup:insert(bestscoresBtn)--]]
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase

	local previousScene = composer.getSceneName( "previous" )
    composer.removeScene( previousScene )
    --[[composer.removeScene( "stage")
    composer.removeScene( "menu")
    composer.removeScene( "game1")
    composer.removeScene( "game2")
    composer.removeScene( "game3")
    composer.removeScene( "game4")--]]

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


function finalScore( )
	scoreFinal = score * score1
end

local options = {
	
	effect = "fade", time = 250
}

function menuGame( )		
	composer.gotoScene( "menu", options )
	score = 0
	score1 = 1
end

function startGame( )
	composer.gotoScene( "stage", options )
	score = 0
	score1 = 1
end


scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )

return scene

