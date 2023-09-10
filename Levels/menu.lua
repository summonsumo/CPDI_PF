local composer = require("composer")
local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 

local function backMenu(event)
    composer.hideOverlay({effect = "fromTop", time = 400})
end
 
 
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view

    local bg = display.newRect(sceneGroup,display.contentCenterX,display.contentCenterY,display.contentWidth - 10,display.contentHeight*2)
    bg:setFillColor (0,0,0)
    bg.alpha = 0.4

    local bloodtable = display.newImageRect(sceneGroup, "Imagens/Hospital/Tabela de Sangue (Menu).jpeg",1024/3,1022/3)
    bloodtable.x = display.contentCenterX
    bloodtable.y = display.contentCenterY

    local backButton = display.newImageRect(sceneGroup, "Imagens/Hospital/retorno.png",256/8,256/8)
    backButton.x,backButton.y = 30,30
    backButton.rotation = 180

    backButton:addEventListener("tap",backMenu)

    -- Code here runs when the scene is first created but has not yet appeared on screen
 
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
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