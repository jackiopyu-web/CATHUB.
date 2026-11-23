local runService = game:GetService("RunService")
local players = game:GetService("Players")
local userInputService = game:GetService("UserInputService")
local tweenService = game:GetService("TweenService")
local textService = game:GetService("TextService")
local httpService = game:GetService("HttpService")
local teleportService = game:GetService("TeleportService")
local marketplaceService = game:GetService("MarketplaceService")
local coreGui = game:GetService("CoreGui")
local stats = game:GetService("Stats")
local getService = not game and game.GetService and runService

local v1 = getService or game.ClassName ~= "DataModel"
  or typeof and typeof(game.Players) ~= "Instance"
  or not (getmetatable and setmetatable and type and pcall and rawget and rawset)

if v1 then
  while true do
    task.wait()
    warn("stop skidding - flazhy")
  end
end

local v2 = {}
local v3 = {}
local v4 = {}
v3.Notification = {}
v2.Notify = v3.Notification
local localPlayer = players.LocalPlayer

if not localPlayer then
  pcall(function() localPlayer = players:GetPropertyChangedSignal("LocalPlayer"):Wait() end)
  localPlayer = localPlayer or players.LocalPlayer
end

local getMouse = localPlayer and localPlayer:GetMouse() or { X = 0, Y = 0 }
local v5 = gethui and gethui() or coreGui

v2.Services = {
  Players = players,
  UIS = userInputService,
  Tween = tweenService,
  Text = textService,
  Http = httpService,
  LocalPlayer = localPlayer,
  Mouse = getMouse,
}

v2.ENV = getgenv and getgenv() or _G
v2.CoreGui = v5

local notify = v2.Notify
local env = v2.ENV
local new = TweenInfo.new
v3._CurrentGui = nil

v2.Save = {
  FolderName = "Keshav Doom Hub",
  Settings = {},
  _Keys = {},
  RegisteredControls = {},
  ActiveProfile = "[Auto]",
}

local save = v2.Save

function save:RegisterKey(p1)
  self._Keys[p1] = true
end

function save:RegisterControl(p2, p3)
  if not p2 then
    return
  end

  self._Keys[p2] = true
  self.RegisteredControls[p2] = p3
end

function save.PruneStaleKeys(p4)
  if not next(p4._Keys) then
    return
  else
    local v6 = false

    for key in pairs(p4.Settings) do
      if key:sub(1, 1) ~= "_" and not p4._Keys[key] then
        p4.Settings[key] = nil
        v6 = true
      end
    end

    local get = p4:Get("_saveSlots", {})
    local v7 = false

    for index, value in ipairs(get) do
      if value.data then
        for key2 in pairs(value.data) do
          if not p4._Keys[key2] then
            value.data[key2] = nil
            v7 = true
          end
        end
      end
    end

    if v6 then
      p4:Save()
    end

    if v7 then
      p4:Save("_saveSlots", get)
    end

    return
  end
end

function JsonEncode(p5)
  return httpService:JSONEncode(p5)
end

function JsonDecode(p6)
  return httpService:JSONDecode(p6)
end

function save:GetPlayerName()
  local localPlayer2 = localPlayer or players and players.LocalPlayer

  if not localPlayer2 then
    pcall(function() localPlayer2 = players.LocalPlayer end)
  end

  local name = localPlayer2 and localPlayer2.Name

  if not name or name == "" then
    name = "User_" .. tostring(localPlayer2 and localPlayer2.UserId or "0")
  end

  return name:gsub("[^%w]", "")
end

function save:GetGameId()
  local gameId = 0
  pcall(function() gameId = game.GameId end)

  if not gameId or gameId == 0 then
    pcall(function() gameId = game.PlaceId end)
  end

  return tostring(gameId or 0)
end

local getFileName

function save:GetFileName(p7)
  local getPlayerName = self:GetPlayerName()
  local v8 = p7
  local getGameId = self:GetGameId()

  if p7 then
    v8 = type(p7) == "string" and p7 ~= ""
  end

  if v8 then
    return getPlayerName .. "-" .. p7:gsub("[^%w%s]", ""):gsub("%s+", "_") .. "-" .. getGameId
      .. ".json"
  end

  if not getFileName then
    local v9, v10 = pcall(function()
      return marketplaceService:GetProductInfo(game.PlaceId).Name
    end)

    getFileName = getPlayerName .. "-"
      .. (v9 and v10 and v10:gsub("[^%w%s]", ""):gsub("%s+", "_") or getGameId) .. "-"
      .. getGameId .. ".json"
  end

  return getFileName
end

function save:Save(p8, p9)
  if p8 ~= nil then
    self.Settings[p8] = p9
  end

  if not isfolder(self.FolderName) then
    pcall(makefolder, self.FolderName)
  end

  pcall(writefile, self.FolderName .. "/" .. self:GetFileName(), JsonEncode(self.Settings))
end

function save:Load()
  if not isfolder(self.FolderName) then
    pcall(makefolder, self.FolderName)
  end

  local v11, v12 = pcall(readfile, self.FolderName .. "/" .. self:GetFileName())

  if not v11 or not v12 then
    local getPlayerName2 = self:GetPlayerName()

    for index2, value2 in ipairs({
      self.FolderName .. "/" .. getPlayerName2 .. "-" .. self:GetGameId() .. ".json",
      self.FolderName .. "/" .. getPlayerName2 .. ".json",
    }) do
      local v13, v14 = pcall(readfile, value2)

      if v13 and v14 then
        v12 = v14
        v11 = true
        break
      end
    end
  end

  local v15

  if v11 and v12 then
    v15 = nil
    pcall(function() v15 = JsonDecode(v12) end)

    if type(v15) == "table" then
      self.Settings = v15
      return v15
    end

    self:Save()
    return {}
  end

  self:Save()
  return {}
end

function save:Get(p10, p11)
  local v16 = self.Settings[p10]
  return v16 ~= nil and v16 or p11
end

function save:GetSnapshot()
  local v17 = {}

  for key3, value3 in pairs(self.Settings) do
    if key3:sub(1, 1) ~= "_" and self._Keys[key3] then
      v17[key3] = value3
    end
  end

  for key4, value4 in pairs(self.RegisteredControls) do
    if v17[key4] == nil and value4.Get then
      local v18, v19 = pcall(value4.Get)

      if v18 and v19 ~= nil then
        v17[key4] = v19
      end
    end
  end

  return v17
end

function save:ApplySnapshot(p12, p13)
  if type(p12) ~= "table" then
    return false
  else
    local v20 = p13 ~= false

    for key5, value5 in pairs(p12) do
      if key5:sub(1, 1) ~= "_" then
        self.Settings[key5] = value5
        local v21 = self.RegisteredControls[key5]

        if v21 and v21.Set then
          pcall(v21.Set, value5, v20)
        end
      end
    end

    self:Save()
    return true
  end
end

function save:ResetToDefaults(p14)
  local v22 = p14 ~= false

  for key6, value6 in pairs(self.RegisteredControls) do
    if value6 and value6.Default ~= nil and value6.Set then
      self.Settings[key6] = value6.Default
      pcall(value6.Set, value6.Default, v22)
    end
  end

  self:Save()
end

function save:ElementSave(p15, p16)
  local isAutoSave

  if self.IsAutoSave then
    isAutoSave = self:IsAutoSave()
  else
    isAutoSave = self:Get("_opt_AutoSave", true)
  end

  if not isAutoSave then
    return
  else
    self:Save(p15, p16)
    local get2 = self:Get("_saveSlots", {})
    local v23 = nil

    for index3, value7 in ipairs(get2) do
      if value7.name == "[Auto]" then
        v23 = index3
        break
      end
    end

    local getSnapshot = self:GetSnapshot()

    if v23 then
      get2[v23].data = getSnapshot
      get2[v23].updated = os.date("%Y-%m-%d %H:%M")
    else
      table.insert(get2, 1, {
        name = "[Auto]",
        data = getSnapshot,
        created = os.date("%Y-%m-%d %H:%M"),
        updated = os.date("%Y-%m-%d %H:%M"),
      })
    end

    self:Save("_saveSlots", get2)
    return
  end
end

function save:ClearAll()
  self.Settings = {}

  if isfolder(self.FolderName) then
    pcall(writefile, self.FolderName .. "/" .. self:GetFileName(), "{}")
  end
end

save.Set = save.ElementSave
save.set = save.ElementSave

v3.SaveSystem = save
v3.Modules = v2

v2.Util = {}
v2.Tween = {}
v2.Media = {}
v2.Theme = {}
v2.UI = {}

local tween = v2.Tween
local media = v2.Media
local theme = v2.Theme

local util = v2.Util

function util.Set(p17, p18, p19)
  p17[p18] = p19
end

function util.Protect(p20)
  if env.HIDEUI then
    p20.Parent = env.HIDEUI
  elseif gethui then
    p20.Parent = gethui()
  elseif syn and syn.protect_gui then
    pcall(syn.protect_gui, p20)
    p20.Parent = v5
  else
    p20.Parent = v5
  end
end

local v24 = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

function util.RandomName()
  local v25 = {}

  for i = 1, 16 do
    local v26 = math.random(1, #v24)
    v25[i] = v24:sub(v26, v26)
  end

  return table.concat(v25)
end

function util:Create(p21, p22)
  local instance = Instance.new(self)

  if p21 then
    for key7, value8 in pairs(p21) do
      if key7 ~= "Children" and key7 ~= "Parent" then
        pcall(util.Set, instance, key7, value8)
      end
    end

    local children = p21.Children

    if children then
      for j = 1, #children do
        local v27 = children[j]

        if v27 then
          v27.Parent = instance
        end
      end
    end

    if p21.Parent then
      instance.Parent = p21.Parent
    elseif p22 then
      instance.Parent = p22
    end
  elseif p22 then
    instance.Parent = p22
  end

  return instance
end

function util.GuiCenterLocal(p23, p24, p25)
  local v28 = p25 and p25 ~= 0 and p25 or 1
  local absolutePosition = p24 and p24.AbsolutePosition or Vector2.zero
  local v29 = p23.AbsolutePosition + p23.AbsoluteSize * 0.5
  return (v29.X - absolutePosition.X) / v28, (v29.Y - absolutePosition.Y) / v28
end

function util.PinAbsToOffset(p26, p27, p28)
  local v30 = p28 and p28 ~= 0 and p28 or 1
  local absolutePosition2 = p27 and p27.AbsolutePosition or Vector2.zero
  local absolutePosition3 = p26.AbsolutePosition

  p26.Position = UDim2.fromOffset(
    (absolutePosition3.X - absolutePosition2.X) / v30,
    (absolutePosition3.Y - absolutePosition2.Y) / v30
  )

  return p26.Position
end

function util.MakeDraggable(p29, p30)
  local v31 = false
  local v32 = false

  local touchEnabled = userInputService.TouchEnabled and not userInputService.KeyboardEnabled
      and 12
    or 6

  local v33, vector, position, connect

  local function f1()
    v31 = false
    v33 = nil
    vector = nil
    position = nil
    v32 = false

    if connect then
      connect:Disconnect()
      connect = nil
    end
  end

  local function f2(p31)
    if v31 then
      return
    end

    if p31.UserInputType ~= Enum.UserInputType.MouseButton1
      and p31.UserInputType ~= Enum.UserInputType.Touch then
      return
    end

    if not p30 or not p30.Parent then
      return
    end

    v31 = true
    v33 = p31
    vector = Vector2.new(p31.Position.X, p31.Position.Y)
    position = p30.Position
    v32 = false

    if connect then
      connect:Disconnect()
      connect = nil
    end

    connect = p31.Changed:Connect(function()
      if p31.UserInputState == Enum.UserInputState.End
        or p31.UserInputState == Enum.UserInputState.Cancel then
        f1()
      end
    end)
  end

  local function f3(p32)
    if not p32 or not p32:IsA("GuiObject") then
      return
    end

    if p32:IsA("TextButton") or p32:IsA("ImageButton") or p32:IsA("TextBox") then
      return
    end

    p32.InputBegan:Connect(f2)
  end

  if p29 then
    f3(p29)

    for index4, value9 in ipairs(p29:GetChildren()) do
      f3(value9)
    end

    p29.ChildAdded:Connect(f3)
  elseif p30 then
    p30.InputBegan:Connect(function(input)
      if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        local scale = MainUIScale and MainUIScale.Scale > 0 and MainUIScale.Scale or 1
        local v34 = input.Position.Y - p30.AbsolutePosition.Y

        if v34 >= 0 and v34 <= 34 * scale then
          f2(input)
        end
      end
    end)
  end

  userInputService.InputChanged:Connect(function(input2)
    if not v31 or not p30 or not p30.Parent or not vector or not position then
      return
    end

    if v33 and v33.UserInputType == Enum.UserInputType.MouseButton1 then
      local v35, v36 = pcall(function()
        return userInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
      end)

      if v35 and v36 == false then
        f1()
        return
      end
    end

    if input2 == v33
      or v33 and v33.UserInputType == Enum.UserInputType.MouseButton1
        and input2.UserInputType == Enum.UserInputType.MouseMovement
      or input2.UserInputType == Enum.UserInputType.Touch then
      local v37 = Vector2.new(input2.Position.X, input2.Position.Y) - vector

      if not v32 and v37.Magnitude >= touchEnabled then
        v32 = true
      end

      if v32 then
        p30.Position = UDim2.new(
          position.X.Scale, position.X.Offset + v37.X, position.Y.Scale,
          position.Y.Offset + v37.Y
        )
      end
    end
  end)

  userInputService.InputEnded:Connect(function(input3)
    if not v31 then
      return
    end

    if input3 == v33 or input3.UserInputType == Enum.UserInputType.MouseButton1
      or input3.UserInputType == Enum.UserInputType.Touch then
      f1()
    end
  end)

  if userInputService.WindowFocusReleased then
    pcall(function() userInputService.WindowFocusReleased:Connect(f1) end)
  end
end

function util.BindHover(p33, p34, p35, p36, p37, p38)
  p33.MouseEnter:Connect(function()
    tween.Play(p33, p34, 0.16, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

    if p38 and p36 then
      tween.Play(p38, p36, 0.16, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    end
  end)

  p33.MouseLeave:Connect(function()
    tween.Play(p33, p35, 0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

    if p38 and p37 then
      tween.Play(p38, p37, 0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    end
  end)
end

function util.Trim(p39)
  if type(p39) ~= "string" then
    return ""
  end

  return p39:gsub("^%s+", ""):gsub("%s+$", ""):gsub("[ \t]+", " "):gsub("\n[ \t]+", "\n"):gsub([[
[ 	]+
]], "\n")
end

local v38 = {}

function util.TextHeight(p40, p41, p42, p43)
  if not p40 or p40 == "" then
    return 0
  else
    local gotham = p41 or Enum.Font.Gotham
    local v39 = p42 or 11
    local v40 = p43 or 150
    local name2 = typeof(gotham) == "EnumItem" and gotham.Name or tostring(gotham)
    local v41 = tostring(p40) .. "\0" .. name2 .. "\0" .. tostring(v39) .. "\0" .. tostring(v40)
    local v42 = v38[v41]

    if v42 then
      return v42
    else
      local gsub = tostring(p40):gsub("<[^>]->", "")
      local count = 0

      for match in gsub:gmatch("\n") do
        count = count + 1
      end

      local v43 = textService:GetTextSize(gsub, v39, gotham, Vector2.new(v40, 10000)).Y
        + count * 4 + 2

      v38[v41] = v43
      return v43
    end
  end
end

function util.WrapText(p44, p45, p46, p47)
  if type(p44) ~= "string" or p44 == "" then
    return ""
  end

  return p44
end

function util.DescMetrics(p48, p49, p50, p51)
  local gotham2 = p49 or Enum.Font.Gotham
  local v44 = p50 or 11
  local v45 = p51 or 150

  if typeof(p48) ~= "string" or p48 == "" then
    return "", 0
  end

  return p48, math.max(util.TextHeight(p48, gotham2, v44, v45), 14)
end

local v46 = setmetatable({}, { __mode = "k" })

function tween.Info(p52, p53, p54, p55, p56, p57)
  return new(
    p52, p53 or Enum.EasingStyle.Quart, p54 or Enum.EasingDirection.Out, p55 or 0, p56 or false,
    p57 or 0
  )
end

function tween:Play(p58, p59, p60, p61, p62)
  if not self then
    return nil
  end

  local v47 = v46[self]

  if not v47 then
    v47 = {}
    v46[self] = v47
  end

  for key8 in pairs(p58) do
    local v48 = v47[key8]

    if v48 then
      pcall(function() v48:Cancel() end)
      v47[key8] = nil
    end
  end

  if typeof(p59) == "number" and p59 == 0 then
    for key9, value10 in pairs(p58) do
      pcall(util.Set, self, key9, value10)
    end

    if typeof(p62) == "function" then
      p62()
    end

    return nil
  end

  local create = tweenService:Create(self, typeof(p59) == "TweenInfo" and p59
    or tween.Info(p59 or 0.25, p60, p61), p58)

  for key10 in pairs(p58) do
    v47[key10] = create
  end

  local connect2 = nil

  connect2 = create.Completed:Connect(function(p63)
    if connect2 then
      connect2:Disconnect()
      connect2 = nil
    end

    if v47 then
      for key11, value11 in pairs(v47) do
        if value11 == create then
          v47[key11] = nil
        end
      end
    end

    if p63 == Enum.PlaybackState.Completed and typeof(p62) == "function" then
      p62()
    end
  end)

  create:Play()
  return create
end

function tween.Group()
  local v49 = {}

  return {
    Play = function(p64, p65, p66, p67, p68, p69, p70)
      local v50 = tween.Play(p65, p66, p67, p68, p69, p70)

      if v50 then
        v49[#v49 + 1] = v50
      end

      return v50
    end,
    Cancel = function()
      for k = 1, #v49 do
        local v51 = v49[k]

        if v51 then
          pcall(function() v51:Cancel() end)
        end
      end

      table.clear(v49)
    end,
  }
end

function media.PathToAsset(p71)
  if type(p71) ~= "string" or p71 == "" then
    return nil
  end

  local gsub2 = p71:gsub("^%s+", ""):gsub("%s+$", "")

  if gsub2 == "" then
    return nil
  elseif gsub2:match("^%d+$") then
    return "rbxassetid://" .. gsub2
  elseif gsub2:find("^rbxassetid://") or gsub2:find("^rbxasset://") or gsub2:find("^http://")
    or gsub2:find("^https://") then
    return gsub2
  else
    local v52 = getcustomasset or getgenv and getgenv().getcustomasset or getsynasset
      or getgenv and getgenv().getsynasset

    if v52 then
      local v53, v54 = pcall(v52, gsub2)

      if v53 and type(v54) == "string" and v54 ~= "" then
        return v54
      else
        if save and save.FolderName then
          local v55, v56 = pcall(v52, save.FolderName .. "/" .. gsub2)

          if v55 and type(v56) == "string" and v56 ~= "" then
            return v56
          else
            local v57, v58 = pcall(v52, save.FolderName .. "\\" .. gsub2)

            if v57 and type(v58) == "string" and v58 ~= "" then
              return v58
            end
          end
        end

        local v59, v60 = pcall(function() return v52(gsub2, true) end)

        if v59 and type(v60) == "string" and v60 ~= "" then
          return v60
        end

        return gsub2
      end
    else
      return gsub2
    end
  end
end

function media.ListImages(p72)
  local v61 = {}

  if not (isfolder and listfiles and isfolder(p72)) then
    return v61
  else
    local v62, v63 = pcall(listfiles, p72)

    if not v62 or not v63 then
      return v61
    end

    for index5, value12 in ipairs(v63) do
      local v64 = string.lower(value12)

      if v64:find("%.png") or v64:find("%.jpe?g") or v64:find("%.webp") or v64:find("%.gif")
        or v64:find("%.bmp") then
        table.insert(v61, value12)
      end
    end

    table.sort(v61)
    return v61
  end
end

function media.ListVideos(p73)
  local v65 = {}

  if not (isfolder and listfiles and isfolder(p73)) then
    return v65
  else
    local v66, v67 = pcall(listfiles, p73)

    if not v66 or not v67 then
      return v65
    end

    for index6, value13 in ipairs(v67) do
      local v68 = string.lower(value13)

      if v68:find("%.webm") or v68:find("%.mp4") or v68:find("%.mov") or v68:find("%.mkv")
        or v68:find("%.avi") then
        table.insert(v65, value13)
      end
    end

    table.sort(v65)
    return v65
  end
end

function media.IsVideo(p74)
  if type(p74) ~= "string" then
    return false
  else
    local gsub3 = string.lower(p74):gsub("%s+$", "")

    return gsub3:find("%.webm") ~= nil or gsub3:find("%.mp4") ~= nil
      or gsub3:find("%.mov") ~= nil or gsub3:find("%.mkv") ~= nil or gsub3:find("%.avi") ~= nil
      or gsub3:find("%[vid%]") ~= nil
  end
end

local create2 = util.Create
local randomName = util.RandomName
local set = util.Set
local protect = util.Protect
local trim = util.Trim
local wrapText = util.WrapText
local descMetrics = util.DescMetrics
local textHeight = util.TextHeight
local listImages = media.ListImages
local listVideos = media.ListVideos
local isVideo = media.IsVideo
local pathToAsset = media.PathToAsset

function v4:Tween(p75, p76, p77, p78, p79, p80)
  return tween.Play(p75, p76, p77, p78, p79, p80)
end

function v3:DestroyGui()
  if self._CurrentGui and self._CurrentGui.Parent then
    self._CurrentGui:Destroy()
    self._CurrentGui = nil
  end
end

function CircleClick(p81, p82, p83)
  if not p81 or not p81.Parent then
    return
  end

  task.spawn(function()
    pcall(function()
      local absolutePosition4 = p81.AbsolutePosition
      local absoluteSize = p81.AbsoluteSize
      local v69 = absoluteSize.X <= 0 or absoluteSize.Y <= 0
      local v70, v71, clipsDescendants, v72

      if v69 then
        return
      else
        local scale2 = 1
        local parent = p81

        while parent and parent ~= workspace do
          local uiScale = parent:FindFirstChildOfClass("UIScale")

          if uiScale and uiScale.Scale > 0 then
            scale2 = scale2 * uiScale.Scale
          end

          parent = parent.Parent
        end

        if scale2 <= 0 then
          scale2 = MainUIScale and MainUIScale.Scale > 0 and MainUIScale.Scale or 1
        end

        local v73 = tonumber(p82) or 0
        local v74 = v73 >= absolutePosition4.X
        local v75 = tonumber(p83) or 0

        if v74 and v73 <= absolutePosition4.X + absoluteSize.X and v75 >= absolutePosition4.Y
          and v75 <= absolutePosition4.Y + absoluteSize.Y and (v73 > 0 or v75 > 0) then
          v70 = (v73 - absolutePosition4.X) / scale2
          v71 = (v75 - absolutePosition4.Y) / scale2
        else
          v70 = absoluteSize.X * 0.5 / scale2
          v71 = absoluteSize.Y * 0.5 / scale2
        end

        clipsDescendants = p81.ClipsDescendants
        p81.ClipsDescendants = true
        local v76 = math.max(absoluteSize.X, absoluteSize.Y) / scale2 * 2.3

        v72 = create2("ImageLabel", {
          Name = "Circle",
          Image = "rbxassetid://266543268",
          ImageColor3 = Color3.fromRGB(240, 230, 255),
          ImageTransparency = 0.7,
          BackgroundTransparency = 1,
          BorderSizePixel = 0,
          ZIndex = (p81.ZIndex or 1) + 4,
          AnchorPoint = Vector2.new(0.5, 0.5),
          Size = UDim2.new(0, 4, 0, 4),
          Position = UDim2.new(0, v70, 0, v71),
        }, p81)

        tween.Play(v72, { Size = UDim2.new(0, v76, 0, v76), ImageTransparency = 1 }, 0.38, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, function()
          pcall(function()
            v72:Destroy()

            if not clipsDescendants and not p81:FindFirstChild("Circle") then
              p81.ClipsDescendants = false
            end
          end)
        end)

        return
      end
    end)
  end)
end

local quantumThemeManager = env.QuantumThemeManager

if not quantumThemeManager then
  local v77, v78 = pcall(function()
    return game:HttpGet("https://raw.githubusercontent.com/flazhy/QuantumOnyx/refs/heads/main/Util/LibraryModule/Themes.lua")
  end)

  if v77 and type(v78) == "string" and v78 ~= "" then
    local v79, v80 = pcall(loadstring, v78)

    if v79 and type(v80) == "function" then
      local v81, v82 = pcall(v80)

      if v81 and type(v82) == "table" then
        quantumThemeManager = v82
      end
    end
  end

  if not quantumThemeManager then
    quantumThemeManager = {
      Current = {
        Primary = Color3.fromRGB(8, 12, 9),
        Secondary = Color3.fromRGB(15, 24, 17),
        Body = Color3.fromRGB(5, 8, 6),
        Lit = ColorSequence.new({
          ColorSequenceKeypoint.new(0, Color3.fromRGB(65, 220, 110)),
          ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 145, 65)),
        }),
        Text = Color3.fromRGB(240, 235, 255),
        SubText = Color3.fromRGB(145, 165, 150),
      },
      Themes = {},
    }
  end

  env.QuantumThemeManager = quantumThemeManager
end

theme.Manager = quantumThemeManager

function theme.Color(p84)
  if quantumThemeManager and quantumThemeManager.Current and quantumThemeManager.Current[p84] then
    return quantumThemeManager.Current[p84]
  end

  return Color3.fromRGB(65, 220, 110)
end

function ThemeColor(p85)
  return theme.Color(p85)
end

function notify:Init()
  if not self.GUI then
    local instance2 = Instance.new("ScreenGui", v5)
    instance2.Name = randomName()
    instance2.ZIndexBehavior = Enum.ZIndexBehavior.Global
    instance2.ResetOnSpawn = false
    instance2.IgnoreGuiInset = true

    protect(instance2)

    self.GUI = create2("Frame", {
      Name = "STX_Notification",
      BackgroundTransparency = 1,
      Size = UDim2.new(1, -20, 1, -52),
      Position = UDim2.new(1, -10, 0, 10),
      AnchorPoint = Vector2.new(1, 0),
      ClipsDescendants = false,
      ZIndex = 999,
      Parent = instance2,
      Children = {
        create2("UIListLayout", {
          Name = "STX_NotificationUIListLayout",
          HorizontalAlignment = Enum.HorizontalAlignment.Right,
          SortOrder = Enum.SortOrder.LayoutOrder,
          VerticalAlignment = Enum.VerticalAlignment.Top,
          Padding = UDim.new(0, 6),
        }),
      },
    })
  end
end

notify.ActiveMessages = notify.ActiveMessages or {}
notify.ActiveById = notify.ActiveById or {}

function notify:Notify(p86, p87)
  local v83 = p86
  assert(self.GUI, "Notification GUI not initialized. Call :Init(parent) first.")
  v83 = v83 or {}
  local v84 = p87 or {}
  local title = v83.Title or "Notification"
  local description = v83.Description or ""
  local time = v84.Time or 3
  local gotham3 = Enum.Font.Gotham

  if v83.Id then
    local v85 = notify.ActiveById[v83.Id]

    if v85 and v85.Host and v85.Host.Parent and not v85.isDismissed then
      if v85.TitleLabel and v85.TitleLabel.Parent then
        v85.TitleLabel.Text = title
      end

      if v85.DescLabel and v85.DescLabel.Parent then
        v85.DescLabel.Text = wrapText(description, gotham3, 12, 176)
      end

      if v85.ResetTimer then
        v85.ResetTimer(time)
      end

      return v85
    end
  end

  local v86 = title .. "||" .. description
  local v87, v88, v89, v90, v91, v92, v93, progressBarFill, v94, f4, v95

  if notify.ActiveMessages[v86] then
    return
  else
    notify.ActiveMessages[v86] = true

    local buttons = v83.Buttons or v83.Button or v83.Actions or v83.Options
      or v84 and (v84.Buttons or v84.Actions)

    local v96 = {}

    if type(buttons) == "string" then
      table.insert(v96, { Text = buttons, Callback = v83.Callback })
    elseif type(buttons) == "table" then
      if buttons.Text or buttons.Name or buttons.Title then
        table.insert(v96, {
          Text = buttons.Text or buttons.Name or buttons.Title or "Okay",
          Callback = buttons.Callback or buttons.OnClick or buttons.Function,
          Primary = buttons.Primary or buttons.IsPrimary,
        })
      elseif #buttons > 0 then
        for index7, value14 in ipairs(buttons) do
          if type(value14) == "string" then
            table.insert(v96, { Text = value14 })
          elseif type(value14) == "table" then
            table.insert(v96, {
              Text = value14.Text or value14.Name or value14.Title or "Button",
              Callback = value14.Callback or value14.OnClick or value14.Function,
              Primary = value14.Primary or value14.IsPrimary,
            })
          end
        end
      else
        for key12, value15 in pairs(buttons) do
          table.insert(v96, {
            Text = tostring(key12),
            Callback = type(value15) == "function" and value15
              or type(value15) == "table"
                and (value15.Callback or value15.OnClick or value15.Function),
            Primary = type(value15) == "table" and (value15.Primary or value15.IsPrimary),
          })
        end
      end
    end

    local v97 = #v96 > 0
    local v98 = v97 and 30 or 0
    local v99 = wrapText(description, gotham3, 12, 176)
    local v100 = textHeight(v99, gotham3, 12, 176)
    local v101 = 28 + v100 + v98 + 14

    v87 = create2("Frame", {
      AnchorPoint = Vector2.new(1, 0),
      BackgroundTransparency = 1,
      BorderSizePixel = 0,
      Position = UDim2.new(1, -10, 0, 10),
      Size = UDim2.new(0, 46, 0, 0),
      ClipsDescendants = false,
      ZIndex = 1000,
    }, self.GUI)

    v88 = create2("TextLabel", {
      BackgroundTransparency = 1,
      Position = UDim2.new(0, 8, 0, 2),
      Size = UDim2.new(1, -16, 0, 18),
      ZIndex = 1002,
      Font = Enum.Font.FredokaOne,
      Text = title,
      TextColor3 = Color3.fromRGB(220, 220, 220),
      TextSize = 12,
      TextTransparency = 1,
      TextXAlignment = Enum.TextXAlignment.Left,
    })

    v89 = create2("TextLabel", {
      BackgroundTransparency = 1,
      AnchorPoint = Vector2.new(1, 0),
      Position = UDim2.new(1, -8, 0, 2),
      Size = UDim2.new(0, 40, 0, 18),
      ZIndex = 1002,
      Font = Enum.Font.Gotham,
      Text = "(" .. time .. "s)",
      TextColor3 = Color3.fromRGB(180, 180, 180),
      TextSize = 11,
      TextTransparency = 1,
      TextXAlignment = Enum.TextXAlignment.Right,
    })

    v90 = create2("TextLabel", {
      BackgroundTransparency = 1,
      Position = UDim2.new(0, 8, 0, 22),
      Size = UDim2.new(0, 184, 0, v100),
      ZIndex = 1002,
      Font = gotham3,
      Text = v99,
      TextColor3 = Color3.fromRGB(180, 180, 180),
      TextSize = 12,
      TextTransparency = 1,
      TextWrapped = true,
      TextXAlignment = Enum.TextXAlignment.Left,
      TextYAlignment = Enum.TextYAlignment.Top,
    })

    local v102 = create2("ImageLabel", {
      Name = "PillLogo",
      AnchorPoint = Vector2.new(0.5, 0.5),
      BackgroundTransparency = 1,
      Position = UDim2.new(0.5, 0, 0.5, 0),
      Size = UDim2.new(0, 0, 0, 0),
      Image = "",
      ImageTransparency = 1,
      ScaleType = Enum.ScaleType.Fit,
      ZIndex = 1002,
      Children = {
        create2("TextLabel", {
          Name = "KeshavDoomLogoText",
          BackgroundTransparency = 1,
          Size = UDim2.new(1, 0, 1, 0),
          Font = Enum.Font.GothamBlack,
          Text = "KD",
          TextColor3 = Color3.fromRGB(105, 255, 145),
          TextSize = 22,
          TextStrokeColor3 = Color3.fromRGB(35, 15, 55),
          TextStrokeTransparency = 0.15,
          ZIndex = 1003,
        }),
      },
    })

    v91 = create2("TextLabel", {
      Name = "DoneLabel",
      AnchorPoint = Vector2.new(0.5, 0.5),
      BackgroundTransparency = 1,
      Position = UDim2.new(0.5, 0, 0.5, 0),
      Size = UDim2.new(1, -8, 1, 0),
      ZIndex = 1002,
      Font = Enum.Font.GothamBold,
      Text = "Done",
      TextColor3 = Color3.fromRGB(220, 220, 220),
      TextSize = 11,
      TextTransparency = 1,
      TextXAlignment = Enum.TextXAlignment.Center,
      TextYAlignment = Enum.TextYAlignment.Center,
    })

    v92 = create2("Frame", {
      Name = "ProgressBarBackground",
      BackgroundColor3 = Color3.fromRGB(40, 40, 40),
      BackgroundTransparency = 1,
      BorderSizePixel = 0,
      Position = UDim2.new(0, 8, 1, -10),
      Size = UDim2.new(1, -16, 0, 4),
      ZIndex = 1002,
      Children = {
        create2("UICorner", { CornerRadius = UDim.new(1, 0) }),
        create2("Frame", {
          Name = "ProgressBarFill",
          BackgroundTransparency = 1,
          BorderSizePixel = 0,
          Size = UDim2.new(1, 0, 1, 0),
          ZIndex = 1003,
          Children = {
            create2("UICorner", { CornerRadius = UDim.new(1, 0) }),
            create2("UIGradient", { Color = ThemeColor("Lit"), Rotation = 0 }),
          },
        }),
      },
    })

    local v103 = nil
    v93 = {}

    if v97 then
      local v104 = #v96

      v103 = create2("Frame", {
        Name = "ButtonContainer",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 8, 0, 22 + v100 + 6),
        Size = UDim2.new(1, -16, 0, 22),
        ZIndex = 1002,
        Children = {
          create2("UIListLayout", {
            Name = "ButtonsLayout",
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 6),
          }),
        },
      })

      local v105 = 1 / v104
      local v106 = -math.floor((v104 - 1) * 6 / v104)

      for index8, value16 in ipairs(v96) do
        local text = value16.Text or "Button"
        local primary = value16.Primary

        if primary == nil then
          local v107 = string.lower(text)

          if v104 == 1 or v107 == "okay" or v107 == "ok" or v107 == "yes" or v107 == "confirm"
            or v107 == "accept" or v107 == "apply" then
            primary = true
          else
            primary = false
          end
        end

        local color = primary
        color = primary and Color3.fromRGB(38, 38, 38)

        local color2 = color
        color2 = color or Color3.fromRGB(28, 28, 28)

        local color3 = primary
        color3 = primary and Color3.fromRGB(52, 52, 52)

        local color4 = color3
        color4 = color3 or Color3.fromRGB(40, 40, 40)

        local color5 = primary
        color5 = primary and Color3.fromRGB(255, 255, 255)

        local color6 = color5
        color6 = color5 or Color3.fromRGB(180, 180, 180)

        local v108 = create2("UIStroke", {
          Color = primary and Color3.fromRGB(80, 80, 80) or Color3.fromRGB(48, 48, 48),
          Transparency = 1,
          Thickness = 1,
          ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        })

        table.insert(v93, {
          Instance = create2("TextButton", {
            Name = "Button_" .. tostring(index8),
            BackgroundColor3 = color2,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = UDim2.new(v105, v106, 1, 0),
            LayoutOrder = index8,
            ZIndex = 1003,
            AutoButtonColor = false,
            Font = Enum.Font.GothamMedium,
            Text = text,
            TextColor3 = color6,
            TextSize = 11,
            TextTransparency = 1,
            Parent = v103,
            Children = { create2("UICorner", { CornerRadius = UDim.new(0, 6) }), v108 },
          }),
          Stroke = v108,
          DefaultBg = color2,
          HoverBg = color4,
          IsPrimary = primary,
          Data = value16,
        })
      end
    end

    local v109 = {
      create2("UICorner", { CornerRadius = UDim.new(0, 13) }), v102, v91, v88, v89, v90, v92,
    }

    if v103 then
      table.insert(v109, v103)
    end

    create2("Frame", {
      BackgroundColor3 = Color3.fromRGB(25, 25, 25),
      BorderSizePixel = 0,
      ClipsDescendants = true,
      Position = UDim2.new(0, 0, 0, 0),
      Size = UDim2.new(1, 0, 1, 0),
      ZIndex = 1001,
      Children = v109,
    }, v87)

    progressBarFill = v92.ProgressBarFill
    v94 = false

    function f4()
      if v94 then
        return
      end

      v94 = true

      v4:Tween(
        v88, { TextTransparency = 1 }, 0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.In
      )

      v4:Tween(
        v89, { TextTransparency = 1 }, 0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.In
      )

      v4:Tween(
        v90, { TextTransparency = 1 }, 0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.In
      )

      v4:Tween(
        v92, { BackgroundTransparency = 1 }, 0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.In
      )

      v4:Tween(
        progressBarFill, { BackgroundTransparency = 1 }, 0.2, Enum.EasingStyle.Sine,
        Enum.EasingDirection.In
      )

      for index9, value17 in ipairs(v93) do
        v4:Tween(
          value17.Instance, { BackgroundTransparency = 1, TextTransparency = 1 }, 0.2,
          Enum.EasingStyle.Sine, Enum.EasingDirection.In
        )

        if value17.Stroke then
          v4:Tween(
            value17.Stroke, { Transparency = 1 }, 0.2, Enum.EasingStyle.Sine,
            Enum.EasingDirection.In
          )
        end
      end

      task.wait(0.2)

      v4:Tween(
        v87, { Size = UDim2.new(0, 46, 0, 26) }, 0.28, Enum.EasingStyle.Quad,
        Enum.EasingDirection.InOut
      )

      task.wait(0.28)

      v4:Tween(
        v91, { TextTransparency = 0 }, 0.18, Enum.EasingStyle.Sine, Enum.EasingDirection.Out
      )

      task.wait(0.35)

      v4:Tween(
        v87, { Size = UDim2.new(0, 0, 0, 0) }, 0.18, Enum.EasingStyle.Quad,
        Enum.EasingDirection.In
      )

      v4:Tween(
        v91, { TextTransparency = 1 }, 0.12, Enum.EasingStyle.Sine, Enum.EasingDirection.In
      )

      task.wait(0.18)

      if v87 and v87.Parent then
        v87:Destroy()
      end

      notify.ActiveMessages[v86] = nil

      if v83.Id then
        notify.ActiveById[v83.Id] = nil
      end
    end

    for index10, value18 in ipairs(v93) do
      local v110 = value18
      local instance3 = v110.Instance
      local stroke = v110.Stroke
      local data = v110.Data

      instance3.MouseEnter:Connect(function()
        if not v94 then
          tween.Play(
            instance3, { BackgroundColor3 = v110.HoverBg }, 0.15, Enum.EasingStyle.Quint
          )

          if stroke then
            tween.Play(stroke, { Transparency = 0.5 }, 0.15)
          end
        end
      end)

      instance3.MouseLeave:Connect(function()
        if not v94 then
          tween.Play(
            instance3, { BackgroundColor3 = v110.DefaultBg }, 0.15, Enum.EasingStyle.Quint
          )

          if stroke then
            tween.Play(stroke, { Transparency = 0.8 }, 0.15)
          end
        end
      end)

      instance3.MouseButton1Click:Connect(function()
        if v94 then
          return
        end

        CircleClick(instance3, getMouse.X, getMouse.Y)

        if type(data.Callback) == "function" then
          task.spawn(function()
            local v111, v112 = pcall(data.Callback)

            if not v111 then
              warn("[Notification Callback Error]: " .. tostring(v112))
            end
          end)
        end

        task.spawn(f4)
      end)
    end

    tween.Play(
      v87, { Size = UDim2.new(0, 200, 0, v101) }, 0.35, Enum.EasingStyle.Back,
      Enum.EasingDirection.Out
    )

    task.delay(0.12, function()
      tween.Play(
        v88, { TextTransparency = 0 }, 0.22, Enum.EasingStyle.Sine, Enum.EasingDirection.Out
      )

      tween.Play(
        v89, { TextTransparency = 0 }, 0.22, Enum.EasingStyle.Sine, Enum.EasingDirection.Out
      )

      tween.Play(
        v90, { TextTransparency = 0 }, 0.22, Enum.EasingStyle.Sine, Enum.EasingDirection.Out
      )

      tween.Play(
        v92, { BackgroundTransparency = 0 }, 0.22, Enum.EasingStyle.Sine,
        Enum.EasingDirection.Out
      )

      tween.Play(
        progressBarFill, { BackgroundTransparency = 0 }, 0.22, Enum.EasingStyle.Sine,
        Enum.EasingDirection.Out
      )

      for index11, value19 in ipairs(v93) do
        tween.Play(
          value19.Instance, { BackgroundTransparency = 0, TextTransparency = 0 }, 0.22,
          Enum.EasingStyle.Sine, Enum.EasingDirection.Out
        )

        if value19.Stroke then
          tween.Play(
            value19.Stroke, { Transparency = 0.8 }, 0.22, Enum.EasingStyle.Sine,
            Enum.EasingDirection.Out
          )
        end
      end

      tween.Play(
        progressBarFill, { Size = UDim2.new(0, 0, 1, 0) }, time, Enum.EasingStyle.Linear,
        Enum.EasingDirection.Out
      )
    end)

    v95 = time

    task.spawn(function()
      while v95 > 0 and not v94 do
        if v89 and v89.Parent then
          v89.Text = "(" .. v95 .. "s)"
        end

        task.wait(1)
        v95 = v95 - 1
      end

      if not v94 then
        f4()
      end
    end)

    local v113 = {
      Host = v87,
      TitleLabel = v88,
      DescLabel = v90,
      CooldownLabel = v89,
      ResetTimer = function(p88)
        v95 = p88 or time

        if v89 and v89.Parent then
          v89.Text = "(" .. v95 .. "s)"
        end
      end,
      Dismiss = f4,
      isDismissed = false,
    }

    if v83.Id then
      notify.ActiveById[v83.Id] = v113
    end

    return v113
  end
end

local v114 = {
  Languages = {
    English = "en",
    Filipino = "fil",
    Indonesian = "id",
    Spanish = "es",
    French = "fr",
    German = "de",
    Japanese = "ja",
    Korean = "ko",
    Vietnamese = "vi",
    Thai = "th",
    Russian = "ru",
    Portuguese = "pt",
    Turkish = "tr",
    Hindi = "hi",
    ["Chinese Simplified"] = "zh-cn",
    ["Chinese Traditional"] = "zh-tw",
    Arabic = "ar",
    Italian = "it",
    Polish = "pl",
    Dutch = "nl",
    Ukrainian = "uk",
    Malay = "ms",
    Bengali = "bn",
    Urdu = "ur",
    Persian = "fa",
    Romanian = "ro",
    Czech = "cs",
    Greek = "el",
    Swedish = "sv",
    Hungarian = "hu",
    Danish = "da",
    Finnish = "fi",
    Norwegian = "no",
    Hebrew = "he",
    Slovak = "sk",
    Bulgarian = "bg",
    Croatian = "hr",
    Serbian = "sr",
    Lithuanian = "lt",
    Latvian = "lv",
    Slovenian = "sl",
  },
  RegisteredElements = {},
  Cache = {},
}

function TranslateText(p89, p90)
  if not p90 or p90 == "" then
    return p90 or ""
  else
    local v115 = p89 .. ":" .. p90

    if v114.Cache[v115] then
      return v114.Cache[v115]
    else
      local v116, v117 = pcall(function()
        local jsonDecode = httpService:JSONDecode((game:HttpGet("https://translate.googleapis.com/translate_a/single?client=gtx&sl=auto&tl="
          .. p89 .. "&dt=t&q=" .. httpService:UrlEncode(p90))))

        local text2 = ""

        if jsonDecode and jsonDecode[1] then
          for index12, value20 in ipairs(jsonDecode[1]) do
            if value20[1] then
              text2 = text2 .. value20[1]
            end
          end
        end

        return text2
      end)

      if v116 and v117 and v117 ~= "" then
        v114.Cache[v115] = v117
        return v117
      end

      return p90
    end
  end
end

function RegisterTranslatable(p91, p92)
  if not p91 or not p92 or p92 == "" then
    return
  end

  v114.RegisteredElements[p91] = { original = p92 }
end

function ApplyTranslation(p93)
  if v114._busy then
    v114._pending = p93
    return
  end

  v114._busy = true
  v114._pending = nil

  local f5

  function f5()
    v114._busy = false

    if v114._pending and v114._pending ~= p93 then
      local pending = v114._pending
      v114._pending = nil
      task.defer(ApplyTranslation, pending)
    end
  end

  if p93 == "en" then
    for key13, value21 in pairs(v114.RegisteredElements) do
      local v118 = key13
      local v119 = value21

      if v118 and v118.Parent then
        pcall(function() v118.Text = v119.original end)
      end
    end

    f5()
    return
  end

  task.spawn(function()
    local v120 = {}
    local v121 = {}

    for key14, value22 in pairs(v114.RegisteredElements) do
      if key14 and key14.Parent then
        local original = value22.original

        if not v120[original] then
          v120[original] = true
          table.insert(v121, original)
        end
      end
    end

    local function f6(p94, text3)
      for key15, value23 in pairs(v114.RegisteredElements) do
        local v122 = key15

        if v122 and v122.Parent and value23.original == p94 then
          pcall(function() v122.Text = text3 end)
        end
      end
    end

    for index13, value24 in ipairs(v121) do
      local v123 = p93 .. ":" .. value24
      local v124 = v114.Cache[v123]
      local v125 = v124 ~= nil

      if not v124 then
        v124 = TranslateText(p93, value24)
        v114.Cache[v123] = v124
      end

      f6(value24, v124 or value24)

      if not v125 then
        task.wait()
      end
    end

    f5()
  end)
end

function v3.CreateWindow(p95, p96)
  local subtitle, version, theme2, credits, v126, v133, v134, v137, v139, v140, v144, v146,
    v151, v154, v155, v156, v157, v163, touchEnabled2, v164, v165, v166, v181, v182, v183, v184,
    bodyVideo, v189, rightControl, v191, v194, v195, v196, v197, v204, v205, v206, v207, v208,
    v209, v224, v225, v226, v227, v228, v229, f11, v230, v231, v232, v233, v234, v235, f12,
    v268, isAutoSave2, get13, v295, v296, text8, v298, v304, v305, v306, v309, v310, v312, v313,
    v314, v315, v318, v319, v321, v322, v323, v324, v325, v395, v396, v397, v414, v419, v420,
    v421, v422, v424, v425, v426, v463, v638

  if type(p96) == "table" then
    p96.Title = "Keshav doom hub"
  end

  if p96.SaveFile and type(p96.SaveFile) == "string" and p96.SaveFile ~= "" then
    getFileName = save:GetFileName(p96.SaveFile)
    save.Settings = {}
    save:Load()
  elseif not getFileName then
    getFileName = save:GetFileName()
    save:Load()
  end

  subtitle = p96.Subtitle or "Untitled"
  version = p96.Version or "v1.0"
  theme2 = p96.Theme or "Emerald"
  credits = p96.Credits or {}

  v126 = {}

  function v126.ColorToHex(p97)
    return string.format(
      "#%02X%02X%02X", math.clamp(math.floor(p97.R * 255 + 0.5), 0, 255),
      math.clamp(math.floor(p97.G * 255 + 0.5), 0, 255),
      (math.clamp(math.floor(p97.B * 255 + 0.5), 0, 255))
    )
  end

  function v126.HexToColor(p98, p99)
    local color7 = p99 or Color3.fromRGB(65, 220, 110)

    if typeof(p98) == "Color3" then
      return p98
    elseif type(p98) ~= "string" then
      return color7
    else
      local gsub4 = p98:gsub("#", ""):gsub("%s+", "")

      if #gsub4 == 6 then
        local v127 = tonumber(gsub4:sub(1, 2), 16)
        local v128 = tonumber(gsub4:sub(3, 4), 16)
        local v129 = tonumber(gsub4:sub(5, 6), 16)

        if v127 and v128 and v129 then
          return Color3.fromRGB(v127, v128, v129)
        end

        return color7
      end

      return color7
    end
  end

  function v126.IsDeveloperBuild()
    local v130 = string.lower(tostring(version))

    return v130 == "developer" or v130 == "v.developer"
      or string.find(v130, "developer", 1, true) ~= nil
  end

  quantumThemeManager.Current = quantumThemeManager.Themes[theme2]
    or quantumThemeManager.Themes.Emerald or quantumThemeManager.Themes.Purple

  function ParseKeySetting(p100)
    if p100 == true then
      return true, nil
    elseif type(p100) ~= "table" then
      return false, nil
    else
      local v131 = nil
      local v132 = false

      for index14, value25 in ipairs(p100) do
        if value25 == true then
          v132 = true
        elseif type(value25) == "string" then
          v131 = value25
        end
      end

      return v132, v131
    end
  end

  do
    v133, v134 = ParseKeySetting(p96.Key)
    local v135 = v134 == "Full"
    local v136 = {}
    v137 = {}
    local v138 = false
    v139 = false
    v140 = p96.Intro ~= false

    function LoadKeyValid()
      local v141 = save.FolderName .. "/Key.json"

      if not isfolder(save.FolderName) or not isfile(v141) then
        return false
      else
        local v142, v143 = pcall(function() return JsonDecode(readfile(v141)) end)

        if not v142 or type(v143) ~= "table" then
          return false
        end

        if type(v143.key) ~= "string" or v143.key == "" then
          return false
        end

        return v143.verified == true
      end
    end

    v144 = v133 and LoadKeyValid() or false

    function v126.HasKeyAccess()
      if not v133 then
        return true
      end

      return v144
    end

    function v126.CreateDummy()
      local v145 = {}

      setmetatable(v145, {
        __index = function(object, key16) return function() return v145 end end,
      })

      return v145
    end

    v146 = v126.CreateDummy()

    function checkCondition(p101)
      if p101 == nil then
        return true
      end

      if type(p101) == "function" then
        local v147, v148 = pcall(p101)
        return v147 and v148
      end

      if type(p101) == "table" and type(p101.fn) == "function" then
        local v149, v150 = pcall(p101.fn)

        if not (v149 and v150) then
          return false
        end

        return true
      end

      return not not p101
    end

    function IsFullLocked()
      return v133 and v135 and not v144 and not v139
    end

    function RefreshKeyLock()
      if not v144 then
        v138 = false
        return
      elseif v138 then
        return
      else
        v138 = true

        if v135 and v151 then
          v151.Visible = false
        end

        for index15, value26 in ipairs(v136) do
          local frame = value26.frame

          if frame and frame.Parent then
            local blocker = value26.blocker

            if blocker and blocker.Parent then
              blocker:Destroy()
            end

            for index16, value27 in ipairs(frame:GetChildren()) do
              if value27:IsA("ImageLabel") and value27.Image == "rbxassetid://7733992528" then
                value27:Destroy()
              end
            end

            frame.BackgroundTransparency = 0.4
            local accentBar = frame:FindFirstChild("AccentBar")

            if accentBar then
              accentBar.BackgroundTransparency = 0
            end
          end
        end

        task.defer(function()
          for index17, value28 in ipairs(v137) do
            local v152 = value28

            pcall(function()
              if v152.saveKey then
                local get3 = save:Get(v152.saveKey, nil)

                if get3 ~= nil then
                  save.Settings[v152.saveKey] = get3
                end
              end

              if v152.UpdateFn then
                v152.UpdateFn()
              end
            end)

            if index17 % 12 == 0 then
              task.wait()
            end
          end
        end)

        return
      end
    end

    function RegisterKeyLocked(p102, p103)
      if not v133 or not p103 then
        return
      elseif v126.HasKeyAccess() then
        return
      else
        p102.BackgroundTransparency = 0.55
        local accentBar2 = p102:FindFirstChild("AccentBar")

        if accentBar2 then
          accentBar2.BackgroundTransparency = 0.8
        end

        for index18, value29 in ipairs(p102:GetDescendants()) do
          if value29:IsA("TextLabel") or value29:IsA("TextButton") then
            if value29.Name == "ButtonLabel" or value29.Name == "ToggleTitle"
              or value29.Name == "SliderTitle" then
              value29.TextColor3 = Color3.fromRGB(105, 145, 115)
            end
          end
        end

        create2("ImageLabel", {
          BackgroundTransparency = 1,
          AnchorPoint = Vector2.new(1, 0),
          Position = UDim2.new(1, -6, 0, 6),
          Size = UDim2.new(0, 11, 0, 11),
          Image = "rbxassetid://7733992528",
          ImageColor3 = Color3.fromRGB(75, 180, 100),
          ImageTransparency = 0.3,
          ZIndex = 10,
        }, p102)

        local v153 = create2("TextButton", {
          Name = "_KeyBlocker",
          BackgroundTransparency = 1,
          Size = UDim2.new(1, 0, 1, 0),
          Text = "",
          ZIndex = 10,
          AutoButtonColor = false,
        }, p102)

        v153.Activated:Connect(function()
          v3.Notification:Notify({
            Title = "Key Required",
            Description = "Verify your key in the Key System panel to unlock this feature.",
          }, { Time = 3 })
        end)

        table.insert(v136, { frame = p102, blocker = v153 })
        return
      end
    end
  end

  v154 = {
    body = nil,
    accentElements = {},
    litGradients = {},
    buttonGradients = {},
  }

  v155 = { List = save:Get("_favorites", {}), Entries = {}, Refresh = nil }

  function ApplyTheme(p104)
    local v158 = quantumThemeManager.Themes[p104]

    if not v158 then
      return
    end

    quantumThemeManager.Current = v158
    save:Save("_activeTheme", p104)

    if v154.body then
      v4:Tween(v154.body, { BackgroundColor3 = v158.Body }, 0.28, Enum.EasingStyle.Quint)
    end

    for index19, value30 in ipairs(v154.accentElements) do
      local v159 = value30[2]
      local v160 = value30[1]
      local accent = v158[value30[3]] or v158.Accent

      if v160 and v160.Parent then
        v4:Tween(v160, { [v159] = accent }, 0.28, Enum.EasingStyle.Quint)
      end
    end

    for index20, value31 in ipairs(v154.litGradients) do
      if value31 and value31.Parent then
        value31.Color = v158.Lit
      end
    end

    for index21, value32 in ipairs(v154.buttonGradients) do
      if value32 and value32.Parent then
        value32.Color = ColorSequence.new({
          ColorSequenceKeypoint.new(0, v158.AccentLight),
          ColorSequenceKeypoint.new(1, v158.AccentDark),
        })
      end
    end

    pcall(function()
      if v157 then
        local uiStroke = v157:FindFirstChildOfClass("UIStroke")

        if uiStroke then
          uiStroke.Color = v158.Accent
        end
      end

      for index22, value33 in ipairs(v156 or {}) do
        if value33.tabUnderline then
          value33.tabUnderline.BackgroundColor3 = v158.Accent
        end
      end
    end)
  end

  function RegisterThemeElement(p105, p106, p107)
    table.insert(v154.accentElements, { p105, p106, p107 or "Accent" })
  end

  function RegisterLitGradient(p108)
    table.insert(v154.litGradients, p108)
  end

  function RegisterButtonGradient(p109)
    table.insert(v154.buttonGradients, p109)
  end

  function CreateAccentBar(p110, p111)
    local v161 = p111 or {}

    local v162 = create2("Frame", {
      Name = "AccentBar",
      BackgroundColor3 = ThemeColor("Accent") or v161.Color or Color3.fromRGB(65, 220, 110),
      BackgroundTransparency = v161.Transparency or 0,
      BorderSizePixel = 0,
      AnchorPoint = Vector2.new(0, 0.5),
      Position = UDim2.new(0, 0, 0.5, 0),
      Size = v161.Size or UDim2.new(0, 2, 0, 14),
      ZIndex = 3,
      Children = { create2("UICorner", { CornerRadius = UDim.new(1, 0) }) },
    }, p110)

    if v161.Gradient then
      RegisterButtonGradient((create2("UIGradient", {
        Color = ColorSequence.new({
          ColorSequenceKeypoint.new(
            0, ThemeColor("AccentLight") or Color3.fromRGB(150, 255, 175)
          ),
          ColorSequenceKeypoint.new(1, ThemeColor("AccentDark") or Color3.fromRGB(20, 145, 65)),
        }),
        Rotation = v161.Gradient and v161.Gradient.Rotation or 90,
      }, v162)))
    end

    RegisterThemeElement(v162, "BackgroundColor3", "Accent")
    return v162
  end

  v163 = create2(
    "ScreenGui", { Name = randomName(), ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, v5
  )

  touchEnabled2 = userInputService.TouchEnabled and not userInputService.KeyboardEnabled
  v164 = touchEnabled2 and 0.45 or 0.5
  v165 = touchEnabled2 and 0.7 or 1

  do
    v166 = create2("UIScale", { Name = "LibraryUIScale", Scale = v165 })
    local v167 = {}

    function UnscaledLayout(p112)
      local scale3 = v166.Scale

      if scale3 == 0 then
        return p112
      end

      return p112 / scale3
    end

    function FitScrollCanvas(p113, p114, p115, p116)
      local v168 = not p113 or not p114
      local v169

      if v168 then
        return
      else
        local v170 = p116 or 4
        local v171 = p115 or "Y"
        local x = v171 == "X" and p114.AbsoluteContentSize.X or p114.AbsoluteContentSize.Y
        local x2 = v171 == "X" and p113.AbsoluteSize.X or p113.AbsoluteSize.Y

        if x2 < 2 then
          x2 = v171 == "X" and p113.Size.X.Offset or p113.Size.Y.Offset
        end

        local v172 = UnscaledLayout(x)
        local v173 = UnscaledLayout(math.max(x2, 0))

        if v172 > 0 then
          v172 = v172 + v170
        end

        local v174 = math.max(v172, 0)
        v169 = v172 > v173 + 1

        if v171 == "X" then
          p113.CanvasSize = UDim2.new(0, v174, 0, 0)

          if not v169 then
            p113.CanvasPosition = Vector2.new(0, p113.CanvasPosition.Y)
          end
        else
          p113.CanvasSize = UDim2.new(0, 0, 0, v174)

          if not v169 then
            p113.CanvasPosition = Vector2.new(p113.CanvasPosition.X, 0)
          end
        end

        p113.ScrollingEnabled = true

        pcall(function()
          p113.ElasticBehavior = v169 and Enum.ElasticBehavior.WhenScrollable
            or Enum.ElasticBehavior.Never
        end)

        return
      end
    end

    local v175 = {}
    local v176 = false

    function DebouncedFitScrollCanvas(p117, p118, p119, p120)
      if not p117 or not p118 then
        return
      end

      v175[p117] = { layout = p118, axis = p119 or "Y", pad = p120 or 2 }

      if not v176 then
        v176 = true

        task.defer(function()
          v176 = false

          for key17, value34 in pairs(v175) do
            v175[key17] = nil
            FitScrollCanvas(key17, value34.layout, value34.axis, value34.pad)
          end
        end)
      end
    end

    function RegisterLayoutRefresh(p121)
      table.insert(v167, p121)
    end

    function ScaledFontSize(p122, p123)
      local scale4 = v166.Scale

      if scale4 <= 0 then
        scale4 = 1
      end

      if scale4 < 1 then
        return math.max(math.floor(p122 * scale4), 4), 1
      end

      return math.min(p122 + math.min(math.floor((scale4 - 1) * 10 + 0.5), 6), 18), 1
    end

    function MakeTextConstraint(p124, p125)
      local v177 = create2("UITextSizeConstraint", {
        MaxTextSize = ScaledFontSize(p124, p125),
        MinTextSize = 1,
      })

      RegisterLayoutRefresh(function()
        v177.MaxTextSize = ScaledFontSize(p124, p125)
        v177.MinTextSize = 1
      end)

      return v177
    end

    function BindScaledText(p126, p127)
      RegisterLayoutRefresh(function() p126.TextSize = ScaledFontSize(p127) end)
    end

    local v178 = false

    function RefreshAllLayouts()
      for index23, value35 in ipairs(v167) do
        pcall(value35)
      end
    end

    function ScheduleRefreshAllLayouts()
      if v178 then
        return
      end

      v178 = true

      task.defer(function()
        v178 = false
        RefreshAllLayouts()
      end)
    end
  end

  do
    function v126.SetUIScalePreview(p128)
      local v179 = math.clamp(p128, v164, 1.8)
      v166.Scale = v179
      v126.CurrentEffectiveScale = v179

      if v126.ToggleClose then
        local uiScale2 = v126.ToggleClose:FindFirstChildOfClass("UIScale")

        if not uiScale2 then
          uiScale2 = create2("UIScale", { Name = "ToggleUIScale" }, v126.ToggleClose)
        end

        uiScale2.Scale = v179

        if v126.ClampToggleClose then
          pcall(v126.ClampToggleClose)
        end
      end

      local parent2 = v3.Notification.GUI and v3.Notification.GUI.Parent

      if parent2 then
        local uiScale3 = parent2:FindFirstChildOfClass("UIScale")

        if not uiScale3 then
          uiScale3 = create2("UIScale", { Name = "LibraryUIScale" }, parent2)
        end

        uiScale3.Scale = v179
      end

      return v179
    end

    function v126.ApplyUIScale(p129)
      local v180 = v126.SetUIScalePreview(p129)
      ScheduleRefreshAllLayouts()
      return v180
    end

    v181 = v165

    local function f7()
      local currentCamera = workspace.CurrentCamera

      if not currentCamera then
        return
      else
        local viewportSize = currentCamera.ViewportSize

        if viewportSize.X < 50 or viewportSize.Y < 50 then
          return
        end

        v126.SetUIScalePreview((math.clamp(v181 * math.min(
          viewportSize.X / (touchEnabled2 and 800 or 1000),
          viewportSize.Y / (touchEnabled2 and 460 or 600), 1
        ), v164, 1.8)))

        ScheduleRefreshAllLayouts()
        return
      end
    end

    local currentCamera2 = workspace.CurrentCamera

    if currentCamera2 then
      currentCamera2:GetPropertyChangedSignal("ViewportSize"):Connect(f7)
      task.defer(f7)
    end

    local applyUIScale = v126.ApplyUIScale

    function v126.ApplyUIScale(p130)
      v181 = p130
      return applyUIScale(p130)
    end

    v182 = create2("Frame", {
      BackgroundColor3 = ThemeColor("Body"),
      BackgroundTransparency = 0.05,
      BorderSizePixel = 0,
      AnchorPoint = Vector2.new(0.5, 0.5),
      Position = UDim2.new(0.5, 0, 0.5, 0),
      Size = UDim2.new(0, 510, 0, 330),
      Visible = not v140,
      Active = true,
      ClipsDescendants = false,
      ZIndex = 10,
      Children = { create2("UICorner", { CornerRadius = UDim.new(0, 10) }) },
    }, v163)

    v166.Parent = v182

    v183 = create2("ImageLabel", {
      Name = "BodyBackground",
      BackgroundTransparency = 1,
      BorderSizePixel = 0,
      Size = UDim2.new(1, 0, 1, 0),
      Image = "",
      ImageTransparency = 0.88,
      ScaleType = Enum.ScaleType.Crop,
      ZIndex = 0,
      Children = { create2("UICorner", { CornerRadius = UDim.new(0, 10) }) },
    }, v182)

    v184 = create2("Frame", {
      Name = "BodyVideoHolder",
      BackgroundColor3 = Color3.fromRGB(0, 0, 0),
      BackgroundTransparency = 1,
      BorderSizePixel = 0,
      Size = UDim2.new(1, 0, 1, 0),
      Visible = false,
      ClipsDescendants = true,
      ZIndex = 0,
      Children = { create2("UICorner", { CornerRadius = UDim.new(0, 10) }) },
    }, v182)
  end

  do
    bodyVideo = nil

    pcall(function()
      bodyVideo = Instance.new("VideoFrame")
      bodyVideo.Name = "BodyVideo"
      bodyVideo.BackgroundTransparency = 1
      bodyVideo.BorderSizePixel = 0
      bodyVideo.Size = UDim2.new(1, 0, 1, 0)
      bodyVideo.Visible = true
      bodyVideo.Looped = true
      bodyVideo.Volume = 0
      bodyVideo.ZIndex = 0
      bodyVideo.Parent = v184
    end)

    function ClearBackgroundMedia()
      v183.Image = ""
      v183.Visible = false

      if v184 then
        v184.Visible = false
      end

      if bodyVideo then
        pcall(function() bodyVideo.Playing = false end)
        pcall(function() bodyVideo:Pause() end)
        pcall(function() bodyVideo.Video = "" end)
      end
    end

    local v185

    function ApplyBackgroundImage(p131, p132)
      local get4 = p132 or save:Get("_opt_BgImageTransparency", 0.88)
      local v186

      if type(p131) ~= "string" or p131 == "" then
        ClearBackgroundMedia()
        save:Save("_opt_BgImage", "")
        return
      elseif isVideo(p131) then
        v183.Image = ""
        v183.Visible = false

        v186 = pathToAsset(p131)

        if not v186 then
          v3.Notification:Notify({
            Title = "Video BG",
            Description = "Could not load video asset. File not found or unsupported.",
          }, { Time = 3 })

          ClearBackgroundMedia()
          return
        end

        if not bodyVideo or not bodyVideo.Parent then
          pcall(function()
            if bodyVideo then
              bodyVideo:Destroy()
            end

            bodyVideo = Instance.new("VideoFrame")
            bodyVideo.Name = "BodyVideo"
            bodyVideo.BackgroundTransparency = 1
            bodyVideo.BorderSizePixel = 0
            bodyVideo.Size = UDim2.new(1, 0, 1, 0)
            bodyVideo.Visible = true
            bodyVideo.Looped = true
            bodyVideo.Volume = 0
            bodyVideo.ZIndex = 0
            bodyVideo.Parent = v184
          end)
        end

        if v184 then
          v184.Visible = true
        end

        if bodyVideo then
          pcall(function()
            bodyVideo.Visible = true
            bodyVideo.Looped = true
            bodyVideo.Volume = 0
            bodyVideo.Video = v186
            bodyVideo.Playing = true
            bodyVideo:Play()
          end)

          task.spawn(function()
            task.wait(0.08)

            pcall(function()
              bodyVideo.Playing = true
              bodyVideo:Play()
            end)

            local v187 = tick()

            while tick() - v187 < 5 do
              local isLoaded = false
              pcall(function() isLoaded = bodyVideo.IsLoaded end)

              if isLoaded then
                pcall(function()
                  bodyVideo.Playing = true
                  bodyVideo:Play()
                end)

                break
              end

              task.wait(0.2)
            end
          end)

          if not v185 then
            v185 = task.spawn(function()
              while true do
                task.wait(1.5)

                if v184 and v184.Visible and bodyVideo and bodyVideo.Parent then
                  local playing = false
                  pcall(function() playing = bodyVideo.Playing end)

                  if not playing then
                    pcall(function()
                      bodyVideo.Playing = true
                      bodyVideo:Play()
                    end)
                  end
                end
              end
            end)
          end
        end

        save:Save("_opt_BgImage", p131)
        return
      else
        local v188 = pathToAsset(p131)

        if not v188 then
          return
        end

        ClearBackgroundMedia()

        v183.Visible = true
        v183.Image = v188
        v183.ImageTransparency = get4

        save:Save("_opt_BgImage", p131)
        return
      end
    end

    local get5 = save:Get("_opt_BgImage", "")

    if get5 ~= "" then
      task.defer(function() ApplyBackgroundImage(get5) end)
    end

    v183.ImageTransparency = save:Get("_opt_BgImageTransparency", 0.88)
    v182.BackgroundTransparency = save:Get("_opt_UITransparency", 0.05)
    v154.body = v182
    protect(v163)
    p95:DestroyGui()
  end

  do
    p95._CurrentGui = v163
    v3.Notification:Init(v182)

    v151 = create2("Frame", {
      Name = "FullLockOverlay",
      BackgroundColor3 = Color3.fromRGB(6, 4, 12),
      BackgroundTransparency = 0.08,
      BorderSizePixel = 0,
      Size = UDim2.new(1, 0, 1, 0),
      Position = UDim2.new(0, 0, 0, 0),
      Visible = false,
      ZIndex = 1003,
      Active = true,
      Children = {
        create2("TextButton", {
          Name = "ClickBlocker",
          BackgroundTransparency = 1,
          Size = UDim2.new(1, 0, 1, 0),
          Position = UDim2.new(0, 0, 0, 0),
          Text = "",
          AutoButtonColor = false,
          ZIndex = 1004,
          Active = true,
        }),
        create2("UICorner", { CornerRadius = UDim.new(0, 10) }),
        create2("UIStroke", {
          Color = Color3.fromRGB(25, 120, 55),
          Transparency = 0.55,
          Thickness = 1,
          ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        }),
        create2("ImageLabel", {
          BackgroundTransparency = 1,
          AnchorPoint = Vector2.new(0.5, 0.5),
          Position = UDim2.new(0.5, 0, 0.38, 0),
          Size = UDim2.new(0, 28, 0, 28),
          Image = "rbxassetid://7733992528",
          ImageColor3 = Color3.fromRGB(65, 220, 110),
          ImageTransparency = 0.1,
          ZIndex = 1004,
        }),
        create2("TextLabel", {
          Name = "LockTitle",
          BackgroundTransparency = 1,
          AnchorPoint = Vector2.new(0.5, 0.5),
          Position = UDim2.new(0.5, 0, 0.52, 0),
          Size = UDim2.new(0.85, 0, 0, 22),
          Font = Enum.Font.FredokaOne,
          Text = "Premium Privilege Only",
          TextColor3 = Color3.fromRGB(135, 245, 160),
          TextSize = 14,
          TextXAlignment = Enum.TextXAlignment.Center,
          ZIndex = 1004,
        }),
        create2("TextLabel", {
          Name = "LockDesc",
          BackgroundTransparency = 1,
          AnchorPoint = Vector2.new(0.5, 0.5),
          Position = UDim2.new(0.5, 0, 0.66, 0),
          Size = UDim2.new(0.88, 0, 0, 36),
          Font = Enum.Font.Gotham,
          RichText = true,
          Text = [[
Premium features require a valid key.
<font color="#34D399">Freemium</font> is still available below.]],
          TextColor3 = Color3.fromRGB(180, 160, 210),
          TextSize = 10,
          TextWrapped = true,
          TextXAlignment = Enum.TextXAlignment.Center,
          ZIndex = 1004,
        }),
        create2("TextButton", {
          Name = "FreemiumBtn",
          BackgroundColor3 = Color3.fromRGB(30, 18, 52),
          BackgroundTransparency = 0.15,
          AnchorPoint = Vector2.new(0.5, 0.5),
          Position = UDim2.new(0.5, 0, 0.82, 0),
          Size = UDim2.new(0.62, 0, 0, 26),
          Font = Enum.Font.GothamBold,
          Text = "Continue Freemium",
          TextColor3 = Color3.fromRGB(130, 230, 180),
          TextSize = 11,
          AutoButtonColor = false,
          ZIndex = 1005,
          Children = {
            create2("UICorner", { CornerRadius = UDim.new(0, 6) }),
            create2("UIStroke", {
              Color = Color3.fromRGB(80, 200, 140),
              Transparency = 0.45,
              Thickness = 1,
              ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
            }),
          },
        }),
        create2("Frame", {
          BackgroundColor3 = Color3.fromRGB(25, 120, 55),
          BackgroundTransparency = 0.7,
          BorderSizePixel = 0,
          AnchorPoint = Vector2.new(0.5, 0.5),
          Position = UDim2.new(0.5, 0, 0.44, 0),
          Size = UDim2.new(0.55, 0, 0, 1),
          ZIndex = 1004,
          Children = {
            create2("UIGradient", {
              Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.2, 0),
                NumberSequenceKeypoint.new(0.8, 0), NumberSequenceKeypoint.new(1, 1),
              }),
            }),
          },
        }),
      },
    }, v182)

    if IsFullLocked() then
      v151.Visible = true
    end

    v189 = create2("Frame", {
      BackgroundColor3 = ThemeColor("Body"),
      BackgroundTransparency = 1,
      BorderSizePixel = 0,
      Position = UDim2.new(0, 0, 0, 0),
      Size = UDim2.new(1, 0, 0, 34),
      ZIndex = 1005,
      Active = true,
      ClipsDescendants = true,
      Children = { create2("UICorner", { CornerRadius = UDim.new(1, 0) }) },
    }, v182)

    create2("TextLabel", {
      Name = "TitleHub",
      BackgroundTransparency = 1,
      Position = UDim2.new(0, 12, 0, 2),
      Size = UDim2.new(0, 240, 0, 16),
      Font = Enum.Font.FredokaOne,
      RichText = true,
      Text = "Keshav Doom Hub",
      TextColor3 = Color3.fromRGB(255, 255, 255),
      TextSize = 13,
      TextTruncate = Enum.TextTruncate.AtEnd,
      TextXAlignment = Enum.TextXAlignment.Left,
    }, v189)

    local v190 = create2("TextLabel", {
      Name = "SubtitleHub",
      BackgroundTransparency = 1,
      Position = UDim2.new(0, 12, 0, 18),
      Size = UDim2.new(0, 160, 0, 12),
      Font = Enum.Font.Gotham,
      RichText = true,
      Text = string.format(
        "<font color=\"#41DC6E\">%s</font> • <font color=\"#FF9E9E\">%s</font>", subtitle,
        os.date("%A")
      ),
      TextColor3 = Color3.fromRGB(200, 200, 200),
      TextSize = 10,
      TextTruncate = Enum.TextTruncate.AtEnd,
      TextXAlignment = Enum.TextXAlignment.Left,
    }, v189)

    function v126.SetSubtitleTier()
      if v126.IsDeveloperBuild() then
        v190.Text = string.format(
          "<font color=\"#41DC6E\">%s</font> • <font color=\"#7286FF\">v.Developer</font> • <font color=\"#FF9E9E\">%s</font>",
          subtitle, os.date("%A")
        )
      elseif v126.HasKeyAccess() then
        v190.Text = string.format(
          "<font color=\"#41DC6E\">%s</font> • <font color=\"#FFD700\">v.Premium</font> • <font color=\"#FF9E9E\">%s</font>",
          subtitle, os.date("%A")
        )
      elseif v133 then
        v190.Text = string.format(
          "<font color=\"#41DC6E\">%s</font> • <font color=\"#34D399\">v.Freemium</font> • <font color=\"#FF9E9E\">%s</font>",
          subtitle, os.date("%A")
        )
      else
        v190.Text = string.format(
          "<font color=\"#41DC6E\">%s</font> • <font color=\"#34D399\">%s</font> • <font color=\"#FF9E9E\">%s</font>",
          subtitle, version, os.date("%A")
        )
      end
    end

    function SetSubtitlePremium()
      v126.SetSubtitleTier()
    end

    v126.SetSubtitleTier()
    local findFirstChild = v151 and v151:FindFirstChild("FreemiumBtn", true)

    if findFirstChild then
      findFirstChild.MouseButton1Click:Connect(function()
        v139 = true
        v151.Visible = false
        v126.SetSubtitleTier()
      end)
    end
  end

  function v126.SyncKeyAccess()
    if v133 then
      v144 = LoadKeyValid()
    end

    if v144 then
      RefreshKeyLock()
    end

    v126.SetSubtitleTier()
  end

  rightControl = Enum.KeyCode.RightControl
  v191 = false
  local v192 = true

  do
    save:RegisterKey("_opt_UIKeybind")
    local v193 = Enum.KeyCode[save:Get("_opt_UIKeybind", "RightControl")]

    if v193 then
      rightControl = v193
    end
  end

  local function f8()
    v192 = not v192
    v182.Visible = v192
  end

  do
    v194 = create2("ImageButton", {
      BackgroundTransparency = 1,
      AnchorPoint = Vector2.new(1, 0.5),
      Position = UDim2.new(1, -34, 0, 16),
      Size = UDim2.new(0, 20, 0, 20),
      ZIndex = 1005,
      Image = "rbxassetid://92966930061759",
    }, v182)

    v195 = create2("ImageButton", {
      BackgroundTransparency = 1,
      AnchorPoint = Vector2.new(1, 0.5),
      Position = UDim2.new(1, -8, 0, 16),
      Size = UDim2.new(0, 20, 0, 20),
      ZIndex = 1005,
      Image = "rbxassetid://79324227570635",
    }, v182)

    v196 = create2("TextButton", {
      Name = "CreditsBtn",
      BackgroundColor3 = Color3.fromRGB(14, 10, 22),
      BackgroundTransparency = 0,
      AnchorPoint = Vector2.new(1, 0.5),
      Position = UDim2.new(1, -62, 0, 16),
      Size = UDim2.new(0, 83, 0, 23),
      Text = "",
      AutoButtonColor = false,
      ZIndex = 1005,
      Children = {
        create2("UICorner", { CornerRadius = UDim.new(0, 6) }),
        create2("UIStroke", {
          Color = Color3.fromRGB(65, 220, 110),
          Transparency = 0.72,
          Thickness = 1,
          ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        }),
        create2("Frame", {
          BackgroundColor3 = Color3.fromRGB(65, 220, 110),
          BackgroundTransparency = 0,
          BorderSizePixel = 0,
          Position = UDim2.new(0, 0, 0.5, -7),
          Size = UDim2.new(0, 2, 0, 14),
          ZIndex = 1006,
          Children = {
            create2("UICorner", { CornerRadius = UDim.new(1, 0) }),
            create2("UIGradient", {
              Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(135, 245, 160)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 60, 220)),
              }),
              Rotation = 90,
            }),
          },
        }),
        create2("ImageLabel", {
          BackgroundTransparency = 1,
          Position = UDim2.new(0, 8, 0.5, -7),
          Size = UDim2.new(0, 14, 0, 14),
          Image = "rbxassetid://83474083071373",
          ImageColor3 = Color3.fromRGB(185, 140, 255),
          ZIndex = 1006,
        }),
        create2("TextLabel", {
          BackgroundTransparency = 1,
          Position = UDim2.new(0, 27, 0, 0),
          Size = UDim2.new(1, -30, 1, 0),
          Font = Enum.Font.GothamBold,
          Text = "Credits",
          TextColor3 = Color3.fromRGB(195, 155, 255),
          TextSize = 11,
          TextXAlignment = Enum.TextXAlignment.Left,
          ZIndex = 1006,
        }),
      },
    }, v182)

    local uiStroke2 = v196:FindFirstChildOfClass("UIStroke")

    util.BindHover(
      v196, { BackgroundColor3 = Color3.fromRGB(22, 14, 38) },
      { BackgroundColor3 = Color3.fromRGB(14, 10, 22) }, { Transparency = 0.38 },
      { Transparency = 0.72 }, uiStroke2
    )

    v197 = create2("TextButton", {
      Name = "SettingsBtn",
      BackgroundColor3 = Color3.fromRGB(14, 10, 22),
      BackgroundTransparency = 0,
      AnchorPoint = Vector2.new(1, 0.5),
      Position = UDim2.new(1, -153, 0, 16),
      Size = UDim2.new(0, 83, 0, 23),
      Text = "",
      AutoButtonColor = false,
      ZIndex = 1005,
      Children = {
        create2("UICorner", { CornerRadius = UDim.new(0, 6) }),
        create2("UIStroke", {
          Color = Color3.fromRGB(65, 220, 110),
          Transparency = 0.72,
          Thickness = 1,
          ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        }),
        create2("Frame", {
          BackgroundColor3 = Color3.fromRGB(65, 220, 110),
          BackgroundTransparency = 0,
          BorderSizePixel = 0,
          Position = UDim2.new(0, 0, 0.5, -7),
          Size = UDim2.new(0, 2, 0, 14),
          ZIndex = 1006,
          Children = {
            create2("UICorner", { CornerRadius = UDim.new(1, 0) }),
            create2("UIGradient", {
              Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(135, 245, 160)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 60, 220)),
              }),
              Rotation = 90,
            }),
          },
        }),
        create2("ImageLabel", {
          BackgroundTransparency = 1,
          Position = UDim2.new(0, 8, 0.5, -7),
          Size = UDim2.new(0, 14, 0, 14),
          Image = "rbxassetid://81151604784579",
          ImageColor3 = Color3.fromRGB(185, 140, 255),
          ZIndex = 1006,
        }),
        create2("TextLabel", {
          BackgroundTransparency = 1,
          Position = UDim2.new(0, 27, 0, 0),
          Size = UDim2.new(1, -30, 1, 0),
          Font = Enum.Font.GothamBold,
          Text = "Settings",
          TextColor3 = Color3.fromRGB(195, 155, 255),
          TextSize = 11,
          TextXAlignment = Enum.TextXAlignment.Left,
          ZIndex = 1006,
        }),
      },
    }, v182)

    local uiStroke3 = v197:FindFirstChildOfClass("UIStroke")

    util.BindHover(
      v197, { BackgroundColor3 = Color3.fromRGB(22, 14, 38) },
      { BackgroundColor3 = Color3.fromRGB(14, 10, 22) }, { Transparency = 0.38 },
      { Transparency = 0.72 }, uiStroke3
    )

    local v198 = false

    function v126.MakeOverlay(text4, image, p133, p134, p135)
      local v199 = create2("Frame", {
        Visible = false,
        Active = true,
        BackgroundTransparency = 0.5,
        BackgroundColor3 = Color3.fromRGB(4, 2, 10),
        Size = UDim2.new(1, 0, 1, 0),
        ZIndex = 20,
      }, v182)

      local v200 = create2("Frame", {
        Visible = false,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        BackgroundColor3 = Color3.fromRGB(11, 8, 18),
        BackgroundTransparency = 0,
        Size = UDim2.new(0, p133, 0, p134),
        ZIndex = 2000,
        Children = {
          create2("UICorner", { CornerRadius = UDim.new(0, 12) }),
          create2("UIStroke", {
            Color = Color3.fromRGB(140, 90, 220),
            Transparency = 0.6,
            Thickness = 1,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
          }),
          create2("Frame", {
            BackgroundColor3 = Color3.fromRGB(80, 40, 160),
            BackgroundTransparency = 0.92,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 0.45, 0),
            Position = UDim2.new(0, 0, 0, 0),
            ZIndex = 21,
            Children = {
              create2("UICorner", { CornerRadius = UDim.new(0, 12) }),
              create2("UIGradient", {
                Transparency = NumberSequence.new({
                  NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1),
                }),
                Rotation = 90,
              }),
            },
          }),
          create2("ImageLabel", {
            BackgroundTransparency = 1,
            AnchorPoint = Vector2.new(0.5, 0),
            Position = UDim2.new(0.5, 0, 0, 14),
            Size = UDim2.new(0, 20, 0, 20),
            Image = image,
            ImageColor3 = Color3.fromRGB(190, 140, 255),
            ZIndex = 22,
          }),
          create2("TextLabel", {
            BackgroundTransparency = 1,
            AnchorPoint = Vector2.new(0.5, 0),
            Position = UDim2.new(0.5, 0, 0, 38),
            Size = UDim2.new(1, -24, 0, 16),
            Font = Enum.Font.FredokaOne,
            Text = text4,
            TextColor3 = Color3.fromRGB(210, 175, 255),
            TextSize = 15,
            TextXAlignment = Enum.TextXAlignment.Center,
            ZIndex = 22,
          }),
          create2("Frame", {
            BackgroundColor3 = Color3.fromRGB(160, 100, 255),
            BackgroundTransparency = 0.72,
            BorderSizePixel = 0,
            AnchorPoint = Vector2.new(0.5, 0),
            Position = UDim2.new(0.5, 0, 0, 57),
            Size = UDim2.new(0.65, 0, 0, 1),
            ZIndex = 22,
            Children = {
              create2("UIGradient", {
                Transparency = NumberSequence.new({
                  NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.2, 0),
                  NumberSequenceKeypoint.new(0.8, 0), NumberSequenceKeypoint.new(1, 1),
                }),
              }),
            },
          }),
        },
      }, v182)

      local vector2 = Vector2.new(0.5, 0)
      local udim = UDim2.new(0.5, 0, 0, 64)
      local udim2 = UDim2.new(1, -16, 1, -100)
      local y = Enum.ScrollingDirection.Y

      local v201 = create2("ScrollingFrame", {
        BackgroundTransparency = 1,
        AnchorPoint = vector2,
        Position = udim,
        Size = udim2,
        Active = true,
        ScrollBarThickness = 0,
        ScrollBarImageTransparency = 1,
        ScrollingDirection = y,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ElasticBehavior = Enum.ElasticBehavior.WhenScrollable,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ZIndex = 22,
        Children = {
          create2("UIListLayout", {
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 4),
          }),
          create2("UIPadding", {
            PaddingTop = UDim.new(0, 3),
            PaddingBottom = UDim.new(0, 3),
            PaddingLeft = UDim.new(0, 2),
            PaddingRight = UDim.new(0, 2),
          }),
        },
      }, v200)

      local v202 = create2("TextButton", {
        Name = "CloseBtn",
        BackgroundColor3 = Color3.fromRGB(30, 18, 52),
        BackgroundTransparency = 0,
        AnchorPoint = Vector2.new(0.5, 1),
        Size = UDim2.new(0.52, 0, 0, 24),
        Position = UDim2.new(0.5, 0, 1, -9),
        Text = "Close",
        TextColor3 = Color3.fromRGB(180, 135, 255),
        Font = Enum.Font.GothamBold,
        TextSize = 11,
        AutoButtonColor = false,
        ZIndex = 22,
        Children = {
          create2("UICorner", { CornerRadius = UDim.new(0, 6) }),
          create2("UIStroke", {
            Color = Color3.fromRGB(140, 90, 220),
            Transparency = 0.65,
            Thickness = 1,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
          }),
        },
      }, v200)

      v202.MouseEnter:Connect(function()
        v4:Tween(
          v202, { BackgroundColor3 = Color3.fromRGB(50, 28, 85) }, 0.15, Enum.EasingStyle.Quint
        )
      end)

      v202.MouseLeave:Connect(function()
        v4:Tween(
          v202, { BackgroundColor3 = Color3.fromRGB(30, 18, 52) }, 0.2, Enum.EasingStyle.Quint
        )
      end)

      local v203 = false

      local function f9()
        if not v203 then
          return
        end

        v203 = false

        v4:Tween(
          v199, { BackgroundTransparency = 1 }, 0.2, Enum.EasingStyle.Quad,
          Enum.EasingDirection.In
        )

        v4:Tween(v200, { Size = UDim2.new(0, p133 * 0.7, 0, p134 * 0.7), BackgroundTransparency = 0.5 }, 0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.In, function()
          if not v203 then
            v200.Visible = false
            v199.Visible = false

            v200.Size = UDim2.new(0, p133, 0, p134)
            v200.BackgroundTransparency = 0

            if p135 then
              p135()
            end
          end
        end)
      end

      v202.MouseButton1Click:Connect(f9)

      v199.InputBegan:Connect(function(input4)
        if v198 then
          return
        end

        if input4.UserInputType == Enum.UserInputType.MouseButton1
          or input4.UserInputType == Enum.UserInputType.Touch then
          f9()
        end
      end)

      return v200, v201, v199, function()
        v203 = true

        v199.BackgroundTransparency = 1
        v199.Visible = true

        v200.Visible = true
        v200.Size = UDim2.new(0, p133 * 0.7, 0, p134 * 0.7)
        v200.BackgroundTransparency = 0.5

        v4:Tween(
          v199, { BackgroundTransparency = 0.5 }, 0.24, Enum.EasingStyle.Quad,
          Enum.EasingDirection.Out
        )

        v4:Tween(
          v200, { Size = UDim2.new(0, p133, 0, p134), BackgroundTransparency = 0 }, 0.28,
          Enum.EasingStyle.Back, Enum.EasingDirection.Out
        )
      end, f9, function() return v203 end
    end

    v204, v205, v206, v207, v208, v209 = v126.MakeOverlay(
      "Credits", "rbxassetid://83474083071373", 270, 270, nil
    )

    local v210 = {
      ServerOwner = Color3.fromRGB(255, 200, 80),
      MainDeveloper = Color3.fromRGB(65, 220, 110),
      WebDesigner = Color3.fromRGB(100, 200, 255),
      Tester = Color3.fromRGB(80, 225, 160),
    }

    if #credits > 0 then
      create2("TextLabel", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 14),
        Font = Enum.Font.GothamBold,
        Text = "TEAM",
        TextColor3 = Color3.fromRGB(130, 90, 200),
        TextSize = 9,
        TextXAlignment = Enum.TextXAlignment.Center,
        ZIndex = 23,
      }, v205)
    end

    for index24, value36 in ipairs(credits) do
      local role = value36.Role or "Developer"
      local name3 = value36.Name or "Unknown"
      local url = value36.Url or ""
      local urlIcon = value36.UrlIcon or "rbxassetid://83474083071373"
      local urlTag = value36.UrlTag or "View Profile"
      local color8 = v210[role] or Color3.fromRGB(65, 220, 110)
      local g = color8.G
      local b = color8.B
      local r = color8.R
      local v211 = url ~= "" and 80 or 60

      local v212 = create2("Frame", {
        BackgroundColor3 = Color3.fromRGB(10, 7, 18),
        BackgroundTransparency = 0,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, v211),
        ZIndex = 23,
        ClipsDescendants = true,
        Children = { create2("UICorner", { CornerRadius = UDim.new(0, 12) }) },
      }, v205)

      create2("Frame", {
        BackgroundColor3 = color8,
        BackgroundTransparency = 0.86,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 1, 0),
        ZIndex = 23,
        Children = {
          create2("UICorner", { CornerRadius = UDim.new(0, 12) }),
          create2("UIGradient", {
            Color = ColorSequence.new({
              ColorSequenceKeypoint.new(0, Color3.new(r * 0.5, g * 0.5, b * 0.5)),
              ColorSequenceKeypoint.new(1, Color3.fromRGB(6, 4, 12)),
            }),
            Rotation = 135,
          }),
        },
      }, v212)

      local v213 = create2("UIStroke", {
        Color = color8,
        Transparency = 0.65,
        Thickness = 1,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
      }, v212)

      create2("Frame", {
        BackgroundColor3 = color8,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, 8),
        Size = UDim2.new(0, 3, 1, -16),
        ZIndex = 25,
        Children = {
          create2("UICorner", { CornerRadius = UDim.new(1, 0) }),
          create2("UIGradient", {
            Color = ColorSequence.new({
              ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
              ColorSequenceKeypoint.new(1, color8),
            }),
            Rotation = 90,
          }),
        },
      }, v212)

      local v214 = create2("Frame", {
        BackgroundColor3 = Color3.new(r * 0.18, g * 0.18, b * 0.18),
        BorderSizePixel = 0,
        Position = UDim2.new(0, 12, 0, 10),
        Size = UDim2.new(0, 36, 0, 36),
        ZIndex = 25,
        Children = {
          create2("UICorner", { CornerRadius = UDim.new(1, 0) }),
          create2("UIStroke", {
            Color = color8,
            Transparency = 0.4,
            Thickness = 1.5,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
          }),
          create2("TextLabel", {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            Font = Enum.Font.FredokaOne,
            Text = string.upper(string.sub(tostring(name3 or "?"), 1, 1)),
            TextColor3 = color8,
            TextSize = 18,
            TextXAlignment = Enum.TextXAlignment.Center,
            ZIndex = 26,
          }),
        },
      }, v212)

      create2("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 58, 0, 10),
        Size = UDim2.new(1, -148, 0, 16),
        Font = Enum.Font.FredokaOne,
        Text = name3,
        TextColor3 = Color3.fromRGB(242, 235, 255),
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 25,
      }, v212)

      create2("Frame", {
        AnchorPoint = Vector2.new(1, 0),
        BackgroundColor3 = Color3.new(r * 0.12, g * 0.12, b * 0.12),
        BorderSizePixel = 0,
        Position = UDim2.new(1, -8, 0, 10),
        Size = UDim2.new(0, 76, 0, 20),
        ZIndex = 25,
        Children = {
          create2("UICorner", { CornerRadius = UDim.new(0, 6) }),
          create2("UIStroke", {
            Color = color8,
            Transparency = 0.5,
            Thickness = 1,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
          }),
          create2("UIGradient", {
            Color = ColorSequence.new({
              ColorSequenceKeypoint.new(0, Color3.new(r * 0.24, g * 0.24, b * 0.24)),
              ColorSequenceKeypoint.new(1, Color3.new(r * 0.08, g * 0.08, b * 0.08)),
            }),
            Rotation = 90,
          }),
          create2("TextLabel", {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            Font = Enum.Font.GothamBold,
            Text = role,
            TextColor3 = color8,
            TextSize = 9,
            TextXAlignment = Enum.TextXAlignment.Center,
            ZIndex = 26,
          }),
        },
      }, v212)

      create2("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 58, 0, 28),
        Size = UDim2.new(1, -148, 0, 12),
        Font = Enum.Font.Gotham,
        Text = string.lower(role),
        TextColor3 = Color3.new(r * 0.82, g * 0.82, b * 0.82),
        TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 25,
      }, v212)

      if url ~= "" then
        create2("Frame", {
          BackgroundColor3 = color8,
          BackgroundTransparency = 0.78,
          BorderSizePixel = 0,
          Position = UDim2.new(0, 10, 0, 52),
          Size = UDim2.new(1, -20, 0, 1),
          ZIndex = 25,
          Children = {
            create2("UIGradient", {
              Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.15, 0),
                NumberSequenceKeypoint.new(0.85, 0), NumberSequenceKeypoint.new(1, 1),
              }),
            }),
          },
        }, v212)

        create2("ImageLabel", {
          BackgroundTransparency = 1,
          Position = UDim2.new(0, 14, 0, 57),
          Size = UDim2.new(0, 13, 0, 13),
          Image = urlIcon,
          ImageColor3 = Color3.new(r * 0.8, g * 0.8, b * 0.8),
          ZIndex = 26,
        }, v212)

        create2("TextLabel", {
          BackgroundTransparency = 1,
          Position = UDim2.new(0, 32, 0, 56),
          Size = UDim2.new(1, -140, 0, 14),
          Font = Enum.Font.Gotham,
          Text = urlTag,
          TextColor3 = Color3.new(r * 0.75, g * 0.75, b * 0.75),
          TextSize = 10,
          TextXAlignment = Enum.TextXAlignment.Left,
          ZIndex = 26,
        }, v212)

        local v215 = create2("TextButton", {
          AnchorPoint = Vector2.new(1, 0),
          BackgroundColor3 = Color3.new(r * 0.12, g * 0.12, b * 0.12),
          BackgroundTransparency = 0,
          BorderSizePixel = 0,
          Position = UDim2.new(1, -8, 0, 55),
          Size = UDim2.new(0, 68, 0, 20),
          AutoButtonColor = false,
          Text = "",
          ZIndex = 26,
          Children = {
            create2("UICorner", { CornerRadius = UDim.new(0, 6) }),
            create2("UIStroke", {
              Color = color8,
              Transparency = 0.5,
              Thickness = 1,
              ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
            }),
            create2("UIGradient", {
              Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.new(r * 0.26, g * 0.26, b * 0.26)),
                ColorSequenceKeypoint.new(1, Color3.new(r * 0.08, g * 0.08, b * 0.08)),
              }),
              Rotation = 90,
            }),
          },
        }, v212)

        local v216 = create2("TextLabel", {
          BackgroundTransparency = 1,
          Size = UDim2.new(1, 0, 1, 0),
          Font = Enum.Font.GothamBold,
          Text = "COPY LINK",
          TextColor3 = color8,
          TextSize = 9,
          TextXAlignment = Enum.TextXAlignment.Center,
          ZIndex = 27,
        }, v215)

        local uiStroke4 = v215:FindFirstChildOfClass("UIStroke")

        v215.MouseEnter:Connect(function()
          v4:Tween(
            v215, { BackgroundColor3 = Color3.new(r * 0.28, g * 0.28, b * 0.28) }, 0.12,
            Enum.EasingStyle.Quint
          )

          v4:Tween(uiStroke4, { Transparency = 0.15 }, 0.12)
        end)

        v215.MouseLeave:Connect(function()
          v4:Tween(
            v215, { BackgroundColor3 = Color3.new(r * 0.12, g * 0.12, b * 0.12) }, 0.18,
            Enum.EasingStyle.Quint
          )

          v4:Tween(uiStroke4, { Transparency = 0.5 }, 0.18)
        end)

        v215.MouseButton1Click:Connect(function()
          CircleClick(v215, getMouse.X, getMouse.Y)
          pcall(function() (setclipboard or toclipboard)(url) end)

          v216.Text = "COPIED"
          v216.TextColor3 = Color3.fromRGB(100, 255, 160)

          v4:Tween(
            v215, { BackgroundColor3 = Color3.fromRGB(14, 60, 32) }, 0.12,
            Enum.EasingStyle.Quint
          )

          task.delay(1.4, function()
            v216.Text = "COPY LINK"
            v216.TextColor3 = color8

            v4:Tween(
              v215, { BackgroundColor3 = Color3.new(r * 0.12, g * 0.12, b * 0.12) }, 0.25,
              Enum.EasingStyle.Quint
            )
          end)

          v3.Notification:Notify({
            Title = name3,
            Description = "Profile link copied to clipboard!",
          }, { Time = 2 })
        end)
      end

      local v217 = create2("TextButton", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, url ~= "" and 54 or v211),
        Text = "",
        ZIndex = 28,
        AutoButtonColor = false,
      }, v212)

      v217.MouseEnter:Connect(function()
        v4:Tween(
          v212, { BackgroundColor3 = Color3.new(r * 0.06, g * 0.04, b * 0.11) }, 0.14,
          Enum.EasingStyle.Quint
        )

        v4:Tween(v213, { Transparency = 0.28 }, 0.14)

        v4:Tween(
          v214, { Size = UDim2.new(0, 39, 0, 39), Position = UDim2.new(0, 11, 0, 9) }, 0.18,
          Enum.EasingStyle.Back, Enum.EasingDirection.Out
        )
      end)

      v217.MouseLeave:Connect(function()
        v4:Tween(
          v212, { BackgroundColor3 = Color3.fromRGB(10, 7, 18) }, 0.2, Enum.EasingStyle.Quint
        )

        v4:Tween(v213, { Transparency = 0.65 }, 0.2)

        v4:Tween(
          v214, { Size = UDim2.new(0, 36, 0, 36), Position = UDim2.new(0, 12, 0, 10) }, 0.2,
          Enum.EasingStyle.Quint
        )
      end)
    end

    create2("Frame", {
      BackgroundColor3 = Color3.fromRGB(140, 90, 220),
      BackgroundTransparency = 0.78,
      BorderSizePixel = 0,
      Size = UDim2.new(1, 0, 0, 1),
      ZIndex = 23,
      Children = {
        create2("UIGradient", {
          Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.12, 0),
            NumberSequenceKeypoint.new(0.88, 0), NumberSequenceKeypoint.new(1, 1),
          }),
        }),
      },
    }, v205)

    local v218 = create2("Frame", {
      BackgroundTransparency = 1,
      Size = UDim2.new(1, 0, 0, 22),
      ZIndex = 23,
    }, v205)

    create2("TextLabel", {
      BackgroundTransparency = 1,
      Position = UDim2.new(0, 0, 0, 4),
      Size = UDim2.new(1, 0, 0, 14),
      Font = Enum.Font.GothamBold,
      Text = "COMMUNITY",
      TextColor3 = Color3.fromRGB(130, 90, 200),
      TextSize = 9,
      TextXAlignment = Enum.TextXAlignment.Center,
      ZIndex = 24,
    }, v218)

    function v126.MakePremiumSocialCard(p136, p137)
      local accentColor = p137.AccentColor
      local g2 = accentColor.G
      local b2 = accentColor.B
      local r2 = accentColor.R

      local v219 = create2("Frame", {
        BackgroundColor3 = Color3.fromRGB(10, 7, 18),
        BackgroundTransparency = 0,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 72),
        ZIndex = 23,
        ClipsDescendants = true,
        Children = { create2("UICorner", { CornerRadius = UDim.new(0, 12) }) },
      }, p136)

      create2("Frame", {
        BackgroundColor3 = accentColor,
        BackgroundTransparency = 0.88,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 1, 0),
        ZIndex = 23,
        Children = {
          create2("UICorner", { CornerRadius = UDim.new(0, 12) }),
          create2("UIGradient", {
            Color = ColorSequence.new({
              ColorSequenceKeypoint.new(0, Color3.new(r2 * 0.6, g2 * 0.6, b2 * 0.6)),
              ColorSequenceKeypoint.new(1, Color3.fromRGB(6, 4, 12)),
            }),
            Rotation = 135,
          }),
        },
      }, v219)

      create2("UIStroke", {
        Color = accentColor,
        Transparency = 0.65,
        Thickness = 1,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
      }, v219)

      create2("Frame", {
        BackgroundColor3 = accentColor,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, 10),
        Size = UDim2.new(0, 3, 1, -20),
        ZIndex = 25,
        Children = {
          create2("UICorner", { CornerRadius = UDim.new(1, 0) }),
          create2("UIGradient", {
            Color = ColorSequence.new({
              ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
              ColorSequenceKeypoint.new(1, accentColor),
            }),
            Rotation = 90,
          }),
        },
      }, v219)

      local v220 = create2("Frame", {
        BackgroundColor3 = Color3.new(r2 * 0.18, g2 * 0.18, b2 * 0.18),
        BorderSizePixel = 0,
        Position = UDim2.new(0, 14, 0.5, -20),
        Size = UDim2.new(0, 40, 0, 40),
        ZIndex = 25,
        Children = {
          create2("UICorner", { CornerRadius = UDim.new(1, 0) }),
          create2("UIStroke", {
            Color = accentColor,
            Transparency = 0.4,
            Thickness = 1.5,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
          }),
          create2("ImageLabel", {
            BackgroundTransparency = 1,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Size = UDim2.new(0, 20, 0, 20),
            Image = p137.IconImg,
            ImageColor3 = accentColor,
            ZIndex = 26,
          }),
        },
      }, v219)

      create2("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 64, 0, 14),
        Size = UDim2.new(1, -160, 0, 18),
        Font = Enum.Font.FredokaOne,
        Text = p137.Label,
        TextColor3 = Color3.fromRGB(240, 235, 255),
        TextSize = 15,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 25,
      }, v219)

      create2("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 64, 0, 34),
        Size = UDim2.new(1, -160, 0, 12),
        Font = Enum.Font.Gotham,
        Text = p137.SubLabel,
        TextColor3 = Color3.new(r2 * 0.8, g2 * 0.8, b2 * 0.8),
        TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 25,
      }, v219)

      local v221 = create2("TextButton", {
        AnchorPoint = Vector2.new(1, 0.5),
        BackgroundColor3 = Color3.new(r2 * 0.14, g2 * 0.14, b2 * 0.14),
        BackgroundTransparency = 0,
        BorderSizePixel = 0,
        Position = UDim2.new(1, -10, 0.5, 0),
        Size = UDim2.new(0, 68, 0, 28),
        AutoButtonColor = false,
        Text = "",
        ZIndex = 26,
        Children = {
          create2("UICorner", { CornerRadius = UDim.new(0, 8) }),
          create2("UIStroke", {
            Color = accentColor,
            Transparency = 0.45,
            Thickness = 1,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
          }),
          create2("UIGradient", {
            Color = ColorSequence.new({
              ColorSequenceKeypoint.new(0, Color3.new(r2 * 0.28, g2 * 0.28, b2 * 0.28)),
              ColorSequenceKeypoint.new(1, Color3.new(r2 * 0.1, g2 * 0.1, b2 * 0.1)),
            }),
            Rotation = 90,
          }),
        },
      }, v219)

      local v222 = create2("TextLabel", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Font = Enum.Font.GothamBold,
        Text = p137.BadgeText or "COPY",
        TextColor3 = accentColor,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Center,
        ZIndex = 27,
      }, v221)

      local uiStroke5 = v221:FindFirstChildOfClass("UIStroke")
      local uiStroke6 = v219:FindFirstChildOfClass("UIStroke")

      local v223 = create2("TextButton", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Text = "",
        ZIndex = 28,
        AutoButtonColor = false,
      }, v219)

      v223.MouseEnter:Connect(function()
        v4:Tween(
          v219, { BackgroundColor3 = Color3.new(r2 * 0.07, g2 * 0.04, b2 * 0.12) }, 0.14,
          Enum.EasingStyle.Quint
        )

        v4:Tween(uiStroke6, { Transparency = 0.3 }, 0.14)

        v4:Tween(
          v220, { Size = UDim2.new(0, 43, 0, 43), Position = UDim2.new(0, 12, 0.5, -21) }, 0.18,
          Enum.EasingStyle.Back, Enum.EasingDirection.Out
        )
      end)

      v223.MouseLeave:Connect(function()
        v4:Tween(
          v219, { BackgroundColor3 = Color3.fromRGB(10, 7, 18) }, 0.2, Enum.EasingStyle.Quint
        )

        v4:Tween(uiStroke6, { Transparency = 0.65 }, 0.2)

        v4:Tween(
          v220, { Size = UDim2.new(0, 40, 0, 40), Position = UDim2.new(0, 14, 0.5, -20) }, 0.2,
          Enum.EasingStyle.Quint
        )
      end)

      v221.MouseEnter:Connect(function()
        v4:Tween(
          v221, { BackgroundColor3 = Color3.new(r2 * 0.28, g2 * 0.28, b2 * 0.28) }, 0.12,
          Enum.EasingStyle.Quint
        )

        v4:Tween(uiStroke5, { Transparency = 0.15 }, 0.12)
      end)

      v221.MouseLeave:Connect(function()
        v4:Tween(
          v221, { BackgroundColor3 = Color3.new(r2 * 0.14, g2 * 0.14, b2 * 0.14) }, 0.18,
          Enum.EasingStyle.Quint
        )

        v4:Tween(uiStroke5, { Transparency = 0.45 }, 0.18)
      end)

      local function f10()
        CircleClick(v221, getMouse.X, getMouse.Y)
        pcall(function() (setclipboard or toclipboard)(p137.CopyText) end)

        v222.Text = "COPIED"
        v222.TextColor3 = Color3.fromRGB(100, 255, 160)

        v4:Tween(
          v221, { BackgroundColor3 = Color3.new(r2 * 0.1, g2 * 0.4, b2 * 0.25) }, 0.12,
          Enum.EasingStyle.Quint
        )

        v4:Tween(uiStroke5, { Transparency = 0 }, 0.12)
        v4:Tween(uiStroke6, { Transparency = 0.15 }, 0.12)

        task.delay(1.4, function()
          v222.Text = p137.BadgeText or "COPY"
          v222.TextColor3 = accentColor

          v4:Tween(
            v221, { BackgroundColor3 = Color3.new(r2 * 0.14, g2 * 0.14, b2 * 0.14) }, 0.35,
            Enum.EasingStyle.Quint
          )

          v4:Tween(uiStroke5, { Transparency = 0.45 }, 0.35)
          v4:Tween(uiStroke6, { Transparency = 0.65 }, 0.35)
        end)

        if p137.OnClick then
          p137.OnClick(p137.CopyText)
        end
      end

      v221.MouseButton1Click:Connect(f10)
      v223.MouseButton1Click:Connect(f10)
      return v219
    end

    local color9 = Color3.fromRGB(210, 145, 255)

    v126.MakePremiumSocialCard(v205, {
      Label = "TikTok",
      SubLabel = "@trustmenotcondom",
      IconImg = "http://www.roblox.com/asset/?id=14620084334",
      AccentColor = color9,
      BadgeText = "COPY",
      CopyText = "https://www.tiktok.com/@trustmenotcondom?_t=ZS-8syewdU3Bxq&_r=1",
      OnClick = function()
        v3.Notification:Notify({
          Title = "TikTok",
          Description = "TikTok link copied to clipboard.",
        }, { Time = 2 })
      end,
    })

    v126.MakePremiumSocialCard(v205, {
      Label = "Discord",
      SubLabel = "discord.gg/YEvpu5St2Z",
      IconImg = "rbxassetid://129297846250682",
      AccentColor = Color3.fromRGB(114, 137, 255),
      BadgeText = "COPY",
      CopyText = "https://discord.gg/YEvpu5St2Z",
      OnClick = function()
        v3.Notification:Notify({
          Title = "Discord",
          Description = "Discord invite copied to clipboard.",
        }, { Time = 3 })
      end,
    })

    v224, v225, v226, v227, v228, v229 = v126.MakeOverlay(
      "Settings", "rbxassetid://81151604784579", 270, 270, nil
    )

    f11 = v228

    v230, v231, v232, v233, v234, v235 = v126.MakeOverlay(
      "Save Manager", "rbxassetid://7733715400", 270, 270, nil
    )

    f12 = v234

    v196.MouseButton1Click:Connect(function()
      CircleClick(v196, getMouse.X, getMouse.Y)

      if v229 and v229() then
        f11()
      end

      if v235 and v235() then
        f12()
      end

      v207()
    end)

    function CloseFullLock()
      if IsFullLocked() and v151 then
        v151.Visible = true
      end
    end

    function v126.MakeMiniToggle(p138, p139, p140, p141, p142, p143, p144)
      local v236 = p142 or 23
      local v237 = p143 and not v126.HasKeyAccess()

      if v237 then
        save:Save(p140, false)
      end

      local get6 = save:Get(p140, p141)

      if v237 then
        get6 = false
      end

      local v238 = create2("Frame", {
        BackgroundColor3 = Color3.fromRGB(18, 12, 30),
        BackgroundTransparency = 0.2,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 34),
        ZIndex = v236,
        Children = { create2("UICorner", { CornerRadius = UDim.new(0, 8) }) },
      }, p138)

      local v239 = create2("UIStroke", {
        Color = Color3.fromRGB(140, 90, 220),
        Transparency = get6 and not v237 and 0.45 or 0.82,
        Thickness = 1,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
      }, v238)

      local v240 = create2("Frame", {
        BackgroundColor3 = Color3.fromRGB(160, 100, 255),
        BackgroundTransparency = get6 and not v237 and 0 or 0.8,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0.5, -10),
        Size = UDim2.new(0, 3, 0, 20),
        ZIndex = v236 + 1,
        Children = {
          create2("UICorner", { CornerRadius = UDim.new(1, 0) }),
          create2("UIGradient", {
            Color = ColorSequence.new({
              ColorSequenceKeypoint.new(0, Color3.fromRGB(220, 170, 255)),
              ColorSequenceKeypoint.new(1, Color3.fromRGB(110, 55, 210)),
            }),
            Rotation = 90,
          }),
        },
      }, v238)

      local v241 = create2("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 14, 0, 0),
        Size = UDim2.new(1, -70, 1, 0),
        Font = Enum.Font.GothamBold,
        Text = p139 .. (v237 and " (Premium)" or ""),
        TextColor3 = get6 and not v237 and Color3.fromRGB(215, 185, 255)
          or Color3.fromRGB(155, 130, 195),
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = v236 + 1,
      }, v238)

      if v237 then
        create2("ImageLabel", {
          BackgroundTransparency = 1,
          AnchorPoint = Vector2.new(1, 0.5),
          Position = UDim2.new(1, -54, 0.5, 0),
          Size = UDim2.new(0, 12, 0, 12),
          Image = "rbxassetid://7733992528",
          ImageColor3 = Color3.fromRGB(75, 180, 100),
          ZIndex = v236 + 3,
        }, v238)
      end

      local v242 = create2("Frame", {
        BackgroundColor3 = get6 and not v237 and Color3.fromRGB(90, 45, 170)
          or Color3.fromRGB(14, 9, 26),
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -10, 0.5, 0),
        Size = UDim2.new(0, 38, 0, 20),
        BorderSizePixel = 0,
        ZIndex = v236 + 2,
        Children = { create2("UICorner", { CornerRadius = UDim.new(1, 0) }) },
      }, v238)

      local v243 = {
        Color = Color3.fromRGB(140, 90, 220),
        Transparency = get6 and not v237 and 0.4 or 0.72,
        Thickness = 1,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
      }

      local v244 = get6
      local v245 = create2("UIStroke", v243, v242)
      local vector3 = Vector2.new(0, 0.5)
      v244 = get6 and not v237

      local udim3 = v244
      udim3 = v244 and UDim2.new(0, 20, 0.5, 0)

      local udim4 = udim3
      udim4 = udim3 or UDim2.new(0, 3, 0.5, 0)

      local udim5 = UDim2.new(0, 14, 0, 14)

      local v246 = create2("Frame", {
        AnchorPoint = vector3,
        Position = udim4,
        Size = udim5,
        BorderSizePixel = 0,
        ZIndex = v236 + 3,
        Children = {
          create2("UICorner", { CornerRadius = UDim.new(1, 0) }),
          create2("UIGradient", {
            Color = ColorSequence.new({
              ColorSequenceKeypoint.new(0, get6 and not v237 and Color3.fromRGB(235, 205, 255)
                or Color3.fromRGB(120, 100, 150)),
              ColorSequenceKeypoint.new(1, get6 and not v237 and Color3.fromRGB(170, 105, 255)
                or Color3.fromRGB(60, 50, 90)),
            }),
            Rotation = 135,
          }),
        },
      }, v242)

      local uiGradient = v246:FindFirstChildOfClass("UIGradient")

      local v247 = create2("TextButton", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Text = "",
        ZIndex = v236 + 4,
      }, v238)

      local v248 = get6

      v247.MouseButton1Click:Connect(function()
        if v237 then
          v3.Notification:Notify({
            Title = "Premium Only",
            Description = "This feature requires a premium key.",
          }, { Time = 3 })

          return
        end

        v248 = not v248

        v4:Tween(
          v246, { Position = v248 and UDim2.new(0, 20, 0.5, 0) or UDim2.new(0, 3, 0.5, 0) },
          0.22, Enum.EasingStyle.Back
        )

        v4:Tween(v242, {
          BackgroundColor3 = v248 and Color3.fromRGB(90, 45, 170) or Color3.fromRGB(14, 9, 26),
        }, 0.2, Enum.EasingStyle.Quint)

        v4:Tween(v245, { Transparency = v248 and 0.4 or 0.72 }, 0.2)
        v4:Tween(v239, { Transparency = v248 and 0.45 or 0.82 }, 0.2)
        v4:Tween(v240, { BackgroundTransparency = v248 and 0 or 0.8 }, 0.2)

        v4:Tween(v241, {
          TextColor3 = v248 and Color3.fromRGB(215, 185, 255) or Color3.fromRGB(155, 130, 195),
        }, 0.2)

        if uiGradient then
          uiGradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, v248 and Color3.fromRGB(235, 205, 255)
              or Color3.fromRGB(120, 100, 150)),
            ColorSequenceKeypoint.new(1, v248 and Color3.fromRGB(170, 105, 255)
              or Color3.fromRGB(60, 50, 90)),
          })
        end

        save:Save(p140, v248)

        if typeof(p144) == "function" then
          pcall(p144, v248)
        end
      end)

      return function() return v248 end
    end

    function v126.MakeMiniSlider(p145, text5, p146, p147, p148, p149, p150, p151, p152, p153)
      local v249 = p152 or 23
      local v250 = p150
      local v251 = p149
      local v252 = p153
      v250 = v250 or 0.05
      v252 = v252 == true
      save:RegisterKey(p146)
      local get7 = save:Get(p146, v251)

      if get7 ~= nil then
        v251 = get7
      end

      local v253 = math.clamp(v251, p147, p148)
      local v254 = touchEnabled2 and 16 or 12
      local v255 = touchEnabled2 and 20 or 14

      local function f13(p154)
        return math.floor(p154 / v250 + 0.5) * v250
      end

      local function f14(p155)
        return math.floor(p155 * 100 + 0.5) .. "%"
      end

      local parent3 = p145
      local v256

      while parent3 do
        if parent3:IsA("ScrollingFrame") then
          v256 = parent3
          break
        end

        parent3 = parent3.Parent
      end

      local v257 = create2("Frame", {
        BackgroundColor3 = Color3.fromRGB(18, 12, 30),
        BackgroundTransparency = 0.2,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, touchEnabled2 and 52 or 48),
        Active = true,
        ZIndex = v249,
        Children = { create2("UICorner", { CornerRadius = UDim.new(0, 8) }) },
      }, p145)

      create2("UIStroke", {
        Color = Color3.fromRGB(140, 90, 220),
        Transparency = 0.7,
        Thickness = 1,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
      }, v257)

      create2("Frame", {
        BackgroundColor3 = Color3.fromRGB(160, 100, 255),
        BackgroundTransparency = 0.15,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0.5, -12),
        Size = UDim2.new(0, 3, 0, 24),
        ZIndex = v249 + 1,
        Children = {
          create2("UICorner", { CornerRadius = UDim.new(1, 0) }),
          create2("UIGradient", {
            Color = ColorSequence.new({
              ColorSequenceKeypoint.new(0, Color3.fromRGB(220, 170, 255)),
              ColorSequenceKeypoint.new(1, Color3.fromRGB(110, 55, 210)),
            }),
            Rotation = 90,
          }),
        },
      }, v257)

      create2("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 14, 0, 6),
        Size = UDim2.new(1, -70, 0, 14),
        Font = Enum.Font.GothamBold,
        Text = text5,
        TextColor3 = Color3.fromRGB(215, 185, 255),
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = v249 + 1,
      }, v257)

      local v258 = create2("TextLabel", {
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, -10, 0, 6),
        Size = UDim2.new(0, 44, 0, 14),
        Font = Enum.Font.GothamBold,
        Text = f14(v253),
        TextColor3 = Color3.fromRGB(65, 220, 110),
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Right,
        ZIndex = v249 + 1,
      }, v257)

      local v259 = create2("Frame", {
        BackgroundColor3 = Color3.fromRGB(10, 10, 16),
        BackgroundTransparency = 0.1,
        Position = UDim2.new(0, 12, 0, touchEnabled2 and 30 or 28),
        Size = UDim2.new(1, -24, 0, touchEnabled2 and 14 or 10),
        Active = true,
        ZIndex = v249 + 2,
        Children = {
          create2("UICorner", { CornerRadius = UDim.new(1, 0) }),
          create2("UIStroke", {
            Color = Color3.fromRGB(140, 90, 220),
            Transparency = 0.72,
            Thickness = 1,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
          }),
        },
      }, v257)

      local v260 = create2("Frame", {
        BackgroundColor3 = Color3.fromRGB(160, 100, 255),
        BackgroundTransparency = 0,
        Size = UDim2.new((v253 - p147) / (p148 - p147), 0, 1, 0),
        ZIndex = v249 + 3,
        Children = {
          create2("UICorner", { CornerRadius = UDim.new(1, 0) }),
          create2("UIGradient", {
            Color = ColorSequence.new({
              ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 145, 65)),
              ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 255, 175)),
            }),
          }),
        },
      }, v259)

      local v261 = create2("Frame", {
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new((v253 - p147) / (p148 - p147), 0, 0.5, 0),
        Size = UDim2.new(0, v254, 0, v254),
        Active = true,
        ZIndex = v249 + 4,
        Children = {
          create2("UICorner", { CornerRadius = UDim.new(1, 0) }),
          create2("UIStroke", {
            Color = Color3.fromRGB(65, 220, 110),
            Transparency = 0.3,
            Thickness = 1.5,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
          }),
        },
      }, v259)

      create2("TextButton", {
        Name = "TouchHitbox",
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, math.max(v254 + 14, 28), 0, math.max(v254 + 14, 28)),
        Text = "",
        ZIndex = v249 + 5,
      }, v261)

      local function f15(p156, p157)
        if not p151 then
          return
        end

        if v252 then
          p151(p156, p157)
        elseif p157 then
          p151(p156, true)
        end
      end

      local v262 = v253
      local v263 = false
      local f16

      local function f17(p158)
        f16(p147
          + (p148 - p147)
            * math.clamp((p158 - v259.AbsolutePosition.X) / v259.AbsoluteSize.X, 0, 1), false)
      end

      function f16(p159, p160)
        local v264 = p160 ~= false
        local v265 = f13(math.clamp(p159, p147, p148))
        v262 = v265
        local v266 = (v265 - p147) / (p148 - p147)
        local udim6 = UDim2.new(v266, 0, 1, 0)
        local udim7 = UDim2.new(v266, 0, 0.5, 0)

        if v264 then
          v4:Tween(v260, { Size = udim6 }, 0.12, Enum.EasingStyle.Quint)
          v4:Tween(v261, { Position = udim7 }, 0.12, Enum.EasingStyle.Quint)
        else
          v260.Size = udim6
          v261.Position = udim7
        end

        v258.Text = f14(v265)

        if v264 then
          save:Save(p146, v265)
        end

        f15(v265, v264)
      end

      local v267 = nil

      local function f18(p161)
        if not v263 then
          return
        elseif p161 ~= v267 then
          return
        else
          v263 = false
          v267 = nil
          v198 = false

          if v256 then
            v256.ScrollingEnabled = true
          end

          v4:Tween(v261, { Size = UDim2.new(0, v254, 0, v254) }, 0.15, Enum.EasingStyle.Quint)
          save:Save(p146, v262)
          f15(v262, true)
          return
        end
      end

      local userInputType

      local function f19(p162)
        if v267 ~= nil then
          return
        end

        if p162.UserInputType == Enum.UserInputType.Touch
          or p162.UserInputType == Enum.UserInputType.MouseButton1 then
          v263 = true
          v267 = p162
          userInputType = p162.UserInputType
          v198 = true

          if v256 then
            v256.ScrollingEnabled = false
          end

          f17(p162.Position.X)
          v4:Tween(v261, { Size = UDim2.new(0, v255, 0, v255) }, 0.12, Enum.EasingStyle.Back)
        end
      end

      v259.InputBegan:Connect(f19)
      v261.InputBegan:Connect(f19)
      local touchHitbox = v261:FindFirstChild("TouchHitbox")

      if touchHitbox then
        touchHitbox.InputBegan:Connect(f19)
      end

      v257.InputBegan:Connect(function(input5)
        if input5.UserInputType == Enum.UserInputType.Touch
          or input5.UserInputType == Enum.UserInputType.MouseButton1 then
          if input5.Position.Y - v257.AbsolutePosition.Y >= (touchEnabled2 and 26 or 24) then
            f19(input5)
          end
        end
      end)

      userInputService.InputChanged:Connect(function(input6)
        if not v263 or not v267 then
          return
        end

        if input6 == v267
          or v267.UserInputType == Enum.UserInputType.MouseButton1
            and input6.UserInputType == Enum.UserInputType.MouseMovement then
          f17(input6.Position.X)
        end
      end)

      userInputService.InputEnded:Connect(function(input7)
        if input7 == v267 or input7.UserInputType == Enum.UserInputType.MouseButton1
          or input7.UserInputType == Enum.UserInputType.Touch then
          f18(input7)
        end
      end)

      f16(v253, true)
      return function() return v262 end
    end
  end

  do
    function v126.MakeKeybindRow(p163, text6, p164, p165)
      local v269 = create2("Frame", {
        BackgroundColor3 = Color3.fromRGB(18, 12, 30),
        BackgroundTransparency = 0.2,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 34),
        ZIndex = 23,
        Children = { create2("UICorner", { CornerRadius = UDim.new(0, 8) }) },
      }, p163)

      create2("UIStroke", {
        Color = Color3.fromRGB(140, 90, 220),
        Transparency = 0.7,
        Thickness = 1,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
      }, v269)

      create2("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 14, 0, 0),
        Size = UDim2.new(1, -90, 1, 0),
        Font = Enum.Font.GothamBold,
        Text = text6,
        TextColor3 = Color3.fromRGB(215, 185, 255),
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 24,
      }, v269)

      v268 = create2("TextLabel", {
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -10, 0.5, 0),
        Size = UDim2.new(0, 72, 0, 14),
        Font = Enum.Font.GothamBold,
        Text = rightControl.Name,
        TextColor3 = Color3.fromRGB(65, 220, 110),
        TextSize = 10,
        TextTruncate = Enum.TextTruncate.AtEnd,
        TextXAlignment = Enum.TextXAlignment.Right,
        ZIndex = 24,
      }, v269)

      create2("TextButton", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Text = "",
        ZIndex = 25,
      }, v269).MouseButton1Click:Connect(function()
        v191 = true
        v268.Text = "..."
      end)
    end

    isAutoSave2 = v126.MakeMiniToggle(v225, "Auto Save changes", "_opt_AutoSave", true)
    local v270 = v126.MakeMiniToggle(v225, "Auto Translate UI", "_opt_AutoTranslate", false)

    v126.MakeMiniSlider(v225, "UI Scale", "_opt_UIScale", v164, 1.8, v165, 0.05, function(p166, p167)
      if p167 then
        v126.ApplyUIScale(p166)
      else
        v126.SetUIScalePreview(p166)
      end
    end, nil, true)

    v126.MakeKeybindRow(v225, "UI Keybind", "_opt_UIKeybind", "RightControl")

    local v271 = {
      "English", "Filipino", "Hindi", "Turkish", "Indonesian", "Spanish", "French", "German",
      "Japanese", "Korean", "Vietnamese", "Thai", "Russian", "Portuguese", "Chinese Simplified",
      "Chinese Traditional", "Arabic", "Italian", "Polish", "Dutch", "Ukrainian", "Malay",
      "Bengali", "Urdu", "Persian", "Romanian", "Czech", "Greek", "Swedish", "Hungarian",
      "Danish", "Finnish", "Norwegian", "Hebrew", "Slovak", "Bulgarian", "Croatian", "Serbian",
      "Lithuanian", "Latvian", "Slovenian",
    }

    local text7 = ""
    local v272 = false

    local v273 = create2("Frame", {
      BackgroundColor3 = Color3.fromRGB(14, 10, 24),
      BackgroundTransparency = 0.2,
      BorderSizePixel = 0,
      Size = UDim2.new(1, 0, 0, 34),
      ZIndex = 23,
      Children = {
        create2("UICorner", { CornerRadius = UDim.new(0, 7) }),
        create2("UIStroke", {
          Color = Color3.fromRGB(140, 90, 220),
          Transparency = 0.7,
          Thickness = 1,
          ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        }),
        create2("TextLabel", {
          BackgroundTransparency = 1,
          Position = UDim2.new(0, 14, 0, 0),
          Size = UDim2.new(0.45, 0, 1, 0),
          Font = Enum.Font.GothamBold,
          Text = "Language",
          TextColor3 = Color3.fromRGB(155, 130, 195),
          TextSize = 11,
          TextXAlignment = Enum.TextXAlignment.Left,
          ZIndex = 24,
        }),
      },
    }, v225)

    local get8 = save:Get("_opt_Language", "English")

    local v274 = create2("TextLabel", {
      BackgroundTransparency = 1,
      AnchorPoint = Vector2.new(1, 0.5),
      Position = UDim2.new(1, -30, 0.5, 0),
      Size = UDim2.new(0, 130, 0, 20),
      Font = Enum.Font.GothamBold,
      Text = get8,
      TextColor3 = Color3.fromRGB(65, 220, 110),
      TextSize = 11,
      TextXAlignment = Enum.TextXAlignment.Right,
      ZIndex = 24,
    }, v273)

    create2("TextLabel", {
      BackgroundTransparency = 1,
      AnchorPoint = Vector2.new(1, 0.5),
      Position = UDim2.new(1, -10, 0.5, 0),
      Size = UDim2.new(0, 14, 0, 14),
      Font = Enum.Font.GothamBold,
      Text = "›",
      TextColor3 = Color3.fromRGB(65, 220, 110),
      TextSize = 14,
      ZIndex = 24,
    }, v273)

    local v275 = create2("Frame", {
      BackgroundTransparency = 1,
      BorderSizePixel = 0,
      AnchorPoint = Vector2.new(0.5, 0),
      Position = UDim2.new(0.5, 0, 0, 0),
      Size = UDim2.new(1, -20, 0, 0),
      ClipsDescendants = true,
      ZIndex = 24,
    }, v225)

    local v276 = create2("TextBox", {
      BackgroundColor3 = Color3.fromRGB(18, 13, 30),
      BackgroundTransparency = 0.1,
      BorderSizePixel = 0,
      Position = UDim2.new(0, 0, 0, 0),
      Size = UDim2.new(1, 0, 0, 30),
      Font = Enum.Font.GothamBold,
      PlaceholderText = "Search language...",
      Text = "",
      TextColor3 = Color3.fromRGB(230, 230, 230),
      PlaceholderColor3 = Color3.fromRGB(120, 110, 145),
      TextSize = 11,
      ClearTextOnFocus = false,
      Visible = false,
      ZIndex = 30,
      Children = {
        create2("UICorner", { CornerRadius = UDim.new(0, 7) }),
        create2("UIPadding", { PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10) }),
      },
    }, v275)

    local v277 = create2("ScrollingFrame", {
      BackgroundColor3 = Color3.fromRGB(14, 10, 20),
      BackgroundTransparency = 0.05,
      BorderSizePixel = 0,
      Position = UDim2.new(0, 0, 0, 36),
      Size = UDim2.new(1, 0, 0, 0),
      CanvasSize = UDim2.new(0, 0, 0, 0),
      ScrollBarThickness = 0,
      ScrollBarImageTransparency = 1,
      ScrollingDirection = Enum.ScrollingDirection.Y,
      AutomaticCanvasSize = Enum.AutomaticSize.None,
      ClipsDescendants = true,
      ZIndex = 24,
      Children = {
        create2("UICorner", { CornerRadius = UDim.new(0, 7) }),
        create2("UIStroke", {
          Color = Color3.fromRGB(140, 90, 220),
          Transparency = 0.55,
          Thickness = 1,
          ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        }),
      },
    }, v275)

    create2(
      "UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 3) }, v277
    )

    create2("UIPadding", {
      PaddingTop = UDim.new(0, 4),
      PaddingBottom = UDim.new(0, 4),
      PaddingLeft = UDim.new(0, 4),
      PaddingRight = UDim.new(0, 4),
    }, v277)

    function v126.GetFilteredLanguages()
      if text7 == "" then
        return table.clone(v271)
      else
        local v278 = string.lower(text7)
        local v279 = {}

        for index25, value37 in ipairs(v271) do
          if string.find(string.lower(value37), v278, 1, true) then
            table.insert(v279, value37)
          end
        end

        return v279
      end
    end

    function v126.CalcListHeight(p168)
      local v280 = math.min(p168, 4)

      if v280 == 0 then
        return 0
      end

      return 8 + v280 * 26 + (v280 - 1) * 3
    end

    function v126.SetCanvasHeight(p169)
      local v281 = 8 + p169 * 26 + math.max(p169 - 1, 0) * 3
      local v282 = v281 > UnscaledLayout(v277.AbsoluteSize.Y) + 1

      v277.CanvasSize = UDim2.new(0, 0, 0, v282 and v281 or 0)
      v277.ScrollingEnabled = v282
      v277.ElasticBehavior = Enum.ElasticBehavior.Never

      if not v282 then
        v277.CanvasPosition = Vector2.new(0, 0)
      end
    end

    function v126.BuildLangItems()
      for index26, value38 in ipairs(v277:GetChildren()) do
        if value38:IsA("TextButton") then
          value38:Destroy()
        end
      end

      local get9 = save:Get("_opt_Language", "English")
      local v283 = v126.GetFilteredLanguages()

      for index27, value39 in ipairs(v283) do
        local v284 = value39
        local v285 = v284 == get9

        local color10 = v285
        color10 = v285 and Color3.fromRGB(30, 18, 52)

        local color11 = color10
        color11 = color10 or Color3.fromRGB(18, 13, 30)

        local backgroundTransparency = v285 and 0.2 or 0.5
        local udim8 = UDim2.new(1, -2, 0, 26)
        local v286 = create2("UICorner", { CornerRadius = UDim.new(0, 5) })

        create2("TextButton", {
          BackgroundColor3 = color11,
          BackgroundTransparency = backgroundTransparency,
          BorderSizePixel = 0,
          Size = udim8,
          LayoutOrder = index27,
          Text = "",
          AutoButtonColor = false,
          ZIndex = 25,
          Children = {
            v286,
            create2("UIStroke", {
              Color = Color3.fromRGB(140, 90, 220),
              Transparency = v285 and 0.42 or 0.82,
              Thickness = 1,
              ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
            }),
            create2("Frame", {
              BackgroundColor3 = Color3.fromRGB(160, 100, 255),
              BackgroundTransparency = v285 and 0 or 1,
              BorderSizePixel = 0,
              Position = UDim2.new(0, 0, 0.5, -9),
              Size = UDim2.new(0, 3, 0, 18),
              ZIndex = 26,
              Children = { create2("UICorner", { CornerRadius = UDim.new(1, 0) }) },
            }),
            create2("TextLabel", {
              BackgroundTransparency = 1,
              Position = UDim2.new(0, 12, 0, 0),
              Size = UDim2.new(1, -24, 1, 0),
              Font = Enum.Font.GothamBold,
              Text = v284,
              TextColor3 = v285 and Color3.fromRGB(215, 185, 255)
                or Color3.fromRGB(175, 155, 210),
              TextSize = 11,
              TextXAlignment = Enum.TextXAlignment.Left,
              ZIndex = 26,
            }),
          },
        }, v277).MouseButton1Click:Connect(function()
          save:Save("_opt_Language", v284)
          v274.Text = v284
          v272 = false
          text7 = ""

          v276.Text = ""
          v276.Visible = false

          v126.BuildLangItems()
          v277.Size = UDim2.new(1, 0, 0, (v126.CalcListHeight(#v126.GetFilteredLanguages())))

          v4:Tween(
            v275, { Size = UDim2.new(1, -20, 0, 0) }, 0.22, Enum.EasingStyle.Quint,
            Enum.EasingDirection.In
          )

          v4:Tween(
            v277, { Size = UDim2.new(1, 0, 0, 0) }, 0.22, Enum.EasingStyle.Quint,
            Enum.EasingDirection.In
          )

          if v270() then
            local v287 = v114.Languages[v284]

            if v287 then
              task.spawn(ApplyTranslation, v287)
            end
          end
        end)
      end

      v126.SetCanvasHeight(#v283)
    end

    v276:GetPropertyChangedSignal("Text"):Connect(function()
      text7 = v276.Text
      v126.BuildLangItems()

      if v272 then
        local v288 = v126.CalcListHeight(#v126.GetFilteredLanguages())
        v277.Size = UDim2.new(1, 0, 0, v288)
        v275.Size = UDim2.new(1, -20, 0, 36 + v288)
      end
    end)

    v126.BuildLangItems()

    create2("TextButton", {
      BackgroundTransparency = 1,
      Size = UDim2.new(1, 0, 1, 0),
      Text = "",
      ZIndex = 25,
    }, v273).MouseButton1Click:Connect(function()
      v272 = not v272
      text7 = ""

      v276.Text = ""
      v276.Visible = v272

      v126.BuildLangItems()
      local v289 = v126.CalcListHeight(#v126.GetFilteredLanguages())
      local v290 = v272 and 36 + v289 or 0
      local out = v272 and Enum.EasingDirection.Out or Enum.EasingDirection.In

      v4:Tween(v275, { Size = UDim2.new(1, -20, 0, v290) }, 0.25, Enum.EasingStyle.Quint, out)
      v4:Tween(v277, { Size = UDim2.new(1, 0, 0, v289) }, 0.25, Enum.EasingStyle.Quint, out)
    end)

    local get10 = save:Get("_opt_AutoTranslate", false)
    local get11 = save:Get("_opt_Language", "English")

    task.spawn(function()
      while true do
        task.wait(0.45)
        local v291 = v270()
        local get12 = save:Get("_opt_Language", "English")

        if v291 ~= get10 or v291 and get12 ~= get11 then
          get10 = v291
          get11 = get12
          local v292 = v114.Languages[get12]

          if v291 and v292 and v292 ~= "en" then
            ApplyTranslation(v292)
          elseif not v291 then
            ApplyTranslation("en")
          end
        end
      end
    end)
  end

  do
    task.defer(function()
      if save:Get("_opt_AutoTranslate", false) then
        local v293 = v114.Languages[save:Get("_opt_Language", "English")]

        if v293 and v293 ~= "en" then
          ApplyTranslation(v293)
        end
      end
    end)

    create2("Frame", {
      BackgroundColor3 = Color3.fromRGB(100, 60, 180),
      BackgroundTransparency = 0.82,
      BorderSizePixel = 0,
      Size = UDim2.new(1, 0, 0, 1),
      ZIndex = 23,
      Children = {
        create2("UIGradient", {
          Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.15, 0),
            NumberSequenceKeypoint.new(0.85, 0), NumberSequenceKeypoint.new(1, 1),
          }),
        }),
      },
    }, v225)

    save.IsAutoSave = isAutoSave2

    local v294 = create2("TextButton", {
      BackgroundColor3 = Color3.fromRGB(22, 14, 38),
      BackgroundTransparency = 0,
      BorderSizePixel = 0,
      Size = UDim2.new(1, 0, 0, 36),
      Text = "",
      AutoButtonColor = false,
      ZIndex = 23,
      Children = {
        create2("UICorner", { CornerRadius = UDim.new(0, 8) }),
        create2("UIStroke", {
          Color = Color3.fromRGB(140, 90, 220),
          Transparency = 0.55,
          Thickness = 1,
          ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        }),
        create2("TextLabel", {
          BackgroundTransparency = 1,
          Position = UDim2.new(0, 12, 0, 0),
          Size = UDim2.new(1, -40, 1, 0),
          Font = Enum.Font.GothamBold,
          Text = "Open Save Manager",
          TextColor3 = Color3.fromRGB(210, 180, 255),
          TextSize = 11,
          TextXAlignment = Enum.TextXAlignment.Left,
          ZIndex = 24,
        }),
        create2("TextLabel", {
          BackgroundTransparency = 1,
          AnchorPoint = Vector2.new(1, 0.5),
          Position = UDim2.new(1, -10, 0.5, 0),
          Size = UDim2.new(0, 16, 0, 16),
          Font = Enum.Font.GothamBold,
          Text = "›",
          TextColor3 = Color3.fromRGB(65, 220, 110),
          TextSize = 14,
          ZIndex = 24,
        }),
      },
    }, v225)

    v294.MouseEnter:Connect(function()
      v4:Tween(
        v294, { BackgroundColor3 = Color3.fromRGB(30, 18, 52) }, 0.15, Enum.EasingStyle.Quint
      )
    end)

    v294.MouseLeave:Connect(function()
      v4:Tween(
        v294, { BackgroundColor3 = Color3.fromRGB(22, 14, 38) }, 0.2, Enum.EasingStyle.Quint
      )
    end)

    v294.MouseButton1Click:Connect(function()
      CircleClick(v294, getMouse.X, getMouse.Y)
      f11()
      v233()
    end)

    create2("TextLabel", {
      BackgroundTransparency = 1,
      Size = UDim2.new(1, 0, 0, 28),
      Font = Enum.Font.Gotham,
      Text = "Saves are stored per Roblox account",
      TextColor3 = Color3.fromRGB(130, 110, 170),
      TextSize = 9,
      TextWrapped = true,
      TextXAlignment = Enum.TextXAlignment.Center,
      ZIndex = 23,
    }, v225)

    get13 = save:Get("_saveSlots", {})
    v295 = {}
    v296 = false
    text8 = ""
  end

  do
    local v297 = create2("Frame", {
      BackgroundColor3 = Color3.fromRGB(18, 12, 30),
      BackgroundTransparency = 0.2,
      BorderSizePixel = 0,
      Size = UDim2.new(1, 0, 0, 52),
      ZIndex = 23,
      Children = {
        create2("UICorner", { CornerRadius = UDim.new(0, 8) }),
        create2("UIStroke", {
          Color = Color3.fromRGB(140, 90, 220),
          Transparency = 0.65,
          Thickness = 1,
          ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        }),
        create2("UIGradient", {
          Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(28, 18, 48)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(14, 10, 24)),
          }),
          Rotation = 135,
        }),
      },
    }, v231)

    create2("TextLabel", {
      BackgroundTransparency = 1,
      Position = UDim2.new(0, 10, 0, 7),
      Size = UDim2.new(1, -20, 0, 16),
      Font = Enum.Font.GothamBold,
      RichText = true,
      TextTruncate = Enum.TextTruncate.AtEnd,
      Text = string.format(
        "Account: <font color=\"#41DC6E\"><b>%s</b></font>", save:GetPlayerName()
      ),
      TextColor3 = Color3.fromRGB(225, 200, 255),
      TextSize = 10,
      TextXAlignment = Enum.TextXAlignment.Left,
      ZIndex = 24,
    }, v297)

    v298 = create2("TextLabel", {
      BackgroundTransparency = 1,
      Position = UDim2.new(0, 10, 0, 26),
      Size = UDim2.new(1, -20, 0, 16),
      Font = Enum.Font.Gotham,
      RichText = true,
      TextTruncate = Enum.TextTruncate.AtEnd,
      Text = string.format(
        "Profile: <font color=\"#41DC6E\"><b>%s</b></font>  •  ID: <font color=\"#34D399\">%s</font>",
        save.ActiveProfile or "[Auto]", save:GetGameId()
      ),
      TextColor3 = Color3.fromRGB(165, 140, 205),
      TextSize = 10,
      TextXAlignment = Enum.TextXAlignment.Left,
      ZIndex = 24,
    }, v297)

    local v299 = create2("Frame", {
      BackgroundTransparency = 1,
      BorderSizePixel = 0,
      Size = UDim2.new(1, 0, 0, 28),
      ZIndex = 23,
      Children = {
        create2("UIListLayout", {
          FillDirection = Enum.FillDirection.Horizontal,
          SortOrder = Enum.SortOrder.LayoutOrder,
          Padding = UDim.new(0, 4),
        }),
      },
    }, v231)

    local v300 = create2("TextButton", {
      BackgroundColor3 = Color3.fromRGB(70, 35, 150),
      BackgroundTransparency = 0.35,
      BorderSizePixel = 0,
      Size = UDim2.new(0.32, 0, 1, 0),
      Text = "Quick Save",
      TextColor3 = Color3.fromRGB(215, 185, 255),
      Font = Enum.Font.GothamBold,
      TextSize = 10,
      AutoButtonColor = false,
      LayoutOrder = 1,
      ZIndex = 24,
      Children = {
        create2("UICorner", { CornerRadius = UDim.new(0, 6) }),
        create2("UIStroke", {
          Color = Color3.fromRGB(150, 100, 235),
          Transparency = 0.6,
          Thickness = 1,
          ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        }),
      },
    }, v299)

    local v301 = create2("TextButton", {
      BackgroundColor3 = Color3.fromRGB(80, 50, 25),
      BackgroundTransparency = 0.4,
      BorderSizePixel = 0,
      Size = UDim2.new(0.32, 0, 1, 0),
      Text = "Reset All",
      TextColor3 = Color3.fromRGB(255, 190, 110),
      Font = Enum.Font.GothamBold,
      TextSize = 10,
      AutoButtonColor = false,
      LayoutOrder = 2,
      ZIndex = 24,
      Children = {
        create2("UICorner", { CornerRadius = UDim.new(0, 6) }),
        create2("UIStroke", {
          Color = Color3.fromRGB(255, 170, 80),
          Transparency = 0.65,
          Thickness = 1,
          ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        }),
      },
    }, v299)

    local v302 = create2("TextButton", {
      BackgroundColor3 = Color3.fromRGB(110, 18, 36),
      BackgroundTransparency = 0.4,
      BorderSizePixel = 0,
      Size = UDim2.new(0.33, 0, 1, 0),
      Text = "Clear All",
      TextColor3 = Color3.fromRGB(255, 110, 130),
      Font = Enum.Font.GothamBold,
      TextSize = 10,
      AutoButtonColor = false,
      LayoutOrder = 3,
      ZIndex = 24,
      Children = {
        create2("UICorner", { CornerRadius = UDim.new(0, 6) }),
        create2("UIStroke", {
          Color = Color3.fromRGB(255, 95, 120),
          Transparency = 0.65,
          Thickness = 1,
          ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        }),
      },
    }, v299)

    v300.MouseEnter:Connect(function()
      v4:Tween(v300, { BackgroundTransparency = 0.15 }, 0.12)
    end)

    v300.MouseLeave:Connect(function()
      v4:Tween(v300, { BackgroundTransparency = 0.35 }, 0.18)
    end)

    v301.MouseEnter:Connect(function() v4:Tween(v301, { BackgroundTransparency = 0.2 }, 0.12) end)
    v301.MouseLeave:Connect(function() v4:Tween(v301, { BackgroundTransparency = 0.4 }, 0.18) end)

    v302.MouseEnter:Connect(function() v4:Tween(v302, { BackgroundTransparency = 0.2 }, 0.12) end)
    v302.MouseLeave:Connect(function() v4:Tween(v302, { BackgroundTransparency = 0.4 }, 0.18) end)

    v300.MouseButton1Click:Connect(function()
      CircleClick(v300, getMouse.X, getMouse.Y)
      local getSnapshot2 = save:GetSnapshot()
      local get14 = save:Get("_saveSlots", {})
      local activeProfile = save.ActiveProfile or "[Auto]"
      local v303 = false

      for index28, value40 in ipairs(get14) do
        if value40.name == activeProfile then
          value40.data = getSnapshot2
          value40.updated = os.date("%Y-%m-%d %H:%M")

          v303 = true
          break
        end
      end

      if not v303 then
        table.insert(get14, {
          name = activeProfile,
          data = getSnapshot2,
          created = os.date("%Y-%m-%d %H:%M"),
          updated = os.date("%Y-%m-%d %H:%M"),
        })
      end

      save:Save("_saveSlots", get14)

      v3.Notification:Notify({
        Title = "Save Manager",
        Description = "Saved state to \"" .. activeProfile .. "\".",
      }, { Time = 2 })

      RefreshSlots()
    end)

    v301.MouseButton1Click:Connect(function()
      CircleClick(v301, getMouse.X, getMouse.Y)
      save:ResetToDefaults(true)

      v3.Notification:Notify({
        Title = "Save Manager",
        Description = "All controls have been reset to default values.",
      }, { Time = 3 })
    end)

    v302.MouseButton1Click:Connect(function()
      CircleClick(v302, getMouse.X, getMouse.Y)

      save:ClearAll()
      save:Save("_saveSlots", {})
      save:Save("_autoLoadTarget", nil)
      save.ActiveProfile = "[Auto]"

      if v298 then
        v298.Text = "Active Profile: <font color=\"#41DC6E\"><b>[Auto]</b></font>"
      end

      RefreshSlots()

      v3.Notification:Notify({
        Title = "Save Manager",
        Description = "All saved profiles and data have been cleared.",
      }, { Time = 3 })
    end)
  end

  do
    v304 = create2("Frame", {
      BackgroundTransparency = 1,
      Size = UDim2.new(1, 0, 0, 0),
      AutomaticSize = Enum.AutomaticSize.Y,
      ZIndex = 22,
      Children = {
        create2("UIListLayout", {
          HorizontalAlignment = Enum.HorizontalAlignment.Center,
          SortOrder = Enum.SortOrder.LayoutOrder,
          Padding = UDim.new(0, 4),
        }),
        create2("UIPadding", { PaddingTop = UDim.new(0, 2), PaddingBottom = UDim.new(0, 4) }),
      },
    }, v231)

    v305 = create2("Frame", {
      BackgroundTransparency = 1,
      Size = UDim2.new(1, 0, 0, 0),
      AutomaticSize = Enum.AutomaticSize.Y,
      Visible = false,
      ZIndex = 22,
      Children = {
        create2("UIListLayout", {
          HorizontalAlignment = Enum.HorizontalAlignment.Center,
          SortOrder = Enum.SortOrder.LayoutOrder,
          Padding = UDim.new(0, 4),
        }),
      },
    }, v231)

    v306 = create2("TextButton", {
      BackgroundColor3 = Color3.fromRGB(20, 14, 34),
      BackgroundTransparency = 0,
      BorderSizePixel = 0,
      Size = UDim2.new(1, 0, 0, 26),
      Text = "",
      AutoButtonColor = false,
      LayoutOrder = 1,
      ZIndex = 23,
      Children = {
        create2("UICorner", { CornerRadius = UDim.new(0, 6) }),
        create2("UIStroke", {
          Color = Color3.fromRGB(140, 90, 220),
          Transparency = 0.6,
          Thickness = 1,
          ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        }),
        create2("TextLabel", {
          BackgroundTransparency = 1,
          Position = UDim2.new(0, 8, 0, 0),
          Size = UDim2.new(0, 16, 1, 0),
          Font = Enum.Font.GothamBold,
          Text = "‹",
          TextColor3 = Color3.fromRGB(65, 220, 110),
          TextSize = 16,
          TextXAlignment = Enum.TextXAlignment.Center,
          ZIndex = 24,
        }),
        create2("TextLabel", {
          Name = "BackLabel",
          BackgroundTransparency = 1,
          Position = UDim2.new(0, 28, 0, 0),
          Size = UDim2.new(1, -34, 1, 0),
          Font = Enum.Font.GothamBold,
          Text = "Back to Profiles",
          TextColor3 = Color3.fromRGB(210, 180, 255),
          TextSize = 11,
          TextXAlignment = Enum.TextXAlignment.Left,
          ZIndex = 24,
        }),
      },
    }, v305)

    local v307 = create2("Frame", {
      BackgroundTransparency = 1,
      Size = UDim2.new(1, 0, 0, 0),
      AutomaticSize = Enum.AutomaticSize.Y,
      LayoutOrder = 2,
      ZIndex = 23,
      Children = {
        create2("UIListLayout", {
          HorizontalAlignment = Enum.HorizontalAlignment.Center,
          SortOrder = Enum.SortOrder.LayoutOrder,
          Padding = UDim.new(0, 4),
        }),
        create2("UIPadding", { PaddingTop = UDim.new(0, 4), PaddingBottom = UDim.new(0, 4) }),
      },
    }, v305)

    function v126.SectionLabel(text9, layoutOrder)
      return create2("TextLabel", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 13),
        LayoutOrder = layoutOrder,
        Font = Enum.Font.GothamBold,
        Text = text9,
        TextColor3 = Color3.fromRGB(140, 105, 200),
        TextSize = 9,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 24,
      }, v307)
    end

    v126.SectionLabel("PROFILE NAME", 1)

    local v308 = create2("Frame", {
      BackgroundColor3 = Color3.fromRGB(16, 11, 26),
      BorderSizePixel = 0,
      Size = UDim2.new(1, 0, 0, 28),
      LayoutOrder = 2,
      ZIndex = 23,
      Children = {
        create2("UICorner", { CornerRadius = UDim.new(0, 6) }),
        create2("UIStroke", {
          Color = Color3.fromRGB(130, 80, 210),
          Transparency = 0.68,
          Thickness = 1,
          ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        }),
      },
    }, v307)

    v309 = create2("TextBox", {
      BackgroundTransparency = 1,
      Position = UDim2.new(0, 10, 0, 0),
      Size = UDim2.new(1, -70, 1, 0),
      Font = Enum.Font.GothamBold,
      Text = "",
      TextColor3 = Color3.fromRGB(220, 200, 255),
      PlaceholderText = "Enter profile name...",
      PlaceholderColor3 = Color3.fromRGB(110, 85, 150),
      TextSize = 11,
      TextXAlignment = Enum.TextXAlignment.Left,
      ClearTextOnFocus = false,
      ZIndex = 24,
    }, v308)

    v310 = create2("TextButton", {
      AnchorPoint = Vector2.new(1, 0.5),
      BackgroundColor3 = Color3.fromRGB(80, 45, 160),
      BackgroundTransparency = 0.3,
      BorderSizePixel = 0,
      Position = UDim2.new(1, -4, 0.5, 0),
      Size = UDim2.new(0, 54, 0, 20),
      Text = "Rename",
      TextColor3 = Color3.fromRGB(220, 190, 255),
      Font = Enum.Font.GothamBold,
      TextSize = 10,
      AutoButtonColor = false,
      Visible = false,
      ZIndex = 25,
      Children = {
        create2("UICorner", { CornerRadius = UDim.new(0, 5) }),
        create2("UIStroke", {
          Color = Color3.fromRGB(150, 100, 230),
          Transparency = 0.5,
          Thickness = 1,
          ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        }),
      },
    }, v308)

    v126.SectionLabel("AUTO LOAD SETTING", 3)

    local v311 = create2("Frame", {
      BackgroundColor3 = Color3.fromRGB(16, 11, 26),
      BorderSizePixel = 0,
      Size = UDim2.new(1, 0, 0, 30),
      LayoutOrder = 4,
      ZIndex = 23,
      Children = {
        create2("UICorner", { CornerRadius = UDim.new(0, 6) }),
        create2("UIStroke", {
          Color = Color3.fromRGB(130, 80, 210),
          Transparency = 0.68,
          Thickness = 1,
          ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        }),
        create2("TextLabel", {
          BackgroundTransparency = 1,
          Position = UDim2.new(0, 10, 0, 0),
          Size = UDim2.new(1, -60, 1, 0),
          Font = Enum.Font.GothamBold,
          Text = "Auto Load this Profile on Game Start",
          TextColor3 = Color3.fromRGB(200, 175, 240),
          TextSize = 10,
          TextXAlignment = Enum.TextXAlignment.Left,
          ZIndex = 24,
        }),
      },
    }, v307)

    v312 = create2("Frame", {
      AnchorPoint = Vector2.new(1, 0.5),
      BackgroundColor3 = Color3.fromRGB(14, 9, 26),
      BorderSizePixel = 0,
      Position = UDim2.new(1, -8, 0.5, 0),
      Size = UDim2.new(0, 36, 0, 18),
      ZIndex = 24,
      Children = {
        create2("UICorner", { CornerRadius = UDim.new(1, 0) }),
        create2("UIStroke", {
          Color = Color3.fromRGB(130, 80, 210),
          Transparency = 0.7,
          Thickness = 1,
          ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        }),
      },
    }, v311)

    v313 = create2("Frame", {
      AnchorPoint = Vector2.new(0, 0.5),
      Position = UDim2.new(0, 3, 0.5, 0),
      Size = UDim2.new(0, 12, 0, 12),
      BorderSizePixel = 0,
      ZIndex = 25,
      Children = {
        create2("UICorner", { CornerRadius = UDim.new(1, 0) }),
        create2("UIGradient", {
          Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(110, 90, 140)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(55, 45, 85)),
          }),
          Rotation = 135,
        }),
      },
    }, v312)

    v314 = create2("TextButton", {
      BackgroundTransparency = 1,
      Size = UDim2.new(1, 0, 1, 0),
      Text = "",
      ZIndex = 26,
    }, v311)

    v126.SectionLabel("DATA INSPECTOR & PREVIEW", 5)

    v315 = create2("TextBox", {
      BackgroundColor3 = Color3.fromRGB(10, 8, 16),
      BorderSizePixel = 0,
      Size = UDim2.new(1, 0, 0, 22),
      LayoutOrder = 6,
      Font = Enum.Font.Gotham,
      PlaceholderText = "Search saved keys...",
      PlaceholderColor3 = Color3.fromRGB(110, 85, 150),
      Text = "",
      TextColor3 = Color3.fromRGB(215, 190, 255),
      TextSize = 10,
      TextXAlignment = Enum.TextXAlignment.Left,
      ClearTextOnFocus = false,
      ZIndex = 24,
      Children = {
        create2("UICorner", { CornerRadius = UDim.new(0, 5) }),
        create2("UIStroke", {
          Color = Color3.fromRGB(120, 75, 200),
          Transparency = 0.75,
          Thickness = 1,
          ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        }),
        create2("UIPadding", { PaddingLeft = UDim.new(0, 8) }),
      },
    }, v307)

    local v316 = create2("ScrollingFrame", {
      BackgroundColor3 = Color3.fromRGB(9, 6, 16),
      BorderSizePixel = 0,
      Size = UDim2.new(1, 0, 0, 74),
      LayoutOrder = 7,
      ScrollBarThickness = 0,
      ScrollBarImageTransparency = 1,
      AutomaticCanvasSize = Enum.AutomaticSize.Y,
      ElasticBehavior = Enum.ElasticBehavior.WhenScrollable,
      CanvasSize = UDim2.new(0, 0, 0, 0),
      ZIndex = 23,
      Children = {
        create2("UICorner", { CornerRadius = UDim.new(0, 6) }),
        create2("UIStroke", {
          Color = Color3.fromRGB(120, 75, 200),
          Transparency = 0.72,
          Thickness = 1,
          ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        }),
        create2("UIListLayout", {
          SortOrder = Enum.SortOrder.LayoutOrder,
          Padding = UDim.new(0, 2),
        }),
        create2("UIPadding", {
          PaddingLeft = UDim.new(0, 8),
          PaddingRight = UDim.new(0, 6),
          PaddingTop = UDim.new(0, 5),
          PaddingBottom = UDim.new(0, 5),
        }),
      },
    }, v307)

    v126.SectionLabel("ACTIONS", 8)

    local v317 = create2("Frame", {
      BackgroundTransparency = 1,
      Size = UDim2.new(1, 0, 0, 26),
      LayoutOrder = 9,
      ZIndex = 23,
      Children = {
        create2("UIListLayout", {
          FillDirection = Enum.FillDirection.Horizontal,
          HorizontalAlignment = Enum.HorizontalAlignment.Center,
          VerticalAlignment = Enum.VerticalAlignment.Center,
          SortOrder = Enum.SortOrder.LayoutOrder,
          Padding = UDim.new(0, 4),
        }),
      },
    }, v307)

    v318 = create2("TextButton", {
      BackgroundColor3 = Color3.fromRGB(80, 40, 170),
      BackgroundTransparency = 0.25,
      BorderSizePixel = 0,
      Size = UDim2.new(0.48, 0, 1, 0),
      LayoutOrder = 1,
      Text = "Load & Apply",
      TextColor3 = Color3.fromRGB(230, 205, 255),
      Font = Enum.Font.GothamBold,
      TextSize = 10,
      AutoButtonColor = false,
      ZIndex = 24,
      Children = {
        create2("UICorner", { CornerRadius = UDim.new(0, 6) }),
        create2("UIStroke", {
          Color = Color3.fromRGB(190, 150, 255),
          Transparency = 0.5,
          Thickness = 1,
          ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        }),
      },
    }, v317)

    v319 = create2("TextButton", {
      BackgroundColor3 = Color3.fromRGB(40, 80, 140),
      BackgroundTransparency = 0.25,
      BorderSizePixel = 0,
      Size = UDim2.new(0.48, 0, 1, 0),
      LayoutOrder = 2,
      Text = "Overwrite Current",
      TextColor3 = Color3.fromRGB(180, 220, 255),
      Font = Enum.Font.GothamBold,
      TextSize = 10,
      AutoButtonColor = false,
      ZIndex = 24,
      Children = {
        create2("UICorner", { CornerRadius = UDim.new(0, 6) }),
        create2("UIStroke", {
          Color = Color3.fromRGB(140, 190, 255),
          Transparency = 0.5,
          Thickness = 1,
          ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        }),
      },
    }, v317)

    local v320 = create2("Frame", {
      BackgroundTransparency = 1,
      Size = UDim2.new(1, 0, 0, 26),
      LayoutOrder = 10,
      ZIndex = 23,
      Children = {
        create2("UIListLayout", {
          FillDirection = Enum.FillDirection.Horizontal,
          HorizontalAlignment = Enum.HorizontalAlignment.Center,
          VerticalAlignment = Enum.VerticalAlignment.Center,
          SortOrder = Enum.SortOrder.LayoutOrder,
          Padding = UDim.new(0, 4),
        }),
      },
    }, v307)

    v321 = create2("TextButton", {
      BackgroundColor3 = Color3.fromRGB(24, 18, 40),
      BackgroundTransparency = 0.2,
      BorderSizePixel = 0,
      Size = UDim2.new(0.32, 0, 1, 0),
      LayoutOrder = 1,
      Text = "Clone",
      TextColor3 = Color3.fromRGB(205, 180, 245),
      Font = Enum.Font.GothamBold,
      TextSize = 10,
      AutoButtonColor = false,
      ZIndex = 24,
      Children = {
        create2("UICorner", { CornerRadius = UDim.new(0, 6) }),
        create2("UIStroke", {
          Color = Color3.fromRGB(130, 90, 210),
          Transparency = 0.65,
          Thickness = 1,
          ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        }),
      },
    }, v320)

    v322 = create2("TextButton", {
      BackgroundColor3 = Color3.fromRGB(20, 75, 35),
      BackgroundTransparency = 0.25,
      BorderSizePixel = 0,
      Size = UDim2.new(0.32, 0, 1, 0),
      LayoutOrder = 2,
      Text = "Export Code",
      TextColor3 = Color3.fromRGB(120, 240, 160),
      Font = Enum.Font.GothamBold,
      TextSize = 10,
      AutoButtonColor = false,
      ZIndex = 24,
      Children = {
        create2("UICorner", { CornerRadius = UDim.new(0, 6) }),
        create2("UIStroke", {
          Color = Color3.fromRGB(90, 220, 130),
          Transparency = 0.6,
          Thickness = 1,
          ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        }),
      },
    }, v320)

    v323 = create2("TextButton", {
      BackgroundColor3 = Color3.fromRGB(110, 18, 36),
      BackgroundTransparency = 0.25,
      BorderSizePixel = 0,
      Size = UDim2.new(0.32, 0, 1, 0),
      LayoutOrder = 3,
      Text = "Delete",
      TextColor3 = Color3.fromRGB(255, 110, 130),
      Font = Enum.Font.GothamBold,
      TextSize = 10,
      AutoButtonColor = false,
      ZIndex = 24,
      Children = {
        create2("UICorner", { CornerRadius = UDim.new(0, 6) }),
        create2("UIStroke", {
          Color = Color3.fromRGB(255, 95, 120),
          Transparency = 0.6,
          Thickness = 1,
          ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        }),
      },
    }, v320)

    v324 = create2("TextLabel", {
      BackgroundTransparency = 1,
      Size = UDim2.new(1, 0, 0, 16),
      LayoutOrder = 9,
      Font = Enum.Font.GothamBold,
      Text = "PROFILES & SLOTS",
      TextColor3 = Color3.fromRGB(150, 115, 215),
      TextSize = 10,
      TextXAlignment = Enum.TextXAlignment.Left,
      ZIndex = 23,
    }, v304)

    v325 = create2("Frame", {
      BackgroundTransparency = 1,
      Size = UDim2.new(1, 0, 0, 0),
      AutomaticSize = Enum.AutomaticSize.Y,
      LayoutOrder = 10,
      ZIndex = 23,
      Children = {
        create2("UIListLayout", {
          HorizontalAlignment = Enum.HorizontalAlignment.Center,
          SortOrder = Enum.SortOrder.LayoutOrder,
          Padding = UDim.new(0, 4),
        }),
      },
    }, v304)

    local v326 = create2("Frame", {
      BackgroundColor3 = Color3.fromRGB(14, 10, 24),
      BackgroundTransparency = 0.2,
      BorderSizePixel = 0,
      Size = UDim2.new(1, 0, 0, 34),
      LayoutOrder = 11,
      ZIndex = 23,
      Children = {
        create2("UICorner", { CornerRadius = UDim.new(0, 7) }),
        create2("UIStroke", {
          Color = Color3.fromRGB(140, 90, 220),
          Transparency = 0.7,
          Thickness = 1,
          ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        }),
        create2("UIGradient", {
          Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 18, 55)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(14, 10, 24)),
          }),
          Rotation = 135,
        }),
      },
    }, v304)

    local v327 = create2("TextBox", {
      BackgroundColor3 = Color3.fromRGB(8, 6, 14),
      BackgroundTransparency = 0,
      BorderSizePixel = 0,
      ClearTextOnFocus = false,
      Position = UDim2.new(0, 8, 0.5, -10),
      Size = UDim2.new(1, -82, 0, 20),
      PlaceholderText = "New profile name...",
      PlaceholderColor3 = Color3.fromRGB(110, 85, 150),
      Text = "",
      TextColor3 = Color3.fromRGB(220, 200, 255),
      Font = Enum.Font.Gotham,
      TextSize = 11,
      TextXAlignment = Enum.TextXAlignment.Left,
      ZIndex = 24,
      Children = {
        create2("UICorner", { CornerRadius = UDim.new(0, 5) }),
        create2("UIStroke", {
          Color = Color3.fromRGB(130, 80, 210),
          Transparency = 0.72,
          Thickness = 1,
          ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        }),
        create2("UIPadding", { PaddingLeft = UDim.new(0, 6) }),
      },
    }, v326)

    local v328 = create2("TextButton", {
      AnchorPoint = Vector2.new(1, 0.5),
      BackgroundColor3 = Color3.fromRGB(80, 40, 160),
      BackgroundTransparency = 0.25,
      BorderSizePixel = 0,
      Position = UDim2.new(1, -6, 0.5, 0),
      Size = UDim2.new(0, 62, 0, 22),
      Text = "+ Create",
      TextColor3 = Color3.fromRGB(220, 195, 255),
      Font = Enum.Font.GothamBold,
      TextSize = 10,
      AutoButtonColor = false,
      ZIndex = 24,
      Children = {
        create2("UICorner", { CornerRadius = UDim.new(0, 6) }),
        create2("UIGradient", {
          Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(140, 80, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(70, 35, 150)),
          }),
          Rotation = 90,
        }),
      },
    }, v326)

    local v329 = create2("Frame", {
      BackgroundColor3 = Color3.fromRGB(12, 9, 22),
      BackgroundTransparency = 0.2,
      BorderSizePixel = 0,
      Size = UDim2.new(1, 0, 0, 34),
      LayoutOrder = 12,
      ZIndex = 23,
      Children = {
        create2("UICorner", { CornerRadius = UDim.new(0, 7) }),
        create2("UIStroke", {
          Color = Color3.fromRGB(80, 180, 120),
          Transparency = 0.7,
          Thickness = 1,
          ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        }),
        create2("UIGradient", {
          Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 38, 28)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(12, 9, 22)),
          }),
          Rotation = 135,
        }),
      },
    }, v304)

    local v330 = create2("TextBox", {
      BackgroundColor3 = Color3.fromRGB(8, 6, 14),
      BackgroundTransparency = 0,
      BorderSizePixel = 0,
      ClearTextOnFocus = false,
      Position = UDim2.new(0, 8, 0.5, -10),
      Size = UDim2.new(1, -82, 0, 20),
      PlaceholderText = "Paste share code...",
      PlaceholderColor3 = Color3.fromRGB(80, 130, 100),
      Text = "",
      TextColor3 = Color3.fromRGB(160, 240, 200),
      Font = Enum.Font.Gotham,
      TextSize = 11,
      TextXAlignment = Enum.TextXAlignment.Left,
      ZIndex = 24,
      Children = {
        create2("UICorner", { CornerRadius = UDim.new(0, 5) }),
        create2("UIStroke", {
          Color = Color3.fromRGB(80, 180, 120),
          Transparency = 0.72,
          Thickness = 1,
          ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        }),
        create2("UIPadding", { PaddingLeft = UDim.new(0, 6) }),
      },
    }, v329)

    local v331 = create2("TextButton", {
      AnchorPoint = Vector2.new(1, 0.5),
      BackgroundColor3 = Color3.fromRGB(30, 120, 70),
      BackgroundTransparency = 0.3,
      BorderSizePixel = 0,
      Position = UDim2.new(1, -6, 0.5, 0),
      Size = UDim2.new(0, 62, 0, 22),
      Text = "Import",
      TextColor3 = Color3.fromRGB(160, 250, 195),
      Font = Enum.Font.GothamBold,
      TextSize = 10,
      AutoButtonColor = false,
      ZIndex = 24,
      Children = {
        create2("UICorner", { CornerRadius = UDim.new(0, 6) }),
        create2("UIGradient", {
          Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 200, 120)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 100, 60)),
          }),
          Rotation = 90,
        }),
      },
    }, v329)

    function v126.ShowSettingsPage()
      v305.Visible = false
      v304.Visible = true
      v231.CanvasPosition = Vector2.new(0, 0)
    end

    function v126.ShowSlotPage(p170)
      v304.Visible = false
      v305.Visible = true
      v231.CanvasPosition = Vector2.new(0, 0)
      local v332 = save:Get("_saveSlots", {})[p170]
      local backLabel = v306:FindFirstChild("BackLabel")

      if backLabel and v332 then
        backLabel.Text = v332.name or "Slot " .. p170
      end
    end

    function v126.EncodeShareCode(p171)
      local v333, v334 = pcall(function() return JsonEncode(p171) end)

      if v333 and v334 then
        return "QH-SAVE:" .. v334
      end

      return nil
    end

    function v126.DecodeShareCode(p172)
      local gsub5 = p172

      if not gsub5 then
        return nil
      else
        gsub5 = gsub5:gsub("^%s+", ""):gsub("%s+$", "")

        if gsub5:match("^QH%-SAVE:") then
          gsub5 = gsub5:sub(9)
        end

        local v335, v336 = pcall(function() return JsonDecode(gsub5) end)

        if v335 and type(v336) == "table" then
          return v336
        end

        return nil
      end
    end

    function v126.UpdatePreview(p173, p174)
      for index29, value41 in ipairs(v316:GetChildren()) do
        if value41:IsA("TextLabel") or value41:IsA("Frame") then
          value41:Destroy()
        end
      end

      if not p173 or not p173.data then
        create2("TextLabel", {
          BackgroundTransparency = 1,
          Size = UDim2.new(1, 0, 0, 16),
          Font = Enum.Font.Gotham,
          Text = "(empty slot)",
          TextColor3 = Color3.fromRGB(110, 85, 140),
          TextSize = 10,
          TextXAlignment = Enum.TextXAlignment.Left,
          ZIndex = 24,
        }, v316)

        return
      else
        local v337 = p174 and string.lower(p174) or ""
        local count2 = 0

        for key18, value42 in pairs(p173.data) do
          if v337 == "" or string.find(string.lower(tostring(key18)), v337, 1, true)
            or string.find(string.lower(tostring(value42)), v337, 1, true) then
            count2 = count2 + 1

            if count2 > 40 then
              create2("TextLabel", {
                BackgroundTransparency = 1,
                LayoutOrder = count2,
                Size = UDim2.new(1, 0, 0, 14),
                Font = Enum.Font.Gotham,
                Text = "… + more items",
                TextColor3 = Color3.fromRGB(130, 95, 170),
                TextSize = 9,
                ZIndex = 24,
              }, v316)

              break
            end

            local v338 = tostring(value42)

            if type(value42) == "table" then
              local v339, v340 = pcall(JsonEncode, value42)
              v338 = v339 and v340 or "[table]"
            end

            if #v338 > 32 then
              v338 = v338:sub(1, 30) .. "…"
            end

            local v341 = "#88bb99"

            if type(value42) == "boolean" then
              v341 = value42 and "#34D399" or "#F87171"
            elseif type(value42) == "number" then
              v341 = "#60A5FA"
            elseif type(value42) == "table" then
              v341 = "#FBBF24"
            end

            create2("TextLabel", {
              BackgroundTransparency = 1,
              LayoutOrder = count2,
              Size = UDim2.new(1, 0, 0, 14),
              Font = Enum.Font.Gotham,
              RichText = true,
              Text = string.format(
                "<font color=\"#41DC6E\">%s</font> <font color=\"#6B7280\">=</font> <font color=\"%s\">%s</font>",
                tostring(key18), v341, v338
              ),
              TextSize = 10,
              TextXAlignment = Enum.TextXAlignment.Left,
              ZIndex = 24,
            }, v316)
          end
        end

        if count2 == 0 then
          create2("TextLabel", {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 16),
            Font = Enum.Font.Gotham,
            Text = v337 ~= "" and "(no matching keys)" or "(no data keys saved)",
            TextColor3 = Color3.fromRGB(110, 85, 140),
            TextSize = 10,
            TextXAlignment = Enum.TextXAlignment.Left,
            ZIndex = 24,
          }, v316)
        end

        return
      end
    end

    local v342

    v315:GetPropertyChangedSignal("Text"):Connect(function()
      text8 = v315.Text

      if v342 then
        local v343 = save:Get("_saveSlots", {})[v342]

        if v343 then
          v126.UpdatePreview(v343, text8)
        end
      end
    end)

    function v126.OpenSlotPanel(p175)
      v342 = p175
      v296 = true
      local v344 = save:Get("_saveSlots", {})[p175]

      if not v344 then
        return
      else
        v309.Text = v344.name or "Slot " .. p175
        v310.Visible = false
        v315.Text = ""
        text8 = ""
        local v345 = save:Get("_autoLoadTarget", nil) == v344.name

        v312.BackgroundColor3 = v345 and Color3.fromRGB(90, 45, 170)
          or Color3.fromRGB(14, 9, 26)

        v313.Position = v345 and UDim2.new(0, 21, 0.5, 0) or UDim2.new(0, 3, 0.5, 0)
        local uiGradient2 = v313:FindFirstChildOfClass("UIGradient")

        if uiGradient2 then
          uiGradient2.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, v345 and Color3.fromRGB(235, 205, 255)
              or Color3.fromRGB(110, 90, 140)),
            ColorSequenceKeypoint.new(1, v345 and Color3.fromRGB(170, 105, 255)
              or Color3.fromRGB(55, 45, 85)),
          })
        end

        v126.UpdatePreview(v344)
        v126.ShowSlotPage(p175)

        return
      end
    end

    function v126.CloseSlotPanel()
      v296 = false
      v342 = nil
      v126.ShowSettingsPage()
      RefreshSlots()
    end

    v306.MouseButton1Click:Connect(function()
      CircleClick(v306, getMouse.X, getMouse.Y)
      v126.CloseSlotPanel()
    end)

    v328.MouseButton1Click:Connect(function()
      CircleClick(v328, getMouse.X, getMouse.Y)
      local get15 = save:Get("_saveSlots", {})

      if #get15 >= 10 then
        v3.Notification:Notify({
          Title = "Save Manager",
          Description = "Maximum 10 profiles reached.",
        }, { Time = 2 })

        return
      else
        local text10 = v327.Text ~= "" and v327.Text or "Profile " .. #get15 + 1

        table.insert(get15, {
          name = text10,
          data = save:GetSnapshot(),
          created = os.date("%Y-%m-%d %H:%M"),
          updated = os.date("%Y-%m-%d %H:%M"),
        })

        save:Save("_saveSlots", get15)
        v327.Text = ""

        v3.Notification:Notify({
          Title = "Save Manager",
          Description = "Created profile \"" .. text10 .. "\".",
        }, { Time = 2 })

        RefreshSlots()
        return
      end
    end)

    v309:GetPropertyChangedSignal("Text"):Connect(function()
      if not v342 then
        return
      else
        local v346 = save:Get("_saveSlots", {})[v342]

        if v346 then
          v310.Visible = v309.Text ~= v346.name and v309.Text ~= ""
        end

        return
      end
    end)

    v310.MouseButton1Click:Connect(function()
      if not v342 then
        return
      else
        local get16 = save:Get("_saveSlots", {})
        local v347 = get16[v342]

        if not v347 then
          return
        else
          local name4 = v347.name
          local text11 = v309.Text ~= "" and v309.Text or name4
          get16[v342].name = text11

          if save:Get("_autoLoadTarget", nil) == name4 then
            save:Save("_autoLoadTarget", text11)
          end

          if save.ActiveProfile == name4 then
            save.ActiveProfile = text11

            if v298 then
              v298.Text = string.format(
                "Active Profile: <font color=\"#41DC6E\"><b>%s</b></font>", text11
              )
            end
          end

          save:Save("_saveSlots", get16)
          v310.Visible = false
          local backLabel2 = v306:FindFirstChild("BackLabel")

          if backLabel2 then
            backLabel2.Text = text11
          end

          v3.Notification:Notify({
            Title = "Save Manager",
            Description = "Renamed to \"" .. text11 .. "\".",
          }, { Time = 2 })

          RefreshSlots()
          return
        end
      end
    end)

    v314.MouseButton1Click:Connect(function()
      if not v342 then
        return
      else
        local v348 = save:Get("_saveSlots", {})[v342]

        if not v348 then
          return
        else
          local v349 = not (save:Get("_autoLoadTarget", nil) == v348.name)
          save:Save("_autoLoadTarget", v349 and v348.name or nil)

          v4:Tween(
            v313, { Position = v349 and UDim2.new(0, 21, 0.5, 0) or UDim2.new(0, 3, 0.5, 0) },
            0.22, Enum.EasingStyle.Back
          )

          v4:Tween(v312, {
            BackgroundColor3 = v349 and Color3.fromRGB(90, 45, 170) or Color3.fromRGB(14, 9, 26),
          }, 0.2, Enum.EasingStyle.Quint)

          local uiGradient3 = v313:FindFirstChildOfClass("UIGradient")

          if uiGradient3 then
            uiGradient3.Color = ColorSequence.new({
              ColorSequenceKeypoint.new(0, v349 and Color3.fromRGB(235, 205, 255)
                or Color3.fromRGB(110, 90, 140)),
              ColorSequenceKeypoint.new(1, v349 and Color3.fromRGB(170, 105, 255)
                or Color3.fromRGB(55, 45, 85)),
            })
          end

          v3.Notification:Notify({
            Title = "Auto Load",
            Description = v349 and "\"" .. v348.name .. "\" set as default auto-load profile."
              or "Auto Load disabled.",
          }, { Time = 2 })

          RefreshSlots()
          return
        end
      end
    end)

    v318.MouseButton1Click:Connect(function()
      if not v342 then
        return
      else
        CircleClick(v318, getMouse.X, getMouse.Y)
        local v350 = save:Get("_saveSlots", {})[v342]

        if v350 and v350.data then
          save:ApplySnapshot(v350.data, true)
          save.ActiveProfile = v350.name or "Slot " .. v342

          if v298 then
            v298.Text = string.format(
              "Active Profile: <font color=\"#41DC6E\"><b>%s</b></font>", save.ActiveProfile
            )
          end

          v3.Notification:Notify({
            Title = "Save Manager",
            Description = "Applied profile \"" .. (v350.name or "Slot") .. "\" to all controls.",
          }, { Time = 3 })

          RefreshSlots()
        end

        return
      end
    end)

    v319.MouseButton1Click:Connect(function()
      if not v342 then
        return
      else
        CircleClick(v319, getMouse.X, getMouse.Y)
        local get17 = save:Get("_saveSlots", {})
        local v351 = get17[v342]

        if v351 then
          v351.data = save:GetSnapshot()
          v351.updated = os.date("%Y-%m-%d %H:%M")

          save:Save("_saveSlots", get17)
          v126.UpdatePreview(v351, text8)

          v3.Notification:Notify({
            Title = "Save Manager",
            Description = "Overwrote \"" .. (v351.name or "profile") .. "\" with current state.",
          }, { Time = 2 })

          RefreshSlots()
        end

        return
      end
    end)

    v321.MouseButton1Click:Connect(function()
      if not v342 then
        return
      else
        CircleClick(v321, getMouse.X, getMouse.Y)
        local get18 = save:Get("_saveSlots", {})

        if #get18 >= 10 then
          v3.Notification:Notify({
            Title = "Save Manager",
            Description = "Maximum 10 profiles reached.",
          }, { Time = 2 })

          return
        else
          local v352 = get18[v342]

          if v352 then
            local v353 = {}

            for key19, value43 in pairs(v352.data or {}) do
              v353[key19] = value43
            end

            table.insert(get18, {
              name = (v352.name or "Profile") .. " (Copy)",
              data = v353,
              created = os.date("%Y-%m-%d %H:%M"),
              updated = os.date("%Y-%m-%d %H:%M"),
            })

            save:Save("_saveSlots", get18)

            v3.Notification:Notify({
              Title = "Save Manager",
              Description = "Cloned \"" .. (v352.name or "profile") .. "\".",
            }, { Time = 2 })

            RefreshSlots()
          end

          return
        end
      end
    end)

    v323.MouseButton1Click:Connect(function()
      if not v342 then
        return
      else
        CircleClick(v323, getMouse.X, getMouse.Y)
        local get19 = save:Get("_saveSlots", {})
        local name5 = get19[v342] and get19[v342].name
        table.remove(get19, v342)
        save:Save("_saveSlots", get19)

        if name5 and save:Get("_autoLoadTarget", nil) == name5 then
          save:Save("_autoLoadTarget", nil)
        end

        if name5 and save.ActiveProfile == name5 then
          save.ActiveProfile = "[Auto]"

          if v298 then
            v298.Text = "Active Profile: <font color=\"#41DC6E\"><b>[Auto]</b></font>"
          end
        end

        v3.Notification:Notify({ Title = "Save Manager", Description = "Profile deleted." }, {
          Time = 2,
        })

        v126.CloseSlotPanel()
        return
      end
    end)

    v322.MouseButton1Click:Connect(function()
      if not v342 then
        return
      else
        CircleClick(v322, getMouse.X, getMouse.Y)
        local v354 = save:Get("_saveSlots", {})[v342]

        if not v354 then
          return
        else
          local v355 = v126.EncodeShareCode({ name = v354.name, data = v354.data })

          if v355 then
            local v356 = setclipboard or toclipboard or getgenv and getgenv().setclipboard

            if v356 then
              pcall(v356, v355)
            end

            v3.Notification:Notify({
              Title = "Share Saved",
              Description = "Share code copied to clipboard!",
            }, { Time = 3 })
          else
            v3.Notification:Notify({
              Title = "Share Saved",
              Description = "Failed to encode save.",
            }, { Time = 2 })
          end

          return
        end
      end
    end)

    v331.MouseButton1Click:Connect(function()
      CircleClick(v331, getMouse.X, getMouse.Y)
      local gsub6 = v330.Text:gsub("`", "")

      if gsub6 == "" then
        return
      else
        local v357 = v126.DecodeShareCode(gsub6)

        if not v357 then
          v3.Notification:Notify(
            { Title = "Import", Description = "Invalid share code format." }, { Time = 2 }
          )

          return
        else
          local get20 = save:Get("_saveSlots", {})

          if #get20 >= 10 then
            v3.Notification:Notify({
              Title = "Import",
              Description = "Maximum 10 profiles reached.",
            }, { Time = 2 })

            return
          else
            local v358 = (v357.name or "Imported") .. " (imported)"

            table.insert(get20, {
              name = v358,
              data = v357.data or {},
              created = os.date("%Y-%m-%d %H:%M"),
              updated = os.date("%Y-%m-%d %H:%M"),
            })

            save:Save("_saveSlots", get20)
            v330.Text = ""

            v3.Notification:Notify({
              Title = "Import",
              Description = "Imported profile \"" .. v358 .. "\".",
            }, { Time = 3 })

            RefreshSlots()
            return
          end
        end
      end
    end)

    local v359 = f11

    function f11()
      if v296 then
        v296 = false
        v342 = nil
        v126.ShowSettingsPage()
      end

      v359()
    end

    local v360 = f12

    function f12()
      if v296 then
        v296 = false
        v342 = nil
        v126.ShowSettingsPage()
      end

      v360()
    end

    function RefreshSlots()
      for index30, value44 in ipairs(v295) do
      end

      v295 = {}
      get13 = save:Get("_saveSlots", {})
      local get21 = save:Get("_autoLoadTarget", nil)

      if v324 then
        v324.Text = string.format("PROFILES & SLOTS (%d/10)", #get13)
      end

      if #get13 == 0 then
        table.insert(v295, (create2("TextLabel", {
          BackgroundTransparency = 1,
          Size = UDim2.new(1, 0, 0, 24),
          Font = Enum.Font.Gotham,
          Text = "No saved profiles. Create or Quick Save above!",
          TextColor3 = Color3.fromRGB(130, 105, 160),
          TextSize = 10,
          TextXAlignment = Enum.TextXAlignment.Center,
          ZIndex = 23,
        }, v325)))
      end

      for index31, value45 in ipairs(get13) do
        local v361 = get21 == value45.name
        local v362 = save.ActiveProfile == value45.name
        local v363 = v342 == index31 and v296

        local v364 = create2("Frame", {
          BackgroundColor3 = v363 and Color3.fromRGB(24, 16, 42) or Color3.fromRGB(15, 10, 26),
          BackgroundTransparency = 0,
          BorderSizePixel = 0,
          Size = UDim2.new(1, 0, 0, 42),
          LayoutOrder = index31,
          ZIndex = 23,
          Children = {
            create2("UICorner", { CornerRadius = UDim.new(0, 7) }),
            create2("UIStroke", {
              Color = v363 and Color3.fromRGB(190, 130, 255)
                or v361 and Color3.fromRGB(160, 105, 240) or Color3.fromRGB(90, 60, 150),
              Transparency = v363 and 0.2 or v361 and 0.4 or 0.75,
              Thickness = 1,
              ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
            }),
          },
        }, v325)

        create2("Frame", {
          BackgroundColor3 = v361 and Color3.fromRGB(190, 140, 255)
            or Color3.fromRGB(120, 70, 200),
          BorderSizePixel = 0,
          Position = UDim2.new(0, 0, 0, 6),
          Size = UDim2.new(0, 3, 1, -12),
          ZIndex = 24,
          Children = { create2("UICorner", { CornerRadius = UDim.new(1, 0) }) },
        }, v364)

        create2("Frame", {
          BackgroundColor3 = Color3.fromRGB(38, 22, 70),
          BackgroundTransparency = 0.2,
          BorderSizePixel = 0,
          Position = UDim2.new(0, 10, 0.5, -10),
          Size = UDim2.new(0, 20, 0, 20),
          ZIndex = 24,
          Children = {
            create2("UICorner", { CornerRadius = UDim.new(0, 5) }),
            create2("TextLabel", {
              BackgroundTransparency = 1,
              Size = UDim2.new(1, 0, 1, 0),
              Font = Enum.Font.GothamBold,
              Text = tostring(index31),
              TextColor3 = Color3.fromRGB(200, 160, 255),
              TextSize = 10,
              TextXAlignment = Enum.TextXAlignment.Center,
              ZIndex = 25,
            }),
          },
        }, v364)

        local count3 = 0

        if value45.data then
          for key20 in pairs(value45.data) do
            count3 = count3 + 1
          end
        end

        create2("TextLabel", {
          BackgroundTransparency = 1,
          Position = UDim2.new(0, 36, 0, 6),
          Size = UDim2.new(1, -105, 0, 15),
          Font = Enum.Font.GothamBold,
          Text = value45.name or "Profile " .. index31,
          TextColor3 = v363 and Color3.fromRGB(240, 220, 255)
            or v362 and Color3.fromRGB(225, 195, 255) or Color3.fromRGB(190, 170, 230),
          TextSize = 11,
          TextXAlignment = Enum.TextXAlignment.Left,
          TextTruncate = Enum.TextTruncate.AtEnd,
          ZIndex = 24,
        }, v364)

        local v365 = string.format("%d keys", count3)

        if v361 then
          v365 = v365 .. "  •  auto load"
        elseif v362 then
          v365 = v365 .. "  •  active"
        end

        create2("TextLabel", {
          BackgroundTransparency = 1,
          Position = UDim2.new(0, 36, 0, 22),
          Size = UDim2.new(1, -105, 0, 13),
          Font = Enum.Font.Gotham,
          Text = v365,
          TextColor3 = v361 and Color3.fromRGB(180, 130, 255)
            or v362 and Color3.fromRGB(140, 220, 170) or Color3.fromRGB(135, 115, 165),
          TextSize = 9,
          TextXAlignment = Enum.TextXAlignment.Left,
          ZIndex = 24,
        }, v364)

        local v366 = create2("TextButton", {
          AnchorPoint = Vector2.new(1, 0.5),
          BackgroundColor3 = Color3.fromRGB(70, 35, 140),
          BackgroundTransparency = 0.35,
          BorderSizePixel = 0,
          Position = UDim2.new(1, -8, 0.5, 0),
          Size = UDim2.new(0, 48, 0, 22),
          Text = "Load",
          TextColor3 = Color3.fromRGB(215, 185, 255),
          Font = Enum.Font.GothamBold,
          TextSize = 10,
          AutoButtonColor = false,
          ZIndex = 25,
          Children = {
            create2("UICorner", { CornerRadius = UDim.new(0, 5) }),
            create2("UIStroke", {
              Color = Color3.fromRGB(150, 100, 230),
              Transparency = 0.6,
              Thickness = 1,
              ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
            }),
          },
        }, v364)

        v366.MouseEnter:Connect(function()
          v4:Tween(v366, { BackgroundTransparency = 0.15 }, 0.12)
        end)

        v366.MouseLeave:Connect(function()
          v4:Tween(v366, { BackgroundTransparency = 0.35 }, 0.18)
        end)

        local v367 = index31
        local v368 = value45

        v366.MouseButton1Click:Connect(function()
          CircleClick(v366, getMouse.X, getMouse.Y)

          if v368 and v368.data then
            save:ApplySnapshot(v368.data, true)
            save.ActiveProfile = v368.name or "Slot " .. v367

            if v298 then
              v298.Text = string.format(
                "Active Profile: <font color=\"#41DC6E\"><b>%s</b></font>", save.ActiveProfile
              )
            end

            v3.Notification:Notify({
              Title = "Save Manager",
              Description = "Loaded profile \"" .. (v368.name or "Slot") .. "\".",
            }, { Time = 2 })

            RefreshSlots()
          end
        end)

        local v369 = create2("TextButton", {
          BackgroundTransparency = 1,
          Size = UDim2.new(1, -62, 1, 0),
          Position = UDim2.new(0, 0, 0, 0),
          Text = "",
          ZIndex = 24,
        }, v364)

        v369.MouseEnter:Connect(function()
          if not v363 then
            v4:Tween(v364, { BackgroundColor3 = Color3.fromRGB(22, 14, 38) }, 0.12)
          end
        end)

        v369.MouseLeave:Connect(function()
          v4:Tween(v364, {
            BackgroundColor3 = v363 and Color3.fromRGB(24, 16, 42) or Color3.fromRGB(15, 10, 26),
          }, 0.18)
        end)

        v369.MouseButton1Click:Connect(function()
          CircleClick(v369, getMouse.X, getMouse.Y)

          if v296 and v342 == v367 then
            v126.CloseSlotPanel()
          else
            v126.OpenSlotPanel(v367)
            RefreshSlots()
          end
        end)

        table.insert(v295, v364)
      end
    end
  end

  do
    RefreshSlots()

    task.defer(function()
      local get22 = save:Get("_autoLoadTarget", nil)

      if get22 then
        for index32, value46 in ipairs((save:Get("_saveSlots", {}))) do
          if value46.name == get22 and value46.data then
            save:ApplySnapshot(value46.data, true)
            save.ActiveProfile = value46.name

            if v298 then
              v298.Text = string.format(
                "Active Profile: <font color=\"#41DC6E\"><b>%s</b></font>", value46.name
              )
            end

            break
          end
        end
      end
    end)

    create2("TextLabel", {
      BackgroundTransparency = 1,
      Size = UDim2.new(1, 0, 0, 16),
      Font = Enum.Font.GothamBold,
      Text = "Theme Manager",
      TextColor3 = Color3.fromRGB(150, 105, 220),
      TextSize = 10,
      TextXAlignment = Enum.TextXAlignment.Center,
      ZIndex = 23,
    }, v225)

    local v370 = create2("Frame", {
      BackgroundTransparency = 1,
      Size = UDim2.new(1, 0, 0, 0),
      AutomaticSize = Enum.AutomaticSize.Y,
      ZIndex = 23,
      Children = {
        create2("UIListLayout", {
          HorizontalAlignment = Enum.HorizontalAlignment.Center,
          SortOrder = Enum.SortOrder.LayoutOrder,
          Padding = UDim.new(0, 5),
        }),
      },
    }, v225)

    local v371 = {}
    local get23 = save:Get("_activeTheme", theme2)

    if quantumThemeManager.Themes[get23] then
      quantumThemeManager.Current = quantumThemeManager.Themes[get23]
      v182.BackgroundColor3 = quantumThemeManager.Current.Body
    end

    function v126.BuildThemeCards()
      for index33, value47 in ipairs(v371) do
      end

      v371 = {}

      for index34, value48 in ipairs({ "Purple", "Crimson", "Ocean", "Emerald", "Sunset" }) do
        local v372 = quantumThemeManager.Themes[value48]
        local v373 = get23 == value48
        local accent2 = v372.Accent
        local accentDark = v372.AccentDark
        local previewColors = v372.PreviewColors

        local v374 = create2("TextButton", {
          BackgroundColor3 = v373 and Color3.fromRGB(20, 13, 36) or Color3.fromRGB(14, 10, 22),
          BackgroundTransparency = 0,
          BorderSizePixel = 0,
          Size = UDim2.new(1, 0, 0, 44),
          Text = "",
          AutoButtonColor = false,
          ZIndex = 23,
          Children = { create2("UICorner", { CornerRadius = UDim.new(0, 9) }) },
        }, v370)

        local v375 = create2("UIStroke", {
          Color = v373 and accent2 or Color3.fromRGB(90, 60, 140),
          Transparency = v373 and 0.3 or 0.78,
          Thickness = 1,
          ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        }, v374)

        create2("Frame", {
          BackgroundColor3 = accent2,
          BackgroundTransparency = v373 and 0 or 0.5,
          BorderSizePixel = 0,
          Position = UDim2.new(0, 0, 0, 7),
          Size = UDim2.new(0, 3, 1, -14),
          ZIndex = 24,
          Children = {
            create2("UICorner", { CornerRadius = UDim.new(1, 0) }),
            create2("UIGradient", {
              Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, v372.AccentLight),
                ColorSequenceKeypoint.new(1, accentDark),
              }),
              Rotation = 90,
            }),
          },
        }, v374)

        local v376 = 12

        for index35, value49 in ipairs(previewColors) do
          create2("Frame", {
            BackgroundColor3 = value49,
            BorderSizePixel = 0,
            Position = UDim2.new(0, v376, 0.5, -10),
            Size = UDim2.new(0, 20, 0, 20),
            ZIndex = 24,
            Children = {
              create2("UICorner", { CornerRadius = UDim.new(1, 0) }),
              create2("UIStroke", {
                Color = Color3.fromRGB(255, 255, 255),
                Transparency = 0.85,
                Thickness = 1,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
              }),
            },
          }, v374)

          v376 = v376 + 16
        end

        create2("TextLabel", {
          BackgroundTransparency = 1,
          Position = UDim2.new(0, 72, 0, 0),
          Size = UDim2.new(1, -130, 1, 0),
          Font = Enum.Font.GothamBold,
          Text = v372.DisplayName,
          TextColor3 = v373 and v372.AccentLight or Color3.fromRGB(185, 165, 215),
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Left,
          ZIndex = 24,
        }, v374)

        local color12 = v373
        local vector4 = Vector2.new(1, 0.5)

        color12 = v373
          and Color3.new(accentDark.R * 0.5, accentDark.G * 0.5, accentDark.B * 0.5)

        local color13 = color12
        color13 = color12 or Color3.fromRGB(18, 12, 28)

        local udim9 = UDim2.new(1, -8, 0.5, 0)
        local udim10 = UDim2.new(0, 62, 0, 22)

        create2("Frame", {
          AnchorPoint = vector4,
          BackgroundColor3 = color13,
          BackgroundTransparency = 0,
          BorderSizePixel = 0,
          Position = udim9,
          Size = udim10,
          ZIndex = 24,
          Children = {
            create2("UICorner", { CornerRadius = UDim.new(0, 6) }),
            create2("UIStroke", {
              Color = v373 and accent2 or Color3.fromRGB(90, 65, 130),
              Transparency = v373 and 0.35 or 0.72,
              Thickness = 1,
              ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
            }),
            create2("TextLabel", {
              BackgroundTransparency = 1,
              Size = UDim2.new(1, 0, 1, 0),
              Font = Enum.Font.GothamBold,
              Text = v373 and "Active" or "Apply",
              TextColor3 = v373 and v372.AccentLight or Color3.fromRGB(160, 130, 200),
              TextSize = 10,
              TextXAlignment = Enum.TextXAlignment.Center,
              ZIndex = 25,
            }),
          },
        }, v374)

        table.insert(v371, v374)
        local v377 = value48

        v374.MouseEnter:Connect(function()
          if get23 ~= v377 then
            v4:Tween(
              v374, { BackgroundColor3 = Color3.fromRGB(18, 13, 30) }, 0.15,
              Enum.EasingStyle.Quint
            )

            v4:Tween(v375, { Transparency = 0.55 }, 0.15)
          end
        end)

        v374.MouseLeave:Connect(function()
          if get23 ~= v377 then
            v4:Tween(
              v374, { BackgroundColor3 = Color3.fromRGB(14, 10, 22) }, 0.2,
              Enum.EasingStyle.Quint
            )

            v4:Tween(v375, { Transparency = 0.78 }, 0.2)
          end
        end)

        v374.MouseButton1Click:Connect(function()
          if get23 == v377 then
            return
          end

          CircleClick(v374, getMouse.X, getMouse.Y)
          get23 = v377
          ApplyTheme(v377)
          v126.BuildThemeCards()

          v3.Notification:Notify({
            Title = "Theme Manager",
            Description = v377 .. " theme applied.",
          }, { Time = 2 })
        end)
      end
    end

    v126.BuildThemeCards()

    create2("TextLabel", {
      BackgroundTransparency = 1,
      Size = UDim2.new(1, 0, 0, 16),
      Font = Enum.Font.GothamBold,
      Text = "Background Media",
      TextColor3 = Color3.fromRGB(150, 105, 220),
      TextSize = 10,
      TextXAlignment = Enum.TextXAlignment.Center,
      ZIndex = 23,
    }, v225)

    create2("TextLabel", {
      BackgroundTransparency = 1,
      Size = UDim2.new(1, 0, 0, 28),
      Font = Enum.Font.Gotham,
      Text = "Drop .png/.jpg/.webm/.mp4 into Quantum Onyx Hub folder",
      TextColor3 = Color3.fromRGB(130, 110, 170),
      TextSize = 9,
      TextWrapped = true,
      TextXAlignment = Enum.TextXAlignment.Center,
      ZIndex = 23,
    }, v225)

    local v378 = create2("ScrollingFrame", {
      BackgroundTransparency = 1,
      BorderSizePixel = 0,
      Size = UDim2.new(1, 0, 0, 72),
      CanvasSize = UDim2.new(0, 0, 0, 0),
      ScrollBarThickness = 0,
      ScrollBarImageTransparency = 1,
      ElasticBehavior = Enum.ElasticBehavior.WhenScrollable,
      ScrollingEnabled = true,
      ZIndex = 23,
      Children = {
        create2("UIListLayout", {
          SortOrder = Enum.SortOrder.LayoutOrder,
          Padding = UDim.new(0, 4),
        }),
        create2("UIPadding", { PaddingLeft = UDim.new(0, 4), PaddingRight = UDim.new(0, 4) }),
      },
    }, v225)

    function v126.BuildBgImageCards()
      for index36, value50 in ipairs(v378:GetChildren()) do
        if value50:IsA("TextButton") then
          value50:Destroy()
        end
      end

      local v379 = listImages(save.FolderName)
      local v380 = listVideos(save.FolderName)
      local v381 = {}

      for index37, value51 in ipairs(v379) do
        table.insert(v381, value51)
      end

      for index38, value52 in ipairs(v380) do
        table.insert(v381, value52)
      end

      local get24 = save:Get("_opt_BgImage", "")

      create2("TextButton", {
        BackgroundColor3 = get24 == "" and Color3.fromRGB(22, 14, 38)
          or Color3.fromRGB(14, 10, 22),
        BorderSizePixel = 0,
        Size = UDim2.new(1, -8, 0, 28),
        Font = Enum.Font.GothamBold,
        Text = "None (theme default)",
        TextColor3 = Color3.fromRGB(185, 165, 215),
        TextSize = 10,
        ZIndex = 24,
        LayoutOrder = 0,
        Children = { create2("UICorner", { CornerRadius = UDim.new(0, 7) }) },
      }, v378).MouseButton1Click:Connect(function()
        ApplyBackgroundImage("")
        save:Save("_opt_BgImage", "")
        v126.BuildBgImageCards()
      end)

      for index39, value53 in ipairs(v381) do
        local match2 = value53:match("([^/\\]+)$") or value53
        local v382 = isVideo(value53)
        local v383 = get24 == value53

        local v384 = create2("TextButton", {
          BackgroundColor3 = v383 and Color3.fromRGB(22, 14, 38) or Color3.fromRGB(14, 10, 22),
          BorderSizePixel = 0,
          Size = UDim2.new(1, -8, 0, 28),
          Font = Enum.Font.GothamBold,
          Text = (v383 and "✓ " or "") .. (v382 and "[VID] " or "") .. match2,
          TextColor3 = v383 and Color3.fromRGB(210, 180, 255) or Color3.fromRGB(160, 140, 200),
          TextSize = 10,
          TextTruncate = Enum.TextTruncate.AtEnd,
          TextXAlignment = Enum.TextXAlignment.Left,
          ZIndex = 24,
          LayoutOrder = index39,
          Children = {
            create2("UICorner", { CornerRadius = UDim.new(0, 7) }),
            create2("UIPadding", { PaddingLeft = UDim.new(0, 10) }),
          },
        }, v378)

        local v385 = value53

        v384.MouseButton1Click:Connect(function()
          ApplyBackgroundImage(v385)
          v126.BuildBgImageCards()

          v3.Notification:Notify({ Title = "Background", Description = "Applied " .. match2 }, {
            Time = 2,
          })
        end)
      end

      local uiListLayout = v378:FindFirstChildOfClass("UIListLayout")

      if uiListLayout then
        FitScrollCanvas(v378, uiListLayout, "Y", 4)
      end
    end
  end

  do
    v126.BuildBgImageCards()

    v126.MakeMiniSlider(v225, "BG Image Fade", "_opt_BgImageTransparency", 0.5, 1, save:Get("_opt_BgImageTransparency", 0.88), 0.02, function(p176, p177)
      if v183 then
        v183.ImageTransparency = p176
      end

      if p177 then
        save:Save("_opt_BgImageTransparency", p176)
      end
    end, nil, true)

    local v386 = {
      {
        Name = "Default",
        Regular = Enum.Font.Gotham,
        Bold = Enum.Font.GothamBold,
        Display = Enum.Font.FredokaOne,
      },
      {
        Name = "Gotham",
        Regular = Enum.Font.Gotham,
        Bold = Enum.Font.GothamBold,
        Display = Enum.Font.FredokaOne,
      },
      {
        Name = "Source Sans",
        Regular = Enum.Font.SourceSans,
        Bold = Enum.Font.SourceSansBold,
        Display = Enum.Font.SourceSansBold,
      },
      {
        Name = "Nunito",
        Regular = Enum.Font.Nunito,
        Bold = Enum.Font.Nunito,
        Display = Enum.Font.Nunito,
      },
      {
        Name = "Oswald",
        Regular = Enum.Font.Oswald,
        Bold = Enum.Font.Oswald,
        Display = Enum.Font.Oswald,
      },
      {
        Name = "Ubuntu",
        Regular = Enum.Font.Ubuntu,
        Bold = Enum.Font.Ubuntu,
        Display = Enum.Font.Ubuntu,
      },
      {
        Name = "Roboto",
        Regular = Enum.Font.Roboto,
        Bold = Enum.Font.Roboto,
        Display = Enum.Font.RobotoCondensed,
      },
      {
        Name = "Arcade",
        Regular = Enum.Font.Arcade,
        Bold = Enum.Font.Arcade,
        Display = Enum.Font.Arcade,
      },
      {
        Name = "Code",
        Regular = Enum.Font.Code,
        Bold = Enum.Font.Code,
        Display = Enum.Font.Code,
      },
    }

    local v387 = {
      [Enum.Font.Gotham] = "Regular",
      [Enum.Font.SourceSans] = "Regular",
      [Enum.Font.Nunito] = "Regular",
      [Enum.Font.Oswald] = "Regular",
      [Enum.Font.Ubuntu] = "Regular",
      [Enum.Font.Roboto] = "Regular",
      [Enum.Font.Arcade] = "Regular",
      [Enum.Font.Code] = "Regular",
      [Enum.Font.GothamBold] = "Bold",
      [Enum.Font.GothamSemibold] = "Bold",
      [Enum.Font.SourceSansBold] = "Bold",
      [Enum.Font.FredokaOne] = "Display",
      [Enum.Font.RobotoCondensed] = "Display",
    }

    function v126.ResolveFontPreset(p178)
      for index40, value54 in ipairs(v386) do
        if value54.Name == p178 then
          return value54
        end
      end

      return v386[1]
    end

    function v126.ApplyUIFont(p179)
      local v388 = v126.ResolveFontPreset(p179)
      save:Save("_opt_UIFont", v388.Name)
      local v389 = { Regular = v388.Regular, Bold = v388.Bold, Display = v388.Display }

      for index41, value55 in ipairs(v182:GetDescendants()) do
        local v390 = value55

        if v390:IsA("TextLabel") or v390:IsA("TextButton") or v390:IsA("TextBox") then
          local v391 = v387[v390.Font] or "Regular"
          pcall(function() v390.Font = v389[v391] or v388.Regular end)
        end
      end
    end

    create2("TextLabel", {
      BackgroundTransparency = 1,
      Size = UDim2.new(1, 0, 0, 16),
      Font = Enum.Font.GothamBold,
      Text = "UI Font",
      TextColor3 = Color3.fromRGB(150, 105, 220),
      TextSize = 10,
      TextXAlignment = Enum.TextXAlignment.Center,
      ZIndex = 23,
    }, v225)

    local v392 = create2("ScrollingFrame", {
      BackgroundTransparency = 1,
      BorderSizePixel = 0,
      Size = UDim2.new(1, 0, 0, 90),
      CanvasSize = UDim2.new(0, 0, 0, 0),
      ScrollBarThickness = 0,
      ScrollBarImageTransparency = 1,
      ElasticBehavior = Enum.ElasticBehavior.WhenScrollable,
      ScrollingEnabled = true,
      ZIndex = 23,
      Children = {
        create2("UIListLayout", {
          SortOrder = Enum.SortOrder.LayoutOrder,
          Padding = UDim.new(0, 4),
        }),
        create2("UIPadding", { PaddingLeft = UDim.new(0, 4), PaddingRight = UDim.new(0, 4) }),
      },
    }, v225)

    function v126.BuildFontCards()
      for index42, value56 in ipairs(v392:GetChildren()) do
        if value56:IsA("TextButton") then
          value56:Destroy()
        end
      end

      local get25 = save:Get("_opt_UIFont", "Gotham")

      for index43, value57 in ipairs(v386) do
        local v393 = get25 == value57.Name

        local v394 = create2("TextButton", {
          BackgroundColor3 = v393 and Color3.fromRGB(22, 14, 38) or Color3.fromRGB(14, 10, 22),
          BorderSizePixel = 0,
          Size = UDim2.new(1, -8, 0, 26),
          Font = value57.Bold,
          Text = (v393 and "✓ " or "") .. value57.Name,
          TextColor3 = v393 and Color3.fromRGB(210, 180, 255) or Color3.fromRGB(160, 140, 200),
          TextSize = 11,
          ZIndex = 24,
          LayoutOrder = index43,
          Children = { create2("UICorner", { CornerRadius = UDim.new(0, 7) }) },
        }, v392)

        local name6 = value57.Name

        v394.MouseButton1Click:Connect(function()
          v126.ApplyUIFont(name6)
          v126.BuildFontCards()

          v3.Notification:Notify({ Title = "Font", Description = "Applied " .. name6 }, {
            Time = 2,
          })
        end)
      end

      local uiListLayout2 = v392:FindFirstChildOfClass("UIListLayout")

      if uiListLayout2 then
        FitScrollCanvas(v392, uiListLayout2, "Y", 4)
      end
    end

    v126.BuildFontCards()

    task.defer(function()
      local get26 = save:Get("_opt_UIFont", "Default")

      if get26 and get26 ~= "Default" and get26 ~= "Gotham" then
        v126.ApplyUIFont(get26)
      end
    end)

    v126.MakeMiniSlider(v225, "UI Transparency", "_opt_UITransparency", 0, 0.55, save:Get("_opt_UITransparency", 0.05), 0.01, function(p180, p181)
      if v182 then
        v182.BackgroundTransparency = p180
      end

      if p181 then
        save:Save("_opt_UITransparency", p180)
      end
    end, nil, true)
  end

  do
    v197.MouseButton1Click:Connect(function()
      CircleClick(v197, getMouse.X, getMouse.Y)

      if v209 and v209() then
        v208()
      end

      if v235 and v235() then
        f12()
      end

      if v126.BuildBgImageCards then
        v126.BuildBgImageCards()
      end

      v227()
    end)

    v395 = create2("Frame", {
      BackgroundColor3 = Color3.fromRGB(60, 60, 60),
      BackgroundTransparency = 1,
      BorderSizePixel = 0,
      Position = UDim2.new(0.0160791595, 0, 0.219451368, 0),
      Size = UDim2.new(0, 60, 0, 60),
      Visible = not v140,
      Active = true,
      Children = { create2("UICorner", { CornerRadius = UDim.new(1, 0) }) },
    }, v163)

    v126.ToggleClose = v395

    create2(
      "UIScale",
      { Name = "ToggleUIScale", Scale = v166 and v166.Scale > 0 and v166.Scale or 1 }, v395
    )

    v396 = create2("ImageButton", {
      Name = "ToggleLogo",
      BackgroundTransparency = 1,
      BorderSizePixel = 0,
      AnchorPoint = Vector2.new(0.5, 0.5),
      Position = UDim2.new(0.5, 0, 0.5, 0),
      Size = UDim2.new(1, 0, 1, 0),
      Image = "",
      Active = true,
      Children = {
        create2("UICorner", { CornerRadius = UDim.new(1, 0) }),
        create2("TextLabel", {
          Name = "KeshavDoomLogoText",
          BackgroundTransparency = 1,
          Size = UDim2.new(1, 0, 1, 0),
          Font = Enum.Font.GothamBlack,
          Text = "KD",
          TextColor3 = Color3.fromRGB(210, 170, 255),
          TextSize = 20,
          TextStrokeColor3 = Color3.fromRGB(35, 15, 55),
          TextStrokeTransparency = 0.1,
          ZIndex = 5,
        }),
      },
    }, v395)

    v397 = {
      on = false,
      moved = false,
      start = nil,
      origin = nil,
      input = nil,
    }

    function v126.ClampToggleClose()
      if not v395 then
        return
      else
        local currentCamera3 = workspace.CurrentCamera

        local viewportSize2 = currentCamera3 and currentCamera3.ViewportSize
          or Vector2.new(1920, 1080)

        if viewportSize2.X < 50 or viewportSize2.Y < 50 then
          return
        else
          local v398 = 60
            * (v395:FindFirstChildOfClass("UIScale")
                and v395:FindFirstChildOfClass("UIScale").Scale > 0
                and v395:FindFirstChildOfClass("UIScale").Scale
              or 1)

          local offset = v395.Position.X.Offset
          local offset2 = v395.Position.Y.Offset
          local v399 = math.clamp(offset, 4, math.max(4, viewportSize2.X - v398 - 4))
          local v400 = math.clamp(offset2, 4, math.max(4, viewportSize2.Y - v398 - 4))

          if v399 ~= offset or v400 ~= offset2 then
            v395.Position = UDim2.fromOffset(v399, v400)
          end

          return
        end
      end
    end

    function v126.PinToggleToOffset()
      local absolutePosition5 = v395.AbsolutePosition
      v395.Position = UDim2.fromOffset(absolutePosition5.X, absolutePosition5.Y)
      v126.ClampToggleClose()
    end

    local v401 = touchEnabled2 and 16 or 8

    local function f20(p182)
      if v397.on then
        return
      end

      if p182.UserInputType ~= Enum.UserInputType.MouseButton1
        and p182.UserInputType ~= Enum.UserInputType.Touch then
        return
      end

      v397.on = true
      v397.input = p182
      v397.moved = false
      v397.start = Vector2.new(p182.Position.X, p182.Position.Y)

      v126.PinToggleToOffset()
      v397.origin = v395.Position
    end

    v395.InputBegan:Connect(f20)
    v396.InputBegan:Connect(f20)

    userInputService.InputChanged:Connect(function(input8)
      if not v397.on or not v397.start or not v397.origin or not v397.input then
        return
      end

      if input8 == v397.input
        or v397.input.UserInputType == Enum.UserInputType.MouseButton1
          and input8.UserInputType == Enum.UserInputType.MouseMovement then
        local v402 = not v397.moved
        local v403 = Vector2.new(input8.Position.X, input8.Position.Y) - v397.start

        if v402 and v403.Magnitude > v401 then
          v397.moved = true
        end

        if v397.moved then
          local currentCamera4 = workspace.CurrentCamera

          local viewportSize3 = currentCamera4 and currentCamera4.ViewportSize
            or Vector2.new(1920, 1080)

          local v404 = 60
            * (v395:FindFirstChildOfClass("UIScale")
                and v395:FindFirstChildOfClass("UIScale").Scale > 0
                and v395:FindFirstChildOfClass("UIScale").Scale
              or 1)

          v395.Position = UDim2.fromOffset(math.clamp(
            v397.origin.X.Offset + v403.X, 4, math.max(4, viewportSize3.X - v404 - 4)
          ), (math.clamp(
            v397.origin.Y.Offset + v403.Y, 4, math.max(4, viewportSize3.Y - v404 - 4)
          )))
        end
      end
    end)
  end

  do
    userInputService.InputEnded:Connect(function(input9)
      if not v397.on then
        return
      end

      if input9 == v397.input or input9.UserInputType == Enum.UserInputType.MouseButton1
        or input9.UserInputType == Enum.UserInputType.Touch then
        v397.on = false
        v397.input = nil
        v397.start = nil
        v397.origin = nil

        v126.ClampToggleClose()
        task.delay(0.12, function() v397.moved = false end)
      end
    end)

    function v126.ClampWindowPosition(p183, p184)
      local currentCamera5 = workspace.CurrentCamera

      local viewportSize4 = currentCamera5 and currentCamera5.ViewportSize
        or Vector2.new(1920, 1080)

      local scale5 = v166 and v166.Scale > 0 and v166.Scale or 1
      local v405 = p184.X.Offset * scale5 / 2
      local v406 = p184.Y.Offset * scale5 / 2

      local v407 = math.clamp(
        p183.X.Scale * viewportSize4.X + p183.X.Offset, v405 + 6,
        math.max(v405 + 6, viewportSize4.X - v405 - 6)
      )

      local v408 = math.clamp(
        p183.Y.Scale * viewportSize4.Y + p183.Y.Offset, v406 + 6,
        math.max(v406 + 6, viewportSize4.Y - v406 - 6)
      )

      return UDim2.new(0, math.floor(v407), 0, math.floor(v408))
    end

    local v409 = false
    v126._minTween = false
    local f21

    local function f22()
      if not v409 or v126._minTween then
        return
      else
        v126._minTween = true
        f21()
        local scale6 = v166 and v166.Scale > 0 and v166.Scale or 1
        local udim11 = UDim2.new(0, 510, 0, 330)

        local udim12 = UDim2.fromOffset(
          v182.Position.X.Offset + 135 * scale6, v182.Position.Y.Offset + 148 * scale6
        )

        v194.Image = "rbxassetid://92966930061759"
        v182.ClipsDescendants = true

        if TabContainer then
          TabContainer.Visible = true
        end

        if MainContainer then
          MainContainer.Visible = true
        end

        v4:Tween(v182, { Position = udim12, Size = udim11 }, 0.24, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, function()
          v182.ClipsDescendants = false

          if v196 then
            v196.Visible = true
          end

          if v197 then
            v197.Visible = true
          end

          if bodyVideo and v184 and v184.Visible then
            pcall(function()
              bodyVideo.Playing = true
              bodyVideo:Play()
            end)
          end

          v409 = false
          v126._minTween = false
        end)

        task.delay(0.28, function()
          if v126._minTween then
            if TabContainer then
              TabContainer.Visible = true
            end

            if MainContainer then
              MainContainer.Visible = true
            end

            if v196 then
              v196.Visible = true
            end

            if v197 then
              v197.Visible = true
            end

            v182.ClipsDescendants = false
            v409 = false
            v126._minTween = false
          end
        end)

        return
      end
    end

    local function f23()
      if v409 or v126._minTween then
        return
      else
        v126._minTween = true

        if v209 and v209() then
          v208()
        end

        if v229 and v229() then
          f11()
        end

        if v235 and v235() then
          f12()
        end

        if bodyVideo and v184 and v184.Visible then
          pcall(function()
            bodyVideo.Playing = false
            bodyVideo:Pause()
          end)
        end

        if v196 then
          v196.Visible = false
        end

        if v197 then
          v197.Visible = false
        end

        v194.Image = "rbxassetid://124967485209478"
        v182.ClipsDescendants = true
        f21()
        local scale7 = v166 and v166.Scale > 0 and v166.Scale or 1
        local udim13 = UDim2.new(0, 240, 0, 34)

        v4:Tween(v182, {
          Position = UDim2.fromOffset(
            v182.Position.X.Offset - 135 * scale7, v182.Position.Y.Offset - 148 * scale7
          ),
          Size = udim13,
        }, 0.22, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, function()
          if TabContainer then
            TabContainer.Visible = false
          end

          if MainContainer then
            MainContainer.Visible = false
          end

          v409 = true
          v126._minTween = false
        end)

        task.delay(0.26, function()
          if v126._minTween then
            if TabContainer then
              TabContainer.Visible = false
            end

            if MainContainer then
              MainContainer.Visible = false
            end

            v409 = true
            v126._minTween = false
          end
        end)

        return
      end
    end

    function f21()
      local anchorPoint = v182.AnchorPoint
      local absolutePosition6 = v182.AbsolutePosition
      local absoluteSize2 = v182.AbsoluteSize

      v182.Position = UDim2.fromOffset(
        absolutePosition6.X + absoluteSize2.X * anchorPoint.X,
        absolutePosition6.Y + absoluteSize2.Y * anchorPoint.Y
      )
    end

    v194.MouseButton1Click:Connect(function()
      if v409 then
        f22()
      else
        f23()
      end
    end)

    local v410 = create2("Frame", {
      Name = "BlurOverlay",
      BackgroundColor3 = Color3.fromRGB(8, 6, 12),
      BackgroundTransparency = 0.35,
      BorderSizePixel = 0,
      Size = UDim2.new(1, 0, 1, 0),
      Position = UDim2.new(0, 0, 0, 0),
      Visible = false,
      Active = true,
      ZIndex = 4000,
      Children = {
        create2("UICorner", { CornerRadius = UDim.new(0, 10) }),
        create2("TextButton", {
          Name = "ClickBlocker",
          BackgroundTransparency = 1,
          BorderSizePixel = 0,
          Size = UDim2.new(1, 0, 1, 0),
          Position = UDim2.new(0, 0, 0, 0),
          Text = "",
          AutoButtonColor = false,
          Active = true,
          ZIndex = 4000,
        }),
      },
    }, v182)

    local v411 = create2("Frame", {
      Name = "ComfirmDialog",
      BackgroundColor3 = Color3.fromRGB(18, 14, 26),
      BackgroundTransparency = 0.02,
      BorderSizePixel = 0,
      AnchorPoint = Vector2.new(0.5, 0.5),
      Position = UDim2.new(0.5, 0, 0.5, 0),
      Size = UDim2.new(0, 240, 0, 112),
      Visible = false,
      Active = true,
      ZIndex = 4001,
      ClipsDescendants = true,
      Children = { create2("UICorner", { CornerRadius = UDim.new(0, 10) }) },
    }, v410)

    create2("TextLabel", {
      Name = "DialogTitle",
      BackgroundTransparency = 1,
      AnchorPoint = Vector2.new(0.5, 0),
      Position = UDim2.new(0.5, 0, 0, 16),
      Size = UDim2.new(1, -24, 0, 18),
      Text = "Are you sure?",
      TextColor3 = Color3.fromRGB(250, 245, 255),
      Font = Enum.Font.GothamBold,
      TextSize = 13,
      TextXAlignment = Enum.TextXAlignment.Center,
      ZIndex = 4002,
    }, v411)

    create2("TextLabel", {
      Name = "DialogSubtitle",
      BackgroundTransparency = 1,
      AnchorPoint = Vector2.new(0.5, 0),
      Position = UDim2.new(0.5, 0, 0, 36),
      Size = UDim2.new(1, -24, 0, 16),
      Text = "Close and destroy interface?",
      TextColor3 = Color3.fromRGB(165, 150, 190),
      Font = Enum.Font.Gotham,
      TextSize = 10,
      TextXAlignment = Enum.TextXAlignment.Center,
      ZIndex = 4002,
    }, v411)

    local v412 = create2("TextButton", {
      BackgroundColor3 = Color3.fromRGB(225, 45, 75),
      BackgroundTransparency = 0.05,
      TextColor3 = Color3.fromRGB(255, 255, 255),
      AnchorPoint = Vector2.new(0, 1),
      Position = UDim2.new(0, 16, 1, -14),
      Size = UDim2.new(0, 96, 0, 28),
      Text = "Yes",
      Font = Enum.Font.GothamBold,
      TextSize = 11,
      AutoButtonColor = false,
      Active = true,
      ZIndex = 4002,
      Children = { create2("UICorner", { CornerRadius = UDim.new(0, 6) }) },
    }, v411)

    local v413 = create2("TextButton", {
      Name = "CancelButton",
      BackgroundColor3 = Color3.fromRGB(28, 22, 38),
      BackgroundTransparency = 0.05,
      TextColor3 = Color3.fromRGB(200, 190, 225),
      AnchorPoint = Vector2.new(1, 1),
      Position = UDim2.new(1, -16, 1, -14),
      Size = UDim2.new(0, 96, 0, 28),
      Text = "No",
      Font = Enum.Font.GothamBold,
      TextSize = 11,
      AutoButtonColor = false,
      Active = true,
      ZIndex = 4002,
      Children = { create2("UICorner", { CornerRadius = UDim.new(0, 6) }) },
    }, v411)

    v195.MouseButton1Click:Connect(function()
      if v409 then
        f22()
      end

      if v209 and v209() then
        v208()
      end

      if v229 and v229() then
        f11()
      end

      if v235 and v235() then
        f12()
      end

      v410.Visible = true
      v411.Visible = true
    end)

    v412.MouseButton1Click:Connect(function()
      v410.Visible = false
      v411.Visible = false
      p95:DestroyGui()
    end)

    v413.MouseButton1Click:Connect(function()
      v410.Visible = false
      v411.Visible = false
    end)
  end

  do
    userInputService.InputBegan:Connect(function(input10)
      if input10.UserInputType ~= Enum.UserInputType.Keyboard then
        return
      elseif input10.KeyCode == Enum.KeyCode.Unknown then
        return
      elseif v191 then
        rightControl = input10.KeyCode
        save:Save("_opt_UIKeybind", input10.KeyCode.Name)
        v191 = false

        if v268 then
          v268.Text = input10.KeyCode.Name
        end

        return
      else
        if userInputService:GetFocusedTextBox() then
          return
        end

        if input10.KeyCode == rightControl then
          f8()
        end

        return
      end
    end)

    v414 = true
    v126._togTween = false

    function f8(p185)
      local v415 = p185

      if v415 == nil then
        v415 = not v414
      end

      if v415 == v414 then
        return
      else
        v414 = v415
        v395.Visible = true
        v396.Visible = true

        local currentEffectiveScale = v126.CurrentEffectiveScale
            and v126.CurrentEffectiveScale > 0 and v126.CurrentEffectiveScale
          or v166 and v166.Scale > 0 and v166.Scale
          or v181 and v181 > 0 and v181
          or 1

        local get27 = save:Get("_opt_UITransparency", 0.05)
        v166.Scale = currentEffectiveScale

        v182.BackgroundTransparency = get27
        v182.Visible = v415

        if v415 then
          if bodyVideo and v184 and v184.Visible then
            pcall(function()
              bodyVideo.Playing = true
              bodyVideo:Play()
            end)
          end
        elseif bodyVideo and v184 and v184.Visible then
          pcall(function()
            bodyVideo.Playing = false
            bodyVideo:Pause()
          end)
        end

        v126._togTween = false
        return
      end
    end

    local v416 = 0
    local activated = v396.Activated

    local function f24()
      if v397.moved then
        return
      else
        local v417 = tick()

        if v417 - v416 < 0.22 then
          return
        end

        v416 = v417
        f8()
        return
      end
    end

    activated:Connect(f24)
    v396.MouseButton1Click:Connect(f24)
    v126.MakeDraggable = util.MakeDraggable
    util.MakeDraggable(v189, v182)

    local v418 = create2("Frame", {
      BackgroundTransparency = 1,
      BorderSizePixel = 0,
      Size = UDim2.new(1, 0, 0, 40),
      Position = UDim2.new(0, 0, 0, 36),
      ClipsDescendants = false,
    }, v182)

    v157 = create2("Frame", {
      Name = "SearchBarFrame",
      BackgroundColor3 = Color3.fromRGB(22, 17, 34),
      BackgroundTransparency = 0.4,
      BorderSizePixel = 0,
      Position = UDim2.new(0, 8, 0, 1),
      Size = UDim2.new(0, 126, 0, 22),
      ZIndex = 6,
      Children = { create2("UICorner", { CornerRadius = UDim.new(0, 6) }) },
    }, v418)

    create2("ImageLabel", {
      BackgroundTransparency = 1,
      Position = UDim2.new(0, 6, 0.5, -6),
      Size = UDim2.new(0, 12, 0, 12),
      Image = "rbxassetid://3926305904",
      ImageRectOffset = Vector2.new(964, 324),
      ImageRectSize = Vector2.new(36, 36),
      ImageColor3 = Color3.fromRGB(175, 140, 230),
      ZIndex = 7,
    }, v157)

    v419 = create2("TextBox", {
      Name = "SearchBox",
      BackgroundTransparency = 1,
      Position = UDim2.new(0, 21, 0, 0),
      Size = UDim2.new(1, -36, 1, 0),
      Font = Enum.Font.Gotham,
      PlaceholderText = "Search...",
      PlaceholderColor3 = Color3.fromRGB(135, 120, 165),
      Text = "",
      TextColor3 = Color3.fromRGB(235, 230, 250),
      TextSize = 10,
      TextXAlignment = Enum.TextXAlignment.Left,
      ClearTextOnFocus = false,
      ZIndex = 7,
    }, v157)

    v420 = create2("TextButton", {
      Name = "SearchClear",
      BackgroundTransparency = 1,
      AnchorPoint = Vector2.new(1, 0.5),
      Position = UDim2.new(1, -3, 0.5, 0),
      Size = UDim2.new(0, 14, 0, 14),
      Font = Enum.Font.GothamBold,
      Text = "×",
      TextColor3 = Color3.fromRGB(175, 145, 215),
      TextSize = 12,
      Visible = false,
      ZIndex = 8,
      AutoButtonColor = false,
    }, v157)

    v421 = create2("TextLabel", {
      Name = "SearchCount",
      BackgroundColor3 = Color3.fromRGB(110, 60, 190),
      BackgroundTransparency = 0.2,
      AnchorPoint = Vector2.new(1, 0),
      Position = UDim2.new(1, -2, 0, -6),
      Size = UDim2.new(0, 22, 0, 13),
      Font = Enum.Font.GothamBold,
      Text = "0",
      TextColor3 = Color3.fromRGB(240, 225, 255),
      TextSize = 9,
      Visible = false,
      ZIndex = 9,
      Children = { create2("UICorner", { CornerRadius = UDim.new(1, 0) }) },
    }, v157)

    v422 = create2("ScrollingFrame", {
      Active = true,
      BackgroundTransparency = 1,
      BorderSizePixel = 0,
      Position = UDim2.new(0, 140, 0, -3),
      Size = UDim2.new(1, -148, 0, 30),
      CanvasPosition = Vector2.new(0, 0),
      CanvasSize = UDim2.new(0, 0, 0, 0),
      ScrollBarThickness = 0,
      ScrollBarImageTransparency = 1,
      ScrollingDirection = Enum.ScrollingDirection.X,
      ElasticBehavior = Enum.ElasticBehavior.WhenScrollable,
      Children = { create2("UICorner", { CornerRadius = UDim.new(0, 7) }) },
    }, v418)
  end

  do
    local v423 = create2("UIListLayout", {
      FillDirection = Enum.FillDirection.Horizontal,
      VerticalAlignment = Enum.VerticalAlignment.Top,
      SortOrder = Enum.SortOrder.LayoutOrder,
      Padding = UDim.new(0, 5),
    }, v422)

    function v126.RefreshTabScrollCanvas()
      DebouncedFitScrollCanvas(v422, v423, "X", 4)
    end

    RegisterLayoutRefresh(function() FitScrollCanvas(v422, v423, "X", 4) end)
    v423:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(v126.RefreshTabScrollCanvas)

    v422:GetPropertyChangedSignal("AbsoluteSize"):Connect(v126.RefreshTabScrollCanvas)
    v422.ChildAdded:Connect(v126.RefreshTabScrollCanvas)

    v424 = create2("Folder", { Name = "Container" }, (create2("Frame", {
      BackgroundTransparency = 1,
      BorderSizePixel = 0,
      Size = UDim2.new(0, 590, 0, 400),
      Position = UDim2.new(0, 5, 0, 70),
    }, v182)))

    v425 = {}
    v156 = {}
    v426 = false
    local v427 = {}
    local v428

    function v126.ActivateScroll(p186, p187, p188, p189)
      if not p189 and v428 == p186 then
        return
      else
        local v429 = nil

        for index44, value58 in ipairs(v156) do
          if value58.scrollFrame == v428 then
            v429 = value58
            break
          end
        end

        if v429 and v429.tabButton ~= p187 then
          v429.tabButton.BackgroundTransparency = 1
          local tabTitle = v429.tabButton:FindFirstChild("TabTitle")

          if tabTitle then
            if not p189 then
              v4:Tween(
                tabTitle, { TextColor3 = Color3.fromRGB(145, 130, 175) }, 0.12,
                Enum.EasingStyle.Quad, Enum.EasingDirection.Out
              )
            else
              tabTitle.TextColor3 = Color3.fromRGB(145, 130, 175)
            end
          else
            v429.tabButton.TextColor3 = Color3.fromRGB(145, 130, 175)
          end

          local tabIcon = v429.tabButton:FindFirstChild("TabIcon")

          if tabIcon then
            if not p189 then
              v4:Tween(
                tabIcon, { ImageColor3 = Color3.fromRGB(150, 135, 180) }, 0.12,
                Enum.EasingStyle.Quad, Enum.EasingDirection.Out
              )
            else
              tabIcon.ImageColor3 = Color3.fromRGB(150, 135, 180)
            end
          end

          if v429.tabUnderline then
            v429.tabUnderline.Visible = false
            v429.tabUnderline.Size = UDim2.new(0, 0, 0, 2.5)
          end

          if v429.scrollFrame then
            v429.scrollFrame.Visible = false
          end
        end

        p187.BackgroundTransparency = 1
        local tabTitle2 = p187:FindFirstChild("TabTitle")

        if tabTitle2 then
          if not p189 then
            v4:Tween(
              tabTitle2, { TextColor3 = Color3.fromRGB(255, 255, 255) }, 0.12,
              Enum.EasingStyle.Quad, Enum.EasingDirection.Out
            )
          else
            tabTitle2.TextColor3 = Color3.fromRGB(255, 255, 255)
          end
        else
          p187.TextColor3 = Color3.fromRGB(255, 255, 255)
        end

        local tabIcon2 = p187:FindFirstChild("TabIcon")

        if tabIcon2 then
          if not p189 then
            v4:Tween(
              tabIcon2, { ImageColor3 = Color3.fromRGB(255, 255, 255) }, 0.12,
              Enum.EasingStyle.Quad, Enum.EasingDirection.Out
            )
          else
            tabIcon2.ImageColor3 = Color3.fromRGB(255, 255, 255)
          end
        end

        if p188 then
          p188.Visible = true

          if not p189 then
            p188.Size = UDim2.new(0, 0, 0, 2.5)

            v4:Tween(
              p188, { Size = UDim2.new(0.85, 0, 0, 2.5) }, 0.14, Enum.EasingStyle.Quad,
              Enum.EasingDirection.Out
            )
          else
            p188.Size = UDim2.new(0.85, 0, 0, 2.5)
          end
        end

        p186.Position = UDim2.new(0, 0, 0, 0)
        p186.Visible = true

        pcall(function()
          if v422 and p187 then
            local x3 = v422.AbsolutePosition.X
            local x4 = v422.AbsoluteSize.X
            local x5 = p187.AbsolutePosition.X
            local x6 = p187.AbsoluteSize.X
            local x7 = v422.CanvasPosition.X

            if x5 < x3 then
              v4:Tween(
                v422, { CanvasPosition = Vector2.new(math.max(0, x7 - (x3 - x5) - 10), 0) },
                0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out
              )
            elseif x5 + x6 > x3 + x4 then
              v4:Tween(
                v422, { CanvasPosition = Vector2.new(x7 + (x5 + x6 - (x3 + x4)) + 10, 0) },
                0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out
              )
            end
          end
        end)

        v428 = p186
        return
      end
    end

    function v126.RefreshSectionVisibility()
      local v430 = {}
      local v431 = {}

      for index45, value59 in ipairs(v425) do
        if not v431[value59.sectionScroll] then
          v431[value59.sectionScroll] = true
          table.insert(v430, value59.sectionScroll)
        end
      end

      for index46, value60 in ipairs(v430) do
        local visible = false

        for index47, value61 in ipairs(value60:GetChildren()) do
          if value61.Name == "Section" then
            local v432 = false

            for index48, value62 in ipairs(v425) do
              if value62.sectionScroll == value60 and value62.sectionFrame == value61
                and value62.elementFrame.Visible then
                v432 = true
                break
              end
            end

            value61.Visible = v432

            if v432 then
              visible = true
            end
          end
        end

        value60.Visible = visible
      end

      local v433 = {}
      local v434 = {}

      for index49, value63 in ipairs(v425) do
        if not v434[value63.scrollFrame] then
          v434[value63.scrollFrame] = true
          v433[value63.scrollFrame] = {}
        end
      end

      for index50, value64 in ipairs(v425) do
        local v435 = v433[value64.scrollFrame]
        local v436 = false

        for index51, value65 in ipairs(v435) do
          if value65 == value64.sectionScroll then
            v436 = true
            break
          end
        end

        if not v436 then
          table.insert(v435, value64.sectionScroll)
        end
      end

      for key21, value66 in pairs(v433) do
        for index52, value67 in ipairs(value66) do
          if value67.Visible then
            value67.Size = UDim2.new(0, 240, 0, 260)
          end
        end
      end
    end

    local v437 = create2("Frame", {
      Name = "SearchHistoryFrame",
      BackgroundColor3 = Color3.fromRGB(16, 12, 24),
      BackgroundTransparency = 0.08,
      Position = UDim2.new(0, 8, 0, 26),
      Size = UDim2.new(0, 220, 0, 0),
      Visible = false,
      ZIndex = 50,
      ClipsDescendants = true,
      Children = {
        create2("UICorner", { CornerRadius = UDim.new(0, 8) }),
        create2("UIListLayout", {
          SortOrder = Enum.SortOrder.LayoutOrder,
          Padding = UDim.new(0, 2),
        }),
        create2("UIPadding", {
          PaddingTop = UDim.new(0, 6),
          PaddingBottom = UDim.new(0, 6),
          PaddingLeft = UDim.new(0, 6),
          PaddingRight = UDim.new(0, 6),
        }),
      },
    }, v182)

    local v438 = create2("ScrollingFrame", {
      Name = "SearchTreeScroll",
      BackgroundTransparency = 1,
      BorderSizePixel = 0,
      Size = UDim2.new(1, -8, 0, 0),
      CanvasSize = UDim2.new(0, 0, 0, 0),
      ScrollBarThickness = 0,
      ScrollBarImageTransparency = 1,
      ZIndex = 51,
      Visible = false,
      AutomaticCanvasSize = Enum.AutomaticSize.None,
      ElasticBehavior = Enum.ElasticBehavior.WhenScrollable,
      ScrollingEnabled = true,
      Children = {
        create2("UIListLayout", {
          SortOrder = Enum.SortOrder.LayoutOrder,
          Padding = UDim.new(0, 2),
        }),
      },
    }, v437)

    local function f25()
      v437.Visible = false
      v437.Size = UDim2.new(0, 220, 0, 0)

      v438.Visible = false
      v438.Size = UDim2.new(1, -8, 0, 0)
      v438.CanvasSize = UDim2.new(0, 0, 0, 0)
    end

    function v126.fuzzyMatch(p190, p191)
      local v439 = 1
      local v440 = 1
      local lower = p190:lower()
      local lower2 = p191:lower()

      while v439 <= #lower2 and v440 <= #lower do
        if lower2:sub(v439, v439) == lower:sub(v440, v440) then
          v439 = v439 + 1
        end

        v440 = v440 + 1
      end

      return v439 > #lower2
    end

    function v126.SplitWords(p192)
      local v441 = {}

      for match3 in string.gmatch(string.lower(p192), "%S+") do
        table.insert(v441, match3)
      end

      return v441
    end

    function v126.ScoreSearchEntry(p193, p194)
      local lower3 = p194:lower()
      local lower4 = (p193.title or ""):lower()
      local lower5 = (p193.menuTitle or ""):lower()
      local lower6 = (p193.tabTitle or ""):lower()
      local v442 = lower6 .. " " .. lower5 .. " " .. lower4
      local v443 = 0

      if lower4 == lower3 then
        return 200
      else
        if lower4:sub(1, #lower3) == lower3 then
          v443 = math.max(v443, 160)
        end

        if lower4:find(lower3, 1, true) then
          v443 = math.max(v443, 120)
        end

        if lower5:find(lower3, 1, true) then
          v443 = math.max(v443, 90)
        end

        if lower6:find(lower3, 1, true) then
          v443 = math.max(v443, 70)
        end

        local v444 = v126.SplitWords(lower3)

        if #v444 > 1 then
          local v445 = true
          local total = 0

          for index53, value68 in ipairs(v444) do
            if v442:find(value68, 1, true) then
              total = total + 25
            else
              v445 = false
            end
          end

          if v445 then
            v443 = math.max(v443, 100 + total)
          end
        end

        if v126.fuzzyMatch(lower4, p194) then
          v443 = math.max(v443, 45)
        end

        if v126.fuzzyMatch(v442, p194) then
          v443 = math.max(v443, 35)
        end

        return v443
      end
    end

    local get28 = save:Get("_opt_SearchHistory", {})

    function v126.SaveSearchToHistory(p195)
      local gsub7 = p195:gsub("^%s+", ""):gsub("%s+$", "")

      if gsub7 == "" or #gsub7 < 2 then
        return
      end

      for m = #get28, 1, -1 do
        if get28[m] == gsub7 then
          table.remove(get28, m)
        end
      end

      table.insert(get28, 1, gsub7)

      if #get28 > 8 then
        table.remove(get28, 9)
      end

      save:Save("_opt_SearchHistory", get28)
    end

    function v126.NavigateToSearchEntry(p196)
      if not p196 then
        return
      end

      for index54, value69 in ipairs(v156) do
        if value69.scrollFrame == p196.scrollFrame then
          v126.ActivateScroll(
            value69.scrollFrame, value69.tabButton, value69.tabUnderline, true
          )

          break
        end
      end

      p196.elementFrame.Visible = true
      p196.sectionFrame.Visible = true
      p196.sectionScroll.Visible = true

      v126.RefreshSectionVisibility()

      task.defer(function()
        local elementFrame = p196.elementFrame
        local sectionScroll = p196.sectionScroll

        if not (elementFrame and elementFrame.Parent and sectionScroll and sectionScroll.Parent) then
          return
        end

        v4:Tween(sectionScroll, {
          CanvasPosition = Vector2.new(0, (math.max(0, elementFrame.AbsolutePosition.Y
                - sectionScroll.AbsolutePosition.Y
              + sectionScroll.CanvasPosition.Y
            - 40))),
        }, 0.28, Enum.EasingStyle.Quint)

        local v446 = create2("Frame", {
          BackgroundColor3 = ThemeColor("Accent") or Color3.fromRGB(180, 120, 255),
          BackgroundTransparency = 0.35,
          BorderSizePixel = 0,
          Size = UDim2.new(1, 0, 1, 0),
          ZIndex = 50,
          Children = { create2("UICorner", { CornerRadius = UDim.new(0, 6) }) },
        }, elementFrame)

        v4:Tween(v446, { BackgroundTransparency = 1 }, 0.65, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, function()
          if v446 then
            v446:Destroy()
          end
        end)

        local uiStroke7 = elementFrame:FindFirstChildOfClass("UIStroke")
        local transparency

        if not uiStroke7 then
          uiStroke7 = create2("UIStroke", {
            Color = ThemeColor("Accent") or Color3.fromRGB(180, 120, 255),
            Transparency = 0.2,
            Thickness = 1.5,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
          }, elementFrame)

          task.delay(0.8, function()
            if uiStroke7 and uiStroke7.Parent then
              uiStroke7:Destroy()
            end
          end)
        else
          transparency = uiStroke7.Transparency
          uiStroke7.Transparency = 0.15

          task.delay(0.8, function()
            if uiStroke7 and uiStroke7.Parent then
              uiStroke7.Transparency = transparency
            end
          end)
        end
      end)
    end

    function v126.UpdateSearchTreeUI(p197, p198)
      for index55, value70 in ipairs(v438:GetChildren()) do
        if value70:IsA("GuiObject") then
          value70:Destroy()
        end
      end

      local count4 = 0
      local v447 = 0

      if p198 == "" or not p197 or #p197 == 0 then
        v438.Visible = false
        v438.Size = UDim2.new(1, -8, 0, 0)
        v438.CanvasSize = UDim2.new(0, 0, 0, 0)

        return 0
      else
        local v448 = {}

        for index56, value71 in ipairs(p197) do
          local tabTitle3 = value71.tabTitle or "Tab"
          v448[tabTitle3] = v448[tabTitle3] or {}
          local v449 = v448[tabTitle3]
          local menuTitle = value71.menuTitle or "Section"
          v449[menuTitle] = v448[tabTitle3][menuTitle] or {}
          table.insert(v448[tabTitle3][menuTitle], value71)
        end

        for key22, value72 in pairs(v448) do
          count4 = count4 + 1
          v447 = v447 + 16 + 2

          create2("TextLabel", {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 16),
            Font = Enum.Font.GothamBold,
            Text = "" .. key22,
            TextColor3 = Color3.fromRGB(65, 220, 110),
            TextSize = 10,
            TextXAlignment = Enum.TextXAlignment.Left,
            LayoutOrder = count4,
            ZIndex = 10001,
          }, v438)

          for key23, value73 in pairs(value72) do
            count4 = count4 + 1
            v447 = v447 + 14 + 2

            create2("TextLabel", {
              BackgroundTransparency = 1,
              Size = UDim2.new(1, -8, 0, 14),
              Font = Enum.Font.GothamSemibold,
              Text = "  └ " .. key23,
              TextColor3 = Color3.fromRGB(160, 130, 200),
              TextSize = 9,
              TextXAlignment = Enum.TextXAlignment.Left,
              LayoutOrder = count4,
              ZIndex = 10001,
            }, v438)

            for index57, value74 in ipairs(value73) do
              local v450 = value74
              count4 = count4 + 1
              v447 = v447 + 20 + 2

              create2("TextButton", {
                BackgroundColor3 = Color3.fromRGB(22, 20, 28),
                BackgroundTransparency = 0.35,
                Size = UDim2.new(1, -12, 0, 20),
                Font = Enum.Font.Gotham,
                Text = "      • " .. (v450.title or ""),
                TextColor3 = Color3.fromRGB(210, 195, 230),
                TextSize = 9,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextTruncate = Enum.TextTruncate.AtEnd,
                LayoutOrder = count4,
                ZIndex = 10001,
                Children = { create2("UICorner", { CornerRadius = UDim.new(0, 4) }) },
              }, v438).MouseButton1Click:Connect(function()
                v126.NavigateToSearchEntry(v450)
                f25()
              end)
            end
          end
        end

        if count4 <= 0 or v447 <= 0 then
          v438.Visible = false
          v438.Size = UDim2.new(1, -8, 0, 0)
          v438.CanvasSize = UDim2.new(0, 0, 0, 0)
          v438.ScrollingEnabled = false

          return 0
        else
          local v451 = v447 > math.max(UnscaledLayout(v438.AbsoluteSize.Y), 1) + 1

          v438.CanvasSize = UDim2.new(0, 0, 0, v451 and v447 or 0)
          v438.ScrollingEnabled = v451
          v438.ElasticBehavior = Enum.ElasticBehavior.Never
          v438.Visible = true

          return v447
        end
      end
    end

    function v126.UpdateHistoryUI(p199)
      for index58, value75 in ipairs(v437:GetChildren()) do
        if value75:IsA("TextButton") or value75:IsA("TextLabel") then
          if value75.Name ~= "SearchTreeScroll" and value75 ~= v438 then
            value75:Destroy()
          end
        end
      end

      local v452

      if p199 then
        local offset3 = 0

        if v438.Visible then
          offset3 = v438.CanvasSize.Y.Offset
        end

        if offset3 <= 0 then
          f25()
          return
        end

        local v453 = math.min(offset3, 180)
        v438.Size = UDim2.new(1, -8, 0, v453)
        v452 = v453 + 12

        if v452 <= 0 then
          f25()
          return
        end

        v437.Size = UDim2.new(0, 220, 0, v452)
        v437.Visible = true

        return
      end

      v438.Visible = false
      v438.Size = UDim2.new(1, -8, 0, 0)

      if #get28 <= 0 then
        f25()
        return
      end

      create2("TextLabel", {
        Name = "HistoryHeader",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 14),
        Font = Enum.Font.GothamBold,
        Text = "Recent",
        TextColor3 = Color3.fromRGB(75, 180, 100),
        TextSize = 9,
        TextXAlignment = Enum.TextXAlignment.Left,
        LayoutOrder = 1,
        ZIndex = 10000,
      }, v437)

      for index59, value76 in ipairs(get28) do
        local v454 = value76

        create2("TextButton", {
          BackgroundColor3 = Color3.fromRGB(22, 20, 28),
          BackgroundTransparency = 0.5,
          Size = UDim2.new(1, 0, 0, 20),
          Font = Enum.Font.Gotham,
          Text = "  " .. v454,
          TextColor3 = Color3.fromRGB(180, 160, 200),
          TextSize = 10,
          TextXAlignment = Enum.TextXAlignment.Left,
          LayoutOrder = index59 + 1,
          ZIndex = 10000,
          Children = { create2("UICorner", { CornerRadius = UDim.new(0, 4) }) },
        }, v437).MouseButton1Click:Connect(function()
          v419.Text = v454
          DoSearch(v454)
          f25()
        end)
      end

      v452 = (#get28 + 1) * 22 + 12

      if v452 <= 0 then
        f25()
        return
      end

      v437.Size = UDim2.new(0, 220, 0, v452)
      v437.Visible = true
    end

    local v455

    function DoSearch(p200)
      local gsub8 = p200:lower():gsub("^%s+", ""):gsub("%s+$", "")
      v420.Visible = gsub8 ~= ""

      if gsub8 == "" then
        v426 = false
        v427 = {}
        v421.Visible = false
        v126.UpdateSearchTreeUI({}, "")
        f25()

        for index60, value77 in ipairs(v425) do
          value77.elementFrame.Visible = true
          value77.sectionFrame.Visible = true
          value77.sectionScroll.Visible = true
          value77.sectionScroll.Size = UDim2.new(0, 240, 0, 260)
        end

        for index61, value78 in ipairs(v156) do
          value78.tabButton.Visible = true
        end

        if v455 then
          for index62, value79 in ipairs(v156) do
            if value79.scrollFrame == v455 then
              v126.ActivateScroll(
                value79.scrollFrame, value79.tabButton, value79.tabUnderline, true
              )

              break
            end
          end

          v455 = nil
        elseif #v156 > 0 then
          local v456 = v156[1]
          v126.ActivateScroll(v456.scrollFrame, v456.tabButton, v456.tabUnderline)
        end

        return
      else
        if not v426 then
          v426 = true
          v455 = v428
        end

        for index63, value80 in ipairs(v425) do
          value80.elementFrame.Visible = false
        end

        for index64, value81 in ipairs(v156) do
          value81.tabButton.Visible = false
          value81.scrollFrame.Visible = false
          value81.tabButton.TextColor3 = Color3.fromRGB(200, 200, 200)

          local tabTitle4 = value81.tabButton:FindFirstChild("TabTitle")

          if tabTitle4 then
            tabTitle4.TextColor3 = Color3.fromRGB(200, 200, 200)
          end

          value81.tabUnderline.Visible = false
        end

        local v457 = {}
        local v458 = {}
        local v459 = {}

        for index65, value82 in ipairs(v425) do
          local v460 = v126.ScoreSearchEntry(value82, gsub8)

          if v460 > 0 then
            table.insert(v458, { entry = value82, score = v460 })
          end
        end

        table.sort(v458, function(p201, p202) return p201.score > p202.score end)
        v427 = {}

        for index66, value83 in ipairs(v458) do
          local entry = value83.entry
          table.insert(v427, entry)
          entry.elementFrame.Visible = true

          if not v457[entry.scrollFrame] then
            v457[entry.scrollFrame] = true
            table.insert(v459, entry.scrollFrame)
          end

          for index67, value84 in ipairs(v156) do
            if value84.scrollFrame == entry.scrollFrame then
              value84.tabButton.Visible = true
              break
            end
          end
        end

        local v461 = #v427

        v421.Visible = v461 > 0
        v421.Text = tostring(v461)
        v421.Size = UDim2.new(0, math.max(22, #tostring(v461) * 8 + 10), 0, 14)

        if v126.UpdateSearchTreeUI(v427, gsub8) <= 0 then
          f25()
        else
          v126.UpdateHistoryUI(true)
        end

        if #v459 == 0 then
          return
        end

        v126.RefreshSectionVisibility()

        for index68, value85 in ipairs(v156) do
          if value85.scrollFrame == v459[1] then
            v126.ActivateScroll(
              value85.scrollFrame, value85.tabButton, value85.tabUnderline, true
            )

            break
          end
        end

        return
      end
    end

    local count5 = 0

    v419:GetPropertyChangedSignal("Text"):Connect(function()
      local text12 = v419.Text
      v420.Visible = text12 ~= ""
      count5 = count5 + 1
      local v462 = count5

      task.delay(0.08, function()
        if v462 ~= count5 then
          return
        end

        DoSearch(text12)

        if text12 == "" then
          f25()
        end
      end)
    end)

    v420.MouseButton1Click:Connect(function()
      v419.Text = ""
      DoSearch("")
      f25()
      v419:CaptureFocus()
    end)

    v419.Focused:Connect(function()
      v4:Tween(v157, { BackgroundTransparency = 0.2 }, 0.15)
      local gsub9 = v419.Text:gsub("^%s+", ""):gsub("%s+$", "")

      if gsub9 ~= "" and #v427 > 0 then
        v126.UpdateSearchTreeUI(v427, gsub9)
        v126.UpdateHistoryUI(true)
      elseif gsub9 == "" and #get28 > 0 then
        v126.UpdateHistoryUI(false)
      else
        f25()
      end
    end)

    v419.FocusLost:Connect(function(p203)
      v4:Tween(v157, { BackgroundTransparency = 0.4 }, 0.2)

      if p203 then
        v126.SaveSearchToHistory(v419.Text)
      end

      task.delay(0.25, function()
        if not v419:IsFocused() then
          f25()
        end
      end)
    end)

    v463 = {}
    local v464 = true

    function v463:AddTab(p204, p205, p206)
      local condition = p206
      local name7 = p204
      local icon = p205

      if type(name7) == "table" then
        local v465 = name7
        name7 = v465.Name or v465.Title or v465[1] or "Tab"
        icon = v465.Icon or v465[2] or icon
        condition = v465.Condition or condition
      end

      local v466, v467, tabTitle5, tabIcon3, v468, v469, v470, general, f26

      if not checkCondition(condition) then
        return v146
      else
        v466 = nil

        v467 = create2("TextButton", {
          BackgroundColor3 = Color3.fromRGB(20, 16, 28),
          BackgroundTransparency = 1,
          BorderSizePixel = 0,
          AutoButtonColor = false,
          Font = Enum.Font.FredokaOne,
          TextColor3 = Color3.fromRGB(145, 130, 175),
          TextSize = 14,
          TextXAlignment = Enum.TextXAlignment.Right,
          Text = "",
          ClipsDescendants = false,
          Children = {
            create2("UICorner", { CornerRadius = UDim.new(0, 6) }),
            create2("ImageLabel", {
              Name = "TabIcon",
              BackgroundTransparency = 1,
              AnchorPoint = Vector2.new(0, 0.5),
              Size = UDim2.new(0, 16, 0, 16),
              Position = UDim2.new(0, 5, 0.5, 0),
              Image = ({
                ["cat-quantum"] = "rbxassetid://82115431450716",
                ["home-quantum"] = "rbxassetid://130439434919073",
                ["swords-quantum"] = "rbxassetid://88173691221304",
                ["rabbit-quantum"] = "rbxassetid://138575837887336",
                ["ship-quantum"] = "rbxassetid://115481449706054",
                ["visual-quantum"] = "rbxassetid://102173201308116",
                ["info-quantum"] = "rbxassetid://88050097561287",
                ["misc-quantum"] = "rbxassetid://137985950260873",
                ["cart-quantum"] = "rbxassetid://137995400175306",
                ["cherry-quantum"] = "rbxassetid://122029349593217",
                ["map-quantum"] = "rbxassetid://125480398387209",
                ["raid-quantum"] = "rbxassetid://104575804564229",
                ["user-quantum"] = "rbxassetid://83474083071373",
                ["settings-quantum"] = "rbxassetid://81151604784579",
                ["bio-quantum"] = "rbxassetid://132316362727024",
                ["craft-quantum"] = "rbxassetid://118197342073112",
              })[icon] or "",
              ImageColor3 = Color3.fromRGB(150, 135, 180),
              ScaleType = Enum.ScaleType.Fit,
            }),
            create2("TextLabel", {
              Name = "TabTitle",
              BackgroundTransparency = 1,
              Font = Enum.Font.FredokaOne,
              TextColor3 = Color3.fromRGB(145, 130, 175),
              TextSize = 14,
              TextXAlignment = Enum.TextXAlignment.Left,
              Text = name7,
              AnchorPoint = Vector2.new(0, 0.5),
              Position = UDim2.new(0, 24, 0.5, 0),
              Size = UDim2.new(0, 0, 1, 0),
            }),
          },
        }, nil)

        tabTitle5 = v467:FindFirstChild("TabTitle")
        tabIcon3 = v467:FindFirstChild("TabIcon")

        v467.MouseEnter:Connect(function()
          if v428 ~= v466 then
            if tabTitle5 then
              v4:Tween(
                tabTitle5, { TextColor3 = Color3.fromRGB(215, 200, 245) }, 0.12,
                Enum.EasingStyle.Quad, Enum.EasingDirection.Out
              )
            end

            if tabIcon3 then
              v4:Tween(
                tabIcon3, { ImageColor3 = Color3.fromRGB(205, 190, 235) }, 0.12,
                Enum.EasingStyle.Quad, Enum.EasingDirection.Out
              )
            end
          end
        end)

        v467.MouseLeave:Connect(function()
          if v428 ~= v466 then
            if tabTitle5 then
              v4:Tween(
                tabTitle5, { TextColor3 = Color3.fromRGB(145, 130, 175) }, 0.12,
                Enum.EasingStyle.Quad, Enum.EasingDirection.Out
              )
            end

            if tabIcon3 then
              v4:Tween(
                tabIcon3, { ImageColor3 = Color3.fromRGB(150, 135, 180) }, 0.12,
                Enum.EasingStyle.Quad, Enum.EasingDirection.Out
              )
            end
          end
        end)

        local function f27()
          local x8 = textService:GetTextSize(
            name7, 14, Enum.Font.FredokaOne, Vector2.new(4096, 24)
          ).X

          v467.Size = UDim2.new(0, 34 + x8, 0, 24)

          if tabTitle5 then
            tabTitle5.Size = UDim2.new(0, x8 + 4, 1, 0)
          end
        end

        RegisterLayoutRefresh(f27)
        f27()

        v468 = create2("Frame", {
          Name = "Tab_Underline",
          BackgroundColor3 = Color3.fromRGB(110, 55, 190),
          BorderSizePixel = 0,
          AnchorPoint = Vector2.new(0.5, 0),
          Size = UDim2.new(0.5, 0, 0, 3),
          Position = UDim2.new(0.5, 0, 1, 1),
          Visible = false,
          Children = {
            create2("UICorner", { CornerRadius = UDim.new(1, 0) }),
            create2("UIGradient", {
              Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(160, 100, 255)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(90, 40, 180)),
              }),
              Rotation = 0,
            }),
          },
        }, v467)

        v467.Parent = v422

        v466 = create2("ScrollingFrame", {
          Name = "ScrollingFrame",
          BackgroundTransparency = 1,
          BorderSizePixel = 0,
          Position = UDim2.new(0, 0, 0, 0),
          Size = UDim2.new(1, 0, 1, 0),
          CanvasSize = UDim2.new(0, 0, 0, 0),
          ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0),
          ScrollBarThickness = 0,
          ScrollBarImageTransparency = 1,
          ScrollingDirection = Enum.ScrollingDirection.X,
          ElasticBehavior = Enum.ElasticBehavior.Never,
          ScrollingEnabled = false,
          Visible = false,
          ClipsDescendants = true,
        }, v424)

        v469 = create2("UIListLayout", {
          Name = "Scrolling_Layout",
          FillDirection = Enum.FillDirection.Horizontal,
          SortOrder = Enum.SortOrder.LayoutOrder,
          Padding = UDim.new(0, 19),
        }, v466)

        local function f28()
          DebouncedFitScrollCanvas(v466, v469, "X", 4)
        end

        RegisterLayoutRefresh(function() FitScrollCanvas(v466, v469, "X", 4) end)
        v469:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(f28)

        v466:GetPropertyChangedSignal("AbsoluteSize"):Connect(f28)
        v466.ChildAdded:Connect(f28)
        v466.ChildRemoved:Connect(f28)

        table.insert(v156, { tabButton = v467, tabUnderline = v468, scrollFrame = v466 })

        if v464 then
          v464 = false
          v126.ActivateScroll(v466, v467, v468, true)
        end

        v467.MouseButton1Click:Connect(function()
          if v426 then
            v126.ActivateScroll(v466, v467, v468)
            v126.RefreshSectionVisibility()
          else
            if v419.Text ~= "" then
              v419.Text = ""
            end

            v126.ActivateScroll(v466, v467, v468)
          end
        end)

        v470 = {}

        function v470:addSection(p207)
          local v471

          if not checkCondition(p207) then
            return v146
          else
            v471 = create2("ScrollingFrame", {
              Name = "SectionScroll",
              BackgroundTransparency = 1,
              BorderSizePixel = 0,
              Size = UDim2.new(0, 240, 0, 260),
              ScrollBarThickness = 0,
              ScrollBarImageTransparency = 1,
              CanvasSize = UDim2.new(0, 0, 0, 0),
              Active = true,
              ClipsDescendants = true,
              ScrollingDirection = Enum.ScrollingDirection.Y,
              AutomaticCanvasSize = Enum.AutomaticSize.Y,
              ElasticBehavior = Enum.ElasticBehavior.WhenScrollable,
              ScrollingEnabled = true,
              Children = { create2("UICorner", { CornerRadius = UDim.new(1, 0) }) },
            }, v466)

            local udim14 = UDim.new(0, 7)

            local v472 = create2("UIListLayout", {
              HorizontalAlignment = Enum.HorizontalAlignment.Center,
              SortOrder = Enum.SortOrder.LayoutOrder,
              Padding = udim14,
            }, v471)

            local function f29()
              DebouncedFitScrollCanvas(v471, v472, "Y", 4)
            end

            RegisterLayoutRefresh(function() FitScrollCanvas(v471, v472, "Y", 4) end)
            v472:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(f29)

            v471:GetPropertyChangedSignal("AbsoluteSize"):Connect(f29)
            v471.ChildAdded:Connect(f29)
            v471.ChildRemoved:Connect(f29)

            local v473 = {}

            function v473:addMenu(p208, p209)
              local v474, v475, v476, f30, v477

              if not checkCondition(p209) then
                return v146
              else
                v474 = create2("Frame", {
                  Name = "Section",
                  BackgroundTransparency = 1,
                  BorderSizePixel = 0,
                  Size = UDim2.new(0.48, 0, 0, 20),
                  ClipsDescendants = false,
                }, v471)

                v475 = create2("Frame", {
                  Name = "InnerSection",
                  BackgroundColor3 = Color3.fromRGB(25, 25, 25),
                  BackgroundTransparency = 0.3,
                  BorderSizePixel = 0,
                  Position = UDim2.new(0, 5, 0, 0),
                  Size = UDim2.new(1, -5, 0, 25),
                  Children = { create2("UICorner", { CornerRadius = UDim.new(0, 6) }) },
                }, v474)

                v476 = create2("UIListLayout", {
                  HorizontalAlignment = Enum.HorizontalAlignment.Center,
                  SortOrder = Enum.SortOrder.LayoutOrder,
                  Padding = UDim.new(0, 3),
                }, v475)

                local v478 = create2("Frame", {
                  BackgroundTransparency = 1,
                  Size = UDim2.new(1, 0, 0, 22),
                  Children = {
                    create2("TextLabel", {
                      BackgroundTransparency = 1,
                      BorderSizePixel = 0,
                      Size = UDim2.new(0.6, 0, 1, 0),
                      Position = UDim2.new(0.2, 0, 0, 0),
                      Font = Enum.Font.FredokaOne,
                      Text = p208,
                      TextColor3 = Color3.fromRGB(255, 255, 255),
                      TextSize = 15,
                      TextTruncate = Enum.TextTruncate.AtEnd,
                      TextXAlignment = Enum.TextXAlignment.Center,
                      ZIndex = 3,
                    }),
                  },
                }, v475)

                local v479 = create2("UIGradient", { Color = ThemeColor("Lit"), Rotation = 60 })
                local v480 = create2("UIGradient", { Color = ThemeColor("Lit"), Rotation = 60 })

                RegisterLitGradient(v479)
                RegisterLitGradient(v480)

                local v481 = create2("Frame", {
                  BackgroundColor3 = ThemeColor("Accent") or Color3.fromRGB(150, 100, 255),
                  BorderSizePixel = 0,
                  Size = UDim2.new(0.2, 0, 0, 10),
                  Position = UDim2.new(0, 0, 0.5, -1),
                  ZIndex = 2,
                  Children = { create2("UICorner", { CornerRadius = UDim.new(0.5) }), v479 },
                }, v478)

                local v482 = create2("Frame", {
                  BackgroundColor3 = ThemeColor("Accent") or Color3.fromRGB(150, 100, 255),
                  BorderSizePixel = 0,
                  Size = UDim2.new(0.2, 0, 0, 10),
                  Position = UDim2.new(0.8, 0, 0.5, -1),
                  ZIndex = 2,
                  Children = { create2("UICorner", { CornerRadius = UDim.new(0.5) }), v480 },
                }, v478)

                RegisterThemeElement(v481, "BackgroundColor3", "Accent")
                RegisterThemeElement(v482, "BackgroundColor3", "Accent")

                local function f31()
                  local v483 = math.max(UnscaledLayout(v476.AbsoluteContentSize.Y) + 4, 22)
                  v474.Size = UDim2.new(1, 0, 0, v483)
                  v475.Size = UDim2.new(1, -10, 0, v483)
                end

                RegisterLayoutRefresh(f31)
                v476:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(f31)
                f31()

                function f30(p210, p211)
                  p210:SetAttribute("STX_SearchElement", true)

                  local v484 = {
                    tabButton = v467,
                    scrollFrame = v466,
                    sectionScroll = v471,
                    sectionFrame = v474,
                    elementFrame = p210,
                    tabTitle = name7,
                    menuTitle = p208,
                    title = p211 or "",
                    favKey = (name7 or "") .. "|" .. (p208 or "") .. "|" .. (p211 or ""),
                  }

                  table.insert(v425, v484)
                  v155.Entries[v484.favKey] = v484

                  local function f32()
                    for index69, value86 in ipairs(v155.List) do
                      if value86 == v484.favKey then
                        return true
                      end
                    end

                    return false
                  end

                  local function f33()
                    local list = v155.List
                    local v485

                    for index70, value87 in ipairs(list) do
                      if value87 == v484.favKey then
                        v485 = index70
                        break
                      end
                    end

                    if v485 then
                      table.remove(list, v485)

                      v3.Notification:Notify({
                        Title = "Favorites",
                        Description = "Removed " .. (v484.title or ""),
                      }, { Time = 2 })
                    else
                      table.insert(list, v484.favKey)

                      v3.Notification:Notify({
                        Title = "Favorites",
                        Description = "Pinned " .. (v484.title or ""),
                      }, { Time = 2 })
                    end

                    save:Save("_favorites", list)

                    if v155.Refresh then
                      v155.Refresh()
                    end

                    local v486 = create2("Frame", {
                      BackgroundColor3 = Color3.fromRGB(255, 200, 80),
                      BackgroundTransparency = 0.4,
                      Size = UDim2.new(1, 0, 1, 0),
                      ZIndex = 40,
                      Children = { create2("UICorner", { CornerRadius = UDim.new(0, 6) }) },
                    }, p210)

                    v4:Tween(v486, { BackgroundTransparency = 1 }, 0.4, Enum.EasingStyle.Quad, nil, function()
                      if v486 then
                        v486:Destroy()
                      end
                    end)
                  end

                  local function f34()
                    local favStar = p210:FindFirstChild("_FavStar")

                    if favStar then
                      favStar:Destroy()
                    end

                    local v487 = f32()

                    local v488 = create2("TextButton", {
                      Name = "_FavStar",
                      AnchorPoint = Vector2.new(1, 0.5),
                      BackgroundTransparency = 1,
                      BorderSizePixel = 0,
                      Position = UDim2.new(1, -6, 0.5, 0),
                      Size = UDim2.new(0, 22, 0, 22),
                      Font = Enum.Font.GothamBold,
                      Text = v487 and "★" or "☆",
                      TextColor3 = v487 and Color3.fromRGB(255, 210, 90)
                        or Color3.fromRGB(210, 180, 255),
                      TextSize = 16,
                      ZIndex = 60,
                      AutoButtonColor = false,
                    }, p210)

                    v488.MouseButton1Click:Connect(function()
                      f33()

                      if v488 and v488.Parent then
                        v488:Destroy()
                      end
                    end)

                    task.delay(3.5, function()
                      if v488 and v488.Parent then
                        v488:Destroy()
                      end
                    end)
                  end

                  local v489 = 0
                  local zero = Vector2.zero

                  p210.InputBegan:Connect(function(input11)
                    if input11.UserInputType == Enum.UserInputType.MouseButton2 then
                      f34()
                      return
                    end

                    if input11.UserInputType == Enum.UserInputType.Touch then
                      local v490 = os.clock()
                      local vector5 = Vector2.new(input11.Position.X, input11.Position.Y)

                      if v490 - v489 <= 0.35 and (vector5 - zero).Magnitude < 40 then
                        v489 = 0
                        f33()
                      else
                        v489 = v490
                        zero = vector5
                      end
                    end
                  end)
                end

                v477 = {}

                function v477:addButton(p212, p213, p214, p215, p216)
                  local v491 = p215
                  local callback = p213
                  local v492 = p214
                  local name8 = p212

                  if type(name8) == "table" then
                    local v493 = name8
                    name8 = v493.Name or v493.Title or v493.Text or "Button"
                    callback = v493.Callback or v493.Function or callback
                    local locked = v493.Locked or v492
                    local condition2 = v493.Condition
                    v492 = locked
                    v491 = condition2 or v491
                    local liteAllowed = v493.LiteAllowed
                  end

                  if not checkCondition(v491) then
                    return v146
                  end

                  callback = callback or function() end

                  local v494 = create2("TextButton", {
                    BackgroundColor3 = ThemeColor("Primary"),
                    BackgroundTransparency = 0.4,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, -25, 0, 32),
                    AutoButtonColor = false,
                    Text = "",
                    ClipsDescendants = true,
                    Children = {
                      create2("UICorner", { CornerRadius = UDim.new(0, 6) }),
                      create2("TextLabel", {
                        Name = "ButtonLabel",
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 12, 0, 0),
                        Size = UDim2.new(1, -36, 1, 0),
                        Font = Enum.Font.GothamBold,
                        Text = name8,
                        TextColor3 = Color3.fromRGB(210, 210, 220),
                        TextXAlignment = Enum.TextXAlignment.Left,
                        TextWrapped = false,
                        TextScaled = true,
                        TextTruncate = Enum.TextTruncate.AtEnd,
                        ZIndex = 3,
                        Children = { MakeTextConstraint(15, 8) },
                      }),
                      create2("TextLabel", {
                        Name = "Arrow",
                        BackgroundTransparency = 1,
                        AnchorPoint = Vector2.new(1, 0.5),
                        Position = UDim2.new(1, -12, 0.5, 0),
                        Size = UDim2.new(0, 14, 0, 14),
                        Font = Enum.Font.GothamBold,
                        Text = "›",
                        TextColor3 = Color3.fromRGB(65, 220, 110),
                        TextScaled = true,
                        ZIndex = 3,
                      }),
                    },
                  }, v475)

                  f30(v494, name8)
                  local arrow = v494:FindFirstChild("Arrow")
                  local buttonLabel = v494:FindFirstChild("ButtonLabel")
                  RegisterTranslatable(buttonLabel, name8)

                  v494.MouseEnter:Connect(function()
                    v4:Tween(
                      v494, { BackgroundTransparency = 0.24 }, 0.16, Enum.EasingStyle.Quart,
                      Enum.EasingDirection.Out
                    )

                    v4:Tween(
                      buttonLabel, { TextColor3 = Color3.fromRGB(242, 240, 252) }, 0.16,
                      Enum.EasingStyle.Quart, Enum.EasingDirection.Out
                    )

                    v4:Tween(arrow, {
                      Position = UDim2.new(1, -8, 0.5, 0),
                      TextColor3 = Color3.fromRGB(225, 195, 255),
                    }, 0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
                  end)

                  v494.MouseLeave:Connect(function()
                    v4:Tween(
                      v494, { BackgroundTransparency = 0.4 }, 0.22, Enum.EasingStyle.Quart,
                      Enum.EasingDirection.Out
                    )

                    v4:Tween(
                      buttonLabel, { TextColor3 = Color3.fromRGB(210, 210, 220) }, 0.22,
                      Enum.EasingStyle.Quart, Enum.EasingDirection.Out
                    )

                    v4:Tween(arrow, {
                      Position = UDim2.new(1, -12, 0.5, 0),
                      TextColor3 = Color3.fromRGB(65, 220, 110),
                    }, 0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
                  end)

                  v494.MouseButton1Click:Connect(function()
                    CircleClick(v494, getMouse.X, getMouse.Y)

                    v4:Tween(arrow, { Position = UDim2.new(1, -5, 0.5, 0) }, 0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, function()
                      v4:Tween(
                        arrow, { Position = UDim2.new(1, -8, 0.5, 0) }, 0.22,
                        Enum.EasingStyle.Back, Enum.EasingDirection.Out
                      )
                    end)

                    pcall(callback)
                  end)

                  RegisterKeyLocked(v494, v492)
                end

                function v477:addToggle(p217, p218, p219, p220, p221, p222, p223, p224, p225)
                  local description2 = p221
                  local condition3 = p223
                  local subToggles = p224
                  local name9 = p217
                  local default = p218
                  local callback2 = p219
                  local locked2 = p220
                  local flag = p222

                  if type(name9) == "table" then
                    local v495 = name9
                    name9 = v495.Name or v495.Title or v495.Text or "Toggle"

                    default = v495.Default ~= nil and v495.Default
                      or v495.Value ~= nil and v495.Value or default

                    callback2 = v495.Callback or v495.Function or callback2
                    locked2 = v495.Locked or locked2
                    description2 = v495.Description or v495.Desc or description2
                    flag = v495.Flag or v495.SaveKey or v495.savekey or flag
                    condition3 = v495.Condition or condition3
                    subToggles = v495.SubToggles or v495.subtoggles or subToggles
                    local liteAllowed2 = v495.LiteAllowed
                  end

                  local v496, f35, v497, v498, v499, v500, v501, v502, f36

                  if not checkCondition(condition3) then
                    return v146
                  else
                    callback2 = callback2 or function() end
                    default = default or false

                    if flag then
                      save:RegisterKey(flag)
                    end

                    if flag then
                      if (not locked2 or v126.HasKeyAccess()) and not IsFullLocked() then
                        local get29 = save:Get(flag, nil)

                        if get29 ~= nil then
                          default = get29
                        end
                      end
                    end

                    local text13, v503 = util.DescMetrics(
                      description2, Enum.Font.Gotham, 11, 150
                    )

                    local v504 = v503 > 0 and 28 + v503 or 32

                    v497 = create2("TextButton", {
                      BackgroundColor3 = ThemeColor("Primary"),
                      BackgroundTransparency = 0.4,
                      Size = UDim2.new(1, -25, 0, v504),
                      Position = UDim2.new(0, 0, 0, 0),
                      BorderSizePixel = 0,
                      AutoButtonColor = false,
                      Text = "",
                      ClipsDescendants = true,
                      Children = { create2("UICorner", { CornerRadius = UDim.new(0, 6) }) },
                    }, v475)

                    f30(v497, name9)

                    v498 = create2("Frame", {
                      BackgroundColor3 = Color3.fromRGB(15, 15, 15),
                      Position = UDim2.new(1, -50, 0.5, -9),
                      Size = UDim2.new(0, 36, 0, 18),
                      BorderSizePixel = 0,
                      Children = {
                        create2("UICorner", { CornerRadius = UDim.new(1, 0) }),
                        create2("UIStroke", {
                          Color = Color3.fromRGB(100, 100, 100),
                          Transparency = 0.8,
                          Thickness = 2,
                          ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        }),
                      },
                    }, v497)

                    v499 = create2("ImageLabel", {
                      AnchorPoint = Vector2.new(0, 0.5),
                      Size = UDim2.fromOffset(14, 14),
                      Position = default and UDim2.new(0, 19, 0.5, 0) or UDim2.new(0, 2, 0.5, 0),
                      Image = "http://www.roblox.com/asset/?id=12266946128",
                      ImageTransparency = default and 0 or 0.5,
                      BackgroundTransparency = 1,
                      ImageColor3 = Color3.fromRGB(255, 255, 255),
                    }, v498)

                    v500 = create2(
                      "UIGradient", { Color = ThemeColor("Lit"), Rotation = 90 }, v499
                    )

                    v500.Enabled = default

                    RegisterLitGradient(v500)

                    v496 = create2("TextLabel", {
                      BackgroundTransparency = 1,
                      Position = UDim2.new(0, 10, 0, 4),
                      Size = UDim2.new(1, -66, 0, 20),
                      Font = Enum.Font.GothamBold,
                      Text = name9,
                      TextColor3 = default and Color3.fromRGB(220, 220, 220)
                        or Color3.fromRGB(180, 180, 180),
                      TextXAlignment = Enum.TextXAlignment.Left,
                      TextWrapped = false,
                      TextScaled = true,
                      TextTruncate = Enum.TextTruncate.AtEnd,
                      Children = { MakeTextConstraint(14, 8) },
                    }, v497)

                    RegisterTranslatable(v496, name9)

                    if v503 > 0 then
                      RegisterTranslatable(create2("TextLabel", {
                        Name = "DescLabel",
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 10, 0, 22),
                        Size = UDim2.new(1, -60, 0, v503),
                        Font = Enum.Font.Gotham,
                        Text = text13,
                        TextColor3 = Color3.fromRGB(130, 130, 145),
                        TextXAlignment = Enum.TextXAlignment.Left,
                        TextYAlignment = Enum.TextYAlignment.Top,
                        TextWrapped = true,
                        TextSize = 11,
                        ZIndex = 2,
                      }, v497), description2)
                    end

                    v501 = locked2 and not v126.HasKeyAccess() and false or default
                    v502 = {}

                    function f35()
                      v4:Tween(v499, {
                        Position = v501 and UDim2.new(0, 19, 0.5, 0) or UDim2.new(0, 2, 0.5, 0),
                        ImageTransparency = v501 and 0 or 0.5,
                        ImageColor3 = Color3.fromRGB(255, 255, 255),
                      }, 0.26, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

                      v500.Enabled = v501

                      v4:Tween(v498, {
                        BackgroundColor3 = v501 and Color3.fromRGB(25, 18, 40)
                          or Color3.fromRGB(15, 15, 15),
                      }, 0.24, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

                      v4:Tween(v496, {
                        TextColor3 = v501 and Color3.fromRGB(235, 235, 245)
                          or Color3.fromRGB(140, 140, 150),
                      }, 0.24, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

                      if flag and (not locked2 or v126.HasKeyAccess()) then
                        save:ElementSave(flag, v501)
                      end

                      pcall(callback2, v501)
                      f36()
                    end

                    function f36()
                      for index71, value88 in ipairs(v502) do
                        if value88.Optional then
                          value88.Frame.Visible = v501
                        end

                        if value88.SetInteractable then
                          value88.SetInteractable(v501)
                        end
                      end
                    end

                    v497.MouseEnter:Connect(function()
                      v4:Tween(
                        v497, { BackgroundTransparency = 0.26 }, 0.16, Enum.EasingStyle.Quart,
                        Enum.EasingDirection.Out
                      )
                    end)

                    v497.MouseLeave:Connect(function()
                      v4:Tween(
                        v497, { BackgroundTransparency = 0.4 }, 0.22, Enum.EasingStyle.Quart,
                        Enum.EasingDirection.Out
                      )
                    end)

                    if flag then
                      save:RegisterControl(flag, {
                        Type = "Toggle",
                        Default = default,
                        Set = function(p226, p227)
                          v501 = p226 == true

                          v4:Tween(v499, {
                            Position = v501 and UDim2.new(0, 19, 0.5, 0)
                              or UDim2.new(0, 2, 0.5, 0),
                            ImageTransparency = v501 and 0 or 0.5,
                            ImageColor3 = Color3.fromRGB(255, 255, 255),
                          }, 0.26, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

                          v500.Enabled = v501

                          v4:Tween(v498, {
                            BackgroundColor3 = v501 and Color3.fromRGB(25, 18, 40)
                              or Color3.fromRGB(15, 15, 15),
                          }, 0.24, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

                          v4:Tween(v496, {
                            TextColor3 = v501 and Color3.fromRGB(235, 235, 245)
                              or Color3.fromRGB(140, 140, 150),
                          }, 0.24, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

                          f36()

                          if p227 ~= false then
                            pcall(callback2, v501)
                          end
                        end,
                        Get = function() return v501 end,
                      })
                    end

                    f35()

                    v497.Activated:Connect(function()
                      CircleClick(v497, getMouse.X, getMouse.Y)
                      v501 = not v501
                      f35()
                    end)

                    if locked2 and flag then
                      table.insert(v137, {
                        saveKey = flag,
                        UpdateFn = function()
                          if v126.HasKeyAccess() then
                            local get30 = save:Get(flag, nil)
                            v501 = get30 ~= nil and get30 or default
                            f35()
                          end
                        end,
                      })
                    end

                    RegisterKeyLocked(v497, locked2)

                    if type(subToggles) == "table" then
                      local v505 = flag

                      local gsub10 = v505
                      gsub10 = v505 or name9:lower():gsub("%s+", "")

                      for index72, value89 in ipairs(subToggles) do
                        local title2 = value89.Title or value89[1] or "Sub Toggle"
                        local default2 = value89.Default or value89[2] or false
                        local callback3 = value89.Callback or value89[3] or function() end

                        local saveKey = value89.SaveKey or value89.savekey
                          or gsub10 .. "_sub" .. index72

                        local v506 = value89.Optional == true
                        save:RegisterKey(saveKey)

                        if (not locked2 or v126.HasKeyAccess()) and not IsFullLocked() then
                          local get31 = save:Get(saveKey, nil)

                          if get31 ~= nil then
                            default2 = get31
                          end
                        end

                        local v507 = not v506

                        local v508 = create2("TextButton", {
                          BackgroundColor3 = ThemeColor("Primary"),
                          BackgroundTransparency = 0.48,
                          Size = UDim2.new(1, -38, 0, 28),
                          BorderSizePixel = 0,
                          AutoButtonColor = false,
                          Text = "",
                          Active = v501,
                          Visible = v507 or v501,
                          ClipsDescendants = true,
                          Children = { create2("UICorner", { CornerRadius = UDim.new(0, 6) }) },
                        }, v475)

                        f30(v508, title2 .. " (" .. name9 .. ")")

                        local v509 = create2("Frame", {
                          BackgroundColor3 = Color3.fromRGB(12, 12, 12),
                          Position = UDim2.new(1, -40, 0.5, -8),
                          Size = UDim2.new(0, 30, 0, 16),
                          BorderSizePixel = 0,
                          Children = {
                            create2("UICorner", { CornerRadius = UDim.new(1, 0) }),
                            create2("UIStroke", {
                              Color = Color3.fromRGB(100, 100, 100),
                              Transparency = 0.8,
                              Thickness = 2,
                              ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                            }),
                          },
                        }, v508)

                        local uiStroke8 = v509.UIStroke

                        local v510 = create2("ImageLabel", {
                          AnchorPoint = Vector2.new(0, 0.5),
                          Size = UDim2.fromOffset(12, 12),
                          Position = default2 and UDim2.new(0, 16, 0.5, 0)
                            or UDim2.new(0, 2, 0.5, 0),
                          Image = "http://www.roblox.com/asset/?id=12266946128",
                          ImageTransparency = default2 and 0 or 0.5,
                          BackgroundTransparency = 1,
                          ImageColor3 = Color3.fromRGB(255, 255, 255),
                        }, v509)

                        local v511 = create2(
                          "UIGradient", { Color = ThemeColor("Lit"), Rotation = 90 }, v510
                        )

                        v511.Enabled = default2

                        RegisterLitGradient(v511)

                        local v512 = create2("TextLabel", {
                          BackgroundTransparency = 1,
                          Position = UDim2.new(0, 12, 0, 0),
                          Size = UDim2.new(1, -54, 1, 0),
                          Font = Enum.Font.GothamBold,
                          Text = title2,
                          TextColor3 = default2 and Color3.fromRGB(205, 205, 210)
                            or Color3.fromRGB(145, 145, 150),
                          TextXAlignment = Enum.TextXAlignment.Left,
                          TextWrapped = false,
                          TextScaled = true,
                          TextTruncate = Enum.TextTruncate.AtEnd,
                          Children = { MakeTextConstraint(13, 8) },
                        }, v508)

                        RegisterTranslatable(v512, title2)
                        local v513 = default2

                        local function f37()
                          v4:Tween(v510, {
                            Position = v513 and UDim2.new(0, 16, 0.5, 0)
                              or UDim2.new(0, 2, 0.5, 0),
                            ImageTransparency = v513 and 0 or 0.5,
                          }, 0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

                          v511.Enabled = v513

                          v4:Tween(v512, {
                            TextColor3 = v513 and Color3.fromRGB(205, 205, 210)
                              or Color3.fromRGB(145, 145, 150),
                          }, 0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)

                          v4:Tween(
                            v508, { BackgroundTransparency = v513 and 0.35 or 0.48 }, 0.3,
                            Enum.EasingStyle.Sine, Enum.EasingDirection.Out
                          )

                          if not locked2 or v126.HasKeyAccess() then
                            save:ElementSave(saveKey, v513)
                          end

                          callback3(v513)
                        end

                        if saveKey then
                          save:RegisterControl(saveKey, {
                            Type = "SubToggle",
                            Default = value89.Default or value89[2] or false,
                            Set = function(p228, p229)
                              v513 = p228 == true

                              v4:Tween(v510, {
                                Position = v513 and UDim2.new(0, 16, 0.5, 0)
                                  or UDim2.new(0, 2, 0.5, 0),
                                ImageTransparency = v513 and 0 or 0.5,
                              }, 0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

                              v511.Enabled = v513

                              v4:Tween(v512, {
                                TextColor3 = v513 and Color3.fromRGB(205, 205, 210)
                                  or Color3.fromRGB(145, 145, 150),
                              }, 0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)

                              v4:Tween(
                                v508, { BackgroundTransparency = v513 and 0.35 or 0.48 }, 0.3,
                                Enum.EasingStyle.Sine, Enum.EasingDirection.Out
                              )

                              if p229 ~= false then
                                pcall(callback3, v513)
                              end
                            end,
                            Get = function() return v513 end,
                          })
                        end

                        local function f38(p230)
                          v508.Active = p230

                          v4:Tween(v508, {
                            BackgroundTransparency = p230 and (v513 and 0.35 or 0.48) or 0.75,
                          }, 0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)

                          v4:Tween(v512, {
                            TextTransparency = p230 and 0 or 0.6,
                            TextColor3 = p230
                                and (v513 and Color3.fromRGB(205, 205, 210)
                                  or Color3.fromRGB(145, 145, 150))
                              or Color3.fromRGB(100, 100, 105),
                          }, 0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)

                          v4:Tween(
                            v509, { BackgroundTransparency = p230 and 0 or 0.65 }, 0.3,
                            Enum.EasingStyle.Sine, Enum.EasingDirection.Out
                          )

                          v4:Tween(
                            v510, { ImageTransparency = p230 and (v513 and 0 or 0.5) or 0.75 },
                            0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out
                          )

                          v4:Tween(
                            uiStroke8, { Transparency = p230 and 0.8 or 0.9 }, 0.3,
                            Enum.EasingStyle.Sine, Enum.EasingDirection.Out
                          )
                        end

                        v508.Activated:Connect(function()
                          if not v501 then
                            return
                          end

                          CircleClick(v508, getMouse.X, getMouse.Y)
                          v513 = not v513
                          f37()
                        end)

                        f37()
                        f38(v501)

                        table.insert(v502, {
                          Frame = v508,
                          Optional = v506,
                          SetInteractable = f38,
                        })
                      end
                    end

                    return {
                      Update = function(p231)
                        v501 = p231
                        f35()
                      end,
                      Get = function() return v501 end,
                      Frame = v497,
                    }
                  end
                end

                function v477:addSlider(p232, p233, p234, p235, p236, p237, p238, p239, p240, p241)
                  local min = p233
                  local max = p234
                  local name10 = p232
                  local default3 = p235
                  local condition4 = p240
                  local callback4 = p236
                  local locked3 = p237
                  local step = p238
                  local flag2 = p239

                  if type(name10) == "table" then
                    local v514 = name10
                    name10 = v514.Name or v514.Title or v514.Text or "Slider"
                    min = v514.Min or v514.Minimum or min
                    max = v514.Max or v514.Maximum or max

                    default3 = v514.Default ~= nil and v514.Default
                      or v514.Value ~= nil and v514.Value or default3

                    callback4 = v514.Callback or v514.Function or callback4
                    locked3 = v514.Locked or locked3
                    step = v514.Step or v514.Increment or v514.Precise or step
                    flag2 = v514.Flag or v514.SaveKey or v514.savekey or flag2
                    condition4 = v514.Condition or condition4
                    local liteAllowed3 = v514.LiteAllowed
                  end

                  local f39, v515, f40, v516, v517, v518, v519, v520, v521, v522, f41, v523, f42

                  if not checkCondition(condition4) then
                    return v146
                  else
                    callback4 = callback4 or function() end
                    min = min or 0
                    max = max or 100
                    step = step or 1

                    if flag2 then
                      save:RegisterKey(flag2)
                    end

                    if flag2 then
                      if not locked3 or v126.HasKeyAccess() then
                        local get32 = save:Get(flag2, nil)

                        if get32 ~= nil then
                          default3 = get32
                        end
                      end
                    end

                    default3 = math.clamp(default3 or min, min, max)
                    local v524 = select(2, tostring(step):find("%."))
                    local v525 = v524

                    if v524 then
                      local v526 = tostring(step)
                      local v527 = tostring(step)
                      v525 = #v526 - v527:find("%.")
                    end

                    v515 = "%." .. (v525 or 0) .. "f"

                    function f40(p242)
                      return math.floor(p242 / step + 0.5) * step
                    end

                    v516 = create2("Frame", {
                      BackgroundColor3 = ThemeColor("Primary"),
                      BackgroundTransparency = 0.4,
                      Size = UDim2.new(1, -25, 0, 54),
                      Position = UDim2.new(0, 0, 0, 0),
                      BorderSizePixel = 0,
                      ClipsDescendants = true,
                      Children = { create2("UICorner", { CornerRadius = UDim.new(0, 6) }) },
                    }, v475)

                    v517 = create2("UIStroke", {
                      Color = Color3.fromRGB(65, 220, 110),
                      Transparency = 1,
                      Thickness = 1,
                      ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    }, v516)

                    RegisterTranslatable(create2("TextLabel", {
                      BackgroundTransparency = 1,
                      Size = UDim2.new(1, -70, 0, 18),
                      Position = UDim2.new(0, 12, 0, 8),
                      Font = Enum.Font.GothamBold,
                      Text = name10,
                      TextSize = 13,
                      TextColor3 = Color3.fromRGB(220, 220, 230),
                      TextXAlignment = Enum.TextXAlignment.Left,
                      TextWrapped = false,
                      TextScaled = true,
                      TextTruncate = Enum.TextTruncate.AtEnd,
                      ZIndex = 3,
                      Children = { MakeTextConstraint(15, 8) },
                    }, v516), name10)

                    f30(v516, name10)

                    v518 = create2("TextBox", {
                      BackgroundColor3 = Color3.fromRGB(12, 12, 18),
                      BackgroundTransparency = 0.2,
                      Position = UDim2.new(1, -56, 0, 6),
                      Size = UDim2.new(0, 46, 0, 20),
                      Font = Enum.Font.GothamBold,
                      Text = string.format(v515, default3),
                      TextSize = 12,
                      TextColor3 = Color3.fromRGB(65, 220, 110),
                      TextXAlignment = Enum.TextXAlignment.Center,
                      TextTruncate = Enum.TextTruncate.AtEnd,
                      ClipsDescendants = true,
                      ClearTextOnFocus = false,
                      ZIndex = 3,
                      Children = {
                        create2("UICorner", { CornerRadius = UDim.new(0, 5) }),
                        create2("UIStroke", {
                          Color = Color3.fromRGB(65, 220, 110),
                          Transparency = 0.72,
                          Thickness = 1,
                          ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        }),
                      },
                    }, v516)

                    v519 = create2("Frame", {
                      BackgroundColor3 = Color3.fromRGB(10, 10, 16),
                      BackgroundTransparency = 0.1,
                      Position = UDim2.new(0, 12, 0, 34),
                      Size = UDim2.new(1, -24, 0, 10),
                      ZIndex = 2,
                      Children = {
                        create2("UICorner", { CornerRadius = UDim.new(1, 0) }),
                        create2("UIStroke", {
                          Color = Color3.fromRGB(65, 220, 110),
                          Transparency = 0.82,
                          Thickness = 1,
                          ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        }),
                      },
                    }, v516)

                    local v528 = create2("UIGradient", {
                      Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 145, 65)),
                        ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 255, 175)),
                      }),
                      Rotation = 0,
                    })

                    RegisterButtonGradient(v528)

                    v520 = create2("Frame", {
                      BackgroundTransparency = 0,
                      Size = UDim2.new((default3 - min) / (max - min), 0, 1, 0),
                      ZIndex = 3,
                      Children = {
                        create2("UICorner", { CornerRadius = UDim.new(1, 0) }), v528,
                      },
                    }, v519)

                    v521 = create2("Frame", {
                      Name = "Thumb",
                      BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                      AnchorPoint = Vector2.new(0.5, 0.5),
                      Position = UDim2.new((default3 - min) / (max - min), 0, 0.5, 0),
                      Size = UDim2.new(0, 13, 0, 13),
                      ZIndex = 5,
                      Children = {
                        create2("UICorner", { CornerRadius = UDim.new(1, 0) }),
                        create2("UIStroke", {
                          Color = Color3.fromRGB(65, 220, 110),
                          Transparency = 0.3,
                          Thickness = 1.5,
                          ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        }),
                        create2("Frame", {
                          BackgroundColor3 = Color3.fromRGB(65, 220, 110),
                          AnchorPoint = Vector2.new(0.5, 0.5),
                          Position = UDim2.new(0.5, 0, 0.5, 0),
                          Size = UDim2.new(0, 5, 0, 5),
                          ZIndex = 6,
                          Children = { create2("UICorner", { CornerRadius = UDim.new(1, 0) }) },
                        }),
                      },
                    }, v519)

                    function f39(p243, p244)
                      local v529 = (p243 - min) / (max - min)

                      if p244 then
                        v520:TweenSize(
                          UDim2.new(v529, 0, 1, 0), Enum.EasingDirection.Out,
                          Enum.EasingStyle.Quint, 0.15, true
                        )

                        v4:Tween(
                          v521, { Position = UDim2.new(v529, 0, 0.5, 0) }, 0.15,
                          Enum.EasingStyle.Quint, Enum.EasingDirection.Out
                        )
                      else
                        v520.Size = UDim2.new(v529, 0, 1, 0)
                        v521.Position = UDim2.new(v529, 0, 0.5, 0)
                      end

                      v518.Text = string.format(v515, p243)

                      if flag2 and (not locked3 or v126.HasKeyAccess()) then
                        save:ElementSave(flag2, p243)
                      end

                      callback4(p243)
                    end

                    v522 = false

                    function f41(p245)
                      f39(f40(min + (max - min) * math.clamp(
                        (p245 - v519.AbsolutePosition.X) / v519.AbsoluteSize.X, 0, 1
                      )), false)
                    end

                    f39(default3, false)
                    v523 = nil

                    v516.MouseEnter:Connect(function()
                      v4:Tween(
                        v516, { BackgroundTransparency = 0.26 }, 0.16, Enum.EasingStyle.Quart,
                        Enum.EasingDirection.Out
                      )
                    end)

                    v516.MouseLeave:Connect(function()
                      if not v522 then
                        v4:Tween(
                          v516, { BackgroundTransparency = 0.4 }, 0.22, Enum.EasingStyle.Quart,
                          Enum.EasingDirection.Out
                        )
                      end
                    end)

                    function f42(p246)
                      if v523 ~= nil then
                        return
                      end

                      if p246.UserInputType == Enum.UserInputType.Touch
                        or p246.UserInputType == Enum.UserInputType.MouseButton1 then
                        v522 = true
                        v523 = p246
                        f41(p246.Position.X)

                        v4:Tween(
                          v517, { Transparency = 0.35 }, 0.16, Enum.EasingStyle.Quart,
                          Enum.EasingDirection.Out
                        )

                        v4:Tween(
                          v521, { Size = UDim2.new(0, 16, 0, 16) }, 0.18, Enum.EasingStyle.Back,
                          Enum.EasingDirection.Out
                        )
                      end
                    end

                    v519.InputBegan:Connect(f42)
                    v521.InputBegan:Connect(f42)

                    v516.InputBegan:Connect(function(input12)
                      if input12.UserInputType == Enum.UserInputType.Touch
                        or input12.UserInputType == Enum.UserInputType.MouseButton1 then
                        if input12.Position.Y - v516.AbsolutePosition.Y >= 28 then
                          f42(input12)
                        end
                      end
                    end)

                    userInputService.InputChanged:Connect(function(input13)
                      if not v522 or not v523 then
                        return
                      end

                      if input13 == v523
                        or v523.UserInputType == Enum.UserInputType.MouseButton1
                          and input13.UserInputType == Enum.UserInputType.MouseMovement then
                        f41(input13.Position.X)
                      end
                    end)

                    userInputService.InputEnded:Connect(function(input14)
                      if input14 == v523
                        or input14.UserInputType == Enum.UserInputType.MouseButton1
                        or input14.UserInputType == Enum.UserInputType.Touch then
                        v522 = false
                        v523 = nil

                        v4:Tween(
                          v517, { Transparency = 1 }, 0.24, Enum.EasingStyle.Quart,
                          Enum.EasingDirection.Out
                        )

                        v4:Tween(
                          v521, { Size = UDim2.new(0, 13, 0, 13) }, 0.22, Enum.EasingStyle.Back,
                          Enum.EasingDirection.Out
                        )

                        v4:Tween(
                          v516, { BackgroundTransparency = 0.4 }, 0.22, Enum.EasingStyle.Quart,
                          Enum.EasingDirection.Out
                        )
                      end
                    end)

                    v518.FocusLost:Connect(function()
                      local v530 = tonumber(v518.Text)

                      if v530 then
                        f39(f40(math.clamp(v530, min, max)), true)
                      else
                        f39(default3, true)
                      end
                    end)

                    if flag2 then
                      save:RegisterControl(flag2, {
                        Type = "Slider",
                        Default = default3,
                        Set = function(p247, p248)
                          local v531 = tonumber(p247) or default3
                          local v532 = math.clamp(v531, min, max)
                          local v533 = (v532 - min) / (max - min)

                          v520:TweenSize(
                            UDim2.new(v533, 0, 1, 0), Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quint, 0.15, true
                          )

                          v4:Tween(
                            v521, { Position = UDim2.new(v533, 0, 0.5, 0) }, 0.15,
                            Enum.EasingStyle.Quint, Enum.EasingDirection.Out
                          )

                          v518.Text = string.format(v515, v532)

                          if p248 ~= false then
                            pcall(callback4, v532)
                          end
                        end,
                        Get = function() return tonumber(v518.Text) or default3 end,
                      })
                    end

                    if locked3 and flag2 then
                      table.insert(v137, {
                        saveKey = flag2,
                        UpdateFn = function()
                          if v126.HasKeyAccess() then
                            local get33 = save:Get(flag2, nil)
                            f39(math.clamp(get33 ~= nil and get33 or default3, min, max))
                          else
                            f39(default3)
                          end
                        end,
                      })
                    end

                    RegisterKeyLocked(v516, locked3)
                    return
                  end
                end

                function v477:addDropdown(p249, p250, p251, p252, p253, p254, p255, p256, p257)
                  local default4 = p250
                  local condition5 = p256
                  local options = p251
                  local name11 = p249
                  local callback5 = p252
                  local locked4 = p253
                  local multi = p254
                  local flag3 = p255

                  if type(name11) == "table" then
                    local v534 = name11
                    name11 = v534.Name or v534.Title or v534.Text or "Dropdown"

                    default4 = v534.Default ~= nil and v534.Default
                      or v534.Value ~= nil and v534.Value or default4

                    options = v534.Options or v534.Values or options
                    callback5 = v534.Callback or v534.Function or callback5
                    locked4 = v534.Locked or locked4
                    multi = v534.Multi or v534.Multimode or v534.multimode or multi
                    flag3 = v534.Flag or v534.SaveKey or v534.savekey or flag3
                    condition5 = v534.Condition or condition5
                    local liteAllowed4 = v534.LiteAllowed
                  end

                  local f43, f44, f45, f46, v535, v536, v537, v538, v539, v540, v541, v542,
                    v543, udim15, f47, f48, f49

                  if not checkCondition(condition5) then
                    return v146
                  else
                    default4 = default4 or 1
                    options = options or {}
                    callback5 = callback5 or function() end

                    if flag3 then
                      save:RegisterKey(flag3)
                    end

                    if flag3 then
                      if not locked4 or v126.HasKeyAccess() then
                        local get34 = save:Get(flag3, nil)

                        if get34 ~= nil then
                          default4 = get34
                        end
                      end
                    end

                    function f43()
                      local v544 = {}

                      for index73, value90 in ipairs(v535) do
                        v544[#v544 + 1] = options[value90]
                      end

                      return v544
                    end

                    function f44(p258)
                      for index74, value91 in ipairs(v535) do
                        if value91 == p258 then
                          table.remove(v535, index74)
                          return
                        end
                      end
                    end

                    v535 = {}

                    function f45(p259)
                      if not table.find(v535, p259) then
                        table.insert(v535, p259)
                      end
                    end

                    function f46(p260, p261)
                      local v545 = p261 or 2

                      if #p260 == 0 then
                        return "None"
                      elseif #p260 <= v545 then
                        return table.concat(p260, ", ")
                      else
                        local v546 = {}

                        for n = 1, v545 do
                          v546[n] = p260[n]
                        end

                        return table.concat(v546, ", ") .. "  +" .. #p260 - v545
                      end
                    end

                    v536 = {}

                    local function f50()
                      local function f51(p262)
                        if #options < 1 then
                          return
                        else
                          local v547 = type(p262) == "number" and math.clamp(p262, 1, #options)
                            or type(p262) == "string" and table.find(options, p262)

                          if v547 then
                            f45(v547)
                          end

                          return
                        end
                      end

                      if multi then
                        if typeof(default4) == "table" then
                          for index75, value92 in ipairs(default4) do
                            f51(value92)
                          end
                        else
                          f51(default4)
                        end

                        if #v535 == 0 and #options > 0 then
                          f45(1)
                        end
                      else
                        f51(default4)

                        if #v535 == 0 and #options > 0 then
                          f45(1)
                        end
                      end
                    end

                    f50()

                    local v548 = create2("Frame", {
                      BackgroundColor3 = ThemeColor("Primary"),
                      BackgroundTransparency = 0.4,
                      BorderSizePixel = 0,
                      Size = UDim2.new(1, -25, 0, 32),
                      ClipsDescendants = true,
                      Children = { create2("UICorner", { CornerRadius = UDim.new(0, 6) }) },
                    }, v475)

                    v537 = create2("UIStroke", {
                      Color = Color3.fromRGB(65, 220, 110),
                      Transparency = 1,
                      Thickness = 1,
                      ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    }, v548)

                    f30(v548, name11)

                    local v549 = create2("TextLabel", {
                      BackgroundTransparency = 1,
                      Position = UDim2.new(0, 12, 0, 0),
                      Size = UDim2.new(1, -95, 1, 0),
                      Font = Enum.Font.GothamBold,
                      TextColor3 = Color3.fromRGB(220, 220, 230),
                      TextXAlignment = Enum.TextXAlignment.Left,
                      Text = name11,
                      TextWrapped = false,
                      TextScaled = true,
                      TextTruncate = Enum.TextTruncate.AtEnd,
                      ZIndex = 3,
                      Children = { MakeTextConstraint(15, 8) },
                    }, v548)

                    local v550 = create2("Frame", {
                      BackgroundColor3 = Color3.fromRGB(12, 12, 18),
                      BackgroundTransparency = 0.15,
                      BorderSizePixel = 0,
                      Position = UDim2.new(1, -90, 0.5, -11),
                      Size = UDim2.new(0, 68, 0, 22),
                      ZIndex = 3,
                      Children = {
                        create2("UICorner", { CornerRadius = UDim.new(0, 5) }),
                        create2("UIStroke", {
                          Color = Color3.fromRGB(65, 220, 110),
                          Transparency = 0.75,
                          Thickness = 1,
                          ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        }),
                      },
                    }, v548)

                    v538 = create2("TextLabel", {
                      BackgroundTransparency = 1,
                      Size = UDim2.new(1, -8, 1, 0),
                      Position = UDim2.new(0, 6, 0, 0),
                      Font = Enum.Font.GothamBold,
                      TextColor3 = Color3.fromRGB(65, 220, 110),
                      TextScaled = true,
                      TextTruncate = Enum.TextTruncate.AtEnd,
                      TextXAlignment = Enum.TextXAlignment.Left,
                      Text = multi and f46(f43(), 2) or options[v535[1]] or "None",
                      ZIndex = 4,
                      Children = { MakeTextConstraint(13, 10) },
                    }, v550)

                    v539 = create2("ImageButton", {
                      BackgroundTransparency = 1,
                      AnchorPoint = Vector2.new(1, 0.5),
                      Position = UDim2.new(1, -8, 0.5, 0),
                      Size = UDim2.new(0, 16, 0, 16),
                      Image = "rbxassetid://95968409641902",
                      ImageColor3 = Color3.fromRGB(65, 220, 110),
                      ZIndex = 3,
                    }, v548)

                    v540 = create2("Frame", {
                      Visible = false,
                      Active = true,
                      BackgroundTransparency = 0.6,
                      BackgroundColor3 = Color3.fromRGB(0, 0, 0),
                      Size = UDim2.new(1, 0, 1, 0),
                      ZIndex = 9,
                    }, v182)

                    v541 = create2("Frame", {
                      Visible = false,
                      AnchorPoint = Vector2.new(0.5, 0.5),
                      Position = UDim2.new(0.5, 0, 0.5, 0),
                      BackgroundTransparency = 0.18,
                      Size = UDim2.new(0, 250, 0, 0),
                      BackgroundColor3 = Color3.fromRGB(14, 14, 20),
                      ZIndex = 10,
                      Children = {
                        create2("UICorner", { CornerRadius = UDim.new(0, 10) }),
                        create2("UIStroke", {
                          Color = Color3.fromRGB(65, 220, 110),
                          Transparency = 0.72,
                          Thickness = 1,
                        }),
                      },
                    }, v182)

                    create2("TextLabel", {
                      Size = UDim2.new(1, -40, 0, 20),
                      Position = UDim2.new(0, 12, 0, 8),
                      BackgroundTransparency = 1,
                      Text = name11,
                      Font = Enum.Font.GothamBold,
                      TextSize = 13,
                      TextColor3 = Color3.fromRGB(220, 220, 230),
                      TextXAlignment = Enum.TextXAlignment.Left,
                      ZIndex = 11,
                    }, v541)

                    local v551 = create2("TextButton", {
                      Text = "×",
                      TextColor3 = Color3.fromRGB(65, 220, 110),
                      TextSize = 18,
                      Font = Enum.Font.GothamBold,
                      Size = UDim2.new(0, 22, 0, 22),
                      Position = UDim2.new(1, -28, 0, 5),
                      BackgroundColor3 = Color3.fromRGB(65, 220, 110),
                      BackgroundTransparency = 0.88,
                      AutoButtonColor = false,
                      ZIndex = 12,
                      Children = { create2("UICorner", { CornerRadius = UDim.new(0, 5) }) },
                    }, v541)

                    v542 = create2("TextBox", {
                      Text = "",
                      PlaceholderText = "Search options...",
                      PlaceholderColor3 = Color3.fromRGB(120, 100, 150),
                      Size = UDim2.new(1, -16, 0, 26),
                      Position = UDim2.new(0, 8, 0, 34),
                      TextSize = 12,
                      Font = Enum.Font.Gotham,
                      TextColor3 = Color3.fromRGB(220, 220, 230),
                      TextXAlignment = Enum.TextXAlignment.Left,
                      BackgroundColor3 = Color3.fromRGB(10, 10, 16),
                      BackgroundTransparency = 0.1,
                      ClearTextOnFocus = true,
                      ZIndex = 11,
                      Children = {
                        create2("UICorner", { CornerRadius = UDim.new(0, 6) }),
                        create2("UIStroke", {
                          Color = Color3.fromRGB(65, 220, 110),
                          Transparency = 0.78,
                          Thickness = 1,
                          ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        }),
                        create2("UIPadding", { PaddingLeft = UDim.new(0, 8) }),
                      },
                    }, v541)

                    v543 = create2("ScrollingFrame", {
                      Size = UDim2.new(1, -8, 1, -70),
                      Position = UDim2.new(0, 4, 0, 66),
                      CanvasSize = UDim2.new(0, 0, 0, 0),
                      ScrollBarThickness = 0,
                      ScrollBarImageTransparency = 1,
                      AutomaticCanvasSize = Enum.AutomaticSize.Y,
                      ElasticBehavior = Enum.ElasticBehavior.WhenScrollable,
                      BackgroundTransparency = 1,
                      Active = true,
                      ZIndex = 11,
                      Children = {
                        create2("UIListLayout", {
                          Padding = UDim.new(0, 4),
                          SortOrder = Enum.SortOrder.LayoutOrder,
                        }),
                        create2("UIPadding", {
                          PaddingLeft = UDim.new(0, 2),
                          PaddingRight = UDim.new(0, 2),
                          PaddingTop = UDim.new(0, 2),
                          PaddingBottom = UDim.new(0, 4),
                        }),
                      },
                    }, v541)

                    udim15 = UDim2.new(0, 250, 0, 230)

                    function f47(p263, p264)
                      local absolutePosition7 = p263.AbsolutePosition
                      local absolutePosition8 = p264.AbsolutePosition

                      return UDim2.new(
                        0, absolutePosition7.X - absolutePosition8.X, 0,
                        absolutePosition7.Y - absolutePosition8.Y
                      )
                    end

                    function f48()
                      local position2 = f47(v539, v182)
                      local absoluteSize3 = v539.AbsoluteSize

                      v4:Tween(
                        v540, { BackgroundTransparency = 1 }, 0.2, Enum.EasingStyle.Quart,
                        Enum.EasingDirection.In
                      )

                      v4:Tween(v541, {
                        Position = position2,
                        Size = UDim2.new(0, absoluteSize3.X, 0, absoluteSize3.Y),
                        BackgroundTransparency = 0.5,
                      }, 0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.In, function()
                        v541.Visible = false
                        v540.Visible = false
                      end)

                      v4:Tween(
                        v539, { Rotation = 0 }, 0.24, Enum.EasingStyle.Quart,
                        Enum.EasingDirection.Out
                      )

                      v4:Tween(v537, { Transparency = 1 }, 0.25)
                    end

                    function f49(p265)
                      for index76, value93 in ipairs(v543:GetChildren()) do
                        if value93:IsA("Frame") then
                          value93:Destroy()
                        end
                      end

                      v536 = {}

                      for index77, value94 in ipairs(options) do
                        if not p265 or p265 == ""
                          or string.find(string.lower(value94), string.lower(p265), 1, true) then
                          table.insert(v536, { index = index77, value = value94 })
                        end
                      end

                      for index78, value95 in ipairs(v536) do
                        local value96 = value95.value
                        local index79 = value95.index
                        local v552 = table.find(v535, index79) ~= nil

                        local v553 = create2("Frame", {
                          Name = "Item_" .. index79,
                          BackgroundColor3 = Color3.fromRGB(22, 22, 32),
                          BackgroundTransparency = v552 and 0.3 or 0.55,
                          BorderSizePixel = 0,
                          Size = UDim2.new(1, 0, 0, 30),
                          LayoutOrder = index78,
                          ZIndex = 12,
                          Children = {
                            create2("UICorner", { CornerRadius = UDim.new(0, 6) }),
                            create2("UIStroke", {
                              Color = Color3.fromRGB(65, 220, 110),
                              Transparency = v552 and 0.55 or 0.9,
                              Thickness = 1,
                              ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                            }),
                          },
                        }, v543)

                        local v554 = create2("Frame", {
                          BackgroundColor3 = Color3.fromRGB(65, 220, 110),
                          BackgroundTransparency = v552 and 0 or 1,
                          AnchorPoint = Vector2.new(0, 0.5),
                          Position = UDim2.new(0, 6, 0.5, 0),
                          Size = UDim2.new(0, 3, 0, 14),
                          ZIndex = 13,
                          Children = {
                            create2("UICorner", { CornerRadius = UDim.new(1, 0) }),
                            create2("UIGradient", {
                              Color = ColorSequence.new({
                                ColorSequenceKeypoint.new(0, Color3.fromRGB(150, 255, 175)),
                                ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 145, 65)),
                              }),
                              Rotation = 90,
                            }),
                          },
                        }, v553)

                        local v555 = create2("TextLabel", {
                          BackgroundTransparency = 1,
                          Position = UDim2.new(0, 16, 0, 0),
                          Size = UDim2.new(1, -24, 1, 0),
                          Font = Enum.Font.GothamBold,
                          Text = value96,
                          TextSize = 12,
                          TextColor3 = v552 and Color3.fromRGB(150, 255, 175)
                            or Color3.fromRGB(190, 190, 205),
                          TextXAlignment = Enum.TextXAlignment.Left,
                          ZIndex = 13,
                        }, v553)

                        local v556

                        if multi then
                          v556 = create2("TextLabel", {
                            BackgroundTransparency = 1,
                            AnchorPoint = Vector2.new(1, 0.5),
                            Position = UDim2.new(1, -8, 0.5, 0),
                            Size = UDim2.new(0, 14, 0, 14),
                            Font = Enum.Font.GothamBold,
                            Text = v552 and "★" or "",
                            TextSize = 11,
                            TextColor3 = Color3.fromRGB(65, 220, 110),
                            ZIndex = 13,
                          }, v553)
                        end

                        local v557 = create2("TextButton", {
                          BackgroundTransparency = 1,
                          Size = UDim2.new(1, 0, 1, 0),
                          Text = "",
                          ZIndex = 14,
                        }, v553)

                        v557.MouseEnter:Connect(function()
                          v4:Tween(v553, { BackgroundTransparency = 0.35 }, 0.15)
                          v4:Tween(v555, { TextColor3 = Color3.fromRGB(230, 220, 255) }, 0.15)
                        end)

                        v557.MouseLeave:Connect(function()
                          local v558 = table.find(v535, index79) ~= nil

                          v4:Tween(
                            v553, { BackgroundTransparency = v558 and 0.3 or 0.55 }, 0.15
                          )

                          v4:Tween(v555, {
                            TextColor3 = v558 and Color3.fromRGB(150, 255, 175)
                              or Color3.fromRGB(190, 190, 205),
                          }, 0.15)
                        end)

                        v557.MouseButton1Click:Connect(function()
                          CircleClick(v553, getMouse.X, getMouse.Y)
                          local v559

                          if multi then
                            if table.find(v535, index79) then
                              f44(index79)
                              v559 = false
                            else
                              f45(index79)
                              v559 = true
                            end

                            v4:Tween(v554, { BackgroundTransparency = v559 and 0 or 1 }, 0.2)

                            v4:Tween(
                              v553, { BackgroundTransparency = v559 and 0.3 or 0.55 }, 0.2
                            )

                            v4:Tween(v555, {
                              TextColor3 = v559 and Color3.fromRGB(150, 255, 175)
                                or Color3.fromRGB(190, 190, 205),
                            }, 0.2)

                            if v556 then
                              v556.Text = v559 and "✓" or ""
                            end

                            local v560 = f43()
                            v538.Text = f46(v560, 2)

                            if flag3 and (not locked4 or v126.HasKeyAccess()) then
                              save:ElementSave(flag3, v560)
                            end

                            callback5(v560)
                          else
                            table.clear(v535)
                            table.insert(v535, index79)

                            v538.Text = options[index79]

                            if flag3 and (not locked4 or v126.HasKeyAccess()) then
                              save:ElementSave(flag3, options[index79])
                            end

                            callback5(options[index79])
                            f48()
                          end
                        end)
                      end

                      if multi then
                        v538.Text = f46(f43(), 2)
                      else
                        v538.Text = options[v535[1]] or "None"
                      end
                    end

                    v542:GetPropertyChangedSignal("Text"):Connect(function() f49(v542.Text) end)

                    v539.MouseButton1Click:Connect(function()
                      v542.Text = ""
                      f49()
                      local absoluteSize4 = v539.AbsoluteSize

                      v541.Position = f47(v539, v182)
                      v541.Size = UDim2.new(0, absoluteSize4.X, 0, absoluteSize4.Y)
                      v541.BackgroundTransparency = 0.5
                      v541.Visible = true

                      v540.BackgroundTransparency = 1
                      v540.Visible = true

                      v4:Tween(
                        v540, { BackgroundTransparency = 0.45 }, 0.26, Enum.EasingStyle.Quart,
                        Enum.EasingDirection.Out
                      )

                      v4:Tween(v541, {
                        Position = UDim2.new(0.5, 0, 0.5, 0),
                        Size = udim15,
                        BackgroundTransparency = 0,
                      }, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

                      v4:Tween(
                        v539, { Rotation = 180 }, 0.26, Enum.EasingStyle.Back,
                        Enum.EasingDirection.Out
                      )

                      v4:Tween(v537, { Transparency = 0.35 }, 0.22)
                    end)

                    v551.MouseButton1Click:Connect(f48)

                    v540.InputBegan:Connect(function(input15)
                      if input15.UserInputType == Enum.UserInputType.MouseButton1 then
                        f48()
                      end
                    end)

                    callback5(multi and f43() or options[v535[1]] or "None")

                    if locked4 and flag3 then
                      table.insert(v137, {
                        saveKey = flag3,
                        UpdateFn = function()
                          table.clear(v535)

                          local function f52(p266)
                            if #options < 1 then
                              return
                            else
                              local v561 = type(p266) == "number"
                                  and math.clamp(p266, 1, #options)
                                or type(p266) == "string" and table.find(options, p266)

                              if v561 then
                                f45(v561)
                              end

                              return
                            end
                          end

                          if v126.HasKeyAccess() then
                            local get35 = save:Get(flag3, nil)

                            if multi then
                              if typeof(get35) == "table" then
                                for index80, value97 in ipairs(get35) do
                                  f52(value97)
                                end
                              end

                              if #v535 == 0 and #options > 0 then
                                f45(1)
                              end

                              v538.Text = f46(f43(), 2)
                              callback5(f43())
                            else
                              local v562 = get35
                              v562 = get35 and table.find(options, get35)

                              if v562 then
                                f45(v562)
                              else
                                f52(default4)
                              end

                              if #v535 == 0 and #options > 0 then
                                f45(1)
                              end

                              v538.Text = options[v535[1]] or "None"
                              callback5(options[v535[1]] or "None")
                            end
                          elseif multi then
                            if typeof(default4) == "table" then
                              for index81, value98 in ipairs(default4) do
                                f52(value98)
                              end
                            else
                              f52(default4)
                            end

                            if #v535 == 0 and #options > 0 then
                              f45(1)
                            end

                            v538.Text = f46(f43(), 2)
                            callback5(f43())
                          else
                            f52(default4)

                            if #v535 == 0 and #options > 0 then
                              f45(1)
                            end

                            v538.Text = options[v535[1]] or "None"
                            callback5(options[v535[1]] or "None")
                          end
                        end,
                      })
                    end

                    if flag3 then
                      save:RegisterControl(flag3, {
                        Type = "Dropdown",
                        Default = default4,
                        Set = function(p267, p268)
                          if multi then
                            table.clear(v535)

                            if type(p267) == "table" then
                              for index82, value99 in ipairs(p267) do
                                local v563 = table.find(options, value99)

                                if v563 then
                                  f45(v563)
                                end
                              end
                            end

                            v538.Text = f46(f43(), 2)

                            if p268 ~= false then
                              pcall(callback5, f43())
                            end
                          else
                            table.clear(v535)
                            local v564 = type(p267) == "string"

                            local v565 = v564
                            v565 = v564 and table.find(options, p267)

                            local v566 = v565
                            v566 = v565 or type(p267) == "number" and p267

                            if v566 and options[v566] then
                              table.insert(v535, v566)
                              v538.Text = options[v566]

                              if p268 ~= false then
                                pcall(callback5, options[v566])
                              end
                            end
                          end
                        end,
                        Get = function()
                          return multi and f43() or options[v535[1]] or "None"
                        end,
                      })
                    end

                    RegisterKeyLocked(v548, locked4)
                    RegisterTranslatable(v549, name11)

                    return {
                      Clear = function()
                        for index83, value100 in ipairs(v543:GetChildren()) do
                          if value100:IsA("Frame") then
                            value100:Destroy()
                          end
                        end

                        v535 = {}
                        v536 = {}
                        v538.Text = "None"
                        callback5(multi and {} or "None")
                      end,
                      Refresh = function(p269, p270)
                        options = p270 or {}
                        local v567 = f43()
                        table.clear(v535)

                        local function f53(p271)
                          if p271 then
                            local v568 = table.find(options, p271)

                            if v568 then
                              f45(v568)
                            end
                          end
                        end

                        if multi then
                          for index84, value101 in ipairs(v567) do
                            f53(value101)
                          end

                          if #v535 == 0 and #options > 0 then
                            f45(1)
                          end
                        else
                          f53(v567[1])

                          if #v535 == 0 and #options > 0 then
                            f45(1)
                          end
                        end

                        v538.Text = multi and f46(f43(), 2) or options[v535[1]] or "None"
                        f49(v542.Text)
                      end,
                    }
                  end
                end

                function v477:addTextbox(p272, p273, p274, p275, p276, p277)
                  local v569 = p272
                  local condition6 = p276
                  local adjustable = p274
                  local v570 = p273
                  local flag4 = p275

                  if type(v569) == "table" then
                    local v571 = v569
                    local name12 = v571.Name

                    local title3 = name12
                    title3 = name12 or v571.Title or v571.Text or "Textbox"

                    local callback6 = v571.Callback
                    v569 = title3
                    v570 = callback6 or v571.Function or v570
                    adjustable = v571.Adjustable or v571.AdjustableTitle or adjustable
                    flag4 = v571.Flag or v571.SaveKey or v571.savekey or flag4
                    condition6 = v571.Condition or condition6
                    local liteAllowed5 = v571.LiteAllowed
                  end

                  local get36, v572, v573, v574, v575, v576

                  if not checkCondition(condition6) then
                    return v146
                  else
                    v570 = v570 or function() end

                    if flag4 then
                      save:RegisterKey(flag4)
                    end

                    get36 = flag4 and save:Get(flag4, "") or ""

                    local v577 = create2("Frame", {
                      BackgroundColor3 = ThemeColor("Primary"),
                      BackgroundTransparency = 0.4,
                      BorderSizePixel = 0,
                      Size = UDim2.new(1, -25, 0, 96),
                      ClipsDescendants = true,
                      Children = { create2("UICorner", { CornerRadius = UDim.new(0, 8) }) },
                    }, v475)

                    f30(v577, v569 or "Textbox")

                    create2("TextLabel", {
                      BackgroundTransparency = 1,
                      Position = UDim2.new(0, 10, 0, 6),
                      Size = UDim2.new(1, -20, 0, 20),
                      Font = Enum.Font.GothamBold,
                      TextColor3 = Color3.fromRGB(220, 220, 230),
                      TextXAlignment = Enum.TextXAlignment.Left,
                      Text = v569 or "Textbox",
                      TextWrapped = false,
                      TextScaled = true,
                      TextTruncate = Enum.TextTruncate.AtEnd,
                      ZIndex = 3,
                      Children = { MakeTextConstraint(15, 8) },
                    }, v577)

                    create2("Frame", {
                      BackgroundColor3 = Color3.fromRGB(110, 55, 190),
                      BackgroundTransparency = 0.82,
                      BorderSizePixel = 0,
                      Position = UDim2.new(0, 10, 0, 30),
                      Size = UDim2.new(1, -20, 0, 1),
                      ZIndex = 3,
                    }, v577)

                    v572 = create2("Frame", {
                      BackgroundColor3 = Color3.fromRGB(10, 10, 16),
                      BackgroundTransparency = 0.1,
                      BorderSizePixel = 0,
                      Position = UDim2.new(0, 10, 0, 38),
                      Size = UDim2.new(1, -20, 0, 24),
                      ClipsDescendants = true,
                      ZIndex = 3,
                      Children = { create2("UICorner", { CornerRadius = UDim.new(0, 6) }) },
                    }, v577)

                    v573 = create2("UIStroke", {
                      Color = Color3.fromRGB(110, 55, 190),
                      Transparency = 0.78,
                      Thickness = 1,
                      ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    }, v572)

                    v574 = create2("TextBox", {
                      BackgroundTransparency = 1,
                      BorderSizePixel = 0,
                      Position = UDim2.new(0, 10, 0, 0),
                      Size = UDim2.new(1, -18, 1, 0),
                      Font = Enum.Font.GothamSemibold,
                      TextColor3 = Color3.fromRGB(210, 195, 255),
                      PlaceholderColor3 = Color3.fromRGB(110, 85, 150),
                      PlaceholderText = v569 or "Enter here...",
                      TextSize = 12,
                      TextXAlignment = Enum.TextXAlignment.Left,
                      TextTruncate = Enum.TextTruncate.AtEnd,
                      Text = get36,
                      ClearTextOnFocus = false,
                      ZIndex = 4,
                    }, v572)

                    local v578 = create2("Frame", {
                      BackgroundTransparency = 1,
                      Position = UDim2.new(0, 10, 0, 70),
                      Size = UDim2.new(1, -20, 0, 20),
                      ZIndex = 3,
                      Children = {
                        create2("UIListLayout", {
                          FillDirection = Enum.FillDirection.Horizontal,
                          Padding = UDim.new(0, 6),
                          HorizontalAlignment = Enum.HorizontalAlignment.Right,
                          VerticalAlignment = Enum.VerticalAlignment.Center,
                          SortOrder = Enum.SortOrder.LayoutOrder,
                        }),
                      },
                    }, v577)

                    v575 = create2("TextButton", {
                      BackgroundColor3 = Color3.fromRGB(110, 55, 190),
                      BackgroundTransparency = 0.84,
                      BorderSizePixel = 0,
                      LayoutOrder = 1,
                      Size = UDim2.new(0, 54, 0, 20),
                      Text = "Clear",
                      TextColor3 = Color3.fromRGB(170, 120, 240),
                      Font = Enum.Font.GothamBold,
                      TextSize = 11,
                      AutoButtonColor = false,
                      ZIndex = 3,
                      Children = {
                        create2("UICorner", { CornerRadius = UDim.new(0, 5) }),
                        create2("UIStroke", {
                          Color = Color3.fromRGB(110, 55, 190),
                          Transparency = 0.72,
                          Thickness = 1,
                          ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        }),
                      },
                    }, v578)

                    v576 = create2("TextButton", {
                      BackgroundColor3 = Color3.fromRGB(110, 55, 190),
                      BackgroundTransparency = 0.45,
                      BorderSizePixel = 0,
                      LayoutOrder = 2,
                      Size = UDim2.new(0, 60, 0, 20),
                      Text = adjustable or "Confirm",
                      TextColor3 = Color3.fromRGB(200, 170, 255),
                      Font = Enum.Font.GothamBold,
                      TextSize = 11,
                      AutoButtonColor = false,
                      ZIndex = 3,
                      Children = {
                        create2("UICorner", { CornerRadius = UDim.new(0, 5) }),
                        create2("UIStroke", {
                          Color = Color3.fromRGB(110, 55, 190),
                          Transparency = 0.6,
                          Thickness = 1,
                          ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        }),
                      },
                    }, v578)

                    v574.Focused:Connect(function()
                      v4:Tween(v573, { Transparency = 0.42 }, 0.2)
                      v4:Tween(v572, { BackgroundTransparency = 0 }, 0.2)
                    end)

                    v574.FocusLost:Connect(function()
                      v4:Tween(v573, { Transparency = 0.78 }, 0.28)
                      v4:Tween(v572, { BackgroundTransparency = 0.1 }, 0.28)
                    end)

                    v575.MouseEnter:Connect(function()
                      v4:Tween(v575, { BackgroundTransparency = 0.6 }, 0.15)
                    end)

                    v575.MouseLeave:Connect(function()
                      v4:Tween(v575, { BackgroundTransparency = 0.84 }, 0.2)
                    end)

                    v576.MouseEnter:Connect(function()
                      v4:Tween(v576, { BackgroundTransparency = 0.25 }, 0.15)
                    end)

                    v576.MouseLeave:Connect(function()
                      v4:Tween(v576, { BackgroundTransparency = 0.45 }, 0.2)
                    end)

                    v575.MouseButton1Click:Connect(function()
                      CircleClick(v575, getMouse.X, getMouse.Y)
                      v574.Text = ""

                      if flag4 then
                        save:ElementSave(flag4, "")
                      end

                      v574:CaptureFocus()
                    end)

                    v576.MouseButton1Click:Connect(function()
                      CircleClick(v576, getMouse.X, getMouse.Y)

                      if v574.Text ~= "" then
                        if flag4 then
                          save:ElementSave(flag4, v574.Text)
                        end

                        v570(v574.Text)
                      end
                    end)

                    v574.FocusLost:Connect(function(p278)
                      if p278 and v574.Text ~= "" then
                        if flag4 then
                          save:ElementSave(flag4, v574.Text)
                        end

                        v570(v574.Text)
                      end
                    end)

                    if get36 ~= "" then
                      task.defer(function() v570(get36) end)
                    end

                    if flag4 then
                      save:RegisterControl(flag4, {
                        Type = "Textbox",
                        Default = "",
                        Set = function(p279, p280)
                          local v579 = tostring(p279 or "")
                          v574.Text = v579

                          if p280 ~= false then
                            pcall(v570, v579)
                          end
                        end,
                        Get = function() return v574.Text end,
                      })
                    end

                    return {
                      TextBox = v574,
                      Clear = v575,
                      Join = v576,
                      Frame = v577,
                      SetText = function(p281, p282) v574.Text = p282 or "" end,
                      GetText = function() return v574.Text end,
                    }
                  end
                end

                function v477:addLabel(p283, p284, p285)
                  local locked5 = p285
                  local name13 = p283
                  local description3 = p284

                  if type(name13) == "table" then
                    local v580 = name13
                    name13 = v580.Name or v580.Title or v580.Text or "Label"
                    description3 = v580.Description or v580.Desc or v580.Content or description3
                    locked5 = v580.Locked or locked5
                  end

                  local v581 = {}
                  local gotham4 = Enum.Font.Gotham

                  local v582 = create2("Frame", {
                    BackgroundColor3 = ThemeColor("Primary"),
                    BackgroundTransparency = 0.4,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, -24, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    ClipsDescendants = false,
                    Children = {
                      create2("UICorner", { CornerRadius = UDim.new(0, 6) }),
                      create2("UIStroke", {
                        Color = Color3.fromRGB(110, 55, 190),
                        Transparency = 0.88,
                        Thickness = 1,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                      }),
                      create2("UIPadding", {
                        PaddingTop = UDim.new(0, 10),
                        PaddingBottom = UDim.new(0, 10),
                        PaddingLeft = UDim.new(0, 14),
                        PaddingRight = UDim.new(0, 14),
                      }),
                      create2("UIListLayout", {
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        Padding = UDim.new(0, 6),
                      }),
                    },
                  }, v475)

                  RegisterKeyLocked(v582, locked5)

                  local v583 = create2("TextLabel", {
                    Name = "TitleLabel",
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    LayoutOrder = 1,
                    Font = Enum.Font.GothamBold,
                    TextColor3 = Color3.fromRGB(230, 230, 240),
                    TextSize = 13,
                    TextWrapped = true,
                    RichText = true,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = Enum.TextYAlignment.Top,
                    Text = name13 or "Default Title",
                    ZIndex = 3,
                  }, v582)

                  local visible2 = description3 and description3 ~= ""

                  local v584 = create2("Frame", {
                    Name = "Divider",
                    BackgroundColor3 = Color3.fromRGB(110, 55, 190),
                    BackgroundTransparency = 0.78,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 1),
                    LayoutOrder = 2,
                    Visible = visible2,
                    ZIndex = 3,
                    Children = {
                      create2("UIGradient", {
                        Transparency = NumberSequence.new({
                          NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.7, 0),
                          NumberSequenceKeypoint.new(1, 1),
                        }),
                      }),
                    },
                  }, v582)

                  local v585 = create2("TextLabel", {
                    Name = "DescLabel",
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    LayoutOrder = 3,
                    Font = gotham4,
                    TextColor3 = Color3.fromRGB(165, 165, 185),
                    TextSize = 11,
                    TextWrapped = true,
                    RichText = true,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = Enum.TextYAlignment.Top,
                    Text = description3 or "",
                    Visible = visible2,
                    ZIndex = 3,
                  }, v582)

                  RegisterTranslatable(v583, name13)
                  RegisterTranslatable(v585, description3)

                  function v581.RefreshTitle(p286, p287)
                    name13 = p287
                    v583.Text = p287 or ""
                  end

                  function v581.RefreshDesc(p288, p289)
                    description3 = p289
                    v585.Text = p289 or ""
                    local visible3 = p289 and p289 ~= ""
                    v584.Visible = visible3
                    v585.Visible = visible3
                  end

                  return v581
                end

                function v477:addButtonGrid(p290, p291)
                  local v586 = p291 or {}
                  local v587 = math.ceil(#v586 / 3)

                  local v588 = 8 + (p290 and p290 ~= "" and 26 or 0)
                    + (v587 * 26 + math.max(v587 - 1, 0) * 4) + 8

                  local v589 = create2("Frame", {
                    BackgroundColor3 = ThemeColor("Primary"),
                    BackgroundTransparency = 0.4,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, -25, 0, v588),
                    ClipsDescendants = true,
                    Children = { create2("UICorner", { CornerRadius = UDim.new(0, 6) }) },
                  }, v475)

                  f30(v589, p290 or "ButtonGrid")

                  if p290 and p290 ~= "" then
                    create2("TextLabel", {
                      BackgroundTransparency = 1,
                      Position = UDim2.new(0, 12, 0, 8),
                      Size = UDim2.new(1, -20, 0, 20),
                      Font = Enum.Font.GothamBold,
                      Text = p290,
                      TextColor3 = Color3.fromRGB(210, 200, 230),
                      TextSize = 12,
                      TextXAlignment = Enum.TextXAlignment.Left,
                      ZIndex = 3,
                    }, v589)
                  end

                  for index85, value102 in ipairs(v586) do
                    local v590 = value102
                    local v591 = (index85 - 1) % 3
                    local v592 = math.floor((index85 - 1) / 3)
                    local v593 = v590.Locked == true

                    local color14 = v593
                    color14 = v593 and Color3.fromRGB(30, 18, 50)

                    local color15 = color14
                    color15 = color14 or Color3.fromRGB(55, 28, 100)

                    local backgroundTransparency2 = v593 and 0.55 or 0.3

                    local udim16 = UDim2.new(
                      v591 / 3, v591 == 0 and 10 or 2, 0,
                      8 + (p290 and p290 ~= "" and 26 or 0) + v592 * 30
                    )

                    local v594 = create2("TextButton", {
                      BackgroundColor3 = color15,
                      BackgroundTransparency = backgroundTransparency2,
                      BorderSizePixel = 0,
                      Position = udim16,
                      Size = UDim2.new(
                        0.33333333333333, v591 == 0 and -12 or v591 == 2 and -12 or -4, 0, 26
                      ),
                      AutoButtonColor = false,
                      ClipsDescendants = true,
                      Text = "",
                      ZIndex = 3,
                      Children = {
                        create2("UICorner", { CornerRadius = UDim.new(0, 3) }),
                        create2("TextLabel", {
                          Name = "BtnLabel",
                          BackgroundTransparency = 1,
                          Size = UDim2.new(1, v593 and -18 or -4, 1, 0),
                          Position = UDim2.new(0, 2, 0, 0),
                          Font = Enum.Font.GothamBold,
                          Text = v590.Label or "Button " .. index85,
                          TextColor3 = v593 and Color3.fromRGB(105, 145, 115)
                            or Color3.fromRGB(210, 185, 255),
                          TextScaled = true,
                          TextTruncate = Enum.TextTruncate.AtEnd,
                          ZIndex = 4,
                          Children = { MakeTextConstraint(12, 8) },
                        }),
                      },
                    }, v589)

                    if v593 then
                      create2("ImageLabel", {
                        BackgroundTransparency = 1,
                        AnchorPoint = Vector2.new(1, 0.5),
                        Position = UDim2.new(1, -4, 0.5, 0),
                        Size = UDim2.new(0, 10, 0, 10),
                        Image = "rbxassetid://7733992528",
                        ImageColor3 = Color3.fromRGB(75, 180, 100),
                        ImageTransparency = 0.3,
                        ZIndex = 5,
                      }, v594)
                    end

                    local btnLabel = v594:FindFirstChild("BtnLabel")

                    if v593 then
                      v594.MouseButton1Click:Connect(function()
                        CircleClick(v594, getMouse.X, getMouse.Y)

                        if typeof(v590.LockedCallback) == "function" then
                          v590.LockedCallback()
                        else
                          v3.Notification:Notify({
                            Title = "Locked",
                            Description = (v590.Label or "This button")
                              .. " is currently locked.",
                          }, { Time = 2 })
                        end
                      end)
                    else
                      v594.MouseEnter:Connect(function()
                        v4:Tween(
                          v594, { BackgroundTransparency = 0.1 }, 0.15, Enum.EasingStyle.Quint
                        )

                        if btnLabel then
                          v4:Tween(
                            btnLabel, { TextColor3 = Color3.fromRGB(235, 220, 255) }, 0.15
                          )
                        end
                      end)

                      v594.MouseLeave:Connect(function()
                        v4:Tween(
                          v594, { BackgroundTransparency = 0.3 }, 0.2, Enum.EasingStyle.Quint
                        )

                        if btnLabel then
                          v4:Tween(
                            btnLabel, { TextColor3 = Color3.fromRGB(210, 185, 255) }, 0.2
                          )
                        end
                      end)

                      v594.MouseButton1Click:Connect(function()
                        CircleClick(v594, getMouse.X, getMouse.Y)

                        if typeof(v590.Callback) == "function" then
                          v590.Callback()
                        end
                      end)
                    end
                  end

                  return v589
                end

                function v477:addMultiDropdown(p292, p293, p294, p295, p296, p297, p298, p299)
                  if type(p292) == "table" then
                    p292.Multi = true
                    p292.Multimode = true
                    p292.multimode = true

                    return v477:addDropdown(p292)
                  end

                  return v477:addDropdown(p292, p293, p294, p295, p296, true, p297, p298, p299)
                end

                function v477:addKeybind(p300, p301, p302, p303, p304, p305)
                  local v595 = p300
                  local condition7 = p304
                  local key24 = p301
                  local callback7 = p302
                  local flag5 = p303

                  if type(v595) == "table" then
                    local v596 = v595
                    local name14 = v596.Name

                    local title4 = name14
                    title4 = name14 or v596.Title or v596.Text or "Keybind"

                    local default5 = v596.Default
                    v595 = title4
                    key24 = default5 or v596.Key or Enum.KeyCode.RightControl
                    callback7 = v596.Callback or v596.Function or function() end
                    flag5 = v596.Flag or v596.SaveKey or v596.savekey
                    condition7 = v596.Condition
                    local liteAllowed6 = v596.LiteAllowed
                  end

                  local f54, v597, v598, v599, f55

                  if not checkCondition(condition7) then
                    return v146
                  else
                    callback7 = callback7 or function() end
                    local rightControl2 = key24 or Enum.KeyCode.RightControl

                    if typeof(rightControl2) == "string" then
                      rightControl2 = Enum.KeyCode[rightControl2] or Enum.KeyCode.RightControl
                    end

                    v597 = rightControl2

                    if flag5 then
                      save:RegisterKey(flag5)
                      local get37 = save:Get(flag5, nil)

                      if get37 then
                        if typeof(get37) == "string" and Enum.KeyCode[get37] then
                          v597 = Enum.KeyCode[get37]
                        elseif typeof(get37) == "EnumItem" then
                          v597 = get37
                        end
                      end
                    end

                    v598 = false

                    local v600 = create2("Frame", {
                      BackgroundColor3 = ThemeColor("Primary"),
                      BackgroundTransparency = 0.4,
                      BorderSizePixel = 0,
                      Size = UDim2.new(1, -25, 0, 32),
                      ClipsDescendants = true,
                      Children = {
                        create2("UICorner", { CornerRadius = UDim.new(0, 6) }),
                        create2("TextLabel", {
                          Name = "KeybindTitle",
                          BackgroundTransparency = 1,
                          Position = UDim2.new(0, 12, 0, 0),
                          Size = UDim2.new(1, -95, 1, 0),
                          Font = Enum.Font.GothamBold,
                          Text = v595,
                          TextColor3 = Color3.fromRGB(210, 210, 220),
                          TextXAlignment = Enum.TextXAlignment.Left,
                          TextScaled = true,
                          TextTruncate = Enum.TextTruncate.AtEnd,
                          ZIndex = 3,
                          Children = { MakeTextConstraint(14, 8) },
                        }),
                      },
                    }, v475)

                    RegisterTranslatable(v600:FindFirstChild("KeybindTitle"), v595)
                    f30(v600, v595)

                    v599 = create2("TextButton", {
                      BackgroundColor3 = Color3.fromRGB(15, 12, 24),
                      BackgroundTransparency = 0.2,
                      BorderSizePixel = 0,
                      AnchorPoint = Vector2.new(1, 0.5),
                      Position = UDim2.new(1, -8, 0.5, 0),
                      Size = UDim2.new(0, 75, 0, 22),
                      Font = Enum.Font.GothamBold,
                      Text = v597.Name,
                      TextColor3 = Color3.fromRGB(65, 220, 110),
                      TextSize = 11,
                      TextTruncate = Enum.TextTruncate.AtEnd,
                      AutoButtonColor = false,
                      ZIndex = 4,
                      Children = {
                        create2("UICorner", { CornerRadius = UDim.new(0, 5) }),
                        create2("UIStroke", {
                          Color = Color3.fromRGB(65, 220, 110),
                          Transparency = 0.75,
                          Thickness = 1,
                          ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        }),
                      },
                    }, v600)

                    function f54(p306)
                      v597 = p306

                      v599.Text = f55(p306)
                      v599.TextColor3 = Color3.fromRGB(65, 220, 110)

                      if flag5 then
                        save:ElementSave(flag5, p306.Name)
                      end

                      pcall(callback7, p306)
                    end

                    function f55(p307)
                      if typeof(p307) == "EnumItem" then
                        return p307.Name
                      end

                      return tostring(p307 or "None")
                    end

                    v599.MouseButton1Click:Connect(function()
                      if v598 then
                        return
                      end

                      v598 = true

                      v599.Text = "..."
                      v599.TextColor3 = Color3.fromRGB(255, 230, 140)

                      local connect3 = nil

                      connect3 = userInputService.InputBegan:Connect(function(input16)
                        if input16.UserInputType == Enum.UserInputType.Keyboard then
                          if input16.KeyCode ~= Enum.KeyCode.Unknown then
                            if connect3 then
                              connect3:Disconnect()
                              connect3 = nil
                            end

                            v598 = false
                            f54(input16.KeyCode)
                          end
                        elseif input16.UserInputType == Enum.UserInputType.MouseButton1
                          or input16.UserInputType == Enum.UserInputType.MouseButton2
                          or input16.UserInputType == Enum.UserInputType.MouseButton3 then
                          if connect3 then
                            connect3:Disconnect()
                            connect3 = nil
                          end

                          v598 = false
                          f54(input16.UserInputType)
                        end
                      end)

                      task.delay(6, function()
                        if v598 then
                          if connect3 then
                            connect3:Disconnect()
                            connect3 = nil
                          end

                          v598 = false

                          v599.Text = f55(v597)
                          v599.TextColor3 = Color3.fromRGB(65, 220, 110)
                        end
                      end)
                    end)

                    local v601 = {
                      Set = function(p308, p309)
                        if typeof(p309) == "string" and Enum.KeyCode[p309] then
                          f54(Enum.KeyCode[p309])
                        elseif typeof(p309) == "EnumItem" then
                          f54(p309)
                        end
                      end,
                      Get = function(p310) return v597 end,
                      Instance = v600,
                    }

                    if flag5 then
                      save:RegisterControl(flag5, {
                        Type = "Keybind",
                        Default = rightControl2 and rightControl2.Name or "RightControl",
                        Set = function(p311, p312)
                          local v602 = typeof(p311) == "string" and Enum.KeyCode[p311]
                            or typeof(p311) == "EnumItem" and p311

                          if v602 then
                            v597 = v602
                            v599.Text = f55(v602)

                            if p312 ~= false then
                              pcall(callback7, v602)
                            end
                          end
                        end,
                        Get = function() return v597 and v597.Name or "None" end,
                      })
                    end

                    return v601
                  end
                end

                function v477:addLine()
                  return (create2("Frame", {
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, -25, 0, 8),
                    Children = {
                      create2("Frame", {
                        BackgroundColor3 = Color3.fromRGB(80, 60, 110),
                        BackgroundTransparency = 0.55,
                        BorderSizePixel = 0,
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Position = UDim2.new(0.5, 0, 0.5, 0),
                        Size = UDim2.new(1, 0, 0, 1),
                        Children = {
                          create2("UIGradient", {
                            Transparency = NumberSequence.new({
                              NumberSequenceKeypoint.new(0, 1),
                              NumberSequenceKeypoint.new(0.2, 0),
                              NumberSequenceKeypoint.new(0.8, 0),
                              NumberSequenceKeypoint.new(1, 1),
                            }),
                          }),
                        },
                      }),
                    },
                  }, v475))
                end

                function v477:addParagraph(p313, p314)
                  local content = p314
                  local title5 = p313

                  if type(title5) == "table" then
                    local v603 = title5
                    title5 = v603.Title or v603.Name or "Paragraph"
                    content = v603.Content or v603.Text or v603.Description or ""
                  end

                  local v604 = title5 or "Paragraph"
                  local v605 = content or ""
                  local v606, v607 = util.DescMetrics(v605, Enum.Font.Gotham, 11, 180)
                  local v608 = math.max(34 + v607, 42)

                  local v609 = create2("Frame", {
                    BackgroundColor3 = ThemeColor("Primary"),
                    BackgroundTransparency = 0.45,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, -25, 0, v608),
                    ClipsDescendants = true,
                    Children = {
                      create2("UICorner", { CornerRadius = UDim.new(0, 6) }),
                      create2("TextLabel", {
                        Name = "ParaTitle",
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 12, 0, 6),
                        Size = UDim2.new(1, -24, 0, 16),
                        Font = Enum.Font.GothamBold,
                        Text = v604,
                        TextColor3 = Color3.fromRGB(220, 215, 235),
                        TextSize = 13,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        ZIndex = 3,
                      }),
                      create2("TextLabel", {
                        Name = "ParaContent",
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 12, 0, 24),
                        Size = UDim2.new(1, -24, 0, math.max(v607, 14)),
                        Font = Enum.Font.Gotham,
                        Text = v605,
                        TextColor3 = Color3.fromRGB(155, 150, 175),
                        TextSize = 11,
                        TextWrapped = true,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        TextYAlignment = Enum.TextYAlignment.Top,
                        ZIndex = 3,
                      }),
                    },
                  }, v475)

                  RegisterTranslatable(v609:FindFirstChild("ParaTitle"), v604)
                  RegisterTranslatable(v609:FindFirstChild("ParaContent"), v605)

                  return {
                    SetTitle = function(p315, text14)
                      local paraTitle = v609:FindFirstChild("ParaTitle")

                      if paraTitle then
                        paraTitle.Text = text14
                      end
                    end,
                    SetContent = function(p316, text15)
                      local paraContent = v609:FindFirstChild("ParaContent")

                      if paraContent then
                        paraContent.Text = text15
                      end
                    end,
                    Instance = v609,
                  }
                end

                function v477:addColorPicker(p317, p318, p319, p320, p321, p322)
                  local name15 = p317
                  local default6 = p318
                  local callback8 = p319
                  local condition8 = p321
                  local flag6 = p320

                  if type(name15) == "table" then
                    local v610 = name15
                    name15 = v610.Name or v610.Title or v610.Text or "Color Picker"

                    default6 = v610.Default or v610.Color or v610.Value
                      or Color3.fromRGB(65, 220, 110)

                    callback8 = v610.Callback or v610.Function or callback8
                    flag6 = v610.Flag or v610.SaveKey or v610.savekey or flag6
                    condition8 = v610.Condition or condition8
                    local liteAllowed7 = v610.LiteAllowed
                  end

                  local color16, v611, v612, v613, v614, v615, v616, v617, v618,
                    colorPreviewChip, svBox, hueBar, rgbDisplay, f56, f57

                  if not checkCondition(condition8) then
                    return v146
                  else
                    callback8 = callback8 or function() end
                    default6 = v126.HexToColor(default6, Color3.fromRGB(65, 220, 110))
                    color16 = default6
                    local v619, v620
                    v611, v619, v620 = color16:ToHSV()
                    v612 = v619
                    v613 = v620
                    v614 = nil

                    if flag6 then
                      save:RegisterKey(flag6)

                      save:RegisterControl(flag6, {
                        Save = function() return v126.ColorToHex(color16) end,
                        Load = function(p323)
                          color16 = v126.HexToColor(p323, color16)
                          local v621
                          v611, v612, v621 = color16:ToHSV()
                          v613 = v621
                          v614(true)
                        end,
                        Reset = function()
                          color16 = default6
                          local v622, v623
                          v611, v622, v623 = color16:ToHSV()
                          v612 = v622
                          v613 = v623
                          v614(true)
                        end,
                      })

                      local get38 = save:Get(flag6, nil)

                      if get38 then
                        color16 = v126.HexToColor(get38, color16)
                        local v624, v625, v626 = color16:ToHSV()
                        v611 = v624
                        v612 = v625
                        v613 = v626
                      end
                    end

                    v615 = false
                    v616 = false
                    v617 = false

                    v618 = create2("Frame", {
                      Name = "ColorPickerFrame",
                      BackgroundColor3 = ThemeColor("Primary"),
                      BackgroundTransparency = 0.4,
                      BorderSizePixel = 0,
                      Size = UDim2.new(1, -25, 0, 32),
                      ClipsDescendants = true,
                      Children = {
                        create2("UICorner", { CornerRadius = UDim.new(0, 6) }),
                        create2("TextLabel", {
                          Name = "CPTitle",
                          BackgroundTransparency = 1,
                          Position = UDim2.new(0, 12, 0, 0),
                          Size = UDim2.new(1, -95, 0, 32),
                          Font = Enum.Font.GothamBold,
                          Text = name15 or "Color Picker",
                          TextColor3 = Color3.fromRGB(215, 210, 230),
                          TextSize = 12,
                          TextXAlignment = Enum.TextXAlignment.Left,
                          TextTruncate = Enum.TextTruncate.AtEnd,
                          ZIndex = 3,
                        }),
                        create2("TextButton", {
                          Name = "ColorPreviewChip",
                          BackgroundColor3 = color16,
                          BorderSizePixel = 0,
                          AnchorPoint = Vector2.new(1, 0.5),
                          Position = UDim2.new(1, -8, 0, 16),
                          Size = UDim2.new(0, 72, 0, 20),
                          AutoButtonColor = false,
                          Text = "",
                          ZIndex = 4,
                          Children = {
                            create2("UICorner", { CornerRadius = UDim.new(0, 4) }),
                            create2("TextLabel", {
                              Name = "HexBadge",
                              BackgroundTransparency = 0.35,
                              BackgroundColor3 = Color3.fromRGB(10, 8, 16),
                              Size = UDim2.new(1, 0, 1, 0),
                              Font = Enum.Font.Code,
                              Text = v126.ColorToHex(color16),
                              TextColor3 = Color3.fromRGB(245, 240, 255),
                              TextSize = 9,
                              TextXAlignment = Enum.TextXAlignment.Center,
                              ZIndex = 5,
                              Children = {
                                create2("UICorner", { CornerRadius = UDim.new(0, 4) }),
                              },
                            }),
                          },
                        }),
                      },
                    }, v475)

                    RegisterTranslatable(v618:FindFirstChild("CPTitle"), name15)
                    f30(v618, name15)
                    colorPreviewChip = v618:FindFirstChild("ColorPreviewChip")

                    local hexBadge = colorPreviewChip
                      and colorPreviewChip:FindFirstChild("HexBadge")

                    local v627 = create2("Frame", {
                      Name = "EditorContainer",
                      BackgroundTransparency = 1,
                      Position = UDim2.new(0, 10, 0, 34),
                      Size = UDim2.new(1, -20, 0, 140),
                      ZIndex = 3,
                      Children = {
                        create2("Frame", {
                          Name = "SVBox",
                          BackgroundColor3 = Color3.fromHSV(v611, 1, 1),
                          BorderSizePixel = 0,
                          Position = UDim2.new(0, 0, 0, 0),
                          Size = UDim2.new(1, -32, 0, 82),
                          ClipsDescendants = true,
                          ZIndex = 4,
                          Children = {
                            create2("UICorner", { CornerRadius = UDim.new(0, 4) }),
                            create2("Frame", {
                              Name = "SatLayer",
                              BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                              BorderSizePixel = 0,
                              Size = UDim2.new(1, 0, 1, 0),
                              ZIndex = 5,
                              Children = {
                                create2("UICorner", { CornerRadius = UDim.new(0, 4) }),
                                create2("UIGradient", {
                                  Transparency = NumberSequence.new({
                                    NumberSequenceKeypoint.new(0, 0),
                                    NumberSequenceKeypoint.new(1, 1),
                                  }),
                                }),
                              },
                            }),
                            create2("Frame", {
                              Name = "ValLayer",
                              BackgroundColor3 = Color3.fromRGB(0, 0, 0),
                              BorderSizePixel = 0,
                              Size = UDim2.new(1, 0, 1, 0),
                              ZIndex = 6,
                              Children = {
                                create2("UICorner", { CornerRadius = UDim.new(0, 4) }),
                                create2("UIGradient", {
                                  Rotation = 90,
                                  Transparency = NumberSequence.new({
                                    NumberSequenceKeypoint.new(0, 1),
                                    NumberSequenceKeypoint.new(1, 0),
                                  }),
                                }),
                              },
                            }),
                            create2("Frame", {
                              Name = "PickerDot",
                              AnchorPoint = Vector2.new(0.5, 0.5),
                              BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                              BorderSizePixel = 0,
                              Position = UDim2.new(v612, 0, 1 - v613, 0),
                              Size = UDim2.new(0, 10, 0, 10),
                              ZIndex = 8,
                              Children = {
                                create2("UICorner", { CornerRadius = UDim.new(1, 0) }),
                                create2("Frame", {
                                  AnchorPoint = Vector2.new(0.5, 0.5),
                                  BackgroundColor3 = Color3.fromRGB(20, 16, 28),
                                  BorderSizePixel = 0,
                                  Position = UDim2.new(0.5, 0, 0.5, 0),
                                  Size = UDim2.new(0, 6, 0, 6),
                                  ZIndex = 9,
                                  Children = {
                                    create2("UICorner", { CornerRadius = UDim.new(1, 0) }),
                                  },
                                }),
                              },
                            }),
                          },
                        }),
                        create2("Frame", {
                          Name = "HueBar",
                          BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                          BorderSizePixel = 0,
                          AnchorPoint = Vector2.new(1, 0),
                          Position = UDim2.new(1, 0, 0, 0),
                          Size = UDim2.new(0, 22, 0, 82),
                          ClipsDescendants = true,
                          ZIndex = 4,
                          Children = {
                            create2("UICorner", { CornerRadius = UDim.new(0, 4) }),
                            create2("UIGradient", {
                              Rotation = 90,
                              Color = ColorSequence.new({
                                ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
                                ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)),
                                ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
                                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
                                ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)),
                                ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
                                ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)),
                              }),
                            }),
                            create2("Frame", {
                              Name = "HueCursor",
                              AnchorPoint = Vector2.new(0.5, 0.5),
                              BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                              BorderSizePixel = 0,
                              Position = UDim2.new(0.5, 0, v611, 0),
                              Size = UDim2.new(1, 0, 0, 3),
                              ZIndex = 7,
                              Children = {
                                create2("UICorner", { CornerRadius = UDim.new(1, 0) }),
                              },
                            }),
                          },
                        }),
                        create2("Frame", {
                          Name = "SwatchesRow",
                          BackgroundTransparency = 1,
                          Position = UDim2.new(0, 0, 0, 88),
                          Size = UDim2.new(1, 0, 0, 20),
                          ZIndex = 4,
                          Children = {
                            create2("UIListLayout", {
                              FillDirection = Enum.FillDirection.Horizontal,
                              SortOrder = Enum.SortOrder.LayoutOrder,
                              Padding = UDim.new(0, 5),
                            }),
                          },
                        }),
                        create2("Frame", {
                          Name = "InfoRow",
                          BackgroundTransparency = 1,
                          Position = UDim2.new(0, 0, 0, 114),
                          Size = UDim2.new(1, 0, 0, 22),
                          ZIndex = 4,
                          Children = {
                            create2("TextLabel", {
                              Name = "RgbDisplay",
                              BackgroundTransparency = 1,
                              Position = UDim2.new(0, 2, 0, 0),
                              Size = UDim2.new(1, -65, 1, 0),
                              Font = Enum.Font.Code,
                              Text = string.format(
                                "RGB: %d, %d, %d", math.floor(color16.R * 255),
                                math.floor(color16.G * 255), math.floor(color16.B * 255)
                              ),
                              TextColor3 = Color3.fromRGB(180, 165, 215),
                              TextSize = 10,
                              TextXAlignment = Enum.TextXAlignment.Left,
                              ZIndex = 5,
                            }),
                            create2("TextButton", {
                              Name = "CopyHexBtn",
                              BackgroundColor3 = Color3.fromRGB(30, 22, 48),
                              BorderSizePixel = 0,
                              AnchorPoint = Vector2.new(1, 0.5),
                              Position = UDim2.new(1, 0, 0.5, 0),
                              Size = UDim2.new(0, 58, 0, 20),
                              Font = Enum.Font.GothamBold,
                              Text = "COPY HEX",
                              TextColor3 = Color3.fromRGB(200, 170, 255),
                              TextSize = 8,
                              AutoButtonColor = false,
                              ZIndex = 5,
                              Children = {
                                create2("UICorner", { CornerRadius = UDim.new(0, 4) }),
                              },
                            }),
                          },
                        }),
                      },
                    }, v618)

                    svBox = v627:FindFirstChild("SVBox")
                    local pickerDot = svBox and svBox:FindFirstChild("PickerDot")
                    hueBar = v627:FindFirstChild("HueBar")
                    local hueCursor = hueBar and hueBar:FindFirstChild("HueCursor")
                    local swatchesRow = v627:FindFirstChild("SwatchesRow")
                    local infoRow = v627:FindFirstChild("InfoRow")
                    rgbDisplay = infoRow and infoRow:FindFirstChild("RgbDisplay")

                    local copyHexBtn = infoRow
                    copyHexBtn = infoRow and infoRow:FindFirstChild("CopyHexBtn")

                    local v628 = {
                      Color3.fromRGB(239, 68, 68), Color3.fromRGB(249, 115, 22),
                      Color3.fromRGB(234, 179, 8), Color3.fromRGB(34, 197, 94),
                      Color3.fromRGB(6, 182, 212), Color3.fromRGB(59, 130, 246),
                      Color3.fromRGB(168, 85, 247), Color3.fromRGB(255, 255, 255),
                    }

                    function v614(p324)
                      color16 = Color3.fromHSV(v611, v612, v613)
                      local v629 = v126.ColorToHex(color16)

                      if colorPreviewChip then
                        colorPreviewChip.BackgroundColor3 = color16
                      end

                      if hexBadge then
                        hexBadge.Text = v629
                      end

                      if svBox then
                        svBox.BackgroundColor3 = Color3.fromHSV(v611, 1, 1)
                      end

                      if pickerDot then
                        pickerDot.Position = UDim2.new(v612, 0, 1 - v613, 0)
                      end

                      if hueCursor then
                        hueCursor.Position = UDim2.new(0.5, 0, v611, 0)
                      end

                      if rgbDisplay then
                        rgbDisplay.Text = string.format(
                          "RGB: %d, %d, %d", math.floor(color16.R * 255),
                          math.floor(color16.G * 255), math.floor(color16.B * 255)
                        )
                      end

                      if flag6 then
                        save:ElementSave(flag6, v629)
                      end

                      if p324 ~= false then
                        pcall(callback8, color16, v629, {
                          R = math.floor(color16.R * 255),
                          G = math.floor(color16.G * 255),
                          B = math.floor(color16.B * 255),
                        })
                      end
                    end

                    for index86, value103 in ipairs(v628) do
                      local v630 = value103

                      create2("TextButton", {
                        Name = "Preset_" .. index86,
                        BackgroundColor3 = v630,
                        BorderSizePixel = 0,
                        Size = UDim2.new(0, 18, 0, 18),
                        Text = "",
                        AutoButtonColor = false,
                        LayoutOrder = index86,
                        ZIndex = 5,
                        Children = { create2("UICorner", { CornerRadius = UDim.new(0, 3) }) },
                      }, swatchesRow).MouseButton1Click:Connect(function()
                        color16 = v630
                        local v631, v632
                        v611, v632, v631 = color16:ToHSV()
                        v612 = v632
                        v613 = v631
                        v614(true)
                      end)
                    end

                    colorPreviewChip.MouseButton1Click:Connect(function()
                      v615 = not v615

                      v4:Tween(
                        v618, { Size = UDim2.new(1, -25, 0, v615 and 184 or 32) }, 0.22,
                        Enum.EasingStyle.Cubic, Enum.EasingDirection.Out
                      )
                    end)

                    if copyHexBtn then
                      copyHexBtn.MouseButton1Click:Connect(function()
                        local v633 = v126.ColorToHex(color16)

                        pcall(function()
                          if setclipboard then
                            setclipboard(v633)

                            v3.Notification:Notify({
                              Title = "Color Copied",
                              Description = v633 .. " copied to clipboard!",
                            })
                          end
                        end)
                      end)
                    end

                    function f56(p325)
                      if not svBox then
                        return
                      else
                        local absolutePosition9 = svBox.AbsolutePosition
                        local absoluteSize5 = svBox.AbsoluteSize

                        local v634 = math.clamp((p325.Position.X - absolutePosition9.X)
                          / absoluteSize5.X, 0, 1)

                        local clamp = math.clamp
                        local y2 = p325.Position.Y
                        local y3 = absolutePosition9.Y
                        local y4 = absoluteSize5.Y
                        local v635 = clamp((y2 - y3) / y4, 0, 1)
                        v612 = v634
                        v613 = 1 - v635
                        v614(true)
                        return
                      end
                    end

                    svBox.InputBegan:Connect(function(input17)
                      if input17.UserInputType == Enum.UserInputType.MouseButton1
                        or input17.UserInputType == Enum.UserInputType.Touch then
                        v616 = true
                        f56(input17)
                      end
                    end)

                    function f57(p326)
                      if not hueBar then
                        return
                      end

                      v611 = math.clamp((p326.Position.Y - hueBar.AbsolutePosition.Y)
                        / hueBar.AbsoluteSize.Y, 0, 1)

                      v614(true)
                    end

                    hueBar.InputBegan:Connect(function(input18)
                      if input18.UserInputType == Enum.UserInputType.MouseButton1
                        or input18.UserInputType == Enum.UserInputType.Touch then
                        v617 = true
                        f57(input18)
                      end
                    end)

                    userInputService.InputChanged:Connect(function(input19)
                      if input19.UserInputType == Enum.UserInputType.MouseMovement
                        or input19.UserInputType == Enum.UserInputType.Touch then
                        if v616 then
                          f56(input19)
                        elseif v617 then
                          f57(input19)
                        end
                      end
                    end)

                    userInputService.InputEnded:Connect(function(input20)
                      if input20.UserInputType == Enum.UserInputType.MouseButton1
                        or input20.UserInputType == Enum.UserInputType.Touch then
                        v616 = false
                        v617 = false
                      end
                    end)

                    v614(false)

                    return {
                      Set = function(p327, p328)
                        color16 = v126.HexToColor(p328, Color3.fromRGB(65, 220, 110))
                        local v636, v637
                        v611, v637, v636 = color16:ToHSV()
                        v612 = v637
                        v613 = v636
                        v614(true)
                      end,
                      Get = function(p329) return color16 end,
                      GetValue = function(p330) return color16 end,
                      GetHex = function(p331) return v126.ColorToHex(color16) end,
                      Instance = v618,
                    }
                  end
                end

                v477.AddColorPicker = v477.addColorPicker
                v477.addColorPicker = v477.addColorPicker
                v477.AddButton = v477.addButton
                v477.AddToggle = v477.addToggle
                v477.AddSlider = v477.addSlider
                v477.AddDropdown = v477.addDropdown
                v477.AddMultiDropdown = v477.addMultiDropdown
                v477.addMultiDropdown = v477.addMultiDropdown
                v477.AddTextBox = v477.addTextbox
                v477.AddTextbox = v477.addTextbox
                v477.AddInput = v477.addTextbox
                v477.addInput = v477.addTextbox
                v477.AddLabel = v477.addLabel
                v477.AddKeybind = v477.addKeybind
                v477.addKeybind = v477.addKeybind
                v477.AddLine = v477.addLine
                v477.addLine = v477.addLine
                v477.AddDivider = v477.addLine
                v477.addDivider = v477.addLine
                v477.AddParagraph = v477.addParagraph
                v477.addParagraph = v477.addParagraph
                v477.AddButtonGrid = v477.addButtonGrid
                v477.InnerSection = v475
                v477.Section = v474

                return v477
              end
            end

            v473.AddMenu = v473.addMenu
            v473.Scroll = v471
            v473.Layout = v472

            return v473
          end
        end

        v470.AddSection = v470.addSection

        function v470.addSubTab(p332, p333, p334)
          local name16 = p333

          if type(name16) == "table" then
            name16 = name16.Name or name16.Title or "SubTab"
          end

          return p332:addSection(p334):addMenu(name16 or "Main", p334)
        end

        v470.AddSubTab = v470.addSubTab

        general = nil

        function f26()
          if not general then
            general = v470:addSection():addMenu("General")
          end

          return general
        end

        function v470:addButton(...)
          return f26():addButton(...)
        end

        function v470:addToggle(...)
          return f26():addToggle(...)
        end

        function v470:addSlider(...)
          return f26():addSlider(...)
        end

        function v470:addDropdown(...)
          return f26():addDropdown(...)
        end

        function v470:addMultiDropdown(...)
          return f26():addMultiDropdown(...)
        end

        function v470:addTextbox(...)
          return f26():addTextbox(...)
        end

        function v470.addInput(p335, ...)
          return f26():addTextbox(...)
        end

        function v470:addLabel(...)
          return f26():addLabel(...)
        end

        function v470:addKeybind(...)
          return f26():addKeybind(...)
        end

        function v470:addLine(...)
          return f26():addLine(...)
        end

        function v470.addDivider(p336, ...)
          return f26():addLine(...)
        end

        function v470:addParagraph(...)
          return f26():addParagraph(...)
        end

        function v470:addButtonGrid(...)
          return f26():addButtonGrid(...)
        end

        function v470:addColorPicker(...)
          return f26():addColorPicker(...)
        end

        v470.AddButton = v470.addButton
        v470.AddToggle = v470.addToggle
        v470.AddSlider = v470.addSlider
        v470.AddDropdown = v470.addDropdown
        v470.AddMultiDropdown = v470.addMultiDropdown
        v470.AddTextBox = v470.addTextbox
        v470.AddTextbox = v470.addTextbox
        v470.AddInput = v470.addTextbox
        v470.AddLabel = v470.addLabel
        v470.AddKeybind = v470.addKeybind
        v470.AddLine = v470.addLine
        v470.AddDivider = v470.addLine
        v470.AddParagraph = v470.addParagraph
        v470.AddButtonGrid = v470.addButtonGrid
        v470.AddColorPicker = v470.addColorPicker
        v470.addColorPicker = v470.addColorPicker

        return v470
      end
    end
  end

  do
    v463.addTab = v463.AddTab

    v638 = {}
    v638.TierColor = Color3.fromRGB(65, 220, 110)
    v638.TierTag = "COMMUNITY PASS"

    if v126.IsDeveloperBuild() then
      v638.TierColor = Color3.fromRGB(114, 134, 255)
      v638.TierTag = "DEV CLIENT"
    elseif v126.HasKeyAccess() then
      v638.TierColor = Color3.fromRGB(255, 215, 0)
      v638.TierTag = ""
    elseif v133 then
      v638.TierColor = Color3.fromRGB(52, 211, 153)
      v638.TierTag = "FREEMIUM"
    end

    v638.Main = v463:AddTab("Main", "info-quantum")
    v638.LeftCol = v638.Main:addSection()
    v638.RightCol = v638.Main:addSection()

    local scroll = v638.LeftCol.Scroll
    local scroll2 = v638.RightCol.Scroll

    local function f58(p337)
      if not p337 or p337 == "" then
        return "User***"
      else
        local v639 = #p337

        if v639 <= 2 then
          return string.sub(p337, 1, 1) .. "*"
        elseif v639 <= 4 then
          return string.sub(p337, 1, 1) .. string.rep("*", v639 - 2) .. string.sub(p337, -1)
        elseif v639 == 5 then
          return string.sub(p337, 1, 2) .. "*" .. string.sub(p337, 4)
        else
          local v640 = {}

          for i6 = 1, v639 do
            if i6 == 3 or i6 >= 6 and i6 < v639 then
              table.insert(v640, "*")
            else
              table.insert(v640, string.sub(p337, i6, i6))
            end
          end

          return table.concat(v640)
        end
      end
    end

    local displayName = localPlayer and localPlayer.DisplayName or "Operator"
    local name17 = localPlayer and localPlayer.Name
    local text16 = f58(displayName)
    local v641 = f58(name17 or "unknown")
    local v642 = f58((tostring(localPlayer and localPlayer.UserId or "0")))

    v638.ProfileCard = create2("Frame", {
      Name = "UserInfoCard",
      BackgroundColor3 = Color3.fromRGB(18, 14, 28),
      BackgroundTransparency = 0.2,
      BorderSizePixel = 0,
      Size = UDim2.new(1, -6, 0, 122),
      ClipsDescendants = true,
      Children = {
        create2("UICorner", { CornerRadius = UDim.new(0, 8) }),
        create2("Frame", {
          Name = "HeaderRow",
          BackgroundTransparency = 1,
          Position = UDim2.new(0, 10, 0, 8),
          Size = UDim2.new(1, -20, 0, 18),
          ZIndex = 2,
          Children = {
            create2("TextLabel", {
              Name = "CardTitle",
              BackgroundTransparency = 1,
              Position = UDim2.new(0, 0, 0, 0),
              Size = UDim2.new(1, 0, 1, 0),
              Font = Enum.Font.GothamBold,
              Text = "USER INFO",
              TextColor3 = Color3.fromRGB(205, 190, 235),
              TextSize = 9,
              TextXAlignment = Enum.TextXAlignment.Left,
              ZIndex = 3,
            }),
          },
        }),
        create2("Frame", {
          BackgroundColor3 = Color3.fromRGB(32, 24, 46),
          BackgroundTransparency = 0.35,
          BorderSizePixel = 0,
          Position = UDim2.new(0, 10, 0, 30),
          Size = UDim2.new(1, -20, 0, 1),
          ZIndex = 2,
        }),
        create2("Frame", {
          Name = "AvatarFrame",
          BackgroundColor3 = Color3.fromRGB(26, 18, 40),
          BorderSizePixel = 0,
          Position = UDim2.new(0, 10, 0, 37),
          Size = UDim2.new(0, 42, 0, 42),
          ZIndex = 2,
          Children = {
            create2("UICorner", { CornerRadius = UDim.new(1, 0) }),
            create2("ImageLabel", {
              Name = "AvatarImg",
              BackgroundTransparency = 1,
              Size = UDim2.new(1, 0, 1, 0),
              Image = "rbxasset://textures/ui/GuiImagePlaceholder.png",
              ScaleType = Enum.ScaleType.Fit,
              ZIndex = 3,
              Children = { create2("UICorner", { CornerRadius = UDim.new(1, 0) }) },
            }),
          },
        }),
        create2("TextLabel", {
          Name = "DisplayNameLabel",
          BackgroundTransparency = 1,
          Position = UDim2.new(0, 60, 0, 37),
          Size = UDim2.new(1, -70, 0, 15),
          Font = Enum.Font.GothamBold,
          Text = text16,
          TextColor3 = Color3.fromRGB(255, 255, 255),
          TextSize = 13,
          TextTruncate = Enum.TextTruncate.AtEnd,
          TextXAlignment = Enum.TextXAlignment.Left,
          ZIndex = 2,
        }),
        create2("TextLabel", {
          Name = "UsernameLabel",
          BackgroundTransparency = 1,
          Position = UDim2.new(0, 60, 0, 52),
          Size = UDim2.new(1, -70, 0, 13),
          Font = Enum.Font.Gotham,
          Text = "@" .. v641,
          TextColor3 = Color3.fromRGB(175, 155, 215),
          TextSize = 10,
          TextTruncate = Enum.TextTruncate.AtEnd,
          TextXAlignment = Enum.TextXAlignment.Left,
          ZIndex = 2,
        }),
        create2("TextLabel", {
          Name = "UidLabel",
          BackgroundTransparency = 1,
          Position = UDim2.new(0, 60, 0, 66),
          Size = UDim2.new(1, -70, 0, 12),
          Font = Enum.Font.Gotham,
          Text = "UID: " .. v642,
          TextColor3 = Color3.fromRGB(130, 115, 160),
          TextSize = 8,
          TextTruncate = Enum.TextTruncate.AtEnd,
          TextXAlignment = Enum.TextXAlignment.Left,
          ZIndex = 2,
        }),
        create2("Frame", {
          BackgroundColor3 = Color3.fromRGB(32, 24, 46),
          BackgroundTransparency = 0.35,
          BorderSizePixel = 0,
          Position = UDim2.new(0, 10, 0, 84),
          Size = UDim2.new(1, -20, 0, 1),
          ZIndex = 2,
        }),
        create2("TextLabel", {
          Name = "DevLabel",
          BackgroundTransparency = 1,
          Position = UDim2.new(0, 10, 0, 89),
          Size = UDim2.new(1, -20, 0, 14),
          Font = Enum.Font.GothamBold,
          Text = "Created by catjack.ggs",
          TextColor3 = Color3.fromRGB(240, 230, 255),
          TextSize = 10,
          TextXAlignment = Enum.TextXAlignment.Left,
          ZIndex = 2,
        }),
        create2("TextLabel", {
          Name = "LibLabel",
          BackgroundTransparency = 1,
          Position = UDim2.new(0, 10, 0, 104),
          Size = UDim2.new(1, -20, 0, 13),
          Font = Enum.Font.Gotham,
          Text = "Library < Flazhy",
          TextColor3 = Color3.fromRGB(165, 145, 205),
          TextSize = 9,
          TextXAlignment = Enum.TextXAlignment.Left,
          ZIndex = 2,
        }),
      },
    }, scroll)

    task.defer(function()
      if localPlayer and localPlayer.UserId then
        pcall(function()
          local getUserThumbnailAsync = players:GetUserThumbnailAsync(
            localPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100
          )

          local findFirstChild2 = v638.ProfileCard:FindFirstChild("AvatarFrame", true)

          if findFirstChild2 then
            local avatarImg = findFirstChild2:FindFirstChild("AvatarImg")

            if avatarImg then
              avatarImg.Image = getUserThumbnailAsync
            end
          end
        end)
      end
    end)

    v638.DiagCard = create2("Frame", {
      Name = "LiveDiagnosticsCard",
      BackgroundColor3 = Color3.fromRGB(18, 14, 28),
      BackgroundTransparency = 0.2,
      BorderSizePixel = 0,
      Size = UDim2.new(1, -6, 0, 134),
      ClipsDescendants = true,
      Children = {
        create2("UICorner", { CornerRadius = UDim.new(0, 8) }),
        create2("Frame", {
          Name = "HeaderRow",
          BackgroundTransparency = 1,
          Position = UDim2.new(0, 10, 0, 8),
          Size = UDim2.new(1, -20, 0, 18),
          ZIndex = 2,
          Children = {
            create2("TextLabel", {
              Name = "CardTitle",
              BackgroundTransparency = 1,
              Position = UDim2.new(0, 0, 0, 0),
              Size = UDim2.new(1, 0, 1, 0),
              Font = Enum.Font.GothamBold,
              Text = "SYSTEM TELEMETRY",
              TextColor3 = Color3.fromRGB(210, 195, 240),
              TextSize = 9,
              TextXAlignment = Enum.TextXAlignment.Left,
              ZIndex = 3,
            }),
          },
        }),
        create2("Frame", {
          BackgroundColor3 = Color3.fromRGB(32, 24, 46),
          BackgroundTransparency = 0.35,
          BorderSizePixel = 0,
          Position = UDim2.new(0, 10, 0, 28),
          Size = UDim2.new(1, -20, 0, 1),
          ZIndex = 2,
        }),
      },
    }, scroll)

    function v638.MakeDiagTile(name18, text17, text18, position3, p338)
      return create2("Frame", {
        Name = name18,
        BackgroundColor3 = Color3.fromRGB(25, 18, 38),
        BackgroundTransparency = 0.3,
        BorderSizePixel = 0,
        Position = position3,
        Size = UDim2.new(0.5, -3, 0, 46),
        ZIndex = 2,
        Children = {
          create2("UICorner", { CornerRadius = UDim.new(0, 6) }),
          create2("TextLabel", {
            Name = "Title",
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 8, 0, 5),
            Size = UDim2.new(1, -12, 0, 12),
            Font = Enum.Font.Gotham,
            Text = text17,
            TextColor3 = Color3.fromRGB(150, 130, 185),
            TextSize = 8,
            TextXAlignment = Enum.TextXAlignment.Left,
            ZIndex = 3,
          }),
          create2("TextLabel", {
            Name = "Val",
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 8, 0, 18),
            Size = UDim2.new(1, -12, 0, 20),
            Font = Enum.Font.GothamBold,
            Text = text18,
            TextColor3 = Color3.fromRGB(240, 235, 255),
            TextSize = 13,
            TextXAlignment = Enum.TextXAlignment.Left,
            ZIndex = 3,
          }),
        },
      }, p338):FindFirstChild("Val")
    end

    v638.FpsValLabel = v638.MakeDiagTile(
      "FpsTile", "FPS", "60 FPS", UDim2.new(0, 10, 0, 34), v638.DiagCard
    )

    v638.PingValLabel = v638.MakeDiagTile(
      "PingTile", "NETWORK PING", "0 ms", UDim2.new(0.5, 3, 0, 34), v638.DiagCard
    )

    v638.UptimeValLabel = v638.MakeDiagTile(
      "UptimeTile", "UPTIME", "00:00:00", UDim2.new(0, 10, 0, 84), v638.DiagCard
    )

    v638.PlayersValLabel = v638.MakeDiagTile(
      "PlayersTile", "PLAYERS", "1 / 1", UDim2.new(0.5, 3, 0, 84), v638.DiagCard
    )

    v638.sessionStartTick = tick()

    task.spawn(function()
      while v163 and v163.Parent and v638.DiagCard and v638.DiagCard.Parent do
        local v643 = 60

        pcall(function()
          local v644 = workspace
          v643 = math.floor(v644:GetRealPhysicsFPS())
        end)

        local v645 = 0

        pcall(function()
          local serverStatsItem = stats.Network.ServerStatsItem

          if serverStatsItem and serverStatsItem:FindFirstChild("Data Ping") then
            local dataPing = serverStatsItem["Data Ping"]
            v645 = math.floor(dataPing:GetValue())
          end
        end)

        local v646 = math.floor(tick() - v638.sessionStartTick)

        local v647 = string.format(
          "%02d:%02d:%02d", math.floor(v646 / 3600), math.floor(v646 % 3600 / 60), v646 % 60
        )

        local v648 = 1
        local maxPlayers = 1

        pcall(function()
          v648 = #players:GetPlayers()
          maxPlayers = players.MaxPlayers or 1
        end)

        if v638.FpsValLabel and v638.FpsValLabel.Parent then
          v638.FpsValLabel.Text = tostring(v643) .. " FPS"

          if v643 >= 50 then
            v638.FpsValLabel.TextColor3 = Color3.fromRGB(110, 240, 160)
          elseif v643 >= 30 then
            v638.FpsValLabel.TextColor3 = Color3.fromRGB(255, 205, 80)
          else
            v638.FpsValLabel.TextColor3 = Color3.fromRGB(255, 90, 90)
          end
        end

        if v638.PingValLabel and v638.PingValLabel.Parent then
          v638.PingValLabel.Text = tostring(v645) .. " ms"

          if v645 <= 80 then
            v638.PingValLabel.TextColor3 = Color3.fromRGB(110, 240, 160)
          elseif v645 <= 160 then
            v638.PingValLabel.TextColor3 = Color3.fromRGB(255, 205, 80)
          else
            v638.PingValLabel.TextColor3 = Color3.fromRGB(255, 90, 90)
          end
        end

        if v638.UptimeValLabel and v638.UptimeValLabel.Parent then
          v638.UptimeValLabel.Text = v647
        end

        if v638.PlayersValLabel and v638.PlayersValLabel.Parent then
          v638.PlayersValLabel.Text = string.format("%d / %d", v648, maxPlayers)
        end

        task.wait(1)
      end
    end)

    v638.FavCard = create2("Frame", {
      Name = "PinnedShortcutsCard",
      BackgroundColor3 = Color3.fromRGB(18, 14, 28),
      BackgroundTransparency = 0.2,
      BorderSizePixel = 0,
      Size = UDim2.new(1, -6, 0, 229),
      AutomaticSize = Enum.AutomaticSize.Y,
      ClipsDescendants = true,
      Children = {
        create2("UICorner", { CornerRadius = UDim.new(0, 8) }),
        create2("Frame", {
          Name = "HeaderRow",
          BackgroundTransparency = 1,
          Position = UDim2.new(0, 10, 0, 8),
          Size = UDim2.new(1, -20, 0, 18),
          ZIndex = 2,
          Children = {
            create2("TextLabel", {
              Name = "CardTitle",
              BackgroundTransparency = 1,
              Position = UDim2.new(0, 0, 0, 0),
              Size = UDim2.new(1, -110, 1, 0),
              Font = Enum.Font.GothamBold,
              Text = "PINNED SHORTCUTS",
              TextColor3 = Color3.fromRGB(255, 225, 140),
              TextSize = 9,
              TextXAlignment = Enum.TextXAlignment.Left,
              ZIndex = 3,
            }),
            create2("TextLabel", {
              Name = "CardTip",
              BackgroundTransparency = 1,
              Position = UDim2.new(1, -110, 0, 0),
              Size = UDim2.new(0, 110, 1, 0),
              Font = Enum.Font.Gotham,
              Text = "Right-Click / Double-Tap",
              TextColor3 = Color3.fromRGB(150, 130, 180),
              TextSize = 8,
              TextXAlignment = Enum.TextXAlignment.Right,
              ZIndex = 3,
            }),
          },
        }),
        create2("Frame", {
          BackgroundColor3 = Color3.fromRGB(32, 24, 46),
          BackgroundTransparency = 0.35,
          BorderSizePixel = 0,
          Position = UDim2.new(0, 10, 0, 28),
          Size = UDim2.new(1, -20, 0, 1),
          ZIndex = 2,
        }),
        create2("Frame", {
          Name = "FavHostContainer",
          BackgroundTransparency = 1,
          Position = UDim2.new(0, 8, 0, 34),
          Size = UDim2.new(1, -16, 0, 0),
          AutomaticSize = Enum.AutomaticSize.Y,
          ZIndex = 2,
          Children = {
            create2("UIListLayout", {
              SortOrder = Enum.SortOrder.LayoutOrder,
              Padding = UDim.new(0, 4),
            }),
            create2("UIPadding", { PaddingBottom = UDim.new(0, 8) }),
          },
        }),
      },
    }, scroll2)
  end

  do
    local findFirstChild3 = v638.FavCard:FindFirstChild("FavHostContainer", true)

    function v155.Refresh()
      if not findFirstChild3 or not findFirstChild3.Parent then
        return
      else
        for index87, value104 in ipairs(findFirstChild3:GetChildren()) do
          if value104:IsA("TextButton")
            or value104:IsA("Frame") and value104.Name == "EmptyState" then
            value104:Destroy()
          end
        end

        local list2 = v155.List

        if #list2 == 0 then
          create2("Frame", {
            Name = "EmptyState",
            BackgroundColor3 = Color3.fromRGB(24, 18, 36),
            BackgroundTransparency = 0.35,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 0, 160),
            ZIndex = 3,
            Children = {
              create2("UICorner", { CornerRadius = UDim.new(0, 6) }),
              create2("TextLabel", {
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 10, 0, 52),
                Size = UDim2.new(1, -20, 0, 18),
                Font = Enum.Font.GothamBold,
                Text = "★  No Shortcuts Pinned Yet",
                TextColor3 = Color3.fromRGB(210, 190, 240),
                TextSize = 10,
                TextXAlignment = Enum.TextXAlignment.Center,
                ZIndex = 4,
              }),
              create2("TextLabel", {
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 10, 0, 76),
                Size = UDim2.new(1, -20, 0, 32),
                Font = Enum.Font.Gotham,
                Text = [[
PC: right-click any toggle, button, or slider
Mobile: double-tap control to pin here]],
                TextColor3 = Color3.fromRGB(150, 130, 180),
                TextSize = 9,
                TextXAlignment = Enum.TextXAlignment.Center,
                ZIndex = 4,
              }),
            },
          }, findFirstChild3)

          return
        end

        for index88, value105 in ipairs(list2) do
          local v649 = v155.Entries[value105]
          local title6 = v649 and v649.title

          local match4 = title6
          match4 = title6 or value105:match("([^|]+)$") or value105

          local text19 = v649 and (v649.tabTitle or "") .. " › " .. (v649.menuTitle or "")
            or ""

          create2("TextButton", {
            BackgroundColor3 = Color3.fromRGB(26, 19, 40),
            BackgroundTransparency = 0.2,
            Size = UDim2.new(1, 0, 0, 34),
            Text = "",
            AutoButtonColor = false,
            LayoutOrder = index88,
            ZIndex = 3,
            Children = {
              create2("UICorner", { CornerRadius = UDim.new(0, 6) }),
              create2("TextLabel", {
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 10, 0, 2),
                Size = UDim2.new(1, -20, 0, 16),
                Font = Enum.Font.GothamBold,
                Text = "★  " .. match4,
                TextColor3 = Color3.fromRGB(255, 220, 140),
                TextSize = 11,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextTruncate = Enum.TextTruncate.AtEnd,
                ZIndex = 4,
              }),
              create2("TextLabel", {
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 10, 0, 18),
                Size = UDim2.new(1, -20, 0, 12),
                Font = Enum.Font.Gotham,
                Text = text19,
                TextColor3 = Color3.fromRGB(160, 140, 190),
                TextSize = 9,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextTruncate = Enum.TextTruncate.AtEnd,
                ZIndex = 4,
              }),
            },
          }, findFirstChild3).MouseButton1Click:Connect(function()
            if v649 then
              v126.NavigateToSearchEntry(v649)
            end
          end)
        end

        return
      end
    end

    task.defer(function()
      if v155.Refresh then
        v155.Refresh()
      end

      task.delay(1.5, function()
        if v155.Refresh then
          v155.Refresh()
        end
      end)
    end)

    task.defer(function() pcall(v126.SyncKeyAccess) end)

    ScheduleRefreshAllLayouts()

    local function f59()
      local g3

      if typeof(getgenv) == "function" then
        local v650 = getgenv()

        if v650 and v650.AutoCloseUI ~= nil then
          return v650.AutoCloseUI == true
        end

        g3 = _G

        if g3 and _G.AutoCloseUI ~= nil then
          return _G.AutoCloseUI == true
        end

        if p96 and p96.AutoCloseUI ~= nil then
          return p96.AutoCloseUI == true
        end

        return false
      end

      g3 = _G

      if g3 and _G.AutoCloseUI ~= nil then
        return _G.AutoCloseUI == true
      end

      if p96 and p96.AutoCloseUI ~= nil then
        return p96.AutoCloseUI == true
      end

      return false
    end

    local function f60()
      local v651 = f59()
      ScheduleRefreshAllLayouts()
      v395.Visible = true
      v396.Visible = true

      if v651 then
        v414 = false
        v182.Visible = false
        v396.Size = UDim2.new(1, 0, 1, 0)
      else
        v414 = true
        v182.Visible = true

        local currentEffectiveScale2 = v126.CurrentEffectiveScale
            and v126.CurrentEffectiveScale > 0 and v126.CurrentEffectiveScale
          or v166 and v166.Scale > 0 and v166.Scale
          or 1

        local get39 = save:Get("_opt_UITransparency", 0.05)
        v166.Scale = currentEffectiveScale2 * 0.94
        v182.BackgroundTransparency = math.min(1, get39 + 0.3)

        v4:Tween(
          v166, { Scale = currentEffectiveScale2 }, 0.22, Enum.EasingStyle.Quart,
          Enum.EasingDirection.Out
        )

        v4:Tween(
          v182, { BackgroundTransparency = get39 }, 0.2, Enum.EasingStyle.Quart,
          Enum.EasingDirection.Out
        )
      end

      ScheduleRefreshAllLayouts()
    end

    f60()

    v463.IsDeveloper = v126.IsDeveloperBuild
    v463.IsPremium = v126.HasKeyAccess
    v463.ToggleUI = f8
    v463.Favorites = v155
  end

  function v463.Destroy()
    v3:DestroyGui()
  end

  function v463:Notify(p339, p340)
    return v3.Notification:Notify(p339, p340)
  end

  v463.notify = v463.Notify

  return v463
end

v3.CreateWindow = v3.CreateWindow
v3.createWindow = v3.CreateWindow
v3.DestroyGui = v3.DestroyGui
v3.destroyGui = v3.DestroyGui

return v3
