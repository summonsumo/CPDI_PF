local composer = require( "composer" )
local scene = composer.newScene()

local physics = require("physics")
physics.start()
physics.pause()
physics.setGravity(0, 0)

physics.setDrawMode( "hybrid" )

display.setStatusBar( display.HiddenStatusBar )
native.setProperty( "windowMode", "maximized" )

audio.reserveChannels( 1 )
audio.setMaxVolume(0.6,{channel = 1})
audio.setMaxVolume(0.3,{channel = 2})
    
composer.gotoScene("Levels.firstlevel",{effect = "fade", time = 1000}) 
--Change to Levels.intro



-- TODO : Finish Finish
-- TODO : Change Commands
-- TODO : Levels | Portals
-- TODO : Enemy | Execute Enemy after command (if not nil)
-- TODO : Audio
-- TODO : Bullet

-- Physics
-- TODO : Distance based on origin point