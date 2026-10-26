local ReplicatedStorage = game:GetService("ReplicatedStorage")
local buySpeed = ReplicatedStorage:WaitForChild("BuySpeed")
local button = script.Parent

button.Activated:Connect(function()
	print("Button clicked!")
	buySpeed:FireServer()
end)
