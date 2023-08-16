local commandsscript = require("scripts.Commands")
local levelscript = require("Scripts.LevelDesign")

local player = {}
function player.new(group,x,y,level)



    local sheetOptions = 
        {
            width = 32,
            height = 32,
            numFrames = 8
        }
    local robotSheet = graphics.newImageSheet( "Imagens/1 - Gum Bot/Turn_Around_Poses (32 x 32).png",sheetOptions)

    local robotSprite = {
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
    --robot
    robot = display.newSprite(group,robotSheet,robotSprite)
    robot.x,robot.y = x,y
    robot.xScale,robot.yScale = 1.5,1.5
    robot.id = "robot"
    robot:setSequence("Cima")
    robot:play()

    originX,originY = robot.x,robot.y   

    physics.addBody(robot, "dynamic", {friction = 1,density = 50,box = {halfWidth = 10,halfHeight = 10,x = 0,y = 10}})
    robot.isFixedRotation = true

    local commands = commandsscript.new(group,robot)
    local level = levelscript.new(group,1)

end
return player