local composer = require("composer")
local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local function change(event)
    composer.gotoScene("Levels.firstscreen", { effect = "fade", time = 300 })
end
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create(event)
    local sceneGroup = self.view

    local bg = display.newImageRect(sceneGroup,"Imagens/fundoIntro4.jpg.jpg",3000/5,2000/5)
    bg.x,bg.y = display.contentCenterX,display.contentCenterY
    bg.alpha = 0.8

    local introText = display.newText(sceneGroup, "MATH", display.contentCenterX, 30, "Assets/Chock-a-BlockNF.ttf", 70)
    local paint = {
        type = "gradient",
        color1 = { 0.3, 0.3, 0.3 },
        color2 = { 1,1,0.3 },
        color3 = {1,0.2,0.5},
        color4 = {0.2,0.3,0.5},
        direction = "right"
    }
    introText.fill = paint

    local introClick = display.newText(sceneGroup, "jogar", display.contentCenterX, display.contentCenterY + 20, "Assets/Chock-a-BlockNF.ttf", 40)
    introClick:addEventListener("tap", change)
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