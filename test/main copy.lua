local physics = require("physics")
physics.start()
physics.setGravity(0, 0)

display.setStatusBar( display.HiddenStatusBar )


local commands = require("scripts.commands")
hud = require("scripts.hud")
local level = require("scripts.leveldesign")
player = require("scripts.player")

physics.setDrawMode("hybrid")








-- TODO : Finish Finish
-- TODO : Change Commands
-- TODO : Set better lineup
-- TODO : Walls | Levels | Portals