local composer = require( "composer" )
local scene = composer.newScene()

local physics = require("physics")
physics.start()
physics.setGravity(0, 0)

display.setStatusBar( display.HiddenStatusBar )

native.setProperty( "windowMode", "normal" )

audio.reserveChannels( 5 )
audio.setMaxVolume(1,{channel = 1})
audio.setMaxVolume(0.3,{channel = 2})
audio.setMaxVolume(0.1,{channel = 3})
audio.setMaxVolume(1,{channel = 4})
audio.setMaxVolume(1,{channel = 5})
    
composer.gotoScene("Levels.intro",{effect = "fade", time = 1000})

--Change to Levels.intro