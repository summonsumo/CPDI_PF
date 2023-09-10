local composer = require( "composer" )
local scene = composer.newScene()
local Enemy = {}

function Enemy.new(group,x,y,i)
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
    local enemy = display.newSprite(group,enemySheet,enemySprite)
    enemy.x,enemy.y = x,y
    enemy.xScale,enemy.yScale = 1.5,1.5
    enemy:setFillColor(0.1,0.6,0.1)
    enemy.id = "Enemy"
    enemy:setSequence("Baixo")
    enemy:play()

    physics.addBody(enemy, "dynamic", {density = 50,box = {halfWidth = 10,halfHeight = 10,x = 0,y = 10}})
    enemy.isSensor = true
    enemy.isFixedRotation = true


    --TODO : movementEnemy - Hunt
    local function movementEnemy(direction)
        if direction == "l" then
            enemy.x = enemy.x - 20
            enemy:setSequence("Esquerda")
            enemy:play()
        elseif direction == "r" then
            enemy.x = enemy.x + 20
            enemy:setSequence("Direita")
            enemy:play()
        elseif direction == "u" then
            enemy.y = enemy.y - 20
            enemy:setSequence("Cima")
            enemy:play()
        elseif direction == "d" then
            enemy.y = enemy.y + 20
            enemy:setSequence("Baixo")
            enemy:play()
        end
    end

    -- local projectileTable = {}
    -- table.insert(projectileTable,projectile)
    -- for i = #projectileTable, 1,-1 do
    --     local thisProj = projectileTable[i]
    --     display.remove(thisProj)    
    --     table.remove(projectileTable,i)
    -- end

    local function createProj(group,x,y,direction)
        local projectile = display.newImageRect("Imagens/feijao1-removebg-preview.png",200/12,250/15)
        projectile:setFillColor(0.8,0.7,0.2)
        projectile.alpha = 0.6
        projectile.x,projectile.y = x ,y + 10
        physics.addBody(projectile,"dynamic")
        projectile.isBullet = true
        projectile.isSensor = true
        projectile.id = "Bullet"

        local function kill(event)
            if event.phase == "began" then
                if event.other.id == "Robot" then
                    display.remove(projectile)

                    composer.removeScene("Levels.firstlevel")
                    local dead = display.newText("Runtime Error", display.contentCenterX,display.contentCenterY,"Assets/Commanders.ttf",33)
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
                elseif event.other.id ~= "Enemy" then
                    display.remove(projectile)
                    huntFlag = true
                end
            end
        end


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
        if huntFlag == true and enemy.x ~= nil then
            if y == objective[2] then
                if objective[1] > x and enemy.sequence == "Direita" then
                    huntFlag = false
                    createProj(group,enemy.x,enemy.y,"r")
                elseif enemy.sequence == "Esquerda" then
                    huntFlag = false
                    createProj(group,enemy.x,enemy.y,"l")
                end
            elseif x == objective[1] then
                if objective[2] > y and enemy.sequence == "Baixo" then
                    huntFlag = false
                    createProj(group,enemy.x,enemy.y,"d")
                elseif enemy.sequence == "Cima" then
                    huntFlag = false
                    createProj(group,enemy.x,enemy.y,"u")
                end
            end
        end
        if enemy.x ~= nil and moved == false then
            local AI = math.random(1,2)
            if x < objective[1] - 20 and AI == 1 then
                moved = true
                movementEnemy("r")
            elseif x > objective[1] + 20 and AI == 1 then
                moved = true
                movementEnemy("l")
            elseif y < objective [2] - 20 and AI == 2 then
                moved = true
                movementEnemy("d")
            elseif y > objective[2] + 20 and AI == 2 then
                moved = true
                movementEnemy("u")
            end
        end 
       
    end

    local function death(event)
        if event.phase == "began" and event.other.id ~= "Bullet" and event.other.id ~= "Attractor" and event.other.id ~= "Enemy" and event.other.id ~= "Wall" then
            Runtime:removeEventListener("enterFrame",hunt)
            display.remove(enemy)
            enemyCount = enemyCount - 1
        end
    end
    Runtime:addEventListener("enterFrame", hunt)
    enemy:addEventListener("collision",death)
    

end
return Enemy