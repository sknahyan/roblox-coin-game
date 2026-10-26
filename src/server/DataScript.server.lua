local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")
local coinStore = DataStoreService:GetDataStore("PlayerCoins")

local BASE_SPEED = 16
local SPEED_BOOST = 4

-- Set speed based on the player's level
local function applySpeed(player, character)
	local humanoid = character:WaitForChild("Humanoid")
	local level = player.leaderstats.SpeedLevel.Value
	humanoid.WalkSpeed = BASE_SPEED + level * SPEED_BOOST
end

-- LOAD when a player joins
Players.PlayerAdded:Connect(function(player)
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player

	local coins = Instance.new("IntValue")
	coins.Name = "Coins"
	coins.Parent = leaderstats

	local speedLevel = Instance.new("IntValue")
	speedLevel.Name = "SpeedLevel"
	speedLevel.Parent = leaderstats

	local success, data = pcall(function()
		return coinStore:GetAsync(player.UserId)
	end)
	if success and data then
		if type(data) == "number" then
			coins.Value = data -- old save (coins only)
		else
			coins.Value = data.Coins or 0
			speedLevel.Value = data.SpeedLevel or 0
		end
	end

	-- Reapply speed every time the character spawns
	player.CharacterAdded:Connect(function(character)
		applySpeed(player, character)
	end)
	if player.Character then
		applySpeed(player, player.Character)
	end
end)

-- SAVE
local function saveData(player)
	local leaderstats = player:FindFirstChild("leaderstats")
	if not leaderstats then return end
	local success, err = pcall(function()
		coinStore:SetAsync(player.UserId, {
			Coins = leaderstats.Coins.Value,
			SpeedLevel = leaderstats.SpeedLevel.Value,
		})
	end)
	if not success then
		warn("Save failed for " .. player.Name .. ": " .. tostring(err))
	end
end

Players.PlayerRemoving:Connect(saveData)

game:BindToClose(function()
	for _, player in ipairs(Players:GetPlayers()) do
		saveData(player)
	end
end)

-- AUTOSAVE every 60 seconds
task.spawn(function()
	while true do
		task.wait(60)
		for _, player in ipairs(Players:GetPlayers()) do
			saveData(player)
		end
	end
end)
