local composer = require("composer")
local scene = composer.newScene( )
local creditsBG
local menuBtn
local nextBtn


function scene:create( event )
	local sceneGroup = self.view	

	
	creditsBG = display.newImageRect( "image/creditsBG2.png", _W, _H )
	creditsBG.x = _W2
	creditsBG.y = _H2
	sceneGroup:insert(creditsBG)

	menuBtn = display.newImage( "image/menuBtn1.png")
	menuBtn.x = _W2
	menuBtn.y = _H2 + 120
	sceneGroup:insert(menuBtn)

	nextBtn = display.newImage("image/nextBtn.png")
	nextBtn.x = _W2 + 150
	nextBtn.y = _H2 + 120
	sceneGroup:insert(nextBtn)

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
  


	if (phase == "did") then
		menuBtn:addEventListener( "tap", menuGame )
		backBtn:addEventListener( "tap", credits1 )
		nextBtn:addEventListener( "tap", credits3 )			
	end
end

function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if (phase == "will") then
		menuBtn:removeEventListener( "tap", menuGame )
		backBtn:removeEventListener( "tap", credits1 )
		nextBtn:removeEventListener( "tap", credits3 )
		
	end
end



local options = {
	
	effect = "fade", time = 250
}


local options1 = {
	
	effect = "fromLeft", time = 500
}

local options2 = {
	
	effect = "fromRight", time = 500
}

function menuGame( )
	audio.stop( 1 )		
	composer.gotoScene( "menu", options )
	
end

function credits1( )
	composer.gotoScene( "credits1", options1 )
end

function credits3( )
	composer.gotoScene( "credits3", options2 )
end


scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )

return scene

