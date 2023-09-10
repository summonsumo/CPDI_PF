local composer = require("composer")
local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local function change(event)
    composer.gotoScene("Levels.firstscreen", { effect = "fade", time = 300 })
end

local function fases(event)
    composer.gotoScene("Levels.blood1", { effect = "fade", time = 300 })
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
local function cpdiClick(event)
    system.openURL("https://cpdi.org.br/")
end
-- create()
function scene:create(event)
    local sceneGroup = self.view

    local bg2 = display.newRect(sceneGroup,0,0,display.contentWidth*3,display.contentHeight*3)

    local bg = display.newImageRect(sceneGroup,"Imagens/heartBG.png",3500/7,2987/8)
    bg.x,bg.y = display.contentCenterX,display.contentCenterY
    bg.alpha = 0.3

    local introText = display.newText(sceneGroup, "Sangue Bom", display.contentCenterX - 20, display.contentCenterY - 80,"Assets/SedgwickAveDisplay-Regular.ttf", 90)
    introText:setFillColor(0,0,0)
    introText.rotation = -36

    local introClick = display.newText(sceneGroup, "jogar", display.contentCenterX, display.contentCenterY + 120, "Assets/Chock-a-BlockNF.ttf", 25)
    introClick:addEventListener("tap", change)
    introClick.alpha = 0.8
    introClick:setFillColor(0.3,0.5,0.6)

    local fasesClick = display.newText(sceneGroup, "fases", display.contentCenterX, display.contentCenterY + 145, "Assets/Chock-a-BlockNF.ttf", 10)
    fasesClick:addEventListener("tap", fases)
    fasesClick.alpha = 0.4
    fasesClick:setFillColor(0.3,0.5,0.6)

    local cpdi = display.newImageRect(sceneGroup,"Imagens/logo_cpdi.png",115/2,82/2)
    cpdi.alpha = 0.9
    cpdi:setFillColor(0.7,0.7,0.8)
    cpdi.x , cpdi.y = display.contentWidth - 80,display.contentHeight - 30

    local soundTrack = audio.loadStream("Imagens/Hospital/RapIntro.wav")
    audio.play(soundTrack,{loops = -1})
    


    cpdi:addEventListener("tap", cpdiClick)



end

-- show()
function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
    elseif (phase == "did") then
        -- Code here runs when the scene is entirely on screen
    end
end

-- hide()
function scene:hide(event)
    local sceneGroup = self.view
    local phase = event.phase
    audio.stop()
    audio.dispose(soundTrack)
    if (phase == "will") then
        -- Code here runs when the scene is on screen (but is about to go off screen)
    elseif (phase == "did") then
        -- Code here runs immediately after the scene goes entirely off screen
    end
end

-- destroy()
function scene:destroy(event)
    local sceneGroup = self.view


end

-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)
-- -----------------------------------------------------------------------------------

return scene