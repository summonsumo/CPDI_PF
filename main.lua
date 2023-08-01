composer = require( "composer" )
local scene = composer.newScene()

native.setProperty( "windowMode", "fullscreen" )
native.setProperty( "mouseCursor", "arrow" ) 

display.setStatusBar(display.HiddenStatusBar)

physics = require("physics")
physics.start()
physics.setDrawMode("hybrid")

snapping = require("scripts.snap")

audio.reserveChannels( 2 )
audio.setMaxVolume(0.6,{channel = 1})
audio.setMaxVolume(0.3,{channel = 2})

composer.gotoScene("Levels.firstscreen",{effect = "fade", time = 1000}) 

--TODO Text Input