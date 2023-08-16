local composer = require( "composer" )
local scene = composer.newScene()

local physics = require("physics")
physics.start()
physics.pause()
physics.setGravity(0, 0)

physics.setDrawMode( "hybrid" )

display.setStatusBar( display.HiddenStatusBar )
native.setProperty( "windowMode", "maximized" )
    
composer.gotoScene("Levels.firstlevel",{effect = "fade", time = 1000}) 
--Change to Levels.intro



-- TODO : Finish Finish
-- TODO : Change Commands
-- TODO : Levels | Portals
-- TODO : Guide To Robot
-- TODO : Enemy | Execute Enemy after command (if not nil)
-- TODO : Colocar botões e introdução
-- TODO : Audio
-- TODO : Crate after being pulled doesnt work
-- TODO : Magnet crashes on enemies


-- Physics
-- TODO : Distance based on origin point