-- Quantum Onyx - Keyless Launcher
-- The Luarmor loader's own authentication, if any, is not bypassed.

local Directory = "https://raw.githubusercontent.com/flazhy/QuantumOnyx/refs/heads/main/Games"
local Scripts = {
    Free = {
        [994732206] = Directory .. "/BloxFruits.lua",
        [9186719164] = Directory .. "/SailorPiece.lua",
        [8191429227] = Directory .. "/CutTrees.lua",
    },
}

local STOCK_LOADER_URL = "https://api.luarmor.net/files/v4/loaders/0ae9fe4cf963e3a13d25eed0e2ce5940.lua"

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer
local GameId = game.GameId

local function Notify(title, desc, duration)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = title or "Quantum Onyx",
            Text = desc or "",
            Duration = duration or 5,
        })
    end)
end

local function Protect(gui)
    local env = (getgenv and getgenv()) or _G
    if env.HIDEUI then
        gui.Parent = env.HIDEUI
    elseif gethui then
        gui.Parent = gethui()
    elseif syn and syn.protect_gui then
        syn.protect_gui(gui)
        gui.Parent = game:GetService("CoreGui")
    else
        gui.Parent = game:GetService("CoreGui")
    end
end

local function LoadStockLoader()
    local ok, err = pcall(function()
        loadstring(game:HttpGet(STOCK_LOADER_URL))()
    end)
    if not ok then
        Notify("Quantum Onyx", "Premium loader failed to start: " .. tostring(err))
    end
end

local function LoadFreeScript()
    local url = Scripts.Free[GameId]
    if not url then
        Notify("Quantum Onyx", "No free script is configured for this game.")
        return
    end

    local ok, err = pcall(function()
        loadstring(game:HttpGet(url))()
    end)
    if not ok then
        Notify("Quantum Onyx", "Free script failed to load: " .. tostring(err))
    end
end

local function New(className, properties, parent)
    local object = Instance.new(className)
    for key, value in pairs(properties or {}) do
        if key ~= "Parent" and key ~= "Children" then
            pcall(function() object[key] = value end)
        end
    end
    if properties and properties.Children then
        for _, child in ipairs(properties.Children) do
            child.Parent = object
        end
    end
    object.Parent = (properties and properties.Parent) or parent
    return object
end

local function MakeButton(parent, text, y, callback)
    local button = New("TextButton", {
        Position = UDim2.new(0, 18, 0, y),
        Size = UDim2.new(1, -36, 0, 42),
        BackgroundColor3 = Color3.fromRGB(55, 25, 105),
        BorderSizePixel = 0,
        AutoButtonColor = true,
        Font = Enum.Font.GothamBold,
        Text = text,
        TextColor3 = Color3.fromRGB(225, 210, 255),
        TextSize = 13,
    }, parent)
    New("UICorner", {CornerRadius = UDim.new(0, 8)}, button)
    button.MouseButton1Click:Connect(callback)
    return button
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "QuantumOnyxLauncher"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
Protect(screenGui)

local card = New("Frame", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    Size = UDim2.new(0, 300, 0, 220),
    BackgroundColor3 = Color3.fromRGB(15, 12, 24),
    BorderSizePixel = 0,
    ClipsDescendants = true,
}, screenGui)
New("UICorner", {CornerRadius = UDim.new(0, 14)}, card)
New("UIStroke", {
    Color = Color3.fromRGB(120, 60, 220),
    Transparency = 0.25,
    Thickness = 1.5,
}, card)

local header = New("TextLabel", {
    Size = UDim2.new(1, -48, 0, 44),
    Position = UDim2.new(0, 16, 0, 0),
    BackgroundTransparency = 1,
    Font = Enum.Font.GothamBold,
    Text = "Quantum Onyx",
    TextColor3 = Color3.fromRGB(220, 200, 255),
    TextSize = 16,
    TextXAlignment = Enum.TextXAlignment.Left,
}, card)

local close = New("TextButton", {
    AnchorPoint = Vector2.new(1, 0),
    Position = UDim2.new(1, -10, 0, 10),
    Size = UDim2.new(0, 28, 0, 26),
    BackgroundColor3 = Color3.fromRGB(90, 35, 55),
    BorderSizePixel = 0,
    Font = Enum.Font.GothamBold,
    Text = "X",
    TextColor3 = Color3.fromRGB(255, 210, 215),
    TextSize = 12,
}, card)
New("UICorner", {CornerRadius = UDim.new(0, 6)}, close)
close.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

New("TextLabel", {
    Position = UDim2.new(0, 18, 0, 48),
    Size = UDim2.new(1, -36, 0, 34),
    BackgroundTransparency = 1,
    Font = Enum.Font.Gotham,
    Text = "Choose a loader to continue",
    TextColor3 = Color3.fromRGB(170, 155, 200),
    TextSize = 11,
    TextXAlignment = Enum.TextXAlignment.Left,
}, card)

MakeButton(card, "Free Version", 92, function()
    screenGui:Destroy()
    LoadFreeScript()
end)

MakeButton(card, "Premium Loader", 144, function()
    screenGui:Destroy()
    LoadStockLoader()
end)

Notify("Quantum Onyx", "Launcher ready.")
