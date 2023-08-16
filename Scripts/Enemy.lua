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
            if event.phase == "began" and event.other.id == "robot" then
                display.remove(projectile)
                composer.removeScene("Levels.firstlevel")
                local dead = display.newText("Erro na Máquina", display.contentCenterX,display.contentCenterY,"Assets/Commanders.ttf",50)
                timer.performWithDelay(1000, function () 
                    display.remove(dead) 
                    physics.stop()
                    composer.gotoScene("Levels.firstlevel")
                    physics.start()
                    physics.setGravity(0,0)
                end )
                huntFlag = true
            else
                display.remove(projectile)
                huntFlag = true
            end
        end
        local projectile = display.newImageRect("Imagens/feijao1-removebg-preview.png",200/10,250/13)
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
            projectile:setLinearVelocity(0,-50)
        elseif direction == "u" then
            projectile:setLinearVelocity(0,50)
        end
        projectile:addEventListener("collision",kill)
    end

    local objective = {robot.x,robot.y}

    -- TODO : Verify Function
    local function hunt(event)
        objective = {robot.x,robot.y}
        if huntFlag == true then
            print("B")
            if objective[1] == robot.x then
                if objective[2] > enemy.x then
                    createProj(enemy.x,enemy.y,"l")
                    huntFlag = false
                else 
                    createProj(enemy.x,enemy.y,"r")
                    huntFlag = false
                end
            end
            if objective[2] == robot.y then
                if objective[2] > enemy.y then
                    createProj(enemy.x,enemy.y,"d")
                    huntFlag = false
                else 
                    createProj(enemy.x,enemy.y,"u")
                    huntFlag = false
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