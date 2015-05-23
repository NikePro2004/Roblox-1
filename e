Mouse = game.Players.LocalPlayer:GetMouse()
P = game.Players.LocalPlayer.Character
georgeyeo89 = "Player"

Cannon = Instance.new("Part" ,game.Workspace.georgeyeo89)
Cannon.BrickColor = BrickColor.new("Black")
Cannon.Size = Vector3.new(1,2.5,1)
Cannon.TopSurface = "Smooth"
Cannon.BottomSurface = "Smooth"
W1 = Instance.new("Weld",Cannon)
W1.Part0 = game.Workspace.georgeyeo89:FindFirstChild("Right Arm")
W1.Part1 = Cannon
local RA = game.Workspace.georgeyeo89.Torso["Right Shoulder"]
local RS = game.Workspace.georgeyeo89:FindFirstChild("Right Arm")
--RA.C0 = RA.C0 * CFrame.Angles(0,0,1.6)
 
Tool = Instance.new("Tool",game.Workspace.georgeyeo89)
Tool.Name = "Cannon"
 
Mouse.KeyDown:connect(function(key)
	if key == "g" then
                local c = game.Workspace.georgeyeo89
                        --y = Instance.new("SpecialMesh",x)
                        --y.MeshType = "Sphere"
                        --y.Scale = Vector3.new(0.7,0.7,0.7)
                        --SNarZ = script:WaitForChild("SNarZ")
                                --local animationTrack = Player.Character.Humanoid:LoadAnimation(SNarZ)
                                local Yui = true
                                wait()
                                game.Workspace.georgeyeo89.Humanoid.WalkSpeed = 1
                                S = Instance.new("Sound")
                        S.Parent = game.Workspace.georgeyeo89.Torso
                        S.Volume = 1
                        S.Pitch = 1
                        S.SoundId = "http://www.roblox.com/asset/?id=189132936"
                        --S.Parent = x
                        S:Play()
                        game.Workspace.georgeyeo89.Humanoid.WalkSpeed = 1
                        local LA = game.Workspace.georgeyeo89.Torso["Left Shoulder"]
                        local RA = game.Workspace.georgeyeo89.Torso["Right Shoulder"]
                        LA.C0 = LA.C0 *  CFrame.Angles(0,0,-1.6)
                        for i = 1,2 do
                        if game.Workspace.georgeyeo89.Humanoid.WalkSpeed ~= 1 then
                                game.Workspace.georgeyeo89.Humanoid.WalkSpeed = 1
                        end
                        LA.C0 = LA.C0 * CFrame.Angles(0.4,0,0)
                        RA.C0 = RA.C0 * CFrame.Angles(0,0.4,0)
                        wait()
                        end
                        for i = 1,4 do
                                --_G.Q = 0.8
                                --x.Size = Vector3.new(_G.Q,_G.Q,_G.Q)
                        LA.C0 = LA.C0 * CFrame.Angles(0,0.05,0)
                        RA.C0 = RA.C0 * CFrame.Angles(0,0.05,0)
                        wait()
                        end
                        game.Workspace.georgeyeo89.Humanoid.WalkSpeed = 1
                        wait(.3)
                        x = Instance.new("Part")
                        x.Name = "SNarZ"
                        x.FormFactor = "Symmetric"
                        x.Size = Vector3.new(1,1,1)
                        x.TopSurface = "Smooth"
                        x.BottomSurface = "Smooth"
                        x.BrickColor = BrickColor.new("Pastel light blue")
                        x.CanCollide = false
                        x.Reflectance = 0.3
                        x.Parent = c
                        x.Transparency = 0.3
                        x.Shape = "Ball"
                        --f = game.Lighting.SNarZ:Clone()
                        f = Instance.new("Fire" ,x)
                        --f.Parent = x
                        f.Size = 2
                        f.Heat = 0
                        f.Color = Color3.new(.35,.6,1)
                        f.SecondaryColor = Color3.new(.35,.6,1)
                        game.Debris:AddItem(x,7.25)
                        w1 = Instance.new("Weld",c)
                        w1.Part0 = w1.Parent["Right Arm"]
                        w1.Part1 = x
                        w1.C1 = CFrame.fromEulerAnglesXYZ(0,0,0) *CFrame.new(0,1.5,0)
                        wait(1.25)
                        S:Remove()
                        game.Workspace.georgeyeo89.Humanoid.WalkSpeed = 1
                        for i = 1,4 do
                                --_G.Q = 0.8
                                --x.Size = Vector3.new(_G.Q,_G.Q,_G.Q)
                        LA.C0 = LA.C0 * CFrame.Angles(0,-0.05,0)
                        RA.C0 = RA.C0 * CFrame.Angles(0,-0.05,0)
                        wait()
                        end
                        wait(.3)
                        for i = 1,2 do
                                --_G.Q = 0.8
                                --x.Size = Vector3.new(_G.Q,_G.Q,_G.Q)
                        LA.C0 = LA.C0 * CFrame.Angles(-0.4,0,0)
                        RA.C0 = RA.C0 * CFrame.Angles(0,-0.4,0)
                        wait()
                        end
                        LA.C0 = LA.C0 *  CFrame.Angles(0,0,1.6)
                        x.Anchored = false
                        game.Workspace.georgeyeo89.Humanoid.WalkSpeed = 60
                        ----------------------------------------
                        local Lul = 1
                        local App = 0
                        if game.Workspace.georgeyeo89.Humanoid.WalkSpeed ~= 60 then
                                                        game.Workspace.georgeyeo89.Humanoid.WalkSpeed = 60
                                                        end
                        function DMG (hit)
                                DMG = 7.5
                                while Lul == 1 do
                                        if hit.Parent.Humanoid and Lul == 1 then
                                                Lul = 0
                                                x:remove()
                                                b = Instance.new("Part",hit.Parent.Torso)
                                                b.Size = Vector3.new(1,1,1)
                                                b.Transparency = 0.5
                                                b.TopSurface = "Smooth"
                                                b.BottomSurface = "Smooth"
                                                b.BrickColor = BrickColor.new("Pastel light blue")
                                                b.CanCollide = false
                                                b.FormFactor = "Symmetric"
                                                b.Shape = "Ball"
                                                bb = Instance.new("SpecialMesh",b)
                                                bb.MeshType = "Sphere"
                                                game.Debris:AddItem(b,2)
                                                w0 = Instance.new("Weld",b)
                                                w0.Part0 = b
                                                w0.Part1 = hit.Parent.Torso
                                                w0.C0 = CFrame.fromEulerAnglesXYZ(0,0,0) *CFrame.new(0,0,0)
                                                game.Debris:AddItem(b,2)
                                                local U = 8
                                                for i = 1,10 do
                                                        hit.Parent.Humanoid.Health = hit.Parent.Humanoid.Health - DMG
                                                        wait(0.000001)
                                                end
                                                bb.Scale = Vector3.new(8,8,8)
                                                for i = 1,10 do
                                                w0.Part1 = hit.Parent.Torso
                                                w0.C0 = CFrame.fromEulerAnglesXYZ(0,0,0) *CFrame.new(0,0,0)
                                                U = U + .7
                                                bb.Scale = Vector3.new(U,U,U)
                                                w0 = Instance.new("Weld",b)
                                                w0.Part0 = b
                                                w0.Part1 = hit.Parent.Torso
                                                w0.C0 = CFrame.fromEulerAnglesXYZ(0,0,0) *CFrame.new(0,0,0)
                                                wait(.1)
                                                end
                                                --script.Parent.Charge.Disabled = false
                                                game.Workspace.georgeyeo89.Humanoid.WalkSpeed = 16
                                        end
                                end
                        end
                        if game.Workspace.georgeyeo89.Humanoid.WalkSpeed ~= 60 then
                                                        game.Workspace.georgeyeo89.Humanoid.WalkSpeed = 60
                                                        end
                        game.Workspace.georgeyeo89.Humanoid.WalkSpeed = 60
                        x.Touched:connect(DMG)
                        wait(5)
                        game.Workspace.georgeyeo89.Humanoid.WalkSpeed = 16
                        end
         
        end)
