local commandsscript = require("scripts.commands")


local player = {}
function player.new(group,x,y)

    
    --robot
    robot = display.newRect(display.contentCenterX,display.contentCenterY,x,y)
    physics.addBody(robot, "dynamic", {density = 15})
    robot.isFixedRotation = true
    robot:setFillColor(0, 0.5, 0.5)
    deltaX,deltaY = robot.x,robot.y

    local commands = commandsscript.new(robot)


    local function collideMovement(event)

        if event.phase == "began" and event.other.id == "ice" then
            print(deltaX,deltaY)
            ice:applyForce(deltaX*0.1,deltaY*0.1,ice.x,ice.y)
        end
        if event.other.id == "finish" then
            
        end
    end

    robot:addEventListener("collision", collideMovement)

end
return player