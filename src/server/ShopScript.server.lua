local ReplicatedStorage = game:GetService("ReplicatedStorage")
local buySpeed = ReplicatedStorage:WaitForChild("BuySpeed")

local PRICE = 5
local MAX_LEVEL = 6

buySpeed.OnServerEvent:Connect(function(player)
	local leaderstats = player:FindFirstChild("leaderstats")
	local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
	if not leaderstats or not humanoid then return end

	local coins = leaderstats.Coins
	local speedLevel = leaderstats.SpeedLevel
	if coins.Value < PRICE then return end
	if speedLevel.Value >= MAX_LEVEL then return end

	coins.Value -= PRICE
	speedLevel.Value += 1
	humanoid.WalkSpeed = 16 + speedLevel.Value * 4
end)
