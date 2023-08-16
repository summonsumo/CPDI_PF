local enemyScript = require("Scripts.Enemy")

local levelObjs = {}

function levelObjs.new(group,x,y,type)

    if type == "enemy" then
        local enemy = enemyScript.new(group,x,y)
    end


    --crate
    if type == "crate" then
        local crate = display.newImageRect(group,"Imagens/fundo_Fase0 - Intro.PNG", 2048/74,2048/86)
        crate.x,crate.y = x,y
        physics.addBody(crate, "dynamic", {bounce = 0, friction = 1, density = 5, box = {halfWidth = 10, halfHeight = 10}})
        crate.isFixedRotation = true
        
        crate.id = "crate"
    end

    --ice
    if type == "ice" then
        local ice = display.newImageRect(group,"Imagens/fundo_Fase0 - Intro.PNG", 2048/74,2048/86)
        ice.x,ice.y = x,y
        physics.addBody(ice, "dynamic", {density = 2, box = {halfWidth = 10, halfHeight = 10}} )
        ice.isFixedRotation = true
        ice.id = "ice"
        ice:setFillColor(0.3,0.6,0.8)
        local function collideMovement(event)

            if event.phase == "began" and event.other.id == "robot" then
                ice:setLinearVelocity(posX*10,posY*10)
            end
            if event.other.id == "finish" then
                
            end
        end
    
        ice:addEventListener("collision", collideMovement)
    end

    --finish
    if type == "finish" then
        local finish = display.newRect(group,x,y,20,20)
        physics.addBody(finish, "static")
        finish.isFixedRotation = true
        finish.id = "finish"
        finish:setFillColor(0.1,0.2,0.3)
    end

    --wall
    if type == "wall" then
        local wall = display.newRect(group,x,y,20,20)
        physics.addBody(wall, "static")
        wall.isFixedRotation = true
        wall.id = "wall"
        wall:setFillColor(0.9,0.8,0.7)
    end

end
function levelObjs:bg(group,text,x,y,sX,sY)
    local bg = display.newImageRect(group,text,x,y)
    bg.x,bg.y = display.contentCenterX,display.contentCenterY + 15
    bg.xScale,bg.yScale = sX,sY
    bg:toBack()

    -- Walls
    local wallLeft = display.newRect(group,0,0,30,display.contentHeight*3)
    wallLeft.alpha = 0
    physics.addBody(wallLeft,"static",{bounce = 0.5})

    local wallUp = display.newRect(group,0,0,display.contentWidth*3,30)
    wallUp.alpha = 0
    physics.addBody(wallUp,"static",{bounce = 0.5})

    local wallRight = display.newRect(group,display.contentWidth,0,30,display.contentHeight*3)
    wallRight.alpha = 0
    physics.addBody(wallRight,"static",{bounce = 0.5})

    local wallDown = display.newRect(group,0,display.contentHeight + 25,display.contentWidth*3,20)
    wallDown.alpha = 0
    physics.addBody(wallDown,"static",{bounce = 0.5})

    local downCorner = display.newRect(group,display.contentCenterX + 110,display.contentCenterY + 53,240,70)
    downCorner.alpha = 0
    physics.addBody(downCorner,"static",{bounce = 0.5})

    local leftCorner = display.newRect(group,display.contentCenterX,display.contentCenterY + 15,20,147)
    leftCorner.alpha = 0
    physics.addBody(leftCorner,"static",{bounce = 0.5})

    local rightCorner = display.newRect(group,display.contentCenterX + 25,display.contentCenterY - 51,40,15)
    rightCorner.alpha = 0
    physics.addBody(rightCorner,"static",{bounce = 0.5})

    local rightUpCorner = display.newRect(group,display.contentCenterX + 40,display.contentCenterY - 70,18,160)
    rightUpCorner.alpha = 0
    physics.addBody(rightUpCorner,"static",{bounce = 0.5})

    local downRightCorner = display.newRect(group,display.contentCenterX + 140,display.contentCenterY - 31,190,20)
    downRightCorner.alpha = 0
    physics.addBody(downRightCorner,"static",{bounce = 0.5})

end

return levelObjs