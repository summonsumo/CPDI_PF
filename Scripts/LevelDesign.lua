local levelobjects = require("scripts.LevelObjects")


local level = {}
    function level.new(group,number)
        if number == 1 then
            levelobjects.new(group,display.contentCenterX + 180, display.contentHeight - 90,"receiver",5)
            levelobjects.new(group,50, display.contentCenterY - 100,"donor",5)
            levelobjects:menu(group,display.contentCenterX,display.contentHeight - 30,number)
            levelobjects:reload(group,50,25,1)
        end
        

    end
return level
