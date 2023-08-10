local hud = {}

function hud.new()    
    local inputField = native.newTextField(display.contentCenterX, display.contentHeight - 40, display.contentWidth - 250, 25)

    local commitButton = display.newText("Executar", display.contentCenterX, display.contentHeight - 10, native.systemFont, 20)

    commitButton:addEventListener("tap", function(event)
        executeButtonPressed = true -- Set the flag for "Executar" button press
        executeCommandsStepByStep() 
    end)

    end

return hud