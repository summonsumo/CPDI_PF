local composer = require( "composer" )
local scene = composer.newScene()

local physics = require("physics")
physics.start()
physics.setGravity(0, 0)

display.setStatusBar( display.HiddenStatusBar )
native.setProperty( "windowMode", "maximized" )


composer.gotoScene("Levels.intro",{effect = "fade", time = 1000}) 




-- TODO : Finish Finish
-- TODO : Change Commands
-- TODO : Walls | Levels | Portals
-- TODO : Transition Chat

-- TODO : Enemy | Execute Enemy after command (if not nil)