-- Keshav Doom Hub: green UI branding only
-- Cosmetic ScreenGui; contains no gameplay or exploit functions.

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "KeshavDoomHub"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local panel = Instance.new("Frame")
panel.Name = "Main"
panel.Size = UDim2.fromOffset(280, 150)
panel.Position = UDim2.new(0.5, -140, 0.5, -75)
panel.BackgroundColor3 = Color3.fromRGB(12, 15, 12)
panel.BorderSizePixel = 0
panel.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = panel

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(60, 255, 90)
stroke.Thickness = 2
stroke.Parent = panel

local logo = Instance.new("ImageLabel")
logo.Name = "Logo"
logo.Size = UDim2.fromOffset(56, 56)
logo.Position = UDim2.new(0, 16, 0, 16)
logo.BackgroundTransparency = 1
logo.Image = "rbxassetid://157397170219"
logo.Parent = panel

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, -88, 0, 54)
title.Position = UDim2.new(0, 80, 0, 17)
title.BackgroundTransparency = 1
title.Text = "KESHAV DOOM HUB"
title.TextColor3 = Color3.fromRGB(75, 255, 100)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextWrapped = true
title.Parent = panel

local subtitle = Instance.new("TextLabel")
subtitle.Name = "Subtitle"
subtitle.Size = UDim2.new(1, -32, 0, 26)
subtitle.Position = UDim2.new(0, 16, 0, 86)
subtitle.BackgroundTransparency = 1
subtitle.Text = "GREEN THEME"
subtitle.TextColor3 = Color3.fromRGB(180, 210, 180)
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 12
subtitle.Parent = panel

local close = Instance.new("TextButton")
close.Name = "Close"
close.Size = UDim2.fromOffset(26, 26)
close.Position = UDim2.new(1, -34, 0, 8)
close.BackgroundColor3 = Color3.fromRGB(25, 35, 25)
close.Text = "X"
close.TextColor3 = Color3.fromRGB(75, 255, 100)
close.Font = Enum.Font.GothamBold
close.TextSize = 14
close.Parent = panel
local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = close

close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)
