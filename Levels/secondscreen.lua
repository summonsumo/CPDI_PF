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

    local text1 = display.newText(group,text, display.contentCenterX + 20, display.contentHeight - 40, native.systemFontBold,12)
    text1.alpha = 0
    text1:setFillColor(0.89,0.8,0.85)

    local slider = display.newRect(display.contentCenterX + 20,display.contentHeight - 20, 290,55)
    slider:setFillColor(0.5,0.5,0.5)
    slider.alpha = 0
    transition.to(slider,{delay = 2400, time = 400, y = display.contentHeight - 5 ,yScale = 0, onComplete = 
    function() 
        slider.alpha = 0
        local button = display.newImageRect(group,"Imagens/setaLab-semfundo.png",250/10,300/10) 
        button.x,button.y = display.contentWidth - 110,display.contentHeight + 5
        if textNum == 1 then
            button:addEventListener("tap", function ()
                texts(group,"Xavier","Então, o sangue tipo A+ e AB+ podem receber \no seu sangue.",2)
                display.remove(button)
                display.remove(text1)
                display.remove(nameCheck)
                display.remove(slider)
                audio.stop()
                audio.dispose(han1)
                han1 = nil
                local xav1 = audio.loadSound( "Assets/Xav1-1.mp4" )
                audio.play(xav1,{fadein = 500, channel = 4})
                end)
            elseif textNum == 2 then
                button:addEventListener("tap", function ()
                    texts(group,"Xavier",'Que tal um jogo pra testar seus \nconhecimentos? Se tiver dúvida, tem um\nbotão de ajuda. Boa sorte, Hannah!',3)
                    display.remove(button)
                    display.remove(text1)
                    display.remove(nameCheck)
                    display.remove(slider)
                    audio.stop()
                    audio.dispose(xav2)
                    xav2 = nil
                    local xav3 = audio.loadSound( "Assets/Xav2-1.mp4" )
                    audio.play(xav3,{fadein = 100, channel = 5})
                    end)
            elseif textNum == 3 then
                button:addEventListener("tap", function ()
                    audio.stop()
                    audio.dispose(xav3)
                    composer.gotoScene("Levels.blood1",{effect = "fade", time = 1000})
                    end)
        end

    end})
    
    
    transition.to(slider, {delay = 2400, time = 200})
    if textNum == 1 then
        transitions({nameCheck},2400)
        transition.to(text1, {delay = 2400, time = 200,alpha = 1})
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
    

    texts(group,"Hannah","Professor, eu tenho tipo sanguíneo A+.\nQuais são os tipos sanguíneos que \npodem receber o meu sangue?",1)
    local han1 = audio.loadSound( "Assets/Han1-1.mp4" )
    timer.performWithDelay(1600,function() audio.play(han1,{fadein = 500, channel = 4})end)

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
    bg:setFillColor( 150/255, 160/255, 122/255)
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

    transitions({hannah,xavier},2400)

    transition.to(fundoTexto,{delay = 2400, time = 600 , alpha = 0.6})

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