local composer = require("composer")

local scene = composer.newScene()


-- TODO : Search bloodDict
        
local bloodDictionary = {}
-- + (A,B)
bloodDictionary["A+"] = {"A+","O+","A-","O-"}
bloodDictionary["B+"] = {"B+","O+","B-","O-"}
-- - (A,B)
bloodDictionary["A-"] = {"A-","O-"}
bloodDictionary["B-"] = {"B-","O-"}

-- + - AB
bloodDictionary["AB+"] = {"A+","O+","B+","B-","A-","O-","AB+","AB-"}
bloodDictionary["AB-"] = {"B-","A-","O-","AB-"}

-- + - O
bloodDictionary["O+"] = {"O+","O-"}
bloodDictionary["O-"] = {"O-"}

local donorTable = {}
local heartTable = {}

local levelObjs = {}
    function levelObjs.new(group,x,y,type,repetition)
        if type == "bg" then
            local bg 
            bg:toBack()
        end

        local bloodtype = math.random(1,4)
        local rh = math.random(1,2)

        -- Receiver (Heart)
        if type == "receiver" then

            heartCount = repetition

            for i = 1, repetition, 1 do
                local heart = display.newImageRect(group,"Imagens/Hospital/Heart_symbol_c00.png",256/12,256/12)
                heart:setFillColor(1,0,0)
                heart.x = x 
                heart.y = (y + 90) - 60 * i
                heart.id = "receiver"
                physics.addBody(heart,"static")
                heart.isFixedRotation = true

                local bloodtype = math.random(1,4)
                local rh = math.random(1,2)
                if bloodtype == 1 then
                    if rh == 1 then
                        
                        heart.name = "A+"
                    else
                        
                        heart.name = "A-"
                    end

                elseif bloodtype == 2 then
                    if rh == 1 then
                        
                        heart.name = "B+"
                    else
                        
                        heart.name = "B-"
                    end

                elseif bloodtype == 3 then
                    if rh == 1 then
                        
                        heart.name = "AB+"
                    else
                        
                        heart.name = "AB-"
                    end

                elseif bloodtype == 4 then
                    if rh == 1 then
                        
                        heart.name = "O+"
                    else
                        
                        heart.name = "O-"
                    end
                    
                end
                local heartText = display.newText(group,heart.name,x + 3,(y + 110) - 60 * i,native.systemFont,20)
                heartText:setFillColor(1,0.4,0.6)
                -- DonorTable
                table.insert(heartTable,heart)
                table.insert(heartTable,heartText)
            end
        end

        -- Donor

        if type == "donor" then
        
            donorCount = repetition

            for i = 1, repetition , 1 do
                local donor = display.newImageRect(group,"Imagens/Hospital/blood_bag.png",675/30,1200/30)
                donor.x = x
                donor.y = (y - 40) + 40 * i
                donor.id = "donor"
                physics.addBody(donor,"dynamic")

                local bloodtype = math.random(1,4)
                local rh = math.random(1,2)
                if bloodtype == 1 then
                    if rh == 1 then
                        
                        donor.name = "A+"
                    else
                        
                        donor.name = "A-"
                    end

                elseif bloodtype == 2 then
                    if rh == 1 then
                        
                        donor.name = "B+"
                    else
                        
                        donor.name = "B-"
                    end

                elseif bloodtype == 3 then
                    if rh == 1 then
                        
                        donor.name = "AB+"
                    else
                        
                        donor.name = "AB-"
                    end

                elseif bloodtype == 4 then
                    if rh == 1 then
                        
                        donor.name = "O+"
                    else
                        
                        donor.name = "O-"
                    end
                    
                end

                local donorText = display.newText(group,donor.name,x + 35,y + 5,native.systemFont,20)
                donorText:setFillColor(0.6,0.3,0.8)

                local function donorTextpos(event)
                    if donorText.x ~= nil then
                        donorText.x = donor.x + 35
                        donorText.y = donor.y + 5
                    end

                end
                Runtime:addEventListener("enterFrame",donorTextpos)
                local startX, startY = nil

                local function donorclick(event)

                    if event.phase == "began" and event.target.OffsetX == nil then
                        display.currentStage:setFocus(event.target)
                        startX, startY = event.x, event.y
                        event.target.touchOffsetX = event.x - event.target.x
                        event.target.touchOffsetY = event.y - event.target.y
                    elseif event.phase == "moved" then
                        event.target.x = event.x - event.target.touchOffsetX
                        event.target.y = event.y - event.target.touchOffsetY
                    elseif event.phase == "ended" or phase == "cancelled" then
                        display.currentStage:setFocus(nil)
                    end
                    return true
                end

                function table.contains(table, element)
                    for _, value in pairs(table) do
                    if value == element then
                        return true
                    end
                    end
                    return false
                end

                local function donorCollision(self,event)
                    if event.phase == "began" and event.other.id == "receiver" then
                        if table.contains(bloodDictionary[event.other.name],self.name) then
                            timer.performWithDelay(10,function() 
                                scoreUpdate(group,"+")
                                Runtime:removeEventListener("enterFrame",donorTextpos)
                                donorText:removeSelf() 
                                donor:removeSelf()                        
                            end)
                        else
                            timer.performWithDelay(10,function() 
                                scoreUpdate(group,"-")
                                Runtime:removeEventListener("enterFrame",donorTextpos)
                                donorText:removeSelf() 
                                donor:removeSelf()                        
                            end)
                        end
                        donorCount = donorCount - 1
                    end
                end
                local function repeated(event)
                    if heartCount == 0 then
                        levelObjs.new(group,display.contentCenterX + 180, display.contentHeight - 90,"receiver",5)
                        Runtime:removeEventListener("enterFrame",repeated)
                    end
                    if donorCount == 0 then
                        levelObjs.new(group,50, display.contentCenterY - 100,"donor",5)
                        Runtime:removeEventListener("enterFrame",repeated)
                    end
                end
                Runtime:addEventListener("enterFrame",repeated)
                donor:addEventListener("touch", donorclick)

                donor.collision = donorCollision
                donor:addEventListener("collision")

                -- DonorTable
                table.insert(donorTable,donor)
                table.insert(donorTable,donorText)
            end
        end

    end
    function levelObjs:menu(group,x,y,number)
        local button = display.newRoundedRect(group,x,y,50,30,15)
        local buttonText = display.newText(group,"Ajuda",x,y,native.systemFont,15)
        buttonText:setFillColor(0.5,0.6,0.6)
        local function menutap(event)
            composer.setVariable("number",number)
            composer.showOverlay("Levels.menu",{effect = "fromTop", time = 500, isModal = true})
        end
        button:addEventListener("tap",menutap)
    end

    function levelObjs:reload(group,x,y)
        local reloadBut = display.newImageRect(group,"Imagens/Hospital/arrows.png",128/6,128/6)
        reloadBut.x = x
        reloadBut.y = y
        reloadBut.alpha = 0.4


        local function reloadAll(event)
            for i = #donorTable, 1, -1 do
                if donorTable[i] ~= nil then
                    display.remove(donorTable[i])
                end
            end
            donorCount = 0
            for i = #heartTable, 1, -1 do
                if heartTable[i] ~= nil then
                    display.remove(heartTable[i])
                end
            end
            heartCount = 0

        end
        reloadBut:addEventListener("touch",reloadAll)
    end
return levelObjs