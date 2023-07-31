composer = require( "composer" )
local scene = composer.newScene()

native.setProperty( "windowMode", "fullscreen" )
native.setProperty( "mouseCursor", "arrow" ) 

physics = require("physics")
physics.start()

snapping = require("scripts.snap")

audio.reserveChannels( 2 )
audio.setMaxVolume(0.6,{channel = 1})
audio.setMaxVolume(0.3,{channel = 2})

composer.gotoScene("Levels.firstscreen",{effect = "fade", time = 1000}) 