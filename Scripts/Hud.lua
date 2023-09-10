local composer = require("composer")

local scene = composer.newScene()

local HUD = {}
function HUD.new(group)

    -- Score
    score = 0
    scoreText = display.newText(group,"Pontos: "..score, 75,display.contentHeight - 10,"Assets/BrazierFlame.ttf",15)
    scoreText:setFillColor(1,1,1)
    scoreText.alpha = 0.4

end

scoreUpdate = function(group,signal)
    if signal == "+" then
        score = score + 100
        local redsignal = display.newImageRect(group,"Imagens/Hospital/heartbeat-good.png",904/3,276/2)
        redsignal.alpha = 0
        redsignal.x,redsignal.y = display.contentCenterX,display.contentCenterY - 20
        local signalplay = audio.loadStream("Assets/Flatline.mp3")
        audio.seek(1500, signalplay)
        audio.play(signalplay,{channel = 2, duration = 1800})
        transition.to(redsignal, {alpha = 1 , time = 1000, onComplete = function() display.remove(redsignal) end})

    end
    if signal == "-" then
        if score > 0 then
            score = score - 50 
        end 
        local deadsignal = display.newImageRect(group,"Imagens/Hospital/hearbeat-bad.png",267,154/2)
        deadsignal.alpha = 0
        deadsignal.x,deadsignal.y = display.contentCenterX,display.contentCenterY
        deadsignal:setFillColor(0,1,0)
        local deadaudio = audio.loadStream("Assets/Flatline.mp3")
        audio.seek(95000, deadaudio)
        audio.play(deadaudio,{channel = 3,duration = 1200})
        transition.to(deadsignal, {alpha = 1 , time = 930, onComplete = function() display.remove(deadsignal) end})
    end
    scoreText.text = "Pontos: "..score
    if score >= 1000 then
        composer.gotoScene("Levels.thirdscreen", {effect = "fromBottom", time = 1000})
    end
end


return HUD