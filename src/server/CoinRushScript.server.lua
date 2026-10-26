local Players = game:GetService("Players")
local pad = workspace:WaitForChild("RushPad")
local rushCoins = workspace:WaitForChild("RushCoins")

local RUSH_TIME = 30
local REWARD = 2

-- Start the rush when a player steps on the pad
pad.Touched:Connect(function(hit)
	local player = Players:GetPlayerFromCharacter(hit.Parent)
	if not player then return end
	if (player:GetAttribute("RushTime") or 0) > 0 then return end -- already rushing

	for t = RUSH_TIME, 0, -1 do
		player:SetAttribute("RushTime", t)
		task.wait(1)
	end
end)

-- One script handles ALL rush coins
for _, coin in ipairs(rushCoins:GetChildren()) do
	local collected = false
	coin.Touched:Connect(function(hit)
		if collected then return end
		local player = Players:GetPlayerFromCharacter(hit.Parent)
		if not player then return end
		if (player:GetAttribute("RushTime") or 0) <= 0 then return end -- only during rush

		collected = true
		player.leaderstats.Coins.Value += REWARD
		coin.Transparency = 1
		task.wait(3)
		coin.Transparency = 0
		collected = false
	end)
end
