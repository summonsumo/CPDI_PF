local composer = require( "composer" )
local scene = composer.newScene()
local Enemy = {}
function Enemy.new(group,x,y)
    local huntFlag = true

    local sheetOptions = 
        {
            width = 32,
            height = 32,
            numFrames = 8
        }
    local enemySheet = graphics.newImageSheet( "Imagens/1 - Gum Bot/Turn_Around_Poses (32 x 32).png",sheetOptions)

    local enemySprite = {
        {
            name = "Esquerda",
            frames = {3}
        },
        {
            name = "Direita",
            frames = {7}
        },
        {   
            name = "Cima",
            frames = {5}
        },
        {
            name = "Baixo",
            frames = {1}
        },

    }
    --enemy
    enemy = display.newSprite(group,enemySheet,enemySprite)
    enemy.x,enemy.y = x,y
    enemy.xScale,enemy.yScale = 1.5,1.5
    enemy:setFillColor(1,0.2,0.2)
    enemy.id = "enemy"
    enemy:setSequence("Baixo")
    enemy:play()

    physics.addBody(enemy, "dynamic", {density = 50,box = {halfWidth = 10,halfHeight = 10,x = 0,y = 10}})
    enemy.isSensor = true
    enemy.isFixedRotation = true

    local function createProj(x,y,direction)
        local function kill(event)
            if event.phase == "began" and event.other.id == "robot"then
                display.remove(projectile)
                composer.removeScene("Levels.firstlevel")
                local dead = display.newText("ERRO ERRO ERRO", display.contentCenterX,display.contentCenterY,"Assets/Commanders.ttf",30)
                dead.alpha = 0
                transition.to(dead,{time = 600, alpha = 1,xScale = 1.5,yScale = 1.5})
                timer.performWithDelay(1000, function () 
                    display.remove(dead) 
                    Runtime:removeEventListener("enterFrame",hunt)
                    physics.pause()
                    composer.gotoScene("Levels.firstlevel")
                    physics.setGravity(0,0)
                end )
                huntFlag = true
            end
            if event.phase == "began" and event.other.id ~= "enemy" then
                display.remove(projectile)
                huntFlag = true
            end
        end
        local projectile = display.newImageRect("Imagens/feijao1-removebg-preview.png",200/12,250/15)
        projectile:setFillColor(0.3,0.7,0.2)
        projectile.x,projectile.y = x ,y + 10
        physics.addBody(projectile,"dynamic")
        projectile.isBullet = true
        projectile.isSensor = true
        projectile.id = "Bullet"
        if direction == "r" then
            projectile:setLinearVelocity(50,0)
        elseif direction == "l" then
            projectile:setLinearVelocity(-50,0)
        elseif direction == "d" then
            projectile:setLinearVelocity(0,50)
        elseif direction == "u" then
            projectile:setLinearVelocity(0,-50)
        end
        projectile:addEventListener("collision",kill)
    end

    local objective = {robot.x,robot.y}


    local function hunt(event)
        objective = {robot.x,robot.y}
        if huntFlag == true then
            if y == objective[2] then
                if objective[1] > x then
                    huntFlag = false
                    createProj(enemy.x,enemy.y,"r")
                else 
                    huntFlag = false
                    createProj(enemy.x,enemy.y,"l")
                end
            end
            if x == objective[1] then
                if objective[2] > y then
                    huntFlag = false
                    createProj(enemy.x,enemy.y,"d")
                else 
                    huntFlag = false
                    createProj(enemy.x,enemy.y,"u")
                end
            end
        end
       
    end

    local function death(event)
        if event.phase == "began" and event.other.id ~= "Bullet" then
            Runtime:removeEventListener("enterFrame",hunt)
            display.remove(enemy)
        end
    end
    Runtime:addEventListener("enterFrame", hunt)
    enemy:addEventListener("collision",death)
    

end
return Enemy