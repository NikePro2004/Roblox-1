bin = script.Parent
h = Instance.new("Hint")
h.Text = "Click to start playing"
mouse = nil
sel = false
clicked = false
dblclicked = false
mdbct = 10
dbct = 10
play = false
mnam = 15 --Amount of mines
mine = { }
mv = 0 --Amount of moves
finished = false

function LoadBoard()
	print("Loading board")
	for a = 1, mnam do --mnam = amount of mines
		local x = math.random(1, 9) --Position on grid
		local y = math.random(1, 9)
		if (#mine > 0) then --Check all the previous so there isn't 2 mines in the same spot
			for _, b in pairs(mine) do
				if (b[1] == x) and (b[2] == y) then --Mine already in that spot
					x = x + math.random(-2, 2) --Re-place it
					y = y + math.random(-2, 2) --Re-place it
				end
			end
		end
		mine[#mine + 1] = {x, y}
	end
	for _, a in pairs(game.Workspace.Board:GetChildren()) do --Loop through all the grid and place the mines
		for _, b in pairs(mine) do
			if (string.gsub(a.Name, "Row", "") == tostring(b[2])) then --Found y
				for _, c in pairs(a:GetChildren()) do
					if (c.Name == tostring(b[1])) then --Found x
						c.Mine.Value = true
						--c.Decal.Texture = game.Workspace.Decals.DecalMine.Decal.Texture --This line is for testing purposes
					end
				end
			end
		end
	end
	for _, a in pairs(game.Workspace.Board:GetChildren()) do --Now find how many mines are around each piece
		local r = a.Name:gsub("Row", "")
		local rw = tonumber(r)
		for _, b in pairs(a:GetChildren()) do
			if not b.Mine.Value then
				local cm = tonumber(b.Name)
				local mn = 0
				local tbl = { }
				if (rw < 9) then --Go up a row
					tbl[#tbl + 1] = {cm, rw + 1}
					if (cm > 1) then
						tbl[#tbl + 1] = {cm - 1, rw + 1}
					end
					if (cm < 9) then
						tbl[#tbl + 1] = {cm + 1, rw + 1}
					end
				end
				if (rw > 1) then --Go down a row
					tbl[#tbl + 1] = {cm, rw - 1}
					if (cm > 1) then
						tbl[#tbl + 1] = {cm - 1, rw - 1}
					end
					if (cm < 9) then
						tbl[#tbl + 1] = {cm + 1, rw - 1}
					end
				end
				if (cm > 1) then --Current row
					tbl[#tbl + 1] = {cm - 1, rw}
				end
				if (cm < 9) then
					tbl[#tbl + 1] = {cm + 1, rw}
				end
				for _, c in pairs(tbl) do --Loop through the table
					if game.Workspace.Board:findFirstChild("Row"..c[2]) then --Find the piece
						local row = game.Workspace.Board["Row"..c[2]]
						if row:findFirstChild(c[1]) then
							local col = row[c[1]]
							if col.Mine.Value then --If it a mine
								mn = mn + 1 --Increase the value
							end
						end
					end
				end
				b.MinesAround.Value = mn --Set the value
				--[[if (mn > 0) then
					b.Decal.Texture = game.Workspace.Decals["Decal"..mn].Decal.Texture --Testing purposes, change the decal
				end]]
				mn = 0
				tbl = { }
			end
		end
	end
end			

function SingleClick()
	if not play then
		if not finished then
			play = true
			LoadBoard()
		end
	end
	if finished then
		h.Text = "Click to start playing"
		--Clear up board
		for _, a in pairs(game.Workspace.Board:GetChildren()) do
			for _, b in pairs(a:GetChildren()) do
				b.Clicked.Value = false
				b.Mine.Value = false
				b.MinesAround.Value = 0
				b.Decal.Texture = ""
				b.BrickColor = BrickColor.new("Pastel Blue")
			end
		end
		for _, a in pairs(game.Workspace:GetChildren()) do
			if (a.Name == "Boom") then
				a:remove()
			end
		end
		mv = 0
		mine = { }
		finished = false
		play = false
	end
	if play then
		local t = mouse.Target
		if t then
			if t.Parent.Name:find("Row") then
				if (t.Parent.Parent.Name == "Board") then
					if not t.Clicked.Value then
						t.Clicked.Value = true
						if not t.Mine.Value then
							print("Not mine")
							if (t.MinesAround.Value > 0) then
								t.Decal.Texture = game.Workspace.Decals["Decal"..t.MinesAround.Value].Decal.Texture
							end
							t.BrickColor = BrickColor.new("Medium stone grey")
							mv = mv + 1
							h.Text = ""..t.MinesAround.Value.." surrounding mine"..string.rep("s", (t.MinesAround.Value == 0 or t.MinesAround.Value > 1) and 1 or 0).." - "..mv.." moves"
							--See if they won
							local wn = true
							for _, a in pairs(game.Workspace.Board:GetChildren()) do
								for _, b in pairs(a:GetChildren()) do
									if not b.Mine.Value then
										if not b.Clicked.Value then
											print("Not won")
											wn = false
											break
										end
									end
								end
							end
							if wn then
								print("Won")
								for _, a in pairs(game.Workspace.Board:GetChildren()) do
									for _, b in pairs(a:GetChildren()) do
										if b.Mine.Value then
											b.Decal.Texture = game.Workspace.Decals.DecalMine.Decal.Texture --Uncover all the mines
											local c = game.Workspace.BoomTemplate:Clone()
											c.Name = "Boom"
											c.Parent = game.Workspace
											c.Position = b.Position - Vector3.new(0, 0, -0.7)
											c.BrickColor = BrickColor.new("Bright green")
										end
									end
								end
								h.Text = "Congratulations! You have won in "..mv.." moves! Click to reset the game"
								finished = true
								play = false
							end
						else
							if (mv > -1) then --If it isn't the first move
								print("Mine")
								for _, a in pairs(game.Workspace.Board:GetChildren()) do
									for _, b in pairs(a:GetChildren()) do
										if b.Mine.Value then
											b.BrickColor = BrickColor.new("Medium stone grey")
											b.Decal.Texture = game.Workspace.Decals.DecalMine.Decal.Texture --Uncover all the mines
											local c = game.Workspace.BoomTemplate:Clone()
											c.Name = "Boom"
											c.Parent = game.Workspace
											c.Position = b.Position - Vector3.new(0, 0, -0.7)
										end
									end
								end
								h.Text = "Game Over! Click to reset the game"
								finished = true
								play = false
							end
						end
					end
					--h.Text = ""..t.Name.."-"..(t.Parent.Name:gsub("Row", "")).." -- "..tostring(t.Mine.Value).." -- "..t.MinesAround.Value..""
				end
			end
		end
	end
end

function DoubleClick()
	print("Double click")
	dblclicked = false
end

bin.Selected:connect(function (m)
	mouse = m
	sel = true
	h.Parent = game.Players.LocalPlayer
	mouse.Button1Down:connect(function ()
		if not clicked then
			clicked = true
		elseif clicked then
			clicked = false
			dblclicked = true
			dbct = mdbct
			DoubleClick()
		end
	end)
	while sel do
		wait()
		if clicked then
			dbct = dbct - 1
			if (dbct < 0) then
				dbct = mdbct
				clicked = false
				dblclicked = false
				SingleClick()
			end
		else
			dbct = mdbct
			clicked = false
			dblclicked = false
		end
	end
end)

bin.Deselected:connect(function ()
	mouse = nil
	sel = false
end)
