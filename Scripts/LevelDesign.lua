
local levelobjects = require("scripts.LevelObjects")


local level = {}
    function level.new(group,number)
        if number == 1 then
            levelobjects:bg(group,"Imagens/THE_LAB/bg0.png",700,695,0.7,0.6)
            levelobjects.new(group,display.contentCenterX - 40,display.contentCenterY - 100,"crate")
            levelobjects.new(group,display.contentCenterX - 120,200, "ice")
            
            levelobjects.new(group,display.contentCenterX - 80,display.contentCenterY + 100 , "enemy")
        end
        

    end
return level
