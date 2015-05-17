
--CRIANDO O HOW TO PLAY

-----------------------------------------------------------------------------------------------------------------------
--physics.setDrawMode( "hybrid")
local composer = require("composer")
local scene = composer.newScene( )
local howToPlayBG
local stageBtn
local playBtn
local nextBtn


function scene:create( event )
	local sceneGroup = self.view	

	
	howToPlayBG = display.newImageRect( "image/howtoplayBG1.png", _W, _H )
	howToPlayBG.x = _W2
	howToPlayBG.y = _H2
	sceneGroup:insert(howToPlayBG)

	menuBtn = display.newImage( "image/menuBtn1.png")
	menuBtn.x = _W2
	menuBtn.y = _H2 + 120
	sceneGroup:insert(menuBtn)

	nextBtn = display.newImage("image/nextBtn.png")
	nextBtn.x = _W2 + 150
	nextBtn.y = _H2 + 120
	sceneGroup:insert(nextBtn)

end
	
function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase

	local previousScene = composer.getSceneName( "previous" )
    composer.removeScene( previousScene )
    composer.removeScene( "menu")
    composer.removeScene( "howtoplay2" )


	if (phase == "did") then
		menuBtn:addEventListener( "tap", menuGame )
		nextBtn:addEventListener( "tap", howToPlay2 )
			
	end
end

function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if (phase == "will") then
		menuBtn:removeEventListener( "tap", menuGame )
		nextBtn:removeEventListener( "tap", howToPlay2)
	end
end


local options = {
	
	effect = "fade", time = 250
}


local options1 = {
	
	effect = "fromRight", time = 500
}

function menuGame( )		
	composer.gotoScene( "menu", options )
	
end

function howToPlay2( )
	composer.gotoScene( "howtoplay2", options1 )
end


scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )

return scene

