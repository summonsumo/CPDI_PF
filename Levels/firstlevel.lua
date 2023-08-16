local composer = require( "composer" )
local scene = composer.newScene()




-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 -- TODO : Change Reset Button Position (HUD Script)
local function resetButtonListener(event)
    composer.removeScene("Levels.firstlevel")
    physics.stop()
    composer.gotoScene("Levels.firstlevel")
    physics.start()
    physics.setGravity(0,0)

end

local playerscript = require("Scripts.Player")
 
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view

    -- Code here runs when the scene is first created but has not yet appeared on screen
 
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then


        local player = playerscript.new(sceneGroup,display.contentCenterX - 30,display.contentCenterY,1)

        
        local resetButton = display.newImageRect(sceneGroup, "Imagens/seta_lab2-semfundo.png", 300/6,250/6)
        resetButton.x,resetButton.y = display.contentCenterX + 150, display.contentHeight - 20
        resetButton.alpha = 0.5
        resetButton:addEventListener("tap", resetButtonListener)
        local resetText = display.newText(sceneGroup,"Reiniciar",display.contentCenterX + 150, display.contentHeight, "Assets/Commanders.ttf", 11 )
        resetText.alpha = 0.9
        resetText:setFillColor(0.9,1,0.6)

        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then

        -- Code here runs when the scene is entirely on screen

    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
 
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view

end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene