local player = game.Players.LocalPlayer
local label = script.Parent
label.Visible = false

player:GetAttributeChangedSignal("RushTime"):Connect(function()
	local t = player:GetAttribute("RushTime")
	label.Visible = t > 0
	label.Text = "Coin Rush: " .. t .. "s"
end)
