local commands = {}

function commands.new(group,robot)
    local commandcount = 0
    local ccText = display.newText(group,"Nº Comandos: ".. commandcount, 90,15, "assets/Commanders.ttf", 15)
    ccText.alpha = 0.3
    local commandText = display.newText(group,"Comandos:\n", display.contentWidth - 50,130, "assets/Commanders.ttf", 13)

    local commandList = {}
    local maxCommands = 10
    local commandIndex = 1 

    local function moveRobot(dx, dy)
        posX,posY = dx,dy
        robot.x = robot.x + dx * robot.xScale
        robot.y = robot.y + dy * robot.yScale
    end
    
    local function processCommand(command)
        if command == "a" then
            moveRobot(-15, 0)
            robot:setSequence("Esquerda")
            robot:play()
        elseif command == "d" then
            moveRobot(15, 0)
            robot:setSequence("Direita")
            robot:play()
        elseif command == "w" then
            moveRobot(0, -15)
            robot:setSequence("Cima")
            robot:play()
        elseif command == "s" then
            moveRobot(0, 15)
            robot:setSequence("Baixo")
            robot:play()
        elseif command == "q" then
            robot.xScale = robot.xScale - 0.1
            robot.yScale = robot.yScale - 0.1
            timer.performWithDelay(900,function() physics.removeBody(robot) physics.addBody(robot, "dynamic", {box = {halfHeight = 7*robot.xScale, halfWidth = 7*robot.xScale, x = 0, y = 10}}) robot.isFixedRotation = true end)
            
        elseif command == "e" then
            robot.xScale = robot.xScale + 0.1
            robot.yScale = robot.yScale + 0.1
            timer.performWithDelay(900,function() physics.removeBody(robot) physics.addBody(robot, "dynamic",  {box = {halfHeight = 7*robot.xScale, halfWidth = 7*robot.xScale, x = 0, y = 10}}) robot.isFixedRotation = true end)
            
        elseif command == "x" then
            
            if robot.sequence == "Esquerda" then
                attractor = display.newRect(group,robot.x - robot.width, robot.y, 5, 5)
                physics.addBody(attractor, "dynamic")
                attractor:setLinearVelocity(-500, 0)
            elseif robot.sequence == "Direita" then
                attractor = display.newRect(group,robot.x + robot.width, robot.y, 5, 5)
                physics.addBody(attractor, "dynamic")
                attractor:setLinearVelocity(500, 0)
            elseif robot.sequence == "Cima" then
                attractor = display.newRect(group,robot.x, robot.y - robot.height, 5, 5)
                physics.addBody(attractor, "dynamic")
                attractor:setLinearVelocity(0, -500)
            elseif robot.sequence == "Baixo" then
                attractor = display.newRect(group,robot.x, robot.y + robot.height, 5, 5)
                physics.addBody(attractor, "dynamic")
                attractor:setLinearVelocity(0, 500)
            end
            attractor.alpha = 0
            attractor.isSensor = true


            local function attraction(event)
                if event.phase == "began" then
                    vxA,vyA = attractor:getLinearVelocity() 
                    event.other:applyForce(-vxA*0.5,-vyA*0.5,attractor.x,attractor.y)
                    display.remove(attractor)
                end
            end

            attractor:addEventListener("collision",attraction)

            if attractor then
                attractor.isBullet = true
                timer.performWithDelay(1000, function()
                    display.remove(attractor)
                end)
            end

        else
            print("Unknown command: " .. command)
        end
    end
    
    local function clearCommands()
        for i = #commandList, 1, -1 do
            table.remove(commandList, i)
            commandcount = commandcount + 1
            ccText.text = "Nº Comandos: ".. commandcount
    
    
        end
        commandText.text = "Comandos:\n"
    end
    
    local function updateCommandText()
        commandText.text = "Comandos:\n"
        for _, cmd in ipairs(commandList) do
            commandText.text = commandText.text .. cmd .. "\n"
        end
    end
    
    local function addCommand(command)
        if #commandList < maxCommands then
            table.insert(commandList, command)
            updateCommandText()
        end
    end

    local inputField = native.newTextField(display.contentCenterX, display.contentHeight - 40, 40, 25)
    group:insert(inputField)
    inputField:addEventListener("userInput", function(event)
        if event.phase == "ended" or event.phase == "submitted" then
            local command = event.target.text
            addCommand(command)
            event.target.text = ""
        end
    end)

    local function physicsCommand()
        physics.start()
        timer.performWithDelay(1090, function() physics.pause() end)
    end

    local function executeCommandsStepByStep()
        if commandIndex <= #commandList then
            local command = commandList[commandIndex]
            processCommand(command)
            physicsCommand()
            commandIndex = commandIndex + 1
            if executeButtonPressed then
                timer.performWithDelay(1000, executeCommandsStepByStep)-- 1000 ms (1 second) delay between each step
            end
        else
            commandIndex = 1 -- Reset the command index when all commands are executed
            executeButtonPressed = false -- Reset the flag for "Executar" button press
            clearCommands()
        end
    end


    local commitButton = display.newText("Executar", display.contentCenterX, display.contentHeight - 10, "assets/Commanders.ttf", 20)
    group:insert(commitButton)

    commitButton:addEventListener("tap", function(event)
        executeButtonPressed = true -- Set the flag for "Executar" button press
        executeCommandsStepByStep() 
    end)

    local function changeCommand(event)
        if event.phase == "began" then
            local index = event.target.index
            if index and commandList[index] then
                inputField.text = commandList[index]
                commandIndex = index -- Update the current command index to the selected command
                table.remove(commandList, index)
                updateCommandText()
            end
        end
    end

    local executeButtonPressed = false -- Keep track if the "Executar" (Execute) button is pressed


    
    commandText:addEventListener("touch", changeCommand)
end

return commands