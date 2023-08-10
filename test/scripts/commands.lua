local commands = {}

function commands.new()
    local commandcount = 0
    local ccText = display.newText("Nº Comandos: ".. commandcount, 60,30, "assets/Commanders.ttf", 15)
    local commandText = display.newText("Comandos:\n", display.contentWidth - 50,150, "assets/Commanders.ttf", 13)

    local commandList = {}
    local maxCommands = 10
    local commandIndex = 1 

    local function moveRobot(dx, dy)
        robot.x = robot.x + dx * robot.xScale
        robot.y = robot.y + dy * robot.yScale
    end
    
    local function processCommand(command)
        if command == "a" then
            moveRobot(-19.9, 0)
        elseif command == "d" then
            moveRobot(19.9, 0)
        elseif command == "w" then
            moveRobot(0, -19.9)
        elseif command == "s" then
            moveRobot(0, 19.9)
        elseif command == "q" then
            robot.xScale = robot.xScale - 0.1
            robot.yScale = robot.yScale - 0.1
            timer.performWithDelay(900,function() physics.removeBody(robot) physics.addBody(robot, "dynamic", {box = {halfHeight = 20*robot.xScale, halfWidth = 20*robot.xScale}}) robot.isFixedRotation = true end)
            
        elseif command == "e" then
            robot.xScale = robot.xScale + 0.1
            robot.yScale = robot.yScale + 0.1
            timer.performWithDelay(900,function() physics.removeBody(robot) physics.addBody(robot, "dynamic",  {box = {halfHeight = 20*robot.xScale, halfWidth = 20*robot.xScale}}) robot.isFixedRotation = true end)
            
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

    inputField:addEventListener("userInput", function(event)
        if event.phase == "ended" or event.phase == "submitted" then
            local command = event.target.text
            addCommand(command)
            event.target.text = ""
        end
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

    local function executeCommandsStepByStep()
        if commandIndex <= #commandList then
            local command = commandList[commandIndex]
            processCommand(command)
            deltaX,deltaY = deltaX - robot.x,deltaY - robot.y
            commandIndex = commandIndex + 1
            if executeButtonPressed then
                timer.performWithDelay(1000, executeCommandsStepByStep) -- 1000 ms (1 second) delay between each step
            end
        else
            commandIndex = 1 -- Reset the command index when all commands are executed
            executeButtonPressed = false -- Reset the flag for "Executar" button press
            clearCommands()
        end
    end
    
    commandText:addEventListener("touch", changeCommand)
end

return commands