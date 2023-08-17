local composer = require( "composer" )
local scene = composer.newScene()

local physics = require("physics")
physics.start()
physics.pause()
physics.setGravity(0, 0)

display.setStatusBar( display.HiddenStatusBar )
native.setProperty( "windowMode", "maximized" )

audio.reserveChannels( 1 )
audio.setMaxVolume(1,{channel = 1})
audio.setMaxVolume(0.6,{channel = 2})
    
composer.gotoScene("Levels.firstlevel",{effect = "fade", time = 1000})

--Change to Levels.intro



-- TODO : Finish Finish
-- TODO : Change Commands
-- TODO : Levels | Portals
-- TODO : Wall Collision -> Player 

-- TODO : Audio

-- Physics
-- TODO : Distance based on origin point