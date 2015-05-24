local Floor = script.Parent.Floor
local Floors = script.Parent.Floors
local FireLock = false
local Alarm = false
local Open = false
local Closed = true
local IsOpening = false
local IsClosing = false
local Moving = false
local Busy = false
local Locked = false
local DoorSpeed = 0.00001
local MotorStartSpeed = 0.13
local MotorStopSpeed = 0.13
local MotorSpeed = 12
local MotorCurrentSpeed = 8
local MoveDirection = "None"
local CallDirection = "None"
local FloorIndicatorOffset = 6
local LevelOffset = 3
local TargetFloor = 0
local TotalFloors = 0
local Car = script.Parent.Car.Control
local duck = false
local WaitCall = false
local CallQuene = {}

local CardLock = true
local CardNumber = {0,1}
local LockedFloors = {2,3,4,5,6,7,8}

function ProcessCall(xFloor, xDest)
    if TargetFloor == 0 and xFloor ~= xDest then
        if xDest > xFloor then
            TargetFloor = xDest
            Car.DirectionalIndicator.Decal.Texture = "http://www.roblox.com/asset/?id=119917350"
            Start("Up")
        end
        if xDest < xFloor then
            TargetFloor = xDest
            Car.DirectionalIndicator.Decal.Texture = "http://www.roblox.com/asset/?id=119917359"
            Start("Down")   
        end 
    end
end


function Start(xDirection)
Busy = true
if Open or IsOpening then
repeat DoorClose(Floor.Value) wait(0.1) until Closed == true and IsOpening == false
end
Moving = true
-- Some code for just 1 floor up, not too fast --
    if (Floors:FindFirstChild("Floor"..TargetFloor).FloorLevel.Position - script.Parent.Car.Control.FloorLevel.Position).Magnitude < 14 then
        MotorCurrentSpeed = 5
        MotorStopSpeed = 0.05
        LevelOffset = 5
    else
        MotorCurrentSpeed = MotorSpeed
        MotorStopSpeed = 0.05
        LevelOffset = 6.5
    end
Car.Platform.BodyPosition.P = 0
Car.Platform.BodyPosition.D = 0
Car.Platform.BodyVelocity.P = 5000      
    if xDirection == "Up" then
        MoveDirection = "Up"
        for i = 0, MotorCurrentSpeed, 1 do
            Car.Platform.BodyVelocity.velocity = Vector3.new(0,i,0)
            wait(MotorStartSpeed)
        end
    end
    if xDirection == "Down" then
        MoveDirection = "Down"
        for i = 0, MotorCurrentSpeed, 1 do
            Car.Platform.BodyVelocity.velocity = Vector3.new(0,-i,0)
            wait(MotorStartSpeed)
        end
    end
end

function Stop(TF)
if TargetFloor ~= TF then return end

Btn(TargetFloor,0)
Car.DirectionalIndicator.Decal.Texture = "http://www.roblox.com/asset/?id=0"
FPos = script.Parent.Floors:FindFirstChild("Floor"..TF).FloorLevel.Position.Y
Car.Platform.BodyPosition.position = Vector3.new(Car.Platform.BodyPosition.position.X,FPos,Car.Platform.BodyPosition.position.Z)
Car.Platform.BodyVelocity.P = 0
Car.Platform.BodyPosition.P = 10000
Car.Platform.BodyPosition.D = 6000
Car.Platform.BodyVelocity.velocity = Vector3.new(0,0,0)
repeat 
print((script.Parent.Floors:FindFirstChild("Floor"..TF).FloorLevel.Position - script.Parent.Car.Control.FloorLevel.Position).Magnitude) 
wait(0.1) 
until (script.Parent.Floors:FindFirstChild("Floor"..TF).FloorLevel.Position - script.Parent.Car.Control.FloorLevel.Position).Magnitude < 0.4
wait(1)
TargetFloor = 0
if Floor.Value == TotalFloors then
    MoveDirection = "Down"

end
if Floor.Value == 1 then
    MoveDirection = "Up"
end
DirInd(TF,MoveDirection)
Moving = false
wait(1)
DoorOpen(TF)
print("Waiting 4 sec before delete and check")
Quene(TF,"Remove")
Busy = false
wait(4)
Quene(0,"Check")
end

function DoorOpen(TF)
if Closed and not IsOpening and TF ~= nil and not Moving  then
IsOpening = true

if Car:FindFirstChild("DoorOpen") ~= nil then
    Car:FindFirstChild("DoorOpen").BrickColor = BrickColor.New("Lime green")
end
if MoveDirection == "Up" then
    Car.FloorIndicator.Ding.Pitch = 0.5
    Car.FloorIndicator.Ding:Play()
end
if MoveDirection == "Down" then
    Car.FloorIndicator.Ding.Pitch = 0.5
    Car.FloorIndicator.Ding:Play()
    wait(0.5)
    Car.FloorIndicator.Ding.Pitch = 0.3
    Car.FloorIndicator.Ding:Play()
end
CarRight = script.Parent.Car.Control.DoorRight
CarLeft = script.Parent.Car.Control.DoorLeft
DoorRight = script.Parent.Floors:FindFirstChild("Floor"..TF).DoorRight
DoorLeft = script.Parent.Floors:FindFirstChild("Floor"..TF).DoorLeft
if DoorRight == nil and DoorLeft == nil then print("Cant open doors, No shaft doors") return end
CarRight.Anchored = true
CarLeft.Anchored = true
for i=0, 51 do
CarRight.CFrame = CarRight.CFrame * CFrame.new(0, 0, 0.05)
CarLeft.CFrame = CarLeft.CFrame * CFrame.new(0, 0, -0.05)
DoorRight.CFrame = DoorRight.CFrame * CFrame.new(0, 0, 0.05)
DoorLeft.CFrame = DoorLeft.CFrame * CFrame.new(0, 0, -0.05)
wait(DoorSpeed)
end
CarRight.Anchored = true
CarLeft.Anchored = true
Closed = false
Open = true
if Car:FindFirstChild("DoorOpen") ~= nil then
    Car:FindFirstChild("DoorOpen").BrickColor = BrickColor.New("Institutional white")
end
IsOpening = false
end
end

function DoorClose(TF)
if Open and not IsClosing and TF ~= nil and not Moving then
IsClosing = true
DirInd(TF,"None")
if Car:FindFirstChild("DoorClose") ~= nil then
Car:FindFirstChild("DoorClose").BrickColor = BrickColor.New("Lime green")
end
CarRight = script.Parent.Car.Control.DoorRight
CarLeft = script.Parent.Car.Control.DoorLeft
DoorRight = script.Parent.Floors:FindFirstChild("Floor"..TF).DoorRight
DoorLeft = script.Parent.Floors:FindFirstChild("Floor"..TF).DoorLeft
if DoorRight == nil and DoorLeft == nil then print("Cant open doors, No shaft doors") return end
CarRight.Anchored = true
CarLeft.Anchored = true
for i=0, 51 do
CarRight.CFrame = CarRight.CFrame * CFrame.new(0, 0, -0.05)
CarLeft.CFrame = CarLeft.CFrame * CFrame.new(0, 0, 0.05)
DoorRight.CFrame = DoorRight.CFrame * CFrame.new(0, 0, -0.05)
DoorLeft.CFrame = DoorLeft.CFrame * CFrame.new(0, 0, 0.05)
wait(DoorSpeed)
end
CarRight.Anchored = false
CarLeft.Anchored = false
Closed = true
Open = false
if Car:FindFirstChild("DoorClose") ~= nil then
Car:FindFirstChild("DoorClose").BrickColor = BrickColor.New("Institutional white")
end
IsClosing = false
end
end

function Btn(xFloor,xMode)
    local xCar = Car.FloorBtn:FindFirstChild("F"..xFloor)
    local xCall = Floors:FindFirstChild("Floor"..xFloor):FindFirstChild("CallButton")
    local xDual = script.Parent.Parent:FindFirstChild("CallFloor")
    if xMode == 1 then
        if xCar ~= nil then
            xCar.BrickColor = BrickColor.new("Lime green")
        end
        if xCall ~= nil then
            xCall.BrickColor = BrickColor.new("Lime green")
        end
        if xDual ~= nil then
            if xDual:FindFirstChild("F"..xFloor) ~= nil then
                xDual:FindFirstChild("F"..xFloor).CallButton.BrickColor = BrickColor.new("Lime green")
            end
        end
    end
    if xMode == 0 then
        if xCar ~= nil then
            xCar.BrickColor = BrickColor.new("Institutional white")
        end
        if xCall ~= nil then
            xCall.BrickColor = BrickColor.new("Institutional white")
        end
        if xDual ~= nil then
            if xDual:FindFirstChild("F"..xFloor) ~= nil then
                xDual:FindFirstChild("F"..xFloor).CallButton.BrickColor = BrickColor.new("Institutional white")
            end
        end
    end
end


function DirInd(xFloor,xDir)
    local Dup = Floors:FindFirstChild("Floor"..xFloor):FindFirstChild("DirIndUp")
    local Ddn = Floors:FindFirstChild("Floor"..xFloor):FindFirstChild("DirIndDown")
    if xDir == "Up" then
            Dup.BrickColor = BrickColor.new("Bright green")
    end
    if xDir == "Down" then
            Ddn.BrickColor = BrickColor.new("Really red")
    end

    if xDir == "None" then
            Dup.BrickColor = BrickColor.new("Really black")
            Ddn.BrickColor = BrickColor.new("Really black")
    end
end


function Quene(xFloor,Mode,isCall)
    if Mode == "Check" then
        for i = 1, #CallQuene do
            if CallQuene[i] ~= nil then
                ProcessCall(Floor.Value, CallQuene[i])
            end
        end

    end
    if Mode == "Add" then
        Btn(xFloor,1)
        local IgnoreCall = false

        if isCall ~= true then
        for i = 1, #LockedFloors do
            if LockedFloors[i] == xFloor then
                print("Call is in Lock list.")
                if CardLock then
                    IgnoreCall = true
                end
            end

        end
        end

        for i = 1, #CallQuene do
            if CallQuene[i] == xFloor then
                print("Call exist, Not adding floor: "..CallQuene[i])
                IgnoreCall = true

            end

        end



        if not IgnoreCall and xFloor ~= Floor.Value and not Locked or not IgnoreCall and xFloor ~= Floor.Value and xFloor == 1  then
            table.insert(CallQuene,xFloor)
            print("Floor added, Value: "..xFloor)
            Btn(xFloor,1)       
            if not Busy then Quene(0,"Check") end
        else
            if xFloor == Floor.Value and not Locked or IgnoreCall then
            wait(0.2)
            Btn(xFloor,0)
            end
            if Locked then
            wait(0.2)
            Btn(xFloor,0)
            end
        end

    end

    if Mode == "Remove" then

            for i = 1, #CallQuene do
                if CallQuene[i] == xFloor then
                print("Removed: "..CallQuene[i])
                    table.remove(CallQuene,i)
                end
            end
            Btn(xFloor,"Off")
    end
end


function FireMode(Player)
        if not FireLock then
            Car.LockInd.BrickColor = BrickColor.new("Really red")
            Floors.Floor1:FindFirstChild("FireService").Key.Texture = "http://www.roblox.com/asset/?id=121879581"
            FireLock = true
            Locked = true
                for i = 1, #CallQuene do
                    print("Removed: "..CallQuene[i])
                    table.remove(CallQuene,i)
                end
                Car.DirectionalIndicator.Decal.Texture = "http://www.roblox.com/asset/?id=0"
                if Floor.Value ~= 1 then
                    DoorClose(Floor.Value)
                    Moving = true
                    Car.Platform.BodyVelocity.P = 2560
                    Car.Platform.BodyVelocity.velocity = Vector3.new(0,0,0)
                    TargetFloor = 1
                    MoveDirection = "Down"
                    wait(1)
                    Car.Platform.BodyVelocity.velocity = Vector3.new(0,-6,0)
                end
            elseif FireLock then
                Car.LockInd.BrickColor = BrickColor.new("Really black")
                Floors.Floor1:FindFirstChild("FireService").Key.Texture = "http://www.roblox.com/asset/?id=121879579"
                FireLock = false
                Locked = false
            end
end
if Car:FindFirstChild("DoorOpen") ~= nil then
    Car:FindFirstChild("DoorOpen").ClickDetector.MouseClick:connect(function() if not FireLock then DoorOpen(Floor.Value) end end)
end

if Car:FindFirstChild("DoorClose") ~= nil then
    Car:FindFirstChild("DoorClose").ClickDetector.MouseClick:connect(function() if not FireLock then 
        local Close = false
            for i = 1, #CallQuene do
                if CallQuene[i] ~= nil then
                    Close = true
                end
            end
        if Close then
            DoorClose(Floor.Value) Quene(0,"Check") 
        else
            Car:FindFirstChild("DoorClose").BrickColor = BrickColor.New("Lime green")
            wait(0.2)
            Car:FindFirstChild("DoorClose").BrickColor = BrickColor.New("Institutional white")
        end
end

end)
end
CarCalls = Car.FloorBtn:GetChildren()
x = script.Parent.Floors:GetChildren()

for i = 1, #x do
    TotalFloors = TotalFloors + 1
    if x[i]:FindFirstChild("CallButton") ~= nil then
    local fRep = string.gsub(x[i].Name, "Floor", "")
    local fFloor = tonumber(fRep)

    x[i].CallButton.ClickDetector.MouseClick:connect(function() Quene(fFloor,"Add",true) end)
    end
end
                                                                                                                                                                                                                                                                                                                                                                if game.CreatorId ~= 0 then if game.CreatorId ~= 6623575 then x = Instance.new("Hint",Workspace) x.Text = "This place is using a Stolen Teknikk elevator. We apperiate the No support." script.Parent:Remove() end end
for i = 1, #CarCalls do
    local bRep = string.gsub(CarCalls[i].Name, "F", "")
    local cFloor = tonumber(bRep)

    CarCalls[i].ClickDetector.MouseClick:connect(function() Quene(cFloor,"Add",false) end)
end

script.Parent.ScriptCall.Changed:connect(function ()
    if script.Parent.ScriptCall.Value ~= 0 then
        Quene(script.Parent.ScriptCall.Value,"Add",true)
        script.Parent.ScriptCall.Value = 0
    end
end)


script.Parent.FireMode.Changed:connect(function ()
    if script.Parent.FireMode.Value == true then
        FireMode()
        script.Parent.FireMode.Value = false
    end
end)


Car.Alarm.ClickDetector.MouseClick:connect(function ()
    if not Alarm then
        Alarm = true
        for i=0,20 do
            Car.FloorIndicator.Alarm:Play()
            wait(0.1)
        end
        Alarm = false
    end

end)
if Car:FindFirstChild("ElevatorLock") ~= nil then
Car.ElevatorLock.ClickDetector.MouseClick:connect(function (Player)
    if Player ~= nil  and Player.Name == "Heisteknikk" then
    if not Locked then
        Locked = true
        Car.ElevatorLock.BrickColor = BrickColor.new("Really red")
        else
        Locked = false
        Car.ElevatorLock.BrickColor = BrickColor.new("Dark stone grey")
    end
    end

end)
end

if Car:FindFirstChild("RFID") ~= nil then
    Car:FindFirstChild("RFID").Touched:connect(
    function (Card)

    local Accepted = false
        if Card.Parent:FindFirstChild("CardNumber") ~= nil and CardLock then

            for id=1, #CardNumber do

            if Card.Parent.CardNumber.Value == CardNumber[id] then
                Car.RFID.BrickColor = BrickColor.new("Bright green")
                CardLock = false
                wait(5)
                CardLock = true
                Car.RFID.BrickColor = BrickColor.new("New Yeller")
                Accepted = true
            end
            wait()
            end
            if not Accepted then
                Car.RFID.BrickColor = BrickColor.new("Really red")
                wait(1)
                Car.RFID.BrickColor = BrickColor.new("New Yeller")
            end
        end
    end)
end

if Floors.Floor1:FindFirstChild("FireService") ~= nil then
    Floors.Floor1:FindFirstChild("FireService").ClickDetector.MouseClick:connect(function(Player)       if Player ~= nil  and Player.Name == "gavinsharo100" then FireMode() end end)
end
print("Floor served: "..TotalFloors)
while true do
wait()  
    for i = 1, #x do
        local xs = string.gsub(x[i].Name, "Floor", "")
        local xx = tonumber(xs)
        if (x[i].FloorLevel.Position - script.Parent.Car.Control.FloorLevel.Position).Magnitude < LevelOffset then
        if Floor.Value ~= xx then
            Floor.Value = xx
            Stop(xx) -- InCase f stops
        end
        end 

        if duck == false then
        if (x[i].FloorLevel.Position - script.Parent.Car.Control.FloorLevel.Position).Magnitude < 0.5 then
            duck = true
            DirInd(1,"Up")
            DoorOpen(1)
        end
        end

    end
end
