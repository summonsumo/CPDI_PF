local composer = require("composer")
local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
local function otherScene(event)
    composer.removeScene("Levels.firstscreen")
    composer.gotoScene("Levels.secondscreen", {effect = fade,time = 500})
end
-- create()
function scene:create( event )
 
    local sceneGroup = self.view

    -- Code here runs when the scene is first created but has not yet appeared on screen
end
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
    local text = display.newText {
        text = [[
A doação de sangue: um gestor de vidas e solidariedade

A doação de sangue é um ato vital que ressoa na saúde pública. Com impacto médico, social e humanitário, essa prática salva vidas em procedimentos complexos, como cirurgias e tratamentos de câncer.

     Benefícios médicos e emergenciais
O sangue doado é separado em componentes essenciais, servindo para diversas terapias. Em situações de emergência, a doação garante o suprimento necessário, sendo crucial para a resposta a desastres.

     Contribuição para a pesquisa e desenvolvimento
Além do âmbito clínico, as doações apoiam pesquisas e desenvolvimento de tratamentos inovadores. O plasma doado é a base para medicamentos vitais no tratamento de diversas doenças.

     Vínculo social e humanitário
A doação cria um laço entre doadores e comunidades, incentivando a solidariedade. Esse ato altruístico demonstra empatia, gerando esperança e reforçando valores humanos fundamentais.
]],
        x = display.contentCenterX,
        y = display.contentCenterY + 20,
        width = display.actualContentWidth,
        height = display.actualContentHeight,
        fontSize = 14,
        align = "left"
    }
    sceneGroup:insert(text)
    local heart1 = display.newImageRect(sceneGroup,"Imagens/Hospital/Heart_symbol_c00.png",256/25,256/25)
    heart1.x = 6
    heart1.y = 188
    heart1.alpha = 0.3

    local heart2 = display.newImageRect(sceneGroup,"Imagens/Hospital/Heart_symbol_c00.png",256/25,256/25)
    heart2.x = 6
    heart2.y = 106
    heart2.alpha = 0.3

    local heart3 = display.newImageRect(sceneGroup,"Imagens/Hospital/Heart_symbol_c00.png",256/25,256/25)
    heart3.x = 6
    heart3.y = 270
    heart3.alpha = 0.3

    timer.performWithDelay(5000, function() 
        local buttonRight = display.newImageRect(sceneGroup,"Imagens/ArrowIntro.png",1200/25,800/15) 
        buttonRight.x = display.contentWidth - 30
        buttonRight.y = 10
        buttonRight:addEventListener("tap",otherScene)
    end)

    
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