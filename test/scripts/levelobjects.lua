local levelObjs = {}

function levelObjs.new(posX,posY,x,y,type)

    --crate
    if type == "crate" then
        local crate = display.newRect(posX,posY,x,y)
        physics.addBody(crate, "dynamic")
        crate.isFixedRotation = true
        crate:setFillColor(0.3,0.6,0.8)
        crate.id = "crate"
    end

    --ice
    if type == "ice" then
        local ice = display.newRect(posX,posY,x,y)
        physics.addBody(ice, "dynamic")
        ice.isFixedRotation = true
        ice.id = "ice"
    end

    --finish
    if type == "finish" then
        local finish = display.newRect(posX,posY,x,y)
        physics.addBody(finish, "static")
        finish.isFixedRotation = true
        finish.id = "finish"
        finish:setFillColor(0.1,0.2,0.3)
    end

    --wall
    if type == "wall" then
        local wall = display.newRect(posX,posY,x,y)
        physics.addBody(wall, "static")
        wall.isFixedRotation = true
        wall.id = "wall"
        wall:setFillColor(0.9,0.8,0.7)
    end

end

return levelObjs