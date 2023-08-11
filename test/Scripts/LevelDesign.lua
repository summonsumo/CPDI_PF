
local levelobjects = require("scripts.levelobjects")


local level = {}
    function level.new(group,number)
        if number == 1 then
            levelobjects.new(group,50,50,"crate")
        end
        

    end
return level
