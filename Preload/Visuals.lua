-- Keshav Doom Hub | GUI-only template
-- No gameplay functions included. Add your own logo and connect features later.

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local gui = Instance.new("ScreenGui")
gui.Name = "KeshavDoomHub"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.fromOffset(430, 300)
main.Position = UDim2.new(0.5, -215, 0.5, -150)
main.BackgroundColor3 = Color3.fromRGB(13, 15, 13)
main.BorderSizePixel = 0
main.Parent = gui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = main

local outline = Instance.new("UIStroke")
outline.Color = Color3.fromRGB(50, 255, 95)
outline.Thickness = 1.5
outline.Parent = main

local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 54)
header.BackgroundColor3 = Color3.fromRGB(19, 24, 19)
header.BorderSizePixel = 0
header.Parent = main

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 12)
headerCorner.Parent = header

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, -60, 1, 0)
title.Position = UDim2.fromOffset(16, 0)
title.BackgroundTransparency = 1
title.Text = "KESHAV DOOM HUB"
title.TextColor3 = Color3.fromRGB(70, 255, 105)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local closeBtn = Instance.new("TextButton")
closeBtn.Name = "Close"
closeBtn.Size = UDim2.fromOffset(30, 30)
closeBtn.Position = UDim2.new(1, -40, 0, 12)
closeBtn.BackgroundColor3 = Color3.fromRGB(27, 40, 27)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(70, 255, 105)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.Parent = header
local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 7)
closeCorner.Parent = closeBtn

local content = Instance.new("Frame")
content.Name = "Content"
content.Size = UDim2.new(1, -24, 1, -72)
content.Position = UDim2.fromOffset(12, 64)
content.BackgroundColor3 = Color3.fromRGB(16, 19, 16)
content.BorderSizePixel = 0
content.Parent = main
local contentCorner = Instance.new("UICorner")
contentCorner.CornerRadius = UDim.new(0, 8)
contentCorner.Parent = content

local placeholder = Instance.new("TextLabel")
placeholder.Name = "Placeholder"
placeholder.Size = UDim2.new(1, -24, 1, -24)
placeholder.Position = UDim2.fromOffset(12, 12)
placeholder.BackgroundTransparency = 1
placeholder.Text = "GUI ONLY  •  ADD YOUR FEATURES HERE"
placeholder.TextColor3 = Color3.fromRGB(150, 180, 150)
placeholder.Font = Enum.Font.GothamMedium
placeholder.TextSize = 13
placeholder.TextWrapped = true
placeholder.Parent = content

-- Dragging support for the main window
local dragging = false
local dragStart, startPosition
header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPosition = main.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(startPosition.X.Scale, startPosition.X.Offset + delta.X, startPosition.Y.Scale, startPosition.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)
