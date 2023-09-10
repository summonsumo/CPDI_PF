local composer = require("composer")

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
local Hud = require("Scripts.Hud")
local levelScript = require("Scripts.LevelDesign")
 
 
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view

    -- BG (Copy every level)
    local bgback = display.newRect(sceneGroup,0,0,display.contentWidth*3,display.contentHeight*3)
    bgback:setFillColor(0.4,0.8,0.6)
    local bggrid = display.newImageRect(sceneGroup,"Imagens/Hospital/Grids.png",1280/4,1280/3)
    local upWall = display.newRect(sceneGroup,0,-15,display.contentWidth*2,30)
    upWall.alpha = 0.6
    bggrid.alpha = 0.2
    bggrid.rotation = 90
    bggrid.x,bggrid.y = display.contentCenterX,display.contentCenterY
    local rightWall = display.newRect(sceneGroup,display.contentWidth - 13,80,30,display.contentHeight*2)
    rightWall.alpha = 0.6

    local downWall = display.newRect(sceneGroup,0,display.contentHeight + 15,display.contentWidth*2,30)
    downWall.alpha = 0.6

    local leftWall = display.newRect(sceneGroup,13,80,30,display.contentHeight*2)
    leftWall.alpha = 0.6
    

    -- Script Load
    local hud = Hud.new(sceneGroup)
    local level = levelScript.new(sceneGroup,1)

    local passar = display.newRect(sceneGroup,display.contentCenterX + 120,display.contentHeight - 10, 30,20)
    passar:addEventListener("tap",function()
            composer.gotoScene("Levels.thirdscreen", {effect = "fromBottom", time = 1000})end)
    passar:setFillColor(0.3,0.7,0.3)
    passar.alpha = 0.6
    local passarText = display.newText(sceneGroup,"Pular",display.contentCenterX + 120,display.contentHeight - 10,native.systemFont,8)
    passarText:setFillColor(0.3,0.3,0.5)
    passarText.alpha = 0.7

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