
--CRIANDO O HOW TO PLAY

-----------------------------------------------------------------------------------------------------------------------
--physics.setDrawMode( "hybrid")
local composer = require("composer")
local scene = composer.newScene( )
local howToPlayBG
local menuBtn
local backBtn


function scene:create( event )
	local sceneGroup = self.view	

	
	howToPlayBG = display.newImageRect( "image/howtoplayBG2.png", _W, _H )
	howToPlayBG.x = _W2
	howToPlayBG.y = _H2
	sceneGroup:insert(howToPlayBG)

	menuBtn = display.newImage( "image/menuBtn1.png")
	menuBtn.x = _W2
	menuBtn.y = _H2 + 120
	sceneGroup:insert(menuBtn)

	backBtn = display.newImage("image/backBtn.png")
	backBtn.x = _W2 - 150
	backBtn.y = _H2 + 120
	sceneGroup:insert(backBtn)

end
	
function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase

	local previousScene = composer.getSceneName( "previous" )
    composer.removeScene( previousScene )
    composer.removeScene( "menu")
    composer.removeScene( "howtoplay1" )


	if (phase == "did") then
		menuBtn:addEventListener( "tap", menuGame )
		backBtn:addEventListener( "tap", howToPlay1 )		
	end
end

function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if (phase == "will") then
		menuBtn:removeEventListener( "tap", menuGame )
		backBtn:removeEventListener( "tap", howToPlay1 )
		
	end
end



local options = {
	
	effect = "fade", time = 250
}


local options1 = {
	
	effect = "fromLeft", time = 500
}

function menuGame( )		
	composer.gotoScene( "menu", options )
	
end

function howToPlay1( )
	composer.gotoScene( "howtoplay1", options1 )
end


scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )

return scene

