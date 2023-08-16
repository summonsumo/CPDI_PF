
local levelobjects = require("scripts.LevelObjects")


local level = {}
    function level.new(group,number)
        if number == 1 then
            levelobjects:bg(group,"Imagens/THE_LAB/bg0.png",700,695,0.7,0.6)
            levelobjects.new(group,display.contentCenterX - 30,display.contentCenterY - 70,"crate")
            levelobjects.new(group,display.contentCenterX - 30,display.contentCenterY - 20, "ice")
            levelobjects.new(group,display.contentCenterX - 30,200, "enemy")
        end
        

    end
return level
