
--CRIANDO O MENU DO JOGO

--------------------------------------------------------------------------------------------------------------

local composer = require("composer")
local scene = composer.newScene( )
local stageBG
local stageBG1
local stage1Btn
local stage2Btn
local stage3Btn
local stage4Btn



function scene:create( event )
	local sceneGroup = self.view
	setupBG()
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	if (phase == "will") then		
	elseif (phase == "did") then
		stage1Btn:addEventListener( "tap", stage1)
		stage2Btn:addEventListener( "tap", stage2 )
		stage3Btn:addEventListener( "tap", stage3 )
		stage4Btn:addEventListener( "tap", stage4 )
		
	end
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase

	if (phase == "will") then
		stage1Btn:removeEventListener( "tap", stage1 )
		stage2Btn:removeEventListener( "tap", stage2 )
		stage3Btn:removeEventListener( "tap", stage3 )
		stage4Btn:removeEventListener( "tap", stage4 )		
		end
end


function setupBG(  )

	stageBG = display.newImage( "image/stageBG.png", _W, _H)
	stageBG.x = _W2
	stageBG.y = _H2
	scene.view:insert( stageBG )

	stageBG1 = display.newImage( "image/stageInfo.png")
	stageBG1.x = _W2
	stageBG1.y = 30
	scene.view:insert( stageBG1 )

	stage1Btn = display.newImage( "image/stage1.png")
	stage1Btn.x = _W2 - 120
	stage1Btn.y = 120
	scene.view:insert( stage1Btn )

	stage2Btn = display.newImage( "image/stage2.png")
	stage2Btn.x = _W2 - 120
	stage2Btn.y = 240
	scene.view:insert( stage2Btn )

	stage3Btn = display.newImage( "image/stage3.png")
	stage3Btn.x = _W2 + 120
	stage3Btn.y = 120
	scene.view:insert( stage3Btn )

	stage4Btn = display.newImage( "image/stage4.png")
	stage4Btn.x = _W2 + 120
	stage4Btn.y = 240
	scene.view:insert( stage4Btn )

end


--[[local options = {
	
	effect = "fade", time = 100
}--]]

function stage1( )
	audio.stop(1)
	composer.gotoScene( "game1" )
end

function stage2( )
	audio.stop(1)
	composer.gotoScene( "game2" )
end

function stage3( )
	audio.stop(1)
	composer.gotoScene( "game3" )
end

function stage4( )
	audio.stop(1)
	composer.gotoScene( "game4" )
end
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )


return scene

