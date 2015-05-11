
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

local finalScore = {}


local function onSceneTouch( event )
	local phase = event.phase

	if "ended" == phase then		
		composer.gotoScene( "game", "fade", 500  )
	end
end

function scene:create( event )
	local sceneGroup = self.view

	finalScore()

	gameoverBG = display.newImageRect( "image/gameoverBG.png", _W, _H )
	gameoverBG.x = _W2
	gameoverBG.y = _H2
	sceneGroup:insert(gameoverBG)	

	menuBtn = display.newImageRect( "image/menuBtn1.png", 50, 49)
	menuBtn.x = 80
	menuBtn.y = _H2 + 120
	sceneGroup:insert(menuBtn)

	retryBtn = display.newImageRect( "image/retryBtn1.png", 50, 49)
	retryBtn.x = 240
	retryBtn.y = _H2 + 120
	sceneGroup:insert(retryBtn)

	scoreInfo = display.newImageRect( "image/scoreInfo.png", 160, 118)
	scoreInfo.x = _W2
	scoreInfo.y = _H2 + 20
	scene.view:insert( scoreInfo )

	scoreTxt = display.newText('' .. score, _W2 + 50, _H2 + 20, "HoboStd", 16)
  	scoreTxt:setTextColor(255, 255, 255)
  	scene.view:insert( scoreTxt )

  	scoreTxt1 = display.newText('' .. score1, _W2 + 50, _H2 - 25, "HoboStd", 16)
  	scoreTxt1:setTextColor(255, 255, 255)
 	scene.view:insert( scoreTxt1)

 	scoreFinalTxT= display.newText('' .. scoreFinal, _W2 + 50, _H2 + 65, "HoboStd", 16)
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
		score = 0
		score1 = 1
	end
end


function finalScore( )
	scoreFinal = score * score1
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

