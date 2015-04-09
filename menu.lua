
--CRIANDO O MENU DO JOGO

--------------------------------------------------------------------------------------------------------------

local composer = require("composer")
local scene = composer.newScene( )
local menuBG
local playBtn
local creditsBtn
local bestscoresBtn


function scene:create( event )
	local sceneGroup = self.view

	menuBG = display.newImageRect( "image/mainscreen.png", _W, _H )
	menuBG.x = _W2
	menuBG.y = _H2
	sceneGroup:insert(menuBG)

	playBtn = display.newImageRect( "image/playBtn.png", 100, 25)
	playBtn.x = _W2
	playBtn.y = _H2
	sceneGroup:insert(playBtn)

	bestscoresBtn = display.newImageRect( "image/bestscoresBtn.png", 100, 25)
	bestscoresBtn.x = _W2
	bestscoresBtn.y = _H2 + 50
	sceneGroup:insert(bestscoresBtn)

	creditsBtn = display.newImageRect( "image/creditsBtn.png", 100, 25)
	creditsBtn.x = _W2
	creditsBtn.y = _H2 + 100
	sceneGroup:insert(creditsBtn)
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	if (phase == "will") then		
	elseif (phase == "did") then
		playBtn:addEventListener( "tap", startGame )
	end
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase

	if (phase == "will") then
		playBtn:removeEventListener( "tap", startGame )
		end
end



function startGame( )
	composer.gotoScene( "game" )
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )


return scene

