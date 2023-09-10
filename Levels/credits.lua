local composer = require("composer")
local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 


 
 
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    local bg = display.newRect(sceneGroup,0,0,display.contentWidth*2,display.contentHeight*3)
    bg:setFillColor(0,0,0)
    local creditsText = display.newText(sceneGroup,"Sangue Bom", display.contentCenterX,15,"Assets/SedgwickAveDisplay-Regular.ttf", 45)
    creditsText:setFillColor(1,0,0)

    local creditsTextD = display.newText(sceneGroup,"Áudio | Programação | Locução",display.contentCenterX,display.contentCenterY - 60,"Assets/SedgwickAveDisplay-Regular.ttf",16)
    local creditsTextM = display.newText(sceneGroup,"Daniel Mattos",display.contentCenterX,display.contentCenterY - 40,"Assets/SedgwickAveDisplay-Regular.ttf",22)

    local creditsTextR = display.newText(sceneGroup,"Arte",display.contentCenterX,display.contentCenterY,"Assets/SedgwickAveDisplay-Regular.ttf",16)
    local creditsTextA = display.newText(sceneGroup,"Raphael Auad",display.contentCenterX,display.contentCenterY + 20,"Assets/SedgwickAveDisplay-Regular.ttf",22)

    local creditsTextPart = display.newText(sceneGroup,"Participação Especial",display.contentCenterX,display.contentCenterY + 70,"Assets/SedgwickAveDisplay-Regular.ttf", 8)
    local creditsTextEli = display.newText(sceneGroup,"Elianne Carpes",display.contentCenterX,display.contentCenterY + 85, "Assets/SedgwickAveDisplay-Regular.ttf", 12)


    local botaoreturn = display.newImageRect (sceneGroup,"Imagens/ArrowIntro.png",1200/20,800/15)
    botaoreturn.x,botaoreturn.y = display.contentWidth - 50, 30
    botaoreturn:addEventListener("tap",function() composer.gotoScene("Levels.intro", {effect = "fade", time = 1000}) 
                end)
    local returnText = display.newText(sceneGroup,"Voltar ao início", display.contentWidth - 50, 50, native.systemFont, 10)
    returnText.alpha = 0.5

    local buttonBlood = display.newImageRect(sceneGroup,"Imagens/Hospital/blood_bag.png",1024/40,454/10)
    buttonBlood.x,buttonBlood.y = 30,display.contentHeight - 10
    buttonBlood:addEventListener("tap", function()
        system.openURL("https://www.salvovidas.com/doacao-de-sangue-no-hemosc-florianopolis/")
        end)

    local buttonText = display.newText(sceneGroup,"clique", 30,display.contentHeight - 32,native.systemFont,10)
    buttonText.alpha = 0.6
    -- Code here runs when the scene is first created but has not yet appeared on screen

    local soundTrack = audio.loadStream("Imagens/Hospital/RapIntro.wav")
    audio.play(soundTrack,{loops = -1})
 
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
        audio.stop()
        audio.dispose(soundTrack)
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