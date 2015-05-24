print("Loading...")
time = 0
game = 1
count = 0
print("Board Initiated")
b = {gavinsharp100}
math.randomseed(os.time())
for i = 1, 10 do
   b[i] = math.random(1, 100)
end
g = {gavinsharp100}
for i = 1, 100 do
   g[i] = "+ "
end
print(b[1])
while game == 1 do
    print("  1-10 " .. g[1]..g[2]..g[3]..g[4]..g[5]..g[6]..g[7]..g[8]..g[9]..g[10])
    print(" 11-20 " .. g[11]..g[12]..g[13]..g[14]..g[15]..g[16]..g[17]..g[18]..g[19]..g[20])
    print(" 21-30 " .. g[21]..g[22]..g[23]..g[24]..g[25]..g[26]..g[27]..g[28]..g[29]..g[30])
    print(" 31-40 " .. g[31]..g[32]..g[33]..g[34]..g[35]..g[36]..g[37]..g[38]..g[39]..g[40])
    print(" 41-50 " .. g[41]..g[42]..g[43]..g[44]..g[45]..g[46]..g[47]..g[48]..g[49]..g[50])
    print(" 51-60 " .. g[51]..g[52]..g[53]..g[54]..g[55]..g[56]..g[57]..g[58]..g[59]..g[60])
    print(" 61-70 " .. g[61]..g[62]..g[63]..g[64]..g[65]..g[66]..g[67]..g[68]..g[69]..g[70])
    print(" 71-80 " .. g[71]..g[72]..g[73]..g[74]..g[75]..g[76]..g[77]..g[78]..g[79]..g[80])
    print(" 81-90 " .. g[81]..g[82]..g[83]..g[84]..g[85]..g[86]..g[87]..g[88]..g[89]..g[90])
    print("91-100 " .. g[91]..g[92]..g[93]..g[94]..g[95]..g[96]..g[97]..g[98]..g[99]..g[100])
    print("What is your move? (Give a number to 'dig', quit to do the obvious, and flag to flag) ")
    count = 0
    move = io.read()
    if move == nil or move == 'quit' then
        game = 0
        break
    end
	if move == "flag" then
		print("Give a number to flag")
		move = io.read()
		move = tonumber(move)
		g[move] = "! "
		move = "skip"
	end
	if move ~= "skip" then
		move = tonumber(move)
		print("You dig @ " .. move)
		for i = 1, 10 do
			if move == b[i] then
				print("You hit a bomb!")
				print("GAME OVER")
				game = 0
				break
			else
				if move - 11 == b[i] then
					count = count + 1
				end
				if move - 1 == b[i] then
					count = count + 1
				end
				if move - 10 == b[i] then
					count = count + 1
				end
				if move - 9 == b[i] then
					count = count + 1
				end
				if move + 11 == b[i] then
					count = count + 1
				end
				if move + 1 == b[i] then
					count = count + 1
				end
				if move + 10 == b[i] then
					count = count + 1
				end
				if move + 9 == b[i] then
					count = count + 1
				end
			end
		end
	end
    if game then
        if count == 0 then
            count = "-"
        end
        print(count)
        count = count .. " "
        g[move] = count
    end
end
