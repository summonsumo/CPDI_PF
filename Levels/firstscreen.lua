local composer = require( "composer" )
local scene = composer.newScene()




-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local function transitions(objects,delay)
    for i = 1, #objects do
        transition.to(objects[i],{delay = delay, time = 600, alpha = 1})
    end

end


local function texts(group,name,text,textNum)

    if name == "Xavier" then
        xavier:setFillColor(1,1,1)
        hannah:setFillColor(0.5,0.5,0.5)
    else
        hannah:setFillColor(1,1,1)
        xavier:setFillColor(0.5,0.5,0.5)
    end
    -- Check

    local nameCheck = display.newText(group, name.. ":",140, display.contentCenterY + 70, native.systemFontBold,18)
    nameCheck.alpha = 0
    nameCheck:setFillColor(0.89,0.8,0.85)

    local text1 = display.newText(group,text, display.contentCenterX + 20, display.contentHeight - 30, native.systemFontBold,12)
    text1.alpha = 0
    text1:setFillColor(0.89,0.8,0.85)

    local slider = display.newRect(display.contentCenterX + 20,display.contentHeight - 20, 290,55)
    slider:setFillColor(0.5,0.5,0.5)
    slider.alpha = 0
    transition.to(slider,{delay = 3400, time = 1500, y = display.contentHeight - 5 ,yScale = 0, onComplete = 
    function() 
        slider.alpha = 0
        local button = display.newImageRect(group,"Imagens/setaLab-semfundo.png",250/10,300/10) 
        button.x,button.y = display.contentWidth - 110,display.contentHeight
        if textNum == 1 then
            button:addEventListener("tap", function ()
                texts(group,"Xavier","Sim, nós programamos todos os robôs \ne ensinamos os primeiros passos para eles \nrepetirem lá dentro do chão de fábrica.\nVocê quer ver como funciona ?",2)
                display.remove(button)
                display.remove(text1)
                display.remove(nameCheck)
                display.remove(slider)
                end)
            elseif textNum == 2 then
                button:addEventListener("tap", function ()
                    texts(group,"Hannah","Adoraria ! O que eu preciso fazer?",3)
                    display.remove(button)
                    display.remove(text1)
                    display.remove(nameCheck)
                    display.remove(slider)
                    end)
            elseif textNum == 3 then
                button:addEventListener("tap", function ()
                    texts(group,"Xavier",'Você só precisa realizar os comandos aqui \npara executar o algoritmo. \nO comando “w” faz ele andar para frente, \no comando “a” e o “d” para os lados \ne a função “s” para trás. ',4)
                    display.remove(button)
                    display.remove(text1)
                    display.remove(nameCheck)
                    display.remove(slider)
                    end)
            elseif textNum == 4 then
                button:addEventListener("tap", function ()
                    texts(group,"Xavier",'Por fim, a função "x" busca a caixa \nde volta para você. O nosso objetivo é derrotar \ntodos os inimigos. \nCuidado com os robôs rivais!',5)
                    display.remove(button)
                    display.remove(text1)
                    display.remove(nameCheck)
                    display.remove(slider)
                    end)
            elseif textNum == 5 then
                button:addEventListener("tap", function ()
                    composer.gotoScene("Levels.firstlevel",{effect = "zoomOutIn", time = 1000})
                    end)
        end

    end})
    
    
    transition.to(slider, {delay = 3400, time = 600})
    if textNum == 1 then
        transitions({nameCheck},3400)
        transition.to(text1, {delay = 3900, time = 300,alpha = 1})
    else
        text1.alpha = 1
        nameCheck.alpha = 1
    end


-- X - Sim, nós programamos todos os robôs e ensinamos os primeiros passos para eles repetirem lá dentro do chão de fábrica. Você quer ver como funciona ?

-- H - Adoraria ! O que eu preciso fazer?
-- X - Você só precisa realizar os comandos aqui para executar o algoritmo. O comando “w” faz ele andar para frente, o comando “a” e o “d” para os lados e a função “s” para trás. 
-- X Por fim, a função "x" busca a caixa de volta para você. O nosso objetivo é derrotar todos os inimigos. Cuidado com os robôs rivais!
    

end

local function cutsceneTexts(group)
    local square = display.newRect(group,display.contentCenterX,20,display.contentWidth, 40)
    square:setFillColor(0.6,0.2,0.1)
    square.alpha = 0 
    local titleT = display.newText(group,"Sala de Laboratório", display.contentCenterX,20,native.systemFont, 40)
    titleT:setFillColor (0.5,0.6,0.8)
    titleT.alpha = 0
    transition.to(square,{time = 1600, alpha = 1,onComplete = function() transition.to(square,{delay = 1400,time = 1600, alpha = 0})end})
    transition.to(titleT,{time = 1600, alpha = 1,onComplete = function() transition.to(titleT,{delay = 1400,time = 1600, alpha = 0})end})
    

    texts(group,"Hannah","Uau ! Que lugar incrível !\nÉ aqui que vocês programam os robôs \npara as fábricas?",1)

end
 
 
local function click(event)
    if event.phase == "began" then
        
    end
end
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )


    local sceneGroup = self.view

    local sheetOptions = 
    {
        width = 890,
        height = 2700,
        numFrames = 8
    }

    local pessoasSprite = graphics.newImageSheet("Imagens/perso_Adultos1.png",sheetOptions)

    -- Inside the scene:create() function
    local sequenceHan = {
        frames = {6},  
    }
    local sequenceXav = {
        frames = {4},
    }



    -- Code here runs when the scene is first created but has not yet appeared on screen
    local bg = display.newImageRect(sceneGroup,"Imagens/fundo_Fase6 - LabRobotica.jpg",6000/10,2700/7)
    bg.x = display.contentCenterX
    bg.y = display.contentCenterY
    bg:toBack()

    local fundoTexto = display.newRect(sceneGroup,display.contentCenterX + 10,display.contentHeight - 33,300,100)
    fundoTexto:setFillColor(0.5,0.5,0.5)
    fundoTexto.alpha = 0


    hannah = display.newSprite(sceneGroup, pessoasSprite, sequenceHan)
    hannah.x = display.contentWidth - 40
    hannah.y = display.contentCenterY + 70
    hannah:setSequence("Hannah")  
    hannah:play()  
    hannah.xScale = 0.1
    hannah.yScale = 0.1
    hannah.alpha = 0


    
    -- Xavier

    xavier = display.newSprite(sceneGroup, pessoasSprite, sequenceXav)
    xavier.x = 50
    xavier.y = display.contentCenterY + 70
    xavier:setSequence("Xavier")  
    xavier:play()  
    xavier.xScale = 0.1
    xavier.yScale = 0.1
    xavier.alpha = 0
    xavier:setFillColor(0.5,0.5,0.5)

    transitions({hannah,xavier},3400)

    transition.to(fundoTexto,{delay = 3400, time = 600 , alpha = 0.6})

    -- TODO : ANA, XAVIER (6,4)
    cutsceneTexts(sceneGroup)


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