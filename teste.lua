
--CRIANDO O MENU DO JOGO

--------------------------------------------------------------------------------------------------------------

local composer = require("composer")
local scene = composer.newScene( )
local menuBG
local playBtn



local function onSceneTouch( event )
	local phase = event.phase

	if "ended" == phase then
		
		composer.gotoScene( "menu", "slideLeft", 800  )
	end
end



function scene:create( event )
	local sceneGroup = self.view

	menuBG = display.newImageRect( "image/bg02.png", _W, _H )
	menuBG.x = _W2
	menuBG.y = _H2
	sceneGroup:insert(menuBG)

	playBtn = display.newImage( "image/play.png")
	playBtn.x = _W2
	playBtn.y = _H2
	sceneGroup:insert(playBtn)
	playBtn:addEventListener( "touch", onSceneTouch)
end


function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase

	if (phase == "will") then
		
		elseif (phase == "did") then

		
		end
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase

	if (phase == "will") then
		elseif (phase == "did") then
		end
end

function scene:destroy( event )
	local sceneGroup = self.view
end



scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )


return scene

