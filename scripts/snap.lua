local snapping = {}
    function snapping.new(xsnap,ysnap,x,y,code)

        local gap = display.newRect(xsnap,ysnap,x,y)
        physics.addBody(gap,"kinematic",{box = {halfWidth = xsnap*0.6,halfHeight = ysnap*0.6},isFixedRotation = true })
        gap.gravityScale = 0
        gap.id = "gap"

        local groupsnap = display.newGroup()

        local snapobject = display.newRect(groupsnap,xsnap + math.random(xsnap, xsnap + 100), ysnap + math.random(ysnap,ysnap + 100),x,y)
        physics.addBody(snapobject,"dynamic",{isFixedRotation = true})
        snapobject.gravityScale = 0
        snapobject.id = "snapobject"

        codeText = display.newText(groupsnap,code,snapobject.x,snapobject.y,native.systemFont,60)
        codeText:setFillColor(0.4,0.5,0.6)

      
        local function execute(code)
            print("AAS")
        end

        local function moveSnap( event )
            if ( event.phase == "began" ) then
                display.getCurrentStage():setFocus( event.target )
                event.target.xStart = event.target.x
                event.target.yStart = event.target.y
            event.target.isFocus = true
         
            elseif ( event.phase == "moved" ) then
                if ( event.target.isFocus ) then
                    event.target.x = event.target.xStart + event.xDelta
                    event.target.y = event.target.yStart + event.yDelta
                    codeText.x = snapobject.x
                    codeText.y = snapobject.y
                end
         
            else
                display.getCurrentStage():setFocus( nil )
                event.target.isFocus = false
         
            end
        end
        

        local function snapCheck(self,event)
            local notme = event.other

            if notme.id == "gap" then
                execute(code)
                timer.peformWithDelay()
            end
        end

        snapobject.collision = snapCheck
        snapobject:addEventListener("collision")
        snapobject:addEventListener("touch",moveSnap)



        
        

    end
return snapping