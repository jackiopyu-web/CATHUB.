-- Delta compatibility fallback: some executor builds do not expose cloneref.
-- Returning the original Roblox Instance is sufficient for this script's service references.
local cloneref = cloneref or function(instance)
  return instance
end

-- Keep the executor environment API available where possible.
local getgenv = getgenv or function()
  return _G
end

local runService = game:GetService("RunService")
local players = game:GetService("Players")
local v1 = game:GetService("Workspace")
local replicatedStorage = game:GetService("ReplicatedStorage")
local collectionService = game:GetService("CollectionService")
local lighting = game:GetService("Lighting")
local virtualInputManager = game:GetService("VirtualInputManager")
local httpService = game:GetService("HttpService")
local userInputService = game:GetService("UserInputService")
local logService = game:GetService("LogService")
local scriptContext = game:GetService("ScriptContext")
local starterGui = game:GetService("StarterGui")
local stats = game:GetService("Stats")
local teleportService = game:GetService("TeleportService")
local guiService = game:GetService("GuiService")
local virtualUser = game:GetService("VirtualUser")
local tweenService = game:GetService("TweenService")
local getService = not game and game.GetService and runService

local v2 = getService or game.ClassName ~= "DataModel"
  or typeof and typeof(game.Players) ~= "Instance"
  or not (getmetatable and setmetatable and type and pcall and rawget and rawset)

if v2 then
  while true do
    task.wait()
    warn("stop skidding - flazhy")
  end
end

local v3 = cloneref(players)
local v4 = cloneref(v1)
local v5 = cloneref(replicatedStorage)
local v6 = cloneref(collectionService)
local v7 = cloneref(runService)
local v8 = cloneref(lighting)
local v9 = cloneref(virtualInputManager)
local v10 = cloneref(httpService)

cloneref(userInputService)
cloneref(logService)
cloneref(scriptContext)
cloneref(starterGui)

local v11 = cloneref(stats)
cloneref(teleportService)
local v12 = cloneref(guiService)
local v13 = cloneref(virtualUser)
local v14 = cloneref(tweenService)
local localPlayer = v3.LocalPlayer or v3:GetPropertyChangedSignal("LocalPlayer"):Wait()
local dataLoaded

repeat
  task.wait()
  local isLoaded = game:IsLoaded()

  dataLoaded = isLoaded
  dataLoaded = isLoaded and localPlayer:FindFirstChild("DataLoaded")
until dataLoaded

local textButton

if localPlayer.PlayerGui:FindFirstChild("Main (minimal)") then
  if not getgenv().Team or getgenv().Team == "" then
    getgenv().Team = "Pirates"
  end

  local container = localPlayer.PlayerGui["Main (minimal)"]:WaitForChild("ChooseTeam"):WaitForChild("Container")
  textButton = nil

  if getgenv().Team == "Pirates" then
    textButton = container:WaitForChild("Pirates"):WaitForChild("Frame"):WaitForChild("TextButton")
  elseif getgenv().Team == "Marines" then
    textButton = container:WaitForChild("Marines"):WaitForChild("Frame"):WaitForChild("TextButton")
  end

  if textButton then
    while true do
      task.wait()
      pcall(function() firesignal(textButton.Activated) end)

      if not localPlayer.PlayerGui:FindFirstChild("Main (minimal)") then
        break
      end
    end
  end
end

while true do
  task.wait()

  if localPlayer.PlayerGui:FindFirstChild("Main") then
    break
  end
end

local utilBloxFruitModulePreloadDataLua, f1, v15, v16, v17, f2, f3, f4, f5, f6, f7, f8, bossMap,
  bossHopNames, v18, f9, spawn, v19, v20, v21, v22, v23, character, waitForChild, waitForChild2,
  data, level, fragments, beli, enemies, seaBeasts, boats, map, worldOrigin, v24, v25, v26,
  remotes, commF, commE, net, v27, v28, v29, v30, v31, v32, f10, v33, v34, devNiulaiLua,
  materialEnemies, quests, bossList, itemsToBuy, islands, v35, swordData, v36, clearNew, v37,
  v38, tweenManager, f11, fastAttack, shootGun, customShoot, serverStatus, utilities, f12, f13,
  f14, f15, v39, v40, v41, f16, f17, f18, v42, color, quantumBerryAnchors, v43, f19, f20, v44,
  gameData, subFunction, v45

if getgenv().QuantumOnyxActive then
  return print("already running")
else
  getgenv().QuantumOnyxActive = true
  v18 = nil

  if syn and syn.request then
    v18 = syn.request
  elseif http_request then
    v18 = http_request
  elseif http and http.request then
    v18 = http.request
  elseif request then
    v18 = request
  elseif httprequest then
    v18 = httprequest
  end

  function f9(p1)
    if not v18 then
      return nil
    end

    return v18(p1)
  end

  spawn = task.spawn
  v19 = {}
  v20 = {}
  v21 = {}
  v22 = {}
  v23 = {}
  character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
  waitForChild = character:WaitForChild("Humanoid", 10)
  waitForChild2 = character:WaitForChild("HumanoidRootPart", 10)
  data = localPlayer:WaitForChild("Data")
  level = data:WaitForChild("Level")
  fragments = data:WaitForChild("Fragments")
  beli = data:WaitForChild("Beli")

  localPlayer.CharacterAdded:Connect(function(character2)
    if not character2 then
      return
    else
      local waitForChild3 = character2.WaitForChild
      character = character2
      waitForChild = waitForChild3(character2, "Humanoid", 10)
      waitForChild2 = character2:WaitForChild("HumanoidRootPart", 10)
      return
    end
  end)

  enemies = v4:WaitForChild("Enemies")
  seaBeasts = v4:WaitForChild("SeaBeasts")
  boats = v4:WaitForChild("Boats")
  map = v4:WaitForChild("Map")
  worldOrigin = v4:WaitForChild("_WorldOrigin")
  local map2 = v4:GetAttribute("MAP")
  v24 = map2 == "Sea1"
  v25 = map2 == "Sea2"
  v26 = map2 == "Sea3"
  remotes = v5:WaitForChild("Remotes")
  commF = remotes:WaitForChild("CommF_")
  commE = v5.Remotes.CommE
  net = v5:WaitForChild("Modules"):WaitForChild("Net")
  v27 = require(v5:WaitForChild("GuideModule"))
  v28 = require(v5.Util.GetWaterHeightAtLocation)
  require(v5.DangerDistance)
  v29 = require(game.ReplicatedStorage.Modules.Net)
  v30 = require(game.ReplicatedStorage.ItemConfig)
  v15 = require(replicatedStorage.NPCManager)

  function f1(p2, p3)
    return (p2 - v32:byte((p3 - 1) % #v32 + 1) - p3) % 32
  end

  function DetectNpc(p4)
    local humanoidRootPart = localPlayer.Character
      and localPlayer.Character:FindFirstChild("HumanoidRootPart")

    if not humanoidRootPart then
      return
    else
      local huge = math.huge
      local v46 = nil

      for key, value in next, { v4.NPCs, v5.NPCs }, nil do
        local v47 = next
        local v48, v49 = value:GetChildren()

        for v50, v51 in v47, v48, v49 do
          if v51:GetAttribute("NPCLoaded") and v51:GetAttribute("NPCReady") and v51.Name == p4
            and v51:FindFirstChild("HumanoidRootPart") then
            local magnitude = (humanoidRootPart.Position - v51.HumanoidRootPart.Position).Magnitude

            if magnitude < huge then
              huge = magnitude
              v46 = v51
            end
          end
        end
      end

      if not v46 then
        local v52, v53 = pcall(function()
          return v15.getNPCsByName(p4)[1]._modelState._instance
        end)

        if v52 and v53 then
          v46 = v53
        end
      end

      return v46, huge
    end
  end

  v31 = "kQ9mZ2xW7nR4vB1jY6tF3hD8pL5cG0sA"
  v32 = "QnTmOnyX"

  function f10(p5)
    local gsub = p5:gsub("^%.", ""):gsub("%.$", "")
    local v54 = {}
    local count = 0

    for i = 1, #gsub do
      count = count + 1

      if count % 5 ~= 0 then
        table.insert(v54, gsub:sub(i, i))
      end
    end

    local v55 = table.concat(v54)
    local v56 = {}
    local v57 = 1
    local v58 = 1

    while v57 <= #v55 do
      local sub = v55:sub(v57, v57)
      local sub2 = v55:sub(v57 + 1, v57 + 1)
      local find = v31:find(sub, 1, true)
      local find2 = v31:find(sub2, 1, true)
      table.insert(v56, string.char(f1(find - 1, v58) + f1(find2 - 1, v58 + 100) * 32))
      v57 = v57 + 2
      v58 = v58 + 1
    end

    return table.concat(v56)
  end

  v33 = {}

  function v33.FireInvoke(p6, ...)
    return commF:InvokeServer(...)
  end

  v34 = {}

  local function f21(p7, p8)
    if not p7 then
      return nil
    end

    if v34[p7] then
      return v34[p7]
    end

    for j = 1, p8 or 2 do
      local v59, v60 = pcall(function()
        return loadstring(game:HttpGet("https://github.com/jackiopyu-web/CATHUB./tree/main"
          .. p7))()
      end)

      if v59 and v60 ~= nil then
        v34[p7] = v60
        return v60
      end

      task.wait(0.3)
    end

    return nil
  end

  utilBloxFruitModulePreloadDataLua = f21("Preload/Data.lua") or {}

  if not f21("Preload/Visuals.lua") then
  end

  devNiulaiLua = (function()
local a=(function()local a=game:GetService('TweenService')local b=game:GetService('UserInputService')local c=game:GetService('GuiService')local d=game:GetService('RunService')local e=game:GetService('HttpService')local f=game:GetService('Players')local g=game:GetService('TeleportService')local h=game:GetService('MarketplaceService')local i=game:GetService('Stats')local j=f.LocalPlayer local k={}k.Flags={}k.Windows={}local function l(m,n)local o={}if type(m)=='string'then o.Name=m elseif type(m)=='table'then for p,q in pairs(m)do o[p]=q end end for p,q in pairs(n or{})do if o[q]==nil and o[p]~=nil then o[q]=o[p]end end if o.Range then o.Min=o.Min or o.Range[1]o.Max=o.Max or o.Range[2]end return o end local function m(n,o,p,q,r)p._type=r p._frame=q p._listeners=p._listeners or{}local s=n and n.Window local t=o.Name or o.Text or o.Title p._searchName=type(t)=='string'and t or''p._searchKey=string.lower(p._searchName)if n and n._items then table.insert(n._items,p)end if o.Flag then k.Flags[o.Flag]=p if s then s:_flagCreated(o.Flag,p)end end p._userVisible=o.Visible~=false function p:IsVisible()return p._userVisible end function p:_isShown()return p._userVisible and not(n and n._userVisible==false)end function p:SetVisible(u)u=u and true or false if u==p._userVisible or p._destroyed then return end p._userVisible=u if not u then if p._onHide then p._onHide()end if p.Open and type(p.SetOpen)=='function'then p:SetOpen(false)end end if q then q.Visible=u end if s then s._controlsDirty=true end end if q and not p._userVisible then q.Visible=false end function p:SetTooltip(u)p._tooltip=u if q and s and not p._tooltipBound then p._tooltipBound=true s:_attachTooltip(p,q)end end function p:GetTooltip()return p._tooltip end if o.Tooltip~=nil and o.Tooltip~=false then p:SetTooltip(o.Tooltip)end function p:Destroy()if p._destroyed then return end p._destroyed=true if s and s._tipOwner==p then s:_hideTooltip()end for u,v in ipairs(p._listeners)do v()end p._listeners={}if n and n._items then local u=table.find(n._items,p)if u then table.remove(n._items,u)end end if o.Flag and k.Flags[o.Flag]==p then k.Flags[o.Flag]=nil end if s then s._controlsDirty=true end if q then q:Destroy()end end return p end k.Theme={Background=Color3.fromRGB(15,18,26),Surface=Color3.fromRGB(18,22,31),Surface2=Color3.fromRGB(22,26,37),Surface3=Color3.fromRGB(37,44,60),Stroke=Color3.fromRGB(34,40,55),StrokeHover=Color3.fromRGB(70,84,112),Accent=Color3.fromRGB(128,160,246),AccentDark=Color3.fromRGB(14,18,30),Text=Color3.fromRGB(228,232,242),Muted=Color3.fromRGB(116,126,148),Warning=Color3.fromRGB(240,176,108),Success=Color3.fromRGB(150,220,170),Error=Color3.fromRGB(240,120,120)}local n={'Accent','AccentDark','Background','Surface','Surface2','Surface3','Stroke','StrokeHover','Text','Muted','Warning','Success','Error'}local function o(p,q,r)return Color3.fromRGB(p,q,r)end local function p(q,r,s,t,u,v,w,x,y,z)return{Background=o(table.unpack(q)),Surface=o(table.unpack(r)),Surface2=o(table.unpack(s)),Surface3=o(table.unpack(t)),Stroke=o(table.unpack(u)),StrokeHover=o(table.unpack(v)),Accent=o(table.unpack(w)),AccentDark=o(table.unpack(x)),Text=o(table.unpack(y)),Muted=o(table.unpack(z))}end k.ThemePresets={Midnight=p({15,18,26},{18,22,31},{22,26,37},{37,44,60},{34,40,55},{70,84,112},{128,160,246},{14,18,30},{228,232,242},{116,126,148}),Ocean=p({12,20,24},{15,24,29},{18,29,35},{31,48,56},{29,44,52},{58,92,104},{110,214,222},{10,24,28},{226,238,240},{108,134,140}),Rose=p({22,15,18},{27,18,22},{32,21,26},{48,34,40},{45,30,37},{98,64,78},{246,160,186},{30,14,20},{240,228,232},{138,112,120}),Emerald=p({13,20,17},{16,24,20},{20,29,24},{33,47,40},{30,44,37},{62,96,78},{132,226,170},{12,26,18},{228,240,233},{110,136,122}),Amber=p({22,18,13},{27,22,16},{32,26,19},{49,41,31},{46,38,28},{100,82,58},{246,196,120},{30,22,10},{242,236,226},{140,126,106}),Mono=p({16,16,17},{20,20,21},{25,25,26},{40,40,42},{38,38,40},{84,84,88},{236,236,240},{20,20,22},{234,234,236},{122,122,128}),Nebula=p({14,12,28},{18,15,35},{23,19,43},{39,32,68},{35,29,62},{84,68,140},{199,125,255},{22,10,40},{236,230,252},{124,114,160}),Synthwave=p({20,12,30},{25,15,37},{31,18,45},{52,30,72},{47,27,66},{110,58,150},{255,94,198},{38,8,30},{250,232,246},{150,118,160}),Sakura=p({24,14,20},{29,17,24},{35,20,29},{54,32,45},{50,29,41},{112,66,92},{255,158,200},{36,12,24},{248,232,240},{150,112,132}),Velvet=p({20,10,16},{25,12,20},{31,15,25},{50,25,40},{46,23,37},{104,52,82},{222,110,170},{30,8,20},{244,228,238},{142,106,126}),Crimson=p({18,10,12},{23,12,15},{28,14,18},{46,24,29},{42,22,27},{104,46,56},{244,74,94},{32,8,12},{244,230,232},{142,106,112}),Sunset=p({22,13,14},{27,16,17},{33,19,21},{52,31,32},{48,28,30},{112,62,58},{255,138,92},{34,14,8},{248,234,228},{150,118,110}),Gold=p({14,13,11},{18,17,14},{23,21,17},{38,35,28},{35,32,26},{92,80,54},{232,196,122},{30,22,8},{240,234,222},{136,126,106}),Cyber=p({13,13,15},{17,17,19},{21,21,24},{36,36,40},{33,33,37},{86,84,70},{250,226,72},{30,26,4},{240,240,232},{126,124,118}),Toxic=p({11,14,11},{14,18,14},{18,23,18},{31,39,30},{28,36,28},{74,98,60},{184,255,74},{18,30,6},{232,242,228},{116,134,110}),Matcha=p({16,19,14},{20,23,17},{24,28,21},{40,46,34},{37,42,31},{84,98,70},{176,214,140},{18,26,10},{236,240,228},{128,136,116}),Aurora=p({10,20,22},{12,25,27},{15,30,33},{26,50,53},{24,45,48},{50,104,104},{94,240,180},{6,30,22},{224,246,240},{102,142,134}),Frost=p({13,17,23},{16,21,28},{20,26,34},{34,43,56},{31,40,52},{72,92,118},{164,214,255},{12,22,34},{230,238,246},{114,128,146}),Abyss=p({7,11,22},{9,14,28},{12,18,35},{22,31,58},{20,28,52},{44,64,120},{72,148,255},{6,14,34},{226,234,250},{100,116,152}),Halloween=p({18,12,20},{23,15,25},{28,18,30},{46,30,48},{43,28,44},{104,62,40},{255,138,36},{36,16,4},{246,234,224},{146,120,128}),Haunted=p({14,12,20},{18,15,26},{22,18,32},{38,31,54},{35,29,50},{70,96,64},{156,255,110},{14,30,8},{232,240,228},{120,116,140}),Christmas=p({12,20,15},{15,25,19},{19,30,23},{32,50,38},{30,46,35},{100,54,56},{236,72,80},{34,8,10},{240,244,236},{120,142,128}),Valentine=p({24,12,17},{30,14,21},{36,17,25},{58,27,40},{54,25,37},{130,56,84},{255,92,140},{40,8,20},{252,232,240},{160,112,132}),Lunar=p({22,10,10},{28,12,12},{34,15,14},{54,24,22},{50,22,20},{130,92,40},{246,196,84},{38,16,6},{250,236,222},{160,120,108}),Tropical=p({10,22,24},{12,27,30},{15,33,36},{26,54,58},{24,50,54},{44,110,110},{255,170,90},{36,18,6},{232,246,244},{104,144,142}),Dracula=p({24,25,33},{29,30,40},{34,36,47},{52,55,70},{48,50,64},{98,114,164},{189,147,249},{26,18,44},{246,246,238},{126,132,168}),Coffee=p({20,16,13},{25,20,16},{30,24,19},{48,39,31},{45,36,29},{104,82,62},{214,170,124},{32,22,12},{240,230,218},{142,124,108})}k.ThemeName='Midnight'k.Assets={Shadow='rbxassetid://6014261993',Glow='rbxassetid://8992230677',Logo='rbxassetid://103859712365480'}local q=[[https://raw.githubusercontent.com/Footagesus/Icons/refs/heads/main/lucide/dist/Icons.lua]]local r=nil local function s()if r~=nil then return r end local t,u=pcall(function()local t=game:HttpGet(q)return loadstring(t)()end)if t and type(u)=='table'then r=u else r=false warn('[AirFlow] lucide icons unavailable: '..tostring(u))end return r end local t={ValleySans={Regular=[[https://raw.githubusercontent.com/HelsinkiTypeStudio/valley-sans/main/fonts/ttf/ValleySans-Regular.ttf]],Medium=[[https://raw.githubusercontent.com/HelsinkiTypeStudio/valley-sans/main/fonts/ttf/ValleySans-Medium.ttf]],SemiBold=[[https://raw.githubusercontent.com/HelsinkiTypeStudio/valley-sans/main/fonts/ttf/ValleySans-SemiBold.ttf]]}}local u={Regular={400,Enum.FontWeight.Regular},Medium={500,Enum.FontWeight.Medium},SemiBold={600,Enum.FontWeight.SemiBold},Bold={700,Enum.FontWeight.Bold}}function k:LoadFont(v)v=l(v,{})if type(writefile)~='function'or type(isfile)~='function'or typeof(getcustomasset)~='function'then warn([[[AirFlow] custom fonts need writefile, isfile and getcustomasset]])return false end local w=v.Name or'CustomFont'local x=v.Weights or t[w]if type(x)~='table'then warn('[AirFlow] no font weights for '..w)return false end local y=v.Folder or'AirFlowFonts'pcall(function()if type(isfolder)=='function'and type(makefolder)=='function'and not isfolder(y)then makefolder(y)end end)local z={}for A,B in pairs(x)do local C=u[A]if C then local D=y..'/'..w..'-'..A..'.ttf'local E=true if not isfile(D)then E=pcall(function()writefile(D,game:HttpGet(B))end)end if E then table.insert(z,{name=A,weight=C[1],style='normal',assetId=getcustomasset(D)})else warn('[AirFlow] could not download '..A..' weight of '..w)end end end if#z==0 then return false end local A=y..'/'..w..'.json'local B=pcall(function()writefile(A,e:JSONEncode({name=w,faces=z}))end)if not B then return false end local C=getcustomasset(A)local function D(E,F)local G=u[E]if G and x[E]then return Font.new(C,G[2])end return F end k.Fonts.Regular=D('Regular',k.Fonts.Regular)k.Fonts.Medium=D('Medium',D('Regular',k.Fonts.Medium))k.Fonts.Bold=D('SemiBold',D('Bold',k.Fonts.Bold))return true end function k:PreloadIcons()return s()~=false end local function v(w)if type(w)=='number'then return'rbxassetid://'..string.format('%.0f',w)end if type(w)=='string'then if w:match('^%d+$')then return'rbxassetid://'..w end if w:find('^rbxassetid://')or w:find('^rbxasset://')or w:find('^rbxthumb://')or w:find('^http')then return w end end return nil end local function w(x)if typeof(x)=='table'then return v(x.Image)or x.Image,x.RectOffset,x.RectSize,true,x.Tint==true end local y=v(x)if y then return y,nil,nil,true,false end if type(x)~='string'then return nil end local z=x:gsub('^lucide:','')local A=s()if not A then return nil end local B=(A.Icons and A.Icons[z])or A[z]if type(B)=='table'then local C=B.Image if type(C)=='number'then C='rbxassetid://'..tostring(C)end local D=(A.Spritesheets and A.Spritesheets[tostring(C)])or C return D,B.ImageRectPosition,B.ImageRectSize elseif type(B)=='string'then return B end warn('[AirFlow] unknown lucide icon: '..z)return nil end local x='chevron-right'local y='rbxasset://fonts/families/BuilderSans.json'k.Fonts={Regular=Font.new(y,Enum.FontWeight.Regular),Medium=Font.new(y,Enum.FontWeight.Medium),Bold=Font.new(y,Enum.FontWeight.SemiBold)}local z=k.Theme local A=k.Assets local B=[[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]]local function C(D)local E={}local F=[[ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/]]for G=1,#F do E[F:byte(G)]=G-1 end local G={}for H=1,#D,4 do local I,J,K,L=D:byte(H,H+3)local M=E[I]*262144+E[J]*4096+(E[K]or 0)*64+(E[L]or 0)local N,O,P=M//65536,M//256%256,M%256 if L~=61 then G[#G+1]=string.char(N,O,P)elseif K~=61 then G[#G+1]=string.char(N,O)else G[#G+1]=string.char(N)end end return table.concat(G)end pcall(function()if type(writefile)~='function'or typeof(getcustomasset)~='function'then return end local D='AirFlowAssets'if type(isfolder)=='function'and type(makefolder)=='function'and not isfolder(D)then makefolder(D)end local E=D..'/OuroFlowLogo.png'local F=C(B)local G=type(isfile)=='function'and type(readfile)=='function'and isfile(E)and readfile(E)==F if not G then writefile(E,F)end local H=getcustomasset(E)if type(H)=='string'and H~=''then A.Logo=H end end)local D=k.Fonts local E=b.TouchEnabled and not b.KeyboardEnabled k.Touch=E local F=188 local G=62 local H=34 local I=E and 54 or 48 local J=E and 70 or 64 local K=E and 40 or 34 local L=E and 34 or 28 local M=64 local N=176 local O=440 local P={Card={Compact=false,Height=I,DescHeight=J,Chip=L,Option=K,TextSize=14,DescSize=13,TitleHeight=18,DescGap=20,DescLine=17,Slider=J},Row={Compact=true,Height=E and 40 or 32,DescHeight=E and 54 or 46,Chip=E and 30 or 24,Option=E and 34 or 28,TextSize=13,DescSize=12,TitleHeight=16,DescGap=17,DescLine=15,Slider=E and 54 or 46}}local Q={}local R={}local S={}local T={}local U={}local V=0 local W=4000 local function X(Y,Z)for _ in pairs(Y)do if _.Parent==nil then if U[_]then Y[_]=nil U[_]=nil if Z then V-=1 end else U[_]=true end else U[_]=nil end end end local function Y()X(R,true)X(S,false)W=math.max(4000,V*2)end local function Z(_)return math.floor(_.R*255+0.5)..','..math.floor(_.G*255+0.5)..','..math.floor(_.B*255+0.5)end local function _()table.clear(T)for aa=#n,1,-1 do local ab=n[aa]T[Z(k.Theme[ab])]=ab end end _()local function aa(ab,ac)for ad,ae in pairs(ac)do if typeof(ae)=='Color3'then local af=T[Z(ae)]local ag=R[ab]if af then if not ag then ag={}R[ab]=ag V+=1 if V>=W then Y()end end ag[ad]=af elseif ag then ag[ad]=nil end end end end local ab=table.clone(k.Theme)local ac=nil local function ad(ae,af,ag)for ah,ai in pairs(af)do local aj=ag[ai]if aj then ae[ah]=aj end end end local function ae(af)for ag,ah in pairs(R)do pcall(ad,ag,ah,af)end end local function af(ag)if ac then ac:Disconnect()ac=nil end local ah,ai={},{}for aj,ak in ipairs(n)do local al=k.Theme[ak]local am=ab[ak]or al if am~=al then ah[ak]=am ai[ak]=am end end local function aj()for ak,al in ipairs(n)do ai[al]=k.Theme[al]ab[al]=k.Theme[al]end ae(ai)end if ag<=0 or next(ah)==nil then aj()return end local ak=0 ac=d.Heartbeat:Connect(function(al)ak+=al if ak>=ag then ac:Disconnect()ac=nil aj()return end local am=1-(1-ak/ag)^5 for an,ao in pairs(ah)do local ap=ao:Lerp(k.Theme[an],am)ai[an]=ap ab[an]=ap end ae(ai)end)end local function ag(ah,ai)S[ah]=ai ai()end local function ah(ai,aj,ak,al,am,an)ak=ak or 0.2 if not an then aa(ai,aj)end if ak<=0 then for ao,ap in pairs(aj)do ai[ao]=ap end return nil end al=al or Enum.EasingStyle.Quart am=am or Enum.EasingDirection.Out local ao=ak..al.Name..am.Name local ap=Q[ao]if not ap then ap=TweenInfo.new(ak,al,am)Q[ao]=ap end local aq=a:Create(ai,ap,aj)aq:Play()return aq end local function ai(aj,ak,al)local am=Instance.new(aj)for an,ao in pairs(ak)do if an~='Parent'then am[an]=ao end end aa(am,ak)if al then for an,ao in ipairs(al)do ao.Parent=am end end if ak.Parent then am.Parent=ak.Parent end return am end k.Roundness=1 k._cornerBases={}local function aj(ak,al)al=al or UDim.new(0,8)local am=ai('UICorner',{CornerRadius=al.Scale==0 and UDim.new(0,math.floor(al.Offset*k.Roundness+0.5))or al,Parent=ak})if al.Scale==0 then k._cornerBases[am]=al.Offset end return am end function k._fixedCorner(ak,al)return ai('UICorner',{CornerRadius=al,Parent=ak})end function k._radius(ak)return math.floor(ak*k.Roundness+0.5)end local function ak(al,am,an,ao)return ai('UIStroke',{Color=am or z.Stroke,Transparency=an or 0,Thickness=ao or 1,ApplyStrokeMode=Enum.ApplyStrokeMode.Border,Parent=al})end local function al(am,an,ao,ap,aq)return ai('UIPadding',{PaddingLeft=UDim.new(0,an or 0),PaddingRight=UDim.new(0,ao or 0),PaddingTop=UDim.new(0,ap or 0),PaddingBottom=UDim.new(0,aq or 0),Parent=am})end local function am(an)local ao={BackgroundTransparency=1,TextColor3=z.Text,TextSize=14,FontFace=D.Medium,TextXAlignment=Enum.TextXAlignment.Left,TextYAlignment=Enum.TextYAlignment.Center,TextTruncate=Enum.TextTruncate.AtEnd}for ap,aq in pairs(an)do ao[ap]=aq end return ai('TextLabel',ao)end local function an(ao,ap,aq,ar,as)local at=ai('ImageLabel',{AnchorPoint=Vector2.new(0.5,0.5),Position=aq,Size=ap,BackgroundTransparency=1,Image=A.Glow,ImageColor3=Color3.fromRGB(226,218,230),ImageTransparency=1,Visible=false,ZIndex=0,Parent=ao})local au=ai('UIGradient',{Rotation=as or 90,Parent=at})ag(au,function()au.Color=ColorSequence.new(Color3.fromRGB(255,255,255),z.Accent)end)return at end local function ao(ap)return ai('Frame',{Position=UDim2.fromOffset(0,0),Size=UDim2.new(1,0,0,1),BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,BorderSizePixel=0,ZIndex=0,Parent=ap})end local ap=1.35 local function aq(ar,as,at)local au,av,aw,ax,ay=w(as)if not au then return end ar.Image=au ar.ImageRectOffset=av or Vector2.zero ar.ImageRectSize=aw or Vector2.zero if as==A.Logo then ay=true end local az=ax and not ay ar:SetAttribute('CustomIcon',az or nil)if az then ah(ar,{ImageColor3=Color3.new(1,1,1)},0)end local aA=ax and not at and as~=A.Logo and(typeof(as)=='table'and tonumber(as.Scale)or ap)or 1 local aB=ar:FindFirstChild('CustomIconScale')if aA~=1 then aB=aB or ai('UIScale',{Name='CustomIconScale',Parent=ar})aB.Scale=aA elseif aB then aB:Destroy()end end local function ar(as,at,au,av)if as:GetAttribute('CustomIcon')then ah(as,{ImageTransparency=au and 0 or 0.4},av)else ah(as,{ImageColor3=at},av)end end local function as()local at pcall(function()if typeof(gethui)=='function'then at=gethui()end end)if typeof(at)=='Instance'then return at end local au pcall(function()au=game:GetService('CoreGui')local av=Instance.new('Folder')av.Parent=au av:Destroy()end)if au then return au end return j:WaitForChild('PlayerGui')end local at,au=nil,Vector2.zero local function av()local aw=time()if at~=aw then at=aw au=c:GetGuiInset()end return b:GetMouseLocation()-au end local function aw(ax)return ax.UserInputType==Enum.UserInputType.MouseButton1 or ax.UserInputType==Enum.UserInputType.Touch end local function ax()return b:GetLastInputType()==Enum.UserInputType.Touch end local function ay(az,aA)local aB az.InputBegan:Connect(function(aC)if aw(aC)then local aD=aA()aB=aD and aD.CanvasPosition end end)return function()local aC=aA()return not(aB and aC and(aC.CanvasPosition-aB).Magnitude>4)end end local function az(aA,aB)local aC,aD=aB.AbsolutePosition,aB.AbsoluteSize return aA.X>=aC.X and aA.X<=aC.X+aD.X and aA.Y>=aC.Y and aA.Y<=aC.Y+aD.Y end local function aA(aB)return aB.UserInputType==Enum.UserInputType.MouseMovement or aB.UserInputType==Enum.UserInputType.Touch end local function aB(aC,aD,aE,aF)local aG=ai('Frame',{AnchorPoint=Vector2.new(0,0.5),Position=aF,Size=UDim2.fromOffset(16,16),BackgroundTransparency=1,Parent=aC})local aH=ai('ImageLabel',{Size=UDim2.fromScale(1,1),BackgroundTransparency=1,ImageColor3=aE,ScaleType=Enum.ScaleType.Fit,Parent=aG})aq(aH,aD)return aG,aH end local function aC(aD,aE,aF)local aG=ai('Frame',{AnchorPoint=Vector2.new(aE,0.5),Position=UDim2.new(aE,aF,0.5,0),Size=UDim2.fromOffset(18,18),BackgroundTransparency=1,Parent=aD})local aH={}local aI=ai('ImageLabel',{AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.fromScale(0.5,0.5),Size=UDim2.fromOffset(16,16),BackgroundTransparency=1,ImageColor3=z.Muted,ScaleType=Enum.ScaleType.Fit,Parent=aG})aq(aI,'chevron-down')if aI.Image~=''then function aH:Set(aJ)ah(aI,{Rotation=aJ and 180 or 0,ImageColor3=aJ and z.Accent or z.Muted},0.3,Enum.EasingStyle.Quint)end return aH end aI:Destroy()local function aJ(aK,aL)return am({AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.fromScale(0.5,0.5),Size=UDim2.fromOffset(18,18),Text='\u{203a}',TextSize=22,TextXAlignment=Enum.TextXAlignment.Center,TextColor3=z.Muted,TextTransparency=aL,Rotation=aK,Parent=aG})end local aK=aJ(90,0)local aL=aJ(270,1)function aH:Set(aM)ah(aK,{TextTransparency=aM and 1 or 0},0.2)ah(aL,{TextTransparency=aM and 0 or 1,TextColor3=aM and z.Accent or z.Muted},0.2)end return aH end local aD={}local function aE(aF)local aG=av()local aH=math.max(aF.AbsoluteSize.X,aF.AbsoluteSize.Y)*2.2 local aI=table.remove(aD)if aI and not pcall(function()aI.Parent=nil end)then aI=nil end if not aI then aI=ai('Frame',{AnchorPoint=Vector2.new(0.5,0.5),BackgroundColor3=z.Accent,BorderSizePixel=0})aj(aI,UDim.new(1,0))end aI.Position=UDim2.fromOffset(aG.X-aF.AbsolutePosition.X,aG.Y-aF.AbsolutePosition.Y)aI.Size=UDim2.fromOffset(0,0)aI.BackgroundColor3=z.Accent aI.BackgroundTransparency=0.82 aI.ZIndex=aF.ZIndex+1 aI.Parent=aF ah(aI,{Size=UDim2.fromOffset(aH,aH),BackgroundTransparency=1},0.55)task.delay(0.55,function()if aI.Parent~=aF or not aF.Parent then pcall(aI.Destroy,aI)return end aI.Parent=nil if#aD<4 then table.insert(aD,aI)else aI:Destroy()end end)end local function aF(aG)if not aG or aG:GetAttribute('Hidden')then return end ah(aG,{Color=z.Accent,Transparency=0.2},0.08)task.delay(0.12,function()ah(aG,{Color=z.Stroke,Transparency=0},0.35)end)end local function aG(aH,aI)aH.MouseEnter:Connect(function()ah(aI,{Color=z.StrokeHover},0.12)end)aH.MouseLeave:Connect(function()ah(aI,{Color=z.Stroke},0.25)end)end local aH={[Enum.KeyCode.LeftControl]='LCtrl',[Enum.KeyCode.RightControl]='RCtrl',[Enum.KeyCode.LeftShift]='LShift',[Enum.KeyCode.RightShift]='RShift',[Enum.KeyCode.LeftAlt]='LAlt',[Enum.KeyCode.RightAlt]='RAlt',[Enum.KeyCode.Return]='Enter',[Enum.KeyCode.Escape]='Esc',[Enum.KeyCode.Backspace]='Backspace'}local function aI(aJ)if aJ==nil then return'None'end return aH[aJ]or aJ.Name end local function aJ(aK,...)if type(aK)~='function'then return end local aL,aM=pcall(aK,...)if not aL then warn('[AirFlow] callback error: '..tostring(aM))end end local function aK(aL)local aM=nil task.spawn(function()aM=table.pack(pcall(aL))end)while aM==nil do task.wait()end return table.unpack(aM,1,aM.n)end local function aL(aM,aN,aO)local aP=0 local aQ=tostring(aO)local aR=aQ:find('%.')if aR then aP=#aQ-aR end local aS='%.'..aP..'f'return{snap=function(aT)aT=math.floor(aT/aO+0.5)*aO return math.clamp(aT,aM,aN)end,format=function(aT)return string.format(aS,aT)end}end local function aM(aN)return aN._metrics or P.Card end local function aN(aO,aP)local aQ=aO.AbsoluteSize.X/aP.Scale.Scale return math.clamp(math.floor(aQ*0.48),90,220)end local function aO(aP,aQ,aR,aS)local aT=aM(aP).Compact local aU={Size=UDim2.new(1,0,0,aR),BackgroundColor3=z.Surface2,BackgroundTransparency=aT and 1 or 0,BorderSizePixel=0,LayoutOrder=aP:_nextOrder(),Parent=aP.List}if aQ=='TextButton'then aU.AutoButtonColor=false aU.Text=''end local aV=ai(aQ,aU)aV:SetAttribute('NoDrag',true)aj(aV)local aW=ak(aV,z.Stroke,aT and 1 or 0)if aT then aW:SetAttribute('Hidden',true)end return aV,aW end local function aP(aQ,aR,aS,aT,aU)aU=aU or P.Card local aV,aW if aS then local aX=math.floor((aU.DescHeight-(aU.DescGap+aU.DescLine))/2)aV=am({Position=UDim2.fromOffset(14,aX),Size=UDim2.new(1,-(14+aT),0,aU.TitleHeight),Text=aR,TextSize=aU.TextSize,Parent=aQ})aW=am({Position=UDim2.fromOffset(14,aX+aU.DescGap),Size=UDim2.new(1,-(14+aT),0,aU.DescLine),Text=aS,TextSize=aU.DescSize,FontFace=D.Regular,TextColor3=z.Muted,Parent=aQ})else aV=am({Position=UDim2.fromOffset(14,0),Size=UDim2.new(1,-(14+aT),1,0),Text=aR,TextSize=aU.TextSize,Parent=aQ})end return aV,aW end local function aQ(aR,aS,aT,aU,aV,aW)aS=l(aS,aT)local aX=aM(aR)local aY=aS.Desc and aX.DescHeight or aX.Height local aZ,a_=aO(aR,aU or'Frame',aY,aS)aG(aZ,a_)local a0,a1 if aV then a0,a1=aP(aZ,aS.Name or aW,aS.Desc,aV,aX)end return aS,aZ,a_,aY,a0,a1 end local function aR(aS,aT,aU)if aS then aS.Size=UDim2.new(1,-(14+aU),aS.Size.Y.Scale,aS.Size.Y.Offset)end if aT then aT.Size=UDim2.new(1,-(14+aU),0,aT.Size.Y.Offset)end end local aS={}aS.__index=aS function aS:_nextOrder()self._order=self._order+1 return self._order end function aS:Section(aT)local aU=not(type(aT)=='table'and aT.Visible==false)if type(aT)=='table'then aT=aT.Name or aT.Title or''end local aV=aM(self).Compact and 14 or 2 local aW=ai('Frame',{Size=UDim2.new(1,0,0,28),BackgroundTransparency=1,LayoutOrder=self:_nextOrder(),Parent=self.List})local aX=am({Position=UDim2.fromOffset(aV,8),Size=UDim2.new(0,0,0,16),AutomaticSize=Enum.AutomaticSize.X,Text=string.upper(aT),TextSize=12,TextColor3=z.Muted,TextTruncate=Enum.TextTruncate.None,Parent=aW})local aY=aV==2 and 0 or aV local aZ=ai('Frame',{AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-aY,0,16),Size=UDim2.new(1,-12,0,1),BackgroundColor3=z.Stroke,BorderSizePixel=0,Parent=aW})local function a_()aZ.Size=UDim2.new(1,-(aX.AbsoluteSize.X/self.Window.Scale.Scale+aV+12+aY),0,1)end aX:GetPropertyChangedSignal('AbsoluteSize'):Connect(a_)task.defer(a_)return m(self,{Visible=aU},{Set=function(a0,a1)aX.Text=string.upper(a1)end},aW,'Section')end function aS:Divider(aT)local aU=type(aT)=='table'and(aT.Text or aT.Name)or type(aT)=='string'and aT or nil if aU then local aV=aM(self).Compact and 14 or 2 local aW=ai('Frame',{Size=UDim2.new(1,0,0,18),BackgroundTransparency=1,LayoutOrder=self:_nextOrder(),Parent=self.List})local aX=am({AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.fromScale(0.5,0.5),Size=UDim2.new(0,0,0,14),AutomaticSize=Enum.AutomaticSize.X,Text=aU,TextSize=11,FontFace=D.Regular,TextColor3=z.Muted,TextTruncate=Enum.TextTruncate.None,Parent=aW})al(aX,8,8)local aY={}for aZ,a_ in ipairs({0,1})do aY[aZ]=ai('Frame',{AnchorPoint=Vector2.new(a_,0.5),Position=UDim2.new(a_,a_==0 and aV or-aV,0.5,0),Size=UDim2.new(0.5,-aV,0,1),BackgroundColor3=z.Stroke,BorderSizePixel=0,Parent=aW})end local function aZ()local a_=aX.AbsoluteSize.X/self.Window.Scale.Scale/2 for a0,a1 in ipairs(aY)do a1.Size=UDim2.new(0.5,-(aV+a_),0,1)end end aX:GetPropertyChangedSignal('AbsoluteSize'):Connect(aZ)task.defer(aZ)return m(self,{Visible=not(type(aT)=='table'and aT.Visible==false)},{Set=function(a_,a0)aX.Text=tostring(a0)end},aW,'Divider')end local aV=ai('Frame',{Size=UDim2.new(1,0,0,1),BackgroundColor3=z.Stroke,BorderSizePixel=0,LayoutOrder=self:_nextOrder(),Parent=self.List})if aM(self).Compact then aV.BackgroundTransparency=1 aV.Size=UDim2.new(1,0,0,9)ai('Frame',{Position=UDim2.fromOffset(14,4),Size=UDim2.new(1,-28,0,1),BackgroundColor3=z.Stroke,BorderSizePixel=0,Parent=aV})end return m(self,{Visible=not(type(aT)=='table'and aT.Visible==false)},{},aV,'Divider')end function aS:Label(aT)aT=l(aT,{Name='Text',Title='Text'})local aU=am({Size=UDim2.new(1,0,0,18),Text=k._rich(aT.Text or''),TextSize=13,FontFace=D.Regular,TextColor3=k._color(aT.Color)or z.Muted,RichText=true,LayoutOrder=self:_nextOrder(),Parent=self.List})if aM(self).Compact then aU.TextSize=12 al(aU,14,14)else al(aU,2)end local aV={Set=function(aV,aW)aU.Text=k._rich(aW)end,Get=function()return aU.Text end,SetColor=function(aV,aW)ah(aU,{TextColor3=k._color(aW)or z.Muted},0.25)end}if type(aT.Update)=='function'then local aW=math.max(tonumber(aT.UpdateRate)or 1,0.05)local aX=true aV._listeners=aV._listeners or{}table.insert(aV._listeners,function()aX=false end)task.spawn(function()while aX and aU.Parent do local aY,aZ=aK(aT.Update)if aY and aZ~=nil then aU.Text=k._rich(aZ)elseif not aY then warn('[AirFlow] label update error: '..tostring(aZ))end task.wait(aW)end end)function aV:SetUpdateRate(aY)aW=math.max(tonumber(aY)or aW,0.05)end end return m(self,aT,aV,aU,'Label')end function aS:Paragraph(aT)aT=l(aT,{Title='Name'})local aU=aO(self,'Frame',0,aT)aU.AutomaticSize=Enum.AutomaticSize.Y if aM(self).Compact then al(aU,14,14,6,8)else al(aU,14,14,11,12)end ai('UIListLayout',{SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,4),Parent=aU})am({Size=UDim2.new(1,0,0,14),Text=aT.Name or'',LayoutOrder=1,Parent=aU})local aV=am({Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,Text=k._rich(aT.Content or''),TextSize=13,FontFace=D.Regular,TextColor3=z.Muted,TextWrapped=true,TextTruncate=Enum.TextTruncate.None,TextYAlignment=Enum.TextYAlignment.Top,RichText=true,LayoutOrder=2,Parent=aU})return m(self,aT,{Set=function(aW,aX)aV.Text=k._rich(aX)end},aU,'Paragraph')end local function aT(aU,aV)local aW=aV.Style=='Primary'local aX=E and 34 or 28 local aY=aX+6+(aV.Desc and 16 or 0)local aZ=aO(aU,'TextButton',aY,aV)local a_=ai('Frame',{Position=UDim2.fromOffset(14,3),Size=UDim2.new(1,-28,0,aX),BackgroundColor3=aW and z.Accent or z.Surface3,BackgroundTransparency=aW and 0.12 or 0.45,BorderSizePixel=0,ClipsDescendants=true,Parent=aZ})aj(a_,UDim.new(0,6))local a0=ak(a_,aW and z.Accent or z.Stroke,aW and 0.4 or 0)local a1=ai('Frame',{AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.fromScale(0.5,0.5),Size=UDim2.new(0,0,1,0),AutomaticSize=Enum.AutomaticSize.X,BackgroundTransparency=1,Parent=a_})ai('UIListLayout',{FillDirection=Enum.FillDirection.Horizontal,VerticalAlignment=Enum.VerticalAlignment.Center,SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,6),Parent=a1})local a2=aW and z.AccentDark or z.Text if aV.Icon then local a3=ai('ImageLabel',{Size=UDim2.fromOffset(14,14),BackgroundTransparency=1,ImageColor3=aW and z.AccentDark or z.Accent,ScaleType=Enum.ScaleType.Fit,LayoutOrder=1,Parent=a1})aq(a3,aV.Icon)end local a3=am({Size=UDim2.new(0,0,1,0),AutomaticSize=Enum.AutomaticSize.X,Text=aV.Name or'Button',TextSize=13,TextColor3=a2,TextTruncate=Enum.TextTruncate.None,LayoutOrder=2,Parent=a1})if aV.Desc then am({Position=UDim2.fromOffset(14,aX+6),Size=UDim2.new(1,-28,0,14),Text=aV.Desc,TextSize=12,FontFace=D.Regular,TextColor3=z.Muted,Parent=aZ})end local a4=aW and 0.12 or 0.45 aZ.MouseEnter:Connect(function()ah(a_,{BackgroundTransparency=aW and 0 or 0.2},0.12)ah(a0,aW and{Transparency=0}or{Color=z.StrokeHover},0.12)end)aZ.MouseLeave:Connect(function()ah(a_,{BackgroundTransparency=a4},0.25)ah(a0,aW and{Transparency=0.4}or{Color=z.Stroke},0.25)end)aZ.MouseButton1Click:Connect(function()aE(a_)aJ(aV.Callback)end)return m(aU,aV,{SetText=function(a5,a6)a3.Text=a6 end},aZ,'Button')end function aS:Button(aU)aU=l(aU,{Title='Name',Description='Desc'})if aM(self).Compact then return aT(self,aU)end local aV=aU.Style=='Primary'local aW=aU.Desc and J or I local aX,aY=aO(self,'TextButton',aW,aU)aX.ClipsDescendants=true if aV then ah(aX,{BackgroundColor3=z.Accent,BackgroundTransparency=0.12},0)ah(aY,{Color=z.Accent},0)aY.Transparency=0.4 aX.MouseEnter:Connect(function()ah(aX,{BackgroundTransparency=0},0.12)ah(aY,{Transparency=0},0.12)end)aX.MouseLeave:Connect(function()ah(aX,{BackgroundTransparency=0.12},0.25)ah(aY,{Transparency=0.4},0.25)end)else aG(aX,aY)end local aZ=aV and z.AccentDark or z.Text local a_=0 if aU.Icon then aB(aX,aU.Icon,aV and z.AccentDark or z.Accent,UDim2.new(0,14,0.5,0))a_=26 end local a0=aP(aX,aU.Name or'Button',aU.Desc,30)if a_>0 then for a1,a2 in ipairs(aX:GetChildren())do if a2:IsA('TextLabel')then a2.Position=a2.Position+UDim2.fromOffset(a_,0)a2.Size=a2.Size-UDim2.fromOffset(a_,0)end end end if aV then for a1,a2 in ipairs(aX:GetChildren())do if a2:IsA('TextLabel')then ah(a2,{TextColor3=aZ},0)end end end aB(aX,x,aV and z.AccentDark or z.Muted,UDim2.new(1,-30,0.5,0))aX.MouseButton1Click:Connect(function()aE(aX)aJ(aU.Callback)end)return m(self,aU,{SetText=function(a1,a2)a0.Text=a2 end},aX,'Button')end function aS:Toggle(aU)local aV,aW aU,aV,aW=aQ(self,aU,{Title='Name',Description='Desc',CurrentValue='Default',Value='Default'},'TextButton',56,'Toggle')local aX=ai('Frame',{AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-14,0.5,0),Size=E and UDim2.fromOffset(44,24)or UDim2.fromOffset(36,20),BackgroundColor3=z.Surface3,BorderSizePixel=0,Parent=aV})aj(aX,UDim.new(1,0))ak(aX,z.Stroke)local aY=ai('Frame',{AnchorPoint=Vector2.new(0,0.5),Position=UDim2.new(0,3,0.5,0),Size=E and UDim2.fromOffset(18,18)or UDim2.fromOffset(14,14),BackgroundColor3=z.Muted,BorderSizePixel=0,Parent=aX})aj(aY,UDim.new(1,0))local aZ=ai('ImageLabel',{AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.fromScale(0.5,0.5),Size=UDim2.new(1,24,1,24),BackgroundTransparency=1,Image=A.Glow,ImageColor3=z.Accent,ImageTransparency=1,ZIndex=0,Parent=aX})local a_={Value=aU.Default==true}local function a0(a1)local a2=a_.Value local a3=a1 and 0.25 or 0 ah(aX,{BackgroundColor3=a2 and z.Accent or z.Surface3},a3)ah(aZ,{ImageTransparency=a2 and 0.75 or 1},a3)local a4=E and 18 or 14 ah(aY,{Position=a2 and UDim2.new(0,(E and 44 or 36)-3-a4,0.5,0)or UDim2.new(0,3,0.5,0),BackgroundColor3=a2 and z.AccentDark or z.Muted},a3,Enum.EasingStyle.Back)if a1 then ah(aY,{Size=UDim2.fromOffset(a4+4,a4-2)},0.08)task.delay(0.08,function()ah(aY,{Size=UDim2.fromOffset(a4,a4)},0.2,Enum.EasingStyle.Back)end)end end local a1=false function a_:Set(a2,a3)a2=a2==true if a2==a_.Value then return end a_.Value=a2 a0(true)if not a1 then aF(aW)end if not a3 then aJ(aU.Callback,a2)end end function a_:Get()return a_.Value end a0(false)aV.MouseButton1Click:Connect(function()a1=true a_:Set(not a_.Value)a1=false end)local a2=m(self,aU,a_,aV,'Toggle')if a_.Value then aJ(aU.Callback,true)end return a2 end function aS:Slider(aU)aU=l(aU,{Title='Name',Description='Desc',CurrentValue='Default',Value='Default',Increment='Step'})local aV=aU.Min or 0 local aW=aU.Max or 100 local aX=aU.Step or 1 local aY=aU.Suffix or''local aZ=aL(aV,aW,aX)local a_=aM(self)local a0=a_.Compact local a1=a_.Slider local a2,a3=aO(self,'Frame',a1,aU)aG(a2,a3)am({Position=UDim2.fromOffset(14,a0 and 5 or 12),Size=UDim2.new(1,-120,0,18),Text=aU.Name or'Slider',TextSize=a_.TextSize,Parent=a2})local a4=ai('Frame',{AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,a0 and-14 or-10,0,a0 and 2 or 9),Size=UDim2.fromOffset(40,24),BackgroundColor3=z.Surface,BorderSizePixel=0,ClipsDescendants=true,Parent=a2})aj(a4,UDim.new(0,6))local a5=ak(a4)local a6=am({Size=UDim2.new(1,0,1,0),TextSize=13,TextColor3=z.Accent,TextXAlignment=Enum.TextXAlignment.Center,TextTruncate=Enum.TextTruncate.None,Parent=a4})local a7=ai('TextBox',{Position=UDim2.fromOffset(9,0),Size=UDim2.new(0,0,1,0),AutomaticSize=Enum.AutomaticSize.X,BackgroundTransparency=1,Text='',TextColor3=z.Text,TextSize=13,FontFace=D.Medium,TextXAlignment=Enum.TextXAlignment.Left,ClearTextOnFocus=false,Visible=false,Parent=a4})ai('UISizeConstraint',{MinSize=Vector2.new(14,0),Parent=a7})local a8=am({Size=UDim2.new(0,0,1,0),AutomaticSize=Enum.AutomaticSize.X,Text=aY,TextSize=13,TextColor3=z.Accent,TextTruncate=Enum.TextTruncate.None,Visible=false,Parent=a4})local a9=ai('TextButton',{Size=UDim2.fromScale(1,1),BackgroundTransparency=1,Text='',AutoButtonColor=false,ZIndex=2,Parent=a4})local ba=false local function bb(bc)local bd if ba then bd=9+a7.AbsoluteSize.X/(self.Window.Scale.Scale)+a8.TextBounds.X+9 a8.Position=UDim2.fromOffset(9+a7.AbsoluteSize.X/(self.Window.Scale.Scale),0)else bd=a6.TextBounds.X+18 end bd=math.max(bd,36)if bc then a4.Size=UDim2.fromOffset(bd,24)else ah(a4,{Size=UDim2.fromOffset(bd,24)},0.2)end end a6:GetPropertyChangedSignal('TextBounds'):Connect(function()if not ba then bb(false)end end)a7:GetPropertyChangedSignal('AbsoluteSize'):Connect(function()if ba then bb(false)end end)local bc=ai('Frame',{Position=UDim2.new(0,14,0,a1-(a0 and 13 or 18)),Size=UDim2.new(1,-28,0,5),BackgroundColor3=z.Surface3,BorderSizePixel=0,Parent=a2})aj(bc,UDim.new(1,0))local bd=ai('Frame',{Size=UDim2.new(0,0,1,0),BackgroundColor3=z.Accent,BorderSizePixel=0,Parent=bc})aj(bd,UDim.new(1,0))local be=ai('ImageLabel',{AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.new(0,0,0.5,0),Size=UDim2.fromOffset(28,28),BackgroundTransparency=1,Image=A.Glow,ImageColor3=z.Accent,ImageTransparency=0.85,ZIndex=2,Parent=bc})local bf=ai('Frame',{AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.new(0,0,0.5,0),Size=UDim2.fromOffset(12,12),BackgroundColor3=z.Accent,BorderSizePixel=0,ZIndex=3,Parent=bc})aj(bf,UDim.new(1,0))local bg=ai('TextButton',{Position=UDim2.new(0,8,0,a1-(a0 and 13 or 18)-(E and 19 or 13)),Size=UDim2.new(1,-16,0,E and 40 or 28),BackgroundTransparency=1,Text='',AutoButtonColor=false,ZIndex=4,Parent=a2})local bh={Value=math.clamp(aU.Default or aV,aV,aW)}local bi=false a9.MouseEnter:Connect(function()ah(a5,{Color=z.StrokeHover},0.12)end)a9.MouseLeave:Connect(function()if not a7:IsFocused()then ah(a5,{Color=z.Stroke},0.2)end end)a9.MouseButton1Click:Connect(function()ba=true a7.Text=aZ.format(bh.Value)a6.Visible=false a7.Visible=true a8.Visible=aY~=''a9.Visible=false ah(a5,{Color=z.StrokeHover},0.12)a7:CaptureFocus()task.defer(bb,false)end)a7.FocusLost:Connect(function()local bj=tonumber(a7.Text)ba=false a7.Visible=false a8.Visible=false a6.Visible=true a9.Visible=true ah(a5,{Color=z.Stroke},0.2)if bj then bh:Set(bj)end bb(false)end)bg.MouseEnter:Connect(function()if not bi then ah(be,{ImageTransparency=0.78,Size=UDim2.fromOffset(34,34)},0.15)end end)bg.MouseLeave:Connect(function()if not bi then ah(be,{ImageTransparency=0.85,Size=UDim2.fromOffset(28,28)},0.2)end end)local bj=aZ.snap local function bk()return(aW-aV)==0 and 0 or(bh.Value-aV)/(aW-aV)end local function bl(bm,bn,bo)bo=bo or Enum.EasingStyle.Linear ah(bd,{Size=UDim2.new(bm,0,1,0)},bn,bo)ah(bf,{Position=UDim2.new(bm,0,0.5,0)},bn,bo)ah(be,{Position=UDim2.new(bm,0,0.5,0)},bn,bo)end local function bm(bn,bo)bl(bk(),bn,bo)a6.Text=aZ.format(bh.Value)..aY end local function bn(bo)local bp=bk()local bq=math.max(bc.AbsoluteSize.X,1)local br=(bp>=bo and 1 or-1)*(5/bq)bl(math.clamp(bp+br,0,1),0.22,Enum.EasingStyle.Quint)task.delay(0.22,function()if not bi then bl(bk(),0.18,Enum.EasingStyle.Quint)end end)a6.Text=aZ.format(bh.Value)..aY end local function bo()ah(bf,{Size=UDim2.fromOffset(14,12)},0.08)ah(be,{Size=UDim2.fromOffset(32,32),ImageTransparency=0.78},0.12)task.delay(0.1,function()ah(bf,{Size=UDim2.fromOffset(12,12)},0.25,Enum.EasingStyle.Quint)ah(be,{Size=UDim2.fromOffset(28,28),ImageTransparency=0.85},0.25)end)end function bh:Set(bp,bq)bp=bj(tonumber(bp)or aV)if bp==bh.Value then return end local br=bk()bh.Value=bp if bi then bm(0.05)else bn(br)bo()aF(a3)end if not bq then aJ(aU.Callback,bp)end end function bh:Get()return bh.Value end local function bp(bq)local br=math.clamp((bq-bc.AbsolutePosition.X)/bc.AbsoluteSize.X,0,1)bh:Set(aV+(aW-aV)*br)end bg.InputBegan:Connect(function(bq)if aw(bq)then bi=true bh.Dragging=true ah(bf,{Size=UDim2.fromOffset(16,16)},0.15,Enum.EasingStyle.Back)ah(be,{Size=UDim2.fromOffset(44,44),ImageTransparency=0.7},0.15)bp(av().X)end end)self.Window:_listen('Changed',function(bq)if bi and aA(bq)then bp(av().X)end end,bh)self.Window:_listen('Ended',function(bq)if bi and aw(bq)then bi=false bh.Dragging=false ah(bf,{Size=UDim2.fromOffset(12,12)},0.2)ah(be,{Size=UDim2.fromOffset(28,28),ImageTransparency=0.85},0.2)aJ(aU.OnRelease,bh.Value)end end,bh)bh.Value=bj(bh.Value)bm(0)task.defer(bb,true)return m(self,aU,bh,a2,'Slider')end function aS:Dropdown(aU)aU=l(aU,{Title='Name',Description='Desc',CurrentOption='Default',Value='Default',MultipleOptions='Multi',Values='Options'})if aU.Multi and type(aU.Default)~='table'and aU.Default~=nil then aU.Default={aU.Default}elseif not aU.Multi and type(aU.Default)=='table'then aU.Default=aU.Default[1]end local aV=aU.Multi==true local aW=aU.Options or{}local aX,aY,aZ aU,aX,aY,aZ=aQ(self,aU,{},'Frame')local a_=aM(self)local a0=a_.Compact local a1=a_.Chip local a2=self.Window local a3=E and 40 or 30 local a4=aU.MaxRows or 6 local a5=a0 and aU.Stacked==true local a6=2 if a5 then a6=(aU.Name or'')~=''and 20 or 2 a1=E and 34 or 30 aZ=a6+a1+4 aX.Size=UDim2.new(1,0,0,aZ)end local a7=ai('TextButton',{Size=UDim2.new(1,0,0,aZ),BackgroundTransparency=1,Text='',AutoButtonColor=false,Parent=aX})local a8,a9 if not a5 then a8,a9=aP(a7,aU.Name or'Dropdown',aU.Desc,180,a_)elseif a6>2 then a8=am({Position=UDim2.fromOffset(14,1),Size=UDim2.new(1,-28,0,16),Text=aU.Name,TextSize=a_.TextSize,Parent=a7})end local ba=ai('Frame',{AnchorPoint=a5 and Vector2.zero or Vector2.new(1,0.5),Position=a5 and UDim2.fromOffset(14,a6)or UDim2.new(1,a0 and-14 or-10,0.5,0),Size=UDim2.fromOffset(60,a1),BackgroundColor3=z.Surface,BorderSizePixel=0,ClipsDescendants=true,Parent=a7})aj(ba,UDim.new(0,6))local bb=ak(ba)local bc=am({Position=UDim2.fromOffset(10,0),Size=UDim2.new(1,-34,1,0),TextColor3=z.Muted,TextSize=13,TextTruncate=Enum.TextTruncate.None,ClipsDescendants=true,Parent=ba})local bd=aC(ba,1,-6)local be=am({Size=UDim2.fromOffset(0,a1),AutomaticSize=Enum.AutomaticSize.X,TextSize=13,Visible=false,Parent=ba})local bf=''local function bg()local bh=(a5 and aX.AbsoluteSize.X/a2.Scale.Scale-28 or a0 and aN(aX,a2)or 190)-10-34 be.Text=bf if be.TextBounds.X<=bh then return bf end local bi=bf while#bi>1 do bi=bi:sub(1,-2)be.Text=bi..'..'if be.TextBounds.X<=bh then return bi..'..'end end return'..'end local function bh(bi)if a5 then ba.Size=UDim2.new(1,-28,0,a1)return end local bj if a0 then bj=aN(aX,a2)else bj=math.clamp(bc.TextBounds.X+10+34,60,190)end aR(a8,a9,bj+(a0 and 24 or 20))if bi then ba.Size=UDim2.fromOffset(bj,a1)else ah(ba,{Size=UDim2.fromOffset(bj,a1)},0.2)end end bc:GetPropertyChangedSignal('TextBounds'):Connect(function()if not a0 then bh(false)end end)if a0 then local bi,bj=0,false aX:GetPropertyChangedSignal('AbsoluteSize'):Connect(function()local bk=aX.AbsoluteSize.X if bk==bi then return end bi=bk bh(true)if not bj then bj=true task.delay(0.12,function()bj=false bc.Text=bg()end)end end)end local bi=ai('Frame',{AnchorPoint=Vector2.new(1,0),Size=UDim2.fromOffset(220,0),BackgroundTransparency=1,Visible=false,ZIndex=45,Parent=a2.Body})bi:SetAttribute('NoDrag',true)local bj=ai('ImageLabel',{Position=UDim2.fromOffset(-18,-12),Size=UDim2.new(1,36,1,36),BackgroundTransparency=1,Image=A.Shadow,ImageColor3=Color3.new(0,0,0),ImageTransparency=1,ScaleType=Enum.ScaleType.Slice,SliceCenter=Rect.new(49,49,450,450),Parent=bi})local bk=ai('Frame',{Size=UDim2.fromScale(1,1),BackgroundColor3=z.Background,BorderSizePixel=0,ClipsDescendants=true,Parent=bi})aj(bk,UDim.new(0,10))local bl=ak(bk,z.Stroke,1)ao(bk)local bm=ai('Frame',{Size=UDim2.new(1,0,0,120),BackgroundTransparency=1,Parent=bk})al(bm,8,8,8,8)local bn=ai('Frame',{Size=UDim2.new(1,0,0,32),BackgroundColor3=z.Surface,BorderSizePixel=0,Parent=bm})aj(bn,UDim.new(0,7))local bo=ak(bn)local bp,bq=aB(bn,'search',z.Muted,UDim2.new(0,10,0.5,0))bp.Size=UDim2.fromOffset(14,14)local br=ai('TextBox',{Position=UDim2.fromOffset(32,0),Size=UDim2.new(1,-40,1,0),BackgroundTransparency=1,Text='',PlaceholderText=aU.SearchPlaceholder or'Search',PlaceholderColor3=z.Muted,TextColor3=z.Text,TextSize=13,FontFace=D.Regular,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,ClearTextOnFocus=false,Parent=bn})br.Focused:Connect(function()ah(bo,{Color=z.StrokeHover},0.15)ah(bq,{ImageColor3=z.Accent},0.15)end)br.FocusLost:Connect(function()ah(bo,{Color=z.Stroke},0.2)ah(bq,{ImageColor3=z.Muted},0.2)end)local bs=ai('Frame',{Size=UDim2.new(1,0,0,28),BackgroundTransparency=1,Visible=aV,Parent=bm})local function bt(bu,bv)local bw=ai('TextButton',{Position=bv,Size=UDim2.new(0.5,-3,1,0),BackgroundColor3=z.Surface3,BackgroundTransparency=0.35,BorderSizePixel=0,Text='',AutoButtonColor=false,ClipsDescendants=true,Parent=bs})aj(bw,UDim.new(0,6))local bx=ak(bw)am({Size=UDim2.fromScale(1,1),Text=bu,TextSize=12,TextXAlignment=Enum.TextXAlignment.Center,Parent=bw})bw.MouseEnter:Connect(function()ah(bw,{BackgroundTransparency=0.05},0.15)ah(bx,{Color=z.StrokeHover},0.15)end)bw.MouseLeave:Connect(function()ah(bw,{BackgroundTransparency=0.35},0.25)ah(bx,{Color=z.Stroke},0.25)end)bw.MouseButton1Click:Connect(function()aE(bw)end)return bw end local bu=bt(aU.SelectAllText or'Select all',UDim2.fromOffset(0,0))local bv=bt(aU.ClearAllText or'Clear all',UDim2.new(0.5,3,0,0))local bw=ai('ScrollingFrame',{Size=UDim2.new(1,0,0,100),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=E and 4 or 3,ScrollBarImageColor3=z.Accent,ScrollBarImageTransparency=0.4,ScrollingDirection=Enum.ScrollingDirection.Y,CanvasSize=UDim2.new(),Parent=bm})ai('UIListLayout',{SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,2),Parent=bw})local bx=am({Size=UDim2.new(1,0,0,a3),Text=aU.NoResultsText or'No results',TextSize=13,FontFace=D.Regular,TextColor3=z.Muted,TextXAlignment=Enum.TextXAlignment.Center,LayoutOrder=0,Visible=false,Parent=bw})local by={Open=false}local bz={}local bA={}local bB=''local function bC(bD)return bB==''or string.find(string.lower(tostring(bD)),bB,1,true)~=nil end local function bD(bE)return(bE:gsub('&','&amp;'):gsub('<','&lt;'):gsub('>','&gt;'))end local function bE(bF)local bG=tostring(bF)local bH=bB~=''and string.find(string.lower(bG),bB,1,true)if not bH then return bD(bG)end local bI=bH+#bB-1 return bD(bG:sub(1,bH-1))..'<font color="#'..z.Accent:ToHex()..'"><b>'..bD(bG:sub(bH,bI))..'</b></font>'..bD(bG:sub(bI+1))end if aV then for bF,bG in ipairs(aU.Default or{})do bz[bG]=true end elseif aU.Default~=nil then bz[aU.Default]=true end local function bF()if aV then local bG={}for bH,bI in ipairs(aW)do if bz[bI]then table.insert(bG,bI)end end return bG end for bG,bH in ipairs(aW)do if bz[bH]then return bH end end return nil end local function bG(bH,bI)local bJ,bK=bH.On==true,bH.Hover==true ah(bH.Frame,{BackgroundColor3=bJ and z.Accent or z.Surface3,BackgroundTransparency=bJ and(bK and 0.8 or 0.88)or(bK and 0.55 or 1)},bI)ah(bH.Label,{TextColor3=(bJ or bK)and z.Text or z.Muted},bI)end local function bH(bI,bJ)local bK=bz[bI.Option]==true if bI.On==bK and bJ then return end bI.On=bK local bL=bJ and 0.18 or 0 bG(bI,bL)if aV then ah(bI.Box,{BackgroundColor3=bK and z.Accent or z.Surface2},bL)ah(bI.BoxStroke,{Color=bK and z.Accent or z.Stroke},bL)else ah(bI.Bar,{BackgroundTransparency=bK and 0 or 1,Size=UDim2.fromOffset(3,bK and a3-14 or 4)},bJ and 0.3 or 0,Enum.EasingStyle.Quint)end ah(bI.Check,{ImageTransparency=bK and 0 or 1},bL)if bJ and bK then bI.CheckScale.Scale=0.5 ah(bI.CheckScale,{Scale=1},0.3,Enum.EasingStyle.Back)else bI.CheckScale.Scale=1 end end local function bI(bJ)local bK=bF()if#aW==0 then bf=aU.EmptyText or'None'elseif aV then if#bK>2 then bf=tostring(bK[1])..', '..tostring(bK[2])..'  +'..(#bK-2)else bf=#bK>0 and table.concat(bK,', ')or(aU.NoneText or'None')end else bf=bK~=nil and tostring(bK)or(aU.NoneText or'None')end bc.Text=bg()local bL=#aW>0 and(if aV then#bK>0 else bK~=nil)ah(bc,{TextColor3=bL and z.Text or z.Muted},bJ and 0.15 or 0)for bM,bN in pairs(bA)do bH(bN,bJ)end end local function bJ()local bK=0 for bL,bM in ipairs(aW)do if bC(bM)then bK+=1 end end return bK end local bK=true local bL=Vector2.new(220,120)local bM=false local function bN(bO)bK=aU.Searchable~=false and#aW>(aU.SearchAfter or 0)bn.Visible=bK local bP=0 if bK then bP+=38 end bs.Position=UDim2.fromOffset(0,bP)if aV and#aW>0 then bs.Visible=true bP+=34 else bs.Visible=false end local bQ=bJ()bx.Visible=bQ==0 local bR=math.clamp(bQ,1,a4)local bS=bR*a3+(bR-1)*2 bw.CanvasSize=UDim2.fromOffset(0,math.max(bQ,1)*(a3+2)-2)local bT=a2.Scale.Scale local bU=a2:_popupHost(aX)local bV=bU.AbsoluteSize.Y/bT local bW=(ba.AbsolutePosition.Y-bU.AbsolutePosition.Y)/bT local bX=math.max(bV-(bW+ba.AbsoluteSize.Y/bT)-14,bW-14)-bP-16 if bX>=a3 then bS=math.min(bS,bX)end bw.Position=UDim2.fromOffset(0,bP)bw.Size=UDim2.new(1,0,0,bS)local bY=math.max(math.floor(ba.AbsoluteSize.X/bT),aU.PopupWidth or 210)local bZ=bU.AbsoluteSize.X/bT bY=math.min(bY,math.max(bZ-16,120))bL=Vector2.new(bY,bP+bS+16)bm.Size=UDim2.new(1,0,0,bL.Y)if not bM then return end if bO then bi.Size=UDim2.fromOffset(bL.X,bL.Y)else ah(bi,{Size=UDim2.fromOffset(bL.X,bL.Y)},0.22,Enum.EasingStyle.Quint)end end local function bO()for bP,bQ in pairs(bA)do local bR=bC(bP)bQ.Frame.Visible=bR if bR then bQ.Label.Text=bE(bP)end end end local bP=nil local function bQ()local bR=a2:_popupHost(aX)local bS=a2.Scale.Scale if bP then local bT=ba.AbsolutePosition+ba.AbsoluteSize/2 if not az(bT,bP)then by:SetOpen(false)return end end local bT=bR.AbsoluteSize/bS local bU=(ba.AbsolutePosition-bR.AbsolutePosition)/bS local bV=ba.AbsoluteSize/bS local bW=math.clamp(bU.X+bV.X,bL.X+8,math.max(bT.X-8,bL.X+8))local bX=bU.Y+bV.Y+6 if bX+bL.Y>bT.Y-8 and bU.Y-6-bL.Y>=8 then bi.AnchorPoint=Vector2.new(1,1)bi.Position=UDim2.fromOffset(bW,bU.Y-6)bm.AnchorPoint=Vector2.new(0,1)bm.Position=UDim2.fromScale(0,1)else bi.AnchorPoint=Vector2.new(1,0)bi.Position=UDim2.fromOffset(bW,bX)bm.AnchorPoint=Vector2.zero bm.Position=UDim2.fromScale(0,0)end end local bR=nil local bS=0 local bT=nil local function bU()if bT then bT.ScrollingEnabled=true bT=nil end end local function bV()bw.CanvasPosition=Vector2.zero if aV then return end local bW=bF()if bW==nil then return end for bX,bY in ipairs(aW)do if bY==bW then bw.CanvasPosition=Vector2.new(0,math.max(0,(bX-2)*(a3+2)))return end end end local function bW(bX)if bX==by.Open then return end by.Open=bX bd:Set(bX)ah(bb,{Color=bX and z.Accent or z.Stroke,Transparency=bX and 0.35 or 0},0.2)ah(ba,{BackgroundColor3=bX and z.Surface2 or z.Surface},0.2)bS+=1 if bX then if a2._closePopup and a2._closePopup~=by._close then a2._closePopup()end a2._closePopup=by._close bP=aX:FindFirstAncestorWhichIsA('ScrollingFrame')if bP and bP.ScrollingEnabled then bT=bP bP.ScrollingEnabled=false end bi.Parent=a2:_popupHost(aX)bB=''br.Text=''br.PlaceholderText=aU.SearchPlaceholder or(#aW>6 and('Search '..#aW..' options')or'Search')bO()bN(true)bI(false)bV()bM=true bi.Size=UDim2.fromOffset(bL.X,0)bQ()bi.Visible=true ah(bi,{Size=UDim2.fromOffset(bL.X,bL.Y)},0.3,Enum.EasingStyle.Quint)ah(bl,{Transparency=0},0.12)ah(bj,{ImageTransparency=0.4},0.3)if not bR then bR=a2:_listen('Render',bQ)end else if a2._closePopup==by._close then a2._closePopup=nil end bU()if br:IsFocused()then br:ReleaseFocus()end bM=false ah(bi,{Size=UDim2.fromOffset(bL.X,0)},0.2,Enum.EasingStyle.Quint)ah(bj,{ImageTransparency=1},0.16)local bY=bS task.delay(0.14,function()if bS==bY and not by.Open then ah(bl,{Transparency=1},0.06)end end)task.delay(0.21,function()if bS==bY and not by.Open then bi.Visible=false if bR then bR()bR=nil end end end)end end by._close=function()bW(false)end local function bX()bI(true)aJ(aU.Callback,bF())end local function bY()local bZ={}for b_,b0 in ipairs(aW)do bZ[b0]=b_ end for b_,b0 in pairs(bA)do if not bZ[b_]then b0.Frame:Destroy()bA[b_]=nil end end for b_,b0 in ipairs(aW)do local b1=bA[b0]if b1 then b1.Frame.LayoutOrder=b_ continue end local b2=ai('TextButton',{Size=UDim2.new(1,-6,0,a3),BackgroundColor3=z.Surface3,BackgroundTransparency=1,BorderSizePixel=0,Text='',AutoButtonColor=false,LayoutOrder=b_,Parent=bw})aj(b2,UDim.new(0,7))local b3,b4,b5,b6 if aV then b3=ai('Frame',{AnchorPoint=Vector2.new(0,0.5),Position=UDim2.new(0,8,0.5,0),Size=UDim2.fromOffset(18,18),BackgroundColor3=z.Surface2,BorderSizePixel=0,Parent=b2})aj(b3,UDim.new(0,5))b4=ak(b3,z.Stroke)b6=ai('ImageLabel',{AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.fromScale(0.5,0.5),Size=UDim2.fromOffset(12,12),BackgroundTransparency=1,ImageColor3=z.AccentDark,ImageTransparency=1,ScaleType=Enum.ScaleType.Fit,Parent=b3})else b5=ai('Frame',{AnchorPoint=Vector2.new(0,0.5),Position=UDim2.new(0,3,0.5,0),Size=UDim2.fromOffset(3,4),BackgroundColor3=z.Accent,BackgroundTransparency=1,BorderSizePixel=0,Parent=b2})aj(b5,UDim.new(1,0))b6=ai('ImageLabel',{AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-10,0.5,0),Size=UDim2.fromOffset(14,14),BackgroundTransparency=1,ImageColor3=z.Accent,ImageTransparency=1,ScaleType=Enum.ScaleType.Fit,Parent=b2})end aq(b6,'check')local b7=ai('UIScale',{Parent=b6})local b8=am({Position=UDim2.fromOffset(aV and 36 or 14,0),Size=UDim2.new(1,aV and-44 or-46,1,0),Text=bE(b0),TextSize=13,TextColor3=z.Muted,RichText=true,Parent=b2})local b9={Option=b0,Frame=b2,Box=b3,BoxStroke=b4,Bar=b5,Check=b6,CheckScale=b7,Label=b8,On=nil,Hover=false}local ca=ay(b2,function()return bw end)b2.MouseEnter:Connect(function()if ax()then return end b9.Hover=true bG(b9,0.15)if b4 and not bz[b0]then ah(b4,{Color=z.StrokeHover},0.15)end end)b2.MouseLeave:Connect(function()b9.Hover=false bG(b9,0.25)if b4 and not bz[b0]then ah(b4,{Color=z.Stroke},0.25)end end)b2.MouseButton1Click:Connect(function()if not ca()then return end if bz[b0]then if not aV and aU.AllowNone==false then bW(false)return end bz[b0]=nil else if not aV then bz={}end bz[b0]=true end bX()if not aV then bW(false)end end)bA[b0]=b9 bH(b9,false)end bO()if by.Open then bN(false)end end bu.MouseButton1Click:Connect(function()for bZ,b_ in ipairs(aW)do if bC(b_)then bz[b_]=true end end bX()end)bv.MouseButton1Click:Connect(function()bz={}bX()end)function by:Set(bZ,b_)bz={}if aV then for b0,b1 in ipairs(type(bZ)=='table'and bZ or{bZ})do bz[b1]=true end elseif bZ~=nil then bz[bZ]=true end bI(by.Open)aF(aY)if not b_ then aJ(aU.Callback,bF())end end function by:Get()return bF()end local function bZ(b_,b0)if type(b_)~='table'or type(b0)~='table'then return b_==b0 end if#b_~=#b0 then return false end for b1,b2 in ipairs(b_)do if b0[b1]~=b2 then return false end end return true end function by:Refresh(b_,b0,b1)local b2=bF()aW=b_ or{}if not b0 then bz={}end bY()bI(false)if not b1 and not bZ(b2,bF())then aJ(aU.Callback,bF())end end function by:_saveValue()local b_=bF()if aV then local b0={}for b1,b2 in ipairs(b_)do b0[b2]=true end for b1 in pairs(bz)do if not b0[b1]then table.insert(b_,b1)end end return b_ end if b_==nil then b_=next(bz)end return b_ end function by:SetOpen(b_)bW(b_==true)end local b_=ay(a7,function()return aX:FindFirstAncestorWhichIsA('ScrollingFrame')end)a7.MouseButton1Click:Connect(function()if b_()then bW(not by.Open)end end)a7.MouseEnter:Connect(function()if not by.Open and not ax()then ah(bb,{Color=z.StrokeHover},0.15)ah(ba,{BackgroundColor3=z.Surface2},0.15)end end)a7.MouseLeave:Connect(function()if not by.Open then ah(bb,{Color=z.Stroke},0.25)ah(ba,{BackgroundColor3=z.Surface},0.25)end end)br:GetPropertyChangedSignal('Text'):Connect(function()bB=string.lower(br.Text)bO()if by.Open then bN(false)end end)by._listeners={function()bW(false)bU()if bR then bR()bR=nil end bi:Destroy()end}a2:_listen('Began',function(b0)if not by.Open then return end if b0.KeyCode==Enum.KeyCode.Escape then bW(false)elseif aw(b0)then local b1=av()if not az(b1,bi)and not az(b1,a7)then bW(false)end end end,by)bY()bI(false)task.defer(bh,true)return m(self,aU,by,aX,'Dropdown')end k._amountSuffixes={k=1e3,m=1e6,b=1e9,t=1e12,qa=1e15,qi=1e18}function k._parseAmount(aU)aU=string.lower(tostring(aU)):gsub('[%s,_%$]','')aU=aU:gsub('kg$',''):gsub('/s$','')local aV=tonumber(aU)if aV then return aV end local aW,aX=aU:match('^(.-)(%a+)$')local aY=aX and k._amountSuffixes[aX]aV=aW and tonumber(aW)if aV and aY then return aV*aY end return nil end function aS:Input(aU)local aV,aW,aX,aY,aZ aU,aV,aW,aX,aY,aZ=aQ(self,aU,{Title='Name',Description='Desc',PlaceholderText='Placeholder',CurrentValue='Default',Value='Default'},'Frame',160,'Input')local a_=aM(self).Compact local a0=a_ and aM(self).Chip+2 or 30 local a1=ai('Frame',{AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,a_ and-14 or-10,0.5,0),Size=UDim2.fromOffset(170,a0),BackgroundColor3=z.Surface,BorderSizePixel=0,Parent=aV})aj(a1,UDim.new(0,6))local a2=ak(a1)local a3=aU.Icon if a3 then aB(a1,a3,z.Muted,UDim2.new(0,8,0.5,0))end local a4=ai('TextBox',{Position=UDim2.fromOffset(a3 and 30 or 8,0),Size=UDim2.new(1,a3 and-38 or-16,1,0),BackgroundTransparency=1,Text=aU.Default or'',PlaceholderText=aU.Placeholder or'',PlaceholderColor3=z.Muted,TextColor3=z.Text,TextSize=a_ and 13 or 14,FontFace=D.Regular,TextXAlignment=Enum.TextXAlignment.Left,ClearTextOnFocus=false,TextTruncate=Enum.TextTruncate.None,ClipsDescendants=true,Parent=a1})a1.ClipsDescendants=true local a5=a4.Text local a6=aU.Numeric and k._parseAmount(a5)or nil if aU.Numeric and not a6 then a5=''end local a7=false local a8=(a3 and 30 or 8)+8 local function a9(ba)local bb if a_ then bb=aN(aV,self.Window)else local bc=aV.AbsoluteSize.X/self.Window.Scale.Scale local bd=math.clamp(bc-14-110-20,100,200)local be=a4.TextBounds.X if#a4.Text==0 then be=math.min(a4.TextBounds.X,90)end bb=math.clamp(be+a8+12,90,bd)+(a7 and 8 or 0)bb=math.min(bb,bd+8)end aR(aY,aZ,bb+(a_ and 24 or 20))if ba then a1.Size=UDim2.fromOffset(bb,a0)else ah(a1,{Size=UDim2.fromOffset(bb,a0)},0.18)end end local ba=0 aV:GetPropertyChangedSignal('AbsoluteSize'):Connect(function()if aV.AbsoluteSize.X~=ba then ba=aV.AbsoluteSize.X a9(true)end end)a4:GetPropertyChangedSignal('Text'):Connect(function()a9(false)end)a4:GetPropertyChangedSignal('TextBounds'):Connect(function()a9(false)end)task.defer(a9,true)a4.Focused:Connect(function()a7=true ah(a2,{Color=z.StrokeHover},0.15)a9(false)end)a4.FocusLost:Connect(function(bb)a7=false ah(a2,{Color=z.Stroke},0.15)a9(false)if aU.Numeric then local bc=k._parseAmount(a4.Text)if not bc then a4.Text=a5 return end a5,a6=a4.Text,bc aJ(aU.Callback,bc,bb)return end aJ(aU.Callback,a4.Text,bb)end)return m(self,aU,{Set=function(bb,bc)a4.Text=tostring(bc)if aU.Numeric then local bd=k._parseAmount(a4.Text)if bd then a5,a6=a4.Text,bd else a4.Text=a5 end end aF(aW)end,Get=function()if aU.Numeric then return a6 end return a4.Text end,_saveValue=aU.Numeric and function()return a5 end or nil},aV,'Input')end function aS:Keybind(aU)local aV,aW,aX,aY,aZ aU,aV,aW,aX,aY,aZ=aQ(self,aU,{Title='Name',Description='Desc',CurrentKeybind='Default',Value='Default'},'Frame',110,'Keybind')if type(aU.Default)=='string'then aU.Default=Enum.KeyCode[aU.Default]end local a_=aM(self).Compact local a0=aM(self).Chip local a1=ai('TextButton',{AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,a_ and-14 or-10,0.5,0),Size=UDim2.fromOffset(44,a0),BackgroundColor3=z.Surface,BorderSizePixel=0,Text='',AutoButtonColor=false,ClipsDescendants=true,Parent=aV})aj(a1,UDim.new(0,6))local a2=ak(a1)local a3=am({Size=UDim2.new(1,0,1,0),TextSize=13,TextColor3=z.Muted,TextXAlignment=Enum.TextXAlignment.Center,TextTruncate=Enum.TextTruncate.None,Parent=a1})local a4={Value=aU.Default,Listening=false}local function a5(a6)local a7=math.max(a3.TextBounds.X+20,E and 44 or 36)aR(aY,aZ,a7+(a_ and 24 or 20))if a6 then a1.Size=UDim2.fromOffset(a7,a0)else ah(a1,{Size=UDim2.fromOffset(a7,a0)},0.2)end end a3:GetPropertyChangedSignal('TextBounds'):Connect(function()a5(false)end)local function a6()a3.Text=a4.Listening and'...'or aI(a4.Value)ah(a2,{Color=a4.Listening and z.StrokeHover or z.Stroke},0.15)ah(a3,{TextColor3=a4.Listening and z.Accent or z.Muted},0.15)end function a4:Set(a7,a8)local a9=a4.Listening a4.Value=a7 a4.Listening=false a6()if not a9 then aF(aW)end if not a8 then aJ(aU.OnChanged,a7)end end a1.MouseButton1Click:Connect(function()a4.Listening=not a4.Listening a6()end)self.Window:_listen('Began',function(a7,a8)if a7.UserInputType~=Enum.UserInputType.Keyboard then return end if a4.Listening then self.Window._consumedKey=a7.KeyCode self.Window._consumedAt=os.clock()if a7.KeyCode==Enum.KeyCode.Escape then a4.Listening=false a6()else a4:Set(a7.KeyCode)end return end if not a8 and a4.Value~=nil and a7.KeyCode==a4.Value then aJ(aU.Callback,a7.KeyCode)end end,a4)a6()task.defer(a5,true)function a4:Get()return a4.Value end a4._onHide=function()if a4.Listening then a4.Listening=false a6()end end return m(self,aU,a4,aV,'Keybind')end function aS:ColorPicker(aU)local aV=194 local aW,aX,aY aU,aW,aX,aY=aQ(self,aU,{Title='Name',Description='Desc',Color='Default',CurrentValue='Default',Value='Default'},'Frame')aW.ClipsDescendants=true local aZ=aM(self)local a_=aZ.Compact local a0=ai('TextButton',{Size=UDim2.new(1,0,0,aY),BackgroundTransparency=1,Text='',AutoButtonColor=false,Parent=aW})aP(a0,aU.Name or'Color',aU.Desc,140,aZ)local a1=ai('Frame',{AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,a_ and-38 or-34,0.5,0),Size=UDim2.fromOffset(22,22),BorderSizePixel=0,Parent=a0})aj(a1,UDim.new(0,6))ak(a1,z.Stroke)local a2=am({AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,a_ and-68 or-64,0.5,0),Size=UDim2.fromOffset(64,16),TextSize=12,FontFace=D.Regular,TextColor3=z.Muted,TextXAlignment=Enum.TextXAlignment.Right,Parent=a0})local a3=aC(a0,1,a_ and-14 or-12)local a4=ai('Frame',{Position=UDim2.fromOffset(14,aY+2),Size=UDim2.new(1,-28,0,aV-12),BackgroundTransparency=1,Visible=false,Parent=aW})local a5=ai('TextButton',{Size=UDim2.new(1,0,0,118),BackgroundColor3=Color3.new(1,1,1),BorderSizePixel=0,Text='',AutoButtonColor=false,Parent=a4})aj(a5,UDim.new(0,8))ak(a5,z.Stroke)local a6=ai('UIGradient',{Color=ColorSequence.new(Color3.new(1,1,1),Color3.new(1,0,0)),Parent=a5})local a7=ai('Frame',{Size=UDim2.fromScale(1,1),BackgroundColor3=Color3.new(0,0,0),BorderSizePixel=0,Parent=a5})aj(a7,UDim.new(0,8))ai('UIGradient',{Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(1,0)}),Rotation=90,Parent=a7})local function a8(a9,ba)local bb=ai('Frame',{AnchorPoint=Vector2.new(0.5,0.5),Size=UDim2.fromOffset(ba,ba),BackgroundColor3=Color3.new(1,1,1),BorderSizePixel=0,ZIndex=3,Parent=a9})aj(bb,UDim.new(1,0))ak(bb,Color3.new(0,0,0),0.7)local bc=ai('Frame',{AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.fromScale(0.5,0.5),Size=UDim2.new(1,-4,1,-4),BorderSizePixel=0,ZIndex=3,Parent=bb})aj(bc,UDim.new(1,0))return bb,bc end local a9,ba=a8(a5,14)local bb=ai('TextButton',{Position=UDim2.fromOffset(0,132),Size=UDim2.new(1,0,0,10),BackgroundColor3=Color3.new(1,1,1),BorderSizePixel=0,Text='',AutoButtonColor=false,Parent=a4})aj(bb,UDim.new(1,0))ai('UIGradient',{Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(255,0,0)),ColorSequenceKeypoint.new(1/6,Color3.fromRGB(255,255,0)),ColorSequenceKeypoint.new(2/6,Color3.fromRGB(0,255,0)),ColorSequenceKeypoint.new(3/6,Color3.fromRGB(0,255,255)),ColorSequenceKeypoint.new(4/6,Color3.fromRGB(0,0,255)),ColorSequenceKeypoint.new(5/6,Color3.fromRGB(255,0,255)),ColorSequenceKeypoint.new(1,Color3.fromRGB(255,0,0))}),Parent=bb})local bc,bd=a8(bb,16)bc.Position=UDim2.fromScale(0,0.5)local be=ai('Frame',{Position=UDim2.fromOffset(0,154),Size=UDim2.fromOffset(a_ and 110 or 124,28),BackgroundColor3=z.Surface,BorderSizePixel=0,Parent=a4})aj(be,UDim.new(0,7))local bf=ak(be)local bg=ai('Frame',{AnchorPoint=Vector2.new(0,0.5),Position=UDim2.new(0,6,0.5,0),Size=UDim2.fromOffset(16,16),BorderSizePixel=0,Parent=be})aj(bg,UDim.new(0,4))ak(bg,z.Stroke)local bh=ai('TextBox',{Position=UDim2.fromOffset(30,0),Size=UDim2.new(1,-38,1,0),BackgroundTransparency=1,Text='',TextTruncate=Enum.TextTruncate.None,ClipsDescendants=false,TextColor3=z.Text,TextSize=13,FontFace=D.Regular,TextXAlignment=Enum.TextXAlignment.Left,ClearTextOnFocus=false,Parent=be})local bi=am({Position=UDim2.fromOffset(a_ and 118 or 134,154),Size=UDim2.new(1,a_ and-118 or-134,0,28),TextXAlignment=Enum.TextXAlignment.Right,TextSize=12,FontFace=D.Regular,TextColor3=z.Muted,Parent=a4})local bj={Open=false}local bk,bl,bm=Color3.toHSV(aU.Default or z.Accent)local bn=nil local function bo(bp)return string.format('#%02X%02X%02X',math.floor(bp.R*255+0.5),math.floor(bp.G*255+0.5),math.floor(bp.B*255+0.5))end local function bp(bq)local br=Color3.fromHSV(bk,bl,bm)bj.Value=br a1.BackgroundColor3=br bg.BackgroundColor3=br ba.BackgroundColor3=br bd.BackgroundColor3=Color3.fromHSV(bk,1,1)a2.Text=bo(br)a6.Color=ColorSequence.new(Color3.new(1,1,1),Color3.fromHSV(bk,1,1))ah(a9,{Position=UDim2.fromScale(bl,1-bm)},bq,Enum.EasingStyle.Quint)ah(bc,{Position=UDim2.fromScale(bk,0.5)},bq,Enum.EasingStyle.Quint)if not bh:IsFocused()then bh.Text=bo(br)end bi.Text=string.format('%d  %d  %d',math.floor(br.R*255+0.5),math.floor(br.G*255+0.5),math.floor(br.B*255+0.5))end local function bq(br,bs)bp(br)if not bs then aJ(aU.Callback,bj.Value)end end function bj:Set(br,bs)bk,bl,bm=Color3.toHSV(br)bq(0.25,bs)aF(aX)end function bj:Get()return bj.Value end local function br(bs)bj.Open=bs ah(aW,{Size=UDim2.new(1,0,0,bs and(aY+aV)or aY)},0.35,Enum.EasingStyle.Quint)a3:Set(bs)if bs then a4.Visible=true else task.delay(0.35,function()if not bj.Open then a4.Visible=false end end)end end function bj:SetOpen(bs)br(bs==true)end a0.MouseButton1Click:Connect(function()br(not bj.Open)end)local function bs(bt)bl=math.clamp((bt.X-a5.AbsolutePosition.X)/a5.AbsoluteSize.X,0,1)bm=1-math.clamp((bt.Y-a5.AbsolutePosition.Y)/a5.AbsoluteSize.Y,0,1)bq(0.04)end local function bt(bu)bk=math.clamp((bu.X-bb.AbsolutePosition.X)/bb.AbsoluteSize.X,0,0.999)bq(0.04)end a5.InputBegan:Connect(function(bu)if aw(bu)then bn='sv'ah(a9,{Size=UDim2.fromOffset(18,18)},0.2,Enum.EasingStyle.Quint)bs(av())end end)bb.InputBegan:Connect(function(bu)if aw(bu)then bn='hue'ah(bc,{Size=UDim2.fromOffset(20,20)},0.2,Enum.EasingStyle.Quint)bt(av())end end)self.Window:_listen('Changed',function(bu)if not bn or not aA(bu)then return end local bv=av()if bn=='sv'then bs(bv)else bt(bv)end end,bj)self.Window:_listen('Ended',function(bu)if bn and aw(bu)then bn=nil ah(a9,{Size=UDim2.fromOffset(14,14)},0.25,Enum.EasingStyle.Quint)ah(bc,{Size=UDim2.fromOffset(16,16)},0.25,Enum.EasingStyle.Quint)end end,bj)bh.Focused:Connect(function()ah(bf,{Color=z.StrokeHover},0.15)end)bh.FocusLost:Connect(function()ah(bf,{Color=z.Stroke},0.15)local bu,bv,bw=bh.Text:match('^%s*#?(%x%x)(%x%x)(%x%x)%s*$')if bu then bj:Set(Color3.fromRGB(tonumber(bu,16),tonumber(bv,16),tonumber(bw,16)))else bh.Text=bo(bj.Value)end end)bp(0)return m(self,aU,bj,aW,'ColorPicker')end function aS:Stepper(aU)local aV,aW,aX,aY,aZ aU,aV,aW,aX,aY,aZ=aQ(self,aU,{Title='Name',Description='Desc',CurrentValue='Default',Value='Default',Increment='Step'},'Frame',150,'Stepper')local a_=aU.Min or 0 local a0=aU.Max or 100 local a1=aU.Step or 1 local a2=aU.Suffix or''local a3=aL(a_,a0,a1)local a4=aM(self).Compact local a5=aM(self).Chip local a6=ai('Frame',{AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,a4 and-14 or-10,0.5,0),Size=UDim2.fromOffset(0,a5),AutomaticSize=Enum.AutomaticSize.X,BackgroundColor3=z.Surface,BorderSizePixel=0,Parent=aV})aj(a6,UDim.new(0,6))local a7=ak(a6)ai('UIListLayout',{FillDirection=Enum.FillDirection.Horizontal,SortOrder=Enum.SortOrder.LayoutOrder,VerticalAlignment=Enum.VerticalAlignment.Center,Parent=a6})local function a8(a9,ba)local bb=ai('TextButton',{Size=UDim2.fromOffset(a5,a5),BackgroundTransparency=1,Text=a9,TextColor3=z.Muted,TextSize=18,FontFace=D.Medium,AutoButtonColor=false,LayoutOrder=ba,Parent=a6})bb.MouseEnter:Connect(function()ah(bb,{TextColor3=z.Accent},0.12)end)bb.MouseLeave:Connect(function()ah(bb,{TextColor3=z.Muted},0.2)end)return bb end local a9=a8('\u{2212}',1)local ba=am({Size=UDim2.new(0,30,1,0),TextSize=13,TextColor3=z.Accent,TextXAlignment=Enum.TextXAlignment.Center,TextTruncate=Enum.TextTruncate.None,LayoutOrder=2,Parent=a6})local bb=a8('+',3)local function bc(bd)local be=math.max(ba.TextBounds.X+12,30)if bd then ba.Size=UDim2.new(0,be,1,0)else ah(ba,{Size=UDim2.new(0,be,1,0)},0.2)end end ba:GetPropertyChangedSignal('TextBounds'):Connect(function()bc(false)end)a6:GetPropertyChangedSignal('AbsoluteSize'):Connect(function()aR(aY,aZ,a6.AbsoluteSize.X/self.Window.Scale.Scale+(a4 and 24 or 20))end)local bd={Value=math.clamp(aU.Default or a_,a_,a0)}local be=a3.snap local bf=false local function bg()ba.Text=a3.format(bd.Value)..a2 ah(a9,{TextTransparency=bd.Value<=a_ and 0.6 or 0},0.15)ah(bb,{TextTransparency=bd.Value>=a0 and 0.6 or 0},0.15)end function bd:Set(bh,bi)bh=be(tonumber(bh)or a_)if bh==bd.Value then return end bd.Value=bh bg()if not bf then aF(aW)end if not bi then aJ(aU.Callback,bh)end end function bd:Get()return bd.Value end local function bh(bi)bf=true bd:Set(bd.Value+bi*a1)bf=false ah(a7,{Color=z.StrokeHover},0.08)task.delay(0.12,function()ah(a7,{Color=z.Stroke},0.2)end)end local function bi(bj,bk)local bl=false bj.InputBegan:Connect(function(bm)if not aw(bm)then return end bl=true bh(bk)task.delay(0.4,function()while bl do bh(bk)task.wait(0.07)end end)end)bj.InputEnded:Connect(function(bm)if aw(bm)then bl=false end end)bj.MouseLeave:Connect(function()bl=false end)end bi(a9,-1)bi(bb,1)bg()task.defer(bc,true)return m(self,aU,bd,aV,'Stepper')end function aS:Progress(aU)aU=l(aU,{Title='Name',Description='Desc',CurrentValue='Default',Value='Default'})local aV=aM(self)local aW=aV.Compact local aX=aW and 6 or 10 local aY,aZ=aO(self,'Frame',(aU.Desc and aV.DescHeight or aV.Height)+aX,aU)aG(aY,aZ)local a_ if aU.Desc then a_=math.floor((aV.DescHeight-(aV.DescGap+aV.DescLine))/2)-2 else a_=aW and 5 or 12 end am({Position=UDim2.fromOffset(14,a_),Size=UDim2.new(1,-110,0,18),Text=aU.Name or'Progress',TextSize=aV.TextSize,Parent=aY})if aU.Desc then am({Position=UDim2.fromOffset(14,a_+aV.DescGap),Size=UDim2.new(1,-110,0,aV.DescLine),Text=aU.Desc,TextSize=aV.DescSize,FontFace=D.Regular,TextColor3=z.Muted,Parent=aY})end local a0=am({AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,-14,0,a_),Size=UDim2.fromOffset(90,18),TextXAlignment=Enum.TextXAlignment.Right,TextSize=13,TextColor3=k._color(aU.TextColor)or z.Accent,RichText=true,Parent=aY})local a1=ai('Frame',{Position=UDim2.new(0,14,1,aW and-12 or-16),Size=UDim2.new(1,-28,0,5),BackgroundColor3=z.Surface3,BorderSizePixel=0,Parent=aY})aj(a1,UDim.new(1,0))local a2=ai('Frame',{Size=UDim2.new(0,0,1,0),BackgroundColor3=k._color(aU.Color)or z.Accent,BorderSizePixel=0,Parent=a1})aj(a2,UDim.new(1,0))local a3={Value=math.clamp(aU.Default or 0,0,1)}local a4=aU.Format local function a5(a6)local a7=a3.Value ah(a2,{Size=UDim2.new(a7,0,1,0)},a6,Enum.EasingStyle.Quint)if type(a4)=='function'then a0.Text=k._rich(a4(a7))else a0.Text=string.format('%d%%',math.floor(a7*100+0.5))end end function a3:Set(a6,a7)a6=math.clamp(tonumber(a6)or 0,0,1)if a6==a3.Value then return end a3.Value=a6 a5(0.35)if not a7 then aJ(aU.Callback,a6)end end function a3:Get()return a3.Value end function a3:SetColor(a6)ah(a2,{BackgroundColor3=k._color(a6)or z.Accent},0.25)end function a3:SetTextColor(a6)ah(a0,{TextColor3=k._color(a6)or z.Accent},0.25)end ag(a0,function()a5(0)end)return m(self,aU,a3,aY,'Progress')end function aS:OrderList(aU)aU=l(aU,{Title='Name',Description='Desc',Options='Items',Values='Items'})local aV=aM(self)local aW=aV.Compact local aX=self.Window local aY=E and 40 or 32 local aZ=4 local a_=aY+aZ local a0=E and 34 or 26 local a1=E and 30 or 22 local a2=math.max(math.floor(tonumber(aU.MaxRows)or 6),1)local a3=aU.Numbered~=false local a4=aU.Arrows~=false local a5=aO(self,'Frame',0,aU)a5.AutomaticSize=Enum.AutomaticSize.Y if aW then al(a5,14,14,6,8)else al(a5,14,14,11,12)end ai('UIListLayout',{SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,6),Parent=a5})local a6=tostring(aU.Name or'')am({Size=UDim2.new(1,0,0,18),Text=a6,TextSize=aV.TextSize,Visible=a6~='',LayoutOrder=1,Parent=a5})if aU.Desc then am({Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,Text=aU.Desc,TextSize=aV.DescSize,FontFace=D.Regular,TextColor3=z.Muted,TextWrapped=true,TextTruncate=Enum.TextTruncate.None,LayoutOrder=2,Parent=a5})end local a7=ai('ScrollingFrame',{Size=UDim2.new(1,0,0,aY+2),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=E and 4 or 3,ScrollBarImageColor3=z.Accent,ScrollBarImageTransparency=0.4,ScrollingDirection=Enum.ScrollingDirection.Y,CanvasSize=UDim2.new(),ScrollingEnabled=false,LayoutOrder=3,Parent=a5})a7:SetAttribute('NoDrag',true)local a8=ai('Frame',{Size=UDim2.fromScale(1,1),BackgroundTransparency=1,Parent=a7})local a9=am({Size=UDim2.new(1,0,0,aY),Text=tostring(aU.EmptyText or'Nothing to order'),TextSize=13,FontFace=D.Regular,TextColor3=z.Muted,TextXAlignment=Enum.TextXAlignment.Center,Visible=false,Parent=a8})local function ba(bb,bc,bd,be,bf)bf.BackgroundTransparency=1 bf.Text=''bf.AutoButtonColor=false bf.Parent=bb local bg=ai('TextButton',bf)local bh=ai('ImageLabel',{AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.fromScale(0.5,0.5),Size=E and UDim2.fromOffset(16,16)or UDim2.fromOffset(14,14),BackgroundTransparency=1,ImageColor3=z.Muted,ScaleType=Enum.ScaleType.Fit,Parent=bg})aq(bh,bc)if bh.Image~=''then return bg,{Object=bh,Color='ImageColor3',Fade='ImageTransparency'}end bh:Destroy()local bi=am({Size=UDim2.fromScale(1,1),Text=bd,TextSize=18,TextColor3=z.Muted,TextXAlignment=Enum.TextXAlignment.Center,TextTruncate=Enum.TextTruncate.None,Rotation=be,Parent=bg})return bg,{Object=bi,Color='TextColor3',Fade='TextTransparency'}end local function bb(bc,bd,be,bf)ah(bc.Object,{[bc.Color]=bd,[bc.Fade]=be},bf)end local bc={}local bd={}local be={}local bf=nil local bg,bh local function bi(bj)return 1+(bj-1)*a_ end local function bj()local bk={}for bl,bm in ipairs(bd)do bk[bl]=bm.Value end return bk end local function bk(bl)local bm=#bd for bn,bo in ipairs(bd)do bo.Index.Text=tostring(bn)if bo~=bf then ah(bo.Frame,{Position=UDim2.fromOffset(3,bi(bn))},bl and 0 or 0.22,Enum.EasingStyle.Quint)end if bo.UpIcon then ah(bo.UpIcon.Object,{[bo.UpIcon.Fade]=bn==1 and 0.7 or 0},bl and 0 or 0.15)ah(bo.DownIcon.Object,{[bo.DownIcon.Fade]=bn==bm and 0.7 or 0},bl and 0 or 0.15)end end end local function bl()local bm=#bd local bn=math.max(bm,1)*a_-aZ+2 local bo=math.clamp(bm,1,a2)local bp=bo*a_-aZ+2 local bq=bm>a2 a7.Size=UDim2.new(1,0,0,bp)a7.CanvasSize=UDim2.fromOffset(0,bn)a8.Size=UDim2.new(1,bq and-8 or 0,0,bn)if not bf then a7.ScrollingEnabled=bq end a9.Visible=bm==0 local br=math.max(bn-bp,0)if a7.CanvasPosition.Y>br then a7.CanvasPosition=Vector2.new(0,br)end end local function bm(bn)bc.Value=bj()if not bn then aJ(aU.Callback,bj())end end local function bn()if a7.ScrollingEnabled then return a7 end return a5:FindFirstAncestorWhichIsA('ScrollingFrame')end local function bo(bp)local bq=ai('Frame',{Size=UDim2.new(1,-6,0,aY),BackgroundColor3=z.Surface,BorderSizePixel=0,Parent=a8})aj(bq,UDim.new(0,7))local br={Value=bp,Frame=bq}br.Stroke=ak(bq)br.Scale=ai('UIScale',{Parent=bq})local bs bs,br.GripIcon=ba(bq,'grip-vertical','=',0,{Size=UDim2.new(0,a0,1,0)})local bt=a0 br.Index=am({Position=UDim2.fromOffset(bt,0),Size=UDim2.new(0,22,1,0),TextSize=12,TextColor3=z.Accent,TextTruncate=Enum.TextTruncate.None,Visible=a3,Parent=bq})if a3 then bt+=22 end local bu=a4 and a1*2+8 or 10 br.Text=am({Position=UDim2.fromOffset(bt,0),Size=UDim2.new(1,-(bt+bu),1,0),Text=tostring(bp),TextSize=13,Parent=bq})local bv={}if a4 then local bw,bx bw,br.UpIcon=ba(bq,'chevron-up','\u{203a}',-90,{AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,-(a1+6),0,0),Size=UDim2.new(0,a1,1,0)})bx,br.DownIcon=ba(bq,'chevron-down','\u{203a}',90,{AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,-4,0,0),Size=UDim2.new(0,a1,1,0)})for by,bz in pairs({[bw]=-1,[bx]=1})do local bA=bz<0 and br.UpIcon or br.DownIcon local bB=ay(by,bn)by.MouseEnter:Connect(function()if not ax()then ah(bA.Object,{[bA.Color]=z.Accent},0.12)end end)by.MouseLeave:Connect(function()ah(bA.Object,{[bA.Color]=z.Muted},0.2)end)by.MouseButton1Click:Connect(function()if bB()then bg(br,bz)end end)table.insert(bv,by)end end bs.InputBegan:Connect(function(bw)if aw(bw)then bh(br)end end)bq.InputBegan:Connect(function(bw)if bw.UserInputType~=Enum.UserInputType.MouseButton1 then return end local bx=av()for by,bz in ipairs(bv)do if az(bx,bz)then return end end bh(br)end)bq.MouseEnter:Connect(function()if not ax()and br~=bf then ah(br.Stroke,{Color=z.StrokeHover},0.12)bb(br.GripIcon,z.Text,0,0.12)end end)bq.MouseLeave:Connect(function()if br~=bf then ah(br.Stroke,{Color=z.Stroke},0.25)bb(br.GripIcon,z.Muted,0,0.25)end end)return br end local function bp(bq)local br={}for bs,bt in ipairs(bd)do br[bt.Value]=br[bt.Value]or{}table.insert(br[bt.Value],bt)end local bs={}for bt,bu in ipairs(bq)do local bv=br[bu]local bw=bv and table.remove(bv,1)if not bw then bw=bo(bu)bw.Frame.Position=UDim2.fromOffset(3,bi(bt))end bs[bt]=bw end for bt,bu in pairs(br)do for bv,bw in ipairs(bu)do bw.Frame:Destroy()end end bd=bs end local function bq(br,bs)local bt={}for bu,bv in ipairs(br)do bt[bv]=(bt[bv]or 0)+1 end local bu={}for bv,bw in ipairs({bs,br})do for bx,by in ipairs(bw)do if(bt[by]or 0)>0 then bt[by]-=1 table.insert(bu,by)end end end return bu end local function br(bs)local bt=bi(bs)-1 local bu=a7.AbsoluteWindowSize.Y/aX.Scale.Scale local bv=a7.CanvasPosition.Y if bt<bv then bv=bt elseif bt+aY+2>bv+bu then bv=bt+aY+2-bu end if bv~=a7.CanvasPosition.Y then ah(a7,{CanvasPosition=Vector2.new(0,math.max(bv,0))},0.2)end end function bg(bs,bt)if bf then return end local bu=table.find(bd,bs)local bv=bu and bu+bt if not bv or bv<1 or bv>#bd then return end bd[bu],bd[bv]=bd[bv],bd[bu]bk(false)ah(bs.Stroke,{Color=z.Accent},0.08)task.delay(0.18,function()if bs~=bf then ah(bs.Stroke,{Color=z.Stroke},0.3)end end)br(bv)bm(false)end local bs,bt=0,nil local bu,bv,bw=nil,nil,nil local function bx(by)local bz=aX.Scale.Scale local bA=(by.Y-bs-a7.AbsolutePosition.Y)/bz+a7.CanvasPosition.Y bA=math.clamp(bA,bi(1),bi(#bd))bf.Frame.Position=UDim2.fromOffset(3,bA)local bB=math.clamp(math.floor((bA-1)/a_+0.5)+1,1,#bd)local bC=table.find(bd,bf)if bC~=bB then table.remove(bd,bC)table.insert(bd,bB,bf)bk(false)end end local function by(bz)if not bf or not bt then return end local bA=aX.Scale.Scale local bB=a7.AbsolutePosition.Y local bC=bB+a7.AbsoluteSize.Y local bD=aY*bA local bE=0 if bt.Y<bB+bD then bE=-(bB+bD-bt.Y)/bD elseif bt.Y>bC-bD then bE=(bt.Y-(bC-bD))/bD end if bE==0 then return end local bF=math.max(a7.CanvasSize.Y.Offset-a7.AbsoluteWindowSize.Y/bA,0)local bG=math.clamp(a7.CanvasPosition.Y+math.clamp(bE,-1.5,1.5)*360*bz,0,bF)if bG~=a7.CanvasPosition.Y then a7.CanvasPosition=Vector2.new(0,bG)bx(bt)end end function bh(bz)if bf or#bd<2 or bc._destroyed then return end bf=bz bu=table.clone(bd)bt=av()bs=bt.Y-bz.Frame.AbsolutePosition.Y bz.Frame.ZIndex=5 ah(bz.Frame,{BackgroundColor3=z.Surface3},0.12)ah(bz.Stroke,{Color=z.Accent},0.12)ah(bz.Scale,{Scale=1.02},0.18,Enum.EasingStyle.Back)bb(bz.GripIcon,z.Accent,0,0.12)a7.ScrollingEnabled=false local bA=a5:FindFirstAncestorWhichIsA('ScrollingFrame')if bA and bA.ScrollingEnabled then bw=bA bA.ScrollingEnabled=false end bv=aX:_listen('Render',by)end local function bz(bA)local bB=bf if not bB then return end bf=nil bt=nil if bv then bv()bv=nil end if bw then bw.ScrollingEnabled=true bw=nil end ah(bB.Frame,{BackgroundColor3=z.Surface},0.2)ah(bB.Stroke,{Color=z.Stroke},0.25)ah(bB.Scale,{Scale=1},0.2)bb(bB.GripIcon,z.Muted,0,0.25)task.delay(0.22,function()if bB~=bf then bB.Frame.ZIndex=1 end end)bk(false)bl()for bC,bD in ipairs(bd)do if bu[bC]~=bD then bm(bA)break end end end aX:_listen('Changed',function(bA)if bf and aA(bA)then bt=av()bx(bt)end end,bc)aX:_listen('Ended',function(bA)if bf and aw(bA)then bz(false)end end,bc)table.insert(bc._listeners,function()bz(true)end)bc._onHide=function()bz(false)end function bc:Set(bA,bB)if type(bA)~='table'then return end bz(true)be=table.clone(bA)bp(bq(bj(),be))bk(false)bl()bm(bB)end function bc:Get()return bj()end function bc:Refresh(bA,bB,bC)bz(true)bA=type(bA)=='table'and table.clone(bA)or{}if bB~=false then bA=bq(bA,bc:_saveValue())else be={}end bp(bA)bk(false)bl()bm(bC)end function bc:_saveValue()local bA=bj()local bB={}for bC,bD in ipairs(bA)do bB[bD]=(bB[bD]or 0)+1 end for bC,bD in ipairs(be)do if(bB[bD]or 0)>0 then bB[bD]-=1 else table.insert(bA,bD)end end return bA end bp(type(aU.Items)=='table'and aU.Items or{})bk(true)bl()bc.Value=bj()return m(self,aU,bc,a5,'OrderList')end for aU,aV in pairs(table.clone(aS))do if type(aV)=='function'and aU:sub(1,1)~='_'and aU:sub(1,6)~='Create'then aS['Create'..aU]=aV end end local function aU()local aV pcall(function()if typeof(identifyexecutor)=='function'then aV=(identifyexecutor())elseif typeof(getexecutorname)=='function'then aV=getexecutorname()end end)if type(aV)=='string'and#aV>0 then return aV end return d:IsStudio()and'Studio'or'Unknown'end local function aV(aW)local aX=aU()local aY=aW.SupportedExecutors if type(aY)=='table'then local aZ=string.lower(aX)for a_,a0 in ipairs(aY)do if string.find(aZ,string.lower(tostring(a0)),1,true)then return aX,true,'Your executor is supported and fully compatible.'end end return aX,false,'Not on the supported list. Some features may not work.'end local aZ={{'writefile',writefile},{'readfile',readfile},{'getcustomasset',getcustomasset},{'setclipboard',setclipboard or toclipboard},{'request',request or http_request or(syn and syn.request)}}local a_={}for a0,a1 in ipairs(aZ)do if type(a1[2])~='function'then table.insert(a_,a1[1])end end if#a_==0 then return aX,true,'Your executor is supported and fully compatible.'end return aX,false,'Missing '..table.concat(a_,', ')..'. Some features may not work.'end local aW={}function aW.Path(aX)return tostring(aX)..'/unsupported_skip.txt'end function aW.Available()return type(writefile)=='function'and type(readfile)=='function'and type(isfile)=='function'end function aW.Saved(aX,aY)if not aW.Available()then return false end local aZ=aW.Path(aX)local a_,a0=pcall(function()return isfile(aZ)and readfile(aZ)or nil end)return a_ and a0==aY end function aW.Write(aX,aY,aZ)if not aW.Available()then return false end return pcall(function()if type(isfolder)=='function'and type(makefolder)=='function'then local a_=''for a0 in tostring(aX):gmatch('[^/\\]+')do a_=a_==''and a0 or a_..'/'..a0 if not isfolder(a_)then makefolder(a_)end end end writefile(aY,aZ)end)end function aW.Save(aX,aY)return aW.Write(aX,aW.Path(aX),aY)end function aW.DisclaimerKey(aX)if aX.Id~=nil then return(tostring(aX.Id):gsub('[\r\n]',' '))end local aY=tostring(aX.Title)..'\0'..tostring(aX.Text)local aZ=5381 for a_=1,#aY do aZ=(aZ*33+aY:byte(a_))%4294967296 end return string.format('%08x',aZ)end function aW.DisclaimerAccepted(aX,aY)if not aW.Available()then return false end local aZ=tostring(aX)..'/disclaimers.txt'local a_,a0=pcall(function()return isfile(aZ)and readfile(aZ)or''end)if not a_ or type(a0)~='string'then return false end for a1 in a0:gmatch('[^\r\n]+')do if a1==aY then return true end end return false end function aW.AcceptDisclaimer(aX,aY)if aW.DisclaimerAccepted(aX,aY)then return true end local aZ=tostring(aX)..'/disclaimers.txt'local a_,a0=pcall(function()return isfile(aZ)and readfile(aZ)or''end)a0=a_ and type(a0)=='string'and a0 or''if a0~=''and not a0:match('\n$')then a0 ..='\n'end return aW.Write(aX,aZ,a0..aY..'\n')end local aX=nil local function aY()if aX==nil then local aZ,a_=pcall(function()return h:GetProductInfo(game.PlaceId)end)aX=aZ and type(a_)=='table'and a_ or false end return aX or nil end local function aZ()local a_=aY()if a_ and a_.Name then return a_.Name end return d:IsStudio()and'Studio'or'Unknown game'end local a_={US='United States',GB='United Kingdom',DE='Germany',FR='France',NL='Netherlands',SG='Singapore',JP='Japan',AU='Australia',BR='Brazil',IN='India',HK='Hong Kong',CA='Canada'}local function a0(a1)task.spawn(function()local a2=request or http_request or(syn and syn.request)or(http and http.request)local a3 if type(a2)=='function'then pcall(function()local a4=a2({Url='https://ipinfo.io/json',Method='GET'})local a5=type(a4)=='table'and(a4.Body or a4.body)or nil if type(a5)=='string'then local a6=e:JSONDecode(a5)if type(a6)=='table'and a6.country then local a7=a_[a6.country]or a6.country a3=a6.city and(a6.city..', '..a7)or a7 end end end)end a1(a3 or'Unavailable')end)end local a1=setmetatable({},{__index=function(a1,a2)if a2=='Success'or a2=='Warning'or a2=='Error'then return z[a2]end return nil end})local a2={}a2.__index=a2 function k.Window(a3,a4)a4=l(a4,{Name='Title',LoadingSubtitle='Subtitle',ToggleUIKeybind='Keybind'})if type(a4.Keybind)=='string'then a4.Keybind=Enum.KeyCode[a4.Keybind]end local a5=a4.Size or UDim2.fromOffset(760,520)local a6=a4.Keybind or Enum.KeyCode.RightControl local a7=setmetatable({Tabs={},CurrentTab=nil,Open=true,Keybind=a6,_connections={},_controls={},_inputListeners={Began={},Changed={},Ended={},Render={}},_frameSteps={},_destroyed=false,_identity={Names={},Avatars={}},_pinned={},Minimized=false,_hideName=false,_hideAvatar=false,Title=a4.Title or'Airflow',_logoIcon=a4.Icon or A.Logo,_sessionStart=os.clock(),_islandLocked=a4.IslandDraggable==false},a2)local a8=type(a4.ConfigurationSaving)=='table'and a4.ConfigurationSaving or{}a7.ConfigFolder=a8.FolderName or'AirflowUI'a7.ConfigName=a8.FileName a7._configListeners={}a7._pendingFlags={}local a9=a4.DefaultTheme or a4.Theme if a9~=nil then k.DefaultTheme=a9 end a7:_applyDefaultTheme()a7._uiScale=math.clamp(tonumber(a4.UIScale)or 1,0.6,1.5)a7._adaptive=a4.AdaptiveSize~=false a7.UIScale=a7._uiScale if a4.Density~=nil then k:SetDensity(a4.Density)end if a4.CornerRadius~=nil then k:SetCornerRadius(a4.CornerRadius,true)end local function ba(bb)return function(...)for bc,bd in ipairs(a7._inputListeners[bb])do bd(...)end end end local bb=ba('Render')table.insert(a7._connections,d.RenderStepped:Connect(function(bc)bb(bc)for bd,be in ipairs(a7._frameSteps)do be(bc)end end))table.insert(a7._connections,b.InputBegan:Connect(ba('Began')))table.insert(a7._connections,b.InputChanged:Connect(ba('Changed')))table.insert(a7._connections,b.InputEnded:Connect(ba('Ended')))local bc=ai('ScreenGui',{Name=a4.Name or'AirflowUI',IgnoreGuiInset=true,ResetOnSpawn=false,DisplayOrder=999,ZIndexBehavior=Enum.ZIndexBehavior.Sibling})a7.Gui=bc local bd=ai('Frame',{Name='Window',AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.fromScale(0.5,0.5),Size=a5,BackgroundTransparency=1,Parent=bc})a7.Root=bd local be=ai('UIScale',{Parent=bd})a7.Scale=be local bf=ai('ImageLabel',{Position=UDim2.fromOffset(-25,-25),Size=UDim2.new(1,50,1,50),BackgroundTransparency=1,Image=A.Shadow,ImageColor3=Color3.new(0,0,0),ImageTransparency=0.6,ScaleType=Enum.ScaleType.Slice,SliceCenter=Rect.new(49,49,450,450),Parent=bd})a7.Shadow=bf a7._shadowRest=0.6 local bg=ai('CanvasGroup',{Name='Fader',Size=UDim2.fromScale(1,1),BackgroundTransparency=1,GroupTransparency=1,ZIndex=2,Parent=bd})a7._fader=bg a7._bodyAlpha=1 local bh=ai('Frame',{Name='Body',Size=UDim2.fromScale(1,1),BackgroundColor3=z.Background,BorderSizePixel=0,ClipsDescendants=true,ZIndex=2,Parent=bg})a7.Body=bh aj(bh,UDim.new(0,10))a7.BodyStroke=ak(bh,z.Stroke)ao(bh)a7._backgroundImage=ai('ImageLabel',{Name='BackgroundImage',Size=UDim2.fromScale(1,1),BackgroundTransparency=1,ScaleType=Enum.ScaleType.Crop,ImageTransparency=1,Visible=false,ZIndex=0,Parent=bh})aj(a7._backgroundImage,UDim.new(0,10))a7.BackgroundTransparency=math.clamp(tonumber(a4.BackgroundTransparency)or 0.35,0,1)a7._backgroundGeneration=0 local bi=ai('Frame',{Name='Sidebar',Size=UDim2.new(0,F,1,0),BackgroundTransparency=1,BorderSizePixel=0,ClipsDescendants=true,Parent=bh})a7.Sidebar=bi local bj=ai('Frame',{Name='Fill',Size=UDim2.new(1,24,1,0),BackgroundColor3=z.Surface,BorderSizePixel=0,ZIndex=0,Parent=bi})aj(bj,UDim.new(0,10))a7.SidebarFill=bj ai('Frame',{Name='Divider',AnchorPoint=Vector2.new(1,0),Position=UDim2.fromScale(1,0),Size=UDim2.new(0,1,1,0),BackgroundColor3=z.Stroke,BorderSizePixel=0,ZIndex=2,Parent=bi})local bk=ai('Frame',{Name='Header',Size=UDim2.new(1,0,0,G),BackgroundTransparency=1,Parent=bi})local bl=ai('ImageLabel',{AnchorPoint=Vector2.new(0,0.5),Position=UDim2.new(0,14,0.5,0),Size=UDim2.fromOffset(32,32),BackgroundTransparency=1,Image='',ImageColor3=z.Accent,ScaleType=Enum.ScaleType.Fit,Parent=bk})aq(bl,a4.Icon or A.Logo,true)local bm=a4.Version or a4.Subtitle am({Position=UDim2.new(0,56,0.5,bm and-15 or-9),Size=UDim2.new(1,-68,0,18),Text=a7.Title,TextSize=14,FontFace=D.Bold,Parent=bk})if bm then am({Position=UDim2.new(0,56,0.5,3),Size=UDim2.new(1,-68,0,14),Text=tostring(bm),TextSize=11,FontFace=D.Regular,TextColor3=z.Muted,Parent=bk})end local bn=a4.Profile~=false local bo=ai('ScrollingFrame',{Name='Tabs',Position=UDim2.fromOffset(0,G),Size=UDim2.new(1,0,1,-(G+(bn and M+4 or 12))),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=0,ScrollingDirection=Enum.ScrollingDirection.Y,AutomaticCanvasSize=Enum.AutomaticSize.Y,CanvasSize=UDim2.new(),Parent=bi})a7.TabList=bo local bp=ai('Frame',{Position=UDim2.fromOffset(8,2),Size=UDim2.new(1,-16,0,H),BackgroundColor3=z.Surface3,BackgroundTransparency=0.35,BorderSizePixel=0,Visible=false,Parent=bo})aj(bp,UDim.new(0,7))local bq=ai('Frame',{AnchorPoint=Vector2.new(0,0.5),Position=UDim2.new(0,0,0.5,0),Size=UDim2.fromOffset(2,14),BackgroundColor3=z.Accent,Visible=false,BorderSizePixel=0,Parent=bp})aj(bq,UDim.new(1,0))a7._indicatorPill=bq a7.Indicator=bp local br=ai('Frame',{Name='Stack',Position=UDim2.fromOffset(8,2),Size=UDim2.new(1,-16,0,0),AutomaticSize=Enum.AutomaticSize.Y,BackgroundTransparency=1,ZIndex=2,Parent=bo})ai('UIListLayout',{SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,2),Parent=br})a7._tabStack=br a7:_overflowHint(bi,bo,br,true,z.Surface)if bn then a7:_buildProfile(bi)end local bs=ai('Frame',{Name='Content',Position=UDim2.fromOffset(F+1,0),Size=UDim2.new(1,-(F+1),1,0),BackgroundTransparency=1,ClipsDescendants=true,Parent=bh})a7.Content=bs a7:_sidebarResize(bi,tonumber(a4.SidebarWidth)or F)a7._outLayer=ai('CanvasGroup',{Name='TransitionOut',Size=UDim2.fromScale(1,1),BackgroundTransparency=1,Visible=false,ZIndex=2,Parent=bs})a7._inLayer=ai('CanvasGroup',{Name='TransitionIn',Size=UDim2.fromScale(1,1),BackgroundTransparency=1,Visible=false,ZIndex=3,Parent=bs})local bt=ai('TextButton',{AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,-14,0,14),Size=UDim2.fromOffset(34,34),BackgroundColor3=z.Surface2,BackgroundTransparency=1,Text='',AutoButtonColor=false,ZIndex=5,Parent=bs})bt:SetAttribute('NoDrag',true)local bu=ai('ImageLabel',{AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.fromScale(0.5,0.5),Size=UDim2.fromOffset(20,20),BackgroundTransparency=1,ImageColor3=z.Muted,ScaleType=Enum.ScaleType.Fit,Parent=bt})aq(bu,'minimize-2')bt.MouseEnter:Connect(function()ah(bu,{ImageColor3=z.Text,Size=UDim2.fromOffset(18,18)},0.2,Enum.EasingStyle.Quint)end)bt.MouseLeave:Connect(function()ah(bu,{ImageColor3=z.Muted,Size=UDim2.fromOffset(20,20)},0.25,Enum.EasingStyle.Quint)end)bt.MouseButton1Click:Connect(function()a7:Minimize()end)a7.MinimizeButton=bt if a4.Search~=false then a7:_buildSearch(bs)end local bv=ai('Frame',{Name='Notifications',AnchorPoint=Vector2.new(1,1),Position=UDim2.new(1,-20,1,-20),Size=UDim2.new(0,280,1,-40),BackgroundTransparency=1,Parent=bc})local function bw()bv.Size=UDim2.new(0,math.min(280,bc.AbsoluteSize.X-40),1,-40)end table.insert(a7._connections,bc:GetPropertyChangedSignal('AbsoluteSize'):Connect(bw))ai('UIListLayout',{SortOrder=Enum.SortOrder.LayoutOrder,VerticalAlignment=Enum.VerticalAlignment.Bottom,Padding=UDim.new(0,4),Parent=bv})a7.NotifyHolder=bv a7._notifyOrder=0 a7._toasts={}a7.MaxNotifications=a4.MaxNotifications or 4 a7._controlsDirty=true table.insert(a7._connections,bh.DescendantAdded:Connect(function()a7._controlsDirty=true end))table.insert(a7._connections,bh.DescendantRemoving:Connect(function()a7._controlsDirty=true end))a7:SetDragStyle(a4.DragStyle or(a4.DragSkeleton==false and'Off'or'Outline'))a7:SetIslandStyle(a4.IslandStyle)if a4.Transparent then a7:SetTransparent(true)end if a4.Background then task.spawn(a7.SetBackground,a7,a4.Background)end a7:_enableDrag()a7.MaxSize=a4.MaxSize a7.KeepOnScreen=a4.KeepOnScreen~=false a7:_enableResize(a4.MinSize or Vector2.new(480,360))if a4.SaveSize~=false then local bx=a7 local by={_type='WindowSize',_listeners={}}function by:Get()local bz=bx:GetSize()return{Width=bz.X,Height=bz.Y}end function by:Set(bz)if type(bz)=='table'and tonumber(bz.Width)and tonumber(bz.Height)then bx:SetSize(Vector2.new(tonumber(bz.Width),tonumber(bz.Height)))end end local bz=type(a4.SaveSize)=='string'and a4.SaveSize or'__WindowSize'k.Flags[bz]=by a7:_flagCreated(bz,by)end table.insert(a7._connections,b.InputBegan:Connect(function(bx,by)if by then return end if bx.UserInputType==Enum.UserInputType.Keyboard and bx.KeyCode==a7.Keybind then task.defer(function()local bz=a7._consumedKey==bx.KeyCode and os.clock()-(a7._consumedAt or 0)<0.2 a7._consumedKey=nil if not bz and not a7._destroyed then if a7.Minimized then a7:Restore()else a7:Toggle(not a7.Open)end end end)end end))pcall(function()if typeof(syn)=='table'and typeof(syn.protect_gui)=='function'then syn.protect_gui(bc)end end)bc.Parent=a4.Parent or as()be.Scale=0.9 bf.ImageTransparency=1 a7.BodyStroke.Transparency=1 bd.Visible=false a7:_fitToScreen(true)table.insert(a7._connections,bc:GetPropertyChangedSignal('AbsoluteSize'):Connect(function()a7:_fitToScreen()a7:_clampToScreen()end))local bx=a4.ToggleButton if bx==nil or bx==true then bx={}end if type(bx)=='table'then a7:_createToggleButton(bx)end local by=a7.ToggleButton~=nil and a7:_toggleButtonAllowed()if(a4.OpenButton~=nil and a4.OpenButton~=false)or(a4.OpenButton==nil and E and not by)then a7:_createOpenButton(type(a4.OpenButton)=='table'and a4.OpenButton or{})end if a4.Backdrop~=false then a7:_buildBackdrop(type(a4.Backdrop)=='table'and a4.Backdrop or{})end a7._introDone=false table.insert(k.Windows,a7)if a4.Home~=false then a7:_buildHome(type(a4.Home)=='table'and a4.Home or{})end local bz=a4.Loading if type(bz)=='table'then a4.LoadingDuration=bz.Duration or a4.LoadingDuration a4.LoadingText=bz.Text or bz.Subtitle or a4.LoadingText a4.LoadingSteps=bz.Steps or a4.LoadingSteps a4.LoadingTitle=bz.Title or a4.LoadingTitle bz=bz.Enabled~=false end local bA={}local bB=a4.UnsupportedExecutor if bB~=false then bB=type(bB)=='table'and bB or{}local bC=a4.SupportedExecutors or(type(a4.Home)=='table'and a4.Home.SupportedExecutors or nil)local bD,bE,bF=aV({SupportedExecutors=bC})if not bE and not aW.Saved(a7.ConfigFolder,bD)then local bG=bB.Block==true local bH=a7.ConfigFolder table.insert(bA,{Title=bB.Title or'Unsupported executor',Subtitle=bD,Text=bG and((bB.Text or bF).." This script can't run here.")or(bB.Text or bF),Icon='shield-alert',Color=z.Warning,ContinueText='Continue anyway',ExitText='Exit',Block=bG,RememberText="Don't ask again on this executor",Remember=function()aW.Save(bH,bD)end})end end local bC=a4.Disclaimer or a4.Disclaimers if type(bC)=='string'or(type(bC)=='table'and(bC.Title~=nil or bC.Text~=nil))then bC={bC}end if type(bC)=='table'then for bD,bE in ipairs(bC)do if type(bE)=='string'then bE={Text=bE}end if type(bE)=='table'then local bF=aW.DisclaimerKey(bE)local bG=a7.ConfigFolder local bH=bE.Block==true local bI=bE.Remember~=false and not bH if not(bI and aW.DisclaimerAccepted(bG,bF))then local bJ=bE.Callback table.insert(bA,{Title=bE.Title or'Disclaimer',Subtitle=bE.Subtitle,Text=bE.Text or'',Icon=bE.Icon or'info',Color=bE.Color or z.Accent,ContinueText=bE.AcceptText or'I understand',ExitText=bE.DeclineText==nil and'Exit'or bE.DeclineText,RememberText=bI and(bE.RememberText or"Don't show again")or nil,Remember=function()aW.AcceptDisclaimer(bG,bF)end,Callback=type(bJ)=='function'and bJ or nil,Block=bH})end end end end if#bA>0 then a4._prompts=bA end if bz==false and a4._prompts then a4.LoadingDuration=a4.LoadingDuration or 0.5 bz=true end if bz==false then task.defer(function()a7:_playIntro()end)else a7:_showLoader(a4)end return a7 end k.CreateWindow=k.Window function k:Notify(a3)local a4=k.Windows[#k.Windows]if a4 then return a4:Notify(a3)end end function k:Confirm(a3)local a4=k.Windows[#k.Windows]if a4 then return a4:Confirm(a3)end end function k:Dialog(a3)local a4=k.Windows[#k.Windows]if a4 then return a4:Dialog(a3)end end local function a3(a4,a5,a6)local a7=a4 while a7 and a7~=a5 and a7:IsA('GuiObject')do if not a7.Visible then return false end local a8=a7.Parent if a8 and a8~=a5 and a8:IsA('GuiObject')and(a8.ClipsDescendants or a8:IsA('ScrollingFrame'))and not az(a6,a8)then return false end a7=a8 end return true end function a2:_refreshControls()local a4={}for a5,a6 in ipairs(self.Body:GetDescendants())do if a6:IsA('GuiButton')or a6:IsA('TextBox')or a6:GetAttribute('NoDrag')then table.insert(a4,a6)end end self._controls=a4 self._controlsDirty=false end function a2:_overControl(a4)if self._dialog or self:_overPopout(a4)then return true end if self._controlsDirty then self:_refreshControls()end for a5,a6 in ipairs(self._controls)do if a6.Parent and az(a4,a6)and a3(a6,self.Body,a4)then return true end end return false end function a2:_tooltipCard()if self._tip then return self._tip end local a4=ai('CanvasGroup',{Name='Tooltip',Size=UDim2.fromOffset(0,0),BackgroundTransparency=1,GroupTransparency=1,Visible=false,ZIndex=60,Parent=self.Gui})local a5=ai('UIScale',{Parent=a4})local a6=4 local a7=ai('Frame',{Position=UDim2.fromOffset(a6,a6),Size=UDim2.fromOffset(0,0),AutomaticSize=Enum.AutomaticSize.XY,BackgroundTransparency=1,Parent=a4})ai('UIListLayout',{SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,2),Parent=a7})local function a8(a9)ai('UIStroke',{Color=Color3.new(0,0,0),Transparency=0.35,Thickness=1,ApplyStrokeMode=Enum.ApplyStrokeMode.Contextual,Parent=a9})end local a9=ai('Frame',{Size=UDim2.fromOffset(0,18),AutomaticSize=Enum.AutomaticSize.X,BackgroundTransparency=1,LayoutOrder=1,Parent=a7})ai('UIListLayout',{FillDirection=Enum.FillDirection.Horizontal,VerticalAlignment=Enum.VerticalAlignment.Center,SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,6),Parent=a9})local ba=ai('ImageLabel',{Size=UDim2.fromOffset(14,14),BackgroundTransparency=1,ImageColor3=z.Accent,ScaleType=Enum.ScaleType.Fit,LayoutOrder=1,Parent=a9})local bb=am({Size=UDim2.fromOffset(0,18),AutomaticSize=Enum.AutomaticSize.X,TextSize=13,FontFace=D.Bold,TextTruncate=Enum.TextTruncate.None,LayoutOrder=2,Parent=a9})a8(bb)local bc=am({Size=UDim2.fromOffset(0,0),AutomaticSize=Enum.AutomaticSize.XY,TextSize=12,FontFace=D.Medium,TextWrapped=true,TextTruncate=Enum.TextTruncate.None,TextYAlignment=Enum.TextYAlignment.Top,LineHeight=1.1,LayoutOrder=2,Parent=a7})a8(bc)ai('UISizeConstraint',{MaxSize=Vector2.new(240,math.huge),Parent=bc})local function bd()local be=math.max(a5.Scale,0.01)local bf=a7.AbsoluteSize/be a4.Size=UDim2.fromOffset(bf.X+a6*2,bf.Y+a6*2)end a7:GetPropertyChangedSignal('AbsoluteSize'):Connect(bd)local be={Holder=a4,Scale=a5,Pad=a6,Head=a9,Icon=ba,Title=bb,Body=bc,Shown=false,Fit=bd}self._tip=be self:_listen('Render',function(bf)local bg=self._tipOwner if not bg then return end local bh=bg._frame if bg._destroyed or not self.Open or self.Minimized or not bh or not bh.Parent or(bg._isShown and not bg:_isShown())or not a3(bh,self.Body,bh.AbsolutePosition+bh.AbsoluteSize/2)then self:_hideTooltip()return end local bi=av()-self.Gui.AbsolutePosition local bj=be.Pad*a5.Scale local bk=a4.AbsoluteSize-Vector2.one*bj*2 local bl=self.Gui.AbsoluteSize local bm,bn if be.Touch then bm,bn=bi.X-bk.X/2,bi.Y-bk.Y-30 else bm,bn=bi.X+14,bi.Y+20 if bm+bk.X>bl.X-8 then bm=bi.X-bk.X-10 end if bn+bk.Y>bl.Y-8 then bn=bi.Y-bk.Y-12 end end local bo=Vector2.new(math.clamp(bm,8,math.max(8,bl.X-bk.X-8)),math.clamp(bn,8,math.max(8,bl.Y-bk.Y-8)))local bp=be.Position if not bp or be.Snap then bp=bo+Vector2.new(0,6)be.Snap=false else bp=bp:Lerp(bo,math.min(bf*22,1))end be.Position=bp a4.Position=UDim2.fromOffset(math.floor(bp.X-bj+0.5),math.floor(bp.Y-bj+0.5))end)self:_listen('Began',function(bf)if self._tipOwner and not be.Touch and(bf.UserInputType==Enum.UserInputType.MouseButton1 or bf.UserInputType==Enum.UserInputType.MouseButton2 or bf.UserInputType==Enum.UserInputType.Keyboard)then self:_hideTooltip()end end)return be end function a2:_showTooltip(a4,a5)local a6=a4._tooltip local a7,a8,a9 if type(a6)=='table'then a7,a8,a9=a6.Text or a6.Content or a6.Desc,a6.Title or a6.Name,a6.Icon elseif a6~=nil and a6~=false then a7=tostring(a6)end if(a7==nil or a7=='')and(a8==nil or a8=='')then return end local ba=self:_tooltipCard()ba.Title.Text=a8 or''ba.Title.Visible=a8~=nil and a8~=''ba.Icon.Visible=a9~=nil if a9~=nil then aq(ba.Icon,a9)end ba.Head.Visible=ba.Title.Visible or a9~=nil ba.Body.Text=a7 or''ba.Body.Visible=a7~=nil and a7~=''ba.Fit()ba.Body.TextColor3=z.Text ba.Scale.Scale=math.max(self.Scale.Scale,0.75)ba.Touch=a5==true local bb=ba.Shown self._tipOwner=a4 ba.Shown=true ba.Generation=(ba.Generation or 0)+1 local bc=ba.Holder if not bb then ba.Snap=true bc.Visible=true bc.GroupTransparency=1 ba.Scale.Scale=ba.Scale.Scale*0.96 end ah(bc,{GroupTransparency=0},0.14,Enum.EasingStyle.Quad)ah(ba.Scale,{Scale=math.max(self.Scale.Scale,0.75)},0.18,Enum.EasingStyle.Back)end function a2:_hideTooltip(a4)local a5=self._tip if not a5 or not a5.Shown or(a4 and self._tipOwner~=a4)then return end self._tipOwner=nil self._tipHiddenAt=os.clock()a5.Shown=false a5.Generation=(a5.Generation or 0)+1 local a6=a5.Generation ah(a5.Holder,{GroupTransparency=1},0.1,Enum.EasingStyle.Quad)task.delay(0.1,function()if a5.Generation==a6 then a5.Holder.Visible=false end end)end function a2:_attachTooltip(a4,a5)local a6,a7,a8=false,0,nil local function a9(ba,bb)a7+=1 local bc=a7 task.delay(ba,function()if a7~=bc or not a6 or a4._destroyed or self._destroyed then return end if bb and a8 and(av()-a8).Magnitude>10 then return end self:_showTooltip(a4,bb)end)end table.insert(a4._listeners,(function()local ba={a5.MouseEnter:Connect(function()if ax()then return end a6=true local ba=os.clock()-(self._tipHiddenAt or 0)<0.35 or self._tipOwner~=nil a9(ba and 0 or 0.45,false)end),a5.MouseLeave:Connect(function()a6=false a7+=1 self:_hideTooltip(a4)end),a5.InputBegan:Connect(function(ba)if ba.UserInputType==Enum.UserInputType.Touch then a6=true a8=av()a9(0.5,true)end end),a5.InputEnded:Connect(function(ba)if ba.UserInputType==Enum.UserInputType.Touch then a6=false a7+=1 self:_hideTooltip(a4)end end)}return function()for bb,bc in ipairs(ba)do bc:Disconnect()end end end)())end k.DragStyles={'Outline','Brackets','Ghost','Frame','Off'}local function a4(a5)local a6=a5.Root local a7=a5.DragStyle or'Outline'local a8=ai('Frame',{AnchorPoint=a6.AnchorPoint,Position=a6.Position,Size=UDim2.fromOffset(a6.AbsoluteSize.X,a6.AbsoluteSize.Y),BackgroundColor3=a7=='Ghost'and z.Background or z.Accent,BackgroundTransparency=1,BorderSizePixel=0,ZIndex=40,Parent=a5.Gui})aj(a8,UDim.new(0,10))local a9={}local function ba(bb,bc)local bd={}for be in pairs(bc)do bd[be]=1 end table.insert(a9,{Object=bb,Shown=bc,Hidden=bd})end local function bb(bc,bd)for be,bf in ipairs({Vector2.new(0,0),Vector2.new(1,0),Vector2.new(0,1),Vector2.new(1,1)})do local bg=UDim2.new(bf.X,bf.X==0 and bd or-bd,bf.Y,bf.Y==0 and bd or-bd)for bh,bi in ipairs({UDim2.fromOffset(bc,2),UDim2.fromOffset(2,bc)})do local bj=ai('Frame',{AnchorPoint=bf,Position=bg,Size=bi,BackgroundColor3=z.Accent,BackgroundTransparency=1,BorderSizePixel=0,Parent=a8})aj(bj,UDim.new(1,0))ba(bj,{BackgroundTransparency=0})end end end if a7=='Brackets'then bb(22,0)elseif a7=='Ghost'then ba(a8,{BackgroundTransparency=0.35})ba(ak(a8,z.Stroke,1,1),{Transparency=0})elseif a7=='Frame'then ba(ak(a8,z.StrokeHover,1,1),{Transparency=0})else ba(a8,{BackgroundTransparency=0.92})ba(ak(a8,z.Accent,1,1.5),{Transparency=0.2})bb(16,6)end local bc=ai('UIScale',{Scale=1.02,Parent=a8})for bd,be in ipairs(a9)do ah(be.Object,be.Shown,0.15,Enum.EasingStyle.Quad)end ah(bc,{Scale=1},0.25,Enum.EasingStyle.Quint)local function bd()for be,bf in ipairs(a9)do ah(bf.Object,bf.Hidden,0.2,Enum.EasingStyle.Quad)end task.delay(0.22,function()a8:Destroy()end)end return a8,bd end function a2:_enableDrag()local a5,a6=false,false local a7,a8=Vector2.zero,Vector2.zero local a9=nil local ba,bb=nil,nil local function bc()local bd=self.Root return bd.AbsolutePosition+bd.AbsoluteSize*bd.AnchorPoint-self.Gui.AbsolutePosition end local function bd()if not ba then return end local be=Vector2.new(ba.Position.X.Offset,ba.Position.Y.Offset)if self.KeepOnScreen then be=self:_clampedCentre(be)end if self._clampTween then self._clampTween:Cancel()end self._clampTween=ah(self.Root,{Position=UDim2.fromOffset(be.X,be.Y)},0.3,Enum.EasingStyle.Quint)bb()ba,bb=nil,nil end table.insert(self._connections,b.InputBegan:Connect(function(be)if not aw(be)then return end if not self.Open or not self.Root.Visible then return end local bf=av()if self._resizeActive or(self._grip and az(bf,self._grip))then return end if not az(bf,self.Body)or self:_overControl(bf)then return end if self._clampTween then self._clampTween:Cancel()self._clampTween=nil end a5,a6=true,false a8=bf a7=bf-bc()end))table.insert(self._connections,b.InputEnded:Connect(function(be)if not a5 then return end if aw(be)then a5=false a9=nil if ba then bd()else self:_clampToScreen()end end end))table.insert(self._frameSteps,function(be)if not a5 then return end local bf=av()if not a6 and(bf-a8).Magnitude>3 then a6=true if self.DragSkeleton then ba,bb=a4(self)end end if not a6 then return end if ba and(not self.Open or not self.Root.Visible)then a5=false bd()return end a9=bf-a7 local bg=1-math.exp(-be*45)if ba then local bh=Vector2.new(ba.Position.X.Offset,ba.Position.Y.Offset)local bi=bh:Lerp(a9,bg)ba.Position=UDim2.fromOffset(bi.X,bi.Y)else local bh=bc():Lerp(a9,bg)self.Root.Position=UDim2.fromOffset(bh.X,bh.Y)end end)end function a2:SetDragStyle(a5)a5=table.find(k.DragStyles,a5)and a5 or'Outline'self.DragStyle=a5 self.DragSkeleton=a5~='Off'return a5 end function a2:GetDragStyle()return self.DragStyle end k.IslandStyles={'Show on Hover','Always Show'}function a2:SetIslandStyle(a5)a5=table.find(k.IslandStyles,a5)and a5 or'Show on Hover'self.IslandStyle=a5 if self._islandSettle then self._islandSettle()end return a5 end function a2:GetIslandStyle()return self.IslandStyle end function a2:SetDragSkeleton(a5)if a5==false then self:SetDragStyle('Off')elseif self.DragStyle=='Off'or not self.DragStyle then self:SetDragStyle('Outline')end end function a2:_sidebarResize(a5,a6)local a7=a5:FindFirstChild('Divider')local a8=a6 local function a9(ba,bb)if bb~=false then a8=ba end local bc=self.Body.AbsoluteSize.X/self.Scale.Scale-300 ba=math.floor(math.clamp(ba,150,math.max(math.min(300,bc),150)))self.SidebarWidth=ba a5.Size=UDim2.new(0,ba,1,0)self.Content.Position=UDim2.fromOffset(ba+1,0)self.Content.Size=UDim2.new(1,-(ba+1),1,0)end self.SetSidebarWidth=function(ba,bb)a9(tonumber(bb)or F)end a9(a6)local ba=ai('TextButton',{AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,0,0,0),Size=UDim2.new(0,6,1,0),BackgroundTransparency=1,Text='',AutoButtonColor=false,ZIndex=6,Parent=a5})ba:SetAttribute('NoDrag',true)local bb,bc,bd=false,0,a6 local function be(bf)if a7 then ah(a7,{BackgroundColor3=bf and z.Accent or z.Stroke},0.15)end end ba.MouseEnter:Connect(function()be(true)end)ba.MouseLeave:Connect(function()if not bb then be(false)end end)ba.InputBegan:Connect(function(bf)if bf.UserInputType==Enum.UserInputType.MouseButton1 or bf.UserInputType==Enum.UserInputType.Touch then bb,bc,bd=true,bf.Position.X,self.SidebarWidth a8=bd be(true)end end)self:_listen('Changed',function(bf)if bb and aA(bf)then a9(bd+(bf.Position.X-bc)/self.Scale.Scale)end end)self:_listen('Ended',function(bf)if bb and(bf.UserInputType==Enum.UserInputType.MouseButton1 or bf.UserInputType==Enum.UserInputType.Touch)then bb=false be(false)end end)self.Body:GetPropertyChangedSignal('AbsoluteSize'):Connect(function()if not bb then a9(a8,false)end end)end function a2:SetTransparent(a5)self.Transparent=a5==true local a6=self.Transparent self._shadowRest=a6 and 0.85 or 0.6 ah(self.Body,{BackgroundTransparency=a6 and 0.35 or 0},0.25)local a7=a6 and 0.5 or(self.Background and 0.45 or 0)ah(self.SidebarFill,{BackgroundTransparency=a7},0.25)if self.Open and not self.Minimized and self.Root.Visible then ah(self.Shadow,{ImageTransparency=self._shadowRest},0.25)end end local function a5(a6)local a7={}for a8,a9 in ipairs(a6:GetChildren())do if a9:IsA('GuiObject')then table.insert(a7,a9)end end table.sort(a7,function(a8,a9)return a8.LayoutOrder<a9.LayoutOrder end)return a7 end local function a6(a7,a8,a9)if not a7.Visible and not a9 then return end a7.Visible=false task.delay(a8,function()if not a7.Parent then return end local ba=ai('UIScale',{Scale=0.94,Parent=a7})a7.Visible=true ah(ba,{Scale=1},0.4,Enum.EasingStyle.Back)task.delay(0.4,function()ba:Destroy()end)end)end function a2:_revealCards(a7,a8)local a9=a7.CurrentSubTab or a7 if a9._revealed then return end a9._revealed=true local ba=0 local function bb(bc)a6(bc,(a8 or 0)+ba*0.035)ba+=1 end local bc=a9._columnSet for bd,be in ipairs(a5(a9.List))do if bc and be==bc.Holder then local bf,bg=a5(bc.Left),a5(bc.Right)for bh=1,math.max(#bf,#bg)do if bf[bh]then bb(bf[bh])end if bg[bh]then bb(bg[bh])end end else bb(be)end end end function a2:_playIntro(a7)if self._introDone or self._destroyed then return end self._introDone=true self:_refreshBackdrop(true)task.delay(0.4,function()self:_refreshToggleButton()end)task.delay(1.5,function()if not self._destroyed and not self.MiniBar then self:_buildMiniBar()end end)local a8,a9,ba=self.Root,self.Shadow,self.Scale if self.CurrentTab then self:_revealCards(self.CurrentTab,a7 and 0.15 or 0.25)end a8.Visible=true if a7 then ba.Scale=self._fitScale or 1 a8.Position=UDim2.fromScale(0.5,0.5)self:_fade(0,0.3)ah(self.BodyStroke,{Transparency=0},0.3)ah(a9,{ImageTransparency=0.6},0.3)else a8.Position=UDim2.new(0.5,0,0.5,24)ah(ba,{Scale=self._fitScale or 1},0.5,Enum.EasingStyle.Back)ah(a8,{Position=UDim2.fromScale(0.5,0.5)},0.5,Enum.EasingStyle.Quint)self:_fade(0,0.35)ah(self.BodyStroke,{Transparency=0},0.35)end if not a7 then ah(a9,{ImageTransparency=0.6},0.5)end for bb,bc in ipairs(self.Tabs)do a6(bc._button,0.1+bb*0.05,true)end self.Indicator.Visible=false task.delay(0.15+#self.Tabs*0.05,function()if self.CurrentTab then self:_placeIndicator(self.CurrentTab)end end)end function a2:_showLoader(a7)local a8=a7.LoadingDuration or 1.6 local a9=self.Gui local ba=a7.LoadingSteps or{'Preparing interface','Loading icons','Almost there'}local bb,bc,bd=340,22,24 local be=80 local bf=be+#ba*bd+18 local bg=ai('CanvasGroup',{AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.new(0.5,0,0.5,10),Size=UDim2.fromOffset(bb,bf),BackgroundColor3=z.Background,BorderSizePixel=0,GroupTransparency=1,ZIndex=10,Parent=a9})local bh=aj(bg,UDim.new(0,12))local bi=ak(bg,z.Stroke,1)local bj=ai('UIScale',{Scale=0.97,Parent=bg})local bk=ai('ImageLabel',{Position=UDim2.fromOffset(-25,-25),Size=UDim2.new(1,50,1,50),BackgroundTransparency=1,Image=A.Shadow,ImageColor3=Color3.new(0,0,0),ImageTransparency=1,ScaleType=Enum.ScaleType.Slice,SliceCenter=Rect.new(49,49,450,450),ZIndex=0,Parent=bg})local bl=ai('CanvasGroup',{Size=UDim2.fromScale(1,1),BackgroundTransparency=1,Parent=bg})local bm=ai('ImageLabel',{Position=UDim2.fromOffset(bc,bc),Size=UDim2.fromOffset(30,30),BackgroundTransparency=1,ImageColor3=z.Accent,ScaleType=Enum.ScaleType.Fit,Parent=bl})aq(bm,a7.Icon or A.Logo,true)local bn=bc+42 local bo=am({Position=UDim2.fromOffset(bn,bc-2),Size=UDim2.new(1,-(bn+70),0,18),Text=a7.LoadingTitle or a7.Title or'Airflow',TextSize=15,FontFace=D.Bold,Parent=bl})local bp=am({Position=UDim2.fromOffset(bn,bc+17),Size=UDim2.new(1,-(bn+70),0,15),Text=a7.LoadingText or a7.Subtitle or'Loading',TextSize=12,FontFace=D.Regular,TextColor3=z.Muted,Parent=bl})local bq=am({AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,-bc,0,bc+6),Size=UDim2.fromOffset(56,16),Text='0%',TextSize=13,FontFace=D.Medium,TextColor3=z.Muted,TextXAlignment=Enum.TextXAlignment.Right,Parent=bl})ai('Frame',{Position=UDim2.fromOffset(bc,be-14),Size=UDim2.new(1,-bc*2,0,1),BackgroundColor3=z.Stroke,BorderSizePixel=0,Parent=bl})local br={}for bs,bt in ipairs(ba)do local bu=ai('Frame',{Position=UDim2.fromOffset(bc,be+(bs-1)*bd),Size=UDim2.new(1,-bc*2,0,bd),BackgroundTransparency=1,Parent=bl})local bv=ai('Frame',{AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.new(0,7,0.5,0),Size=UDim2.fromOffset(6,6),BackgroundColor3=z.Surface3,BorderSizePixel=0,Parent=bu})aj(bv,UDim.new(1,0))local bw=ai('Frame',{AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.new(0,7,0.5,0),Size=UDim2.fromOffset(12,12),BackgroundTransparency=1,Visible=false,Parent=bu})aj(bw,UDim.new(1,0))local bx=ai('UIStroke',{Color=z.Accent,Thickness=2,Parent=bw})ai('UIGradient',{Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0),NumberSequenceKeypoint.new(0.5,0),NumberSequenceKeypoint.new(0.501,1),NumberSequenceKeypoint.new(1,1)}),Parent=bx})local by=ai('ImageLabel',{AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.new(0,7,0.5,0),Size=UDim2.fromOffset(14,14),BackgroundTransparency=1,ImageColor3=z.Accent,ImageTransparency=1,ScaleType=Enum.ScaleType.Fit,Parent=bu})aq(by,'check')local bz=am({Position=UDim2.fromOffset(24,0),Size=UDim2.new(1,-24,1,0),Text=tostring(bt),TextSize=13,FontFace=D.Regular,TextColor3=z.Muted,TextTransparency=1,Parent=bu})br[bs]={Dot=bv,Spinner=bw,Check=by,Label=bz,State='pending'}task.delay(0.15+bs*0.06,function()if bg.Parent and br[bs].State=='pending'then ah(bz,{TextTransparency=0.45},0.3)end end)end local function bs(bt,bu)local bv=br[bt]if not bv or bv.State==bu then return end bv.State=bu bv.Dot.Visible=bu=='pending'bv.Spinner.Visible=bu=='active'ah(bv.Check,{ImageTransparency=bu=='done'and 0 or 1},0.2)ah(bv.Label,{TextTransparency=bu=='pending'and 0.45 or 0,TextColor3=bu=='active'and z.Text or z.Muted},0.2)end local bt=ai('Frame',{AnchorPoint=Vector2.new(0,1),Position=UDim2.fromScale(0,1),Size=UDim2.new(1,0,0,2),BackgroundColor3=z.Surface3,BorderSizePixel=0,Parent=bl})local bu=ai('Frame',{Size=UDim2.fromScale(0,1),BackgroundColor3=z.Accent,BorderSizePixel=0,Parent=bt})ah(bg,{GroupTransparency=0,Position=UDim2.fromScale(0.5,0.5)},0.45,Enum.EasingStyle.Quint)ah(bj,{Scale=1},0.45,Enum.EasingStyle.Quint)ah(bk,{ImageTransparency=0.55},0.4)ah(bu,{Size=UDim2.fromScale(0.85,1)},a8*0.8,Enum.EasingStyle.Quart)local bv bv=d.RenderStepped:Connect(function(bw)if not bg.Parent then bv:Disconnect()return end bq.Text=math.floor(bu.Size.X.Scale*100+0.5)..'%'for bx,by in ipairs(br)do if by.State=='active'then by.Spinner.Rotation=(by.Spinner.Rotation+bw*360)%360 end end end)task.spawn(s)for bw in ipairs(ba)do task.delay(a8*(bw-1)/#ba,function()if not bg.Parent then return end if bw>1 then bs(bw-1,'done')end bs(bw,'active')end)end local function bw()for bx in ipairs(br)do bs(bx,'done')end end local function bx()bw()ah(bl,{GroupTransparency=1},0.18)local by=self._fitScale or 1 local bz=self.Root.Size ah(bg,{Size=UDim2.fromOffset(bz.X.Offset*by,bz.Y.Offset*by),Position=UDim2.fromScale(0.5,0.5)},0.5,Enum.EasingStyle.Quint)ah(bh,{CornerRadius=UDim.new(0,k._radius(10))},0.5,Enum.EasingStyle.Quint)ah(bj,{Scale=1},0.5,Enum.EasingStyle.Quint)task.delay(0.28,function()self:_playIntro(true)ah(bg,{GroupTransparency=1},0.25)ah(bi,{Transparency=1},0.2)ah(bk,{ImageTransparency=1},0.2)end)task.delay(0.6,function()bg:Destroy()end)end local function by()bw()ah(bl,{GroupTransparency=1},0.18)end local function bz(bA,bB)local bC,bD,bE=360,24,220 local bF=bA.Color or z.Accent local bG=ai('CanvasGroup',{AnchorPoint=Vector2.new(0.5,0),Position=UDim2.fromScale(0.5,0),Size=UDim2.new(0,bC,1,0),BackgroundTransparency=1,GroupTransparency=1,ZIndex=5,Parent=bg})local bH=ai('Frame',{Position=UDim2.fromOffset(bD,bD),Size=UDim2.fromOffset(44,44),BackgroundColor3=bF,BackgroundTransparency=0.86,BorderSizePixel=0,Parent=bG})aj(bH,UDim.new(0,12))ak(bH,bF,1).Transparency=0.6 local bI=ai('ImageLabel',{AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.fromScale(0.5,0.5),Size=UDim2.fromOffset(22,22),BackgroundTransparency=1,ImageColor3=bF,ScaleType=Enum.ScaleType.Fit,Parent=bH})aq(bI,bA.Icon or'info')am({Position=UDim2.fromOffset(bD+58,bA.Subtitle and bD+3 or bD+12),Size=UDim2.new(1,-(bD*2+58),0,20),Text=bA.Title,TextSize=17,Parent=bG})if bA.Subtitle then am({Position=UDim2.fromOffset(bD+58,bD+25),Size=UDim2.new(1,-(bD*2+58),0,16),Text=tostring(bA.Subtitle),TextSize=13,TextColor3=bF,Parent=bG})end local bJ=ai('ScrollingFrame',{Position=UDim2.fromOffset(bD,bD+60),Size=UDim2.new(1,-bD*2,0,16),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=E and 4 or 3,ScrollBarImageColor3=z.Accent,ScrollBarImageTransparency=0.4,ScrollingDirection=Enum.ScrollingDirection.Y,CanvasSize=UDim2.new(),Parent=bG})local bK=am({Size=UDim2.new(1,-8,0,0),Text=tostring(bA.Text),TextSize=13,FontFace=D.Regular,TextColor3=z.Muted,TextWrapped=true,TextTruncate=Enum.TextTruncate.None,TextYAlignment=Enum.TextYAlignment.Top,Parent=bJ})local bL=ai('Frame',{AnchorPoint=Vector2.new(0,1),Position=UDim2.new(0,bD,1,-bD+4),Size=UDim2.new(1,-bD*2,0,34),BackgroundTransparency=1,Parent=bG})ai('UIListLayout',{FillDirection=Enum.FillDirection.Horizontal,HorizontalAlignment=Enum.HorizontalAlignment.Right,SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,8),Parent=bL})local bM=false local bN=nil if not bA.Block and bA.RememberText and aW.Available()then local bO=E and 20 or 16 bN=ai('TextButton',{AnchorPoint=Vector2.new(0,1),Position=UDim2.new(0,bD,1,-bD+4-34-12),Size=UDim2.new(1,-bD*2,0,E and 28 or 22),BackgroundTransparency=1,Text='',AutoButtonColor=false,Parent=bG})local bP=ai('Frame',{AnchorPoint=Vector2.new(0,0.5),Position=UDim2.fromScale(0,0.5),Size=UDim2.fromOffset(bO,bO),BackgroundColor3=z.Surface2,BorderSizePixel=0,Parent=bN})aj(bP,UDim.new(0,4))local bQ=ak(bP,z.Stroke,1)local bR=ai('ImageLabel',{AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.fromScale(0.5,0.5),Size=UDim2.fromOffset(bO-4,bO-4),BackgroundTransparency=1,ImageColor3=z.AccentDark,ImageTransparency=1,ScaleType=Enum.ScaleType.Fit,Parent=bP})aq(bR,'check')local bS=am({Position=UDim2.fromOffset(bO+8,0),Size=UDim2.new(1,-(bO+8),1,0),Text=bA.RememberText,TextSize=12,FontFace=D.Regular,TextColor3=z.Muted,Parent=bN})bN.MouseEnter:Connect(function()ah(bQ,{Color=bM and z.Accent or z.StrokeHover},0.12)ah(bS,{TextColor3=z.Text},0.12)end)bN.MouseLeave:Connect(function()ah(bQ,{Color=bM and z.Accent or z.Stroke},0.2)ah(bS,{TextColor3=bM and z.Text or z.Muted},0.2)end)bN.MouseButton1Click:Connect(function()bM=not bM ah(bP,{BackgroundColor3=bM and z.Accent or z.Surface2},0.15)ah(bQ,{Color=bM and z.Accent or z.Stroke},0.15)ah(bR,{ImageTransparency=bM and 0 or 1},0.15)ah(bS,{TextColor3=bM and z.Text or z.Muted},0.15)end)end local bO=false local function bP(bQ,bR,bS,bT)local bU=ai('TextButton',{Size=UDim2.fromOffset(0,34),AutomaticSize=Enum.AutomaticSize.X,BackgroundColor3=bR and z.Accent or z.Surface2,BackgroundTransparency=bR and 0.12 or 0,BorderSizePixel=0,Text='',AutoButtonColor=false,LayoutOrder=bS,Parent=bL})aj(bU,UDim.new(0,7))local bV=ak(bU,bR and z.Accent or z.Stroke,1)bV.Transparency=bR and 0.4 or 0 al(bU,14,14)am({Size=UDim2.new(0,0,1,0),AutomaticSize=Enum.AutomaticSize.X,Text=bQ,TextSize=13,TextColor3=bR and z.AccentDark or z.Text,TextXAlignment=Enum.TextXAlignment.Center,Parent=bU})bU.MouseEnter:Connect(function()if bR then ah(bU,{BackgroundTransparency=0},0.12)ah(bV,{Transparency=0},0.12)else ah(bV,{Color=z.StrokeHover},0.12)end end)bU.MouseLeave:Connect(function()if bR then ah(bU,{BackgroundTransparency=0.12},0.2)ah(bV,{Transparency=0.4},0.2)else ah(bV,{Color=z.Stroke},0.2)end end)bU.MouseButton1Click:Connect(function()if bO then return end bO=true bT()end)end if bA.ExitText~=false then bP(bA.ExitText or'Exit',bA.Block,1,function()if bA.Callback then task.spawn(bA.Callback,false)end ah(bg,{GroupTransparency=1,Position=UDim2.new(0.5,0,0.5,12)},0.25,Enum.EasingStyle.Quint)ah(bk,{ImageTransparency=1},0.2)task.delay(0.25,function()self:Destroy()end)end)end if not bA.Block then bP(bA.ContinueText or'Continue',true,2,function()if bM and bA.Remember then bA.Remember()end if bA.Callback then task.spawn(bA.Callback,true)end ah(bG,{GroupTransparency=1},0.15)task.delay(0.15,function()bG:Destroy()bB()end)end)end local bQ=false local function bR()local bS,bT=pcall(function()local bS=Instance.new('GetTextBoundsParams')bS.Text=bK.Text bS.Font=bK.FontFace bS.Size=bK.TextSize bS.Width=bC-bD*2-8 return game:GetService('TextService'):GetTextBoundsAsync(bS)end)return bS and bT and math.ceil(bT.Y)+2 or bK.TextBounds.Y end local function bS(bT)local bU=math.max(bR(),16)local bV=math.min(bU,bE)bK.Size=UDim2.new(1,-8,0,bU)bJ.Size=UDim2.new(1,-bD*2,0,bV)bJ.CanvasSize=UDim2.fromOffset(0,bU)local bW=bD+60+bV+18+34+bD-4 if bN then bW+=bN.Size.Y.Offset+10 end ah(bg,{Size=UDim2.fromOffset(bC,bW)},bT,Enum.EasingStyle.Quint)end bK:GetPropertyChangedSignal('TextBounds'):Connect(function()if bQ and bg.Parent and bG.Parent then bS(0.2)end end)task.delay(0.15,function()if not bg.Parent then return end bQ=true bS(0.35)task.delay(0.12,function()ah(bG,{GroupTransparency=0},0.3)bH.Size=UDim2.fromOffset(34,34)bH.Position=UDim2.fromOffset(bD+5,bD+5)ah(bH,{Size=UDim2.fromOffset(44,44),Position=UDim2.fromOffset(bD,bD)},0.45,Enum.EasingStyle.Back)end)end)end local function bA(bB,bC)if not bg.Parent then return end local bD=bB[bC]if not bD then bx()return end bz(bD,function()bA(bB,bC+1)end)end task.delay(a8,function()ah(bu,{Size=UDim2.fromScale(1,1)},0.25,Enum.EasingStyle.Quint)task.delay(0.25,function()if not bg.Parent then return end if a7._prompts then by()bA(a7._prompts,1)else bx()end end)end)end function a2:_fitToScreen(a7)local a8=self.Gui.AbsoluteSize if a8.X==0 or a8.Y==0 then return end local a9=self.Root.Size local ba=(self._uiScale or 1)*(self._adaptive~=false and k._adaptiveFactor(a8)or 1)local bb=math.min(ba,(a8.X-24)/math.max(a9.X.Offset,1),(a8.Y-24)/math.max(a9.Y.Offset,1))self._fitScale=math.max(bb,0.45)if self._introDone and self.Open then if a7 then self.Scale.Scale=self._fitScale else ah(self.Scale,{Scale=self._fitScale},0.2)end end end function k._adaptiveFactor(a7)if E then return 1 end local a8=math.min(a7.X/1920,a7.Y/1020)if a8>0.9 and a8<1.15 then return 1 end return math.clamp(math.floor(a8*20+0.5)/20,0.85,1.75)end function a2:SetAdaptiveSize(a7)self._adaptive=a7~=false self:_fitToScreen()task.delay(0.22,function()if not self._destroyed then self:_clampToScreen()end end)end function a2:GetAdaptiveSize()return self._adaptive~=false end function a2:SetUIScale(a7)a7=math.clamp(tonumber(a7)or 1,0.6,1.5)self.UIScale=a7 self._uiScale=a7 self:_fitToScreen()task.delay(0.22,function()if not self._destroyed then self:_clampToScreen()end end)end function a2:GetUIScale()return self._uiScale or 1 end k.DensityModes={Compact=0.55,Default=1,Comfortable=1.45}k.Density='Default'function k._spaced(a7,a8)if a7<=0 then return 0 end return math.max(math.floor(a7*a8+(a8-1)*4+0.5),0)end function k._space(a7,a8)local a9=k.DensityModes[k.Density]or 1 if a7:IsA('UIListLayout')or a7:IsA('UIGridLayout')then a7:SetAttribute('Space',a8)a7.Padding=UDim.new(0,k._spaced(a8,a9))elseif a7:IsA('UIPadding')then a7:SetAttribute('SpaceL',a8[1])a7:SetAttribute('SpaceR',a8[2])a7:SetAttribute('SpaceT',a8[3])a7:SetAttribute('SpaceB',a8[4])a7.PaddingLeft=UDim.new(0,math.floor(a8[1]*math.sqrt(a9)+0.5))a7.PaddingRight=UDim.new(0,math.floor(a8[2]*math.sqrt(a9)+0.5))a7.PaddingTop=UDim.new(0,k._spaced(a8[3],a9))a7.PaddingBottom=UDim.new(0,k._spaced(a8[4],a9))end return a7 end function k:SetDensity(a7)if type(a7)=='string'then for a8 in pairs(k.DensityModes)do if a8:lower()==a7:lower()then a7=a8 break end end end if not k.DensityModes[a7]then a7='Default'end k.Density=a7 for a8,a9 in ipairs(k.Windows)do if a9.Gui and a9.Gui.Parent then for ba,bb in ipairs(a9.Gui:GetDescendants())do local bc=bb:GetAttribute('Space')if bc then k._space(bb,bc)elseif bb:GetAttribute('SpaceL')then k._space(bb,{bb:GetAttribute('SpaceL'),bb:GetAttribute('SpaceR'),bb:GetAttribute('SpaceT'),bb:GetAttribute('SpaceB')})end end end end return a7 end function a2:SetDensity(a7)return k:SetDensity(a7)end function a2:GetDensity()return k.Density end function a2:_clampedCentre(a7)local a8=self.Gui.AbsoluteSize local a9=self.Root.AbsoluteSize/2 return Vector2.new(math.clamp(a7.X,math.min(a9.X,a8.X/2),math.max(a8.X-a9.X,a8.X/2)),math.clamp(a7.Y,math.min(a9.Y,a8.Y/2),math.max(a8.Y-a9.Y,a8.Y/2)))end function a2:_clampToScreen()if not self.KeepOnScreen or self._resizeActive then return end local a7=self.Root local a8=a7.AbsolutePosition+a7.AbsoluteSize/2-self.Gui.AbsolutePosition local a9=self:_clampedCentre(a8)if(a9-a8).Magnitude>0.5 then self._clampTween=ah(a7,{Position=UDim2.fromOffset(a9.X,a9.Y)},0.25,Enum.EasingStyle.Quint)end end function a2:_createOpenButton(a7)local a8=self.Gui local a9=ai('TextButton',{AnchorPoint=Vector2.new(0.5,0),Position=UDim2.new(0.5,0,0,14),Size=UDim2.fromOffset(0,40),AutomaticSize=Enum.AutomaticSize.X,BackgroundColor3=z.Background,BorderSizePixel=0,Text='',AutoButtonColor=false,ZIndex=30,Parent=a8})aj(a9,UDim.new(1,0))ak(a9,z.Stroke)al(a9,12,16)local ba=ai('ImageLabel',{AnchorPoint=Vector2.new(0,0.5),Position=UDim2.new(0,0,0.5,0),Size=UDim2.fromOffset(20,20),BackgroundTransparency=1,ImageColor3=z.Accent,ScaleType=Enum.ScaleType.Fit,ZIndex=31,Parent=a9})aq(ba,a7.Icon or A.Logo,true)am({Position=UDim2.fromOffset(28,0),Size=UDim2.new(0,0,1,0),AutomaticSize=Enum.AutomaticSize.X,Text=a7.Title or'Airflow',TextSize=13,TextTruncate=Enum.TextTruncate.None,ZIndex=31,Parent=a9})self.OpenButton=a9 local bb,bc=false,false local bd=Vector2.zero a9.InputBegan:Connect(function(be)if aw(be)then bb=true bc=false bd=av()-a9.AbsolutePosition end end)table.insert(self._connections,b.InputChanged:Connect(function(be)if not bb then return end if aA(be)then local bf=av()-bd-a8.AbsolutePosition if(bf-(a9.AbsolutePosition-a8.AbsolutePosition)).Magnitude>3 then bc=true end a9.AnchorPoint=Vector2.new(0,0)a9.Position=UDim2.fromOffset(math.clamp(bf.X,0,math.max(a8.AbsoluteSize.X-a9.AbsoluteSize.X,0)),math.clamp(bf.Y,0,math.max(a8.AbsoluteSize.Y-a9.AbsoluteSize.Y,0)))end end))table.insert(self._connections,b.InputEnded:Connect(function(be)if bb and aw(be)then bb=false if not bc then self:Toggle()end end end))end function a2:_toggleButtonAllowed()return self._toggleEnabled and(E or self._togglePlatform=='Both')end function a2:_refreshToggleButton()local a7=self.ToggleButton if not a7 then return end local a8=self._introDone and not self._destroyed and self:_toggleButtonAllowed()if a8 and not a7.Visible then a7.Visible=true a7.Size=UDim2.fromOffset(0,0)ah(a7,{Size=UDim2.fromOffset(self._toggleSize,self._toggleSize)},0.45,Enum.EasingStyle.Quint)elseif not a8 then a7.Visible=false end local a9=self.Minimized or not self.Open ah(self._toggleStroke,{Color=a9 and z.Accent or z.Stroke,Transparency=a9 and 0.3 or 0},0.35)local ba=self._toggleIcon ah(ba,{Rotation=a9 and 180 or 0},0.5,Enum.EasingStyle.Quint)if not ba:GetAttribute('CustomIcon')then ah(ba,{ImageColor3=a9 and z.Text or z.Accent},0.35)end end function a2:_createToggleButton(a7)local a8=self.Gui local a9=tonumber(a7.Size)or(E and 56 or 50)local ba=math.floor(a9*0.46)self._toggleEnabled=a7.Enabled~=false self._togglePlatform=a7.Platform=='Both'and'Both'or'Mobile'self._toggleSize=a9 local bb=ai('TextButton',{AnchorPoint=Vector2.new(0.5,0.5),Position=a7.Position or UDim2.new(0,18+a9/2,0.5,0),Size=UDim2.fromOffset(a9,a9),BackgroundColor3=z.Background,BorderSizePixel=0,Text='',AutoButtonColor=false,ClipsDescendants=true,Visible=false,ZIndex=30,Parent=a8})aj(bb,UDim.new(0,12))local bc=ak(bb,z.Stroke)local bd=ai('ImageLabel',{AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.fromScale(0.5,0.5),Size=UDim2.fromOffset(ba,ba),BackgroundTransparency=1,ImageColor3=z.Accent,ScaleType=Enum.ScaleType.Fit,ZIndex=31,Parent=bb})local be=ai('UIScale',{Parent=bb})self.ToggleButton=bb self._toggleStroke=bc self._toggleIcon=bd self:SetToggleButtonIcon(a7.Icon or'layout-grid')local bf,bg=false,false local bh=Vector2.zero bb.InputBegan:Connect(function(bi)if aw(bi)then bf=true bg=false bh=av()-bb.AbsolutePosition ah(be,{Scale=0.94},0.18,Enum.EasingStyle.Quint)end end)table.insert(self._connections,b.InputChanged:Connect(function(bi)if not bf or not aA(bi)then return end local bj=av()-bh-a8.AbsolutePosition if(bj-(bb.AbsolutePosition-a8.AbsolutePosition)).Magnitude>3 then bg=true end if bg then bb.AnchorPoint=Vector2.zero bb.Position=UDim2.fromOffset(math.clamp(bj.X,0,math.max(a8.AbsoluteSize.X-bb.AbsoluteSize.X,0)),math.clamp(bj.Y,0,math.max(a8.AbsoluteSize.Y-bb.AbsoluteSize.Y,0)))end end))table.insert(self._connections,b.InputEnded:Connect(function(bi)if not bf or not aw(bi)then return end bf=false ah(be,{Scale=1},0.4,Enum.EasingStyle.Quint)if bg then return end aE(bb)if not self.Open then self:Toggle(true)elseif self.Minimized then self:Restore()else self:Minimize()end end))end function a2:SetToggleButton(a7)self._toggleEnabled=a7~=false self:_refreshToggleButton()end function a2:SetToggleButtonPlatform(a7)self._togglePlatform=a7=='Both'and'Both'or'Mobile'self:_refreshToggleButton()end function a2:SetToggleButtonIcon(a7)local a8=self._toggleIcon if not a8 then return end a8.Image=''aq(a8,a7)if a8.Image==''then aq(a8,A.Logo)end if not a8:GetAttribute('CustomIcon')then ah(a8,{ImageColor3=(self.Minimized or not self.Open)and z.Text or z.Accent},0)end end function a2:_enableResize(a7)local a8=self.MaxSize or Vector2.new(math.huge,math.huge)self._minSize=a7 local a9=self.Root local ba=ai('Frame',{AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.new(1,4,1,4),Size=UDim2.fromOffset(32,32),BackgroundTransparency=1,Active=true,ZIndex=20,Parent=a9})self._grip=ba local bb=ai('Frame',{AnchorPoint=Vector2.new(1,1),Position=UDim2.fromOffset(12,12),Size=UDim2.fromOffset(26,26),BackgroundTransparency=1,ZIndex=20,Parent=ba})aj(bb,UDim.new(0,10))local bc=ai('UIStroke',{Color=z.Muted,Thickness=2,Transparency=0.55,Parent=bb})ai('UIGradient',{Rotation=45,Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(0.55,1),NumberSequenceKeypoint.new(0.85,0),NumberSequenceKeypoint.new(1,0)}),Parent=bc})local function bd(be)ah(bc,{Color=be and z.Accent or z.Muted,Transparency=be and 0 or 0.55},be and 0.15 or 0.3,Enum.EasingStyle.Quint)end local be=20 local bf=false local bg=Vector2.zero local bh=Vector2.zero local bi=Vector2.zero local bj=Vector2.zero local bk=Vector2.zero local bl=Vector2.zero local function bm()return Vector2.new(a9.Size.X.Offset,a9.Size.Y.Offset)end local function bn()if a9.AnchorPoint==Vector2.zero then return end if self._clampTween then self._clampTween:Cancel()self._clampTween=nil end local bo=a9.AbsolutePosition-self.Gui.AbsolutePosition a9.AnchorPoint=Vector2.zero a9.Position=UDim2.fromOffset(bo.X,bo.Y)end local function bo()local bp=a9.AbsolutePosition-self.Gui.AbsolutePosition local bq=a9.AbsoluteSize/2 a9.AnchorPoint=Vector2.new(0.5,0.5)a9.Position=UDim2.fromOffset(bp.X+bq.X,bp.Y+bq.Y)end local function bp(bq)return Vector2.new(math.floor(math.clamp(bq.X,a7.X,a8.X)+0.5),math.floor(math.clamp(bq.Y,a7.Y,a8.Y)+0.5))end ba.InputBegan:Connect(function(bq)if not aw(bq)or not self.Open then return end if not self._resizeActive then bn()bi=bm()bj=Vector2.zero bl=bi end self._resizeActive=true bf=true bg=bi bh=av()bk=bp(bg)bd(true)end)ba.MouseEnter:Connect(function()if not bf then bd(true)end end)ba.MouseLeave:Connect(function()if not bf then bd(false)end end)table.insert(self._connections,b.InputEnded:Connect(function(bq)if bf and aw(bq)then bf=false bd(false)end end))table.insert(self._frameSteps,function(bq)if not self._resizeActive then return end if bf then local br=(av()-bh)/self.Scale.Scale bk=bp(bg+br)end local br=math.min(bq,1/30)local bs=math.exp(-be*br)local bt=bi-bk local bu=(bj+bt*be)*br bj=(bj-bu*be)*bs bi=bk+(bt+bu)*bs local bv=Vector2.new(math.floor(bi.X+0.5),math.floor(bi.Y+0.5))if bv~=bl then bl=bv a9.Size=UDim2.fromOffset(bv.X,bv.Y)end if not bf and(bi-bk).Magnitude<0.3 and bj.Magnitude<3 then bi=bk bj=Vector2.zero bl=bk a9.Size=UDim2.fromOffset(bk.X,bk.Y)bo()self._resizeActive=false self:_fitToScreen()self:_clampToScreen()end end)end function a2:GetSize()return Vector2.new(self.Root.Size.X.Offset,self.Root.Size.Y.Offset)end function a2:SetSize(a7,a8)if typeof(a7)=='UDim2'then a7=Vector2.new(a7.X.Offset,a7.Y.Offset)end if typeof(a7)~='Vector2'or self._resizeActive then return end local a9=self._minSize or Vector2.zero local ba=self.MaxSize or Vector2.new(math.huge,math.huge)a7=Vector2.new(math.floor(math.clamp(a7.X,a9.X,ba.X)+0.5),math.floor(math.clamp(a7.Y,a9.Y,ba.Y)+0.5))if a7==self:GetSize()then return end local bb=(a8 or not self.Root.Visible)and 0 or 0.3 ah(self.Root,{Size=UDim2.fromOffset(a7.X,a7.Y)},bb,Enum.EasingStyle.Quint)task.delay(bb+0.02,function()if not self._destroyed then self:_fitToScreen()self:_clampToScreen()end end)end local a7=1 local a8='airflow:'local function a9(ba,bb)return ba.ConfigFolder..'/'..bb..'.json'end local function ba()return type(writefile)=='function'and type(readfile)=='function'and type(isfile)=='function'end local function bb(bc)if type(isfolder)~='function'or type(makefolder)~='function'then return end local bd=''for be in tostring(bc):gmatch('[^/\\]+')do bd=bd==''and be or bd..'/'..be if not isfolder(bd)then makefolder(bd)end end end local function bc(bd)return string.format('%02x%02x%02x',math.floor(bd.R*255+0.5),math.floor(bd.G*255+0.5),math.floor(bd.B*255+0.5))end local function bd(be)if type(be)=='table'then if type(be.Hex)=='string'then be=be.Hex elseif type(be[1])=='number'then return Color3.new(be[1],be[2]or 0,be[3]or 0)end end if type(be)=='string'then local bf,bg,bh=be:match('^%s*#?(%x%x)(%x%x)(%x%x)%s*$')if bf then return Color3.fromRGB(tonumber(bf,16),tonumber(bg,16),tonumber(bh,16))end end return nil end local function be(bf)local bg=bf._type local bh=bf:Get()if type(bf._saveValue)=='function'then bh=bf:_saveValue()end if bg=='Keybind'then return{Type=bg,Value=bh and bh.Name or nil}elseif bg=='ColorPicker'then return{Type=bg,Value=typeof(bh)=='Color3'and{Hex=bc(bh)}or nil}end return{Type=bg,Value=bh}end local function bf(bg,bh,bi)local bj=bg._type local bk=bh.Value if bj=='Keybind'then bg:Set(type(bk)=='string'and Enum.KeyCode[bk]or nil,bi)elseif bj=='ColorPicker'then local bl=bd(bk)if bl then bg:Set(bl,bi)end elseif bj=='Dropdown'then bg:Set(bk,bi)elseif bj=='Toggle'then if type(bk)=='boolean'then bg:Set(bk,bi)end elseif bj=='Slider'or bj=='Stepper'or bj=='Progress'then local bl=tonumber(bk)if bl then bg:Set(bl,bi)end elseif bk~=nil then bg:Set(bk,bi)end end local function bg(bh,bi)return type(bi)=='table'and(bi.Type==nil or bi.Type==bh._type)end local function bh(bi)local bj={}if bi and bi._pendingFlags then for bk,bl in pairs(bi._pendingFlags)do bj[bk]=bl.Entry end end for bk,bl in pairs(k.Flags)do if bl._type and type(bl.Get)=='function'then local bm,bn=pcall(be,bl)if bm then bj[bk]=bn end end end return bj end function a2:_applyFlags(bi,bj)bj=bj==true self._pendingFlags={}for bk,bl in pairs(bi)do local bm=k.Flags[bk]if bm and type(bm.Set)=='function'then if bg(bm,bl)then pcall(bf,bm,bl,bj)end elseif type(bl)=='table'then self._pendingFlags[bk]={Entry=bl,Silent=bj}end end end function a2:_flagCreated(bi,bj)local bk,bl=pcall(be,bj)if bk then bj._defaultEntry=bl end local bm=self._pendingFlags and self._pendingFlags[bi]if not bm then return end task.defer(function()if self._pendingFlags[bi]~=bm or k.Flags[bi]~=bj or bj._destroyed then return end self._pendingFlags[bi]=nil if bg(bj,bm.Entry)then pcall(bf,bj,bm.Entry,bm.Silent)end end)end function a2:_configChanged()for bi,bj in ipairs(self._configListeners)do aJ(bj)end end function a2:OnConfigChanged(bi)table.insert(self._configListeners,bi)return function()local bj=table.find(self._configListeners,bi)if bj then table.remove(self._configListeners,bj)end end end local function bi(bj)return type(bj)=='string'and bj~=''and not bj:find('[\\/:%*%?"<>|]')end local function bj(bk,bl,bm)return e:JSONEncode({Folder=bk.ConfigFolder,Name=bl,Version=a7,Config=e:JSONEncode(bm)})end local bk=[[ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/]]local bl={}for bm=1,#bk do bl[bk:byte(bm)]=bm-1 end local function bm(bn)if#bn%4~=0 then return nil end local bo={}for bp=1,#bn,4 do local bq,br=0,0 for bs=0,3 do local bt=bn:byte(bp+bs)local bu=bl[bt]if bt==61 and bp+3>=#bn then br+=1 bu=0 elseif bu==nil or br>0 then return nil end bq=bq*64+bu end if br>2 then return nil end local bs=string.char(bit32.extract(bq,16,8),bit32.extract(bq,8,8),bit32.extract(bq,0,8))table.insert(bo,bs:sub(1,3-br))end return table.concat(bo)end local function bn(bo)bo=tostring(bo or''):match('^%s*(.-)%s*$')if bo:sub(1,#a8)==a8 then bo=bm((bo:sub(#a8+1):gsub('%s','')))if not bo then return nil,'invalid config code'end end local bp,bq=pcall(function()return e:JSONDecode(bo)end)if not bp or type(bq)~='table'then return nil,'invalid config code'end local br={}if type(bq.Config)=='string'or(type(bq.Config)=='table'and bq.Config.Type==nil)then br.Folder=type(bq.Folder)=='string'and bq.Folder or nil br.Name=type(bq.Name)=='string'and bq.Name or nil br.Version=tonumber(bq.Version)local bs=bq.Config if type(bs)=='string'then bp,bs=pcall(function()return e:JSONDecode(bq.Config)end)if not bp then return nil,'invalid config code'end end if type(bs)~='table'then return nil,'invalid config code'end bq=bs end for bs,bt in pairs(bq)do if type(bs)~='string'or type(bt)~='table'then return nil,'invalid config code'end end return bq,br end local function bo(bp,bq,br)if not bi(bq)then return false,'invalid config name'end if not ba()then return false,'file API unavailable'end local bs,bt=pcall(bj,bp,bq,br)if not bs then return false,'could not encode config'end bb(bp.ConfigFolder)return pcall(writefile,a9(bp,bq),bt)end local function bp(bq,br)if not ba()then return nil,'file API unavailable'end if not bi(br)then return nil,'invalid config name'end local bs=a9(bq,br)if not isfile(bs)then return nil,'no config named '..tostring(br)end local bt,bu=pcall(readfile,bs)if not bt or type(bu)~='string'then return nil,'could not read '..br end local bv,bw=bn(bu)if not bv then return nil,'config is not valid JSON'end return bv,bw end function a2:ConfigExists(bq)return bi(bq)and ba()and isfile(a9(self,bq))or false end function a2:SaveConfig(bq)bq=bq or self.ConfigName if not bq then return false,'no config name'end local br,bs=bo(self,bq,bh(self))if br then self.ConfigName=bq end return br,bs end function a2:LoadConfig(bq,br)bq=bq or self.ConfigName if not bq then return false,'no config name'end local bs,bt=bp(self,bq)if not bs then return false,bt end self:_applyFlags(bs,br)self.ConfigName=bq self.LoadedConfig=bq self:_configChanged()return true end function a2:DeleteConfig(bq)if not ba()or type(delfile)~='function'then return false,'file API unavailable'end if not bi(bq)then return false,'invalid config name'end local br=a9(self,bq)if not isfile(br)then return false,'no config named '..bq end local bs,bt=pcall(delfile,br)if not bs then return false,bt end if self.LoadedConfig==bq then self.LoadedConfig=nil end self:_configChanged()return true end function a2:RenameConfig(bq,br)if not bi(br)then return false,'invalid config name'end if bq==br then return true end if self:ConfigExists(br)then return false,br..' already exists'end local bs,bt=bp(self,bq)if not bs then return false,bt end local bu bu,bt=bo(self,br,bs)if not bu then return false,bt end if type(delfile)=='function'then pcall(delfile,a9(self,bq))end if self.LoadedConfig==bq then self.LoadedConfig=br end if self.ConfigName==bq then self.ConfigName=br end for bv,bw in ipairs({'Global','Account'})do if self:GetAutoload(bw)==bq then self:SetAutoload(br,bw)end end self:_configChanged()return true end function a2:ListConfigs()local bq={}if type(listfiles)~='function'or type(isfolder)~='function'or not isfolder(self.ConfigFolder)then return bq end local br,bs=pcall(listfiles,self.ConfigFolder)if not br or type(bs)~='table'then return bq end for bt,bu in ipairs(bs)do local bv=bu:match('([^/\\]+)%.json$')if bv then table.insert(bq,bv)end end table.sort(bq,function(bt,bu)return bt:lower()<bu:lower()end)return bq end function a2:ResetConfig(bq)self._pendingFlags={}for br,bs in pairs(k.Flags)do if bs._defaultEntry and type(bs.Set)=='function'then pcall(bf,bs,bs._defaultEntry,bq==true)end end self:_configChanged()return true end local function bq(br)if type(isfolder)~='function'or not isfolder(br)then return true end if type(delfolder)=='function'and pcall(delfolder,br)and not isfolder(br)then return true end if type(listfiles)=='function'then local bs,bt=pcall(listfiles,br)for bu,bv in ipairs(bs and bt or{})do if isfolder(bv)then bq(bv)elseif type(delfile)=='function'then pcall(delfile,bv)end end end if type(delfolder)=='function'then pcall(delfolder,br)end return not isfolder(br)end function a2:ClearWorkspace()local br=bq(self.ConfigFolder)self.LoadedConfig=nil for bs,bt in ipairs(self._workspaceListeners or{})do aJ(bt)end self:_configChanged()return br end function a2:ExportConfig(br)local bs,bt if br then bs,bt=bp(self,br)if not bs then return nil,bt end else bs=bh(self)br=self.LoadedConfig or self.ConfigName end local bu,bv=pcall(bj,self,br,bs)if not bu then return nil,'could not encode config'end return bv end function a2:DecodeConfig(br)return bn(br)end function a2:ImportConfig(br,bs,bt)local bu,bv=bn(br)if not bu then return false,bv end if not bt and bv.Folder and bv.Folder~=self.ConfigFolder then return false,'config is for '..bv.Folder end if bs==true then bs=bv.Name if not bi(bs)then return false,'config has no usable name'end end if bs then local bw,bx=bo(self,bs,bu)if not bw then return false,bx end end self:_applyFlags(bu)if bs then self.ConfigName=bs self.LoadedConfig=bs end self:_configChanged()return true,nil,bs end local function br(bs)if not ba()or not isfile(bs)then return nil end local bt,bu=pcall(readfile,bs)if bt and type(bu)=='string'and bu~=''then return bu end return nil end local function bs(bt)if ba()and type(delfile)=='function'and isfile(bt)then pcall(delfile,bt)end end local function bt(bu)return bu.ConfigFolder..'/configsettings.txt'end function a2:_readConfigSettings()local bu=br(bt(self))if bu then local bv,bw=pcall(function()return e:JSONDecode(bu)end)if bv and type(bw)=='table'then return bw end end return{}end function a2:_writeConfigSettings(bu)if not ba()then return false,'file API unavailable'end local bv=self:_readConfigSettings()for bw,bx in pairs(bu)do bv[bw]=bx end bb(self.ConfigFolder)return pcall(writefile,bt(self),e:JSONEncode(bv))end local function bu(bv,bw)if bw=='Account'then return bv.ConfigFolder..'/autoload_'..tostring(j and j.UserId or 0)..'.txt'end return bv.ConfigFolder..'/autoload.txt'end function a2:GetAutoloadMode()return self:_readConfigSettings().AutoloadMode=='Account'and'Account'or'Global'end function a2:GetAutoload(bv)if bv then return br(bu(self,bv))end return br(bu(self,'Account'))or br(bu(self,'Global'))end function a2:SetAutoload(bv,bw)if not ba()then return false,'file API unavailable'end bw=bw or self:GetAutoloadMode()local bx,by=true,nil if bv==nil or bv==''then bs(bu(self,bw))if bw=='Global'then bs(bu(self,'Account'))end else bb(self.ConfigFolder)bx,by=pcall(writefile,bu(self,bw),tostring(bv))if bx and bw=='Global'then bs(bu(self,'Account'))end end self:_configChanged()return bx,by end function a2:SetAutoloadMode(bv)bv=bv=='Account'and'Account'or'Global'if bv==self:GetAutoloadMode()then return true end local bw=self:GetAutoload()local bx,by=self:_writeConfigSettings({AutoloadMode=bv})if not bx then return false,by end bs(bu(self,bv=='Account'and'Global'or'Account'))if bw then return self:SetAutoload(bw,bv)end self:_configChanged()return true end function a2:LoadAutoload(bv)local bw=self:GetAutoload()if not bw then return false,'no autoload config'end return self:LoadConfig(bw,bv)end k._themeListeners={}local function bv(bw)if typeof(bw)=='Color3'then return bw elseif type(bw)=='string'then local bx,by,bz=bw:match('^%s*#?(%x%x)(%x%x)(%x%x)%s*$')if bx then return Color3.fromRGB(tonumber(bx,16),tonumber(by,16),tonumber(bz,16))end elseif type(bw)=='table'then local bx,by,bz=bw[1]or bw.R,bw[2]or bw.G,bw[3]or bw.B if tonumber(bx)and tonumber(by)and tonumber(bz)then return Color3.fromRGB(bx,by,bz)end end return nil end local function bw(bx)return string.format('#%02X%02X%02X',math.floor(bx.R*255+0.5),math.floor(bx.G*255+0.5),math.floor(bx.B*255+0.5))end k._toneTags={}for bx,by in ipairs(n)do k._toneTags[string.lower(by)]=by end function k._color(bx)if type(bx)=='string'then local by=k._toneTags[string.lower(bx)]if by then return z[by]end end return bv(bx)end function k._rich(bx)bx=tostring(bx==nil and''or bx)if not string.find(bx,'<',1,true)then return bx end return(string.gsub(bx,'<(/?)(%a+%d*)>',function(by,bz)local bA=k._toneTags[string.lower(bz)]if not bA then return nil end if by=='/'then return'</font>'end return'<font color="'..bw(z[bA])..'">'end))end function k.Colorize(...)local bx={...}if bx[1]==k then table.remove(bx,1)end local by,bz=tostring(bx[1]==nil and''or bx[1]),bx[2]local bA=type(bz)=='string'and k._toneTags[string.lower(bz)]if bA then return'<'..bA..'>'..by..'</'..bA..'>'end local bB=bv(bz)if not bB then return by end return'<font color="'..bw(bB)..'">'..by..'</font>'end function k:SetCornerRadius(bx,by)bx=math.clamp(math.floor((tonumber(bx)or 10)+0.5),0,20)k.Roundness=bx/10 for bz,bA in pairs(k._cornerBases)do if not bz.Parent then k._cornerBases[bz]=nil else local bB=UDim.new(0,math.floor(bA*k.Roundness+0.5))if by then bz.CornerRadius=bB else ah(bz,{CornerRadius=bB},0.25,Enum.EasingStyle.Quint)end end end return bx end function k:GetCornerRadius()return math.floor(k.Roundness*10+0.5)end function k:SetTheme(bx,by)if type(bx)=='string'then local bz=k.ThemePresets[bx]if not bz then return false end k.ThemeName=bx bx=bz elseif type(bx)~='table'then return false end local bz=false for bA,bB in ipairs(n)do local bC=bv(bx[bB])if bC and bC~=z[bB]then z[bB]=bC bz=true end end if not bz then return true end _()Y()af(by and 0 or 0.3)for bA,bB in pairs(S)do if bA.Parent then pcall(bB)end end for bA,bB in ipairs(k._themeListeners)do pcall(bB)end return true end function k:GetTheme()local bx={}for by,bz in ipairs(n)do bx[bz]=z[bz]end return bx end function k:SetDefaultTheme(bx)k.DefaultTheme=bx if bx==nil then return true end local by=false for bz,bA in ipairs(k.Windows)do if not bA._destroyed then if bA:GetDefaultTheme()then return true end by=true end end return k:SetTheme(bx,not by)end function k:GetDefaultTheme()return k.DefaultTheme end local function bx(by)return by.ConfigFolder..'/themes'end function a2:SaveTheme(by)if not ba()then return false,'file API unavailable'end if type(by)~='string'or by==''then return false,'theme needs a name'end bb(self.ConfigFolder)bb(bx(self))local bz={}for bA,bB in ipairs(n)do bz[bB]=bw(z[bB])end return pcall(function()writefile(bx(self)..'/'..by..'.json',e:JSONEncode(bz))end)end function a2:LoadTheme(by,bz)if k.ThemePresets[by]then return k:SetTheme(by,bz)end local bA=br(bx(self)..'/'..tostring(by)..'.json')if not bA then return false,'no theme named '..tostring(by)end local bB,bC=pcall(function()return e:JSONDecode(bA)end)if not bB or type(bC)~='table'then return false,'theme is not valid JSON'end k.ThemeName=by return k:SetTheme(bC,bz)end function a2:DeleteTheme(by)if not ba()or type(delfile)~='function'then return false,'file API unavailable'end local bz=bx(self)..'/'..tostring(by)..'.json'if not isfile(bz)then return false,'no theme named '..tostring(by)end delfile(bz)if self:GetDefaultTheme()==by then self:SetDefaultTheme(nil)end return true end function a2:ListThemes()local by={}if type(listfiles)~='function'or type(isfolder)~='function'or not isfolder(bx(self))then return by end for bz,bA in ipairs(listfiles(bx(self)))do local bB=bA:match('([^/\\]+)%.json$')if bB then table.insert(by,bB)end end table.sort(by)return by end function a2:GetDefaultTheme()return br(bx(self)..'/default.txt')end function a2:SetDefaultTheme(by)if not ba()then return false,'file API unavailable'end bb(self.ConfigFolder)bb(bx(self))local bz=bx(self)..'/default.txt'if by==nil or by==''then if isfile(bz)and type(delfile)=='function'then pcall(delfile,bz)end return true end return pcall(writefile,bz,tostring(by))end function a2:_applyDefaultTheme()local by=self:GetDefaultTheme()if by then local bz,bA=pcall(self.LoadTheme,self,by,true)if bz and bA then return end end if k.DefaultTheme~=nil then pcall(k.SetTheme,k,k.DefaultTheme,true)end end k.BackgroundPresets={['Deep Violet']='rbxassetid://136310484943077',['Blood Red']='rbxassetid://121343473918667',['Cyanic']='rbxassetid://95656189244173',['Amber Glow']='rbxassetid://107795771598485',['Bloomings']='rbxassetid://133541508207801',['Lavender Pink']='rbxassetid://126107479485287'}k.BackgroundPresetOrder={'Deep Violet','Blood Red','Cyanic','Amber Glow','Bloomings','Lavender Pink'}k._imageExtensions={png=true,jpg=true,jpeg=true,webp=true,gif=true,bmp=true}function a2:_backgroundFolder()return self.ConfigFolder..'/backgrounds'end function a2:_trimBackground(by)return(tostring(by or''):match('^%s*(.-)%s*$'))end function a2:_resolveBackground(by)by=self:_trimBackground(by)local bz=k.BackgroundPresets[by]if bz then return bz end if by:match('^%d+$')then return'rbxassetid://'..by end if by:match('^rbxassetid://%d+')or by:match('^rbxasset://')or by:match('^rbxthumb://')or by:match('^https?://www%.roblox%.com/asset')then return by end local bA=ba()and typeof(getcustomasset)=='function'if by:match('^https?://')then if not bA then return nil,'web images need writefile and getcustomasset'end local bB=by:match('^[^?#]+')or by local bC=(bB:match('%.(%w+)$')or'png'):lower()if not k._imageExtensions[bC]then bC='png'end local bD=(bB:gsub('^https?://',''):gsub('[^%w]','_')):sub(-60)local bE=self:_backgroundFolder()..'/cache'local bF=bE..'/'..bD..'_'..#by..'.'..bC if not isfile(bF)then local bG,bH=pcall(function()local bG=(syn and syn.request)or http_request or request if bG then local bH=bG({Url=by,Method='GET'})return bH and bH.Body end return game:HttpGet(by,true)end)if not bG or type(bH)~='string'or#bH<128 then return nil,'could not download the image'end local bI=bH:sub(1,64):lower()if bI:find('<!doctype')or bI:find('<html')then return nil,'that link is a web page, not an image'end bb(bE)if not pcall(writefile,bF,bH)then return nil,'could not save the image'end end local bG,bH=pcall(getcustomasset,bF)if bG and type(bH)=='string'and bH~=''then return bH end pcall(delfile,bF)return nil,'the downloaded file is not an image'end if bA then for bB,bC in ipairs({self:_backgroundFolder()..'/'..by,by})do if isfile(bC)then local bD,bE=pcall(getcustomasset,bC)if bD and type(bE)=='string'and bE~=''then return bE end return nil,'could not load '..by end end end return nil,'no image called '..by end function a2:SetBackground(by)self._backgroundGeneration+=1 local bz=self._backgroundGeneration local bA=self._backgroundImage by=by~=false and self:_trimBackground(by)or''if by==''or by=='None'then self.Background=nil ah(bA,{ImageTransparency=1},0.25)task.delay(0.25,function()if self._backgroundGeneration==bz then bA.Visible=false bA.Image=''end end)self:SetTransparent(self.Transparent)return true end local bB,bC=self:_resolveBackground(by)if self._backgroundGeneration~=bz or self._destroyed then return false,'replaced by a newer background'end if not bB then return false,bC end self.Background=by bA.Image=bB bA.Visible=true ah(bA,{ImageTransparency=self.BackgroundTransparency},0.3)self:SetTransparent(self.Transparent)return true end function a2:GetBackground()return self.Background end function a2:SetBackgroundTransparency(by)self.BackgroundTransparency=math.clamp(tonumber(by)or 0.35,0,1)if self.Background then ah(self._backgroundImage,{ImageTransparency=self.BackgroundTransparency},0.15)end end function a2:ListBackgrounds()local by=table.clone(k.BackgroundPresetOrder)local bz=self:_backgroundFolder()if type(listfiles)=='function'and type(isfolder)=='function'and isfolder(bz)then local bA={}for bB,bC in ipairs(listfiles(bz))do local bD=bC:match('([^/]+)$')local bE=bD and bD:match('%.(%w+)$')if bE and k._imageExtensions[bE:lower()]then table.insert(bA,bD)end end table.sort(bA)for bB,bC in ipairs(bA)do table.insert(by,bC)end end return by end local function by(bz,bA,bB)local bC=ai('Frame',{AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.new(0.5,0,0.5,-10),Size=UDim2.fromOffset(200,70),BackgroundTransparency=1,Parent=bz})local bD=ai('ImageLabel',{AnchorPoint=Vector2.new(0.5,0),Position=UDim2.new(0.5,0,0,0),Size=UDim2.fromOffset(26,26),BackgroundTransparency=1,ImageColor3=z.Muted,ImageTransparency=0.15,ScaleType=Enum.ScaleType.Fit,Parent=bC})aq(bD,bA)local bE=am({Position=UDim2.fromOffset(0,36),Size=UDim2.new(1,0,0,16),Text=bB,TextSize=13,FontFace=D.Regular,TextColor3=z.Muted,TextXAlignment=Enum.TextXAlignment.Center,Parent=bC})return bC,bE,bD end local function bz(bA,bB)bB=bB or 0 bA.GroupTransparency=1 bA.Position=UDim2.fromOffset(0,bB+14)bA.Visible=true ah(bA,{GroupTransparency=0,Position=UDim2.fromOffset(0,bB)},0.32,Enum.EasingStyle.Quint)end local function bA(bB)bB=math.max(math.floor(bB),0)local bC=math.floor(bB/86400)local bD=math.floor(bB/3600)%24 local bE=math.floor(bB/60)%60 if bC>0 then return string.format('%dd %dh',bC,bD)elseif bD>0 then return string.format('%dh %dm',bD,bE)elseif bE>0 then return string.format('%dm %ds',bE,bB%60)end return string.format('%ds',bB)end local function bB(bC)if type(bC)~='string'or bC==''then return'Studio'end if#bC>16 then return bC:sub(1,8)..'...'..bC:sub(-4)end return bC end local function bC(bD)local bE=setclipboard or toclipboard or(Clipboard and Clipboard.set)if type(bE)~='function'then return false end return(pcall(bE,tostring(bD)))end local function bD(bE)local bF=string.format([[https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=%s&limit=100&excludeFullGames=true]],game.PlaceId,bE)local bG,bH=pcall(function()return game:HttpGet(bF)end)if not bG or type(bH)~='string'then return nil end local bI,bJ=pcall(function()return e:JSONDecode(bH)end)if not bI or type(bJ)~='table'or type(bJ.data)~='table'then return nil end return bJ.data end local function bE(bF,bG,bH,bI)local bJ=ai('TextButton',{Size=UDim2.fromOffset(30,16),BackgroundColor3=z.Surface3,BorderSizePixel=0,Text='',AutoButtonColor=false,LayoutOrder=bH,Parent=bF})aj(bJ,UDim.new(1,0))ak(bJ)local bK=ai('Frame',{AnchorPoint=Vector2.new(0,0.5),Position=UDim2.new(0,2,0.5,0),Size=UDim2.fromOffset(12,12),BackgroundColor3=z.Muted,BorderSizePixel=0,Parent=bJ})aj(bK,UDim.new(1,0))local bL=bG==true local function bM(bN)local bO=bN and 0.22 or 0 ah(bJ,{BackgroundColor3=bL and z.Accent or z.Surface3},bO)ah(bK,{Position=bL and UDim2.new(0,16,0.5,0)or UDim2.new(0,2,0.5,0),BackgroundColor3=bL and z.AccentDark or z.Muted},bO,Enum.EasingStyle.Back)end bJ.MouseButton1Click:Connect(function()bL=not bL bM(true)aJ(bI,bL)end)bM(false)return bJ end local function bF(bG,bH,bI,bJ)local bK=ai('TextButton',{BackgroundColor3=z.Surface3,BackgroundTransparency=0.45,BorderSizePixel=0,Text='',AutoButtonColor=false,ClipsDescendants=true,Parent=bG})for bL,bM in pairs(bI)do bK[bL]=bM end aj(bK,UDim.new(0,6))local bL=ak(bK)local bM=am({Size=UDim2.fromScale(1,1),Text=bH,TextSize=12,TextXAlignment=Enum.TextXAlignment.Center,Parent=bK})if bK.AutomaticSize==Enum.AutomaticSize.X then bM.Size=UDim2.new(0,0,1,0)bM.AutomaticSize=Enum.AutomaticSize.X bM.TextTruncate=Enum.TextTruncate.None al(bK,14,14)end bK.MouseEnter:Connect(function()ah(bK,{BackgroundTransparency=0.15},0.12)ah(bL,{Color=z.StrokeHover},0.12)end)bK.MouseLeave:Connect(function()ah(bK,{BackgroundTransparency=0.45},0.25)ah(bL,{Color=z.Stroke},0.25)end)bK.MouseButton1Click:Connect(function()aE(bK)aJ(bJ)end)return bK,bM end local function bG(bH,bI,bJ)local bK=ai('Frame',{Size=UDim2.new(1,0,0,bI),BackgroundColor3=z.Surface2,BorderSizePixel=0,LayoutOrder=bJ,Parent=bH})bK:SetAttribute('NoDrag',true)aj(bK,UDim.new(0,10))ak(bK)return bK end local bH={Players={'users','Players'},Friends={'user-check','Friends'},Execs={'zap','Execs'},Session={'timer','Session'},Uptime={'timer','Session'},FPS={'gauge','FPS'},Ping={'wifi','Ping'},Executor={'terminal','Executor'},Game={'gamepad-2','Game'},Region={'globe','Region'},Time={'clock','Time'},ServerAge={'server','Server age'},Memory={'cpu','Memory'}}function k._healthColor(bI,bJ,bK,bL)if type(bI)~='number'then return z.Text end if bL then return bI<=bJ and z.Success or bI<=bK and z.Warning or z.Error end return bI>=bJ and z.Success or bI>=bK and z.Warning or z.Error end local function bI(bJ)if not ba()then return nil end local bK=bJ..'/executions.txt'local bL=0 pcall(function()bb(bJ)if isfile(bK)then bL=tonumber(readfile(bK))or 0 end end)bL+=1 pcall(writefile,bK,tostring(bL))return bL end local function bJ(bK,bL,bM,bN,bO)local bP=ai('ScrollingFrame',{Position=UDim2.fromOffset(0,bM),Size=UDim2.new(1,0,1,-bM),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=2,ScrollBarImageColor3=z.Accent,ScrollBarImageTransparency=0.5,ScrollingDirection=Enum.ScrollingDirection.Y,AutomaticCanvasSize=Enum.AutomaticSize.Y,CanvasSize=UDim2.new(),Parent=bL})k._space(al(bP,24,24,2,24),{24,24,2,24})k._space(ai('UIListLayout',{SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,8),Parent=bP}),8)bK.List=bP bK._items={}bK._groupboxes={}bK._childCount=0 bK._emptyText=bO bK._empty,bK._emptyCaption=by(bL,bN,bO)bP.ChildAdded:Connect(function(bQ)if bQ:IsA('GuiObject')then bK._childCount+=1 bK:_refreshEmpty()end end)bP.ChildRemoved:Connect(function(bQ)if bQ:IsA('GuiObject')then bK._childCount=math.max(bK._childCount-1,0)bK:_refreshEmpty()end end)bK:_refreshEmpty()return bP end function aS:_refreshEmpty()local bK=self._empty if not bK then return end if self._subTabs then bK.Visible=false else bK.Visible=self._childCount==0 end end function aS:_columns()if self._columnSet then return self._columnSet end local bK=ai('Frame',{Name='Columns',Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,BackgroundTransparency=1,LayoutOrder=100000,Parent=self.List})local bL=k._space(ai('UIListLayout',{FillDirection=Enum.FillDirection.Horizontal,SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,10),Parent=bK}),10)local function bM(bN)local bO=ai('Frame',{Size=UDim2.new(0.5,-5,0,0),AutomaticSize=Enum.AutomaticSize.Y,BackgroundTransparency=1,LayoutOrder=bN,Parent=bK})k._space(ai('UIListLayout',{SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,10),Parent=bO}),10)return bO end local bN={Holder=bK,Left=bM(1),Right=bM(2),Counts={0,0},Stacked=false}local bO=self.Window local function bP()local bQ=bK.AbsoluteSize.X/bO.Scale.Scale if bQ<=0 then return end local bR=bQ<O local bS=bL.Padding.Offset if bR==bN.Stacked and bS==bN.Gap then return end bN.Stacked=bR bN.Gap=bS bL.FillDirection=bR and Enum.FillDirection.Vertical or Enum.FillDirection.Horizontal local bT=bR and UDim2.new(1,0,0,0)or UDim2.new(0.5,-bS/2,0,0)bN.Left.Size=bT bN.Right.Size=bT end bK:GetPropertyChangedSignal('AbsoluteSize'):Connect(bP)bL:GetPropertyChangedSignal('Padding'):Connect(bP)task.defer(bP)self._columnSet=bN return bN end function aS:Groupbox(bK,bL)if self._groupbox then return self.Parent:Groupbox(bK,bL)end bK=l(bK,{Title='Name'})if bL~=nil and bK.Icon==nil then bK.Icon=bL end local bM=self.Window local bN=self:_columns()local bO=bK.Side if bO=='Left'or bO==1 then bO=1 elseif bO=='Right'or bO==2 then bO=2 else bO=bN.Counts[1]<=bN.Counts[2]and 1 or 2 end bN.Counts[bO]+=1 local bP=ai('Frame',{Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,BackgroundColor3=z.Surface2,BorderSizePixel=0,LayoutOrder=bN.Counts[bO],Parent=bO==1 and bN.Left or bN.Right})bP:SetAttribute('NoDrag',true)aj(bP,UDim.new(0,10))ak(bP)ai('UIListLayout',{SortOrder=Enum.SortOrder.LayoutOrder,Parent=bP})local bQ=ai('TextButton',{Size=UDim2.new(1,0,0,40),BackgroundColor3=z.Surface3,BorderSizePixel=0,Text='',AutoButtonColor=false,LayoutOrder=1,Parent=bP})aj(bQ,UDim.new(0,10))local bR=ai('Frame',{AnchorPoint=Vector2.new(0,1),Position=UDim2.fromScale(0,1),Size=UDim2.new(1,0,0,10),BackgroundColor3=z.Surface3,BorderSizePixel=0,Parent=bQ})local bS=14 if bK.Icon then local bT=ai('ImageLabel',{AnchorPoint=Vector2.new(0,0.5),Position=UDim2.new(0,14,0.5,0),Size=UDim2.fromOffset(14,14),BackgroundTransparency=1,ImageColor3=z.Accent,ScaleType=Enum.ScaleType.Fit,ZIndex=2,Parent=bQ})aq(bT,bK.Icon)bS=37 end local bT=ai('ImageLabel',{AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-14,0.5,0),Size=UDim2.fromOffset(14,14),BackgroundTransparency=1,ImageColor3=z.Muted,ScaleType=Enum.ScaleType.Fit,ZIndex=2,Parent=bQ})aq(bT,'chevron-down')local bU=bK.PopOut~=false local bV,bW if bU then bV=ai('TextButton',{AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-34,0.5,0),Size=UDim2.fromOffset(24,24),BackgroundColor3=z.Surface2,BackgroundTransparency=1,BorderSizePixel=0,Text='',AutoButtonColor=false,ZIndex=3,Parent=bQ})aj(bV,UDim.new(0,6))bW=ai('ImageLabel',{AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.fromScale(0.5,0.5),Size=UDim2.fromOffset(13,13),BackgroundTransparency=1,ImageColor3=z.Muted,ImageTransparency=E and 0 or 0.45,ScaleType=Enum.ScaleType.Fit,ZIndex=3,Parent=bV})aq(bW,'picture-in-picture-2')end local bX=am({Position=UDim2.fromOffset(bS,0),Size=UDim2.new(1,-(bS+(bU and 66 or 40)),1,0),Text=bK.Name or'Groupbox',TextSize=13,FontFace=D.Bold,ZIndex=2,Parent=bQ})local bY=ai('Frame',{Size=UDim2.new(1,0,0,1),BackgroundColor3=z.Stroke,BorderSizePixel=0,LayoutOrder=2,Parent=bP})local bZ=ai('Frame',{Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,BackgroundTransparency=1,ClipsDescendants=true,LayoutOrder=3,Parent=bP})local b_=ai('Frame',{Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,BackgroundTransparency=1,Parent=bZ})k._space(al(b_,0,0,6,8),{0,0,6,8})k._space(ai('UIListLayout',{SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,2),Parent=b_}),2)local b0=setmetatable({Name=bK.Name or'Groupbox',Window=bM,Parent=self,List=b_,Frame=bP,_frame=bP,_order=0,_groupbox=true,_metrics=P.Row,_items={}},aS)table.insert(self._groupboxes,b0)local b1=false local b2=0 local function b3(b4,b5)b4=b4==true if b4==b1 then return end b1=b4 b2+=1 local b6=b2 local b7=b5 and 0 or 0.32 if b4 then for b8,b9 in ipairs(b0._items)do if b9._onHide then b9._onHide()end if b9.Open and type(b9.SetOpen)=='function'then b9:SetOpen(false)end end end bM._controlsDirty=true local b8=bM.Scale.Scale if b4 then bZ.AutomaticSize=Enum.AutomaticSize.None bZ.Size=UDim2.new(1,0,0,bZ.AbsoluteSize.Y/b8)ah(bZ,{Size=UDim2.new(1,0,0,0)},b7,Enum.EasingStyle.Quint)else ah(bZ,{Size=UDim2.new(1,0,0,b_.AbsoluteSize.Y/b8)},b7,Enum.EasingStyle.Quint)local function b9()if b2==b6 and not b1 then bZ.AutomaticSize=Enum.AutomaticSize.Y bZ.Size=UDim2.new(1,0,0,0)end end if b7>0 then task.delay(b7,b9)else b9()end end local b9=b5 and 0 or 0.3 if b4 then local function ca()if b2==b6 and b1 then bY.Visible=false bR.Visible=false end end if b7>0 then task.delay(b7,ca)else ca()end else bY.Visible=true bR.Visible=true end ah(bT,{Rotation=b4 and-90 or 0},b9,Enum.EasingStyle.Quint)end local function b4(b5)local b6=b5 and 0.15 or 0.25 ah(bT,{ImageColor3=b5 and z.Text or z.Muted},b6)if bW and not E then ah(bW,{ImageTransparency=b5 and 0 or 0.45},b6)end end bQ.MouseEnter:Connect(function()b4(true)end)bQ.MouseLeave:Connect(function()b4(false)end)local b5=ay(bQ,function()return bP:FindFirstAncestorWhichIsA('ScrollingFrame')end)local b6,b7=false,0 local b8,b9,ca,cb,cc local cd,ce,cf,cg=nil,nil,false,false local ch=false local function ci()return math.max(bM.Scale.Scale,0.05)end local function cj(ck)return(ck-bM._popLayer.AbsolutePosition)/ci()end local function ck(cl,cm,cn)local co=bM._popLayer.AbsoluteSize/ci()local cp=8 local cq=math.clamp(cl.X,cm/2+cp,math.max(co.X-cm/2-cp,cm/2+cp))local cr=math.clamp(cl.Y,cp,math.max(co.Y-math.min(cn,120)-cp,cp))return Vector2.new(cq,cr)end local function cl()for cm,cn in ipairs(b0._items)do if cn._onHide then cn._onHide()end if cn.Open and type(cn.SetOpen)=='function'then cn:SetOpen(false)end end end local function cm(cn)if bW then aq(bW,cn and'minimize-2'or'picture-in-picture-2')end end local function cn()if b6 or not bU or not bP.Parent or b0._destroyed then return end if b0._settleDock then b0._settleDock()end local co=bM:_popoutLayer()b6=true b0._popped=true b7+=1 local cp=b7 cl()bM:_closePopups()local cq=ci()local cr=bP.Parent local cs=cj(bP.AbsolutePosition)local ct=bP.AbsoluteSize.X/cq local cu=bP.AbsoluteSize.Y/cq cb=ai('TextButton',{Size=UDim2.new(1,0,0,cu),BackgroundColor3=z.Surface2,BackgroundTransparency=0.6,BorderSizePixel=0,Text='',AutoButtonColor=false,ClipsDescendants=true,LayoutOrder=bP.LayoutOrder,Parent=cr})cb:SetAttribute('NoDrag',true)aj(cb,UDim.new(0,10))ak(cb,z.Stroke,1).Transparency=0.3 local cv=am({Size=UDim2.new(1,-24,0,40),Position=UDim2.fromOffset(12,0),Text=k._rich(b0.Name)..'<font transparency="0.4">  \u{b7}  popped out, click to dock</font>',TextSize=12,FontFace=D.Regular,TextColor3=z.Muted,TextXAlignment=Enum.TextXAlignment.Center,RichText=true,TextTransparency=1,Parent=cb})local cw=cb cb.MouseEnter:Connect(function()ah(cw,{BackgroundTransparency=0.35},0.15)end)cb.MouseLeave:Connect(function()ah(cw,{BackgroundTransparency=0.6},0.25)end)cb.MouseButton1Click:Connect(function()if cb==cw then b0:Dock()end end)ah(cb,{Size=UDim2.new(1,0,0,40)},0.42,Enum.EasingStyle.Quint)ah(cv,{TextTransparency=0},0.3)cb.Visible=bP.Visible b8=ai('Frame',{Name='PopOut',AnchorPoint=Vector2.new(0.5,0),Position=UDim2.fromOffset(cs.X+ct/2,cs.Y),Size=UDim2.fromOffset(ct,cu),BackgroundTransparency=1,Parent=co})b8:SetAttribute('NoDrag',true)b9=ai('UIScale',{Parent=b8})ca=ai('ImageLabel',{Position=UDim2.fromOffset(-24,-18),Size=UDim2.new(1,48,1,44),BackgroundTransparency=1,Image=A.Shadow,ImageColor3=Color3.new(0,0,0),ImageTransparency=1,ScaleType=Enum.ScaleType.Slice,SliceCenter=Rect.new(49,49,450,450),ZIndex=0,Parent=b8})table.insert(bM._popPanels,b8)bP.Parent=b8 bM._controlsDirty=true cm(true)local cx=ck(b0._popSpot or Vector2.new(cs.X+ct/2+22,cs.Y-14),ct,cu)ch=true b9.Scale=0.97 ah(b8,{Position=UDim2.fromOffset(cx.X,cx.Y)},0.5,Enum.EasingStyle.Quint)ah(b9,{Scale=1},0.55,Enum.EasingStyle.Back)ah(ca,{ImageTransparency=0.35},0.4)task.delay(0.5,function()if b7==cp then ch=false end end)local cy=b8 cc=bM:_listen('Render',function()if b8~=cy or not cy.Parent then return end local cz=bP.AbsoluteSize.Y/ci()if math.abs(cy.Size.Y.Offset-cz)>0.5 then cy.Size=UDim2.fromOffset(cy.Size.X.Offset,cz)end cy.Visible=bP.Visible if cb then cb.Visible=bP.Visible end if not ch and not cd then local cA=Vector2.new(cy.Position.X.Offset,cy.Position.Y.Offset)local cB=ck(cA,cy.Size.X.Offset,cz)if(cB-cA).Magnitude>0.5 then cy.Position=UDim2.fromOffset(cB.X,cB.Y)end end end)end local function co(cp)if not b6 then return end b6=false b0._popped=false b7+=1 cd,cf,cg=nil,false,false cl()bM:_closePopups()local cq,cr,cs,ct,cu=b8,cb,cc,b9,ca b8,cb,cc=nil,nil,nil cm(false)b0._popSpot=Vector2.new(cq.Position.X.Offset,cq.Position.Y.Offset)local cv=false local function cw()if cv then return end cv=true if b0._settleDock==cw then b0._settleDock=nil end if cs then cs()end local cx=table.find(bM._popPanels,cq)if cx then table.remove(bM._popPanels,cx)end if bP.Parent==cq then if cr and cr.Parent and not b0._destroyed then bP.Parent=cr.Parent bP.LayoutOrder=cr.LayoutOrder end end if cr then cr:Destroy()end if bP.Parent~=cq then cq:Destroy()end ch=false bM._controlsDirty=true end b0._settleDock=cw local cx=not cp and cr and cr.Parent and bM.Root.Visible and bP.Visible and cr.AbsoluteSize.X>0 and a3(cr,bM.Body,cr.AbsolutePosition+cr.AbsoluteSize/2)if not cx then cw()return end ch=true local cy=ci()local cz=bP.AbsoluteSize.Y/cy local cA=cr.AbsoluteSize.X/cy ah(cr,{Size=UDim2.new(1,0,0,cz)},0.36,Enum.EasingStyle.Quint)local cB=cr:FindFirstChildWhichIsA('TextLabel')if cB then ah(cB,{TextTransparency=1},0.12)end local cC=cj(cr.AbsolutePosition)ah(cq,{Position=UDim2.fromOffset(cC.X+cA/2,cC.Y),Size=UDim2.fromOffset(cA,cz)},0.36,Enum.EasingStyle.Quint)ah(ct,{Scale=1},0.2)ah(cu,{ImageTransparency=1},0.3)task.delay(0.37,cw)end bQ.InputBegan:Connect(function(cp)if not b6 or not aw(cp)or not b8 then return end cd=Vector2.new(cp.Position.X,cp.Position.Y)ce=Vector2.new(b8.Position.X.Offset,b8.Position.Y.Offset)cf=false cg=false end)bM:_listen('Changed',function(cp)if not cd or not b8 or not aA(cp)then return end local cq=Vector2.new(cp.Position.X,cp.Position.Y)-cd if not cf then if cq.Magnitude<(E and 8 or 5)then return end cf,cg=true,true ch=false cl()bM:_closePopups()ah(b9,{Scale=1.025},0.18,Enum.EasingStyle.Quint)ah(ca,{ImageTransparency=0.15},0.18)end local cr=ck(ce+cq/ci(),b8.Size.X.Offset,b8.Size.Y.Offset)b8.Position=UDim2.fromOffset(cr.X,cr.Y)end,b0)bM:_listen('Ended',function(cp)if not cd or not aw(cp)then return end cd=nil if cf and b8 then cf=false ah(b9,{Scale=1},0.4,Enum.EasingStyle.Back)ah(ca,{ImageTransparency=0.35},0.3)b0._popSpot=Vector2.new(b8.Position.X.Offset,b8.Position.Y.Offset)end end,b0)if bV then bV.MouseEnter:Connect(function()ah(bV,{BackgroundTransparency=0},0.15)ah(bW,{ImageColor3=z.Text},0.15)end)bV.MouseLeave:Connect(function()ah(bV,{BackgroundTransparency=1},0.25)ah(bW,{ImageColor3=z.Muted},0.25)end)bV.MouseButton1Click:Connect(function()if b6 then co()else cn()end end)end bQ.MouseButton1Click:Connect(function()if cg then cg=false return end if b5()then b3(not b1)end end)function b0:PopOut()cn()end function b0:Dock()co()end function b0:IsPoppedOut()return b6 end function b0:SetCollapsed(cp)b3(cp)end function b0:Collapse()b3(true)end function b0:Expand()b3(false)end function b0:IsCollapsed()return b1 end function b0:SetTitle(cp)b0.Name=tostring(cp)bX.Text=b0.Name end b0._userVisible=bK.Visible~=false function b0:IsVisible()return b0._userVisible end function b0:SetVisible(cp)cp=cp and true or false if cp==b0._userVisible then return end b0._userVisible=cp if not cp then for cq,cr in ipairs(b0._items)do if cr._onHide then cr._onHide()end if cr.Open and type(cr.SetOpen)=='function'then cr:SetOpen(false)end end end bP.Visible=cp bM._controlsDirty=true end if not b0._userVisible then bP.Visible=false end function b0:Destroy()for cp=#b0._items,1,-1 do local cq=b0._items[cp]if type(cq.Destroy)=='function'then cq:Destroy()end end local cp=b0.Parent local cq=table.find(cp._groupboxes,b0)if cq then table.remove(cp._groupboxes,cq)end bN.Counts[bO]=math.max(bN.Counts[bO]-1,0)co(true)b0._destroyed=true bM._controlsDirty=true bP:Destroy()end if bK.Collapsed then b3(true,true)end if bK.PoppedOut then task.defer(cn)end return b0 end local function bK(bL)return function(bM,bN,bO)bN=l(bN,{Title='Name'})bN.Side=bL return bM:Groupbox(bN,bO)end end aS.CreateGroupbox=aS.Groupbox aS.AddGroupbox=aS.Groupbox aS.AddLeftGroupbox=bK('Left')aS.AddRightGroupbox=bK('Right')function aS:ButtonRow(bL)local bM=type(bL)=='table'and(bL.Buttons or bL)or{}local bN=aM(self).Compact local bO=E and 34 or 30 local bP=aO(self,'Frame',bO+(bN and 4 or 14),{})local bQ=bN and 14 or 7 local bR=ai('Frame',{Position=UDim2.fromOffset(bQ,bN and 2 or 7),Size=UDim2.new(1,-bQ*2,0,bO),BackgroundTransparency=1,Parent=bP})local bS=math.max(#bM,1)local bT={Buttons={}}local bU={}for bV,bW in ipairs(bM)do if type(bW)=='string'then bW={Name=bW}end local bX=bW.Name or bW.Title or'Button'table.insert(bU,bX)local bY,bZ=bF(bR,bX,{Position=UDim2.new((bV-1)/bS,(bV-1)*6/bS,0,0),Size=UDim2.new(1/bS,-6*(bS-1)/bS,1,0)},function()aJ(bW.Callback)end)bZ.TextSize=13 if bW.Style=='Primary'then ah(bY,{BackgroundColor3=z.Accent,BackgroundTransparency=0.12},0)ah(bZ,{TextColor3=z.AccentDark},0)elseif bW.Style=='Danger'then ah(bZ,{TextColor3=z.Error},0)end bT.Buttons[bV]={Button=bY,Label=bZ}end function bT:SetText(bV,bW)local bX=bT.Buttons[bV]if bX then bX.Label.Text=tostring(bW)end end return m(self,{Name=table.concat(bU,' '),Visible=not(type(bL)=='table'and bL.Visible==false)},bT,bP,'ButtonRow')end local function bL(bM,bN,bO,bP)local bQ=E and 34 or 30 local bR=aO(bM,'Frame',bQ+4,{})local bS=aM(bM).Compact and 14 or 7 local bT local bU=bO and bF(bR,bO,{AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,-bS,0,2),Size=UDim2.fromOffset(0,bQ),AutomaticSize=Enum.AutomaticSize.X},function()aJ(bP,bT.Text)end)local bV=ai('Frame',{Position=UDim2.fromOffset(bS,2),Size=UDim2.new(1,-(bS*2+(bU and 70 or 0)),0,bQ),BackgroundColor3=z.Surface,BorderSizePixel=0,Parent=bR})aj(bV,UDim.new(0,6))local bW=ak(bV)bT=ai('TextBox',{Position=UDim2.fromOffset(8,0),Size=UDim2.new(1,-16,1,0),BackgroundTransparency=1,Text='',PlaceholderText=bN,PlaceholderColor3=z.Muted,TextColor3=z.Text,TextSize=13,FontFace=D.Regular,TextXAlignment=Enum.TextXAlignment.Center,TextTruncate=Enum.TextTruncate.AtEnd,ClearTextOnFocus=false,Parent=bV})bT.Focused:Connect(function()ah(bW,{Color=z.StrokeHover},0.15)end)bT.FocusLost:Connect(function(bX)ah(bW,{Color=z.Stroke},0.2)if bX and bT.Text~=''then aJ(bP,bT.Text)end end)if bU then local function bX()local bY=bU.AbsoluteSize.X/bM.Window.Scale.Scale bV.Size=UDim2.new(1,-(bS*2+bY+6),0,bQ)end bU:GetPropertyChangedSignal('AbsoluteSize'):Connect(bX)task.defer(bX)end return m(bM,{Name=bN},{Get=function()return bT.Text end,Set=function(bX,bY)bT.Text=tostring(bY or'')end},bR,'ActionInput')end local function bM(bN)return(tostring(bN or''):match('^%s*(.-)%s*$'))end local function bN(bO,bP,bQ,bR)if bO._groupbox then return bO end local bS=bO:Groupbox({Name=bP.Name or bQ,Icon=bP.Icon or bR,Side=bP.Side})bS._manager=true return bS end function aS:ConfigManager(bO)bO=l(bO,{Title='Name'})local bP=bN(self,bO,'Configs','folder')local bQ=self.Window local bR={}local bS,bT,bU local function bV(bW,bX,bY)bQ:Notify({Title=bX,Content=bY,Type=bW and'Success'or'Error',Duration=3})end local function bW()bT:Set(('loaded: %s   |   autoload: %s'):format(bQ.LoadedConfig or'none',bQ:GetAutoload()or'none'))end local function bX()local bY=bS:Get()if not bY then bV(false,'No config selected','Pick one from the list first')end return bY end local bY=bL(bP,bO.Placeholder or'config name',nil,function(bY)bR:Create(bY)end)local bZ=bQ:ListConfigs()local b_=bQ.LoadedConfig or bQ:GetAutoload()bS=bP:Dropdown({Stacked=true,Options=bZ,Default=table.find(bZ,b_)and b_ or nil,EmptyText='--',NoneText='--'})bP:ButtonRow({{Name='Create',Callback=function()bR:Create(bY:Get())end},{Name='Save',Callback=function()bR:Save()end}})bP:ButtonRow({{Name='Load',Callback=function()bR:Load()end},{Name='Delete',Style='Danger',Callback=function()bR:Delete()end}})bP:ButtonRow({{Name='Set autoload',Callback=function()bR:SetAutoload()end},{Name='Clear autoload',Callback=function()bR:ClearAutoload()end}})bP:ButtonRow({{Name='Rename',Callback=function()bR:Rename(nil,bY:Get())end},{Name='Reset',Style='Danger',Callback=function()bR:Reset()end}})bT=bP:Label('loaded: none   |   autoload: none')bU=bP:Dropdown({Name='Autoload mode',Stacked=true,Options={'All accounts','This account'},Default=bQ:GetAutoloadMode()=='Account'and'This account'or'All accounts',AllowNone=false,Callback=function(b0)bR:SetAutoloadMode(b0=='This account'and'Account'or'Global')end})bP:Button({Name='Refresh list',Callback=function()bR:Refresh()end})bP:Divider({Text='share'})bP:Button({Name='Copy code',Callback=function()bR:Export()end})local b0=bL(bP,'paste a config code...',nil,function(b0)bR:Import(b0)end)bP:Button({Name='Import code',Callback=function()bR:Import(b0:Get())end})function bR:Refresh()local b1=bQ:ListConfigs()local b2=bS:Get()bS:Refresh(b1,true)if b2 and not table.find(b1,b2)then bS:Set(bQ.LoadedConfig and table.find(b1,bQ.LoadedConfig)and bQ.LoadedConfig or nil,true)end bW()end local function b1(b2)bR:Refresh()bS:Set(b2,true)end function bR:Create(b2)b2=bM(b2)if b2==''then bV(false,'Name the config','Type a name before creating it')return end if not bi(b2)then bV(false,'Invalid name','Names cannot contain \\ / : * ? " < > |')return end local b3,b4=bQ:SaveConfig(b2)if b3 then bQ.LoadedConfig=b2 bY:Set('')b1(b2)end bV(b3,b3 and'Config created'or'Create failed',b3 and b2 or tostring(b4))end function bR:Save(b2)b2=b2 or bS:Get()if not b2 then local b3=bM(bY:Get())if b3==''then bV(false,'No config selected','Pick one from the list or type a name')return end return bR:Create(b3)end local b3,b4=bQ:SaveConfig(b2)if b3 then bQ.LoadedConfig=b2 bW()end bV(b3,b3 and'Config saved'or'Save failed',b3 and b2 or tostring(b4))end function bR:Load(b2)b2=b2 or bX()if not b2 then return end local b3,b4=bQ:LoadConfig(b2)bV(b3,b3 and'Config loaded'or'Load failed',b3 and b2 or tostring(b4))end function bR:Delete(b2)b2=b2 or bX()if not b2 then return end bQ:Confirm({Title='Delete config',Content='Remove '..b2..'? This cannot be undone.',Icon='trash-2',ConfirmText='Delete',Callback=function()local b3,b4=bQ:DeleteConfig(b2)if b3 then if bQ:GetAutoload('Account')==b2 then bQ:SetAutoload(nil,'Account')end if bQ:GetAutoload('Global')==b2 then bQ:SetAutoload(nil,'Global')end bS:Set(nil,true)end bR:Refresh()bV(b3,b3 and'Config deleted'or'Delete failed',b3 and b2 or tostring(b4))end})end function bR:Rename(b2,b3)b2=b2 or bX()if not b2 then return end b3=bM(b3)if b3==''then bV(false,'Name the config','Type the new name in the name box')return end if not bi(b3)then bV(false,'Invalid name','Names cannot contain \\ / : * ? " < > |')return end local b4,b5=bQ:RenameConfig(b2,b3)if b4 then bY:Set('')b1(b3)end bV(b4,b4 and'Config renamed'or'Rename failed',b4 and(b2..' -> '..b3)or tostring(b5))end function bR:Reset()bQ:Confirm({Title='Reset settings',Content=[[Put every setting back to its default and delete this script's folder? Saved configs, themes and autoload are removed for good.]],Icon='rotate-ccw',ConfirmText='Reset',Callback=function()bQ:ResetConfig()local b2=bQ:ClearWorkspace()bQ:_applyDefaultTheme()bS:Set(nil,true)bR:Refresh()bU:Set('All accounts',true)bV(b2,b2 and'Settings reset'or'Reset incomplete',b2 and'Everything is back to its default'or'Some files in '..bQ.ConfigFolder..' could not be deleted')end})end function bR:SetAutoload(b2)b2=b2 or bX()if not b2 then return end local b3,b4=bQ:SetAutoload(b2)bV(b3,b3 and'Autoload set'or'Autoload failed',b3 and b2 or tostring(b4))end function bR:ClearAutoload()local b2=bQ:GetAutoload()if not b2 then bV(false,'No autoload','Nothing is set to autoload')return end local b3,b4=bQ:SetAutoload(nil)bV(b3,b3 and'Autoload cleared'or'Clear failed',b3 and b2 or tostring(b4))end function bR:ToggleAutoload(b2)b2=b2 or bX()if not b2 then return end if bQ:GetAutoload()==b2 then bR:ClearAutoload()else bR:SetAutoload(b2)end end function bR:SetAutoloadMode(b2)local b3,b4=bQ:SetAutoloadMode(b2)local b5=b2=='Account'and'This account'or'All accounts'if bU:Get()~=b5 then bU:Set(b5,true)end bV(b3~=false,b3~=false and'Autoload mode'or'Mode change failed',b3~=false and b5 or tostring(b4))end function bR:Export(b2)local b3,b4=bQ:ExportConfig(b2)if not b3 then bV(false,'Export failed',tostring(b4))return nil end bQ:CopyToClipboard(b3,'Config code')return b3 end function bR:Import(b2)b2=bM(b2)if b2==''then bV(false,'Nothing to import','Paste a config code first')return end local b3,b4=bQ:DecodeConfig(b2)if not b3 then bV(false,'Import failed','Invalid config code')return end local b5=bM(bY:Get())if b5==''then b5=nil if bi(b4.Name)then b5=b4.Name local b6=2 while bQ:ConfigExists(b5)do b5=('%s (%d)'):format(b4.Name,b6)b6+=1 end end elseif not bi(b5)then bV(false,'Invalid name','Names cannot contain \\ / : * ? " < > |')return end local function b6()local b7,b8=bQ:ImportConfig(b2,b5,true)if b7 then b0:Set('')if b5 then bY:Set('')b1(b5)end end bV(b7,b7 and'Config imported'or'Import failed',b7 and(b5 or'Applied to current settings')or tostring(b8))end if b4.Folder and b4.Folder~=bQ.ConfigFolder then bQ:Confirm({Title='Different script',Content=([[This config was made for %s. Import it anyway? Only matching settings are applied.]]):format(b4.Folder),Icon='triangle-alert',ConfirmText='Import',Callback=b6})return end b6()end local b2=bQ:OnConfigChanged(function()bR:Refresh()if bQ.LoadedConfig and bS:Get()==nil then bS:Set(bQ.LoadedConfig,true)end end)bT._listeners=bT._listeners or{}table.insert(bT._listeners,b2)bW()return bR end local bO={'Midnight','Nebula','Synthwave','Sakura','Velvet','Rose','Crimson','Sunset','Amber','Gold','Cyber','Toxic','Matcha','Emerald','Aurora','Ocean','Frost','Abyss','Mono','Halloween','Haunted','Christmas','Valentine','Lunar','Tropical','Dracula','Coffee'}local function bP()local bQ,bR={},{}for bS,bT in ipairs(bO)do if k.ThemePresets[bT]then table.insert(bQ,bT)bR[bT]=true end end local bS={}for bT in pairs(k.ThemePresets)do if not bR[bT]then table.insert(bS,bT)end end table.sort(bS)for bT,bU in ipairs(bS)do table.insert(bQ,bU)end return bQ end function aS:ThemeManager(bQ)bQ=l(bQ,{Title='Name'})local bR=bN(self,bQ,'Themes','palette')local bS=self.Window local bT={}local bU,bV,bW,bX local bY,bZ,b_,b0,b1,b2 local b3,b4,b5,b6 local b7,b8,b9,ca local function cb(cc,cd,ce)bS:Notify({Title=cd,Content=ce,Type=cc and'Success'or'Error',Duration=3})end local function cc()local cd=bS:GetDefaultTheme()bV:Set('Default theme: '..(cd or'none'))local ce=bU:Get()or bX:Get()bW:SetText(2,(ce and ce==cd)and'Clear Default'or'Set Default')end local function cd()local ce=bU:Get()if not ce then cb(false,'No theme selected','Pick one from the list first')end return ce end bX=bR:Dropdown({Name='Preset',Options=bP(),Default=k.ThemePresets[k.ThemeName or'']and k.ThemeName or nil,NoneText='custom',AllowNone=false,Callback=function(ce)if ce then k:SetTheme(ce)bU:Set(nil,true)cc()end end})local ce={None='None',Snow='Snow',Rain='Rain',Ember='Hell Fire',Sakura='Sakura',Fireflies='Fireflies',Matrix='Matrix'}if bS._backdrop and bQ.Weather~=false then bY=bR:Dropdown({Name='Weather',Options={'Snow','Rain','Hell Fire','Sakura','Fireflies','Matrix','None'},Default=ce[bS.Weather]or'None',AllowNone=false,Callback=function(cf)if cf then bS:SetWeather(cf)end end})end if bS._backdrop and bQ.Weather~=false then bZ=bR:Dropdown({Name='Weather Mode',Options={'Screen','UI'},Default=bS.WeatherMode,AllowNone=false,Callback=function(cf)if cf then bS:SetWeatherMode(cf)end end})end if bS._backdrop and bQ.Dim~=false then b_=bR:Toggle({Name='Dim',Default=bS._backdropDim,Callback=function(cf)bS:SetDim(cf)end})end if bQ.Transparent~=false then b0=bR:Toggle({Name='Transparent',Default=bS.Transparent==true,Callback=function(cf)bS:SetTransparent(cf)end})end if bQ.DragSkeleton~=false and bQ.DragStyle~=false then b1=bR:Dropdown({Name='Drag Style',Options=k.DragStyles,Default=bS.DragStyle,AllowNone=false,Callback=function(cf)if cf then bS:SetDragStyle(cf)end end})end if bQ.IslandStyle~=false then b2=bR:Dropdown({Name='Dynamic Island',Options=k.IslandStyles,Default=bS.IslandStyle,AllowNone=false,Callback=function(cf)if cf then bS:SetIslandStyle(cf)end end})end if bQ.AdaptiveSize~=false then b9=bR:Toggle({Name='Adaptive Size',Default=bS:GetAdaptiveSize(),Callback=function(cf)bS:SetAdaptiveSize(cf)end})end if bQ.Scale~=false then b7=bR:Slider({Name='UI Scale',Min=60,Max=150,Increment=5,Default=math.floor(bS:GetUIScale()*100+0.5),Suffix='%',Callback=function(cf)if not(b7 and b7.Dragging)then bS:SetUIScale(cf/100)end end,OnRelease=function(cf)bS:SetUIScale(cf/100)end})end if bQ.Density~=false then b8=bR:Dropdown({Name='Density',Options={'Compact','Default','Comfortable'},Default=k.Density,AllowNone=false,Callback=function(cf)if cf then k:SetDensity(cf)end end})end if bQ.CornerRadius~=false then ca=bR:Slider({Name='Corner Radius',Min=0,Max=20,Increment=1,Default=k:GetCornerRadius(),Suffix='px',Callback=function(cf)k:SetCornerRadius(cf)end})end if bQ.Background~=false then b6=function(cf)if cf==nil or cf==''then return'None'end return table.find(bS:ListBackgrounds(),cf)and cf or nil end local function cf(cg,ch)task.spawn(function()local ci,cj=bS:SetBackground(cg)if ci and not ch then b3:Set(b6(bS.Background),true)elseif not ci and cj~='replaced by a newer background'then cb(false,'Background failed',tostring(cj))end end)end local cg=bS:ListBackgrounds()table.insert(cg,1,'None')b3=bR:Dropdown({Name='Background',Options=cg,Default=b6(bS.Background),NoneText='custom',AllowNone=false,Callback=function(ch)if ch then cf(ch,true)end end})b4=bL(bR,'image id or url','Set',function(ch)ch=bM(ch)if ch==''then cb(false,'No image','Paste an image id or link first')return end cf(ch)end)b5=bR:Slider({Name='Background Opacity',Min=0,Max=100,Default=math.floor((1-bS.BackgroundTransparency)*100+0.5),Suffix='%',Callback=function(ch)bS:SetBackgroundTransparency(1-ch/100)end})end local cf=bL(bR,bQ.Placeholder or'theme name','Create',function(cf)bT:Create(cf)end)bU=bR:Dropdown({Name='Theme',Options=bS:ListThemes(),Default=(function()local cg=bS:GetDefaultTheme()return cg and not k.ThemePresets[cg]and cg or nil end)(),EmptyText='no themes',NoneText='select',Callback=function()cc()end})bR:ButtonRow({{Name='Save',Callback=function()bT:Save()end},{Name='Load',Callback=function()bT:Load()end}})bW=bR:ButtonRow({{Name='Delete',Callback=function()bT:Delete()end},{Name='Set Default',Callback=function()bT:ToggleDefault()end}})bV=bR:Label('Default theme: none')function bT:Refresh()bU:Refresh(bS:ListThemes(),true)if b3 then local cg=bS:ListBackgrounds()table.insert(cg,1,'None')b3:Refresh(cg,true,true)end cc()end function bT:Create(cg)cg=bM(cg)if cg==''then cb(false,'Name the theme','Type a name before creating it')return end if k.ThemePresets[cg]then cb(false,'Name taken',cg..' is a built-in preset')return end local ch,ci=bS:SaveTheme(cg)bT:Refresh()if ch then bU:Set(cg,true)cf:Set('')cc()end cb(ch,ch and'Theme created'or'Create failed',ch and cg or tostring(ci))end function bT:Save(cg)cg=cg or cd()if not cg then return end local ch,ci=bS:SaveTheme(cg)cb(ch,ch and'Theme saved'or'Save failed',ch and cg or tostring(ci))end function bT:Load(cg)cg=cg or cd()if not cg then return end local ch,ci=bS:LoadTheme(cg)if ch then bX:Set(nil,true)end cb(ch~=false,ch and'Theme loaded'or'Load failed',ch and cg or tostring(ci))end function bT:Delete(cg)cg=cg or cd()if not cg then return end bS:Confirm({Title='Delete theme',Content='Remove '..cg..'? This cannot be undone.',Icon='trash-2',ConfirmText='Delete',Callback=function()local ch,ci=bS:DeleteTheme(cg)bT:Refresh()cb(ch,ch and'Theme deleted'or'Delete failed',ch and cg or tostring(ci))end})end function bT:ToggleDefault(cg)cg=cg or bU:Get()or bX:Get()if not cg then cb(false,'Nothing selected','Pick a theme or a preset first')return end local ch=bS:GetDefaultTheme()==cg local ci,cj=bS:SetDefaultTheme(not ch and cg or nil)cc()cb(ci~=false,ch and'Default cleared'or'Default theme set',ci~=false and cg or tostring(cj))end if bQ.Customize~=false then bR:Divider()local cg=bQ.Colors or{{'Accent','Accent'},{'Background','Background'},{'Surface2','Surface'},{'Text','Text'},{'Muted','Muted text'}}for ch,ci in ipairs(cg)do local cj,ck=ci[1],ci[2]or ci[1]local cl,cm=nil,false local cn cn=bR:ColorPicker({Name=ck,Default=z[cj],Callback=function(co)cl=co if cm then return end cm=true task.delay(0.08,function()cm=false k:SetTheme({[cj]=cl},true)bX:Set(nil,true)end)end})table.insert(k._themeListeners,function()if cn.Value~=z[cj]then cn:Set(z[cj],true)end end)end end if bQ.Flag~=false then local cg=type(bQ.Flag)=='string'and bQ.Flag or'__Theme'local ch={_type='Theme',_searchName='Theme',_searchKey='theme',_listeners={}}function ch:Get()local ci={}for cj,ck in ipairs(n)do ci[ck]=bc(z[ck])end return{Name=bX:Get()or bU:Get(),Colors=ci,Weather=bY and bS.Weather or nil,WeatherMode=bZ and bS.WeatherMode or nil,Dim=if b_ then bS._backdropDim==true else nil,Transparent=if b0 then bS.Transparent==true else nil,DragStyle=b1 and bS.DragStyle or nil,IslandStyle=b2 and bS.IslandStyle or nil,CornerRadius=ca and k:GetCornerRadius()or nil,UIScale=b7 and bS:GetUIScale()or nil,AdaptiveSize=if b9 then bS:GetAdaptiveSize()else nil,Density=b8 and k.Density or nil,Background=b3 and(bS.Background or'')or nil,BackgroundTransparency=b3 and bS.BackgroundTransparency or nil}end function ch:Set(ci)if type(ci)~='table'then return end if type(ci.Colors)=='table'then k:SetTheme(ci.Colors)end local cj=type(ci.Name)=='string'and ci.Name or nil if cj and k.ThemePresets[cj]then k.ThemeName=cj bX:Set(cj,true)bU:Set(nil,true)else if cj then k.ThemeName=cj end bX:Set(nil,true)bU:Set(cj and table.find(bS:ListThemes(),cj)and cj or nil,true)end if bY and type(ci.Weather)=='string'then bS:SetWeather(ci.Weather)bY:Set(ce[bS.Weather]or'None',true)end if bZ and type(ci.WeatherMode)=='string'then bS:SetWeatherMode(ci.WeatherMode)bZ:Set(bS.WeatherMode,true)end if b_ and type(ci.Dim)=='boolean'then bS:SetDim(ci.Dim)b_:Set(ci.Dim,true)end if b0 and type(ci.Transparent)=='boolean'then bS:SetTransparent(ci.Transparent)b0:Set(ci.Transparent,true)end if b1 and type(ci.DragStyle)=='string'then b1:Set(bS:SetDragStyle(ci.DragStyle),true)elseif b1 and type(ci.DragSkeleton)=='boolean'then bS:SetDragSkeleton(ci.DragSkeleton)b1:Set(bS.DragStyle,true)end if b2 and type(ci.IslandStyle)=='string'then b2:Set(bS:SetIslandStyle(ci.IslandStyle),true)end if ca and tonumber(ci.CornerRadius)then ca:Set(k:SetCornerRadius(ci.CornerRadius),true)end if b9 and type(ci.AdaptiveSize)=='boolean'then bS:SetAdaptiveSize(ci.AdaptiveSize)b9:Set(ci.AdaptiveSize,true)end if b7 and tonumber(ci.UIScale)then bS:SetUIScale(tonumber(ci.UIScale))b7:Set(math.floor(bS:GetUIScale()*100+0.5),true)end if b8 and type(ci.Density)=='string'then b8:Set(k:SetDensity(ci.Density),true)end if b3 and tonumber(ci.BackgroundTransparency)then bS:SetBackgroundTransparency(tonumber(ci.BackgroundTransparency))b5:Set(math.floor((1-bS.BackgroundTransparency)*100+0.5),true)end if b3 and type(ci.Background)=='string'and ci.Background~=(bS.Background or'')then local ck=ci.Background b3:Set(b6(ck),true)task.spawn(bS.SetBackground,bS,ck)end cc()end k.Flags[cg]=ch bS:_flagCreated(cg,ch)end bS._workspaceListeners=bS._workspaceListeners or{}table.insert(bS._workspaceListeners,function()bU:Set(nil,true)bT:Refresh()end)cc()return bT end aS.CreateButtonRow=aS.ButtonRow aS.CreateConfigManager=aS.ConfigManager aS.CreateThemeManager=aS.ThemeManager local bQ={Plain=22,Row=24,Badge=28,Dot=24,Bar=38,Stat=46}local function bR(bS)return k._color(bS)or z.Accent end local function bS(bT)if bT==math.floor(bT)then return tostring(math.floor(bT))end return string.format('%.1f',bT)end local function bT(bU,bV)if type(bU)=='number'and type(bV)=='number'then return bU,bV end if type(bU)=='string'then local bW=(bU:gsub(',',''))local bX,bY=bW:match('^%s*(%-?[%d%.]+)%s*/%s*(%-?[%d%.]+)')if bX then return tonumber(bX),tonumber(bY)end end return nil,nil end function aS:Status(bU)bU=l(bU,{Title='Name',Text='Value',Content='Value',CurrentValue='Value',Default='Value'})local bV=bQ[bU.Style]and bU.Style or'Plain'local bW=aM(self).Compact local bX=self.Window local bY=bQ[bV]local bZ=bW and 0 or 8 local b_=aO(self,'Frame',bY+bZ*2,bU)local b0=ai('Frame',{Position=UDim2.fromOffset(14,bZ),Size=UDim2.new(1,-28,0,bY),BackgroundTransparency=1,Parent=b_})local b1={Value=bU.Value,Max=bU.Max,Tone=bU.Tone or'Accent',Name=bU.Name or'',Color=bU.Color or bU.ValueColor}local b2,b3,b4,b5,b6,b7,b8 local b9=false local function ca()return bV=='Plain'and(b1.Name..':')or b1.Name end if bV=='Plain'then ai('UIListLayout',{FillDirection=Enum.FillDirection.Horizontal,VerticalAlignment=Enum.VerticalAlignment.Center,SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,5),Parent=b0})b2=am({Size=UDim2.new(0,0,1,0),AutomaticSize=Enum.AutomaticSize.X,TextSize=12,FontFace=D.Regular,TextColor3=z.Muted,TextTruncate=Enum.TextTruncate.None,LayoutOrder=1,Parent=b0})b3=am({Size=UDim2.new(0,0,1,0),AutomaticSize=Enum.AutomaticSize.X,TextSize=12,TextColor3=z.Text,TextTruncate=Enum.TextTruncate.None,LayoutOrder=2,Parent=b0})elseif bV=='Stat'then b2=am({Position=UDim2.fromOffset(0,3),Size=UDim2.new(1,0,0,14),TextSize=11,TextColor3=z.Muted,Parent=b0})b3=am({Position=UDim2.fromOffset(0,18),Size=UDim2.new(1,0,0,24),TextSize=20,FontFace=D.Bold,TextColor3=z.Text,Parent=b0})else local cb=0 if bV=='Dot'then cb=18 b7=ai('Frame',{AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.new(0,5,0.5,0),Size=UDim2.fromOffset(8,8),BackgroundColor3=bR(b1.Tone),BackgroundTransparency=0.4,BorderSizePixel=0,Parent=b0})aj(b7,UDim.new(1,0))b6=ai('Frame',{AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.new(0,5,0.5,0),Size=UDim2.fromOffset(8,8),BackgroundColor3=bR(b1.Tone),BorderSizePixel=0,Parent=b0})aj(b6,UDim.new(1,0))if bU.Pulse~=false then a:Create(b7,TweenInfo.new(1.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out,-1),{Size=UDim2.fromOffset(20,20),BackgroundTransparency=1}):Play()else b7.Visible=false end end local cc=bV=='Bar'and 18 or bY b2=am({Position=UDim2.fromOffset(cb,0),Size=UDim2.new(0.55,-cb,0,cc),TextSize=12,FontFace=D.Regular,TextColor3=z.Muted,Parent=b0})if bV=='Badge'then b9=true b4=ai('Frame',{AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,0,0.5,0),Size=UDim2.fromOffset(0,22),AutomaticSize=Enum.AutomaticSize.X,BackgroundColor3=bR(b1.Tone),BackgroundTransparency=0.86,BorderSizePixel=0,Parent=b0})aj(b4,UDim.new(1,0))b5=ak(b4,bR(b1.Tone),0.6)al(b4,10,10)b3=am({Size=UDim2.new(0,0,1,0),AutomaticSize=Enum.AutomaticSize.X,TextSize=12,TextColor3=bR(b1.Tone),TextTruncate=Enum.TextTruncate.None,Parent=b4})else b3=am({AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,0,0,0),Size=UDim2.new(0.45,0,0,cc),TextSize=12,TextColor3=z.Text,TextXAlignment=Enum.TextXAlignment.Right,Parent=b0})end if bV=='Bar'then local cd=ai('Frame',{Position=UDim2.fromOffset(0,25),Size=UDim2.new(1,0,0,5),BackgroundColor3=z.Surface3,BorderSizePixel=0,ClipsDescendants=true,Parent=b0})aj(cd,UDim.new(1,0))b8=ai('Frame',{Size=UDim2.new(0,0,1,0),BackgroundColor3=bR(b1.Tone),BorderSizePixel=0,Parent=cd})aj(b8,UDim.new(1,0))end end local cb=nil local function cc(cd)b2.Text=k._rich(ca())local ce=b1.Value local cf=ce==nil and(bU.Placeholder or'-')or tostring(ce)if bV=='Bar'then local cg,ch=bT(ce,b1.Max)if cg and ch then b1.Max=ch cf=bS(cg)..' / '..bS(ch)local ci=ch>0 and math.clamp(cg/ch,0,1)or 0 ah(b8,{Size=UDim2.new(ci,0,1,0)},cd and 0.4 or 0,Enum.EasingStyle.Quint)elseif type(ce)=='number'and ce<=1 then cf=string.format('%d%%',math.floor(ce*100+0.5))ah(b8,{Size=UDim2.new(math.clamp(ce,0,1),0,1,0)},cd and 0.4 or 0,Enum.EasingStyle.Quint)end end cf=k._rich((bU.Prefix or'')..cf..(bU.Suffix or''))local cg=cb~=nil and cf~=cb cb=cf b3.Text=cf local ch=bR(b1.Tone)local ci=cd and 0.25 or 0 local cj=not b9 and k._color(b1.Color)or z.Text if not b9 and not(cg and cd and bU.Flash~=false)then ah(b3,{TextColor3=cj},ci)end if b4 then ah(b4,{BackgroundColor3=ch},ci)ah(b5,{Color=ch},ci)ah(b3,{TextColor3=ch},ci)end if b6 then ah(b6,{BackgroundColor3=ch},ci)ah(b7,{BackgroundColor3=ch},0)end if b8 then ah(b8,{BackgroundColor3=ch},ci)end if cg and cd and not b9 and bU.Flash~=false then ah(b3,{TextColor3=z.Accent},0.08)task.delay(0.1,function()if b3.Parent then ah(b3,{TextColor3=k._color(b1.Color)or z.Text},0.45)end end)end end b2.RichText=true b3.RichText=true ag(b0,function()if cb~=nil then cc(false)end end)function b1:Set(cd,ce)b1.Value=cd if ce~=nil then b1.Max=ce end cc(true)end function b1:Get()return b1.Value end function b1:SetTone(cd)b1.Tone=cd cc(true)end function b1:SetColor(cd)b1.Color=cd cc(true)end function b1:SetName(cd)b1.Name=tostring(cd)cc(false)end function b1:Text()return b3.Text end function b1._shownColor()if b1.Color~=nil then return k._color(b1.Color)or z.Text end if bV=='Badge'or bV=='Dot'or bV=='Bar'then return bR(b1.Tone)end return z.Text end b1._listeners={}if type(bU.Update)=='function'then local cd=math.max(tonumber(bU.UpdateRate)or 1,0.05)local ce=true table.insert(b1._listeners,function()ce=false end)task.spawn(function()while ce and b_.Parent do local cf,cg,ch=aK(bU.Update)if cf then if cg~=nil then b1.Value=cg end if type(ch)=='number'then b1.Max=ch elseif type(ch)=='string'or typeof(ch)=='Color3'then b1.Tone=ch end cc(true)else warn('[AirFlow] status update error: '..tostring(cg))end task.wait(cd)end end)function b1:SetUpdateRate(cf)cd=math.max(tonumber(cf)or cd,0.05)end end if bU.Pin then table.insert(bX._pinned,b1)table.insert(b1._listeners,function()local cd=table.find(bX._pinned,b1)if cd then table.remove(bX._pinned,cd)end end)end cc(false)return m(self,bU,b1,b_,'Status')end function aS:Statuses(bU,bV)local bW={}for bX,bY in ipairs(bU or{})do local bZ=type(bY)=='table'and table.clone(bY)or{Name=tostring(bY)}for b_,b0 in pairs(bV or{})do if bZ[b_]==nil then bZ[b_]=b0 end end local b_=self:Status(bZ)bW[bZ.Name or bZ.Title or bX]=b_ end return bW end function aS:StatusList(bU)bU=l(bU,{Title='Name'})local bV=aM(self).Compact local bW=self.Window local bX=math.max(math.floor(tonumber(bU.MaxRows)or 5),1)local bY=aO(self,'Frame',0,bU)bY.AutomaticSize=Enum.AutomaticSize.Y if bV then al(bY,14,14,6,8)else al(bY,14,14,11,12)end ai('UIListLayout',{SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,4),Parent=bY})local bZ=am({Size=UDim2.new(1,0,0,16),Text=string.upper(tostring(bU.Name or'')),TextSize=11,TextColor3=z.Muted,Visible=tostring(bU.Name or'')~='',LayoutOrder=1,Parent=bY})local b_=ai('ScrollingFrame',{Size=UDim2.new(1,0,0,0),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=2,ScrollBarImageColor3=z.Accent,ScrollBarImageTransparency=0.4,ScrollingDirection=Enum.ScrollingDirection.Y,AutomaticCanvasSize=Enum.AutomaticSize.Y,CanvasSize=UDim2.new(),ScrollingEnabled=false,LayoutOrder=2,Parent=bY})b_:SetAttribute('NoDrag',true)local b0=ai('Frame',{Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,BackgroundTransparency=1,Parent=b_})local b1=al(b0,0,0,0,0)ai('UIListLayout',{SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,2),Parent=b0})local b2=am({Size=UDim2.new(1,0,0,24),AutomaticSize=Enum.AutomaticSize.Y,Text=tostring(bU.EmptyText or'Nothing yet'),TextSize=13,LineHeight=1.1,FontFace=D.Regular,TextColor3=z.Muted,TextWrapped=true,TextTruncate=Enum.TextTruncate.None,LayoutOrder=0,Parent=b0})local b3,b4,b5,b6={},{},nil,{}local b7={_listeners={}}local function b8()if b7._destroyed then return end local b9=bW.Scale.Scale local ca=#b4 local cb=0 if ca==0 then cb=b2.AbsoluteSize.Y/b9 else local cc=math.min(ca,bX)for cd=1,cc do cb+=b3[cd].Frame.AbsoluteSize.Y/b9 end cb+=(cc-1)*2 end cb=math.ceil(cb)local cc=ca>bX b_.ScrollingEnabled=cc b1.PaddingRight=UDim.new(0,cc and 8 or 0)if b_.Size.Y.Offset~=cb then b_.Size=UDim2.new(1,0,0,cb)end local cd=math.max(b_.AbsoluteCanvasSize.Y-b_.AbsoluteWindowSize.Y,0)/b9 if b_.CanvasPosition.Y>cd then b_.CanvasPosition=Vector2.new(0,cd)end end local function b9(ca)if ca.Value.Visible then ca.Text.Size=UDim2.new(1,-(math.ceil(ca.Value.AbsoluteSize.X/bW.Scale.Scale)+12),0,24)else ca.Text.Size=UDim2.new(1,0,0,24)end end local function ca(cb)local cc=ai('Frame',{Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,BackgroundTransparency=1,LayoutOrder=cb,Parent=b0})local cd={Frame=cc,Text=am({Size=UDim2.new(1,0,0,24),AutomaticSize=Enum.AutomaticSize.Y,Text='',TextSize=13,LineHeight=1.1,FontFace=D.Regular,TextColor3=z.Muted,TextWrapped=true,TextTruncate=Enum.TextTruncate.None,RichText=true,Parent=cc}),Value=am({AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,0,0,0),Size=UDim2.new(0,0,0,24),AutomaticSize=Enum.AutomaticSize.X,Text='',TextSize=12,FontFace=D.Medium,TextColor3=z.Text,RichText=true,TextXAlignment=Enum.TextXAlignment.Right,TextTruncate=Enum.TextTruncate.None,Visible=false,Parent=cc})}cd.Connections={cc:GetPropertyChangedSignal('AbsoluteSize'):Connect(b8),cd.Value:GetPropertyChangedSignal('AbsoluteSize'):Connect(function()b9(cd)end)}return cd end local function cb(cc)if type(cc)=='table'then local cd=cc.Text or cc.Name or cc[1]local ce=cc.Tone or cc.Color return{Text=tostring(cd==nil and''or cd),Value=cc.Value~=nil and tostring(cc.Value)or nil,Tone=(type(ce)=='string'or typeof(ce)=='Color3')and ce or nil}end return{Text=tostring(cc)}end local function cc(cd)return cd.Text..'\0'..(cd.Value or'\1')..'\0'..tostring(cd.Tone or'')end local function cd(ce,cf)local cg=cc(cf)if ce.Key==cg then return end ce.Key=cg ce.Text.Text=k._rich(cf.Text)local ch=cf.Tone and k._color(cf.Tone)or nil if cf.Value then ce.Value.Text=k._rich(cf.Value)ce.Value.Visible=true ah(ce.Value,{TextColor3=ch or z.Text},0)ah(ce.Text,{TextColor3=z.Muted},0)else ce.Value.Visible=false ah(ce.Text,{TextColor3=ch or z.Muted},0)end b9(ce)end local function ce(cf)for cg,ch in ipairs(cf.Connections)do ch:Disconnect()end cf.Frame:Destroy()end function b7:Set(cf)if type(cf)~='table'or b7._destroyed then return end local cg,ch={},{}b6={}for ci,cj in ipairs(cf)do b6[ci]=type(cj)=='table'and table.clone(cj)or cj local ck=cb(cj)cg[ci]=ck ch[ci]=cc(ck)end local ci=table.concat(ch,'\2')..'#'..#cg if ci==b5 then return end b5=ci b4=cg for cj,ck in ipairs(b4)do local cl=b3[cj]if not cl then cl=ca(cj)b3[cj]=cl end cd(cl,ck)end for cj=#b3,#b4+1,-1 do ce(b3[cj])b3[cj]=nil end b2.Visible=#b4==0 b8()end function b7:Get()local cf={}for cg,ch in ipairs(b6)do cf[cg]=type(ch)=='table'and table.clone(ch)or ch end return cf end function b7:Clear()b7:Set({})end function b7:SetName(cf)cf=tostring(cf or'')bZ.Text=string.upper(cf)bZ.Visible=cf~=''b7._searchName=cf b7._searchKey=string.lower(cf)end local cf=math.max(tonumber(bU.UpdateRate)or 1,0.05)function b7:SetUpdateRate(cg)cf=math.max(tonumber(cg)or cf,0.05)end ag(b0,function()for cg,ch in ipairs(b3)do if b4[cg]then ch.Key=nil cd(ch,b4[cg])end end end)local cg=b2:GetPropertyChangedSignal('AbsoluteSize'):Connect(b8)table.insert(b7._listeners,function()b7._destroyed=true cg:Disconnect()for ch,ci in ipairs(b3)do for cj,ck in ipairs(ci.Connections)do ck:Disconnect()end end end)local function ch()if bW._destroyed or not bW.Open or bW.Minimized or not b7._userVisible then return false end local ci=self if ci._groupbox then if ci._userVisible==false then return false end ci=ci.Parent end if ci._isSubTab then if ci.Parent.CurrentSubTab~=ci then return false end ci=ci.Parent end return bW.CurrentTab==ci end if type(bU.Update)=='function'then local ci=true table.insert(b7._listeners,function()ci=false end)task.defer(function()local cj=true while ci and bY.Parent do if cj or ch()then cj=false local ck,cl=aK(bU.Update)if ck then if cl~=nil then b7:Set(cl)end else warn('[AirFlow] status list update error: '..tostring(cl))end end task.wait(cf)end end)end b7:Set(bU.Rows or{})return m(self,bU,b7,bY,'StatusList')end aS.CreateStatus=aS.Status aS.AddStatus=aS.Status aS.CreateStatuses=aS.Statuses aS.CreateStatusList=aS.StatusList aS.AddStatusList=aS.StatusList function aS:_mediaCard(bU,bV)bU=l(bU,{Title='Name',Description='Desc'})local bW=aM(self)local bX=bW.Compact local bY=math.clamp(tonumber(bU.Height)or bV,40,600)local bZ=bX and 14 or 8 local b_=type(bU.Name)=='string'and bU.Name~=''local b0=bX and 4 or 10 local b1=b_ and(b0+(bU.Desc and 38 or 22))or(bX and 4 or bZ)local b2=b1+bY+(bX and 6 or bZ)local b3,b4=aO(self,'Frame',b2,bU)aG(b3,b4)local b5,b6 if b_ then b5=am({Position=UDim2.fromOffset(14,b0),Size=UDim2.new(1,-28,0,bW.TitleHeight),Text=bU.Name,TextSize=bW.TextSize,Parent=b3})if bU.Desc then b6=am({Position=UDim2.fromOffset(14,b0+bW.TitleHeight+1),Size=UDim2.new(1,-28,0,bW.DescLine),Text=bU.Desc,TextSize=bW.DescSize,FontFace=D.Regular,TextColor3=z.Muted,Parent=b3})end end local b7=ai('Frame',{Position=UDim2.fromOffset(bZ,b1),Size=UDim2.new(1,-bZ*2,0,bY),BackgroundColor3=z.Surface3,BackgroundTransparency=0.5,BorderSizePixel=0,ClipsDescendants=true,Parent=b3})aj(b7,UDim.new(0,6))ak(b7,z.Stroke)local b8=ai('ImageLabel',{AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.fromScale(0.5,0.5),Size=UDim2.fromOffset(22,22),BackgroundTransparency=1,ImageColor3=z.Muted,ImageTransparency=0.3,ScaleType=Enum.ScaleType.Fit,Parent=b7})local b9=ai('Frame',{AnchorPoint=Vector2.new(0,1),Position=UDim2.fromScale(0,1),Size=UDim2.new(1,0,0,30),BackgroundColor3=Color3.new(0,0,0),BackgroundTransparency=0.35,BorderSizePixel=0,Visible=false,ZIndex=3,Parent=b7})ai('UIGradient',{Rotation=90,Transparency=NumberSequence.new(1,0),Parent=b9})local ca=am({Position=UDim2.fromOffset(10,8),Size=UDim2.new(1,-20,1,-10),TextSize=12,TextColor3=Color3.new(1,1,1),ZIndex=4,Parent=b9})local function cb(cc)cc=cc~=nil and tostring(cc)or''ca.Text=cc b9.Visible=cc~=''end cb(bU.Caption)return bU,{Frame=b3,Stroke=b4,Media=b7,Placeholder=b8,Title=b5,Desc=b6,SetCaption=cb}end function aS:Image(bU)local bV bU,bV=self:_mediaCard(bU,160)local bW=self.Window local bX=bV.Media aq(bV.Placeholder,'image')local function bY(bZ,b_)local b0,b1=pcall(function()return Enum.ScaleType[tostring(bZ)]end)return b0 and b1 or b_ end local bZ=ai('ImageLabel',{Size=UDim2.fromScale(1,1),BackgroundTransparency=1,ImageTransparency=1,ScaleType=bY(bU.ScaleType or'Crop',Enum.ScaleType.Crop),ZIndex=2,Parent=bX})aj(bZ,UDim.new(0,6))if bU.Color then bZ.ImageColor3=bU.Color end local b_={Value=nil}local b0=0 function b_:SetImage(b1)b0+=1 local b2=b0 b_.Value=b1 if b1==nil or b1==''or b1=='None'then ah(bZ,{ImageTransparency=1},0.2)ah(bV.Placeholder,{ImageTransparency=0.3},0.2)return true end local b3,b4 if type(b1)=='number'then b3='rbxassetid://'..math.floor(b1)elseif type(b1)=='string'and({avatar=true,headshot=true})[b1:lower()]then b3='rbxthumb://type=AvatarHeadShot&id='..j.UserId..'&w=420&h=420'else local b5,b6,b7=pcall(bW._resolveBackground,bW,tostring(b1))if b5 then b3,b4=b6,b7 else b4=tostring(b6)end end if b0~=b2 then return false,'replaced by a newer image'end if not b3 then warn('[AirFlow] image: '..tostring(b4))return false,b4 end bZ.ImageTransparency=1 bZ.Image=b3 task.spawn(function()local b5=0 while not bZ.IsLoaded and b5<4 and b0==b2 and bZ.Parent do b5+=task.wait(0.05)end if b0==b2 and bZ.Parent then ah(bZ,{ImageTransparency=0},0.35)ah(bV.Placeholder,{ImageTransparency=1},0.2)end end)return true end b_.Set=b_.SetImage function b_:Get()return b_.Value end function b_:SetCaption(b1)bV.SetCaption(b1)end function b_:SetScaleType(b1)bZ.ScaleType=bY(b1,bZ.ScaleType)end function b_:SetColor(b1)bZ.ImageColor3=typeof(b1)=='Color3'and b1 or Color3.new(1,1,1)end function b_:SetTitle(b1)if bV.Title then bV.Title.Text=tostring(b1)end end if bU.Image~=nil then task.spawn(b_.SetImage,b_,bU.Image)end return m(self,bU,b_,bV.Frame,'Image')end function aS:Viewport(bU)local bV bU,bV=self:_mediaCard(bU,180)local bW=self.Window local bX=bV.Media aq(bV.Placeholder,'box')local bY=ai('ViewportFrame',{Size=UDim2.fromScale(1,1),BackgroundTransparency=1,ImageTransparency=1,Ambient=bU.Ambient or Color3.fromRGB(165,160,175),LightColor=bU.LightColor or Color3.fromRGB(255,250,245),LightDirection=Vector3.new(-0.6,-1,-0.8),ZIndex=2,Parent=bX})local bZ=Instance.new('Camera')bZ.FieldOfView=math.clamp(tonumber(bU.FieldOfView)or 35,10,90)bZ.Parent=bY bY.CurrentCamera=bZ local b_=Instance.new('WorldModel')b_.Parent=bY local b0={Model=nil,Spin=bU.Spin~=false,SpinSpeed=tonumber(bU.SpinSpeed)or 25}local b1=math.rad(tonumber(bU.Angle)or 0)local b2=math.rad(tonumber(bU.Pitch)or 10)local b3=tonumber(bU.Distance)or 1 local b4,b5,b6=nil,10,CFrame.new()local b7=nil local b8=0 local b9,ca,cb=false,0,0 local function cc()if not b4 then return end local cd=b6:VectorToWorldSpace(Vector3.new(math.sin(b1)*math.cos(b2),math.sin(b2),-math.cos(b1)*math.cos(b2)))bZ.CFrame=CFrame.lookAt(b4+cd*b5,b4)end local function cd(ce)local cf,cg if ce:IsA('Model')then cf,cg=ce:GetBoundingBox()b6=ce:GetPivot().Rotation elseif ce:IsA('BasePart')then cf,cg=ce.CFrame,ce.Size b6=ce.CFrame.Rotation else return false end b4=cf.Position local ch=math.max(cg.Magnitude/2,0.5)b5=ch/math.tan(math.rad(bZ.FieldOfView/2))*b3 cc()return true end local function ce(cf)local cg=cf if bU.Clone~=false then local ch=cf.Archivable pcall(function()cf.Archivable=true end)local ci,cj=pcall(cf.Clone,cf)pcall(function()cf.Archivable=ch end)cg=ci and cj or nil end if not cg then return nil end local function ch(ci)if ci:IsA('LuaSourceContainer')or ci:IsA('Sound')or ci:IsA('ForceField')then ci:Destroy()elseif ci:IsA('BasePart')then ci.Anchored=true ci.CanCollide=false end end for ci,cj in ipairs(cg:GetDescendants())do pcall(ch,cj)end if cg:IsA('BasePart')then cg.Anchored=true end local ci=cg:FindFirstChildOfClass('Humanoid')if ci then ci.DisplayDistanceType=Enum.HumanoidDisplayDistanceType.None end return cg end local function cf(cg)if type(cg)=='function'then local ch,ci=pcall(cg)cg=ch and ci or nil end if type(cg)=='string'and({avatar=true,player=true,character=true})[cg:lower()]then cg=j end if typeof(cg)=='Instance'and cg:IsA('Player')then local ch=cg.Character if not ch then ch=cg.CharacterAdded:Wait()task.wait(0.5)end cg=ch end return typeof(cg)=='Instance'and cg or nil end function b0:SetModel(cg)b8+=1 local ch=b8 b7=cg if b0.Model then b0.Model:Destroy()b0.Model=nil end b4=nil if cg==nil then ah(bY,{ImageTransparency=1},0.2)ah(bV.Placeholder,{ImageTransparency=0.3},0.2)return true end local ci=cf(cg)if b8~=ch then return false,'replaced by a newer model'end if not ci then return false,'no model to show'end local cj=ce(ci)if not cj then return false,'could not copy the model'end cj.Parent=b_ b0.Model=cj if not cd(cj)then cj:Destroy()b0.Model=nil return false,'not a Model or a part'end bY.ImageTransparency=1 ah(bY,{ImageTransparency=0},0.35)ah(bV.Placeholder,{ImageTransparency=1},0.2)return true end b0.Set=b0.SetModel function b0:Get()return b0.Model end function b0:Refresh()return b0:SetModel(b7)end function b0:SetSpin(cg)b0.Spin=cg~=false end function b0:SetSpinSpeed(cg)b0.SpinSpeed=tonumber(cg)or b0.SpinSpeed end function b0:SetAngle(cg)b1=math.rad(tonumber(cg)or 0)cc()end function b0:SetCaption(cg)bV.SetCaption(cg)end function b0:SetTitle(cg)if bV.Title then bV.Title.Text=tostring(cg)end end bX.InputBegan:Connect(function(cg)if aw(cg)and b0.Model then b9=true ca=av().X end end)bW:_listen('Changed',function(cg)if b9 and aA(cg)then local ch=av().X b1-=(ch-ca)*0.012 ca=ch cc()end end,b0)bW:_listen('Ended',function(cg)if b9 and aw(cg)then b9=false cb=os.clock()+1.5 end end,b0)bW:_listen('Render',function(cg)if b0.Spin and b4 and not b9 and os.clock()>=cb and bW.Open and not bW.Minimized and bV.Frame.Visible then b1+=math.rad(b0.SpinSpeed)*cg cc()end end,b0)if bU.Model~=nil then task.spawn(b0.SetModel,b0,bU.Model)end return m(self,bU,b0,bV.Frame,'Viewport')end function aS:Table(bU)bU=l(bU,{Title='Name',Description='Desc',Data='Rows',OnRowClick='Callback'})local bV=self.Window local bW=aM(self)local bX=bW.Compact local bY=tonumber(bU.RowHeight)or(E and 32 or 26)local bZ=math.max(math.floor(tonumber(bU.MaxRows)or 8),1)local b_=E and 28 or 24 local b0=bX and 12 or 13 local b1=bX and 14 or 8 local b2=type(bU.Name)=='string'and bU.Name~=''local b3=bX and 4 or 10 local b4=bU.Search~=false local b5=E and 30 or 26 local b6=b2 and(b3+(bU.Desc and 38 or 22))or(bX and 4 or b1)local b7=b6+(b4 and b5+6 or 0)local b8=bX and 6 or b1 local b9,ca=aO(self,'Frame',b7+b_+bY+b8,bU)aG(b9,ca)local cb if b2 then cb=am({Position=UDim2.fromOffset(14,b3),Size=UDim2.new(1,-28,0,bW.TitleHeight),Text=bU.Name,TextSize=bW.TextSize,Parent=b9})if bU.Desc then am({Position=UDim2.fromOffset(14,b3+bW.TitleHeight+1),Size=UDim2.new(1,-28,0,bW.DescLine),Text=bU.Desc,TextSize=bW.DescSize,FontFace=D.Regular,TextColor3=z.Muted,Parent=b9})end end local cc=''local cd,ce if b4 then local cf=ai('Frame',{Position=UDim2.fromOffset(b1,b6),Size=UDim2.new(1,-b1*2,0,b5),BackgroundColor3=z.Surface,BorderSizePixel=0,Parent=b9})cf:SetAttribute('NoDrag',true)aj(cf,UDim.new(0,6))local cg=ak(cf)local ch,ci=aB(cf,'search',z.Muted,UDim2.new(0,9,0.5,0))ch.Size=UDim2.fromOffset(13,13)ce=am({AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,-9,0,0),Size=UDim2.new(0,0,1,0),AutomaticSize=Enum.AutomaticSize.X,Text='',TextSize=11,FontFace=D.Regular,TextColor3=z.Muted,TextTruncate=Enum.TextTruncate.None,Visible=false,Parent=cf})cd=ai('TextBox',{Position=UDim2.fromOffset(29,0),Size=UDim2.new(1,-90,1,0),BackgroundTransparency=1,Text='',PlaceholderText=bU.SearchPlaceholder or'Search',PlaceholderColor3=z.Muted,TextColor3=z.Text,TextSize=12,FontFace=D.Regular,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,ClearTextOnFocus=false,Parent=cf})cd.Focused:Connect(function()ah(cg,{Color=z.StrokeHover},0.15)ah(ci,{ImageColor3=z.Accent},0.15)end)cd.FocusLost:Connect(function()ah(cg,{Color=z.Stroke},0.2)ah(ci,{ImageColor3=z.Muted},0.2)end)end local cf=ai('Frame',{Position=UDim2.fromOffset(b1,b7),Size=UDim2.new(1,-b1*2,0,b_+bY),BackgroundColor3=z.Surface,BackgroundTransparency=0.2,BorderSizePixel=0,ClipsDescendants=true,Parent=b9})aj(cf,UDim.new(0,6))ak(cf,z.Stroke)local cg=ai('Frame',{Size=UDim2.new(1,0,0,b_),BackgroundColor3=z.Surface3,BackgroundTransparency=0.45,BorderSizePixel=0,Parent=cf})ai('Frame',{AnchorPoint=Vector2.new(0,1),Position=UDim2.fromScale(0,1),Size=UDim2.new(1,0,0,1),BackgroundColor3=z.Stroke,BorderSizePixel=0,Parent=cg})local ch=ai('ScrollingFrame',{Position=UDim2.fromOffset(0,b_),Size=UDim2.new(1,0,1,-b_),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=2,ScrollBarImageColor3=z.Accent,ScrollBarImageTransparency=0.4,ScrollingDirection=Enum.ScrollingDirection.Y,AutomaticCanvasSize=Enum.AutomaticSize.Y,CanvasSize=UDim2.new(),Parent=cf})ai('UIListLayout',{SortOrder=Enum.SortOrder.LayoutOrder,Parent=ch})local ci=am({Position=UDim2.fromOffset(0,b_),Size=UDim2.new(1,0,0,bY),Text=bU.EmptyText or'Nothing here yet',TextSize=12,FontFace=D.Regular,TextColor3=z.Muted,TextXAlignment=Enum.TextXAlignment.Center,Parent=cf})local cj={Rows={}}local ck=nil local cl,cm={},{}local cn={}local co,cp=nil,false local cq=nil local cr={Color3.fromRGB(245,200,90),Color3.fromRGB(200,206,218),Color3.fromRGB(214,146,96)}local function cs(ct)local cu=type(ct.Align)=='string'and ct.Align:lower()or nil if cu=='right'then return Enum.TextXAlignment.Right elseif cu=='center'or cu=='centre'then return Enum.TextXAlignment.Center end return Enum.TextXAlignment.Left end local function ct()local cu,cv,cw=0,0,0 for cx,cy in ipairs(cl)do local cz=tonumber(cy.Width)if cz and cz>1 then cu+=cz elseif cz and cz>0 then cv+=cz else cw+=1 end end local cx=math.max(1-cv,0)for cy,cz in ipairs(cl)do local cA=tonumber(cz.Width)local cB if cA and cA>1 then cz.UDim=UDim.new(0,cA)else cB=(cA and cA>0)and cA or(cw>0 and cx/cw or 0)cz.UDim=UDim.new(cB,-cu*cB)end end end local function cu(cv,cw)if cw.Rank then return nil end if cv[1]~=nil or cw.Key==nil then return cv[cw.Index]end return cv[cw.Key]end local function cv(cw,cx,cy)if type(cx.Format)=='function'then local cz,cA=pcall(cx.Format,cw,cy)if cz and cA~=nil then return tostring(cA)end end if type(cw)=='number'then local cz=cw==math.floor(cw)local cA=cz and string.format('%d',cw)or string.format('%.2f',cw)local cB,cC,cD=cA:match('^(%-?)(%d+)(.*)$')if cC then cC=cC:reverse():gsub('(%d%d%d)','%1,'):reverse():gsub('^,','')return cB..cC..cD end return cA end if cw==nil then return''end return tostring(cw)end local function cw()for cx,cy in ipairs(cm)do local cz=cy.Column local cA=co~=nil and co==cz ah(cy.Label,{TextColor3=cA and z.Text or z.Muted},0.15)cy.Arrow.Visible=cA if cA then ah(cy.Arrow,{Rotation=cp and 0 or 180},0.2,Enum.EasingStyle.Quint)end end end local function cx()local cy={}for cz,cA in ipairs(cj.Rows)do cy[cz]={Row=cA,Index=cz}end if co then local cz=co table.sort(cy,function(cA,cB)local cC,cD=cu(cA.Row,cz),cu(cB.Row,cz)local cE,cF=tonumber(cC),tonumber(cD)if cE and cF then if cE~=cF then if cp then return cE>cF end return cE<cF end elseif cC~=nil and cD~=nil then local cG,cH=string.lower(tostring(cC)),string.lower(tostring(cD))if cG~=cH then if cp then return cG>cH end return cG<cH end elseif cC~=cD then return cC~=nil end return cA.Index<cB.Index end)end for cz,cA in ipairs(cy)do cA.Rank=cz end if cc==''then return cy end local cz={}for cA,cB in ipairs(cy)do for cC,cD in ipairs(cl)do if not cD.Rank then local cE=cv(cu(cB.Row,cD),cD,cB.Row)cE=string.lower((string.gsub(cE,'<[^>]->','')))if string.find(cE,cc,1,true)then table.insert(cz,cB)break end end end end return cz end local function cy()local cz=ai('TextButton',{Size=UDim2.new(1,0,0,bY),BackgroundColor3=z.Surface3,BackgroundTransparency=1,BorderSizePixel=0,AutoButtonColor=false,Text='',Parent=ch})local cA=ai('Frame',{Position=UDim2.new(0,3,0.5,0),AnchorPoint=Vector2.new(0,0.5),Size=UDim2.new(0,2,1,-10),BackgroundColor3=z.Accent,BackgroundTransparency=1,BorderSizePixel=0,Parent=cz})aj(cA,UDim.new(1,0))local cB=ai('Frame',{Size=UDim2.fromScale(1,1),BackgroundTransparency=1,Parent=cz})al(cB,10,10)ai('UIListLayout',{FillDirection=Enum.FillDirection.Horizontal,VerticalAlignment=Enum.VerticalAlignment.Center,SortOrder=Enum.SortOrder.LayoutOrder,Parent=cB})local cC={Frame=cz,Marker=cA,Cells={},Hover=false}for cD,cE in ipairs(cl)do local cF=ai('Frame',{Size=UDim2.new(cE.UDim.Scale,cE.UDim.Offset,1,0),BackgroundTransparency=1,LayoutOrder=cD,Parent=cB})local cG=am({Size=UDim2.new(1,-6,1,0),TextSize=b0,FontFace=cE.Rank and D.Bold or D.Regular,TextColor3=z.Text,TextXAlignment=cs(cE),RichText=not cE.Rank,Parent=cF})local cH if cE.Rank then cG.Size=UDim2.fromScale(1,1)cG.TextXAlignment=Enum.TextXAlignment.Center cH=ai('Frame',{AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.fromScale(0.5,0.5),Size=UDim2.fromOffset(bY-8,bY-8),BackgroundTransparency=1,BorderSizePixel=0,ZIndex=0,Parent=cF})aj(cH,UDim.new(1,0))end cC.Cells[cD]={Label=cG,Badge=cH}end local cD=ay(cz,function()return ch end)cz.MouseEnter:Connect(function()cC.Hover=true ah(cz,{BackgroundTransparency=0.35},0.1)end)cz.MouseLeave:Connect(function()cC.Hover=false ah(cz,{BackgroundColor3=cC.Highlighted and z.Accent or z.Surface3,BackgroundTransparency=cC.Rest or 1},0.2)end)cz.MouseButton1Click:Connect(function()if cC.Data and cD()then aJ(bU.Callback,cC.Data,cC.Index)end end)return cC end local function cz(cA)local cB=ck or#cj.Rows local cC=math.clamp(cB,1,bZ)local cD=b_+cC*bY local cE=b7+cD+b8 if cq==cE then return end local cF=(cA or cq==nil)and 0 or 0.25 cq=cE ah(cf,{Size=UDim2.new(1,-b1*2,0,cD)},cF,Enum.EasingStyle.Quint)ah(b9,{Size=UDim2.new(1,0,0,cE)},cF,Enum.EasingStyle.Quint)end local function cA()local cB=cx()for cC,cD in ipairs(cB)do local cE=cn[cC]if not cE then cE=cy()cn[cC]=cE end local cF=cD.Row cE.Data=cF cE.Index=cD.Index cE.Frame.LayoutOrder=cC cE.Frame.Visible=true local cG=cF.Highlight==true if not cG and type(bU.Highlight)=='function'then local cH,cI=pcall(bU.Highlight,cF,cD.Index)cG=cH and cI==true end cE.Highlighted=cG cE.Rest=cG and 0.86 or(cC%2==0 and 0.78 or 1)if not cE.Hover then cE.Frame.BackgroundColor3=cG and z.Accent or z.Surface3 cE.Frame.BackgroundTransparency=cE.Rest aa(cE.Frame,{BackgroundColor3=cE.Frame.BackgroundColor3})end cE.Marker.BackgroundTransparency=cG and 0 or 1 for cH,cI in ipairs(cl)do local cJ=cE.Cells[cH]if cI.Rank then local cK=cr[cD.Rank]cJ.Label.Text=tostring(cD.Rank)cJ.Label.TextColor3=cK and Color3.fromRGB(28,22,18)or z.Muted aa(cJ.Label,{TextColor3=cJ.Label.TextColor3})cJ.Badge.BackgroundColor3=cK or z.Surface3 cJ.Badge.BackgroundTransparency=cK and 0.05 or 1 else local cK=cu(cF,cI)cJ.Label.Text=k._rich(cv(cK,cI,cF))local cL=cI.Color if type(cL)=='function'then local cM,cN=pcall(cL,cK,cF)cL=cM and cN or nil end if type(cF.Colors)=='table'then local cM=cF.Colors[cI.Key or cI.Index]if cM==nil then cM=cF.Colors[cI.Index]end if cM~=nil then cL=cM end end local cM=k._color(cL)or(cG and z.Accent or z.Text)cJ.Label.TextColor3=cM aa(cJ.Label,{TextColor3=cM})end end end for cC=#cB+1,#cn do cn[cC].Frame.Visible=false cn[cC].Data=nil end ck=#cB ci.Visible=#cB==0 ci.Text=(#cB==0 and cc~=''and#cj.Rows>0)and(bU.NoMatchText or'No rows match')or(bU.EmptyText or'Nothing here yet')if ce then ce.Visible=cc~=''ce.Text=#cB..' / '..#cj.Rows end cz()end local function cB()for cC,cD in ipairs(cm)do cD.Frame:Destroy()end table.clear(cm)for cC,cD in ipairs(cn)do cD.Frame:Destroy()end table.clear(cn)local cC=cg:FindFirstChild('Cells')or ai('Frame',{Name='Cells',Size=UDim2.fromScale(1,1),BackgroundTransparency=1,Parent=cg})if not cC:FindFirstChildOfClass('UIListLayout')then al(cC,10,10)ai('UIListLayout',{FillDirection=Enum.FillDirection.Horizontal,VerticalAlignment=Enum.VerticalAlignment.Center,SortOrder=Enum.SortOrder.LayoutOrder,Parent=cC})end for cD,cE in ipairs(cl)do local cF=ai('TextButton',{Size=UDim2.new(cE.UDim.Scale,cE.UDim.Offset,1,0),BackgroundTransparency=1,AutoButtonColor=false,Text='',LayoutOrder=cD,Parent=cC})local cG=cE.Rank and Enum.TextXAlignment.Center or cs(cE)local cH=cG==Enum.TextXAlignment.Right local cI=am({Size=UDim2.new(1,cG==Enum.TextXAlignment.Center and 0 or-16,1,0),Position=UDim2.fromOffset(cH and 16 or 0,0),Text=string.upper(cE.Name),TextSize=11,FontFace=D.Bold,TextColor3=z.Muted,TextXAlignment=cG,Parent=cF})local cJ=ai('ImageLabel',{AnchorPoint=Vector2.new(0,0.5),Position=UDim2.new(0,0,0.5,0),Size=UDim2.fromOffset(12,12),BackgroundTransparency=1,ImageColor3=z.Accent,ScaleType=Enum.ScaleType.Fit,Visible=false,Parent=cF})aq(cJ,'chevron-down')local function cK()local cL=cI.TextBounds.X if cH then cJ.Position=UDim2.new(1,-(cL+15),0.5,0)elseif cG==Enum.TextXAlignment.Center then cJ.Position=UDim2.new(0.5,cL/2+3,0.5,0)else local cM=cF.AbsoluteSize.X/math.max(bV.Scale.Scale,0.01)cJ.Position=UDim2.new(0,math.clamp(cL+4,0,math.max(cM-12,0)),0.5,0)end end cI:GetPropertyChangedSignal('TextBounds'):Connect(cK)cF:GetPropertyChangedSignal('AbsoluteSize'):Connect(cK)task.defer(cK)local cL=cE.Sortable and not cE.Rank if cL then cF.MouseEnter:Connect(function()if co~=cE then ah(cI,{TextColor3=z.Text},0.12)end end)cF.MouseLeave:Connect(function()if co~=cE then ah(cI,{TextColor3=z.Muted},0.2)end end)cF.MouseButton1Click:Connect(function()if co~=cE then local cM=false for cN,cO in ipairs(cj.Rows)do local cP=cu(cO,cE)if cP~=nil then cM=tonumber(cP)~=nil break end end co,cp=cE,cM cE.FirstDescending=cM elseif cp==cE.FirstDescending then cp=not cp else co=nil end cw()cA()end)end table.insert(cm,{Frame=cF,Label=cI,Arrow=cJ,Column=cE})end cw()end function cj:SetColumns(cC)table.clear(cl)if bU.Rank then table.insert(cl,{Name='#',Rank=true,Width=E and 40 or 36,Sortable=false})end for cD,cE in ipairs(type(cC)=='table'and cC or{})do if type(cE)~='table'then cE={Name=tostring(cE)}end local cF=cE.Name or cE.Title or('Column '..cD)table.insert(cl,{Name=cF,Key=cE.Key or cF,Index=cD,Width=cE.Width,Align=cE.Align,Format=cE.Format,Color=cE.Color,Sortable=cE.Sortable~=false and bU.Sortable~=false})end co=nil ct()cB()cA()end local function cC(cD)if type(cD)=='number'then return cl[cD+(bU.Rank and 1 or 0)]end for cE,cF in ipairs(cl)do if not cF.Rank and(cF.Key==cD or cF.Name==cD)then return cF end end return nil end function cj:SetRows(cD)cj.Rows={}for cE,cF in ipairs(type(cD)=='table'and cD or{})do cj.Rows[cE]=type(cF)=='table'and cF or{cF}end cA()end cj.Set=cj.SetRows function cj:GetRows()return cj.Rows end cj.Get=cj.GetRows function cj:AddRow(cD,cE)cD=type(cD)=='table'and cD or{cD}if tonumber(cE)then table.insert(cj.Rows,math.clamp(math.floor(cE),1,#cj.Rows+1),cD)else table.insert(cj.Rows,cD)end cA()return#cj.Rows end function cj:UpdateRow(cD,cE)if not cj.Rows[cD]then return false end cj.Rows[cD]=type(cE)=='table'and cE or{cE}cA()for cF,cG in ipairs(cn)do if cG.Index==cD and cG.Frame.Visible then local cH=cG.Highlighted and z.Accent or z.Surface3 ah(cG.Frame,{BackgroundColor3=z.Accent,BackgroundTransparency=0.7},0.08)task.delay(0.1,function()if not cG.Hover then ah(cG.Frame,{BackgroundColor3=cH,BackgroundTransparency=cG.Rest},0.5)end end)break end end return true end function cj:RemoveRow(cD)if not cj.Rows[cD]then return false end table.remove(cj.Rows,cD)cA()return true end function cj:Clear()cj:SetRows({})end function cj:Sort(cD,cE)co=cD~=nil and cC(cD)or nil cp=cE==true if co then co.FirstDescending=cp end cw()cA()end function cj:SetTitle(cD)if cb then cb.Text=tostring(cD)end end function cj:SetMaxRows(cD)bZ=math.max(math.floor(tonumber(cD)or bZ),1)cz()end cj:SetColumns(bU.Columns or{})cj:SetRows(bU.Rows or{})if bU.SortBy~=nil then cj:Sort(bU.SortBy,bU.SortDescending~=false)end cz(true)if cd then cd:GetPropertyChangedSignal('Text'):Connect(function()local cD=string.lower(bM(cd.Text))if cD~=cc then cc=cD ch.CanvasPosition=Vector2.zero cA()end end)end function cj:SetSearch(cD)if cd then cd.Text=tostring(cD or'')end end ag(cf,cA)return m(self,bU,cj,b9,'Table')end aS.CreateImage=aS.Image aS.AddImage=aS.Image aS.CreateViewport=aS.Viewport aS.AddViewport=aS.Viewport aS.CreateTable=aS.Table aS.AddTable=aS.Table aS.CreateLeaderboard=aS.Table local function bU(bV)if bV.OutFrame then bV.OutFrame.Parent=bV.Area bV.OutFrame.Visible=false bV.OutFrame=nil end bV.Out.Visible=false end local function bV(bW)if bW.InFrame then bW.InFrame.Parent=bW.Area bW.InFrame.Position=UDim2.fromOffset(0,0)bW.InFrame=nil end bW.In.Visible=false end function aS:_setupSubTabs()local bW=self._headerBottom local bX=self._page local bY=ai('ScrollingFrame',{Name='SubTabs',Position=UDim2.fromOffset(24,bW-4),Size=UDim2.new(1,-48,0,32),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=0,ScrollingDirection=Enum.ScrollingDirection.X,AutomaticCanvasSize=Enum.AutomaticSize.X,CanvasSize=UDim2.new(),Parent=bX})bY:SetAttribute('NoDrag',true)local bZ=ai('Frame',{Size=UDim2.fromOffset(0,32),BackgroundColor3=z.Surface3,BackgroundTransparency=0.35,BorderSizePixel=0,Visible=false,Parent=bY})aj(bZ,UDim.new(0,8))ak(bZ,z.Stroke)local b_=ai('Frame',{Size=UDim2.new(0,0,1,0),AutomaticSize=Enum.AutomaticSize.X,BackgroundTransparency=1,ZIndex=2,Parent=bY})ai('UIListLayout',{FillDirection=Enum.FillDirection.Horizontal,VerticalAlignment=Enum.VerticalAlignment.Center,SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,4),Parent=b_})self.Window:_overflowHint(bX,bY,b_,false,z.Background)local b0=bW+36 local b1=ai('Frame',{Name='SubPages',Position=UDim2.fromOffset(0,b0),Size=UDim2.new(1,0,1,-b0),BackgroundTransparency=1,ClipsDescendants=true,Parent=bX})local b2={Strip=bY,Row=b_,Highlight=bZ,Area=b1,Out=ai('CanvasGroup',{Size=UDim2.fromScale(1,1),BackgroundTransparency=1,Visible=false,ZIndex=2,Parent=b1}),In=ai('CanvasGroup',{Size=UDim2.fromScale(1,1),BackgroundTransparency=1,Visible=false,ZIndex=3,Parent=b1}),Generation=0}self._sub=b2 self._subTabs={}self.List.Visible=false self:_refreshEmpty()b_:GetPropertyChangedSignal('AbsoluteSize'):Connect(function()if self.CurrentSubTab and not b2.Moving then self:_placeSubHighlight(self.CurrentSubTab,true)end end)end function aS:_placeSubHighlight(bW,bX)local bY=self._sub local bZ=self.Window.Scale.Scale local b_=bW._button local b0=b_.AbsoluteSize.X/bZ if b0<=0 then return end local b1=(b_.AbsolutePosition.X-bY.Row.AbsolutePosition.X)/bZ local b2={Position=UDim2.fromOffset(b1,0),Size=UDim2.fromOffset(b0,32)}if bX or not bY.Highlight.Visible then bY.Highlight.Visible=true bY.Highlight.Position=b2.Position bY.Highlight.Size=b2.Size else bY.Moving=true ah(bY.Highlight,b2,0.35,Enum.EasingStyle.Quint)task.delay(0.36,function()bY.Moving=false end)end local b3=bY.Strip.AbsoluteSize.X/bZ local b4=bY.Strip.CanvasPosition.X if b1<b4 then ah(bY.Strip,{CanvasPosition=Vector2.new(math.max(b1-8,0),0)},0.3,Enum.EasingStyle.Quint)elseif b1+b0>b4+b3 then ah(bY.Strip,{CanvasPosition=Vector2.new(b1+b0-b3+8,0)},0.3,Enum.EasingStyle.Quint)end end function aS:SubTab(bW,bX)if self._groupbox or self._isSubTab then return self.Parent:SubTab(bW,bX)end bW=l(bW,{Title='Name',Description='Desc'})if bX~=nil and bW.Icon==nil then bW.Icon=bX end if not self._subTabs then self:_setupSubTabs()end local bY=self._sub local bZ=#self._subTabs+1 local b_=setmetatable({Name=bW.Name or('Page '..bZ),Window=self.Window,Parent=self,_order=0,_isSubTab=true,_index=bZ,_iconName=bW.Icon},aS)local b0=ai('Frame',{Name=b_.Name,Size=UDim2.fromScale(1,1),BackgroundTransparency=1,Visible=false,Parent=bY.Area})b_._frame=b0 bJ(b_,b0,0,bW.Icon or self._iconName or'layout-grid',bW.EmptyText or'Nothing here yet')local b1=ai('TextButton',{Size=UDim2.new(0,0,1,0),AutomaticSize=Enum.AutomaticSize.X,BackgroundTransparency=1,Text='',AutoButtonColor=false,LayoutOrder=bZ,Parent=bY.Row})al(b1,14,14)ai('UIListLayout',{FillDirection=Enum.FillDirection.Horizontal,VerticalAlignment=Enum.VerticalAlignment.Center,SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,6),Parent=b1})if bW.Icon then local b2=ai('ImageLabel',{Size=UDim2.fromOffset(14,14),BackgroundTransparency=1,ImageColor3=z.Muted,ScaleType=Enum.ScaleType.Fit,LayoutOrder=1,Parent=b1})aq(b2,bW.Icon)if b2:GetAttribute('CustomIcon')then b2.ImageTransparency=0.4 end b_._iconImage=b2 end b_._label=am({Size=UDim2.new(0,0,1,0),AutomaticSize=Enum.AutomaticSize.X,Text=b_.Name,TextSize=13,TextColor3=z.Muted,TextTruncate=Enum.TextTruncate.None,LayoutOrder=2,Parent=b1})b_._button=b1 b1.MouseEnter:Connect(function()if self.CurrentSubTab~=b_ then ah(b_._label,{TextColor3=z.Text},0.12)end end)b1.MouseLeave:Connect(function()if self.CurrentSubTab~=b_ then ah(b_._label,{TextColor3=z.Muted},0.2)end end)b1.MouseButton1Click:Connect(function()self:SelectSubTab(b_)end)table.insert(self._subTabs,b_)if bZ==1 then self:SelectSubTab(b_,true)end return b_ end aS.CreateSubTab=aS.SubTab aS.AddSubTab=aS.SubTab function aS:SelectSubTab(bW,bX)if type(bW)~='table'then for bY,bZ in ipairs(self._subTabs or{})do if bZ.Name==bW or bY==bW then bW=bZ break end end end if type(bW)~='table'or not self._sub then return end local bY=self.CurrentSubTab if bY==bW then return end self.Window:_resetSearch()self.Window:_closePopups()self.CurrentSubTab=bW local bZ=self._sub bU(bZ)bV(bZ)bZ.Generation+=1 local b_=bZ.Generation local b0=bX and 0 or 0.2 if bY then ah(bY._label,{TextColor3=z.Muted},b0)if bY._iconImage then ar(bY._iconImage,z.Muted,false,b0)end end ah(bW._label,{TextColor3=z.Text},b0)if bW._iconImage then ar(bW._iconImage,z.Accent,true,b0)end self:_placeSubHighlight(bW,bX)if bX or not bY then if bY then bY._frame.Visible=false end bW._frame.Visible=true return end local b1=bW._index>bY._index and 1 or-1 bZ.OutFrame=bY._frame bY._frame.Parent=bZ.Out bZ.Out.GroupTransparency=0 bZ.Out.Position=UDim2.fromOffset(0,0)bZ.Out.Visible=true ah(bZ.Out,{GroupTransparency=1,Position=UDim2.fromOffset(-b1*28,0)},0.2)bZ.InFrame=bW._frame bW._frame.Visible=true bW._frame.Parent=bZ.In bZ.In.GroupTransparency=1 bZ.In.Position=UDim2.fromOffset(b1*28,0)bZ.In.Visible=true ah(bZ.In,{GroupTransparency=0,Position=UDim2.fromOffset(0,0)},0.34,Enum.EasingStyle.Quint)task.delay(0.2,function()if bZ.Generation==b_ then bU(bZ)end end)task.delay(0.34,function()if bZ.Generation==b_ then bV(bZ)end end)end a2._searchIcons={Tab='app-window',Page='panels-top-left',Groupbox='layout-grid',Button='mouse-pointer-click',ButtonRow='mouse-pointer-click',Toggle='toggle-right',Slider='sliders-horizontal',Dropdown='list',Input='text-cursor-input',Keybind='keyboard',ColorPicker='palette',Stepper='chevrons-up-down',Progress='activity',Status='activity',StatusList='activity',Label='type',Paragraph='type',OrderList='list-ordered'}function a2:_searchResults(bW)local bX={}local function bY(bZ,b_)if type(bZ)~='string'or bZ==''then return end local b0=string.find(string.lower(bZ),bW,1,true)if not b0 then return end b_.Name=bZ b_.At=b0 b_.Rank=b0==1 and 0 or(string.find(string.sub(bZ,b0-1,b0-1),'[%s%p]')and 1 or 2)b_.Order=#bX+1 table.insert(bX,b_)end local function bZ(b_)return not b_._destroyed and b_._type~='Section'and b_._type~='Divider'and(b_._isShown==nil or b_:_isShown())end for b_,b0 in ipairs(self.Tabs)do bY(b0.Name,{Kind='Tab',Tab=b0,Icon=b0._iconName})for b1,b2 in ipairs(b0._subTabs or{b0})do local b3=b2._isSubTab and b2 or nil local b4=b0.Name if b3 then bY(b3.Name,{Kind='Page',Tab=b0,Sub=b3,Path=b0.Name})b4=b0.Name..'  \u{203a}  '..b3.Name end if not b2._noSearch then for b5,b6 in ipairs(b2._items or{})do if bZ(b6)then bY(b6._searchName,{Kind=b6._type,Tab=b0,Sub=b3,Target=b6,Path=b4})end end for b5,b6 in ipairs(b2._groupboxes or{})do if b6._userVisible~=false then bY(b6.Name,{Kind='Groupbox',Tab=b0,Sub=b3,Target=b6,Path=b4})local b7=b4..'  \u{203a}  '..b6.Name for b8,b9 in ipairs(b6._items)do if bZ(b9)then bY(b9._searchName,{Kind=b9._type,Tab=b0,Sub=b3,Target=b9,Group=b6,Path=b7})end end end end end end end table.sort(bX,function(b_,b0)if b_.Rank~=b0.Rank then return b_.Rank<b0.Rank end return b_.Order<b0.Order end)return bX end function a2:_flash(bW,bX)for bY,bZ in ipairs({'SearchFlash','SearchGlow'})do local b_=bW:FindFirstChild(bZ)if b_ then b_:Destroy()end end bX=bX or 8 local bY=z.Accent local bZ=bY:Lerp(Color3.new(1,1,1),0.65)local b_=ai('Frame',{Name='SearchGlow',Size=UDim2.fromScale(1,1),BackgroundTransparency=1,ZIndex=10,Parent=bW})aj(b_,UDim.new(0,bX))local b0=ai('UIStroke',{Color=bY,Thickness=1,Transparency=1,ApplyStrokeMode=Enum.ApplyStrokeMode.Border,Parent=b_})local b1=ai('Frame',{Name='SearchFlash',Size=UDim2.fromScale(1,1),BackgroundColor3=bY,BackgroundTransparency=1,BorderSizePixel=0,ZIndex=10,Parent=bW})aj(b1,UDim.new(0,bX))local b2=ai('UIGradient',{Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0.7),NumberSequenceKeypoint.new(0.4,0.55),NumberSequenceKeypoint.new(0.5,0),NumberSequenceKeypoint.new(0.6,0.55),NumberSequenceKeypoint.new(1,0.7)}),Rotation=18,Offset=Vector2.new(-1,0),Parent=b1})local b3=ai('UIStroke',{Color=Color3.new(1,1,1),Thickness=1.6,Transparency=1,ApplyStrokeMode=Enum.ApplyStrokeMode.Border,Parent=b1})local b4=ai('UIGradient',{Color=ColorSequence.new({ColorSequenceKeypoint.new(0,bY),ColorSequenceKeypoint.new(0.5,bZ),ColorSequenceKeypoint.new(1,bY)}),Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0.45),NumberSequenceKeypoint.new(0.5,0),NumberSequenceKeypoint.new(1,0.45)}),Parent=b3})local b5=pcall(function()b0.BorderStrokePosition=Enum.BorderStrokePosition.Inner b3.BorderStrokePosition=Enum.BorderStrokePosition.Inner end)local b6=b5 and 6 or 3 if not b5 then b_.Position=UDim2.fromOffset(b6+1,b6+1)b_.Size=UDim2.new(1,-(b6+1)*2,1,-(b6+1)*2)b1.Position=UDim2.fromOffset(2,2)b1.Size=UDim2.new(1,-4,1,-4)end local b7 if not bW:FindFirstChildOfClass('UIScale')then b7=ai('UIScale',{Scale=0.975,Parent=bW})ah(b7,{Scale=1},0.4,Enum.EasingStyle.Quint)end ah(b1,{BackgroundTransparency=0.8},0.2,Enum.EasingStyle.Quad)ah(b3,{Transparency=0},0.2,Enum.EasingStyle.Quad)ah(b0,{Thickness=b6,Transparency=0.72},0.35,Enum.EasingStyle.Quint)ah(b2,{Offset=Vector2.new(1,0)},0.8,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut)ah(b4,{Rotation=540},2.2,Enum.EasingStyle.Quad)task.spawn(function()task.wait(0.75)ah(b1,{BackgroundTransparency=0.9},0.35,Enum.EasingStyle.Sine)ah(b0,{Thickness=b6/2,Transparency=0.85},0.35,Enum.EasingStyle.Sine)task.wait(0.35)ah(b1,{BackgroundTransparency=0.84},0.3,Enum.EasingStyle.Sine)ah(b0,{Thickness=b6*0.85,Transparency=0.76},0.3,Enum.EasingStyle.Sine)task.wait(0.4)ah(b1,{BackgroundTransparency=1},0.55,Enum.EasingStyle.Quad)ah(b3,{Transparency=1},0.65,Enum.EasingStyle.Quad)ah(b0,{Thickness=b6,Transparency=1},0.65,Enum.EasingStyle.Quad)task.wait(0.7)b1:Destroy()b_:Destroy()if b7 then b7:Destroy()end end)end function a2:_revealResult(bW)local bX,bY,bZ,b_=bW.Tab,bW.Sub,bW.Target,bW.Group if self.CurrentTab~=bX then self:SelectTab(bX)end if bY then bX:SelectSubTab(bY)end if not bZ then local b0=bY and bY._button or bX._button task.delay(0.1,function()if b0.Parent then self:_flash(b0,bY and 8 or 10)end end)return end local b0=b_~=nil and b_:IsCollapsed()if b0 then b_:Expand()end local b1=(bY or bX).List task.spawn(function()task.wait()task.wait()if b0 then task.wait(0.3)end local b2=bZ._frame if self._destroyed or bZ._destroyed or not b2 or not b2.Parent or not b1 then return end local b3=self.Scale.Scale local b4=(b2.AbsolutePosition.Y-b1.AbsolutePosition.Y)/b3+b1.CanvasPosition.Y local b5=b2.AbsoluteSize.Y/b3 local b6=b1.AbsoluteWindowSize.Y/b3 local b7=math.max(b1.AbsoluteCanvasSize.Y/b3-b6,0)local b8=math.clamp(b4+b5/2-b6/2,0,b7)if math.abs(b8-b1.CanvasPosition.Y)>2 then ah(b1,{CanvasPosition=Vector2.new(0,b8)},0.45,Enum.EasingStyle.Quint)task.wait(0.25)end if b2.Parent then self:_flash(b2,bZ._groupbox and 10 or 8)end end)end function a2:_resetSearch()if self.SearchBox and self.SearchBox.Text~=''then self.SearchBox.Text=''end end function a2:_fitTitle(bW)local bX=self.SearchBox and(self._searchWidth or N)+72 or 56 local bY=bW._titleX+bX bW._title.Size=UDim2.new(1,-bY,0,24)if bW._desc then bW._desc.Size=UDim2.new(1,-bY,0,16)end end function a2:_buildSearch(bW)local bX=ai('Frame',{AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,-56,0,14),Size=UDim2.fromOffset(N,34),BackgroundTransparency=1,BorderSizePixel=0,ZIndex=5,Parent=bW})bX:SetAttribute('NoDrag',true)local bY=ai('Frame',{AnchorPoint=Vector2.new(0,1),Position=UDim2.new(0,0,1,-2),Size=UDim2.new(1,0,0,1),BackgroundColor3=z.Stroke,BorderSizePixel=0,Parent=bX})local bZ=ai('Frame',{AnchorPoint=Vector2.new(0.5,1),Position=UDim2.new(0.5,0,1,-1),Size=UDim2.new(0,0,0,2),BackgroundColor3=z.Accent,BorderSizePixel=0,ZIndex=2,Parent=bX})aj(bZ,UDim.new(1,0))local b_,b0=aB(bX,'search',z.Muted,UDim2.new(0,2,0.5,-1))b0.Parent.Size=UDim2.fromOffset(15,15)local b1=ai('TextBox',{Position=UDim2.fromOffset(26,0),Size=UDim2.new(1,-28,1,-2),BackgroundTransparency=1,Text='',PlaceholderText='Search',PlaceholderColor3=z.Muted,TextColor3=z.Text,TextSize=13,FontFace=D.Regular,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,ClearTextOnFocus=false,Parent=bX})bX.MouseEnter:Connect(function()if not b1:IsFocused()then ah(bY,{BackgroundColor3=z.StrokeHover},0.15)end end)bX.MouseLeave:Connect(function()ah(bY,{BackgroundColor3=z.Stroke},0.25)end)self.SearchBox=b1 local b2=E and 40 or 34 local b3=8 local b4=ai('Frame',{AnchorPoint=Vector2.new(1,0),Size=UDim2.fromOffset(300,0),BackgroundTransparency=1,Visible=false,ZIndex=45,Parent=self.Body})b4:SetAttribute('NoDrag',true)local b5=ai('ImageLabel',{Position=UDim2.fromOffset(-18,-12),Size=UDim2.new(1,36,1,36),BackgroundTransparency=1,Image=A.Shadow,ImageColor3=Color3.new(0,0,0),ImageTransparency=1,ScaleType=Enum.ScaleType.Slice,SliceCenter=Rect.new(49,49,450,450),Parent=b4})local b6=ai('Frame',{Size=UDim2.fromScale(1,1),BackgroundColor3=z.Background,BorderSizePixel=0,ClipsDescendants=true,Parent=b4})aj(b6,UDim.new(0,10))local b7=ak(b6,z.Stroke,1)ao(b6)local b8=ai('ScrollingFrame',{Position=UDim2.fromOffset(6,6),Size=UDim2.new(1,-12,1,-12),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=E and 4 or 3,ScrollBarImageColor3=z.Accent,ScrollBarImageTransparency=0.4,ScrollingDirection=Enum.ScrollingDirection.Y,CanvasSize=UDim2.new(),Parent=b6})ai('UIListLayout',{SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,2),Parent=b8})local b9=am({Size=UDim2.new(1,0,0,b2),Text='No results',TextSize=13,FontFace=D.Regular,TextColor3=z.Muted,TextXAlignment=Enum.TextXAlignment.Center,LayoutOrder=0,Visible=false,Parent=b8})local ca={}local cb={}local cc=1 local cd=false local ce=0 local cf=Vector2.new(300,0)local cg=nil local ch local function ci()local cj=self.Scale.Scale local ck=self.Body.AbsolutePosition local cl=self.Body.AbsoluteSize.X/cj local cm=(bX.AbsolutePosition.X+bX.AbsoluteSize.X-ck.X)/cj local cn=(bX.AbsolutePosition.Y+bX.AbsoluteSize.Y-ck.Y)/cj+6 cm=math.clamp(cm,cf.X+8,math.max(cl-8,cf.X+8))b4.Position=UDim2.fromOffset(cm,cn)end local function cj()local ck=self.Scale.Scale local cl=self.Body.AbsoluteSize/ck local cm=(bX.AbsolutePosition.Y+bX.AbsoluteSize.Y-self.Body.AbsolutePosition.Y)/ck+6 local cn=math.max(#ca,1)local co=math.min(cn,b3)*(b2+2)-2+12 co=math.max(math.min(co,cl.Y-cm-12),b2+12)local cp=math.min(math.max(bX.AbsoluteSize.X/ck,300),math.max(cl.X-16,160))cf=Vector2.new(cp,co)end local function ck()for cl,cm in ipairs(ca)do local cn=cl==cc ah(cm.Button,{BackgroundTransparency=cn and 0.35 or 1},0.12)ar(cm.Icon,cn and z.Accent or z.Muted,cn,0.12)end end local function cl()local cm=(cc-1)*(b2+2)local cn=b8.AbsoluteWindowSize.Y/self.Scale.Scale local co=b8.CanvasPosition.Y if cm<co then co=cm elseif cm+b2>co+cn then co=cm+b2-cn else return end b8.CanvasPosition=Vector2.new(0,math.max(co,0))end local function cm(cn)if cn==cd then return end cd=cn ce+=1 local co=ce if cn then if self._closePopup and self._closePopup~=ch then self._closePopup()end self._closePopup=ch ci()b4.Size=UDim2.fromOffset(cf.X,0)b4.Visible=true ah(b4,{Size=UDim2.fromOffset(cf.X,cf.Y)},0.26,Enum.EasingStyle.Quint)ah(b7,{Transparency=0},0.12)ah(b5,{ImageTransparency=0.55},0.26)if not cg then cg=self:_listen('Render',ci)end else if self._closePopup==ch then self._closePopup=nil end ah(b4,{Size=UDim2.fromOffset(cf.X,0)},0.18,Enum.EasingStyle.Quint)ah(b5,{ImageTransparency=1},0.14)task.delay(0.19,function()if ce==co and not cd then b4.Visible=false b7.Transparency=1 if cg then cg()cg=nil end end end)end end ch=function()cm(false)end local function cn(co)if not co then return end cm(false)b1.Text=''if b1:IsFocused()then b1:ReleaseFocus()end self:_revealResult(co)end local function co(cp)return(string.gsub(string.gsub(string.gsub(cp,'&','&amp;'),'<','&lt;'),'>','&gt;'))end local function cp(cq)for cr,cs in ipairs(ca)do cs.Button:Destroy()end table.clear(ca)cb=self:_searchResults(cq)cc=1 local cr=bc(z.Accent)for cs,ct in ipairs(cb)do if cs>50 then break end local cu=ai('TextButton',{Size=UDim2.new(1,0,0,b2),BackgroundColor3=z.Surface3,BackgroundTransparency=1,Text='',AutoButtonColor=false,LayoutOrder=cs,Parent=b8})aj(cu,UDim.new(0,7))local cv=ai('Frame',{Position=UDim2.fromOffset(10,0),Size=UDim2.new(1,-20,1,0),BackgroundTransparency=1,ClipsDescendants=true,Parent=cu})ai('UIListLayout',{FillDirection=Enum.FillDirection.Horizontal,VerticalAlignment=Enum.VerticalAlignment.Center,SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,5),Parent=cv})local cw=0 local cx=nil local function cy(cz)if not cz then return end cw+=1 local cA=ai('ImageLabel',{Size=UDim2.fromOffset(14,14),BackgroundTransparency=1,ImageColor3=z.Muted,ScaleType=Enum.ScaleType.Fit,LayoutOrder=cw,Parent=cv})aq(cA,cz)cx=cx or cA end local function cz(cA,cB,cC)cw+=1 return am({Size=UDim2.new(0,0,1,0),AutomaticSize=Enum.AutomaticSize.X,Text=cA,RichText=cC==true,TextSize=13,FontFace=cB and D.Medium or D.Regular,TextColor3=cB or z.Muted,TextTruncate=Enum.TextTruncate.None,LayoutOrder=cw,Parent=cv})end local function cA()cz('>')end local cB,cC,cD=ct.Tab,ct.Sub,ct.Group local cE=ct.Kind=='Tab'local cF=ct.Kind=='Page'local cG=ct.Kind=='Groupbox'cy(cB._iconName or'layout-grid')if not cE then cz(cB.Name)if cC then cA()cy(cC._iconName or'layers')if not cF then cz(cC.Name)end end if cD and not cG then cA()cz(cD.Name)end if not cF then cA()end end local cH=ct.Name local cI=ct.At+#cq local cJ=co(string.sub(cH,1,ct.At-1))..'<b>'..co(string.sub(cH,ct.At,cI-1))..'</b>'..co(string.sub(cH,cI))cz(cJ,z.Accent,true)local cK=cx local cL=ay(cu,function()return b8 end)cu.MouseEnter:Connect(function()if not ax()then cc=cs ck()end end)cu.MouseButton1Click:Connect(function()if cL()then cn(ct)end end)table.insert(ca,{Button=cu,Icon=cK})end b9.Visible=#ca==0 b8.CanvasSize=UDim2.fromOffset(0,math.max(#ca,1)*(b2+2)-2)b8.CanvasPosition=Vector2.zero ck()cj()if cd then ci()ah(b4,{Size=UDim2.fromOffset(cf.X,cf.Y)},0.2,Enum.EasingStyle.Quint)end end local function cq()local cr=string.match(string.lower(b1.Text),'^%s*(.-)%s*$')if cr==''then cm(false)return end cp(cr)cm(true)end b1.Focused:Connect(function()ah(bZ,{Size=UDim2.new(1,0,0,2)},0.35,Enum.EasingStyle.Quint)ah(b0,{ImageColor3=z.Accent},0.15)if b1.Text~=''then cq()end end)b1.FocusLost:Connect(function(cr)ah(bZ,{Size=UDim2.new(0,0,0,2)},0.3,Enum.EasingStyle.Quint)ah(b0,{ImageColor3=z.Muted},0.2)if cr and cd then cn(cb[cc])end end)b1:GetPropertyChangedSignal('Text'):Connect(cq)self:_listen('Began',function(cr)if not cd then return end if cr.KeyCode==Enum.KeyCode.Up or cr.KeyCode==Enum.KeyCode.Down then if#ca>0 then local cs=cr.KeyCode==Enum.KeyCode.Up and-1 or 1 cc=math.clamp(cc+cs,1,#ca)ck()cl()end elseif cr.KeyCode==Enum.KeyCode.Escape then cm(false)elseif aw(cr)then local cs=av()if not az(cs,b4)and not az(cs,bX)then cm(false)end end end)local function cr()local cs=bW.AbsoluteSize.X/self.Scale.Scale local ct=math.clamp(math.floor(cs*0.32),110,N)bX.Size=UDim2.fromOffset(ct,34)if ct~=self._searchWidth then self._searchWidth=ct for cu,cv in ipairs(self.Tabs)do self:_fitTitle(cv)end end end bW:GetPropertyChangedSignal('AbsoluteSize'):Connect(cr)task.defer(cr)end function a2:_trackName(bW,bX)table.insert(self._identity.Names,{Label=bW,Kind=bX})self:_renderIdentity()end function a2:_trackAvatar(bW,bX)table.insert(self._identity.Avatars,{Image=bW,Placeholder=bX})self:_renderIdentity(true)end function a2:_renderIdentity(bW)for bX,bY in ipairs(self._identity.Names)do if bY.Kind=='User'then bY.Label.Text=self._hideName and'@hidden'or('@'..j.Name)else bY.Label.Text=self._hideName and'Hidden'or j.DisplayName end end local bX=bW and 0 or 0.2 for bY,bZ in ipairs(self._identity.Avatars)do ah(bZ.Image,{ImageTransparency=self._hideAvatar and 1 or 0},bX)ah(bZ.Placeholder,{ImageTransparency=self._hideAvatar and 0.2 or 1},bX)end end function a2:SetHideName(bW)self._hideName=bW==true self:_renderIdentity()end function a2:SetHideAvatar(bW)self._hideAvatar=bW==true self:_renderIdentity()end local function bW(bX,bY,bZ,b_,b0,b1)local b2=ai('Frame',{BackgroundColor3=z.Surface3,BorderSizePixel=0,Parent=bY})for b3,b4 in pairs(bZ)do b2[b3]=b4 end aj(b2,UDim.new(1,0))ak(b2,b_ or z.Stroke,b0 or 0,b1 or 1)local b3=ai('ImageLabel',{Size=UDim2.fromScale(1,1),BackgroundTransparency=1,Image='rbxthumb://type=AvatarHeadShot&id='..tostring(j.UserId)..'&w=150&h=150',Parent=b2})aj(b3,UDim.new(1,0))local b4=ai('ImageLabel',{AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.fromScale(0.5,0.5),Size=UDim2.fromScale(0.45,0.45),BackgroundTransparency=1,ImageColor3=z.Muted,ImageTransparency=1,ScaleType=Enum.ScaleType.Fit,Parent=b2})aq(b4,'user')bX:_trackAvatar(b3,b4)return b2 end function a2:_buildProfile(bX)ai('Frame',{AnchorPoint=Vector2.new(0.5,1),Position=UDim2.new(0.5,0,1,-M),Size=UDim2.new(1,-20,0,1),BackgroundColor3=z.Stroke,BorderSizePixel=0,Parent=bX})local bY=ai('TextButton',{AnchorPoint=Vector2.new(0.5,1),Position=UDim2.new(0.5,0,1,-8),Size=UDim2.new(1,-16,0,M-16),BackgroundColor3=z.Surface2,BackgroundTransparency=0,Text='',AutoButtonColor=false,Parent=bX})aj(bY,UDim.new(0,8))local bZ=ak(bY,z.Stroke,0)local b_=bW(self,bY,{AnchorPoint=Vector2.new(0,0.5),Position=UDim2.new(0,8,0.5,0),Size=UDim2.fromOffset(32,32)})local b0=ai('Frame',{AnchorPoint=Vector2.new(1,1),Position=UDim2.new(1,1,1,1),Size=UDim2.fromOffset(9,9),BackgroundColor3=z.Success,BorderSizePixel=0,ZIndex=2,Parent=b_})aj(b0,UDim.new(1,0))ak(b0,z.Surface2,0,2)local b1=am({Position=UDim2.new(0,48,0.5,-15),Size=UDim2.new(1,-74,0,15),TextSize=12,FontFace=D.Bold,Parent=bY})self:_trackName(b1,'Display')local b2=am({Position=UDim2.new(0,48,0.5,1),Size=UDim2.new(1,-74,0,13),Text='\u{2026}',TextSize=11,FontFace=D.Regular,TextColor3=z.Muted,Parent=bY})local b3=ai('ImageLabel',{AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-8,0.5,0),Size=UDim2.fromOffset(14,14),BackgroundTransparency=1,ImageColor3=z.Muted,ScaleType=Enum.ScaleType.Fit,Parent=bY})aq(b3,'chevron-right')task.spawn(function()b2.Text=aZ()end)bY.MouseEnter:Connect(function()if ax()then return end ah(bZ,{Color=z.StrokeHover},0.12)ah(b3,{ImageColor3=z.Text,Position=UDim2.new(1,-6,0.5,0)},0.15)end)bY.MouseLeave:Connect(function()ah(bZ,{Color=z.Stroke},0.2)ah(b3,{ImageColor3=z.Muted,Position=UDim2.new(1,-8,0.5,0)},0.2)end)bY.MouseButton1Click:Connect(function()if self.Home then self:SelectTab(self.Home)end end)self.Profile=bY end function a2:Rejoin()self:Notify({Title='Rejoining',Content='Teleporting back into this server',Icon='refresh-cw',Duration=3})task.spawn(function()local bX,bY=pcall(function()if#f:GetPlayers()<=1 or game.JobId==''then g:Teleport(game.PlaceId,j)else g:TeleportToPlaceInstance(game.PlaceId,game.JobId,j)end end)if not bX then self:Notify({Title='Rejoin failed',Content=tostring(bY),Type='Error',Duration=4})end end)end local function bX(bY,bZ,b_,b0)task.spawn(function()local b1=bD(bZ)if not b1 then bY:Notify({Title=b0..' failed',Content='Could not load the server list',Type='Error',Duration=4})return end local b2={}for b3,b4 in ipairs(b1)do if type(b4)=='table'and b4.id~=game.JobId then local b5,b6=tonumber(b4.playing),tonumber(b4.maxPlayers)if b5 and b6 and b5<b6 then table.insert(b2,b4)end end end local b3=#b2>0 and b_(b2)or nil if not b3 then bY:Notify({Title=b0..' failed',Content='No other open server found',Type='Warning',Duration=4})return end bY:Notify({Title=b0,Content=string.format('Joining a server with %d/%d players',b3.playing,b3.maxPlayers),Icon='server',Duration=3})local b4,b5=pcall(function()g:TeleportToPlaceInstance(game.PlaceId,b3.id,j)end)if not b4 then bY:Notify({Title=b0..' failed',Content=tostring(b5),Type='Error',Duration=4})end end)end function a2:ServerHop()bX(self,'Desc',function(bY)return bY[math.random(1,#bY)]end,'Server hop')end function a2:JoinLowestServer()bX(self,'Asc',function(bY)table.sort(bY,function(bZ,b_)return bZ.playing<b_.playing end)return bY[1]end,'Lowest server')end function a2:CopyToClipboard(bY,bZ)local b_=bC(bY)self:Notify({Title=b_ and'Copied'or'Clipboard unavailable',Content=b_ and(bZ or tostring(bY))or'Your executor has no setclipboard',Type=b_ and'Success'or'Error',Icon=b_ and'clipboard-check'or nil,Duration=2.5})return b_ end function a2:_homeCard(bY,bZ)local b_=bG(bY,0,bZ)b_.AutomaticSize=Enum.AutomaticSize.Y al(b_,16,16,14,14)ai('UIListLayout',{SortOrder=Enum.SortOrder.LayoutOrder,Parent=b_})return b_ end function a2:_homeCaption(bY,bZ,b_)return am({Size=UDim2.new(1,0,0,22),Text=string.upper(bZ),TextSize=10,TextColor3=z.Muted,TextYAlignment=Enum.TextYAlignment.Top,LayoutOrder=b_,Parent=bY})end function a2:_homeChip(bY,bZ,b_,b0,b1)local b2=ai('TextButton',{Size=UDim2.fromOffset(0,24),AutomaticSize=Enum.AutomaticSize.X,BackgroundColor3=z.Surface3,BackgroundTransparency=0.2,BorderSizePixel=0,Text='',AutoButtonColor=false,LayoutOrder=bZ,Parent=bY})aj(b2,UDim.new(0,6))local b3=ak(b2)al(b2,8,9)ai('UIListLayout',{FillDirection=Enum.FillDirection.Horizontal,VerticalAlignment=Enum.VerticalAlignment.Center,SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,6),Parent=b2})local b4=ai('ImageLabel',{Size=UDim2.fromOffset(12,12),BackgroundTransparency=1,ImageColor3=b1 or z.Muted,ScaleType=Enum.ScaleType.Fit,LayoutOrder=1,Parent=b2})aq(b4,b_)local b5=am({Size=UDim2.new(0,0,1,0),AutomaticSize=Enum.AutomaticSize.X,Text=b0,TextSize=12,TextColor3=b1 or z.Muted,TextTruncate=Enum.TextTruncate.None,LayoutOrder=2,Parent=b2})return b2,b5,b4,b3 end function a2:_homeToggleChip(bY,bZ,b_,b0,b1,b2)local b3,b4,b5,b6=self:_homeChip(bY,bZ,b_,b0)local b7=b1==true local function b8(b9)ah(b3,{BackgroundColor3=b7 and z.Accent or z.Surface3,BackgroundTransparency=b7 and 0.85 or 0.2},b9)ah(b6,{Color=b7 and z.Accent or z.Stroke,Transparency=b7 and 0.6 or 0},b9)ah(b4,{TextColor3=b7 and z.Accent or z.Muted},b9)ah(b5,{ImageColor3=b7 and z.Accent or z.Muted},b9)end b8(0)b3.MouseButton1Click:Connect(function()b7=not b7 b8(0.2)aJ(b2,b7)end)return b3 end function a2:_homeProfile(bY,bZ,b_)local b0=bG(bY,140,b_)b0.ClipsDescendants=true local b1=ai('ImageLabel',{AnchorPoint=Vector2.new(1,1),Position=UDim2.new(1,-16,1,0),Size=UDim2.fromOffset(140,140),BackgroundTransparency=1,Image='rbxthumb://type=AvatarBust&id='..tostring(j.UserId)..'&w=420&h=420',ScaleType=Enum.ScaleType.Fit,Parent=b0})ai('UIGradient',{Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(0.45,0),NumberSequenceKeypoint.new(1,0)}),Parent=b1})local b2=ai('ImageLabel',{AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.fromScale(0.6,0.55),Size=UDim2.fromOffset(40,40),BackgroundTransparency=1,ImageColor3=z.Muted,ImageTransparency=1,ScaleType=Enum.ScaleType.Fit,Parent=b1})aq(b2,'user')self:_trackAvatar(b1,b2)local b3=UDim2.new(1,-190,0,0)am({Position=UDim2.fromOffset(22,20),Size=b3+UDim2.fromOffset(0,14),Text=string.upper(bZ.Welcome or'Welcome back'),TextSize=10,TextColor3=z.Muted,Parent=b0})local b4=am({Position=UDim2.fromOffset(22,35),Size=b3+UDim2.fromOffset(0,32),TextSize=26,FontFace=D.Bold,Parent=b0})self:_trackName(b4,'Display')local b5=am({Position=UDim2.fromOffset(22,67),Size=b3+UDim2.fromOffset(0,16),TextSize=13,FontFace=D.Regular,TextColor3=z.Muted,Parent=b0})self:_trackName(b5,'User')local b6=ai('Frame',{Position=UDim2.new(0,22,1,-40),Size=UDim2.new(1,-44,0,24),BackgroundTransparency=1,Parent=b0})ai('UIListLayout',{FillDirection=Enum.FillDirection.Horizontal,VerticalAlignment=Enum.VerticalAlignment.Center,SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,6),Parent=b6})local b7=bZ.Tier if b7==nil then b7='Free'end if b7 then local b8,b9,ca=self:_homeChip(b6,1,bZ.TierIcon or self._logoIcon,tostring(b7),z.Accent)b8.Active=false b9.FontFace=D.Bold ca.Size=UDim2.fromOffset(13,13)self.TierLabel=b9 end local b8,b9=self:_homeChip(b6,2,'clock','')b8.Active=false b8.Visible=false self:_homeToggleChip(b6,3,'eye-off','Name',self._hideName,function(ca)self:SetHideName(ca)end)self:_homeToggleChip(b6,4,'user-x','Avatar',self._hideAvatar,function(ca)self:SetHideAvatar(ca)end)return function()local ca=bZ.Expiry if type(ca)=='function'then local cb,cc=pcall(ca)ca=cb and cc or nil end if type(ca)=='number'then local cb=ca-os.time()b9.Text=cb>0 and(bA(cb)..' left')or'Expired'elseif ca~=nil then b9.Text=tostring(ca)end b8.Visible=b9.Text~=''end end function a2:_homeGraph(bY,bZ,b_,b0,b1)local b2=ai('Frame',{BackgroundTransparency=1,LayoutOrder=bZ,Parent=bY})local b3=aB(b2,b_,z.Muted,UDim2.new(0,0,0,7))b3.Size=UDim2.fromOffset(12,12)am({Position=UDim2.fromOffset(18,0),Size=UDim2.new(1,-18,0,14),Text=string.upper(b0),TextSize=10,TextColor3=z.Muted,Parent=b2})local b4=am({Position=UDim2.fromOffset(0,16),Size=UDim2.new(1,0,0,28),Text='\u{2026}',TextSize=24,FontFace=D.Bold,RichText=true,Parent=b2})local b5=ai('Frame',{Position=UDim2.fromOffset(0,50),Size=UDim2.new(1,0,0,26),BackgroundTransparency=1,Parent=b2})ai('UIListLayout',{FillDirection=Enum.FillDirection.Horizontal,VerticalAlignment=Enum.VerticalAlignment.Bottom,SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,2),Parent=b5})local b6=24 local b7,b8={},{}for b9=1,b6 do local ca=ai('Frame',{Size=UDim2.new(1/b6,-2,0,2),BackgroundColor3=z.Surface3,BorderSizePixel=0,LayoutOrder=b9,Parent=b5})aj(ca,UDim.new(0,2))b7[b9]=ca end local function b9(ca,cb)table.insert(b8,ca)if#b8>b6 then table.remove(b8,1)end local cc=b1 or 1 for cd,ce in ipairs(b8)do cc=math.max(cc,ce)end local cd=b6-#b8 for ce,cf in ipairs(b7)do local cg=b8[ce-cd]local ch=ce==b6 local ci=cg and math.max(cg/cc,0.08)or 0 ah(cf,{Size=UDim2.new(1/b6,-2,ci,cg and 0 or 2),BackgroundColor3=(ch and cb)or(cg and z.Muted or z.Surface3),BackgroundTransparency=ch and 0 or(cg and 0.6 or 0)},0.35,Enum.EasingStyle.Quint)end end return b4,b9 end function a2:_homeFigure(bY,bZ,b_)local b0=ai('Frame',{BackgroundTransparency=1,LayoutOrder=bZ,Parent=bY})local b1=am({Size=UDim2.new(1,-8,0,20),Text='\u{2026}',TextSize=15,FontFace=D.Bold,RichText=true,Parent=b0})am({Position=UDim2.fromOffset(0,21),Size=UDim2.new(1,-8,0,14),Text=string.upper(b_),TextSize=10,TextColor3=z.Muted,Parent=b0})return b1 end function a2:_homeAction(bY,bZ,b_,b0,b1)local b2=ai('TextButton',{BackgroundColor3=z.Surface3,BackgroundTransparency=0.5,BorderSizePixel=0,Text='',AutoButtonColor=false,ClipsDescendants=true,LayoutOrder=bZ,Parent=bY})aj(b2,UDim.new(0,8))local b3=ak(b2)local b4=ai('ImageLabel',{AnchorPoint=Vector2.new(0.5,0),Position=UDim2.new(0.5,0,0,11),Size=UDim2.fromOffset(16,16),BackgroundTransparency=1,ImageColor3=z.Text,ScaleType=Enum.ScaleType.Fit,Parent=b2})aq(b4,b_)am({Position=UDim2.new(0,4,0,32),Size=UDim2.new(1,-8,0,14),Text=b0,TextSize=11,TextColor3=z.Muted,TextXAlignment=Enum.TextXAlignment.Center,Parent=b2})b2.MouseEnter:Connect(function()ah(b2,{BackgroundTransparency=0},0.15,Enum.EasingStyle.Quint)ah(b3,{Color=z.StrokeHover},0.15)ah(b4,{ImageColor3=z.Accent},0.15)end)b2.MouseLeave:Connect(function()ah(b2,{BackgroundTransparency=0.5},0.25,Enum.EasingStyle.Quint)ah(b3,{Color=z.Stroke},0.25)ah(b4,{ImageColor3=z.Text},0.25)end)b2.MouseButton1Click:Connect(function()aE(b2)aJ(b1)end)return b2 end function a2:_homeGame(bY,bZ)local b_=self:_homeCard(bY,bZ)local b0=ai('Frame',{Size=UDim2.new(1,0,0,46),BackgroundTransparency=1,LayoutOrder=1,Parent=b_})local b1=ai('ImageLabel',{Size=UDim2.fromOffset(44,44),BackgroundColor3=z.Surface3,BorderSizePixel=0,Image='rbxthumb://type=GameIcon&id='..tostring(game.GameId)..'&w=150&h=150',Parent=b0})aj(b1,UDim.new(0,10))ak(b1)local b2=am({Position=UDim2.fromOffset(56,3),Size=UDim2.new(1,-56,0,20),Text='Loading',TextSize=15,FontFace=D.Bold,Parent=b0})local b3=am({Position=UDim2.fromOffset(56,24),Size=UDim2.new(1,-56,0,16),Text='',TextSize=12,FontFace=D.Regular,TextColor3=z.Muted,Parent=b0})local b4=nil task.spawn(function()local b5=aY()b2.Text=b5 and b5.Name or aZ()b4=b5 and type(b5.Creator)=='table'and b5.Creator.Name or nil end)local b5=ai('Frame',{Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,BackgroundTransparency=1,LayoutOrder=2,Parent=b_})al(b5,0,0,12,0)ai('UIGridLayout',{CellPadding=UDim2.fromOffset(6,6),CellSize=UDim2.new(0.25,-5,0,54),SortOrder=Enum.SortOrder.LayoutOrder,Parent=b5})self:_homeAction(b5,1,'refresh-cw','Rejoin',function()self:Rejoin()end)self:_homeAction(b5,2,'shuffle','Hop',function()self:ServerHop()end)self:_homeAction(b5,3,'users','Lowest',function()self:JoinLowestServer()end)self:_homeAction(b5,4,'copy','Job ID',function()self:CopyToClipboard(game.JobId,'Job ID')end)am({Size=UDim2.new(1,0,0,26),Text='Job '..bB(game.JobId)..'  \u{b7}  Place '..tostring(game.PlaceId),TextSize=11,FontFace=D.Regular,TextColor3=z.Muted,TextYAlignment=Enum.TextYAlignment.Bottom,LayoutOrder=3,Parent=b_})return function()local b6=#f:GetPlayers()..'/'..f.MaxPlayers..' players'b3.Text=b4 and('by '..b4..'  \u{b7}  '..b6)or b6 end end function a2:_homeLink(bY,bZ,b_,b0,b1,b2,b3)local b4=ai('Frame',{Size=UDim2.new(1,0,0,46),BackgroundTransparency=1,LayoutOrder=bZ,Parent=bY})ai('Frame',{Name='Rule',Size=UDim2.new(1,0,0,1),BackgroundColor3=z.Stroke,BorderSizePixel=0,Parent=b4})local b5=aB(b4,b_,z.Accent,UDim2.new(0,0,0.5,0))b5.Size=UDim2.fromOffset(16,16)local b6=am({Position=UDim2.fromOffset(28,6),Size=UDim2.new(1,-68,0,18),Text=b0,TextSize=13,Parent=b4})local b7=am({Position=UDim2.fromOffset(28,24),Size=UDim2.new(1,-68,0,15),Text=b1,TextSize=12,FontFace=D.Regular,TextColor3=z.Muted,Parent=b4})local b8=ai('TextButton',{AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,0,0.5,0),Size=UDim2.fromOffset(30,30),BackgroundColor3=z.Surface3,BackgroundTransparency=0.5,BorderSizePixel=0,Text='',AutoButtonColor=false,Parent=b4})aj(b8,UDim.new(0,8))local b9=ak(b8)local ca=ai('ImageLabel',{AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.fromScale(0.5,0.5),Size=UDim2.fromOffset(14,14),BackgroundTransparency=1,ImageColor3=z.Muted,ScaleType=Enum.ScaleType.Fit,Parent=b8})aq(ca,b2)b8.MouseEnter:Connect(function()ah(b8,{BackgroundTransparency=0},0.15,Enum.EasingStyle.Quint)ah(b9,{Color=z.StrokeHover},0.15)ah(ca,{ImageColor3=z.Accent},0.15)end)b8.MouseLeave:Connect(function()ah(b8,{BackgroundTransparency=0.5},0.25,Enum.EasingStyle.Quint)ah(b9,{Color=z.Stroke},0.25)ah(ca,{ImageColor3=z.Muted},0.25)end)b8.MouseButton1Click:Connect(function()aJ(b3)end)return b4,b6,b7 end function a2:_homeLinks(bY,bZ,b_)local b0={}if bZ.Discord then table.insert(b0,{Icon=bZ.DiscordIcon or'message-circle',Title=bZ.DiscordTitle or'Community',Text=bZ.Discord})end if bZ.Website then table.insert(b0,{Icon=bZ.WebsiteIcon or'globe',Title=bZ.WebsiteTitle or'Website',Text=bZ.Website})end for b1,b2 in ipairs(bZ.Links or{})do table.insert(b0,b2)end local b1=bZ.Features if#b0==0 and b1==false then return nil,function()end end local b2=self:_homeCard(bY,b_)self:_homeCaption(b2,'Links',0)for b3,b4 in ipairs(b0)do local b5=type(b4.Callback)=='function'self:_homeLink(b2,b3,b4.Icon or'link',b4.Title or'',b4.Text or'',b5 and'arrow-up-right'or'copy',function()if b5 then aJ(b4.Callback)else self:CopyToClipboard(b4.Copy or b4.Text,b4.Title)end end)end local b3=function()end if b1~=false then if type(b1)=='table'then self._featuresTitle=b1.Title self._features=b1.List or(#b1>0 and b1 or nil)end local b4,b5,b6=self:_homeLink(b2,100,type(b1)=='table'and b1.Icon or'list-checks',type(b1)=='table'and b1.Title or'Feature list','','chevron-right',function()self:ShowFeatures()end)b3=function()local b7=type(b1)=='table'and b1.Desc b6.Text=b7 or(self:_featureSummary())end task.defer(b3)end local b5=nil for b6,b7 in ipairs(b2:GetChildren())do if b7:IsA('Frame')and b7:FindFirstChild('Rule')and(not b5 or b7.LayoutOrder<b5.LayoutOrder)then b5=b7 end end if b5 then b5.Rule.Visible=false end return b2,b3 end function a2:_homeExecutor(bY,bZ,b_)local b0=ai('Frame',{Size=UDim2.new(1,0,0,26),BackgroundTransparency=1,LayoutOrder=b_,Parent=bY})local b1,b2,b3=aV(bZ)local b5=ai('Frame',{AnchorPoint=Vector2.new(0,0.5),Position=UDim2.new(0,4,0.5,0),Size=UDim2.fromOffset(7,7),BackgroundColor3=b2 and z.Success or z.Warning,BorderSizePixel=0,Parent=b0})aj(b5,UDim.new(1,0))local b6=ai('Frame',{Position=UDim2.fromOffset(18,0),Size=UDim2.new(1,-170,1,0),BackgroundTransparency=1,ClipsDescendants=true,Parent=b0})ai('UIListLayout',{FillDirection=Enum.FillDirection.Horizontal,VerticalAlignment=Enum.VerticalAlignment.Center,SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,8),Parent=b6})am({Size=UDim2.new(0,0,1,0),AutomaticSize=Enum.AutomaticSize.X,Text=b1,TextSize=12,TextTruncate=Enum.TextTruncate.None,LayoutOrder=1,Parent=b6})am({Size=UDim2.new(0,0,1,0),AutomaticSize=Enum.AutomaticSize.X,Text=b3,TextSize=12,FontFace=D.Regular,TextColor3=b2 and z.Muted or z.Warning,TextTruncate=Enum.TextTruncate.None,LayoutOrder=2,Parent=b6})local b7=ai('Frame',{AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-2,0.5,0),Size=UDim2.fromOffset(0,22),AutomaticSize=Enum.AutomaticSize.X,BackgroundTransparency=1,Parent=b0})ai('UIListLayout',{FillDirection=Enum.FillDirection.Horizontal,VerticalAlignment=Enum.VerticalAlignment.Center,SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,6),Parent=b7})am({Size=UDim2.new(0,0,1,0),AutomaticSize=Enum.AutomaticSize.X,Text=E and'Tap the pill or'or'Hide with',TextSize=12,FontFace=D.Regular,TextColor3=z.Muted,TextTruncate=Enum.TextTruncate.None,LayoutOrder=1,Parent=b7})local b8=ai('Frame',{Size=UDim2.fromOffset(0,20),AutomaticSize=Enum.AutomaticSize.X,BackgroundColor3=z.Surface3,BorderSizePixel=0,LayoutOrder=2,Parent=b7})aj(b8,UDim.new(0,5))ak(b8)al(b8,6,6)self._keyChipLabel=am({Size=UDim2.new(0,0,1,0),AutomaticSize=Enum.AutomaticSize.X,Text=aI(self.Keybind),TextSize=11,FontFace=D.Bold,TextTruncate=Enum.TextTruncate.None,Parent=b8})end a2._featureKinds={Toggle=true,Slider=true,Dropdown=true,Input=true,Keybind=true,ColorPicker=true,Stepper=true,Button=true,ButtonRow=true,OrderList=true}function a2:_featureGroups()local bY,bZ={},{}for b_,b0 in ipairs(self.Tabs)do if b0~=self.Home and b0._userVisible~=false then local b1={Name=b0.Name,Icon=b0._iconName,Items={}}for b2,b3 in ipairs(b0._subTabs or{b0})do local b5=b3._isSubTab and b3 or nil local function b6(b7,b8,b9,ca)if type(b7)~='string'or b7==''then return end local cb={Name=b7,Kind=b8._type=='ButtonRow'and'Button'or b8._type,Path=ca,Result={Tab=b0,Sub=b5,Target=b8,Group=b9}}table.insert(b1.Items,cb)bZ[string.lower(b7)]=bZ[string.lower(b7)]or cb end local function b7(b8,b9,ca)if b8._destroyed or not self._featureKinds[b8._type]or(b8._isShown and not b8:_isShown())then return end if b8._type=='ButtonRow'and b8.Buttons then for cb,cc in ipairs(b8.Buttons)do b6(cc.Label.Text,b8,b9,ca)end else b6(b8._searchName,b8,b9,ca)end end if not b3._noSearch then for b8,b9 in ipairs(b3._items or{})do b7(b9,nil,b5 and b5.Name or nil)end for b8,b9 in ipairs(b3._groupboxes or{})do if b9._userVisible~=false and not b9._manager then for ca,cb in ipairs(b9._items)do b7(cb,b9,b5 and(b5.Name..'  \u{203a}  '..b9.Name)or b9.Name)end end end end end if#b1.Items>0 then table.insert(bY,b1)end end end local b_=self._features if type(b_)~='table'then return bY end local function b0(b1)if type(b1)~='table'then b1={Name=b1}end local b2=tostring(b1.Name or b1.Title or b1[1]or'')local b3=bZ[string.lower(b2)]return{Name=b2,Desc=b1.Desc or b1.Description,Tag=b1.Tag,Icon=b1.Icon,Kind=b3 and b3.Kind,Path=b3 and b3.Path,Result=b3 and b3.Result,Callback=b1.Callback}end local b1,b2={},nil for b3,b5 in ipairs(b_)do if type(b5)=='table'and type(b5.Items)=='table'then local b6={Name=tostring(b5.Name or b5.Title or'Features'),Icon=b5.Icon,Items={}}for b7,b8 in ipairs(b5.Items)do table.insert(b6.Items,b0(b8))end table.insert(b1,b6)else if not b2 then b2={Name=self._featuresTitle or'Features',Items={}}table.insert(b1,b2)end table.insert(b2.Items,b0(b5))end end return b1 end function a2:_featureSummary()local bY=self:_featureGroups()local bZ=0 for b_,b0 in ipairs(bY)do bZ+=#b0.Items end local b_=bZ..(bZ==1 and' feature'or' features')if type(self._features)~='table'and#bY>0 then b_..=' across '..#bY..(#bY==1 and' tab'or' tabs')end return b_,bY,bZ end function a2:ShowFeatures()if self._dialog then self._dialog.Close()end local bY,bZ,b_=self:_featureSummary()local b0=16 local b1=E and 44 or 38 local b2=self.Body local b3=ai('TextButton',{Size=UDim2.fromScale(1,1),BackgroundColor3=Color3.new(0,0,0),BackgroundTransparency=1,Text='',AutoButtonColor=false,ZIndex=40,Parent=b2})local b5=ai('CanvasGroup',{AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.new(0.5,0,0.5,10),Size=UDim2.fromOffset(420,460),BackgroundColor3=z.Background,BorderSizePixel=0,GroupTransparency=1,Active=true,Parent=b3})aj(b5,UDim.new(0,12))local b6=ak(b5,z.Stroke,1)local b7=ai('UIScale',{Scale=0.94,Parent=b5})local function b8()local b9=self.Scale.Scale local ca=b2.AbsoluteSize/b9 b5.Size=UDim2.fromOffset(math.min(440,ca.X-24),math.min(480,ca.Y-24))end b8()local b9=b2:GetPropertyChangedSignal('AbsoluteSize'):Connect(b8)local ca=aB(b5,'list-checks',z.Accent,UDim2.new(0,b0,0,b0+10))ca.Size=UDim2.fromOffset(18,18)am({Position=UDim2.fromOffset(b0+28,b0),Size=UDim2.new(1,-(b0*2+28+36),0,18),Text=self._featuresTitle or'Features',TextSize=15,Parent=b5})am({Position=UDim2.fromOffset(b0+28,b0+19),Size=UDim2.new(1,-(b0*2+28+36),0,14),Text=bY,TextSize=12,FontFace=D.Regular,TextColor3=z.Muted,Parent=b5})local cb=ai('TextButton',{AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,-(b0-6),0,b0-6),Size=E and UDim2.fromOffset(40,40)or UDim2.fromOffset(32,32),BackgroundColor3=z.Surface3,BackgroundTransparency=1,Text='',AutoButtonColor=false,Parent=b5})aj(cb,UDim.new(0,8))local cc=ai('ImageLabel',{AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.fromScale(0.5,0.5),Size=UDim2.fromOffset(16,16),BackgroundTransparency=1,ImageColor3=z.Muted,ScaleType=Enum.ScaleType.Fit,Parent=cb})aq(cc,'x')if cc.Image==''then cc:Destroy()am({Size=UDim2.fromScale(1,1),Text='\u{d7}',TextSize=20,TextColor3=z.Muted,TextXAlignment=Enum.TextXAlignment.Center,Parent=cb})end cb.MouseEnter:Connect(function()ah(cb,{BackgroundTransparency=0.5},0.12)end)cb.MouseLeave:Connect(function()ah(cb,{BackgroundTransparency=1},0.2)end)local cd=b0+44 local ce=ai('Frame',{Position=UDim2.fromOffset(b0,cd),Size=UDim2.new(1,-b0*2,0,E and 36 or 32),BackgroundColor3=z.Surface,BorderSizePixel=0,Parent=b5})aj(ce,UDim.new(0,7))local cf=ak(ce)local cg,ch=aB(ce,'search',z.Muted,UDim2.new(0,10,0.5,0))ch.Parent.Size=UDim2.fromOffset(14,14)local ci=ai('TextBox',{Position=UDim2.fromOffset(32,0),Size=UDim2.new(1,-40,1,0),BackgroundTransparency=1,Text='',PlaceholderText='Search features',PlaceholderColor3=z.Muted,TextColor3=z.Text,TextSize=13,FontFace=D.Regular,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,ClearTextOnFocus=false,Parent=ce})ci.Focused:Connect(function()ah(cf,{Color=z.StrokeHover},0.15)ah(ch,{ImageColor3=z.Accent},0.15)end)ci.FocusLost:Connect(function()ah(cf,{Color=z.Stroke},0.2)ah(ch,{ImageColor3=z.Muted},0.2)end)cd+=(E and 36 or 32)+10 local cj=ai('ScrollingFrame',{Position=UDim2.fromOffset(b0,cd),Size=UDim2.new(1,-b0*2+6,1,-(cd+b0-4)),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=E and 4 or 3,ScrollBarImageColor3=z.Accent,ScrollBarImageTransparency=0.4,ScrollingDirection=Enum.ScrollingDirection.Y,CanvasSize=UDim2.new(),Parent=b5})local ck=ai('Frame',{Size=UDim2.new(1,-10,0,0),AutomaticSize=Enum.AutomaticSize.Y,BackgroundTransparency=1,Parent=cj})local cl=ai('UIListLayout',{SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,2),Parent=ck})cl:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()cj.CanvasSize=UDim2.fromOffset(0,cl.AbsoluteContentSize.Y/self.Scale.Scale+4)end)local cm=am({Size=UDim2.new(1,0,0,60),Text=b_==0 and'No features yet'or'No matches',TextSize=13,FontFace=D.Regular,TextColor3=z.Muted,TextXAlignment=Enum.TextXAlignment.Center,LayoutOrder=0,Visible=b_==0,Parent=ck})local cn={}local co=false local cp=nil function cn.Close()if co then return end co=true if self._dialog==cn then self._dialog=nil end b9:Disconnect()if cp then task.defer(cp)end if ci:IsFocused()then ci:ReleaseFocus()end ah(b3,{BackgroundTransparency=1},0.18)ah(b5,{Position=UDim2.new(0.5,0,0.5,8),GroupTransparency=1},0.18,Enum.EasingStyle.Quint)ah(b7,{Scale=0.96},0.18,Enum.EasingStyle.Quint)ah(b6,{Transparency=1},0.12)task.delay(0.2,function()b3:Destroy()end)end local cq={}local cr=0 for cs,ct in ipairs(bZ)do cr+=1 local cu=ai('Frame',{Size=UDim2.new(1,0,0,30),BackgroundTransparency=1,LayoutOrder=cr,Parent=ck})local cv=aB(cu,ct.Icon or'layout-grid',z.Accent,UDim2.new(0,2,0,18))cv.Size=UDim2.fromOffset(14,14)am({Position=UDim2.fromOffset(24,10),Size=UDim2.new(1,-70,0,16),Text=string.upper(ct.Name),TextSize=11,TextColor3=z.Muted,Parent=cu})local cw=am({AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,-4,0,10),Size=UDim2.new(0,40,0,16),Text=tostring(#ct.Items),TextSize=11,TextColor3=z.Muted,TextXAlignment=Enum.TextXAlignment.Right,Parent=cu})local cx={Header=cu,Count=cw,Rows={}}for cy,cz in ipairs(ct.Items)do cr+=1 local cA=cz.Desc or cz.Path local cB=cz.Result~=nil or type(cz.Callback)=='function'local cC=ai('TextButton',{Size=UDim2.new(1,0,0,cA and b1+4 or b1-4),BackgroundColor3=z.Surface2,BackgroundTransparency=1,BorderSizePixel=0,Text='',AutoButtonColor=false,LayoutOrder=cr,Parent=ck})aj(cC,UDim.new(0,8))local cD=aB(cC,cz.Icon or self._searchIcons[cz.Kind]or'check',z.Muted,UDim2.new(0,10,0.5,0))cD.Size=UDim2.fromOffset(14,14)local cE=12+(cB and 22 or 0)local cF if cz.Tag then cF=ai('Frame',{AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-(cB and 30 or 10),0.5,0),Size=UDim2.fromOffset(0,20),AutomaticSize=Enum.AutomaticSize.X,BackgroundColor3=z.Accent,BackgroundTransparency=0.85,BorderSizePixel=0,Parent=cC})aj(cF,UDim.new(0,5))al(cF,7,7)am({Size=UDim2.new(0,0,1,0),AutomaticSize=Enum.AutomaticSize.X,Text=tostring(cz.Tag),TextSize=11,TextColor3=z.Accent,TextTruncate=Enum.TextTruncate.None,Parent=cF})end local cG=am({Position=UDim2.fromOffset(34,cA and 5 or 0),Size=UDim2.new(1,-(34+cE),0,cA and 18 or b1-4),Text=cz.Name,TextSize=13,Parent=cC})local cH if cA then cH=am({Position=UDim2.fromOffset(34,23),Size=UDim2.new(1,-(34+cE),0,14),Text=cA,TextSize=11,FontFace=D.Regular,TextColor3=z.Muted,Parent=cC})end if cF then local function cI()local cJ=34+cE+cF.AbsoluteSize.X/self.Scale.Scale+8 cG.Size=UDim2.new(1,-cJ,0,cG.Size.Y.Offset)if cH then cH.Size=UDim2.new(1,-cJ,0,14)end end cF:GetPropertyChangedSignal('AbsoluteSize'):Connect(cI)task.defer(cI)end if cB then local cI=ai('ImageLabel',{AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-10,0.5,0),Size=UDim2.fromOffset(14,14),BackgroundTransparency=1,ImageColor3=z.Muted,ImageTransparency=0.4,ScaleType=Enum.ScaleType.Fit,Parent=cC})aq(cI,'arrow-up-right')end local cI=ay(cC,function()return cj end)cC.MouseEnter:Connect(function()if not ax()then ah(cC,{BackgroundTransparency=0.3},0.12)end end)cC.MouseLeave:Connect(function()ah(cC,{BackgroundTransparency=1},0.2)end)cC.MouseButton1Click:Connect(function()if not cB or not cI()then return end cn.Close()if cz.Result then self:_revealResult(cz.Result)end aJ(cz.Callback)end)table.insert(cx.Rows,{Frame=cC,Key=string.lower(cz.Name..' '..(cA or''))})end table.insert(cq,cx)end ci:GetPropertyChangedSignal('Text'):Connect(function()local cs=string.lower(ci.Text)local ct=false for cu,cv in ipairs(cq)do local cw=0 for cx,cy in ipairs(cv.Rows)do local cz=cs==''or string.find(cy.Key,cs,1,true)~=nil cy.Frame.Visible=cz if cz then cw+=1 end end cv.Header.Visible=cw>0 cv.Count.Text=tostring(cw)ct=ct or cw>0 end cm.Visible=not ct cj.CanvasPosition=Vector2.zero end)cb.MouseButton1Click:Connect(cn.Close)b3.MouseButton1Click:Connect(cn.Close)cp=self:_listen('Began',function(cs)if cs.KeyCode==Enum.KeyCode.Escape then cn.Close()end end)self._dialog=cn ah(b3,{BackgroundTransparency=0.45},0.25)ah(b5,{Position=UDim2.fromScale(0.5,0.5),GroupTransparency=0},0.3,Enum.EasingStyle.Quint)ah(b7,{Scale=1},0.4,Enum.EasingStyle.Back)return cn end function a2:_homeStats(bY,bZ,b_,b0)local b1=bZ.Stats or{'Players','Execs','Session','FPS','Ping'}local b2=self:_homeCard(bY,b_)local b3=ai('Frame',{Size=UDim2.new(1,0,0,76),BackgroundTransparency=1,LayoutOrder=1,Parent=b2})ai('UIGridLayout',{CellPadding=UDim2.fromOffset(24,0),CellSize=UDim2.new(0.5,-12,0,76),SortOrder=Enum.SortOrder.LayoutOrder,Parent=b3})local b5=ai('Frame',{Size=UDim2.new(1,0,0,1),BackgroundColor3=z.Stroke,BorderSizePixel=0,LayoutOrder=2,Parent=b2})local b6=ai('Frame',{Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,BackgroundTransparency=1,LayoutOrder=3,Parent=b2})al(b6,0,0,12,0)local b7=ai('UIGridLayout',{CellPadding=UDim2.fromOffset(0,8),CellSize=UDim2.new(0.25,0,0,36),SortOrder=Enum.SortOrder.LayoutOrder,Parent=b6})local b8,b9={},{}local ca,cb=0,0 for cc,cd in ipairs(b1)do local ce=bH[cd]if ce and not b8[cd]then if cd=='FPS'or cd=='Ping'then ca+=1 b8[cd],b9[cd]=self:_homeGraph(b3,cc,ce[1],ce[2],cd=='FPS'and 60 or 100)else cb+=1 b8[cd]=self:_homeFigure(b6,cc,ce[2])end end end b3.Visible=ca>0 b6.Visible=cb>0 b5.Visible=ca>0 and cb>0 if ca==0 then al(b6,0,0,0,0)end local function cc()local cd=b6.AbsoluteSize.X/self.Scale.Scale local ce=math.clamp(cb,1,cd>=440 and 5 or 3)b7.CellSize=UDim2.new(1/ce,0,0,36)end b6:GetPropertyChangedSignal('AbsoluteSize'):Connect(cc)task.defer(cc)if b8.Executor then b8.Executor.Text=aU()end if b8.Game then b8.Game.Text='Loading'task.spawn(function()b8.Game.Text=aZ()end)end if b8.Region then b8.Region.Text='Loading'a0(function(cd)b8.Region.Text=cd end)end if b8.Execs then local cd=bI(bZ.StatsFolder or self.ConfigFolder)b8.Execs.Text=cd and tostring(cd)or'\u{2014}'end if b8.Friends then local cd={}local function ce()local cf=0 for cg,ch in ipairs(f:GetPlayers())do if ch~=j then local ci=cd[ch.UserId]if ci==nil then local cj,ck=pcall(function()return j:IsFriendsWith(ch.UserId)end)ci=cj and ck==true cd[ch.UserId]=ci end if ci then cf+=1 end end end b8.Friends.Text=tostring(cf)end task.spawn(ce)table.insert(self._connections,f.PlayerAdded:Connect(function()task.spawn(ce)end))table.insert(self._connections,f.PlayerRemoving:Connect(function()task.defer(ce)end))end local cd=b8.Session or b8.Uptime local ce=os.clock()local cf=0 self:_listen('Render',function()cf+=1 end)local cg=bZ.StatColors~=false local function ch(ci,cj)if cg and ci.TextColor3~=cj then ah(ci,{TextColor3=cj},0.3)end end return function()if b8.FPS then b8.FPS.Text=tostring(cf)ch(b8.FPS,k._healthColor(cf,50,30))b9.FPS(cf,k._healthColor(cf,50,30))end cf=0 if b8.Ping then local ci,cj=pcall(function()return math.floor(j:GetNetworkPing()*1000)end)cj=ci and cj or 0 b8.Ping.Text=cj..'ms'ch(b8.Ping,k._healthColor(cj,90,180,true))b9.Ping(cj,k._healthColor(cj,90,180,true))end if b8.Players then b8.Players.Text=#f:GetPlayers()..'/'..f.MaxPlayers end if cd then cd.Text=bA(os.clock()-ce)end if b8.Time then b8.Time.Text=os.date(bZ.TimeFormat or'%H:%M')end if b8.ServerAge then b8.ServerAge.Text=bA(workspace.DistributedGameTime)end if b8.Memory then local ci,cj=pcall(function()return i:GetTotalMemoryUsageMb()end)b8.Memory.Text=ci and string.format('%d MB',cj)or'\u{2014}'ch(b8.Memory,ci and k._healthColor(cj,1500,3000,true)or z.Text)end end,function()cf=0 end end local function bY(bZ,b_)local b0=bZ.List if type(b_.Content)=='string'then local b1=bG(b0,0,1)b1.AutomaticSize=Enum.AutomaticSize.Y al(b1,16,16,14,16)am({Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,Text=b_.Content,TextSize=13,FontFace=D.Regular,TextColor3=z.Muted,TextWrapped=true,TextTruncate=Enum.TextTruncate.None,TextYAlignment=Enum.TextYAlignment.Top,Parent=b1})end if type(b_.Entries)=='table'then for b1,b2 in ipairs(b_.Entries)do local b3=bG(b0,0,b1+1)b3.AutomaticSize=Enum.AutomaticSize.Y al(b3,16,16,14,16)ai('UIListLayout',{SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,6),Parent=b3})local b5=ai('Frame',{Size=UDim2.new(1,0,0,20),BackgroundTransparency=1,LayoutOrder=1,Parent=b3})am({Size=UDim2.new(1,-90,1,0),Text=b2.Title or b2.Version or'Update',TextSize=15,Parent=b5})if b2.Date or b2.Tag then local b6=ai('Frame',{AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,0,0.5,0),Size=UDim2.fromOffset(0,20),AutomaticSize=Enum.AutomaticSize.X,BackgroundColor3=z.Surface,BorderSizePixel=0,Parent=b5})aj(b6,UDim.new(0,5))ak(b6)al(b6,8,8)am({Size=UDim2.new(0,0,1,0),AutomaticSize=Enum.AutomaticSize.X,Text=b2.Tag or b2.Date,TextSize=11,TextColor3=z.Muted,TextTruncate=Enum.TextTruncate.None,Parent=b6})end local b6=b2.Content or b2.Body if type(b2.Changes)=='table'then b6='\u{2022} '..table.concat(b2.Changes,'\n\u{2022} ')end if b6 then am({Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,Text=b6,TextSize=13,FontFace=D.Regular,TextColor3=z.Muted,TextWrapped=true,TextTruncate=Enum.TextTruncate.None,TextYAlignment=Enum.TextYAlignment.Top,LayoutOrder=2,Parent=b3})end end end if type(b_.Build)=='function'then aJ(b_.Build,bZ,b0)else bZ._noSearch=true end end function a2:_buildHome(bZ)self._hideName=bZ.HideName==true self._hideAvatar=bZ.HideAvatar==true self:_renderIdentity(true)local b_=self:Tab({Name=bZ.Name or'Home',Desc=bZ.Desc,Icon=bZ.Icon or'house',PageTitle=bZ.Title or'Home'})b_._order=100 self.Home=b_ local b0=bZ.Pages or bZ.Tabs local b1=b_ if type(b0)=='table'and#b0>0 then b1=b_:SubTab({Name=bZ.OverviewName or'Overview',Icon=bZ.TabIcon or'layout-grid'})end b1._noSearch=true b1._order=100 local b2=b1.List local b3=self:_homeProfile(b2,bZ,1)local b5,b6=self:_homeStats(b2,bZ,2,b_)local b7=ai('Frame',{Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,BackgroundTransparency=1,LayoutOrder=3,Parent=b2})local b8=ai('UIListLayout',{SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,10),Parent=b7})local function b9(ca)local cb=ai('Frame',{Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,BackgroundTransparency=1,LayoutOrder=ca,Parent=b7})ai('UIListLayout',{SortOrder=Enum.SortOrder.LayoutOrder,Parent=cb})return cb end local ca,cb=b9(1),b9(2)local cc=self:_homeGame(ca,1)local cd,ce=self:_homeLinks(cb,bZ,1)if not cd then cb:Destroy()end local function cf()local cg=cd~=nil and b7.AbsoluteSize.X/self.Scale.Scale>=540 b8.FillDirection=cg and Enum.FillDirection.Horizontal or Enum.FillDirection.Vertical local ch=cg and UDim2.new(0.5,-5,0,0)or UDim2.new(1,0,0,0)ca.Size=ch if cd then cb.Size=ch end end b7:GetPropertyChangedSignal('AbsoluteSize'):Connect(cf)task.defer(cf)self:_homeExecutor(b2,bZ,4)if type(b0)=='table'then for cg,ch in ipairs(b0)do bY(b_:SubTab({Name=ch.Name or ch.Title or'Page',Icon=ch.Icon}),ch)end end b3()b5()cc()task.spawn(function()while not self._destroyed and b_._page.Parent do task.wait(1)if self.Open and self.CurrentTab==b_ then b5()b3()cc()ce()else b6()end end end)return b_ end function a2:Tab(bZ,b_)bZ=l(bZ,{Title='Name',Description='Desc'})if b_~=nil and bZ.Icon==nil then bZ.Icon=b_ end local b0=setmetatable({Name=bZ.Name or'Tab',Window=self,_order=0},aS)local b1=ai('TextButton',{Size=UDim2.new(1,0,0,H),BackgroundColor3=z.Surface3,BackgroundTransparency=1,Text='',AutoButtonColor=false,LayoutOrder=#self.Tabs+1,Parent=self._tabStack})aj(b1,UDim.new(0,7))local b2=ak(b1,z.Stroke,1)b2.Enabled=false b0._button=b1 local b3=bZ.Icon~=nil if b3 then local b5=ai('ImageLabel',{AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.new(0,20,0.5,0),Size=UDim2.fromOffset(16,16),BackgroundTransparency=1,ImageColor3=z.Muted,ScaleType=Enum.ScaleType.Fit,Parent=b1})aq(b5,bZ.Icon)if b5:GetAttribute('CustomIcon')then b5.ImageTransparency=0.4 end b0._icon=b5 end b0._label=am({Position=UDim2.fromOffset(b3 and 38 or 14,0),Size=UDim2.new(1,b3 and-46 or-22,1,0),Text=b0.Name,TextSize=13,TextColor3=z.Muted,Parent=b1})local b5=ai('Frame',{Name=b0.Name,Size=UDim2.fromScale(1,1),BackgroundTransparency=1,Visible=false,Parent=self.Content})b0._page=b5 local b6=24 if b3 then local b7=aB(b5,bZ.Icon,z.Accent,UDim2.new(0,24,0,32))b7.Size=UDim2.fromOffset(20,20)b6=54 end b0._titleX=b6 b0._title=am({Position=UDim2.fromOffset(b6,20),Size=UDim2.new(1,-b6,0,24),Text=bZ.PageTitle or b0.Name,TextSize=22,Parent=b5})if bZ.Desc then b0._desc=am({Position=UDim2.fromOffset(b6,44),Size=UDim2.new(1,-b6,0,16),Text=bZ.Desc,TextSize=13,FontFace=D.Regular,TextColor3=z.Muted,Parent=b5})end local b7=bZ.Desc and 70 or 58 b0._headerBottom=b7 b0._iconName=bZ.Icon bJ(b0,b5,b7,bZ.Icon or'layout-grid',bZ.EmptyText or'Nothing here yet')local b8=ai('UIScale',{Parent=b1})local function b9()ah(b8,{Scale=1},0.3,Enum.EasingStyle.Quint)end b1.MouseEnter:Connect(function()if self.CurrentTab~=b0 and not ax()then ah(b1,{BackgroundTransparency=0.75},0.2,Enum.EasingStyle.Quint)ah(b0._label,{TextColor3=z.Text},0.2)if b0._icon then ar(b0._icon,z.Text,true,0.2)end end end)b1.MouseLeave:Connect(function()b9()if self.CurrentTab~=b0 then ah(b1,{BackgroundTransparency=1},0.3,Enum.EasingStyle.Quint)ah(b0._label,{TextColor3=z.Muted},0.3)if b0._icon then ar(b0._icon,z.Muted,false,0.3)end end end)b1.MouseButton1Down:Connect(function()ah(b8,{Scale=0.97},0.15,Enum.EasingStyle.Quint)end)b1.MouseButton1Up:Connect(b9)local ca=ay(b1,function()return self.TabList end)b1.MouseButton1Click:Connect(function()b9()if ca()then self:SelectTab(b0)end end)b0._stroke=b2 self:_fitTitle(b0)if not self._introDone then b1.Visible=false end table.insert(self.Tabs,b0)if#self.Tabs==1 then task.defer(function()if not self.CurrentTab then self:SelectTab(b0)end end)end return b0 end a2.CreateTab=a2.Tab function a2:CloudConfigs(bZ)bZ=l(bZ,{Title='Name',Description='Desc'})local b_=self local b0=self:Tab({Name=bZ.Name or'Cloud',Desc=bZ.Desc,Icon=bZ.Icon or'cloud',PageTitle=bZ.PageTitle})b0._noSearch=true b0.List.Visible=false if b0._empty then b0._empty:Destroy()b0._empty=nil end local b1=116 local b2=E and 36 or 32 local b3=E and 30 or 26 local b5={'Popular','New','Top','Installs'}local b6={Popular='Popular',New='Newest',Top='Top rated',Installs='Most installed'}local b7={'All','Favorites','Mine','Installed'}local b8=40 local b9=math.max(math.floor(tonumber(bZ.DescriptionLimit)or 300),20)local ca=math.max(math.floor(tonumber(bZ.PageSize)or 20),1)local cb=type(bZ.Tags)=='table'and bZ.Tags or{}local cc=math.max(math.floor(tonumber(bZ.MaxTags)or 3),0)local cd=tostring(bZ.StreamerName or'Ouroboros User')local ce={Tab=b0}local cf,cg={},{}local ch={}local ci,cj,ck=false,0,0 local cl=false local cm={Search='',Sort='Popular',Filter='All',Tag=nil}local cn,co={},nil local cp,cq,cr={},nil,0 local cs=b_:_readConfigSettings()local ct=type(cs.CloudFavorites)=='table'and cs.CloudFavorites or{}local cu=type(cs.CloudInstalled)=='table'and cs.CloudInstalled or{}if table.find(b5,cs.CloudSort)then cm.Sort=cs.CloudSort elseif table.find(b5,bZ.Sort)then cm.Sort=bZ.Sort end local function cv(cw,cx)b_:_writeConfigSettings({[cw]=cx})end local function cw(cx,cy,cz)b_:Notify({Title=cy,Content=cz,Type=cx and'Success'or'Error',Duration=3})end local function cx()return b_._hideName==true end local function cy(cz)local cA=type(cz)=='string'and b_:DecodeConfig(cz)if not cA then return nil end local cB=0 for cC in pairs(cA)do cB+=1 end return cB end local function cz(cA)cA=math.max(math.floor(tonumber(cA)or 0),0)if cA>=1e6 then return(('%.1f'):format(cA/1e6):gsub('%.0$',''))..'m'elseif cA>=1e3 then return(('%.1f'):format(cA/1e3):gsub('%.0$',''))..'k'end return tostring(cA)end local function cA(cB)cB=tonumber(cB)if not cB then return nil end local cC=os.time()-cB if cC<60 then return'just now'elseif cC<3600 then return math.floor(cC/60)..'m ago'elseif cC<86400 then return math.floor(cC/3600)..'h ago'elseif cC<604800 then return math.floor(cC/86400)..'d ago'elseif cC<2592000 then return math.floor(cC/604800)..'w ago'end return os.date('%d %b %Y',cB)end local function cB(cC)return(cC:gsub('&','&amp;'):gsub('<','&lt;'):gsub('>','&gt;'):gsub('"','&quot;'):gsub("'",'&apos;'))end local function cC(cD)local cE=string.lower(cm.Search)if cE==''then return cB(cD)end local cF=string.lower(cD)local cG=bc(z.Accent)local cH,cI={},1 while true do local cJ,cK=string.find(cF,cE,cI,true)if not cJ then break end table.insert(cH,cB(cD:sub(cI,cJ-1)))table.insert(cH,('<font color="#%s"><b>%s</b></font>'):format(cG,cB(cD:sub(cJ,cK))))cI=cK+1 end table.insert(cH,cB(cD:sub(cI)))return table.concat(cH)end local function cD(cE)if type(cE)~='table'then return nil end local cF=cE.Id~=nil and tostring(cE.Id)or e:GenerateGUID(false)local cG=cg[cF]or{Id=cF}for cH,cI in pairs(cE)do if cH~='Id'then cG[cH]=cI end end cG.Name=tostring(cG.Name or'Untitled')cG.Author=tostring(cG.Author or'Unknown')cG.Description=cG.Description~=nil and tostring(cG.Description)or''local cH={}for cI,cJ in ipairs(type(cG.Tags)=='table'and cG.Tags or{})do table.insert(cH,tostring(cJ))end cG.Tags=cH cG.Installs=tonumber(cG.Installs)or 0 cG.Likes=tonumber(cG.Likes)or 0 cG.Updated=tonumber(cG.Updated or cG.Created)cG.Liked=cG.Liked==true if type(cG.Code)~='string'or cG.Code==''then cG.Code=nil end cG.Count=tonumber(cG.Count)or cy(cG.Code)cG.Mine=cG.Mine==true or tonumber(cG.AuthorId)==j.UserId or tonumber(cG.OwnerId)==j.UserId cg[cF]=cG return cG end local function cE(cF)return{Id=cF.Id,Name=cF.Name,Description=cF.Description,Author=cF.Author,AuthorId=cF.AuthorId,Tags=table.clone(cF.Tags),Installs=cF.Installs,Likes=cF.Likes,Liked=cF.Liked,Updated=cF.Updated,Code=cF.Code,Count=cF.Count,Folder=cF.Folder,Mine=cF.Mine}end local function cF(cG)local cH=cE(cG)cH.Code=nil cH.Liked=nil return cH end local function cG(cH)local cI=cu[cH.Id]if type(cI)~='table'then return nil end if cH.Updated and tonumber(cI.Updated)and cH.Updated>tonumber(cI.Updated)then return'Update'end return'Installed'end local function cH(cI)return type(cI.Folder)=='string'and cI.Folder~=b_.ConfigFolder end local function cI(cJ,cK,cL,cM,cN)local cO=ai('TextButton',{Size=UDim2.fromOffset(cM,cM),BackgroundColor3=z.Surface2,BackgroundTransparency=cN and 1 or 0,Text='',AutoButtonColor=false,Parent=cJ})aj(cO,UDim.new(0,8))if not cN then aG(cO,ak(cO))end local cP=ai('ImageLabel',{AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.fromScale(0.5,0.5),Size=UDim2.fromOffset(15,15),BackgroundTransparency=1,ImageColor3=z.Muted,ScaleType=Enum.ScaleType.Fit,Parent=cO})aq(cP,cK)if cP.Image==''then cP:Destroy()cP=am({Size=UDim2.fromScale(1,1),Text=cL,TextSize=15,TextColor3=z.Muted,TextXAlignment=Enum.TextXAlignment.Center,TextTruncate=Enum.TextTruncate.None,Parent=cO})end return cO,cP end local function cJ(cK,cL)ah(cK,{BackgroundColor3=z.Accent,BackgroundTransparency=0.12},0)ah(cL,{TextColor3=z.AccentDark},0)cL.FontFace=D.Bold end local function cK(cL)for cM,cN in ipairs(cL:GetChildren())do if cN:IsA('GuiObject')then cN:Destroy()end end end local function cL(cM,cN,cO,cP)local cQ=ai('TextButton',{Size=UDim2.fromOffset(0,b3),AutomaticSize=Enum.AutomaticSize.X,BackgroundColor3=z.Surface2,Text='',AutoButtonColor=false,LayoutOrder=cO,Parent=cM})cQ:SetAttribute('NoDrag',true)aj(cQ,UDim.new(1,0))local cR=ak(cQ)al(cQ,12,12)local cS=am({Size=UDim2.new(0,0,1,0),AutomaticSize=Enum.AutomaticSize.X,Text=cN,TextSize=12,TextColor3=z.Muted,TextTruncate=Enum.TextTruncate.None,Parent=cQ})local cT={Button=cQ,Label=cS}function cT.Set(cU,cV)local cW=cV and 0 or 0.15 ah(cQ,{BackgroundColor3=cU and z.Accent or z.Surface2},cW)ah(cS,{TextColor3=cU and z.AccentDark or z.Muted},cW)ah(cR,{Transparency=cU and 1 or 0},cW)end if cP then cQ.MouseButton1Click:Connect(cP)else cQ.Active=false end return cT end local function cM(cN,cO,cP)local cQ=am({Size=UDim2.fromOffset(0,18),AutomaticSize=Enum.AutomaticSize.X,BackgroundColor3=z.Surface3,BackgroundTransparency=0.2,Text=cO,TextSize=11,TextColor3=z.Muted,TextXAlignment=Enum.TextXAlignment.Center,TextTruncate=Enum.TextTruncate.None,LayoutOrder=cP,Parent=cN})aj(cQ,UDim.new(0,5))al(cQ,7,7)return cQ end local function cN(cO,cP,cQ)return ai('UIListLayout',{FillDirection=Enum.FillDirection.Horizontal,VerticalAlignment=Enum.VerticalAlignment.Center,SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,cP),Wraps=cQ==true,Parent=cO})end local function cO(cP,cQ)return ai('UIListLayout',{SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,cQ),Parent=cP})end local function cP(cQ,cR,cS,cT,cU,cV)return am({Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,Text=cR,TextSize=cS,FontFace=cV or D.Regular,TextColor3=cT or z.Text,TextWrapped=true,TextTruncate=Enum.TextTruncate.None,TextYAlignment=Enum.TextYAlignment.Top,LayoutOrder=cU,Parent=cQ})end local function cQ(cR,cS)local cT=ai('ScrollingFrame',{Size=UDim2.fromScale(1,1),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=3,ScrollBarImageColor3=z.Accent,ScrollBarImageTransparency=0.4,ScrollingDirection=Enum.ScrollingDirection.Y,AutomaticCanvasSize=Enum.AutomaticSize.Y,CanvasSize=UDim2.new(),Visible=cS~=false,Parent=cR})cT:SetAttribute('NoDrag',true)return cT end local function cR(cS,cT,cU,cV,cW)local cX=cV>b2 local cY=ai('Frame',{Size=UDim2.new(1,0,0,cV),BackgroundColor3=z.Surface,BorderSizePixel=0,ClipsDescendants=true,LayoutOrder=cT,Parent=cS})aj(cY,UDim.new(0,8))local cZ=ak(cY)local c_=ai('TextBox',{Position=UDim2.fromOffset(10,cX and 8 or 0),Size=UDim2.new(1,-20,1,cX and-24 or 0),BackgroundTransparency=1,Text='',PlaceholderText=cU,PlaceholderColor3=z.Muted,TextColor3=z.Text,TextSize=13,FontFace=D.Regular,TextXAlignment=Enum.TextXAlignment.Left,TextYAlignment=cX and Enum.TextYAlignment.Top or Enum.TextYAlignment.Center,MultiLine=cX,TextWrapped=cX,ClearTextOnFocus=false,Parent=cY})local c0=cX and am({AnchorPoint=Vector2.new(1,1),Position=UDim2.new(1,-10,1,-4),Size=UDim2.fromOffset(0,14),AutomaticSize=Enum.AutomaticSize.X,Text='',TextSize=11,FontFace=D.Regular,TextColor3=z.Muted,TextTruncate=Enum.TextTruncate.None,Parent=cY})c_.Focused:Connect(function()ah(cZ,{Color=z.StrokeHover},0.15)end)c_.FocusLost:Connect(function()ah(cZ,{Color=z.Stroke},0.2)end)c_:GetPropertyChangedSignal('Text'):Connect(function()local c1=c_.Text local c2=utf8.len(c1)or#c1 if cW and c2>cW then local c3=utf8.offset(c1,cW+1)c_.Text=c3 and c1:sub(1,c3-1)or c1:sub(1,cW)return end if c0 then c0.Text=cW and(c2..'/'..cW)or''end end)if c0 and cW then c0.Text='0/'..cW end return c_,cZ end local function cS(cT)cT=bM((tostring(cT or''):gsub('[\\/:%*%?"<>|]','')))if cT==''then cT='Cloud config'end local cU,cV=cT,2 while b_:ConfigExists(cU)do cU=('%s (%d)'):format(cT,cV)cV+=1 end return cU end local cT=b0._headerBottom local cU=ai('Frame',{Position=UDim2.fromOffset(23,cT-1),Size=UDim2.new(1,-46,1,-(cT+14)),BackgroundTransparency=1,ClipsDescendants=true,Parent=b0._page})for cV,cW in ipairs({'Browse','Detail','Publish'})do cn[cW]=ai('Frame',{Size=UDim2.fromScale(1,1),BackgroundTransparency=1,Visible=false,Parent=cU})al(cn[cW],1,1,1,1)end local function cV(cW)if co==cW then return end local cX=co co=cW if cX then cX.Visible=false end local cY=cW==cn.Browse and-24 or 24 cW.Position=UDim2.fromOffset(cY,0)cW.Visible=true ah(cW,{Position=UDim2.fromOffset(0,0)},0.3,Enum.EasingStyle.Quint)end local cW=cn.Browse local cX=ai('Frame',{Size=UDim2.new(1,0,0,b2),BackgroundTransparency=1,Parent=cW})local cY,cZ=bF(cX,'Publish',{AnchorPoint=Vector2.new(1,0),Position=UDim2.fromScale(1,0),Size=UDim2.new(0,0,1,0),AutomaticSize=Enum.AutomaticSize.X},function()ce:OpenPublish()end)cJ(cY,cZ)cY.Visible=type(bZ.OnPublish)=='function'local c_,c0=cI(cX,'refresh-cw','R',b2)c_.AnchorPoint=Vector2.new(1,0)local c1=ai('Frame',{Size=UDim2.new(1,-(b2+8),1,0),BackgroundColor3=z.Surface2,BorderSizePixel=0,Parent=cX})aj(c1,UDim.new(0,8))local c2=ak(c1)local c3,c4=aB(c1,'search',z.Muted,UDim2.new(0,10,0.5,0))c3.Size=UDim2.fromOffset(14,14)local c5=ai('TextBox',{Position=UDim2.fromOffset(32,0),Size=UDim2.new(1,-62,1,0),BackgroundTransparency=1,Text='',PlaceholderText=bZ.SearchPlaceholder or(E and'Search configs...'or'Search configs...   ( / )'),PlaceholderColor3=z.Muted,TextColor3=z.Text,TextSize=13,FontFace=D.Regular,TextXAlignment=Enum.TextXAlignment.Left,ClearTextOnFocus=false,ClipsDescendants=true,Parent=c1})local c6=cI(c1,'x','x',24,true)c6.AnchorPoint=Vector2.new(1,0.5)c6.Position=UDim2.new(1,-4,0.5,0)c6.Visible=false local c7 local c8=0 local c9=type(cs.CloudRecent)=='table'and cs.CloudRecent or{}local da=ai('Frame',{Position=UDim2.fromOffset(0,b2+4),Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,BackgroundColor3=z.Surface2,BorderSizePixel=0,Visible=false,ZIndex=5,Parent=cW})aj(da,UDim.new(0,8))ak(da)al(da,6,6,6,6)cO(da,2)local function db(dc)dc=bM(dc)if#dc<2 then return end for dd=#c9,1,-1 do if string.lower(c9[dd])==string.lower(dc)then table.remove(c9,dd)end end table.insert(c9,1,dc)while#c9>6 do table.remove(c9)end cv('CloudRecent',c9)end local function dc(dd)dd=dd and#c9>0 and c5.Text==''if dd==da.Visible then return end da.Visible=dd if not dd then return end cK(da)local de=ai('Frame',{Size=UDim2.new(1,0,0,20),BackgroundTransparency=1,LayoutOrder=0,Parent=da})am({Position=UDim2.fromOffset(8,0),Size=UDim2.new(1,-60,1,0),Text='Recent searches',TextSize=11,TextColor3=z.Muted,Parent=de})local df=ai('TextButton',{AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,-6,0,0),Size=UDim2.fromOffset(0,20),AutomaticSize=Enum.AutomaticSize.X,BackgroundTransparency=1,Text='Clear',TextSize=11,FontFace=D.Medium,TextColor3=z.Accent,AutoButtonColor=false,Parent=de})df.MouseButton1Down:Connect(function()c9={}cv('CloudRecent',c9)dc(false)end)for dg,dh in ipairs(c9)do local di=ai('TextButton',{Size=UDim2.new(1,0,0,E and 32 or 28),BackgroundColor3=z.Surface3,BackgroundTransparency=1,Text='',AutoButtonColor=false,LayoutOrder=dg,Parent=da})aj(di,UDim.new(0,6))local dj=aB(di,'history',z.Muted,UDim2.new(0,8,0.5,0))dj.Size=UDim2.fromOffset(13,13)am({Position=UDim2.fromOffset(28,0),Size=UDim2.new(1,-34,1,0),Text=dh,TextSize=13,FontFace=D.Regular,Parent=di})di.MouseEnter:Connect(function()ah(di,{BackgroundTransparency=0.5},0.1)end)di.MouseLeave:Connect(function()ah(di,{BackgroundTransparency=1},0.15)end)di.MouseButton1Down:Connect(function()c8+=1 c5.Text=dh cm.Search=dh db(dh)dc(false)c5:ReleaseFocus()c7(false)end)end end local function dd()local de=b_.Scale.Scale local df=cY.Visible and(cY.AbsoluteSize.X/de+8)or 0 c_.Position=UDim2.new(1,-df,0,0)c1.Size=UDim2.new(1,-(df+b2+8),1,0)da.Size=UDim2.new(1,-(df+b2+8),0,0)end cY:GetPropertyChangedSignal('AbsoluteSize'):Connect(dd)task.defer(dd)local de=ai('Frame',{Position=UDim2.fromOffset(0,b2+7),Size=UDim2.new(1,0,0,b3+2),BackgroundTransparency=1,Parent=cW})local df=ai('TextButton',{AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,-1,0,1),Size=UDim2.fromOffset(0,b3),AutomaticSize=Enum.AutomaticSize.X,BackgroundColor3=z.Surface2,Text='',AutoButtonColor=false,Parent=de})aj(df,UDim.new(1,0))aG(df,ak(df))al(df,10,12)cN(df,6)local dg=aB(df,'arrow-down-up',z.Accent,UDim2.new())dg.Size=UDim2.fromOffset(13,13)local dh=am({Size=UDim2.new(0,0,1,0),AutomaticSize=Enum.AutomaticSize.X,Text=b6[cm.Sort],TextSize=12,TextTruncate=Enum.TextTruncate.None,LayoutOrder=2,Parent=df})local di=ai('ScrollingFrame',{Size=UDim2.new(1,-120,1,0),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=0,ScrollingDirection=Enum.ScrollingDirection.X,AutomaticCanvasSize=Enum.AutomaticSize.X,CanvasSize=UDim2.new(),Parent=de})di:SetAttribute('NoDrag',true)cN(di,6)al(di,1,1,1,1)local function dj()local dk=df.AbsoluteSize.X/b_.Scale.Scale di.Size=UDim2.new(1,-(dk+8),1,0)end df:GetPropertyChangedSignal('AbsoluteSize'):Connect(dj)task.defer(dj)local dk=b2+8+b3+10 local dl=cQ(cW)dl.Position=UDim2.fromOffset(0,dk)dl.Size=UDim2.new(1,0,1,-dk)al(dl,1,6,1,12)cO(dl,10)local dm=ai('Frame',{Size=UDim2.new(1,0,0,16),BackgroundTransparency=1,LayoutOrder=0,Parent=dl})local dn=am({Size=UDim2.new(1,-100,1,0),Text='',RichText=true,TextSize=12,FontFace=D.Regular,TextColor3=z.Muted,Parent=dm})local dp=ai('TextButton',{AnchorPoint=Vector2.new(1,0),Position=UDim2.fromScale(1,0),Size=UDim2.fromOffset(0,16),AutomaticSize=Enum.AutomaticSize.X,BackgroundTransparency=1,Text='Clear filters',TextSize=12,FontFace=D.Medium,TextColor3=z.Accent,AutoButtonColor=false,Visible=false,Parent=dm})local dq local function dr()return cm.Search~=''or cm.Tag~=nil or cm.Filter~='All'end local function ds(dt)local du={}if cm.Filter~='All'then table.insert(du,'in '..cm.Filter)end if cm.Tag then table.insert(du,'tagged '..cB(cm.Tag))end if cm.Search~=''then table.insert(du,('matching <font color="#%s">"%s"</font>'):format(bc(z.Accent),cB(cm.Search)))end local dv=#du>0 and(' '..table.concat(du,', '))or''if dt or(cl and#cf==0)then dn.Text='Searching'..dv..'...'else local dw=#cf dn.Text=('%d%s config%s%s'):format(dw,ci and'+'or'',(dw==1 and not ci)and''or's',dv)end dp.Visible=dr()end local dt=nil local function du(dv)cl=dv if dv and not dt then c0.Rotation=0 dt=a:Create(c0,TweenInfo.new(0.9,Enum.EasingStyle.Linear,Enum.EasingDirection.In,-1),{Rotation=360})dt:Play()elseif not dv and dt then dt:Cancel()dt=nil ah(c0,{Rotation=360},0.35,Enum.EasingStyle.Quint)end ds()end local dv=ai('Frame',{Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,BackgroundTransparency=1,LayoutOrder=1,Parent=dl})local dw=ai('UIGridLayout',{CellSize=UDim2.new(1,0,0,b1),CellPadding=UDim2.fromOffset(8,8),SortOrder=Enum.SortOrder.LayoutOrder,Parent=dv})local function dx()local dy=dl.AbsoluteSize.X/b_.Scale.Scale local dz=dy>=620 and 2 or 1 dw.CellSize=UDim2.new(1/dz,-(dz-1)*8/dz,0,b1)end dl:GetPropertyChangedSignal('AbsoluteSize'):Connect(dx)task.defer(dx)local dy=bF(dl,'Load more',{Size=UDim2.new(1,0,0,32),LayoutOrder=2,Visible=false},function()ce:LoadMore()end)local dz=ai('Frame',{Size=UDim2.new(1,0,0,180),BackgroundTransparency=1,Visible=false,LayoutOrder=3,Parent=dl})local dA={}local function dB(dC)for dD=1,dC do local dE=ai('Frame',{BackgroundColor3=z.Surface2,BorderSizePixel=0,LayoutOrder=100000+#dA,Parent=dv})aj(dE,UDim.new(0,10))ak(dE)for dF,dG in ipairs({{14,0.45},{36,0.3},{58,0.8},{76,0.6}})do local dH=ai('Frame',{Position=UDim2.fromOffset(14,dG[1]),Size=UDim2.new(dG[2],-14,0,dF==1 and 14 or 10),BackgroundColor3=z.Surface3,BorderSizePixel=0,Parent=dE})aj(dH,UDim.new(0,4))a:Create(dH,TweenInfo.new(0.75,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut,-1,true),{BackgroundTransparency=0.65}):Play()end table.insert(dA,dE)end end local function dC()for dD,dE in ipairs(dA)do dE:Destroy()end dA={}end local function dD(dE,dF)cK(dz)dz.Visible=dE~=nil if not dE then return end local dG,dH=by(dz,dE=='error'and'cloud-off'or'search-x',dF)dG.Size=UDim2.fromOffset(280,70)dG.Position=UDim2.new(0.5,0,0,60)dH.TextWrapped=true dH.TextTruncate=Enum.TextTruncate.None dH.Size=UDim2.new(1,0,0,32)if dE=='error'or dr()then bF(dz,dE=='error'and'Try again'or'Clear filters',{AnchorPoint=Vector2.new(0.5,0),Position=UDim2.new(0.5,0,0,132),Size=UDim2.fromOffset(0,30),AutomaticSize=Enum.AutomaticSize.X},function()if dE=='error'then ce:Refresh()else dq()end end)end ds()end local dE,dF,dG local function dH(dI)local dJ=dI.Record dI.Title.Text=cC(dJ.Name)local dK={'by '..dJ.Author}local dL=cA(dJ.Updated)if dL then table.insert(dK,dL)end if dJ.Count then table.insert(dK,dJ.Count..(dJ.Count==1 and' setting'or' settings'))end dI.Meta.Text=table.concat(dK,'  \u{b7}  ')dI.Desc.Text=dJ.Description~=''and cC(dJ.Description)or'No description'dI.Desc.TextTransparency=dJ.Description~=''and 0.2 or 0.55 dI.Likes.Text=cz(dJ.Likes)dI.Installs.Text=cz(dJ.Installs)ah(dI.Heart,{ImageColor3=dJ.Liked and z.Accent or z.Muted},0.15)local dM=cG(dJ)local dN,dO if dM=='Update'then dN,dO='UPDATE',z.Accent elseif dM=='Installed'then dN,dO='INSTALLED',z.Success elseif dJ.Mine then dN,dO='YOURS',z.Accent elseif cH(dJ)then dN,dO='OTHER SCRIPT',z.Warning end dI.Badge.Visible=dN~=nil if dN then dI.Badge.Text=dN ah(dI.Badge,{TextColor3=dO,BackgroundColor3=dO},0)end dI.Star.Visible=ct[dJ.Id]~=nil dI.InstallText.Text=dM=='Update'and'Update'or(dM=='Installed'and'Reinstall'or'Install')cK(dI.TagRow)for dP,dQ in ipairs(dJ.Tags)do if dP>3 then cM(dI.TagRow,'+'..(#dJ.Tags-3),dP)break end cM(dI.TagRow,dQ,dP)end end local function dI(dJ,dK)local dL=ai('TextButton',{BackgroundColor3=z.Surface2,BorderSizePixel=0,Text='',AutoButtonColor=false,LayoutOrder=dK,Parent=dv})dL:SetAttribute('NoDrag',true)aj(dL,UDim.new(0,10))aG(dL,ak(dL))al(dL,14,14,12,12)local dM={Record=dJ,Frame=dL}dM.Title=am({Size=UDim2.new(1,-110,0,18),RichText=true,TextSize=14,FontFace=D.Bold,Parent=dL})local dN=ai('Frame',{AnchorPoint=Vector2.new(1,0),Position=UDim2.fromScale(1,0),Size=UDim2.fromOffset(0,18),AutomaticSize=Enum.AutomaticSize.X,BackgroundTransparency=1,Parent=dL})local dO=cN(dN,6)dO.HorizontalAlignment=Enum.HorizontalAlignment.Right dM.Star=am({Size=UDim2.fromOffset(14,18),Text='\u{2605}',TextSize=13,TextColor3=z.Accent,TextXAlignment=Enum.TextXAlignment.Center,TextTruncate=Enum.TextTruncate.None,LayoutOrder=1,Parent=dN})dM.Badge=am({Size=UDim2.fromOffset(0,17),AutomaticSize=Enum.AutomaticSize.X,BackgroundTransparency=0.85,TextSize=10,FontFace=D.Bold,TextXAlignment=Enum.TextXAlignment.Center,TextTruncate=Enum.TextTruncate.None,LayoutOrder=2,Parent=dN})aj(dM.Badge,UDim.new(0,5))al(dM.Badge,6,6)dM.Meta=am({Position=UDim2.fromOffset(0,20),Size=UDim2.new(1,0,0,16),TextSize=12,FontFace=D.Regular,TextColor3=z.Muted,Parent=dL})dM.Desc=am({Position=UDim2.fromOffset(0,41),RichText=true,Size=UDim2.new(1,0,0,30),TextSize=12,FontFace=D.Regular,TextWrapped=true,TextYAlignment=Enum.TextYAlignment.Top,Parent=dL})local dP=ai('Frame',{AnchorPoint=Vector2.new(0,1),Position=UDim2.fromScale(0,1),Size=UDim2.new(1,0,0,26),BackgroundTransparency=1,Parent=dL})dM.TagRow=ai('Frame',{Size=UDim2.new(1,-190,1,0),BackgroundTransparency=1,ClipsDescendants=true,Parent=dP})cN(dM.TagRow,4)local dQ,dR=bF(dP,'Install',{AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,0,0.5,0),Size=UDim2.fromOffset(76,26)},function()dF(dJ)end)cJ(dQ,dR)dM.InstallText=dR local dS=ai('Frame',{AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-86,0.5,0),Size=UDim2.fromOffset(0,20),AutomaticSize=Enum.AutomaticSize.X,BackgroundTransparency=1,Parent=dP})cN(dS,4)local function dT(dU,dV)local dW,dX=aB(dS,dU,z.Muted,UDim2.new())dW.Size=UDim2.fromOffset(12,12)dW.LayoutOrder=dV local dY=am({Size=UDim2.fromOffset(0,20),AutomaticSize=Enum.AutomaticSize.X,TextSize=12,TextColor3=z.Muted,TextTruncate=Enum.TextTruncate.None,LayoutOrder=dV+1,Parent=dS})return dY,dX end dM.Likes,dM.Heart=dT('heart',1)ai('Frame',{Size=UDim2.fromOffset(4,1),BackgroundTransparency=1,LayoutOrder=3,Parent=dS})dM.Installs=dT('download',4)local dU=ay(dL,function()return dl end)dL.MouseButton1Click:Connect(function()if dU()then if cm.Search~=''then db(cm.Search)end dE(dJ)end end)ch[dJ.Id]=dM dH(dM)return dM end local function dJ()for dK,dL in pairs(ch)do dL.Frame:Destroy()end ch={}for dK,dL in ipairs(cf)do dI(dL,dK)end end local function dK()local dL=cm.Filter=='Favorites'and ct or cu local dM=string.lower(cm.Search)local dN={}for dO,dP in pairs(dL)do local dQ=cm.Filter=='Favorites'and dP or(type(dP)=='table'and dP.Record)if type(dQ)=='table'then dQ=table.clone(dQ)dQ.Id=dO local dR=cD(dQ)local dS=dM==''or string.find(string.lower(dR.Name),dM,1,true)or string.find(string.lower(dR.Description),dM,1,true)if dS and cm.Tag then dS=table.find(dR.Tags,cm.Tag)~=nil end if dS then table.insert(dN,dR)end end end table.sort(dN,function(dO,dP)if cm.Sort=='New'then return(dO.Updated or 0)>(dP.Updated or 0)elseif cm.Sort=='Installs'then return dO.Installs>dP.Installs end return dO.Likes>dP.Likes end)return dN end local function dL()if cm.Filter=='Favorites'then return[[No favorites yet. Open a config and press Favorite to keep it here.]]elseif cm.Filter=='Installed'then return'Nothing installed from the cloud yet'elseif cm.Filter=='Mine'then return"You haven't published anything yet"elseif cm.Search~=''or cm.Tag then return'No configs match your search'end return tostring(bZ.EmptyText or'No configs shared yet. Be the first!')end function c7(dM)ck+=1 local dN=ck if cm.Filter=='Favorites'or cm.Filter=='Installed'then du(false)dC()cf=dK()ci=false dJ()dy.Visible=false dD(#cf==0 and'empty'or nil,dL())return end if type(bZ.OnFetch)~='function'then dJ()dD(#cf==0 and'empty'or nil,dL())return end if dM then if not ci then return end cj+=1 else cj=1 cf={}dJ()dl.CanvasPosition=Vector2.zero end du(true)dC()dB(dM and 2 or 4)dy.Visible=false dD(nil)local dO={Search=cm.Search,Sort=cm.Sort,Filter=cm.Filter,Tag=cm.Tag,Page=cj,PageSize=ca,Folder=b_.ConfigFolder,UserId=j.UserId}task.spawn(function()local dP,dQ,dR=aK(function()return bZ.OnFetch(dO)end)if dN~=ck then return end du(false)dC()if not dP or type(dQ)~='table'then if dM then cj-=1 end if not dP then warn('[AirFlow] cloud OnFetch error: '..tostring(dQ))end ci=dM and ci or false dy.Visible=false dD('error',not dP and'Could not load configs'or tostring(dR or'Could not load configs'))return end ci=dR==true local dS={}for dT,dU in ipairs(cf)do dS[dU]=true end for dT,dU in ipairs(dQ)do local dV=cD(dU)if dV and not dS[dV]then dS[dV]=true table.insert(cf,dV)dI(dV,#cf)end end dy.Visible=ci dD(#cf==0 and'empty'or nil,dL())end)end dl:GetPropertyChangedSignal('CanvasPosition'):Connect(function()if not ci or cl then return end local dM=b_.Scale.Scale local dN=dl.AbsoluteCanvasSize.Y/dM-dl.AbsoluteWindowSize.Y/dM-dl.CanvasPosition.Y if dN<160 then c7(true)end end)local dM,dN={},{}local function dO(dP)for dQ,dR in pairs(dM)do dR.Set(cm.Filter==dQ,dP)end for dQ,dR in pairs(dN)do dR.Set(cm.Tag==dQ,dP)end dh.Text=b6[cm.Sort]end for dP,dQ in ipairs(b7)do if not(dQ=='Mine'and bZ.MineFilter==false)then dM[dQ]=cL(di,dQ,dP,function()if cm.Filter~=dQ then cm.Filter=dQ dO()c7(false)end end)end end if#cb>0 then ai('Frame',{Size=UDim2.fromOffset(1,16),BackgroundColor3=z.Stroke,BorderSizePixel=0,LayoutOrder=10,Parent=di})end for dP,dQ in ipairs(cb)do dQ=tostring(dQ)dN[dQ]=cL(di,dQ,10+dP,function()cm.Tag=cm.Tag~=dQ and dQ or nil dO()c7(false)end)end df.MouseButton1Click:Connect(function()local dP=table.find(b5,cm.Sort)or 1 cm.Sort=b5[dP%#b5+1]cv('CloudSort',cm.Sort)dO()c7(false)end)function dq()c8+=1 c5.Text=''cm.Search,cm.Tag,cm.Filter='',nil,'All'dO()c7(false)end dp.MouseButton1Click:Connect(dq)c5:GetPropertyChangedSignal('Text'):Connect(function()c6.Visible=c5.Text~=''dc(c5:IsFocused())c8+=1 local dP=c8 local dQ=bM(c5.Text)if dQ~=cm.Search then ds(true)end task.delay(0.35,function()dQ=bM(c5.Text)if dP==c8 and dQ~=cm.Search then cm.Search=dQ c7(false)end end)end)c5.Focused:Connect(function()ah(c2,{Color=z.Accent},0.15)ah(c4,{ImageColor3=z.Accent},0.15)dc(true)end)c5.FocusLost:Connect(function(dP)ah(c2,{Color=z.Stroke},0.2)ah(c4,{ImageColor3=z.Muted},0.2)db(c5.Text)task.delay(0.15,function()if not c5:IsFocused()then dc(false)end end)if dP then c8+=1 local dQ=bM(c5.Text)if dQ~=cm.Search then cm.Search=dQ c7(false)end end end)c6.MouseButton1Click:Connect(function()c8+=1 c5.Text=''if cm.Search~=''then cm.Search=''c7(false)end end)b_:_listen('Began',function(dP,dQ)if dQ or dP.KeyCode~=Enum.KeyCode.Slash then return end if b_.Open and b_.CurrentTab==b0 and co==cn.Browse and not b:GetFocusedTextBox()then task.defer(function()c5:CaptureFocus()c5.Text=c5.Text:gsub('/$','')end)end end,ce)c_.MouseButton1Click:Connect(function()ce:Refresh()end)local function dP(dQ,dR,dS)if dQ.Code then dR(dQ.Code)return end local function dT(dU)if dS then dS(dU)else cw(false,'Could not load config',dU)end end if type(bZ.OnFetchCode)~='function'then dT('This config has no code')return end task.spawn(function()local dU,dV,dW=aK(function()return bZ.OnFetchCode(cE(dQ))end)if dU and type(dV)=='string'and dV~=''then dQ.Code=dV dQ.Count=dQ.Count or cy(dV)dR(dV)else dT(tostring(dW or(not dU and'the request failed')or'no code came back'))end end)end function dF(dQ)if dQ._busy then return end dQ._busy=true dP(dQ,function(dR)dQ._busy=nil local dS,dT=b_:DecodeConfig(dR)if not dS then cw(false,'Install failed','The config code is invalid')return end local dU=0 for dV in pairs(dS)do dU+=1 end local dV=cu[dQ.Id]local dW=nil if ba()then dW=type(dV)=='table'and type(dV.Name)=='string'and b_:ConfigExists(dV.Name)and dV.Name or cS(dQ.Name)end local dX=dT.Folder and dT.Folder~=b_.ConfigFolder local function dY(dZ)local d_=dZ and dW or nil local d0,d1=b_:ImportConfig(dR,d_,true)if not d0 then cw(false,'Install failed',tostring(d1))return end cu[dQ.Id]={Updated=dQ.Updated or os.time(),Name=d_,At=os.time(),Record=cF(dQ)}cv('CloudInstalled',cu)dQ.Installs+=1 dG(dQ)cw(true,'Config installed',d_ and('Saved as '..d_)or'Applied to your current settings')if bZ.OnInstall then task.spawn(aJ,bZ.OnInstall,cE(dQ),d_)end end local dZ=('%s by %s changes %d setting%s.'):format(dQ.Name,dQ.Author,dU,dU==1 and''or's')if dX then dZ..=(' It was made for %s, so only matching settings apply.'):format(dT.Folder)end if dW then dZ..=(" Install also saves it as %s; Apply only doesn't."):format(dW)end local d_={{Title='Cancel'}}table.insert(d_,{Title='Apply only',Variant=not dW and'Primary'or nil,Callback=function()dY(false)end})if dW then table.insert(d_,{Title='Install',Variant='Primary',Callback=function()dY(true)end})end b_:Dialog({Title=cG(dQ)=='Update'and'Update config'or'Install config',Content=dZ,Icon=dX and'triangle-alert'or'download',Buttons=d_})end,function(dR)dQ._busy=nil cw(false,'Could not load config',dR)end)end local function dQ(dR)if type(bZ.OnLike)~='function'or dR._liking then return end local dS=not dR.Liked dR.Liked=dS dR.Likes=math.max(dR.Likes+(dS and 1 or-1),0)dR._liking=true dG(dR)task.spawn(function()local dT,dU,dV=aK(function()return bZ.OnLike(cE(dR),dS)end)dR._liking=nil if not dT or dU==false then dR.Liked=not dS dR.Likes=math.max(dR.Likes+(dS and-1 or 1),0)dG(dR)cw(false,'Like not saved',tostring(dV or'Try again in a moment'))end end)end local function dR(dS)local dT=ct[dS.Id]==nil ct[dS.Id]=dT and cF(dS)or nil cv('CloudFavorites',ct)dG(dS)b_:Notify({Title=dT and'Added to favorites'or'Removed from favorites',Content=dS.Name,Icon='star',Duration=2})end local function dS(dT)local dU=table.find(cf,dT)if dU then table.remove(cf,dU)end cg[dT.Id]=nil local dV=ch[dT.Id]if dV then dV.Frame:Destroy()ch[dT.Id]=nil end if#cf==0 and not cl then dD('empty',dL())end end local function dT(dU)b_:Confirm({Title='Delete config',Content=([[Remove %s from the cloud? People who installed it keep their copy.]]):format(dU.Name),Icon='trash-2',ConfirmText='Delete',Callback=function()task.spawn(function()local dV,dW,dX=aK(function()return bZ.OnDelete(cE(dU))end)if not dV or dW==false then cw(false,'Delete failed',tostring(dX or'Try again in a moment'))return end ct[dU.Id]=nil cv('CloudFavorites',ct)dS(dU)cV(cn.Browse)cw(true,'Config deleted',dU.Name)end)end})end local function dU(dV)local dW=type(bZ.ReportReasons)=='table'and bZ.ReportReasons or{'Broken','Spam','Inappropriate'}local dX={{Title='Cancel'}}for dY,dZ in ipairs(dW)do table.insert(dX,{Title=tostring(dZ),Callback=function()task.spawn(function()local d_,d0=aK(function()return bZ.OnReport(cE(dV),tostring(dZ))end)local d1=d_ and d0~=false cw(d1,d1 and'Report sent'or'Report failed',d1 and'Thanks for letting us know'or'Try again in a moment')end)end})end b_:Dialog({Title='Report config',Content=("What's wrong with %s?"):format(dV.Name),Icon='flag',Buttons=dX})end local dV=cQ(cn.Detail)al(dV,1,8,1,16)cO(dV,10)local function dW(dX)local dY=type(dX)=='table'and dX.Value or nil if dY==nil then return'None'elseif type(dY)=='boolean'then return dY and'On'or'Off'elseif type(dY)=='number'then return(('%.2f'):format(dY):gsub('%.?0+$',''))elseif type(dY)=='table'then if type(dY.Hex)=='string'then return'#'..string.upper(dY.Hex)elseif type(dY.Colors)=='table'then local dZ=type(dY.Name)=='string'and dY.Name or'Custom'if type(dY.Background)=='string'and dY.Background~=''then dZ..=', image'end return dZ end local dZ={}for d_,d0 in ipairs(dY)do dZ[d_]=tostring(d0)end return#dZ>0 and table.concat(dZ,', ')or'None'end return tostring(dY)end local function dX(dY)local dZ,d_=pcall(e.JSONEncode,e,type(dY)=='table'and dY.Value or nil)return dZ and d_ or tostring(dY)end local function dY()local dZ=cq if not dZ or not cp.Meta then return end cp.Title.Text=dZ.Name local d_={'by '..dZ.Author}local d0=cA(dZ.Updated)if d0 then table.insert(d_,'updated '..d0)end if cH(dZ)then table.insert(d_,'made for '..dZ.Folder)end cp.Meta.Text=table.concat(d_,'  \u{b7}  ')cp.Stats.Text=('%s like%s  \u{b7}  %s install%s'):format(cz(dZ.Likes),dZ.Likes==1 and''or's',cz(dZ.Installs),dZ.Installs==1 and''or's')if cp.BuiltFor~=dZ or cp.BuiltMine~=dZ.Mine then cp.BuiltFor,cp.BuiltMine=dZ,dZ.Mine local d1=cp.Actions cK(d1)local d2=0 local function d3(d4,d5,d6)d2+=1 local d7,d8=bF(d1,d4,{Size=UDim2.new(0,0,0,30),AutomaticSize=Enum.AutomaticSize.X,LayoutOrder=d2},d6)d8.TextSize=13 if d5=='Primary'then cJ(d7,d8)elseif d5=='Danger'then ah(d8,{TextColor3=z.Error},0)end return d8 end cp.InstallLabel=d3('Install','Primary',function()dF(dZ)end)if type(bZ.OnLike)=='function'then cp.LikeLabel=d3('Like',nil,function()dQ(dZ)end)end cp.FavoriteLabel=d3('Favorite',nil,function()dR(dZ)end)d3('Copy code',nil,function()dP(dZ,function(d4)b_:CopyToClipboard(d4,'Config code')end)end)if dZ.Mine then if type(bZ.OnUpdate)=='function'then d3('Edit',nil,function()ce:OpenPublish(dZ)end)end if type(bZ.OnDelete)=='function'then d3('Delete','Danger',function()dT(dZ)end)end elseif type(bZ.OnReport)=='function'then d3('Report','Danger',function()dU(dZ)end)end end local d1=cG(dZ)cp.InstallLabel.Text=d1=='Update'and'Update'or(d1=='Installed'and'Reinstall'or'Install')if cp.LikeLabel then cp.LikeLabel.Text=(dZ.Liked and'Liked'or'Like')..'  \u{b7}  '..cz(dZ.Likes)end cp.FavoriteLabel.Text=ct[dZ.Id]and'Favorited'or'Favorite'end local function dZ(d_,d0)local function d1(d2)if cr==d0 then cp.Summary.Text=d2 end end dP(d_,function(d2)if cr~=d0 then return end local d3=b_:DecodeConfig(d2)if not d3 then d1('The config code is invalid')return end local d4=bh(b_)local d5={}local d6=0 for d7,d8 in pairs(d3)do local d9=k.Flags[d7]local ea=d9~=nil local eb=ea and dX(d8)~=dX(d4[d7])if eb then d6+=1 end table.insert(d5,{Name=d9 and d9._searchName~=''and d9._searchName or d7,Value=dW(d8),Known=ea,Changed=eb,Rank=eb and 0 or(ea and 1 or 2)})end table.sort(d5,function(d7,d8)if d7.Rank~=d8.Rank then return d7.Rank<d8.Rank end return string.lower(d7.Name)<string.lower(d8.Name)end)d_.Count=#d5 cp.Summary.Text=d6==0 and('%d settings, all the same as yours'):format(#d5)or('%d settings, %d different from yours'):format(#d5,d6)cK(cp.Rows)for d7,d8 in ipairs(d5)do if d7>150 then cP(cp.Rows,('and %d more'):format(#d5-150),12,z.Muted,d7)break end local d9=ai('Frame',{Size=UDim2.new(1,0,0,30),BackgroundColor3=z.Surface2,BackgroundTransparency=d8.Changed and 0 or 0.5,BorderSizePixel=0,LayoutOrder=d7,Parent=cp.Rows})aj(d9,UDim.new(0,7))if d8.Changed then local ea=ai('Frame',{AnchorPoint=Vector2.new(0,0.5),Position=UDim2.new(0,10,0.5,0),Size=UDim2.fromOffset(6,6),BackgroundColor3=z.Accent,BorderSizePixel=0,Parent=d9})aj(ea,UDim.new(1,0))end am({Position=UDim2.fromOffset(24,0),Size=UDim2.new(0.55,-24,1,0),Text=d8.Known and d8.Name or(d8.Name..'  (not in this script)'),TextSize=12,TextColor3=d8.Known and z.Text or z.Muted,Parent=d9})am({AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,-10,0,0),Size=UDim2.new(0.45,-10,1,0),Text=d8.Value,TextSize=12,FontFace=D.Regular,TextColor3=d8.Changed and z.Accent or z.Muted,TextXAlignment=Enum.TextXAlignment.Right,Parent=d9})end if ch[d_.Id]then dH(ch[d_.Id])end end,d1)end function dE(d_)cq=d_ cr+=1 local d0=cr cK(dV)cp={}dV.CanvasPosition=Vector2.zero bF(dV,'Back',{Size=UDim2.new(0,0,0,28),AutomaticSize=Enum.AutomaticSize.X,LayoutOrder=1},function()cV(cn.Browse)end)cp.Title=cP(dV,d_.Name,20,z.Text,2,D.Bold)cp.Meta=cP(dV,'',12,z.Muted,3)if d_.Description~=''then cP(dV,d_.Description,13,z.Text,4)end if#d_.Tags>0 then local d1=ai('Frame',{Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,BackgroundTransparency=1,LayoutOrder=5,Parent=dV})cN(d1,4,true)for d2,d3 in ipairs(d_.Tags)do cM(d1,d3,d2)end end cp.Stats=cP(dV,'',12,z.Muted,6)cp.Actions=ai('Frame',{Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,BackgroundTransparency=1,LayoutOrder=7,Parent=dV})cN(cp.Actions,6,true)ai('Frame',{Size=UDim2.new(1,0,0,1),BackgroundColor3=z.Stroke,BorderSizePixel=0,LayoutOrder=8,Parent=dV})cP(dV,'Settings',14,z.Text,9,D.Bold)cp.Summary=cP(dV,'Loading settings...',12,z.Muted,10)cp.Rows=ai('Frame',{Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,BackgroundTransparency=1,LayoutOrder=11,Parent=dV})cO(cp.Rows,4)dY()cV(cn.Detail)dZ(d_,d0)end function dG(d_)local d0=ch[d_.Id]if d0 then dH(d0)end if cq==d_ and co==cn.Detail then dY()end end local d_={Mode='Publish',Record=nil,Source=false,Tags={},Busy=false}local d0=cQ(cn.Publish)al(d0,1,8,1,16)cO(d0,8)bF(d0,'Back',{Size=UDim2.new(0,0,0,28),AutomaticSize=Enum.AutomaticSize.X,LayoutOrder=1},function()cV(d_.Mode=='Edit'and d_.Record and cn.Detail or cn.Browse)end)local d1=cP(d0,'Publish a config',20,z.Text,2,D.Bold)cP(d0,'Name',12,z.Muted,3)local d2=cR(d0,4,'What is it for?',b2,b8)cP(d0,'Description',12,z.Muted,5)local d3=cR(d0,6,'What does it do, and how should people use it?',90,b9)local d4=cP(d0,'Tags',12,z.Muted,7)local d5=ai('Frame',{Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,BackgroundTransparency=1,LayoutOrder=8,Parent=d0})cN(d5,6,true)d4.Visible=#cb>0 and cc>0 d5.Visible=d4.Visible cP(d0,'Settings to share',12,z.Muted,9)local d6=ai('Frame',{Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,BackgroundTransparency=1,LayoutOrder=10,Parent=d0})cN(d6,6,true)local d7=cP(d0,'',12,z.Muted,11)local d8=cP(d0,'',12,z.Muted,12)local d9=cP(d0,'',12,z.Error,13)d9.Visible=false local ea=ai('Frame',{Size=UDim2.new(1,0,0,32),BackgroundTransparency=1,LayoutOrder=14,Parent=d0})cN(ea,6)local eb,ec=bF(ea,'Publish',{Size=UDim2.new(0,0,1,0),AutomaticSize=Enum.AutomaticSize.X,LayoutOrder=1},function()ce:_submit()end)cJ(eb,ec)bF(ea,'Cancel',{Size=UDim2.new(0,0,1,0),AutomaticSize=Enum.AutomaticSize.X,LayoutOrder=2},function()cV(d_.Mode=='Edit'and d_.Record and cn.Detail or cn.Browse)end)local ed={}local function ee()for ef,eg in pairs(ed)do eg.Set(table.find(d_.Tags,ef)~=nil)end d4.Text=cc>0 and('Tags  (%d/%d)'):format(#d_.Tags,cc)or'Tags'end for ef,eg in ipairs(cb)do eg=tostring(eg)ed[eg]=cL(d5,eg,ef,function()local eh=table.find(d_.Tags,eg)if eh then table.remove(d_.Tags,eh)elseif#d_.Tags<cc then table.insert(d_.Tags,eg)else cw(false,'Too many tags',('Pick up to %d'):format(cc))end ee()end)end local function ef(eg)if d_.Source=='Keep'then return nil,d_.Record and d_.Record.Count elseif d_.Source then local eh,ei=b_:ExportConfig(d_.Source)if not eh then return nil,nil,ei end return eh,cy(eh)end local eh,ei=pcall(bj,b_,eg~=''and eg or'Cloud config',bh(b_))if not eh then return nil,nil,'could not encode your settings'end return ei,cy(ei)end local eg={}local function eh()for ei,ej in pairs(eg)do ej.Set(ei==(d_.Source or'*current'))end local ei,ej,ek=ef(bM(d2.Text))if ek then d7.Text=tostring(ek)elseif d_.Source=='Keep'then d7.Text='Keeps the settings already published'..(ej and(' ('..ej..')')or'')else d7.Text=('%d setting%s from %s'):format(ej or 0,ej==1 and''or's',d_.Source or'your current settings')end end local function ei()cK(d6)eg={}local ej=0 local function ek(el,em)ej+=1 eg[el]=cL(d6,em,ej,function()d_.Source=el~='*current'and el or false eh()end)end if d_.Mode=='Edit'then ek('Keep','Keep published settings')end ek('*current','Current settings')for el,em in ipairs(b_:ListConfigs())do ek(em,em)end eh()end local function ej(ek)d9.Text=tostring(ek)d9.Visible=true end function ce:OpenPublish(ek)local el=type(ek)=='table'and ek.Id and cg[ek.Id]or nil if el then d_.Mode,d_.Record='Edit',el d_.Source='Keep'd_.Tags=table.clone(el.Tags)d2.Text=el.Name d3.Text=el.Description elseif d_.Mode=='Edit'then d_.Mode,d_.Record,d_.Source,d_.Tags='Publish',nil,false,{}d2.Text=''d3.Text=''end d1.Text=el and'Edit config'or'Publish a config'ec.Text=el and'Save changes'or'Publish'd9.Visible=false local em=cx()d8.Text=em and('Your name is hidden, so you publish as '..cd)or('You publish as '..j.DisplayName)ee()ei()d0.CanvasPosition=Vector2.zero cV(cn.Publish)end d2:GetPropertyChangedSignal('Text'):Connect(function()d9.Visible=false end)function ce:_submit()if d_.Busy then return end local ek=bM(d2.Text)if ek==''then ej('Give your config a name')return end local el,em,en=ef(ek)if en then ej(en)return end if d_.Source~='Keep'and(em or 0)==0 then ej('There are no settings to share')return end local eo=d_.Mode=='Edit'and d_.Record or nil local ep=eo and bZ.OnUpdate or bZ.OnPublish if type(ep)~='function'then ej(eo and"Editing isn't available"or"Publishing isn't available")return end local eq=cx()local er={Name=ek,Description=bM(d3.Text),Tags=table.clone(d_.Tags),Code=el,Count=em,Folder=b_.ConfigFolder,Author=eq and cd or j.DisplayName,AuthorId=not eq and j.UserId or nil,OwnerId=j.UserId,Streamer=eq}d_.Busy=true ec.Text=eo and'Saving...'or'Publishing...'d9.Visible=false task.spawn(function()local es,et,eu=aK(function()if eo then return ep(cE(eo),er)end return ep(er)end)d_.Busy=false ec.Text=eo and'Save changes'or'Publish'if not es or et==false then if not es then warn('[AirFlow] cloud publish error: '..tostring(et))end ej(es and eu and tostring(eu)or'Something went wrong, try again')return end local ev=table.clone(er)ev.Code=el or(eo and eo.Code)ev.Updated=os.time()if type(et)=='table'then for ew,ex in pairs(et)do ev[ew]=ex end end if eo then ev.Id=eo.Id cD(ev)if ct[eo.Id]then ct[eo.Id]=cF(eo)cv('CloudFavorites',ct)end dG(eo)cw(true,'Config updated',ek)dE(eo)else d2.Text=''d3.Text=''d_.Tags={}d_.Source=false if type(et)=='table'then ev.Mine=true local ew=cD(ev)if cm.Filter=='All'or cm.Filter=='Mine'then table.insert(cf,1,ew)dJ()dD(nil)end cw(true,'Config published',ek)dE(ew)else cw(true,'Config published',ek)cV(cn.Browse)c7(false)end end end)end function ce:Refresh()c7(false)end function ce:LoadMore()if not cl then c7(true)end end function ce:SetConfigs(ek,el)ck+=1 du(false)dC()cf={}for em,en in ipairs(type(ek)=='table'and ek or{})do local eo=cD(en)if eo then table.insert(cf,eo)end end ci=el==true dJ()dy.Visible=ci dD(#cf==0 and'empty'or nil,dL())end function ce:AddConfigs(ek,el)ck+=1 du(false)dC()for em,en in ipairs(type(ek)=='table'and ek or{})do local eo=cD(en)if eo and not table.find(cf,eo)then table.insert(cf,eo)dI(eo,#cf)end end ci=el==true dy.Visible=ci dD(#cf==0 and'empty'or nil,dL())end function ce:UpdateConfig(ek,el)local em=cg[tostring(ek)]if em and type(el)=='table'then local en=table.clone(el)en.Id=em.Id cD(en)dG(em)end end function ce:RemoveConfig(ek)local el=cg[tostring(ek)]if el then dS(el)if cq==el and co==cn.Detail then cV(cn.Browse)end end end function ce:SetLoading(ek)ck+=1 du(ek==true)dC()if cl then dB(4)dD(nil)end end function ce:SetError(ek)ck+=1 du(false)dC()dD(ek and'error'or nil,tostring(ek or''))end function ce:Open(ek)local el=cg[tostring(ek)]if el then b_:SelectTab(b0)dE(el)end end function ce:Back()cV(cn.Browse)end function ce:GetQuery()return table.clone(cm)end function ce:GetFavorites()local ek={}for el,em in pairs(ct)do local en=table.clone(em)en.Id=el table.insert(ek,en)end return ek end function ce:GetInstalled()local ek={}for el,em in pairs(cu)do table.insert(ek,{Id=el,Name=em.Name,Updated=em.Updated,Record=em.Record})end return ek end dO(true)cV(cn.Browse)local ek=false local function el()if not ek and b0._page.Visible then ek=true c7(false)end end b0._page:GetPropertyChangedSignal('Visible'):Connect(el)if type(bZ.OnFetch)~='function'then ek=true dD('empty',dL())else task.defer(el)end return ce end a2.CreateCloudConfigs=a2.CloudConfigs a2.CloudConfig=a2.CloudConfigs a2.CreateCloudConfig=a2.CloudConfigs function aS:SetBadge()end function aS:GetBadge()return nil end function a2:Dialog(bZ)bZ=l(bZ,{Text='Content',Message='Content'})if self._dialog then self._dialog.Close()end local b_=300 local b0=18 local b1=ai('TextButton',{Size=UDim2.fromScale(1,1),BackgroundColor3=Color3.new(0,0,0),BackgroundTransparency=1,Text='',AutoButtonColor=false,ZIndex=40,Parent=self.Body})local b2=ai('Frame',{AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.new(0.5,0,0.5,10),Size=UDim2.fromOffset(b_,120),BackgroundColor3=z.Background,BackgroundTransparency=1,BorderSizePixel=0,ZIndex=41,Parent=b1})aj(b2,UDim.new(0,10))local b3=ak(b2,z.Stroke,1)local b5=ai('UIScale',{Scale=0.94,Parent=b2})local b6={}local b7=0 if bZ.Icon then local b8,b9=aB(b2,bZ.Icon,z.Accent,UDim2.new(0,b0,0,b0+9))b9.ImageTransparency=1 b8.ZIndex=42 b9.ZIndex=42 table.insert(b6,{b9,'ImageTransparency',0})b7=24 end local b8=am({Position=UDim2.fromOffset(b0+b7,b0),Size=UDim2.new(1,-(b0*2+b7),0,18),Text=bZ.Title or'Are you sure?',TextSize=15,TextTransparency=1,ZIndex=42,Parent=b2})table.insert(b6,{b8,'TextTransparency',0})local b9=0 if bZ.Content then local ca=am({Position=UDim2.fromOffset(b0,b0+24),Size=UDim2.new(1,-b0*2,0,0),AutomaticSize=Enum.AutomaticSize.Y,Text=bZ.Content,TextSize=13,FontFace=D.Regular,TextColor3=z.Muted,TextWrapped=true,TextTransparency=1,TextTruncate=Enum.TextTruncate.None,TextYAlignment=Enum.TextYAlignment.Top,ZIndex=42,Parent=b2})table.insert(b6,{ca,'TextTransparency',0})b9=math.max(ca.TextBounds.Y,16)+6 ca:GetPropertyChangedSignal('TextBounds'):Connect(function()local cb=math.max(ca.TextBounds.Y,16)+6 if cb~=b9 then b9=cb b2.Size=UDim2.fromOffset(b_,b0+24+b9+12+34+b0)local cc=b2:FindFirstChild('ButtonRow')if cc then cc.Position=UDim2.fromOffset(b0,b0+24+b9+12)end end end)end local ca=ai('Frame',{Name='ButtonRow',Position=UDim2.fromOffset(b0,b0+24+b9+12),Size=UDim2.new(1,-b0*2,0,34),BackgroundTransparency=1,ZIndex=42,Parent=b2})ai('UIListLayout',{FillDirection=Enum.FillDirection.Horizontal,HorizontalAlignment=Enum.HorizontalAlignment.Right,SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,8),Parent=ca})b2.Size=UDim2.fromOffset(b_,b0+24+b9+12+34+b0)local cb={}local cc=false function cb.Close()if cc then return end cc=true if self._dialog==cb then self._dialog=nil end ah(b1,{BackgroundTransparency=1},0.18)ah(b2,{BackgroundTransparency=1,Position=UDim2.new(0.5,0,0.5,8)},0.18,Enum.EasingStyle.Quint)ah(b5,{Scale=0.96},0.18,Enum.EasingStyle.Quint)ah(b3,{Transparency=1},0.12)for cd,ce in ipairs(b6)do ah(ce[1],{[ce[2] ]=1},0.12)end task.delay(0.2,function()b1:Destroy()end)end for cd,ce in ipairs(bZ.Buttons or{})do local cf=ce.Variant=='Primary'local cg=ai('TextButton',{Size=UDim2.fromOffset(0,34),AutomaticSize=Enum.AutomaticSize.X,BackgroundColor3=cf and z.Accent or z.Surface2,BackgroundTransparency=1,BorderSizePixel=0,Text='',AutoButtonColor=false,ClipsDescendants=true,LayoutOrder=cd,ZIndex=43,Parent=ca})aj(cg,UDim.new(0,7))local ch=ak(cg,cf and z.Accent or z.Stroke,1)al(cg,14,14)local ci=am({Size=UDim2.new(0,0,1,0),AutomaticSize=Enum.AutomaticSize.X,Text=ce.Title or ce.Name or'OK',TextSize=13,TextColor3=cf and z.AccentDark or z.Text,TextXAlignment=Enum.TextXAlignment.Center,TextTransparency=1,ZIndex=44,Parent=cg})local cj=cf and 0.12 or 0 local ck=cf and 0.4 or 0 table.insert(b6,{cg,'BackgroundTransparency',cj})table.insert(b6,{ch,'Transparency',ck})table.insert(b6,{ci,'TextTransparency',0})cg.MouseEnter:Connect(function()if cc then return end if cf then ah(cg,{BackgroundTransparency=0},0.12)ah(ch,{Transparency=0},0.12)else ah(ch,{Color=z.StrokeHover},0.12)end end)cg.MouseLeave:Connect(function()if cc then return end if cf then ah(cg,{BackgroundTransparency=cj},0.2)ah(ch,{Transparency=ck},0.2)else ah(ch,{Color=z.Stroke},0.2)end end)cg.MouseButton1Click:Connect(function()cb.Close()aJ(ce.Callback)end)end if bZ.CloseOnBackdrop~=false then b1.MouseButton1Click:Connect(function()cb.Close()aJ(bZ.OnCancel)end)end self._dialog=cb ah(b1,{BackgroundTransparency=0.45},0.25)ah(b2,{BackgroundTransparency=0,Position=UDim2.fromScale(0.5,0.5)},0.3,Enum.EasingStyle.Quint)ah(b3,{Transparency=0},0.25)ah(b5,{Scale=1},0.4,Enum.EasingStyle.Back)for cd,ce in ipairs(b6)do ah(ce[1],{[ce[2] ]=ce[3]},0.25)end return cb end function a2:Confirm(bZ)bZ=l(bZ,{Text='Content',Message='Content'})return self:Dialog({Title=bZ.Title or'Are you sure?',Content=bZ.Content,Icon=bZ.Icon,OnCancel=bZ.OnCancel,Buttons={{Title=bZ.CancelText or'Cancel',Callback=bZ.OnCancel},{Title=bZ.ConfirmText or'Confirm',Variant='Primary',Callback=bZ.Callback}}})end function a2:_listen(bZ,b_,b0)local b1=self._inputListeners[bZ]table.insert(b1,b_)local function b2()for b3,b5 in ipairs(b1)do if b5==b_ then table.remove(b1,b3)break end end end if b0 then b0._listeners=b0._listeners or{}table.insert(b0._listeners,b2)end return b2 end function a2:_indicatorY(bZ)local b_=self._tabStack return(bZ._button.AbsolutePosition.Y-b_.AbsolutePosition.Y)/self.Scale.Scale+b_.Position.Y.Offset end function a2:_placeIndicator(bZ)local b_=self.Indicator local b0=self:_indicatorY(bZ)if not b_.Visible then b_.Visible=true b_.Position=UDim2.fromOffset(8,b0)b_.BackgroundTransparency=1 ah(b_,{BackgroundTransparency=0.35},0.3)end ah(b_,{Position=UDim2.fromOffset(8,b0)},0.45,Enum.EasingStyle.Quint)end function a2:_overflowHint(bZ,b_,b0,b1,b2)local b3=ai('Frame',{AnchorPoint=b_.AnchorPoint,Position=b_.Position,Size=b_.Size,BackgroundTransparency=1,ZIndex=3,Parent=bZ})local function b5()b3.Position=b_.Position b3.Size=b_.Size b3.Visible=b_.Visible end for b6,b7 in ipairs({'Position','Size','Visible'})do b_:GetPropertyChangedSignal(b7):Connect(b5)end local function b6(b7)return b1 and b7.Y or b7.X end local function b7()return self.Scale and self.Scale.Scale or 1 end local function b8(b9)local ca=b6(b_.AbsoluteWindowSize)/b7()local cb=math.max(b6(b_.AbsoluteCanvasSize)/b7()-ca,0)local cc=math.clamp(b6(b_.CanvasPosition)+b9*ca*0.75,0,cb)ah(b_,{CanvasPosition=b1 and Vector2.new(0,cc)or Vector2.new(cc,0)},0.35,Enum.EasingStyle.Quint)end local b9={}for ca,cb in ipairs({-1,1})do local cc=cb>0 local cd=ai('Frame',{AnchorPoint=b1 and Vector2.new(0,cc and 1 or 0)or Vector2.new(cc and 1 or 0,0),Position=b1 and UDim2.fromScale(0,cc and 1 or 0)or UDim2.fromScale(cc and 1 or 0,0),Size=b1 and UDim2.new(1,0,0,34)or UDim2.new(0,48,1,0),BackgroundColor3=b2,BackgroundTransparency=1,BorderSizePixel=0,Visible=false,Parent=b3})ai('UIGradient',{Rotation=b1 and(cc and 270 or 90)or(cc and 180 or 0),Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0),NumberSequenceKeypoint.new(0.4,0.2),NumberSequenceKeypoint.new(1,1)}),Parent=cd})local ce=b1 and UDim2.new(0.5,0,cc and 1 or 0,cc and-5 or 5)or UDim2.new(cc and 1 or 0,cc and-2 or 2,0.5,0)local cf=ai('TextButton',{AnchorPoint=b1 and Vector2.new(0.5,cc and 1 or 0)or Vector2.new(cc and 1 or 0,0.5),Position=ce,Size=UDim2.fromOffset(0,20),AutomaticSize=Enum.AutomaticSize.X,BackgroundColor3=z.Surface3,BackgroundTransparency=1,BorderSizePixel=0,Text='',AutoButtonColor=false,Visible=false,ZIndex=2,Parent=b3})aj(cf,UDim.new(1,0))local cg=ak(cf,z.Stroke,1)al(cf,7,7)ai('UIListLayout',{FillDirection=Enum.FillDirection.Horizontal,VerticalAlignment=Enum.VerticalAlignment.Center,SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,3),Parent=cf})local ch=ai('ImageLabel',{Size=UDim2.fromOffset(12,12),BackgroundTransparency=1,ImageColor3=z.Accent,ImageTransparency=1,ScaleType=Enum.ScaleType.Fit,LayoutOrder=1,ZIndex=2,Parent=cf})aq(ch,b1 and(cc and'chevron-down'or'chevron-up')or(cc and'chevron-right'or'chevron-left'))local ci='ImageTransparency'if ch.Image==''then ch:Destroy()ch=am({Size=UDim2.fromOffset(10,20),Text='\u{203a}',TextSize=16,TextColor3=z.Accent,TextTransparency=1,TextXAlignment=Enum.TextXAlignment.Center,TextTruncate=Enum.TextTruncate.None,Rotation=b1 and(cc and 90 or-90)or(cc and 0 or 180),LayoutOrder=1,ZIndex=2,Parent=cf})ci='TextTransparency'end local cj=am({Size=UDim2.new(0,0,1,0),AutomaticSize=Enum.AutomaticSize.X,Text='',TextSize=11,TextColor3=z.Text,TextTransparency=1,TextTruncate=Enum.TextTruncate.None,Visible=false,LayoutOrder=2,ZIndex=2,Parent=cf})cf.MouseEnter:Connect(function()if not ax()then ah(cg,{Color=z.StrokeHover},0.12)end end)cf.MouseLeave:Connect(function()ah(cg,{Color=z.Stroke},0.2)end)cf.MouseButton1Click:Connect(function()b8(cb)end)b9[cb]={Direction=cb,Fade=cd,Chip=cf,Stroke=cg,Arrow=ch,ArrowFade=ci,Count=cj,Home=ce,Shown=false,Generation=0}end local function ca(cb,cc)if cb.Shown==cc then return end cb.Shown=cc cb.Generation+=1 local cd=cb.Home+(b1 and UDim2.fromOffset(0,cb.Direction*6)or UDim2.fromOffset(cb.Direction*6,0))local ce=cc and 0 or 1 if cc then cb.Fade.Visible=true cb.Chip.Visible=true cb.Chip.Position=cd ah(cb.Chip,{Position=cb.Home,BackgroundTransparency=0.08},0.3,Enum.EasingStyle.Quint)else ah(cb.Chip,{Position=cd,BackgroundTransparency=1},0.2,Enum.EasingStyle.Quint)local cf=cb.Generation task.delay(0.21,function()if cb.Generation==cf then cb.Fade.Visible=false cb.Chip.Visible=false end end)end ah(cb.Fade,{BackgroundTransparency=ce},0.2)ah(cb.Stroke,{Transparency=ce},0.2)ah(cb.Arrow,{[cb.ArrowFade]=ce},0.2)ah(cb.Count,{TextTransparency=ce},0.2)end local function cb()local cc=b6(b_.AbsoluteWindowSize)local cd=(b6(b_.AbsoluteCanvasSize)-cc)/b7()local ce=b6(b_.CanvasPosition)local cf=b6(b_.AbsolutePosition)local cg,ch=0,0 for ci,cj in ipairs(b0:GetChildren())do if cj:IsA('GuiObject')and cj.Visible and b6(cj.AbsoluteSize)>0 then local ck=b6(cj.AbsolutePosition)+b6(cj.AbsoluteSize)/2-cf if ck<0 then cg+=1 elseif ck>cc then ch+=1 end end end for ci,cj in pairs(b9)do local ck=ci<0 and cg or ch cj.Count.Text=tostring(ck)cj.Count.Visible=ck>0 ca(cj,cd>1 and(ci<0 and ce>1 or ci>0 and ce<cd-1))end end for cc,cd in ipairs({'CanvasPosition','AbsoluteCanvasSize','AbsoluteWindowSize'})do b_:GetPropertyChangedSignal(cd):Connect(cb)end task.defer(cb)end function a2:_scrollTabIntoView(bZ)local b_=self.TabList local b0=self.Scale.Scale local b1=(bZ._button.AbsolutePosition.Y-b_.AbsolutePosition.Y)/b0+b_.CanvasPosition.Y local b2=b1+bZ._button.AbsoluteSize.Y/b0 local b3=b_.AbsoluteWindowSize.Y/b0 local b5=b_.CanvasPosition.Y if b1-8<b5 then b5=b1-8 elseif b2+8>b5+b3 then b5=b2+8-b3 else return end ah(b_,{CanvasPosition=Vector2.new(0,math.max(0,b5))},0.35,Enum.EasingStyle.Quint)end function a2:_closePopups()if self._closePopup then self._closePopup()end end function a2:_popoutLayer()if self._popLayer then return self._popLayer end local bZ=ai('Frame',{Name='PopOuts',Size=UDim2.fromScale(1,1),BackgroundTransparency=1,ZIndex=20,Parent=self.Gui})local b_=ai('UIScale',{Parent=bZ})self._popLayer=bZ self._popPanels={}self:_listen('Render',function()local b0=math.max(self.Scale.Scale,0.05)if math.abs(b_.Scale-b0)>1e-4 then b_.Scale=b0 bZ.Size=UDim2.fromScale(1/b0,1/b0)end bZ.Visible=self.Open==true and not self._destroyed end)return bZ end function a2:_popupHost(bZ)local b_=self._popLayer if b_ and bZ and bZ:IsDescendantOf(b_)then return b_ end return self.Body end function a2:_overPopout(bZ)local b_=self._popLayer if not b_ or not b_.Visible then return false end for b0,b1 in ipairs(self._popPanels)do if b1.Parent and b1.Visible and az(bZ,b1)then return true end end return false end function a2:_fade(bZ,b_)local b0,b1=self._fader,self.Body self._fadeGeneration=(self._fadeGeneration or 0)+1 local b2=self._fadeGeneration if b1.Parent~=b0 then b0.GroupTransparency=self._bodyAlpha b1.Parent=b0 end b0.Visible=true self._bodyAlpha=bZ ah(b0,{GroupTransparency=bZ},b_)task.delay(b_+0.03,function()if self._fadeGeneration==b2 and bZ<=0 and not self._destroyed then b1.Parent=self.Root b0.Visible=false end end)end function a2:SelectTab(bZ)if self.CurrentTab==bZ then return end local b_=self.CurrentTab self:_resetSearch()self:_closePopups()self.CurrentTab=bZ self:_settleTransition()local b0=(self._transitionGeneration or 0)+1 self._transitionGeneration=b0 if b_ then ah(b_._label,{TextColor3=z.Muted},0.3)if b_._icon then ar(b_._icon,z.Muted,false,0.3)end local b1=self._outLayer b_._page.Parent=b1 self._outPage=b_._page b1.GroupTransparency=0 b1.Position=UDim2.fromOffset(0,0)b1.Visible=true ah(b1,{GroupTransparency=1,Position=UDim2.fromOffset(0,-6)},0.2,Enum.EasingStyle.Quint)task.delay(0.18,function()if self._transitionGeneration==b0 then self:_settleOut()end end)end ah(bZ._button,{BackgroundTransparency=1},0.2)ah(bZ._stroke,{Transparency=1},0.2)ah(bZ._label,{TextColor3=z.Text},0.3)if bZ._icon then ar(bZ._icon,z.Text,true,0.3)end self:_placeIndicator(bZ)self:_scrollTabIntoView(bZ)local b1=bZ._page b1.Position=UDim2.fromOffset(0,0)b1.Visible=true b1.Parent=self._inLayer self._inPage=b1 bz(self._inLayer)task.delay(0.32,function()if self._transitionGeneration==b0 then self:_settleIn()end end)end function a2:_settleOut()local bZ=self._outPage if bZ then bZ.Parent=self.Content bZ.Visible=false self._outPage=nil end self._outLayer.Visible=false end function a2:_settleIn()local bZ=self._inPage if bZ then bZ.Parent=self.Content bZ.Position=UDim2.fromOffset(0,0)self._inPage=nil end self._inLayer.Visible=false end function a2:_settleTransition()self:_settleOut()self:_settleIn()end local bZ={Rain={Image='rbxassetid://241868005',Count=90,Stretch=true},Snow={Image='rbxassetid://99851851',Count=60},Ember={Image='rbxassetid://242205518',Count=55},Sakura={Petal=true,Count=46,Glow=Color3.fromRGB(255,150,190),GlowAmount=0.1},Fireflies={Image=A.Glow,Count=34,Glow=Color3.fromRGB(70,150,60),GlowAmount=0.16},Matrix={Text=true,Count=38,Glow=Color3.fromRGB(30,200,90),GlowAmount=0.07,Glyphs='01234567890123456789\u{30a2}\u{30a4}\u{30a6}\u{30a8}\u{30aa}\u{30ab}\u{30ad}\u{30af}\u{30b1}\u{30b3}\u{30b5}\u{30b7}\u{30b9}\u{30bb}\u{30bd}\u{30bf}\u{30c1}\u{30c4}\u{30c6}\u{30c8}\u{30ca}\u{30cb}\u{30cc}\u{30cd}\u{30ce}\u{30cf}\u{30d2}\u{30d5}\u{30d8}\u{30db}\u{30de}\u{30df}\u{30e0}\u{30e1}\u{30e2}\u{30e4}\u{30e6}\u{30e8}\u{30e9}\u{30ea}\u{30eb}\u{30ec}\u{30ed}\u{30ef}\u{30f3}+-*=<>:'}}local b_={rain='Rain',snow='Snow',ember='Ember',embers='Ember',fire='Ember',hellfire='Ember',sakura='Sakura',petals='Sakura',cherryblossom='Sakura',firefly='Fireflies',fireflies='Fireflies',matrix='Matrix',matrixrain='Matrix',code='Matrix'}local b0=Vector2.new(7/420,151/263)local b1=Random.new()local function b2(b3)if type(b3)=='string'and({ui=true,window=true,inside=true})[b3:lower()]then return'UI'end return'Screen'end local function b3(b5)return'Sakura'end local function b5(b6,b7)return b1:NextNumber(b6,b7)end local function b6(b7,b8,b9,ca,cb)b8.Time=b5(0,10)b8.Phase=b5(0,math.pi*2)if b7=='Rain'then local cc=b5(2,3.5)b8.Size=Vector2.new(cc,b5(26,52))b8.VY=b5(950,1400)b8.VX=b8.VY*0.12 b8.Sway,b8.Spin=0,0 b8.Rotation=-math.deg(math.atan2(b8.VX,b8.VY))b8.Alpha=b5(0,0.35)b8.X=b5(-0.15*b9,b9)b8.Y=cb and b5(-40,ca)or b5(-120,-b8.Size.Y)elseif b7=='Snow'then local cc=b5(6,17)b8.Size=Vector2.new(cc,cc)b8.VY=b5(30,55)*(0.6+cc/17)b8.VX=b5(-8,14)b8.Sway=b5(12,38)b8.Frequency=b5(0.5,1.3)b8.Spin=b5(-60,60)b8.Rotation=b5(0,360)b8.Alpha=b5(0.05,0.45)b8.X=b5(0,b9)b8.Y=cb and b5(-20,ca)or b5(-60,-cc)elseif b7=='Sakura'then local cc=b5(7,14)b8.Size=Vector2.new(cc,cc*b5(0.55,0.75))b8.VY=b5(35,70)b8.VX=b5(18,45)b8.Sway=b5(14,34)b8.Frequency=b5(0.6,1.4)b8.Flutter=b5(1.2,2.6)b8.Spin=b5(-90,90)b8.Rotation=b5(0,360)b8.Alpha=b5(0.05,0.35)b8.Color=Color3.fromRGB(255,180,195):Lerp(Color3.fromRGB(235,95,140),b5(0,1))b8.X=b5(-0.25*b9,b9)b8.Y=cb and b5(-20,ca)or b5(-60,-cc)elseif b7=='Fireflies'then local cc=b5(14,28)b8.Size=Vector2.new(cc,cc)b8.VY=b5(-14,8)b8.VX=b5(-12,12)b8.Sway=b5(10,30)b8.SwayY=b5(8,22)b8.Frequency=b5(0.3,0.8)b8.Spin,b8.Rotation=0,0 b8.Alpha=b5(0,0.25)b8.Life=b5(5,11)b8.Age=cb and b5(0,b8.Life)or 0 b8.Pulse=b5(1.5,3.5)b8.Color=Color3.fromRGB(200,255,120):Lerp(Color3.fromRGB(255,230,120),b5(0,1))b8.X=b5(0,b9)b8.Y=b5(ca*0.15,ca)elseif b7=='Matrix'then local cc=bZ.Matrix if not cc.List then cc.List={}for cd,ce in utf8.codes(cc.Glyphs)do table.insert(cc.List,utf8.char(ce))end end local cd=cc.List local ce=math.floor(b5(12,19))local cf=math.floor(b5(8,20))b8.TextSize=ce b8.Size=Vector2.new(ce+6,ce*cf)b8.VY=b5(160,360)*(ce/15)b8.VX,b8.Sway,b8.Spin,b8.Rotation=0,0,0,0 b8.Alpha=b5(0,0.25)+(19-ce)*0.04 b8.X=math.floor(b5(0,b9)/18)*18+9 b8.Y=cb and b5(-b8.Size.Y/2,ca)or-b8.Size.Y/2-b5(0,240)b8.Chars={}for cg=1,cf do b8.Chars[cg]=cd[math.random(#cd)]end b8.Shuffle=b5(0.05,0.2)else local cc=b5(4,12)b8.Size=Vector2.new(cc,cc)b8.VY=-b5(60,170)b8.VX=b5(-12,12)b8.Sway=b5(8,28)b8.Frequency=b5(1,2.4)b8.Spin=b5(-140,140)b8.Rotation=b5(0,360)b8.Alpha=b5(0,0.3)b8.Color=Color3.fromRGB(255,70,20):Lerp(Color3.fromRGB(255,190,70),b5(0,1))b8.X=b5(0,b9)b8.Y=cb and b5(ca*0.2,ca+10)or ca+b5(10,80)end local cc=b8.Label if b7=='Rain'then cc.Size=UDim2.fromOffset(b8.Size.X/b0.X,b8.Size.Y/b0.Y)else cc.Size=UDim2.fromOffset(b8.Size.X,b8.Size.Y)end if b7=='Matrix'then cc.TextSize=b8.TextSize cc.Text=table.concat(b8.Chars,'\n')elseif b7=='Sakura'then cc.BackgroundColor3=b8.Color else cc.ImageColor3=b8.Color or(b7=='Rain'and Color3.fromRGB(190,210,245)or Color3.new(1,1,1))end end function a2:_buildBackdrop(b7)local b8=ai('Frame',{Name='Backdrop',Size=UDim2.fromScale(1,1),BackgroundTransparency=1,Visible=false,ZIndex=0,Parent=self.Gui})local b9=ai('Frame',{Size=UDim2.fromScale(1,1),BackgroundColor3=Color3.new(0,0,0),BackgroundTransparency=1,BorderSizePixel=0,ZIndex=0,Parent=b8})ai('UIGradient',{Rotation=90,Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0),NumberSequenceKeypoint.new(0.5,0.3),NumberSequenceKeypoint.new(1,0)}),Parent=b9})local ca=ai('Frame',{AnchorPoint=Vector2.new(0,1),Position=UDim2.fromScale(0,1),Size=UDim2.fromScale(1,0.5),BackgroundColor3=Color3.fromRGB(255,60,15),BackgroundTransparency=1,BorderSizePixel=0,ZIndex=1,Parent=b8})ai('UIGradient',{Rotation=90,Transparency=NumberSequence.new(1,0),Parent=ca})local cb=ai('Frame',{Size=UDim2.fromScale(1,1),BackgroundTransparency=1,ClipsDescendants=true,ZIndex=2,Parent=b8})ca.Parent=cb self._backdrop=b8 self._backdropTintFrame=b9 self._backdropHeat=ca self._weatherField=cb self._weatherParticles={}self._backdropFade=0 self._weatherKick=0 self._backdropShown=false self._backdropEnabled=b7.Enabled~=false self._backdropTint=math.clamp(tonumber(b7.Tint)or 0.45,0,1)self._backdropDim=b7.Dim~=false self._dimLevel=self._backdropDim and 1 or 0 self._weatherDensity=math.clamp(tonumber(b7.Density)or 1,0,3)self._weatherSpeed=math.clamp(tonumber(b7.Speed)or 1,0.1,3)self.Weather=b3(b7.Weather==nil and'Sakura'or b7.Weather)self.WeatherMode='Screen'self:SetWeatherMode(b7.Mode)self:_rebuildWeather()table.insert(self._frameSteps,function(cc)self:_stepBackdrop(cc)end)end function a2:_weatherSize()if self.WeatherMode=='UI'then return Vector2.new(self.Root.Size.X.Offset,self.Root.Size.Y.Offset)end return self.Gui.AbsoluteSize end function a2:_rebuildWeather()for b7,b8 in ipairs(self._weatherParticles)do b8.Label:Destroy()end self._weatherParticles={}local b7=bZ[self.Weather]if not b7 then return end self._backdropHeat.BackgroundColor3=b7.Glow or Color3.fromRGB(255,60,15)local b8=self:_weatherSize()local b9=b7.Count*self._weatherDensity*(self.WeatherMode=='UI'and 0.45 or 1)for ca=1,math.floor(b9+0.5)do local cb,cc if b7.Text then cc='TextTransparency'cb=ai('TextLabel',{AnchorPoint=Vector2.new(0.5,0.5),BackgroundTransparency=1,Text='',TextColor3=Color3.fromRGB(90,255,140),TextTransparency=1,FontFace=Font.fromEnum(Enum.Font.Code),TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Top,LineHeight=1,ZIndex=2,Parent=self._weatherField})ai('UIGradient',{Rotation=90,Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.new(1,1,1)),ColorSequenceKeypoint.new(0.88,Color3.new(1,1,1)),ColorSequenceKeypoint.new(1,Color3.fromRGB(235,255,240))}),Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(0.6,0.45),NumberSequenceKeypoint.new(1,0)}),Parent=cb})elseif b7.Petal then cc='BackgroundTransparency'cb=ai('Frame',{AnchorPoint=Vector2.new(0.5,0.5),BackgroundColor3=Color3.fromRGB(255,145,180),BackgroundTransparency=1,BorderSizePixel=0,ZIndex=2,Parent=self._weatherField})aj(cb,UDim.new(1,0))ai('UIGradient',{Rotation=35,Color=ColorSequence.new(Color3.new(1,1,1),Color3.fromRGB(225,105,145)),Parent=cb})else cc='ImageTransparency'cb=ai('ImageLabel',{AnchorPoint=Vector2.new(0.5,0.5),BackgroundTransparency=1,Image=b7.Image,ImageTransparency=1,ScaleType=b7.Stretch and Enum.ScaleType.Stretch or Enum.ScaleType.Fit,ZIndex=2,Parent=self._weatherField})end local cd={Label=cb,Property=cc}b6(self.Weather,cd,b8.X,b8.Y,true)table.insert(self._weatherParticles,cd)end end function a2:_stepBackdrop(b7)local b8=self._backdropShown and 1 or 0 local b9=self._backdropFade if b9==b8 and b8==0 then return end if b9<b8 then b9=math.min(b9+b7/0.45,b8)elseif b9>b8 then b9=math.max(b9-b7/0.25,b8)end self._backdropFade=b9 if b9<=0 then self._backdrop.Visible=false self._weatherField.Visible=false return end local ca=1-(1-b9)^3 local cb=self.Weather local cc=self._dimLevel if self._backdropDim then cc=math.min(cc+b7/0.3,1)else cc=math.max(cc-b7/0.3,0)end self._dimLevel=cc self._backdropTintFrame.BackgroundTransparency=1-self._backdropTint*ca*cc local cd=bZ[cb]self._backdropHeat.BackgroundTransparency=cb=='Ember'and 1-(0.22+math.sin(os.clock()*2.1)*0.05)*ca or cd and cd.GlowAmount and 1-(cd.GlowAmount+math.sin(os.clock()*0.8)*cd.GlowAmount*0.25)*ca or 1 local ce=self._weatherKick self._weatherKick=math.max(ce-b7*1.3,0)local cf=self._weatherSpeed*(1+ce*ce*2.5)local cg=self:_weatherSize()local ch,ci=cg.X,cg.Y for cj,ck in ipairs(self._weatherParticles)do ck.Time+=b7 ck.X+=ck.VX*b7*cf ck.Y+=ck.VY*b7*cf ck.Rotation+=ck.Spin*b7*cf local cl=math.max(ck.Size.X,ck.Size.Y)if ck.Life then ck.Age+=b7 end if(ck.Life and ck.Age>ck.Life)or(not ck.Life and((ck.VY>0 and ck.Y>ci+cl)or(ck.VY<0 and ck.Y<-cl)))then b6(cb,ck,ch,ci,false)elseif ck.X>ch+cl*4 then ck.X-=ch+cl*6 elseif ck.X<-cl*4 then ck.X+=ch+cl*6 end local cm=ck.X local cn=1-ck.Alpha if ck.Sway~=0 then cm+=math.sin(ck.Time*ck.Frequency+ck.Phase)*ck.Sway end local co=ck.Y local cp=ck.Label if cb=='Ember'then cn*=math.clamp(ck.Y/(ci*0.85),0,1)^0.6 cn*=0.75+math.sin(ck.Time*9+ck.Phase)*0.25 elseif cb=='Sakura'then local cq=math.abs(math.cos(ck.Time*ck.Flutter+ck.Phase))cp.Size=UDim2.fromOffset(ck.Size.X*(0.3+cq*0.7),ck.Size.Y)elseif cb=='Fireflies'then co+=math.cos(ck.Time*ck.Frequency*1.3+ck.Phase)*ck.SwayY local cq,cr=ck.Age,ck.Life cn*=math.clamp(math.min(cq/1.2,(cr-cq)/1.2),0,1)cn*=0.5+math.sin(ck.Time*ck.Pulse+ck.Phase)*0.5 elseif cb=='Matrix'then ck.Shuffle-=b7*cf if ck.Shuffle<=0 then ck.Shuffle=b5(0.05,0.2)local cq=bZ.Matrix.List local cr=ck.Chars cr[math.random(#cr)]=cq[math.random(#cq)]cr[#cr]=cq[math.random(#cq)]cp.Text=table.concat(cr,'\n')end end cp.Position=UDim2.fromOffset(cm,co)cp.Rotation=ck.Rotation cp[ck.Property or'ImageTransparency']=1-cn*ca end end function a2:_refreshBackdrop(b7)if not self._backdrop then return end local b8=self._backdropEnabled and self._introDone and self.Open and not self.Minimized and not self._destroyed if b8 and not self._backdropShown then self._backdrop.Visible=true self._weatherField.Visible=true if self._backdropFade<=0 then local b9=self:_weatherSize()for ca,cb in ipairs(self._weatherParticles)do b6(self.Weather,cb,b9.X,b9.Y,true)end end if b7 then self._weatherKick=1 end end self._backdropShown=b8==true end function a2:SetBackdrop(b7)if not self._backdrop then return end self._backdropEnabled=b7~=false self:_refreshBackdrop(true)end function a2:SetBackdropTint(b7)if not self._backdrop then return end self._backdropTint=math.clamp(tonumber(b7)or 0.45,0,1)end function a2:SetDim(b7)if not self._backdrop then return end self._backdropDim=b7~=false end function a2:SetWeatherMode(b7)if not self._backdrop then return end b7=b2(b7)local b8=self._weatherField if b7=='UI'then b8.ZIndex=0 b8.Parent=self.Body else b8.ZIndex=2 b8.Parent=self._backdrop end if b7==self.WeatherMode then return end self.WeatherMode=b7 self:_rebuildWeather()if self._backdropShown then self._weatherKick=1 end end function a2:SetWeather(b7)if not self._backdrop then return end local b8=b3(b7)if b8==self.Weather then return end self.Weather=b8 self:_rebuildWeather()if self._backdropShown then self._weatherKick=1 end end function a2:SetWeatherDensity(b7)if not self._backdrop then return end self._weatherDensity=math.clamp(tonumber(b7)or 1,0,3)self:_rebuildWeather()end function a2:SetWeatherSpeed(b7)if not self._backdrop then return end self._weatherSpeed=math.clamp(tonumber(b7)or 1,0.1,3)end local b7={Top=8,Width=E and 176 or 168,Height=E and 36 or 32,Wide=340,Radius=34,Bars=4,Pinned=6}local function b8(b9,ca,cb,cc)if b9._ghost then b9._ghost:Destroy()end local cd=ai('Frame',{Position=UDim2.fromOffset(ca.X,ca.Y),Size=UDim2.fromOffset(cb.X,cb.Y),BackgroundColor3=z.Background,BackgroundTransparency=1,BorderSizePixel=0,ZIndex=29,Parent=b9.Gui})local ce=k._fixedCorner(cd,UDim.new(0,cc))local cf=ak(cd,z.Stroke,1)b9._ghost=cd return cd,cf,ce end local function b9(ca,cb,cc,cd,ce,cf)ah(ca,{Position=UDim2.fromOffset(cc.X,cc.Y),Size=UDim2.fromOffset(cd.X,cd.Y)},cf,Enum.EasingStyle.Quint)ah(cb,{CornerRadius=UDim.new(0,ce)},cf,Enum.EasingStyle.Quint)end local function ca(cb,cc,cd,ce)ah(cc,{BackgroundTransparency=1},ce,Enum.EasingStyle.Quad)ah(cd,{Transparency=1},ce,Enum.EasingStyle.Quad)task.delay(ce+0.02,function()if cb._ghost==cc then cb._ghost=nil end cc:Destroy()end)end function a2:_buildMiniBar()if self.MiniBar then return self.MiniBar end local cb=self.Gui local cc=ai('CanvasGroup',{Name='Island',AnchorPoint=Vector2.new(0.5,0),Position=UDim2.new(0.5,0,0,b7.Top),Size=UDim2.fromOffset(b7.Width,b7.Height),BackgroundColor3=Color3.new(0,0,0),BorderSizePixel=0,GroupTransparency=1,Visible=false,ZIndex=30,Parent=cb})local cd=k._fixedCorner(cc,UDim.new(0,b7.Height/2))local ce=ai('UIScale',{Parent=cc})self._miniScale=ce local cf=ai('NumberValue',{Value=1})local cg self._miniOrb=cc local function ch(ci)return ai('CanvasGroup',{Name=ci,AnchorPoint=Vector2.new(0.5,0),Position=UDim2.fromScale(0.5,0),Size=UDim2.new(0,b7.Wide,0,400),BackgroundTransparency=1,GroupTransparency=1,Parent=cc})end local ci=ai('CanvasGroup',{Name='Compact',Size=UDim2.fromScale(1,1),BackgroundColor3=Color3.fromRGB(30,30,34),BorderSizePixel=0,Parent=cc})ai('UIGradient',{Rotation=90,Color=ColorSequence.new(Color3.fromRGB(255,255,255),Color3.fromRGB(120,120,120)),Parent=ci})local cj=ai('Frame',{AnchorPoint=Vector2.new(0,0.5),Position=UDim2.new(0,5,0.5,0),Size=UDim2.fromOffset(b7.Height-10,b7.Height-10),BackgroundColor3=z.Accent,BackgroundTransparency=0.82,BorderSizePixel=0,Parent=ci})aj(cj,UDim.new(1,0))local ck=ai('ImageLabel',{AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.fromScale(0.5,0.5),Size=UDim2.fromOffset(16,16),BackgroundTransparency=1,ImageColor3=z.Accent,ScaleType=Enum.ScaleType.Fit,Parent=cj})aq(ck,self._logoIcon,true)local cl=am({AnchorPoint=Vector2.new(0,0.5),Position=UDim2.new(0,b7.Height+2,0.5,0),Size=UDim2.new(1,-b7.Height-2-72,0,18),Text=self.Title,TextSize=13,FontFace=D.Bold,TextColor3=Color3.fromRGB(244,244,246),Parent=ci})local cm=ai('Frame',{AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-14,0.5,0),Size=UDim2.fromOffset(0,18),AutomaticSize=Enum.AutomaticSize.X,BackgroundTransparency=1,Parent=ci})ai('UIListLayout',{FillDirection=Enum.FillDirection.Horizontal,HorizontalAlignment=Enum.HorizontalAlignment.Right,VerticalAlignment=Enum.VerticalAlignment.Center,SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,7),Parent=cm})local cn=ai('Frame',{Size=UDim2.fromOffset(b7.Bars*3+(b7.Bars-1)*2,16),BackgroundTransparency=1,Visible=false,LayoutOrder=1,Parent=cm})local co={}for cp=1,b7.Bars do local cq=ai('Frame',{AnchorPoint=Vector2.new(0,0.5),Position=UDim2.new(0,(cp-1)*5,0.5,0),Size=UDim2.fromOffset(3,3),BackgroundColor3=z.Muted,BorderSizePixel=0,Parent=cn})aj(cq,UDim.new(1,0))co[cp]=cq end local cp=am({Size=UDim2.fromOffset(0,18),AutomaticSize=Enum.AutomaticSize.X,Text='',TextSize=13,FontFace=D.Bold,TextTruncate=Enum.TextTruncate.None,Visible=false,LayoutOrder=2,Parent=cm})local cq=ai('Frame',{Size=UDim2.fromOffset(6,6),BackgroundColor3=z.Accent,BorderSizePixel=0,LayoutOrder=-1,Parent=cm})aj(cq,UDim.new(1,0))local cr=am({Size=UDim2.fromOffset(0,18),AutomaticSize=Enum.AutomaticSize.X,Text='0s',TextSize=12,FontFace=D.Bold,TextColor3=Color3.fromRGB(220,220,224),TextTruncate=Enum.TextTruncate.None,LayoutOrder=0,Parent=cm})local cs=ch('Expanded')local ct=ai('Frame',{Position=UDim2.fromOffset(16,14),Size=UDim2.new(1,-32,0,0),AutomaticSize=Enum.AutomaticSize.Y,BackgroundTransparency=1,Parent=cs})ai('UIListLayout',{SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,8),Parent=ct})local cu=ai('Frame',{Size=UDim2.new(1,0,0,48),BackgroundTransparency=1,LayoutOrder=1,Parent=ct})local cv=ai('ImageLabel',{Size=UDim2.fromOffset(48,48),BackgroundColor3=Color3.fromRGB(38,38,41),BorderSizePixel=0,Image='rbxthumb://type=AvatarHeadShot&id='..tostring(j.UserId)..'&w=150&h=150',Parent=cu})aj(cv,UDim.new(0,12))local cw=ai('ImageLabel',{AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.fromScale(0.5,0.5),Size=UDim2.fromOffset(20,20),BackgroundTransparency=1,ImageColor3=z.Muted,ImageTransparency=1,ScaleType=Enum.ScaleType.Fit,Parent=cv})aq(cw,'user')self:_trackAvatar(cv,cw)local cx=am({Position=UDim2.fromOffset(60,5),Size=UDim2.new(1,-150,0,20),TextSize=15,FontFace=D.Bold,TextColor3=Color3.fromRGB(244,244,246),Parent=cu})self:_trackName(cx,'Display')local cy=am({Position=UDim2.fromOffset(60,26),Size=UDim2.new(1,-150,0,15),Text='',TextSize=12,FontFace=D.Regular,TextColor3=z.Muted,Parent=cu})task.spawn(function()cy.Text=aZ()end)local cz=am({AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,0,0,3),Size=UDim2.fromOffset(90,24),Text='0s',TextSize=20,FontFace=D.Bold,TextColor3=Color3.fromRGB(244,244,246),TextXAlignment=Enum.TextXAlignment.Right,Parent=cu})am({AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,0,0,27),Size=UDim2.fromOffset(90,14),Text='session',TextSize=11,FontFace=D.Regular,TextColor3=z.Muted,TextXAlignment=Enum.TextXAlignment.Right,Parent=cu})local cA=ai('Frame',{Size=UDim2.new(1,0,0,42),BackgroundTransparency=1,LayoutOrder=2,Parent=ct})local function cB(cC,cD)local cE=ai('Frame',{Position=cC,Size=UDim2.new(0.5,-10,1,0),BackgroundTransparency=1,Parent=cA})local cF=am({Size=UDim2.new(1,-70,0,24),Text='',TextSize=20,FontFace=D.Bold,TextColor3=Color3.fromRGB(244,244,246),RichText=true,Parent=cE})am({AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,0,0,6),Size=UDim2.fromOffset(70,14),Text=cD,TextSize=10,TextColor3=z.Muted,TextXAlignment=Enum.TextXAlignment.Right,Parent=cE})local cG=ai('Frame',{AnchorPoint=Vector2.new(0,1),Position=UDim2.new(0,0,1,-4),Size=UDim2.new(1,0,0,3),BackgroundColor3=Color3.fromRGB(38,38,42),BorderSizePixel=0,Parent=cE})aj(cG,UDim.new(1,0))local cH=ai('Frame',{Size=UDim2.fromScale(0,1),BackgroundColor3=z.Success,BorderSizePixel=0,Parent=cG})aj(cH,UDim.new(1,0))return cH,cF end local cC,cD=cB(UDim2.fromScale(0,0),'FRAME RATE')local cE,cF=cB(UDim2.new(0.5,10,0,0),'PING')local cG=ai('Frame',{Size=UDim2.new(1,0,0,30),BackgroundTransparency=1,LayoutOrder=3,Parent=ct})ai('UIListLayout',{FillDirection=Enum.FillDirection.Horizontal,VerticalAlignment=Enum.VerticalAlignment.Center,SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,8),Parent=cG})local function cH(cI,cJ,cK)local cL=ai('Frame',{Size=UDim2.fromOffset(0,30),AutomaticSize=Enum.AutomaticSize.X,BackgroundColor3=Color3.fromRGB(32,32,35),BorderSizePixel=0,LayoutOrder=cI,Parent=cG})aj(cL,UDim.new(1,0))al(cL,14,14)ai('UIListLayout',{FillDirection=Enum.FillDirection.Horizontal,VerticalAlignment=Enum.VerticalAlignment.Center,SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,7),Parent=cL})am({Size=UDim2.new(0,0,1,0),AutomaticSize=Enum.AutomaticSize.X,Text=cJ,TextSize=12,FontFace=D.Regular,TextColor3=z.Muted,TextTruncate=Enum.TextTruncate.None,LayoutOrder=1,Parent=cL})return am({Size=UDim2.new(0,0,1,0),AutomaticSize=Enum.AutomaticSize.X,Text='',TextSize=12,FontFace=D.Bold,TextColor3=cK or Color3.fromRGB(244,244,246),TextTruncate=Enum.TextTruncate.None,LayoutOrder=2,Parent=cL})end local cI=cH(1,'Players')local cJ=cH(2,'Running',z.Accent)local cK=cH(3,'Tab')local cL=ai('Frame',{Size=UDim2.new(1,0,0,0),BackgroundTransparency=1,Visible=false,LayoutOrder=4,Parent=ct})ai('UIListLayout',{SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,2),Parent=cL})local cM=am({Size=UDim2.new(1,0,0,15),Text='',TextSize=12,FontFace=D.Regular,TextColor3=Color3.fromRGB(200,200,206),RichText=true,Visible=false,LayoutOrder=4,Parent=ct})local cN=am({Size=UDim2.new(1,0,0,14),TextSize=11,FontFace=D.Regular,TextColor3=z.Muted,LayoutOrder=5,Parent=ct})local cO=self._sessionStart or os.clock()local cP,cQ,cR=0,os.clock(),60 self:_listen('Render',function()cP+=1 local cS=os.clock()if cS-cQ>=0.5 then cR=math.floor(cP/(cS-cQ)+0.5)cP,cQ=0,cS end end)local function cS()cz.Text=bA(os.clock()-cO)cr.Text=cz.Text ah(cq,{BackgroundColor3=k._healthColor(cR,50,30)},0.4)local cT='<font size="12" color="#8A8A93"> %s</font>'cD.Text=cR..string.format(cT,'fps')ah(cC,{Size=UDim2.fromScale(math.clamp(cR/60,0.05,1),1),BackgroundColor3=k._healthColor(cR,50,30)},0.4,Enum.EasingStyle.Quint)local cU,cV=pcall(function()return math.floor(j:GetNetworkPing()*1000)end)cV=cU and cV or 0 cF.Text=cV..string.format(cT,'ms')ah(cE,{Size=UDim2.fromScale(math.clamp(1-(cV-40)/360,0.05,1),1),BackgroundColor3=k._healthColor(cV,90,180,true)},0.4,Enum.EasingStyle.Quint)cI.Text=#f:GetPlayers()..'/'..f.MaxPlayers local cW=self.CurrentTab cK.Text=cW and cW.Name or'-'end task.spawn(function()while cc.Parent do if cc.Visible and self.Minimized then cS()end task.wait(0.5)end end)local cT=ch('Activity')local cU=ai('Frame',{Position=UDim2.fromOffset(16,13),Size=UDim2.new(1,-32,0,0),AutomaticSize=Enum.AutomaticSize.Y,BackgroundTransparency=1,Parent=cT})local cV=ai('Frame',{Size=UDim2.fromOffset(34,34),BackgroundColor3=z.Accent,BackgroundTransparency=0.85,BorderSizePixel=0,Parent=cU})aj(cV,UDim.new(1,0))local cW=ai('ImageLabel',{AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.fromScale(0.5,0.5),Size=UDim2.fromOffset(17,17),BackgroundTransparency=1,ImageColor3=z.Accent,ScaleType=Enum.ScaleType.Fit,Parent=cV})local cX=ai('Frame',{Position=UDim2.fromOffset(46,0),Size=UDim2.new(1,-46,0,0),AutomaticSize=Enum.AutomaticSize.Y,BackgroundTransparency=1,Parent=cU})ai('UIListLayout',{SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,1),Parent=cX})local cY=am({Size=UDim2.new(1,0,0,18),TextSize=14,FontFace=D.Bold,LayoutOrder=1,Parent=cX})local cZ=am({Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,TextSize=12,FontFace=D.Regular,TextColor3=z.Muted,TextWrapped=true,TextTruncate=Enum.TextTruncate.None,TextYAlignment=Enum.TextYAlignment.Top,MaxVisibleGraphemes=140,LayoutOrder=2,Parent=cX})local c_=ai('TextButton',{Size=UDim2.fromScale(1,1),BackgroundTransparency=1,Text='',AutoButtonColor=false,ZIndex=10,Parent=cc})local c0={Compact=ci,Expanded=cs,Activity=cT}local c1='Compact'local c2=0 local c3,c4 local c5,c6=false,false local c7=0 local c8,c9,da,db=nil,nil,false,false local dc=0 local dd=false local function de(df)if df=='Expanded'then return Vector2.new(b7.Wide,math.floor(ct.AbsoluteSize.Y+28+0.5)),b7.Radius elseif df=='Activity'then return Vector2.new(b7.Wide,math.floor(math.max(cU.AbsoluteSize.Y,34)+26+0.5)),b7.Radius end return Vector2.new(b7.Width,b7.Height),b7.Height/2 end local df=self:_readConfigSettings().IslandPosition if type(df)=='table'and tonumber(df.X)and tonumber(df.Y)then self._islandAnchor=Vector2.new(math.clamp(tonumber(df.X),0,1),math.clamp(tonumber(df.Y),0,1))end local dg local function dh()local di=cb.AbsoluteSize local dj=self._islandAnchor if not dj then return Vector2.new(di.X/2,b7.Top)end return Vector2.new(dj.X*di.X,dj.Y*di.Y)end local function di(dj,dk)local dl=cb.AbsoluteSize local dm=dk or dh()local dn=6 local dp=math.clamp(dm.X,dj.X/2+dn,math.max(dl.X-dj.X/2-dn,dj.X/2+dn))local dq=math.clamp(dm.Y,dn,math.max(dl.Y-dj.Y-dn,dn))return Vector2.new(dp,dq)end local function dj(dk,dl,dm)local dn=di(dk)if dg then dg:Cancel()dg=nil end if dl and dl>0 then dg=ah(cc,{Position=UDim2.fromOffset(dn.X,dn.Y)},dl,dm or Enum.EasingStyle.Quint)else cc.Position=UDim2.fromOffset(dn.X,dn.Y)end end self._islandReset=function()self._islandAnchor=nil if cc.Visible then dj(Vector2.new(cc.Size.X.Offset,cc.Size.Y.Offset),0.35)end end local function dk(dl,dm)local dn,dp=de(dl)local dq=dl~=c1 c1=dl c2+=1 local dr=c2 local ds=Vector2.new(cc.Size.X.Offset,cc.Size.Y.Offset)local dt=dn.X>ds.X+1 or dn.Y>ds.Y+1 local du=dm and 0 or(dt and 0.5 or 0.38)if c3 then c3:Cancel()end if c4 then c4:Cancel()end dj(dn,du)c3=ah(cc,{Size=UDim2.fromOffset(dn.X,dn.Y)},du,dt and Enum.EasingStyle.Back or Enum.EasingStyle.Quint)c4=ah(cd,{CornerRadius=UDim.new(0,dp)},du,Enum.EasingStyle.Quint)if dq and not dm and not c6 and not da then ce.Scale=dt and 0.96 or 1.03 ah(ce,{Scale=1},dt and 0.55 or 0.4,Enum.EasingStyle.Back)end if dq or dm then if cg then cg:Cancel()cg=nil end if dm then cf.Value=dl=='Compact'and 1 or 0 elseif dl=='Compact'then task.delay(du*0.55,function()if c2==dr then cg=ah(cf,{Value=1},0.6,Enum.EasingStyle.Back)end end)else cg=ah(cf,{Value=0},0.2,Enum.EasingStyle.Quint)end end if not dq and not dm then local dv=c0[dl]if dv.GroupTransparency>0 then ah(dv,{GroupTransparency=0},0.22,Enum.EasingStyle.Quad)end if dv~=ci and dv.Position~=UDim2.fromScale(0.5,0)then ah(dv,{Position=UDim2.fromScale(0.5,0)},0.32,Enum.EasingStyle.Quint)end return end for dv,dw in pairs(c0)do if dv~=dl then ah(dw,{GroupTransparency=1},dm and 0 or 0.14,Enum.EasingStyle.Quad)end end local dv=c0[dl]if dm then dv.GroupTransparency=0 if dv~=ci then dv.Position=UDim2.fromScale(0.5,0)end else if dv~=ci then dv.Position=UDim2.new(0.5,0,0,6)end task.delay(0.1,function()if c2==dr then ah(dv,{GroupTransparency=0},0.22,Enum.EasingStyle.Quad)if dv~=ci then ah(dv,{Position=UDim2.fromScale(0.5,0)},0.32,Enum.EasingStyle.Quint)end end end)end end local function dl()if c5 and not E and not da then dk('Expanded')elseif dd then dk('Activity')elseif self.IslandStyle=='Always Show'and not da then self:_refreshMini()cS()dk('Expanded')else dk('Compact')end end self._islandSettle=function()if self.Minimized and cc.Visible and not da then dl()end end function self:_miniLand()c5,dd=false,false dc+=1 ce.Scale=1 dk('Compact',true)local dm=Vector2.new(b7.Width,b7.Height)local dn=di(dm)return Vector2.new(dn.X-dm.X/2,dn.Y),dm end c_.MouseEnter:Connect(function()if ax()or da then return end c5=true c7+=1 local dm=c7 if c1=='Expanded'then return end if not c6 then ah(ce,{Scale=1.04},0.18,Enum.EasingStyle.Quint)end task.delay(0.12,function()if c7==dm and c5 and self.Minimized and not da then self:_refreshMini()cS()dk('Expanded')end end)end)c_.MouseLeave:Connect(function()c5=false c7+=1 local dm=c7 if not c6 then ah(ce,{Scale=1},0.25,Enum.EasingStyle.Quint)end task.delay(c1=='Expanded'and 0.28 or 0.1,function()if c7==dm and not c5 and self.Minimized then dl()end end)end)c_.InputBegan:Connect(function(dm)if not aw(dm)then return end c6=true db=false ah(ce,{Scale=0.95},0.12,Enum.EasingStyle.Quad)if not self._islandLocked then c8=Vector2.new(dm.Position.X,dm.Position.Y)c9=di(Vector2.new(b7.Width,b7.Height))end end)self:_listen('Changed',function(dm)if not c8 or not aA(dm)or not self.Minimized then return end local dn=Vector2.new(dm.Position.X,dm.Position.Y)-c8 if not da then if dn.Magnitude<(E and 10 or 6)then return end da,db=true,true c5=false dk('Compact')ah(ce,{Scale=1.06},0.2,Enum.EasingStyle.Quint)end local dp=di(Vector2.new(b7.Width,b7.Height),c9+dn)local dq=cb.AbsoluteSize self._islandAnchor=Vector2.new(dp.X/math.max(dq.X,1),dp.Y/math.max(dq.Y,1))if dg then dg:Cancel()dg=nil end cc.Position=UDim2.fromOffset(dp.X,dp.Y)end)table.insert(self._connections,b.InputEnded:Connect(function(dm)if not aw(dm)then return end c8=nil if c6 then c6=false ah(ce,{Scale=1},0.35,Enum.EasingStyle.Back)end if da then da=false local dn=Vector2.new(cb.AbsoluteSize.X/2,b7.Top)local dp=di(Vector2.new(b7.Width,b7.Height))if(dp-dn).Magnitude<28 then self._islandAnchor=nil dj(Vector2.new(b7.Width,b7.Height),0.35,Enum.EasingStyle.Back)end local dq=self._islandAnchor self:_writeConfigSettings({IslandPosition=dq and{X=dq.X,Y=dq.Y}or false})c5=not ax()and az(av(),cc)task.delay(0.1,function()if self.Minimized and not da then dl()end end)end end))table.insert(self._connections,cb:GetPropertyChangedSignal('AbsoluteSize'):Connect(function()if cc.Visible and not da then dj(Vector2.new(cc.Size.X.Offset,cc.Size.Y.Offset),0)end end))c_.MouseButton1Click:Connect(function()if db then db=false return end if self.Minimized then self:Restore()end end)self._miniUnhover=function()c5,c6,dd=false,false,false c8,da=nil,false dc+=1 ce.Scale=1 task.delay(0.15,function()if not self.Minimized then dk('Compact',true)end end)end self._islandActivity=function(dm)if not self.Minimized or not cc.Visible then return end local dn=a1[dm.Type]or z.Accent cY.Text=tostring(dm.Title or'Notification')cY.TextColor3=a1[dm.Type]or z.Text cZ.Text=tostring(dm.Content or'')cZ.Visible=cZ.Text~=''local dp=dm.Icon if dp==nil then dp=({Success='circle-check',Warning='triangle-alert',Error='circle-x'})[dm.Type]or'bell'end aq(cW,dp)if not cW:GetAttribute('CustomIcon')then cW.ImageColor3=dn end cV.BackgroundColor3=dn dd=true dc+=1 local dq=dc task.defer(function()if dc==dq and not c5 and not da then dk('Activity')ce.Scale=0.96 ah(ce,{Scale=1},0.4,Enum.EasingStyle.Back)end end)task.delay(math.clamp(tonumber(dm.Duration)or 3,1.5,5),function()if dc==dq then dd=false if self.Minimized and not c5 then dl()end end end)end local dm=0 self:_listen('Render',function()if cc.Visible and dm>0 and c1=='Compact'then local dn=os.clock()for dp,dq in ipairs(co)do local dr=0.5+0.5*math.sin(dn*(6+dp*1.4)+dp*1.9)dq.Size=UDim2.fromOffset(3,math.floor(4+dr*11+0.5))end end end)local dn=am({AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-14,0.5,0),Size=UDim2.new(1,-52,0,18),TextSize=13,FontFace=D.Bold,TextXAlignment=Enum.TextXAlignment.Right,RichText=true,TextTransparency=1,Parent=ci})local dp=ai('TextButton',{Name='IslandBubble',AnchorPoint=Vector2.new(0.5,0.5),Size=UDim2.fromOffset(0,0),BackgroundColor3=Color3.fromRGB(26,26,30),BorderSizePixel=0,Text='',AutoButtonColor=false,Visible=false,ZIndex=30,Parent=cb})aj(dp,UDim.new(1,0))local dq=ai('NumberValue',{Value=0})local dr=false local ds=nil local function dt(du)if du==dr then return end dr=du cn.Parent=du and dp or cm cn.AnchorPoint=du and Vector2.new(0.5,0.5)or Vector2.new(0,0)cn.Position=du and UDim2.fromScale(0.5,0.5)or UDim2.new()cm.Visible=not du ah(dn,{TextTransparency=du and 0 or 1},0.2,Enum.EasingStyle.Quad)ah(dq,{Value=du and 1 or 0},du and 0.55 or 0.3,du and Enum.EasingStyle.Back or Enum.EasingStyle.Quint)if du then ce.Scale=0.96 ah(ce,{Scale=1},0.45,Enum.EasingStyle.Back)end end self:_listen('Render',function()local du=dq.Value*cf.Value local dv=cc.Visible and du>0.02 and cc.GroupTransparency<0.5 dp.Visible=dv if not dv then return end local dw=cb.AbsolutePosition local dx,dy=cc.AbsolutePosition-dw,cc.AbsoluteSize local dz=math.min(dy.Y,b7.Height)local dA=6 local dB=dx.X+dy.X+dA+dz<=cb.AbsoluteSize.X local dC=dB and dx.X+dy.X or dx.X local dD=dB and 1 or-1 local dE=dC-dD*dz*0.6 local dF=dC+dD*(dA+dz/2)local dG=dE+(dF-dE)*du local dH=math.clamp(0.35+0.65*du,0,1.2)local dI=math.sin(math.clamp(du,0,1)*math.pi)dp.Position=UDim2.fromOffset(dG,dx.Y+dz/2)dp.Size=UDim2.fromOffset(dz*dH*(1+0.4*dI),dz*dH*(1-0.18*dI))dp.BackgroundTransparency=cc.GroupTransparency end)dp.MouseButton1Click:Connect(function()if self.Minimized then self:Restore()end end)local du={}function self:_refreshMini()local dv=0 for dw,dx in pairs(k.Flags)do if dx._type=='Toggle'and dx.Value==true then dv+=1 end end if dv~=dm then local dw=dv>dm dm=dv cp.Text=tostring(dv)for dx,dy in ipairs(co)do ah(dy,{BackgroundColor3=dv>0 and z.Accent or z.Muted},0.25)if dv==0 then ah(dy,{Size=UDim2.fromOffset(3,3)},0.25)end end if dw and c1=='Compact'and cc.Visible then ce.Scale=1.06 ah(ce,{Scale=1},0.4,Enum.EasingStyle.Back)end end cJ.Text=tostring(dv)local dw={}for dx,dy in pairs(k.Flags)do if dy._type=='Toggle'and dy.Value==true and dy._searchName~=''then table.insert(dw,dy._searchName)end end table.sort(dw)local dx={}for dy=1,math.min(#dw,3)do dx[dy]=k._rich(dw[dy])end local dy=#dw-#dx cM.Text='<font color="#8A8A93">Running </font>'..table.concat(dx,'<font color="#8A8A93"> \u{b7} </font>')..(dy>0 and string.format('<font color="#8A8A93">  +%d</font>',dy)or'')cM.Visible=#dw>0 ds=nil for dz,dA in ipairs(self._pinned)do if not dA._isShown or dA:_isShown()then ds=dA break end end if ds then local dz=tostring(ds:Text()or'')if dz:gsub('<[^>]*>',''):match('%S')then dn.Text=dz local dA=ds._shownColor and ds._shownColor()or z.Text local dB,dC,dD=dA:ToHSV()dn.TextColor3=dD<0.35 and z.Text or dA else ds=nil end end dt(dm>0 and ds~=nil)local dz=dm>0 and not dr cq.Visible=not dz cr.Visible=not dz cp.Visible=dz cn.Visible=dm>0 cm.Visible=not dr cl.Visible=not dr local dA=typeof(self.Keybind)=='EnumItem'and aI(self.Keybind)cN.Text=E and'Tap to open'or(dA and('Click or press '..dA..' to open')or'Click to open')local dC={}for dD,dE in ipairs(self._pinned)do if(not dE._isShown or dE:_isShown())and#dC<b7.Pinned then table.insert(dC,dE)end end cL.Visible=false for dD=1,math.max(#dC,#du)do local dE=dC[dD]local dF=du[dD]if dE then if not dF then local dG=ai('Frame',{Size=UDim2.new(1,0,0,18),BackgroundTransparency=1,LayoutOrder=dD,Parent=cL})dF={Frame=dG,Key=am({Size=UDim2.new(0.5,-4,1,0),TextSize=12,FontFace=D.Regular,TextColor3=z.Muted,RichText=true,Parent=dG}),Value=am({AnchorPoint=Vector2.new(1,0),Position=UDim2.fromScale(1,0),Size=UDim2.new(0.5,-4,1,0),TextSize=12,TextXAlignment=Enum.TextXAlignment.Right,RichText=true,Parent=dG})}du[dD]=dF end dF.Frame.Visible=true dF.Key.Text=k._rich(dE.Name)dF.Value.Text=dE:Text()local dG=dE._shownColor and dE._shownColor()or z.Text if dF.Value.TextColor3~=dG then ah(dF.Value,{TextColor3=dG},0.2)end elseif dF then dF.Frame.Visible=false end end if c1=='Expanded'and(c5 or self.IslandStyle=='Always Show')then task.defer(function()if c1=='Expanded'and(c5 or self.IslandStyle=='Always Show')and self.Minimized then local dD=de('Expanded')if math.abs(dD.Y-cc.Size.Y.Offset)>1 then dk('Expanded')end end end)end end self.MiniBar=cc self.Island=cc return cc end function a2:Minimize()if self.Minimized or not self._introDone or not self.Open or self._destroyed then return end self.Minimized=true self._minimizeGeneration=(self._minimizeGeneration or 0)+1 local cb=self._minimizeGeneration self:_closePopups()self:_refreshToggleButton()self:_refreshBackdrop()local cc=self:_buildMiniBar()self:_refreshMini()local cd=self.Gui local ce=self.Root.AbsolutePosition-cd.AbsolutePosition local cf=self.Root.AbsoluteSize local cg=1 if self._ghost then ce=self._ghost.AbsolutePosition-cd.AbsolutePosition cf=self._ghost.AbsoluteSize cg=self._ghost.BackgroundTransparency end local ch,ci,cj=b8(self,ce,cf,k._radius(10))ch.BackgroundTransparency=cg ci.Transparency=cg ah(ch,{BackgroundTransparency=0},0.11,Enum.EasingStyle.Quad)ah(ci,{Transparency=0},0.11,Enum.EasingStyle.Quad)ah(self.Scale,{Scale=(self._fitScale or 1)*0.985},0.11,Enum.EasingStyle.Quad)ah(self.Shadow,{ImageTransparency=1},0.2)cc.Visible=true cc.GroupTransparency=1 task.delay(0.11,function()if self._minimizeGeneration~=cb or self._destroyed then return end self.Root.Visible=false self.Scale.Scale=self._fitScale or 1 local ck,cl=self:_miniLand(ce+cf/2)b9(ch,cj,ck,cl,math.floor(cl.Y/2),0.36)task.delay(0.3,function()if self._minimizeGeneration~=cb or self._destroyed then return end self._miniScale.Scale=0.9 ah(self._miniScale,{Scale=1},0.3,Enum.EasingStyle.Quint)ah(cc,{GroupTransparency=0},0.18,Enum.EasingStyle.Quad)ca(self,ch,ci,0.2)if self.IslandStyle=='Always Show'then task.delay(0.22,function()if self._minimizeGeneration==cb and self._islandSettle then self._islandSettle()end end)end end)end)task.spawn(function()while self.Minimized and self._minimizeGeneration==cb and not self._destroyed do self:_refreshMini()task.wait(0.5)end end)end function a2:Restore()if not self.Minimized or self._destroyed then return end self.Minimized=false self._minimizeGeneration=(self._minimizeGeneration or 0)+1 local cb=self._minimizeGeneration self:_refreshToggleButton()self:_refreshBackdrop(true)local cc=self.Gui local cd=self.MiniBar local ce=self._fitScale or 1 local cf=Vector2.new(self.Root.Size.X.Offset,self.Root.Size.Y.Offset)*ce local cg=self.Root.AbsolutePosition+self.Root.AbsoluteSize/2-cc.AbsolutePosition local ch=cg-cf/2 local ci,cj=ch,cf local ck=1 if self._ghost then ci=self._ghost.AbsolutePosition-cc.AbsolutePosition cj=self._ghost.AbsoluteSize ck=self._ghost.BackgroundTransparency elseif cd and cd.Visible then ci=self._miniOrb.AbsolutePosition-cc.AbsolutePosition cj=self._miniOrb.AbsoluteSize end if cd and cd.Visible then if self._miniUnhover then self._miniUnhover()end ah(cd,{GroupTransparency=1},0.12,Enum.EasingStyle.Quad)task.delay(0.12,function()if self._minimizeGeneration==cb then cd.Visible=false end end)end local cl,cm,cn=b8(self,ci,cj,math.floor(math.min(cj.X,cj.Y)/2))cl.BackgroundTransparency=ck cm.Transparency=ck ah(cl,{BackgroundTransparency=0},0.1,Enum.EasingStyle.Quad)ah(cm,{Transparency=0},0.1,Enum.EasingStyle.Quad)b9(cl,cn,ch,cf,k._radius(10),0.4)ah(self.Shadow,{ImageTransparency=self._shadowRest},0.45)task.delay(0.3,function()if self._minimizeGeneration~=cb or self._destroyed then return end self.Scale.Scale=ce self.BodyStroke.Transparency=0 self.Root.Visible=true end)task.delay(0.4,function()if self._ghost==cl and self._minimizeGeneration==cb then ca(self,cl,cm,0.22)end end)end function a2:SetIslandDraggable(cb)self._islandLocked=cb==false end function a2:ResetIslandPosition()self._islandAnchor=nil if self._islandReset then self._islandReset()end self:_writeConfigSettings({IslandPosition=false})end function a2:SetMinimized(cb)if cb then self:Minimize()else self:Restore()end end function a2:Toggle(cb)if not self._introDone then return end if self.Minimized then if cb~=false then self:Restore()end return end if cb==nil then cb=not self.Open end if cb==self.Open then return end self.Open=cb self:_refreshToggleButton()self:_refreshBackdrop(cb)self._minimizeGeneration=(self._minimizeGeneration or 0)+1 local cc=self._minimizeGeneration local cd=self.Gui local ce=self._fitScale or 1 local cf=Vector2.new(self.Root.Size.X.Offset,self.Root.Size.Y.Offset)*ce local cg=self.Root.AbsolutePosition+self.Root.AbsoluteSize/2-cd.AbsolutePosition local ch=cf*0.94 local ci,cj,ck if self._ghost then ci=self._ghost.AbsolutePosition-cd.AbsolutePosition cj=self._ghost.AbsoluteSize ck=self._ghost.BackgroundTransparency end if cb then local cl,cm,cn=b8(self,ci or cg-ch/2,cj or ch,k._radius(10))cl.BackgroundTransparency=ck or 1 cm.Transparency=ck or 1 ah(cl,{BackgroundTransparency=0},0.12,Enum.EasingStyle.Quad)ah(cm,{Transparency=0},0.12,Enum.EasingStyle.Quad)b9(cl,cn,cg-cf/2,cf,k._radius(10),0.3)ah(self.Shadow,{ImageTransparency=self._shadowRest},0.3)task.delay(0.2,function()if self._minimizeGeneration~=cc or self._destroyed then return end self.Scale.Scale=ce self.BodyStroke.Transparency=0 self.Root.Visible=true end)task.delay(0.3,function()if self._ghost==cl and self._minimizeGeneration==cc then ca(self,cl,cm,0.18)end end)else self:_closePopups()local cl=ci or self.Root.AbsolutePosition-cd.AbsolutePosition local cm=cj or self.Root.AbsoluteSize local cn,co,cp=b8(self,cl,cm,k._radius(10))cn.BackgroundTransparency=ck or 1 co.Transparency=ck or 1 ah(cn,{BackgroundTransparency=0},0.08,Enum.EasingStyle.Quad)ah(co,{Transparency=0},0.08,Enum.EasingStyle.Quad)ah(self.Shadow,{ImageTransparency=1},0.16)task.delay(0.08,function()if self._minimizeGeneration~=cc or self._destroyed then return end self.Root.Visible=false b9(cn,cp,cg-ch/2,ch,k._radius(10),0.2)ca(self,cn,co,0.16)end)end end function a2:SetKeepOnScreen(cb)self.KeepOnScreen=cb~=false if self.KeepOnScreen then self:_clampToScreen()end end function a2:SetKeybind(cb)self.Keybind=cb if self._keyChipLabel then self._keyChipLabel.Text=aI(cb)end end function a2:Notify(cb)cb=l(cb,{Text='Content',Message='Content',Image='Icon'})if self.Minimized and self._islandActivity then self._islandActivity(cb)end local cc=cb.Duration or 4 local cd=a1[cb.Type]or z.Text self._notifyOrder=self._notifyOrder+1 local ce=ai('Frame',{Size=UDim2.new(1,0,0,0),BackgroundTransparency=1,LayoutOrder=self._notifyOrder,Parent=self.NotifyHolder})local cf=ai('Frame',{Position=UDim2.fromOffset(320,0),Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,BackgroundTransparency=1,Parent=ce})local cg=ai('ImageLabel',{Position=UDim2.fromOffset(-20,-20),Size=UDim2.new(1,40,1,40),BackgroundTransparency=1,Image=A.Shadow,ImageColor3=Color3.new(0,0,0),ImageTransparency=1,ScaleType=Enum.ScaleType.Slice,SliceCenter=Rect.new(49,49,450,450),ZIndex=0,Parent=cf})local ch=ai('CanvasGroup',{Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,BackgroundColor3=z.Background,BorderSizePixel=0,GroupTransparency=1,Parent=cf})aj(ch,UDim.new(0,10))local ci=ak(ch,z.Stroke)ao(ch)an(ch,UDim2.fromOffset(260,120),UDim2.new(1,-10,0,-10),0.86,90)local cj=ai('Frame',{Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,BackgroundTransparency=1,Parent=ch})al(cj,16,16,14,24)local ck=0 if cb.Icon then aB(cj,cb.Icon,cd==z.Text and z.Accent or cd,UDim2.new(0,0,0,8))ck=24 end am({Position=UDim2.fromOffset(ck,0),Size=UDim2.new(1,-28-ck,0,16),Text=cb.Title or'Notification',TextSize=14,TextColor3=cd,Parent=cj})local cl=ai('TextButton',{AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,6,0,-5),Size=UDim2.fromOffset(24,24),BackgroundTransparency=1,Text='\u{d7}',TextColor3=z.Muted,TextSize=22,FontFace=D.Bold,AutoButtonColor=false,Parent=cj})cl.MouseEnter:Connect(function()ah(cl,{TextColor3=z.Text},0.15)end)cl.MouseLeave:Connect(function()ah(cl,{TextColor3=z.Muted},0.2)end)if cb.Content then am({Position=UDim2.fromOffset(ck,21),Size=UDim2.new(1,-ck,0,0),AutomaticSize=Enum.AutomaticSize.Y,Text=cb.Content,TextSize=13,FontFace=D.Regular,TextColor3=z.Muted,TextWrapped=true,TextTruncate=Enum.TextTruncate.None,TextYAlignment=Enum.TextYAlignment.Top,Parent=cj})end local cm=ai('Frame',{AnchorPoint=Vector2.new(0,1),Position=UDim2.new(0,16,1,-8),Size=UDim2.new(1,-32,0,3),BackgroundColor3=z.Surface3,BorderSizePixel=0,Parent=ch})aj(cm,UDim.new(1,0))local cn=ai('Frame',{Size=UDim2.fromScale(1,1),BackgroundColor3=z.Accent,BorderSizePixel=0,Parent=cm})aj(cn,UDim.new(1,0))task.defer(function()if ce.Parent then ah(ce,{Size=UDim2.new(1,0,0,ch.AbsoluteSize.Y)},0.3,Enum.EasingStyle.Quint)end end)ah(cf,{Position=UDim2.fromOffset(0,0)},0.5,Enum.EasingStyle.Back)ah(ch,{GroupTransparency=0},0.3)ah(cg,{ImageTransparency=0.6},0.4)ah(cn,{Size=UDim2.fromScale(0,1)},cc,Enum.EasingStyle.Linear)local co=false local function cp()if co then return end co=true for cq,cr in ipairs(self._toasts)do if cr==cp then table.remove(self._toasts,cq)break end end ah(cf,{Position=UDim2.fromOffset(320,0)},0.3,Enum.EasingStyle.Quint)ah(ch,{GroupTransparency=1},0.2)ah(ci,{Transparency=1},0.15)ah(cg,{ImageTransparency=1},0.2)task.delay(0.22,function()ce.ClipsDescendants=true ah(ce,{Size=UDim2.new(1,0,0,-4)},0.22,Enum.EasingStyle.Quint)task.delay(0.24,function()ce:Destroy()end)end)end task.delay(cc,cp)cl.MouseButton1Click:Connect(cp)table.insert(self._toasts,cp)while#self._toasts>self.MaxNotifications do local cq=table.remove(self._toasts,1)cq()end return{Dismiss=cp}end function a2:Destroy()if self._destroyed then return end self._destroyed=true for cb,cc in ipairs(k.Windows)do if cc==self then table.remove(k.Windows,cb)break end end for cb,cc in ipairs(self._connections)do pcall(function()cc:Disconnect()end)end self._connections={}self._inputListeners={Began={},Changed={},Ended={},Render={}}self._frameSteps={}local cb=self.Gui local cc=false local function cd()if cc then return end cc=true if not pcall(cb.Destroy,cb)then pcall(function()cb.Enabled=false end)end end local ce,cf=pcall(function()if self._dialog then self._dialog.Close()end self:_closePopups()local ce=self._fitScale or 1 ah(self.Scale,{Scale=ce*0.92},0.22,Enum.EasingStyle.Quint)self:_fade(1,0.2)ah(self.BodyStroke,{Transparency=1},0.12)ah(self.Shadow,{ImageTransparency=1},0.2)if self.MiniBar and self.MiniBar.Visible then ah(self.MiniBar,{GroupTransparency=1},0.18)end if self._backdrop then self._weatherField.Visible=false ah(self._backdropTintFrame,{BackgroundTransparency=1},0.2)ah(self._backdropHeat,{BackgroundTransparency=1},0.2)end for cf,cg in ipairs({self.ToggleButton,self.OpenButton})do if typeof(cg)=='Instance'and cg:IsA('GuiObject')then ah(cg,{Size=UDim2.fromOffset(0,0)},0.2,Enum.EasingStyle.Quint)end end end)if not ce then warn([[[AirFlow] unload animation failed, removing the window directly: ]]..tostring(cf))cd()return end task.delay(0.24,cd)end a2.Unload=a2.Destroy function k:Destroy()for cb=#k.Windows,1,-1 do local cc=k.Windows[cb]if cc then cc:Destroy()end end end k.Unload=k.Destroy local cb=getthreadidentity or getidentity or get_thread_identity or(syn and syn.get_thread_identity)local cc=setthreadidentity or setidentity or set_thread_identity or(syn and syn.set_thread_identity)local cd=nil if cb then local ce,cf=pcall(cb)if ce and type(cf)=='number'then cd=cf end end local function ce()local cf=k.Windows[#k.Windows]local cg=cf and cf.Gui if typeof(cg)~='Instance'then return false end return not pcall(function()return cg.Name end)end local cf={}d.Heartbeat:Connect(function()if#cf==0 then return end local cg=cf cf={}for ch,ci in ipairs(cg)do ci()end end)local function cg(ch,...)local ci=table.pack(...)local cj=nil table.insert(cf,function()cj=table.pack(pcall(ch,table.unpack(ci,1,ci.n)))end)while cj==nil do task.wait()end if not cj[1]then error(cj[2],0)end return table.unpack(cj,2,cj.n)end local ch=setmetatable({},{__mode='k'})local ci local function cj(ck)return function(...)if ce()then if cc then pcall(cc,cd or 8)end if ce()then return ci(cg(ck,...))end end return ci(ck(...))end end function ci(...)for ck=1,select('#',...)do local cl=select(ck,...)if type(cl)=='table'and not ch[cl]then local cm=getmetatable(cl)if cm~=a2 and cm~=aS then ch[cl]=true for cn,co in pairs(cl)do if type(cn)=='string'and type(co)=='function'and cn:sub(1,1)~='_'then cl[cn]=cj(co)elseif type(cn)=='number'and type(co)=='table'then ci(co)end end end end end return...end for ck,cl in ipairs({k,a2,aS})do for cm,cn in pairs(cl)do if type(cm)=='string'and type(cn)=='function'and cm:sub(1,1)~='_'then cl[cm]=cj(cn)end end end return k end)()return a
  end)()
  materialEnemies = utilBloxFruitModulePreloadDataLua.MaterialEnemies
  quests = utilBloxFruitModulePreloadDataLua.QUESTS
  bossList = utilBloxFruitModulePreloadDataLua.BossList
  itemsToBuy = utilBloxFruitModulePreloadDataLua.ItemsToBuy
  islands = utilBloxFruitModulePreloadDataLua.Islands

  v35 = {
    ["Black Leg"] = { Npc = "Dark Step Teacher", Remote = { "BuyBlackLeg" } },
    Electro = { Npc = "Mad Scientist", Remote = { "BuyElectro" } },
    ["Fishman Karate"] = { Npc = "Water Kung-fu Teacher", Remote = { "BuyFishmanKarate" } },
    ["Dragon Claw"] = {
      Npc = "Sabi",
      Remote = {
        { "BlackbeardReward", "DragonClaw", "1" }, { "BlackbeardReward", "DragonClaw", "2" },
      },
    },
    Superhuman = { Npc = "Martial Arts Master", Remote = { "BuySuperhuman" } },
    ["Death Step"] = { Npc = "Phoeyu, the Reformed", Remote = { "BuyDeathStep" } },
    ["Sharkman Karate"] = { Npc = "Sharkman Teacher", Remote = { "BuySharkmanKarate" } },
    ["Electric Claw"] = { Npc = "Previous Hero", Remote = { "BuyElectricClaw" } },
    ["Dragon Talon"] = { Npc = "Uzoth", Remote = { "BuyDragonTalon" } },
    Godhuman = { Npc = "Ancient Monk", Remote = { "BuyGodhuman" } },
    ["Sanguine Art"] = {
      Npc = "Shafi",
      Remote = { { "BuySanguineArt", true }, { "BuySanguineArt" } },
    },
  }

  swordData = utilBloxFruitModulePreloadDataLua.SwordData

  v16 = {
    CurrentDracoStage = 1,
    DracoSequence = utilBloxFruitModulePreloadDataLua.DracoSequence
      or { "Relic1", "EndRelic1", "Relic2", "EndRelic2", "Relic3", "EndRelic3" },
    SwordList = utilBloxFruitModulePreloadDataLua.SwordList or { "Shizu", "Saishi", "Oroshi" },
    ActiveSword = nil,
    JoinTime = os.time(),
    CamLockConn = nil,
    BlueMoonState = "FIND_ISLAND",
  }

  function v33:IsReady(p9)
    if not p9 or not p9.Parent or not p9:IsDescendantOf(v4) then
      return false
    elseif p9:FindFirstChild("Ignored") then
      return false
    elseif p9.Parent == boats or p9:GetAttribute("IsBoat") or p9.Name:find("Brigade")
      or p9.Name:find("Boat") or p9.Name:find("Ship") then
      local health = p9:FindFirstChild("Health")

      if health
        and (health:IsA("ValueBase") and health.Value <= 0
          or type(health.Value) == "number" and health.Value <= 0) then
        return false
      else
        local humanoid = p9:FindFirstChildOfClass("Humanoid") or p9:FindFirstChild("Humanoid")

        if humanoid
          and (humanoid:IsA("Humanoid") and humanoid.Health <= 0
            or humanoid:IsA("ValueBase") and humanoid.Value <= 0) then
          return false
        end

        if p9:GetAttribute("Dead") == true or p9:GetAttribute("Sunk") == true then
          return false
        else
          local engine = p9:FindFirstChild("Engine") or p9.PrimaryPart
            or p9:FindFirstChildWhichIsA("BasePart")

          if not engine or engine.Position.Y < -15 then
            return false
          end

          return true
        end
      end
    elseif p9.Parent == seaBeasts then
      local health2 = p9:FindFirstChild("Health")
      return health2 and health2.Value > 0
    else
      local humanoid2 = p9:FindFirstChildOfClass("Humanoid")
      local humanoidRootPart2 = p9:FindFirstChild("HumanoidRootPart") or p9.PrimaryPart

      if humanoid2 and humanoid2.Health > 0 and humanoidRootPart2 then
        return true
      end

      return false
    end
  end

  v17 = {
    StartTime = tick(),
    StartLevel = level and level.Value or 0,
    StartBeli = beli and beli.Value or 0,
    StartFragments = fragments and fragments.Value or 0,
    LastDataLogTick = 0,
    LastErrorTick = {},
    ErrorLogs = {},
    FarmsCompleted = 0,
    ChestsCollected = 0,
    MobsKilled = 0,
    BossesKilled = 0,
    LevelGained = 0,
    BeliGained = 0,
    FragmentsGained = 0,
    ActiveFarm = "None",
  }

  v36 = nil

  v36 = {
    CleanMemory = function() end,
    ClearDebris = function()
      pcall(function()
        local v61, v62 = v4:GetChildren()

        for key2, value2 in next, v61, v62 do
          if value2:IsA("Tool")
            and (not value2.Parent or not value2.Parent:FindFirstChildOfClass("Humanoid")) then
            value2:Destroy()
          elseif value2.Name == "Debris" or value2.Name == "Effect"
            or value2.Name == "Effects" then
            value2:ClearAllChildren()
          elseif value2:IsA("BasePart")
            and (value2.Name:find("Slash") or value2.Name:find("HitEffect")
              or value2.Name:find("Particle") or value2.Name:find("Explosion")) then
            value2:Destroy()
          end
        end

        if v4:FindFirstChild("Characters") then
          local v63, v64 = v4.Characters:GetChildren()

          for key3, value3 in next, v63, v64 do
            local humanoid3 = value3:FindFirstChildOfClass("Humanoid")

            if humanoid3 and humanoid3.Health <= 0 and value3 ~= localPlayer.Character then
              value3:Destroy()
            end
          end
        end
      end)
    end,
    ClearNew = function(p10)
      if p10 then
        table.clear(p10)
        return p10
      end

      return {}
    end,
    CreateDictionary = function(p11, p12)
      local v65 = {}
      local v66 = p12 ~= nil and p12 or true

      if p11 then
        for k = 1, #p11 do
          v65[p11[k]] = v66
        end
      end

      return v65
    end,
    CreateAutoCache = function(fn)
      local v67 = {}

      setmetatable(v67, {
        __index = function(object, key4)
          if key4 == nil then
            return nil
          else
            local v68 = fn(key4)
            rawset(object, key4, v68)
            return v68
          end
        end,
      })

      return v67
    end,
    FastMode = false,
    SetFastMode = function(p13, p14)
      local v69 = p13

      if type(v69) == "table" and v69 == v36 then
        v69 = p14
      end

      if v69 == nil then
        v69 = true
      end

      v36.FastMode = v69

      spawn(function()
        pcall(function()
          local playerGui = localPlayer and localPlayer:FindFirstChild("PlayerGui")
          local main = playerGui and playerGui:FindFirstChild("Main")
          local settingsMenu = main and main:FindFirstChild("SettingsMenu")
          local content = settingsMenu and settingsMenu:FindFirstChild("Content")
          local scrollingFrame = content and content:FindFirstChild("ScrollingFrame")
          local fastMode = scrollingFrame and scrollingFrame:FindFirstChild("FastMode")

          if fastMode then
            local firstButton = v69 and fastMode:FindFirstChild("FirstButton")
              or fastMode:FindFirstChild("SecondButton")

            if firstButton and firstButton:IsA("GuiButton") then
              if firesignal then
                firesignal(firstButton.Activated)
              end
            end
          end
        end)
      end)

      return v36.FastMode
    end,
  }

  clearNew = v36.ClearNew
  local createDictionary = v36.CreateDictionary
  local createAutoCache = v36.CreateAutoCache
  v37 = nil

  v38 = {
    {
      Text = "Stop Hop",
      Callback = function()
        if v37 and v37.StopHop then
          v37.StopHop()
        end
      end,
    },
  }

  v37 = {
    Phase = 1,
    PhaseStart = tick(),
    LastHop = tick(),
    LastRejoin = tick(),
    LastFruitRoll = 0,
    _IsHopping = false,
    _CancelHop = false,
    StopHop = function()
      v37._CancelHop = true
      v37._IsHopping = false

      if v22 then
        for key5 in pairs(v22) do
          v22[key5] = false
        end
      end

      for index, value4 in ipairs({}) do
        local v70 = value4

        if v19 then
          v19[v70] = false
        end

        if v33 and v33.Toggles and v33.Toggles[v70] and v33.Toggles[v70].Update then
          pcall(function() v33.Toggles[v70].Update(false) end)
        end
      end

      if v33 and v33.SendNotify then
        v33:SendNotify("AFK Farm", "AFK farm & server hop stopped.", 3)
      end
    end,
    ServerHop = function(p15, p16)
      v37._CancelHop = false

      spawn(function()
        v37._IsHopping = true
        local v71 = p15 or v19 and tonumber(v19.HopDelay) or 0

        if v71 > 0 then
          if v33 and v33.SendNotify then
            v33:SendNotify(
              "Server Hop", string.format("Hopping server in %d seconds...", math.floor(v71)),
              math.min(math.floor(v71), 5), v38
            )
          end

          local total = 0

          while total < v71 do
            if v37._CancelHop then
              v37._IsHopping = false
              return
            end

            task.wait(0.2)
            total = total + 0.2
          end
        end

        local v72

        if v37._CancelHop then
          v37._IsHopping = false
          return
        else
          local jobId = game.JobId
          v72 = false

          for m = 1, 100 do
            local v73 = m

            if v37._CancelHop then
              break
            end

            spawn(function()
              if v72 or v37._CancelHop then
                return
              else
                local v74, v75 = pcall(function() return v5.__ServerBrowser:InvokeServer(v73) end)

                if v74 and type(v75) == "table" then
                  for key6, value5 in pairs(v75) do
                    local v76 = key6

                    if not v72 and not v37._CancelHop and type(value5) == "table"
                      and value5.Count and value5.Count < 12 and v76 ~= game.JobId then
                      v72 = true

                      if v33 and v33.SendNotify then
                        v33:SendNotify(
                          "Hopping", "Server found! Teleporting...", 5, nil, "ServerHop"
                        )
                      end

                      pcall(function()
                        if not v37._CancelHop then
                          v5.__ServerBrowser:InvokeServer("teleport", v76)
                        end
                      end)
                    end
                  end
                end

                return
              end
            end)
          end

          v37._IsHopping = false
          return
        end
      end)
    end,
    Rejoin = function()
      if v33 and v33.SendNotify then
        v33:SendNotify("Rejoin", "Rejoining current server...", 3)
      end

      pcall(function() v5.__ServerBrowser:InvokeServer("teleport", game.JobId) end)
    end,
  }

  local stopHop = v37.StopHop
  v33.StopAfkFarm = v37.StopHop

  function f6(p17, p18)
    if v22[p17] then
      return
    else
      local v77 = os.clock()

      if p18 and v77 - (v21[p17] or 0) < p18 then
        return
      end

      pcall(function() v12:ClearError() end)

      v37._CancelHop = false
      v37._IsJoiningActive = true

      v22[p17] = true
      v21[p17] = v77

      spawn(function()
        local function f22()
          v22[p17] = false
          v37._IsJoiningActive = false
        end

        local v78, v79 = pcall(f9, {
          Url = "https://api.quantumonyx.cc" .. "/api/logs/" .. tostring(p17):lower(),
          Method = "GET",
          Headers = { ["Content-Type"] = "application/json" },
        })

        local cancelHop = not v78 or not v79 or v79.StatusCode ~= 200 or v37._CancelHop
        local v80

        if cancelHop then
          return f22()
        else
          local v81 = (v10:JSONDecode(v79.Body) or {})[tostring(p17):lower()]

          if not v81 or #v81 == 0 then
            f22()
            v37.ServerHop(0, true)
            return
          end

          v80 = nil

          for n = #v81, 1, -1 do
            local v82 = v81[n]
            local jobId2 = v82.jobId and f10(v82.jobId)

            if jobId2 and jobId2 ~= "" and jobId2 ~= game.JobId then
              if not v82.placeId or tostring(v82.placeId) == tostring(game.PlaceId) then
                v80 = jobId2
                break
              end
            end
          end

          if not v80 or v37._CancelHop then
            f22()
            v37.ServerHop(0, true)
            return
          end

          pcall(function() v5.__ServerBrowser:InvokeServer("teleport", v80) end)
          f22()
          return
        end
      end)

      return
    end
  end

  v33.JoinAPI = f6

  local function f23()
    local count2 = 0
    local v83 = false
    local v84 = false

    local v85 = {
      Sea_1 = {
        Inside = Vector3.new(61170.05, -2, 1952.83),
        Outside = Vector3.new(4050.31, -1.69, -1814.12),
      },
      Sea_2 = {
        Inside = Vector3.new(920.48, 154.9, 32838.96),
        Outside = Vector3.new(-6496.9, 89.04, -116.51),
      },
      Sea_3 = {
        Inside = Vector3.new(11426, -2155, 9732),
        Outside = Vector3.new(-16224, 9, 439),
      },
    }

    local v86 = {
      Sea1 = {
        {
          { Vector3.new(4050.31, -1.69, -1814.12), Vector3.new(61163.85, 11.68, 1819.78) },
          Req = "None",
        },
        {
          { Vector3.new(61170.05, -2, 1952.83), Vector3.new(3864.69, 6.74, -1926.21) },
          Req = "None",
        },
      },
      Sea2 = {
        {
          { Vector3.new(-6496.9, 89, -116.5), Vector3.new(923.2, 127, 32852.8) },
          Req = "GhostShip",
        },
        {
          { Vector3.new(920.5, 154.9, 32838.9), Vector3.new(-6508.6, 89, -132.8) },
          Req = "None",
        },
        {
          { Vector3.new(-287, 306.1, 592.9), Vector3.new(2284.9, 15.5, 902.5) },
          Req = "Flamingo",
        },
        { { Vector3.new(2284.9, 15.5, 910.5), Vector3.new(-287, 306.1, 600.9) }, Req = "None" },
        {
          { Vector3.new(2284.9, 15.5, 910.5), Vector3.new(-287, 306.1, 600.9) },
          { Vector3.new(-6496.9, 89, -116.5), Vector3.new(923.2, 127, 32852.8) },
          Req = "GhostShip",
        },
        {
          { Vector3.new(920.5, 154.9, 32838.9), Vector3.new(-6508.6, 89, -132.8) },
          { Vector3.new(-287, 306.1, 592.9), Vector3.new(2284.9, 15.5, 902.5) },
          Req = "Flamingo",
        },
      },
      Sea3 = {
        { { Vector3.new(-5060.4, 318.5, -3193.2), Vector3.new(-12463.6, 378.3, -7566.1) } },
        { { Vector3.new(-5027, 318.5, -3206.7), Vector3.new(5650.9, 1017.3, -350.4) } },
        { { Vector3.new(-5097.1, 318.5, -3178.4), Vector3.new(-16799.1, 84.3, 291.1) } },
        { { Vector3.new(-12463.6, 378.3, -7566.1), Vector3.new(-5060.4, 318.5, -3193.2) } },
        { { Vector3.new(5650.9, 1017.3, -350.4), Vector3.new(-5027, 318.5, -3206.7) } },
        { { Vector3.new(-16799.1, 84.3, 291.1), Vector3.new(-5097.1, 318.5, -3178.4) } },
        {
          { Vector3.new(-12463.6, 378.3, -7566.1), Vector3.new(-5060.4, 318.5, -3193.2) },
          { Vector3.new(-5027, 318.5, -3206.7), Vector3.new(5650.9, 1017.3, -350.4) },
        },
        {
          { Vector3.new(-12463.6, 378.3, -7566.1), Vector3.new(-5060.4, 318.5, -3193.2) },
          { Vector3.new(-5097.1, 318.5, -3178.4), Vector3.new(-16799.1, 84.3, 291.1) },
        },
        {
          { Vector3.new(5650.9, 1017.3, -350.4), Vector3.new(-5027, 318.5, -3206.7) },
          { Vector3.new(-5060.4, 318.5, -3193.2), Vector3.new(-12463.6, 378.3, -7566.1) },
        },
        {
          { Vector3.new(5650.9, 1017.3, -350.4), Vector3.new(-5027, 318.5, -3206.7) },
          { Vector3.new(-5097.1, 318.5, -3178.4), Vector3.new(-16799.1, 84.3, 291.1) },
        },
        {
          { Vector3.new(-16799.1, 84.3, 291.1), Vector3.new(-5097.1, 318.5, -3178.4) },
          { Vector3.new(-5060.4, 318.5, -3193.2), Vector3.new(-12463.6, 378.3, -7566.1) },
        },
        {
          { Vector3.new(-16799.1, 84.3, 291.1), Vector3.new(-5097.1, 318.5, -3178.4) },
          { Vector3.new(-5027, 318.5, -3206.7), Vector3.new(5650.9, 1017.3, -350.4) },
        },
      },
    }

    local v87 = 0

    local function f24(p19)
      if not p19 then
        return
      else
        character = p19
        local waitForChild4 = p19.WaitForChild
        waitForChild = p19:WaitForChild("Humanoid", 10)
        waitForChild2 = waitForChild4(p19, "HumanoidRootPart", 10)
        return
      end
    end

    localPlayer.CharacterAdded:Connect(f24)

    if localPlayer.Character then
      f24(localPlayer.Character)
    end

    local function f25()
      return waitForChild2 and waitForChild2.Parent and waitForChild and waitForChild.Parent
        and waitForChild.Health > 0
    end

    local function f26()
      if not localPlayer.Character then
        return
      end

      for index2, value6 in ipairs(localPlayer.Character:GetDescendants()) do
        if value6:IsA("BasePart") and value6.CanCollide then
          value6.CanCollide = false
        end
      end
    end

    local partVelocuty

    local function f27()
      if not waitForChild2 or waitForChild2:FindFirstChild("PartVelocuty") then
        return
      end

      if partVelocuty then
        pcall(function() partVelocuty:Destroy() end)
      end

      partVelocuty = Instance.new("BodyVelocity")
      partVelocuty.Name = "PartVelocuty"
      partVelocuty.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
      partVelocuty.Velocity = Vector3.zero
      partVelocuty.P = 1000
      partVelocuty.Parent = waitForChild2
    end

    local function f28(p20)
      local position = typeof(p20) == "Vector3" and p20 or p20 and p20.Position

      if not position then
        return { Name = "" }
      else
        local v88, v89 = v4._WorldOrigin.Locations:GetChildren()

        for key7, value7 in next, v88, v89 do
          local x = value7:FindFirstChild("Mesh") and value7.Mesh.Scale.X
            or value7:IsA("BasePart") and value7.Size.X or 0

          if x > 0 and (position - value7.Position).Magnitude <= x then
            return value7
          end
        end

        return { Name = "" }
      end
    end

    local function f29(p21)
      local position2 = typeof(p21) == "Vector3" and p21 or p21 and p21.Position

      if not position2 then
        return false
      else
        local lower = f28(position2).Name:lower()

        return lower:find("under") or lower:find("submerged") or lower:find("sealed cavern")
          or lower:find("dimension") or position2.X > 50000 or position2.Z > 25000
          or position2.Y < -500
      end
    end

    local function f30()
      if v24 then
        return v85.Sea_1
      elseif v25 then
        return v85.Sea_2
      elseif v26 then
        return v85.Sea_3
      else
        local value8 = localPlayer:FindFirstChild("Data")
            and localPlayer.Data:FindFirstChild("Level") and localPlayer.Data.Level.Value
          or 1

        return value8 >= 1500 and v85.Sea_3 or value8 >= 700 and v85.Sea_2 or v85.Sea_1
      end
    end

    local function f31(p22)
      if typeof(p22) == "Vector3" then
        return CFrame.new(p22)
      elseif typeof(p22) == "CFrame" then
        return p22
      elseif typeof(p22) == "Instance" then
        if p22:IsA("BasePart") then
          return p22.CFrame
        end

        if p22:IsA("Model") then
          return p22.PrimaryPart and p22.PrimaryPart.CFrame or p22:GetPivot()
        end

        return
      else
        return
      end
    end

    local function f32()
      if not waitForChild2 then
        return
      else
        local v90 = tonumber(v19 and v19.PosY) or 0

        if v90 == 0 then
          return
        end

        task.wait(0.6)

        if not waitForChild2 then
          return
        end

        waitForChild2.CFrame = CFrame.new(
          waitForChild2.Position.X, waitForChild2.Position.Y + v90, waitForChild2.Position.Z
        )

        return
      end
    end

    local position3

    local function f33()
      position3 = waitForChild2 and waitForChild2.Position
      v87 = tick()

      task.delay(15, function() position3 = nil end)
      task.wait(0.8)

      position3 = waitForChild2 and waitForChild2.Position
    end

    local v91

    local function f34(p23, p24, p25)
      local position4 = p23.Position
      local position5 = waitForChild2.Position
      local magnitude2 = (position4 - position5).Magnitude
      local create

      if magnitude2 <= 8 then
        return true
      else
        f27()
        local v92 = 0
        local v93 = position5
        local v94 = os.clock()
        create = nil
        local v95 = nil
        local v96 = nil

        while true do
          if f25() and not v83 and (not p25 or p25()) then
            if v6:HasTag(localPlayer, "Teleporting")
              or waitForChild and waitForChild.PlatformStand then
              if create then
                pcall(function() create:Cancel() end)

                if v91 == create then
                  v91 = nil
                end
              end

              return false
            else
              if waitForChild and waitForChild.Sit
                and not (waitForChild.SeatPart and waitForChild.SeatPart:IsDescendantOf(v4.Boats)) then
                waitForChild.Sit = false
                waitForChild:ChangeState(Enum.HumanoidStateType.Jumping)
              end

              local position6 = waitForChild2.Position

              if (position6 - v93).Magnitude > 200 then
                position5 = position6
                v92 = 0
                magnitude2 = (position4 - position5).Magnitude

                if create then
                  pcall(function() create:Cancel() end)
                  create = nil
                  v91 = nil
                end

                v96 = nil

                if magnitude2 <= 8 then
                  waitForChild2.CFrame = p23
                  waitForChild2.AssemblyLinearVelocity = Vector3.zero
                  return true
                end
              end

              v93 = position6

              local v97 = (v19.TweenMode or v19.TweenOption) == "TweenService"
                  and "TweenService"
                or "Lerp"

              local v98 = math.clamp((tonumber(v19.TweenSpeed) or 350) * (p24 or 1), 0.1, 600)
              local v99 = os.clock()
              local v100 = v99 - v94
              v94 = v99
              local v101 = math.min(v100, 0.05)
              local magnitude3 = (position4 - position6).Magnitude

              if magnitude3 <= 6 then
                waitForChild2.CFrame = p23
                waitForChild2.AssemblyLinearVelocity = Vector3.zero

                if create then
                  pcall(function() create:Cancel() end)
                end

                return true
              elseif v97 == "TweenService" then
                if v96 ~= "TweenService" or v95 ~= v98 or not create then
                  if create then
                    pcall(function() create:Cancel() end)
                  end

                  create = v14:Create(
                    waitForChild2, TweenInfo.new(magnitude3 / v98, Enum.EasingStyle.Linear),
                    { CFrame = p23 }
                  )

                  v91 = create
                  create:Play()
                  v96 = "TweenService"
                  v95 = v98
                end
              else
                if v96 == "TweenService" and create then
                  pcall(function() create:Cancel() end)
                  create = nil
                  v91 = nil
                  position5 = position6
                  magnitude2 = (position4 - position5).Magnitude
                  v92 = 0
                end

                v96 = "Lerp"
                local v102 = magnitude2 > 0
                v92 = v92 + math.min(v98 * v101, math.min(v98 / 30, 18))
                local v103 = v102 and math.clamp(v92 / magnitude2, 0, 1) or 1

                waitForChild2.CFrame = CFrame.new(position5:Lerp(position4, v103))
                  * (p23 - position4)

                if v92 >= magnitude2 then
                  break
                end
              end

              waitForChild2.AssemblyLinearVelocity = Vector3.zero
              f26()
              task.wait()
            end
          else
            if create then
              pcall(function() create:Cancel() end)

              if v91 == create then
                v91 = nil
              end
            end

            return false
          end
        end

        waitForChild2.CFrame = p23
        waitForChild2.AssemblyLinearVelocity = Vector3.zero

        return true
      end
    end

    local function f35(p26, p27)
      if not f25() or not waitForChild2 then
        return
      end

      count2 = count2 + 1
      v84 = false

      if v91 then
        pcall(function() v91:Cancel() end)
        v91 = nil
      end

      f34(typeof(p26) == "Vector3" and CFrame.new(p26) or p26, p27)
    end

    local function f36(p28, p29, p30, p31)
      local v104 = tick()
      local v105

      repeat
        if p31 then
          if localPlayer.Character and localPlayer.Character:FindFirstChild("Busy") then
            localPlayer.Character.Busy.Value = false
          end

          pcall(function() v6:RemoveTag(localPlayer, "Teleporting") end)

          if waitForChild and waitForChild.Sit
            and not (waitForChild.SeatPart and waitForChild.SeatPart:IsDescendantOf(v4.Boats)) then
            waitForChild.Sit = false
          end
        else
          if v6:HasTag(localPlayer, "Teleporting")
            or waitForChild and waitForChild.PlatformStand then
            local v106 = tick()

            while f25()
              and waitForChild2
              and (v6:HasTag(localPlayer, "Teleporting")
                or waitForChild and waitForChild.PlatformStand)
              and tick() - v106 < 6 do
              if (waitForChild2.Position - p28).Magnitude < 150 then
                break
              end

              task.wait(0.1)
            end

            task.wait(0.5)
            break
          end

          if localPlayer.Character and localPlayer.Character:FindFirstChild("Busy") then
            localPlayer.Character.Busy.Value = false
          end
        end

        task.wait(0.25)
        local v107 = not f25()

        v105 = v107

        v105 = v107 or not waitForChild2 or (waitForChild2.Position - p28).Magnitude < 150
          or p29 and (waitForChild2.Position - p29).Magnitude > 500
          or tick() - v104 > (p30 or 6)
      until v105
    end

    local function f37(p32, p33, p34)
      for index3, value9 in ipairs(p32) do
        if not f25() or not waitForChild2 or v83 then
          return false
        else
          local v108 = value9[2]
          local v109 = value9[1]
          f35(CFrame.new(v109), 1)

          if not f25() or not waitForChild2 or v83 then
            return false
          end

          f36(v108, v109, p34 and 4 or 6, p34)

          if not waitForChild2 or (waitForChild2.Position - v109).Magnitude <= 500 then
            return false
          end

          f33()
          f32()
          task.wait(0.2)
        end
      end

      return true
    end

    local function f38(p35, p36, p37, p38)
      local magnitude4 = (p37 - p36).Magnitude
      local v110 = magnitude4
      local v111

      for index4, value10 in ipairs(p35) do
        local magnitude5 = (value10[1][1] - p36).Magnitude

        for i6 = 1, #value10 - 1 do
          magnitude5 = magnitude5 + (value10[i6 + 1][1] - value10[i6][2]).Magnitude
        end

        local v112 = magnitude5 + (p37 - value10[#value10][2]).Magnitude

        if v112 < v110 then
          v111 = value10
          v110 = v112
        end
      end

      return v111 and magnitude4 - v110 > (p38 or 2500) and v111 or nil
    end

    local v113, v114

    local function f39(p39)
      local v115 = not f25() or not waitForChild2
      local v116, v117, v118, v119, v120

      if v115 then
        return
      else
        local position7 = typeof(p39) == "Vector3" and p39 or p39.Position

        if not position7 then
          return
        end

        if position3 and (waitForChild2.Position - position3).Magnitude < 80 then
          return
        end

        if not (v24 or v25 or v26) then
          local value11 = localPlayer:FindFirstChild("Data")
              and localPlayer.Data:FindFirstChild("Level") and localPlayer.Data.Level.Value
            or 1

          if value11 >= 1500 then
            v26 = true
          elseif value11 >= 700 then
            v25 = true
          else
            v24 = true
          end
        end

        if v24 then
          local position8 = waitForChild2.Position
          local v121 = position8.X > 50000 or f28(position8).Name == "Underwater City"

          if v121 ~= (position7.X > 50000 or f28(position7).Name == "Underwater City")
            and tick() - v87 >= 15 then
            local vector = v121
            vector = v121 and Vector3.new(61170.05, -2, 1952.83)

            local vector2 = vector
            vector2 = vector or Vector3.new(4050.31, -1.69, -1814.12)

            local vector3 = v121
            vector3 = v121 and Vector3.new(3864.69, 6.74, -1926.21)

            local vector4 = vector3
            vector4 = vector3 or Vector3.new(61163.85, 11.68, 1819.78)

            f35(CFrame.new(vector2), 1)

            if not f25() or not waitForChild2 or v83 then
              return
            end

            f36(vector4, vector2, 6, false)
            f33()
            f32()
            task.wait(0.2)
            v119 = not f25()

            v120 = v119
            v120 = v119 or not waitForChild2 or v83

            if v120 then
              return
            else
              local v122 = f38(v86.Sea1, waitForChild2.Position, position7)

              if v122 and tick() - v87 >= 15 then
                f37(v122, nil, false)
              end

              return
            end
          else
            v119 = not f25()

            v120 = v119
            v120 = v119 or not waitForChild2 or v83

            if v120 then
              return
            else
              local v123 = f38(v86.Sea1, waitForChild2.Position, position7)

              if v123 and tick() - v87 >= 15 then
                f37(v123, nil, false)
              end

              return
            end
          end
        elseif v25 then
          local value12 = localPlayer:FindFirstChild("Data")
              and localPlayer.Data:FindFirstChild("Level") and localPlayer.Data.Level.Value
            or 0

          if v114 == nil then
            pcall(function()
              local getUnlockables = commF:InvokeServer("GetUnlockables")
              v114 = typeof(getUnlockables) == "table" and getUnlockables.FlamingoAccess == true
            end)
          end

          local function f40()
            return waitForChild2.Position
          end

          local vector5 = Vector3.new(2284.9, 15.5, 905.5)
          local v124 = f40().Z > 25000 or f28(f40()).Name == "Cursed Ship"
          local v125 = position7.Z > 25000 or f28(position7).Name == "Cursed Ship"
          local v126 = (f40() - vector5).Magnitude <= 260
          local v127 = (position7 - vector5).Magnitude <= 260

          for index5, value13 in ipairs({
            {
              cond = v124 and not v125,
              entry = Vector3.new(920.48, 154.9, 32838.96),
              exit = Vector3.new(-6508.56, 89.04, -132.84),
            },
            {
              cond = v126 and not v127,
              entry = Vector3.new(2284.91, 15.54, 910.48),
              exit = Vector3.new(-286.99, 306.14, 600.88),
            },
            {
              cond = not v124 and v125 and value12 >= 1000,
              entry = Vector3.new(-6496.9, 89.04, -116.51),
              exit = Vector3.new(923.21, 126.98, 32852.83),
            },
            {
              cond = not v126 and v127 and v114,
              entry = Vector3.new(-286.99, 306.14, 592.88),
              exit = Vector3.new(2284.91, 15.54, 902.48),
            },
          }) do
            if value13.cond and tick() - v87 >= 15 then
              f35(CFrame.new(value13.entry), 1)

              if not f25() or not waitForChild2 or v83 then
                return
              end

              f36(value13.exit, value13.entry, 4, true)
              f33()
              f32()
              task.wait(0.2)
            end

            if not f25() or not waitForChild2 or v83 then
              return
            end
          end

          local v128 = {}

          for index6, value14 in ipairs(v86.Sea2) do
            if (value14.Req ~= "GhostShip" or value12 >= 1000)
              and (value14.Req ~= "Flamingo" or v114) then
              v128[#v128 + 1] = value14
            end
          end

          local v129 = f38(v128, waitForChild2.Position, position7)

          if v129 and tick() - v87 >= 15 then
            f37(v129, nil, true)
          end

          return
        else
          if f28(waitForChild2).Name:find("Submerged")
            and not f28(position7).Name:find("Submerged") then
            local rfSubmarineTransportation = v5:FindFirstChild("Modules")
              and v5.Modules:FindFirstChild("Net")
              and v5.Modules.Net:FindFirstChild("RF/SubmarineTransportation")

            if rfSubmarineTransportation then
              local v130 = tick()

              repeat
                if not f25() or not waitForChild2 or v83 then
                  break
                else
                  f35(CFrame.new(11426, -2155, 9732), 1)

                  pcall(function()
                    rfSubmarineTransportation:InvokeServer("InitiateTeleport", "Tiki Outpost")
                  end)

                  task.wait(0.5)
                  local v131 = not f28(waitForChild2).Name:find("Submerged")

                  v116 = v131
                  v116 = v131 or not f25() or tick() - v130 > 8
                end
              until v116

              task.wait(0.3)
            end
          end

          if not f25() or not waitForChild2 or v83 then
            return
          else
            local position9 = waitForChild2.Position
            local v132 = position9.Y > 10000 and position9.X > 20000
            local v133 = position7.Y > 10000 and position7.X > 20000

            if v132 and not v133 then
              f35(CFrame.new(28603, 14897, 103), 1)
              task.wait(0.2)
              pcall(function() commF:InvokeServer("RaceV4Progress", "TeleportBack") end)
              local v134 = tick()

              repeat
                task.wait(0.2)
                local v135 = not f25()

                v117 = v135

                v117 = v135 or not waitForChild2 or waitForChild2.Position.Y < 10000
                  or tick() - v134 > 6
              until v117

              f33()
              f32()
              task.wait(0.3)
            end

            if not f25() or not waitForChild2 or v83 then
              return
            else
              local position10 = waitForChild2.Position

              if not (position10.Y > 10000 and position10.X > 20000) then
                local vector6 = v133 and Vector3.new(3031, 2281, -7326) or position7

                if v113 == nil then
                  pcall(function()
                    local getUnlockables2 = commF:InvokeServer("GetUnlockables")

                    v113 = typeof(getUnlockables2) == "table"
                      and getUnlockables2.DefeatedIndraTrueForm == true
                  end)
                end

                if v113 ~= false then
                  local v136 = f38(v86.Sea3, position10, vector6)

                  if v136 and tick() - v87 >= 15 then
                    f37(v136, nil, true)
                  end
                end
              end

              if not f25() or not waitForChild2 or v83 then
                return
              else
                local position11 = waitForChild2.Position

                if not (position11.Y > 10000 and position11.X > 20000) and v133 then
                  f35(CFrame.new(3031, 2281, -7326), 1)
                  task.wait(0.2)

                  pcall(function()
                    if v5:FindFirstChild("MapStash")
                      and v5.MapStash:FindFirstChild("Temple of Time") then
                      v5.MapStash["Temple of Time"].Parent = v4:FindFirstChild("Map")
                    end
                  end)

                  pcall(function() commF:InvokeServer("RaceV4Progress", "Teleport") end)

                  local v137 = tick()

                  repeat
                    task.wait(0.2)
                    local v138 = not f25()

                    v118 = v138

                    v118 = v138 or not waitForChild2 or waitForChild2.Position.Y > 10000
                      or tick() - v137 > 6
                  until v118

                  f33()
                  f32()
                  task.wait(0.3)
                end

                return
              end
            end
          end
        end
      end
    end

    local function f41(p40)
      if not f25() or not waitForChild2 then
        return
      else
        local position12 = typeof(p40) == "Vector3" and p40 or p40.Position
        local v139 = f30()

        if not v139 then
          return
        else
          local v140 = f29(waitForChild2.Position)

          if v140 == f29(position12) then
            return
          else
            local inside = v140 and v139.Inside or v139.Outside
            f35(CFrame.new(inside), 1)
            task.wait(0.2)

            if waitForChild2 and (waitForChild2.Position - inside).Magnitude < 50 then
              waitForChild2.CFrame = waitForChild2.CFrame + Vector3.new(0, 10, 0)
            end

            task.wait(0.2)
            return
          end
        end
      end
    end

    local v141 = {}
    local v142

    function v141:StopTween()
      v83 = true
      count2 = count2 + 1
      v84 = false

      if v91 then
        pcall(function() v91:Cancel() end)
        v91 = nil
      end

      if v142 then
        pcall(function() v142:Disconnect() end)
        v142 = nil
      end

      if partVelocuty then
        pcall(function()
          if partVelocuty.Parent then
            partVelocuty:Destroy()
          end
        end)

        partVelocuty = nil
      end

      if waitForChild2 then
        for index7, value15 in ipairs(waitForChild2:GetChildren()) do
          local v143 = value15

          if v143:IsA("BodyVelocity") or v143:IsA("BodyPosition") or v143:IsA("BodyGyro") then
            pcall(function() v143:Destroy() end)
          end
        end

        pcall(function()
          waitForChild2.Anchored = false
          waitForChild2.AssemblyLinearVelocity = Vector3.zero
          waitForChild2.AssemblyAngularVelocity = Vector3.zero
        end)
      end
    end

    function v141:topos(p41, p42, p43, p44)
      if v84 or not f25() then
        return
      end

      if waitForChild and waitForChild.Sit
        and not (waitForChild.SeatPart and waitForChild.SeatPart:IsDescendantOf(v4.Boats)) then
        waitForChild.Sit = false
        waitForChild:ChangeState(Enum.HumanoidStateType.Jumping)
      end

      local v144 = f31(p41)

      if not v144 then
        return
      end

      v83 = false
      f39(v144)

      if not f25() then
        return
      end

      f41(v144)
      local v145

      if not f25() or v83 then
        self:StopTween()
        return
      else
        local v146 = tick()

        while f25()
          and waitForChild2
          and (v6:HasTag(localPlayer, "Teleporting")
            or waitForChild and waitForChild.PlatformStand)
          and tick() - v146 < 6 do
          task.wait(0.1)
        end

        if not f25() then
          return
        end

        count2 = count2 + 1
        v84 = true
        v145 = count2
        f26()

        spawn(function()
          local connect = v7.PreSimulation:Connect(f26)
          v142 = connect
          f34(v144, p44, function() return v145 == count2 end)
          pcall(function() connect:Disconnect() end)

          if v142 == connect then
            v142 = nil
          end

          if not v83 and p42 then
            f27()
          elseif not p43 and waitForChild2 then
            local partVelocuty2 = waitForChild2:FindFirstChild("PartVelocuty")

            if partVelocuty2 then
              partVelocuty2:Destroy()
            end

            pcall(function()
              waitForChild2.AssemblyLinearVelocity = Vector3.zero
              waitForChild2.AssemblyAngularVelocity = Vector3.zero
            end)
          end

          v84 = false
        end)

        return
      end
    end

    function GetAllBoats()
      local v147 = { "My Boat" }
      local v148, v149 = v4.Boats:GetChildren()

      for key8, value16 in next, v148, v149 do
        local owner = value16:FindFirstChild("Owner")

        if owner and tostring(owner.Value) ~= localPlayer.Name then
          v147[#v147 + 1] = value16.Name .. " [" .. tostring(owner.Value) .. "]"
        end
      end

      return v147
    end

    function IsBoatAlive(p45)
      if not p45 or not p45.Parent then
        return false
      else
        local humanoid4 = p45:FindFirstChild("Humanoid")

        if humanoid4 then
          if humanoid4:IsA("ValueBase") and tonumber(humanoid4.Value)
            and tonumber(humanoid4.Value) <= 0 then
            return false
          end

          if humanoid4:IsA("Humanoid") and humanoid4.Health <= 0 then
            return false
          end
        end

        local health3 = p45:FindFirstChild("Health")

        if health3 and health3:IsA("ValueBase") and tonumber(health3.Value)
          and tonumber(health3.Value) <= 0 then
          return false
        end

        if p45:GetAttribute("Dead") or p45:GetAttribute("Sunk") then
          return false
        end

        return p45:FindFirstChildWhichIsA("VehicleSeat", true) ~= nil
      end
    end

    function GetSelectedBoat()
      local sailTargetBoat = v19.SailTargetBoat
      local position13 = localPlayer.Character and localPlayer.Character:GetPivot().Position
      local huge2 = math.huge
      local v150, v151 = v4.Boats:GetChildren()
      local v152, v153

      for key9, value17 in next, v150, v151 do
        local owner2 = value17:FindFirstChild("Owner")

        if owner2 then
          if (not sailTargetBoat or sailTargetBoat == "My Boat")
              and tostring(owner2.Value) == localPlayer.Name
            or value17.Name .. " [" .. tostring(owner2.Value) .. "]" == sailTargetBoat then
            v153 = v153 or value17

            if IsBoatAlive(value17) and position13 then
              local magnitude6 = (value17:GetPivot().Position - position13).Magnitude

              if magnitude6 < huge2 then
                huge2 = magnitude6
                v152 = value17
              end
            elseif IsBoatAlive(value17) then
              return value17
            end
          end
        end
      end

      return v152 or v153
    end

    function v141:StopBoatTween()
      v141.StopBoatFlag = true
      v141.ActiveBoatTween = nil
    end

    function v141:toposboat(p46)
      local vehicleSeat, cframe, cframe2, magnitude7, bodyVelocity

      if v141.ActiveBoatTween then
        return
      else
        local v154 = GetSelectedBoat()
        vehicleSeat = v154 and v154:FindFirstChild("VehicleSeat")
        cframe = typeof(p46) == "Vector3" and CFrame.new(p46) or p46

        if not (v154 and vehicleSeat and waitForChild and waitForChild.Sit and cframe) then
          return
        else
          local v155 = tonumber(v19.BoatPosY) or 31
          cframe = CFrame.new(cframe.X, v155, cframe.Z)
          cframe2 = CFrame.new(vehicleSeat.CFrame.X, v155, vehicleSeat.CFrame.Z)
          magnitude7 = (cframe.Position - cframe2.Position).Magnitude

          if magnitude7 <= 25 then
            return
          end

          v141.ActiveBoatTween = true
          v141.StopBoatFlag = false

          bodyVelocity = Instance.new("BodyVelocity")
          bodyVelocity.MaxForce = Vector3.new(1000000000, 1000000000, 1000000000)
          bodyVelocity.Velocity = Vector3.zero
          bodyVelocity.P = 1000000000
          bodyVelocity.Parent = vehicleSeat

          spawn(function()
            local total2 = 0
            local v156 = tick()

            while not v141.StopBoatFlag and waitForChild.Health > 0 and waitForChild.Sit do
              local v157 = tick()
              local v158 = v157 - v156
              v156 = v157
              local v159 = math.max(tonumber(v19.SpeedBoat) or 250, 0.1)
              total2 = total2 + v159 * v158
              local v160 = math.clamp(total2 / magnitude7, 0, 1)
              local lerp = cframe2:Lerp(cframe, v160)
              local v161 = lerp.Position - vehicleSeat.CFrame.Position
              bodyVelocity.Velocity = v161.Magnitude > 0.1 and v161.Unit * v159 or Vector3.zero
              vehicleSeat.CFrame = lerp

              if v160 >= 1 or (cframe.Position - vehicleSeat.CFrame.Position).Magnitude <= 25 then
                vehicleSeat.CFrame = cframe
                break
              end

              task.wait()
            end

            bodyVelocity.Velocity = Vector3.zero
            bodyVelocity:Destroy()

            v141.ActiveBoatTween = nil
            v141.StopBoatFlag = false
          end)

          return
        end
      end
    end

    return v141
  end

  v33.TweenManager = f23()
  tweenManager = v33.TweenManager

  local function f42()
    local hits = {}

    local validTools = {
      Melee = true,
      Sword = true,
      Gun = true,
      ["Blox Fruit"] = true,
    }

    local bodyParts = {
      "Head", "UpperTorso", "Torso", "RightUpperArm", "RightLowerArm", "RightHand",
      "LeftUpperArm", "LeftLowerArm", "LeftHand",
    }

    local sub3 = tostring(localPlayer.UserId or 0):sub(2, 4)

    local overheatData = {
      Dragonstorm = {
        MaxOverheat = 3,
        Cooldown = 0,
        TotalOverheat = 0,
        Distance = 500,
        Shooting = false,
      },
    }

    local shootsPerTarget = { ["Dual Flintlock"] = 2 }

    local shootStyles = {
      ["Skull Guitar"] = "TAP",
      ["Soul Guitar"] = "TAP",
      Bazooka = "Position",
      Cannon = "Position",
      Dragonstorm = "Overheat",
    }

    local remoteFruits = { ["Blade-Blade"] = true, ["Gas-Gas"] = true }

    local v162 = {
      ValidTools = validTools,
      BodyParts = bodyParts,
      LastCombo = 0,
      ComboTime = 0,
      GunDebounce = 0,
      MaxHits = 12,
      CurrentTarget = nil,
      Hits = hits,
      GunIndices = nil,
      LastAttack = 0,
      ShootController = nil,
      UserId = sub3,
      OverheatData = overheatData,
      ShootsPerTarget = shootsPerTarget,
      ShootStyles = shootStyles,
      RemoteFruits = remoteFruits,
      NormalFruits = { ["Light-Light"] = true, ["Ice-Ice"] = true },
      CombatUtils = require(v5.Modules.CombatUtil),
      CombatController = require(v5.Controllers.CombatController),
      GunValidator = remotes:WaitForChild("Validator2"),
      RegisterAttack = net:WaitForChild("RE/RegisterAttack"),
      ShootGun = net:FindFirstChild("RE/ShootGunEvent")
        or require(v5.Modules.Net):RemoteEvent("ShootGunEvent"),
      RegisterHit = require(v5.Modules.Net):RemoteEvent("RegisterHit", true),
    }

    local function f43()
      local shootController = v162.ShootController

      if not shootController then
        pcall(function()
          shootController = getupvalue(v162.CombatController.Attack, 9)
          v162.ShootController = shootController
        end)
      end

      if not shootController then
        return 0, 0
      else
        if not v162.GunIndices then
          local v163 = nil
          local v164 = nil
          local v165 = getupvalues(shootController)
          local v166 = nil

          for i7 = 1, #v165 do
            local v167 = v165[i7]

            if v167 == 798405 then
              v164 = i7
            elseif v167 == 727595 then
              v166 = i7
            elseif v167 == 1099511627776 then
              v163 = i7
            end
          end

          if v164 and v166 and v163 then
            v162.GunIndices = { v164 - 1, v164, v164 + 1, v166, v166 + 1, v163, v163 + 1 }
          else
            v162.GunIndices = { 12, 13, 14, 15, 16, 17, 18 }
          end
        end

        local gunIndices = v162.GunIndices
        local v168 = getupvalue(shootController, gunIndices[1])
        local v169 = getupvalue(shootController, gunIndices[2])
        local v170 = getupvalue(shootController, gunIndices[3])
        local v171 = getupvalue(shootController, gunIndices[4])
        local v172 = getupvalue(shootController, gunIndices[5])
        local v173 = getupvalue(shootController, gunIndices[6])
        local v174 = getupvalue(shootController, gunIndices[7])

        if type(v168) ~= "number" or type(v169) ~= "number" or type(v170) ~= "number"
          or type(v171) ~= "number" or type(v172) ~= "number" or type(v173) ~= "number" then
          return 0, 0
        else
          local v175 = ((v170 * v169 + v168 * v171) % v172 * v172 + v168 * v169) % v173
          local v176 = math.floor(v175 / v172)
          local v177 = (v174 or 0) + 1

          setupvalue(shootController, gunIndices[1], v175 - v176 * v172)
          setupvalue(shootController, gunIndices[3], v176)
          setupvalue(shootController, gunIndices[7], v177)

          return math.floor(v175 / v173 * 16777215), v177
        end
      end
    end

    local function f44()
      if v19.RemoveAnimationFast then
        return
      end

      pcall(function()
        local character3 = localPlayer.Character or character
        local humanoid5 = character3 and character3:FindFirstChildOfClass("Humanoid")

        local tool = character3
          and (character3:FindFirstChildOfClass("Tool")
            or character3:FindFirstChild("EquippedWeapon"))

        if not humanoid5 or not tool then
          return
        else
          local getMovesetAnimCache = v162.CombatUtils:GetMovesetAnimCache(humanoid5)
          local combatUtils = v162.CombatUtils
          local v178 = not getMovesetAnimCache
          local getWeaponName = combatUtils:GetWeaponName(tool)
          local getWeaponData = v162.CombatUtils:GetWeaponData(getWeaponName)

          if v178 or not getWeaponData or not getWeaponData.Moveset
            or not getWeaponData.Moveset.Basic then
            return
          else
            local v179 = getMovesetAnimCache[v162.CombatUtils:GetPureWeaponName(getWeaponName) .. "-basic"
              .. math.random(1, #getWeaponData.Moveset.Basic)]

            if v179 then
              v179:Play(0, 1, (v179:GetAttribute("SpeedMult") or 1) * 5)
              v179.TimePosition = 0.01
            end

            return
          end
        end
      end)
    end

    local v180 = {
      "Head", "UpperTorso", "Torso", "LowerTorso", "RightUpperArm", "RightLowerArm",
      "RightHand", "LeftUpperArm", "LeftLowerArm", "LeftHand", "Right Arm", "Left Arm",
      "RightUpperLeg", "RightLowerLeg", "RightFoot", "LeftUpperLeg", "LeftLowerLeg", "LeftFoot",
      "Right Leg", "Left Leg",
    }

    local function f45(p47)
      if not p47 then
        return nil
      else
        local head = p47:FindFirstChild("Head")

        if head and head:IsA("BasePart") then
          return head
        else
          local upperTorso = p47:FindFirstChild("UpperTorso") or p47:FindFirstChild("Torso")
            or p47:FindFirstChild("LowerTorso")

          if upperTorso and upperTorso:IsA("BasePart") then
            return upperTorso
          else
            for i8 = 1, #v180 do
              local findFirstChild = p47:FindFirstChild(v180[i8])

              if findFirstChild and findFirstChild:IsA("BasePart") then
                return findFirstChild
              end
            end

            local meshPart = p47:FindFirstChildOfClass("MeshPart")
              or p47:FindFirstChildWhichIsA("BasePart")

            if meshPart and meshPart.Name ~= "HumanoidRootPart" then
              return meshPart
            end

            return p47.PrimaryPart or p47:FindFirstChild("HumanoidRootPart")
          end
        end
      end
    end

    local function f46(p48, p49)
      local v181 = {}
      local v182 = p49 or 80
      local character4 = localPlayer.Character or character

      local humanoidRootPart3 = character4
          and (character4:FindFirstChild("HumanoidRootPart") or character4.PrimaryPart)
        or waitForChild2

      if not humanoidRootPart3 then
        return v181
      else
        local position14 = humanoidRootPart3.Position
        local maxHits = v162.MaxHits or 12
        local currentTarget = v162.CurrentTarget

        if currentTarget and currentTarget.Parent and not currentTarget:GetAttribute("IsBoat") then
          local humanoidRootPart4 = currentTarget:FindFirstChild("HumanoidRootPart")
            or currentTarget.PrimaryPart

          if humanoidRootPart4 and (humanoidRootPart4.Position - position14).Magnitude <= v182
            and v33:IsReady(currentTarget) then
            local v183 = f45(currentTarget)

            if v183 then
              table.insert(v181, { currentTarget, v183 })

              if #v181 >= maxHits then
                return v181
              end
            end
          end
        end

        if v19.attackmobs and enemies then
          local getChildren = enemies:GetChildren()

          for i9 = 1, #getChildren do
            if #v181 >= maxHits then
              break
            else
              local v184 = getChildren[i9]

              if v184 ~= currentTarget and not v184:GetAttribute("IsBoat") then
                local humanoidRootPart5 = v184:FindFirstChild("HumanoidRootPart")
                  or v184.PrimaryPart

                if humanoidRootPart5
                  and (humanoidRootPart5.Position - position14).Magnitude <= v182
                  and v33:IsReady(v184) then
                  local v185 = false

                  if not p48 and v19.MasteryFarm then
                    local humanoid6 = v184:FindFirstChildOfClass("Humanoid")

                    if humanoid6
                      and humanoid6.Health / humanoid6.MaxHealth <= (v19.HealthMob or 0) / 100 then
                      v185 = true
                    end
                  end

                  if not v185 then
                    local v186 = f45(v184)

                    if v186 then
                      table.insert(v181, { v184, v186 })
                    end
                  end
                end
              end
            end
          end
        end

        if v19.attackplayers and not localPlayer:GetAttribute("PvpDisabled")
          and v4:FindFirstChild("Characters") then
          local getChildren2 = v4.Characters:GetChildren()

          for i10 = 1, #getChildren2 do
            if #v181 >= maxHits then
              break
            else
              local v187 = getChildren2[i10]

              if v187 ~= character4 then
                local humanoidRootPart6 = v187:FindFirstChild("HumanoidRootPart")
                  or v187.PrimaryPart

                if humanoidRootPart6
                  and (humanoidRootPart6.Position - position14).Magnitude <= v182 then
                  local getPlayerFromCharacter = v3:GetPlayerFromCharacter(v187)

                  if getPlayerFromCharacter
                    and (v19.AutoKillPlayerinTrial or f11(getPlayerFromCharacter)) then
                    local v188 = f45(v187)

                    if v188 then
                      table.insert(v181, { v187, v188 })
                    end
                  end
                end
              end
            end
          end
        end

        return v181
      end
    end

    local function f47(p50, p51, p52)
      v162.Hits = {}
      local v189 = p50 or 200
      local character5 = localPlayer and localPlayer.Character or character

      local humanoidRootPart7 = character5
          and (character5:FindFirstChild("HumanoidRootPart") or character5.PrimaryPart)
        or waitForChild2

      if not humanoidRootPart7 then
        return
      else
        local position15 = humanoidRootPart7.Position

        if p51 or v19.attackmobs then
          local getChildren3 = enemies and enemies:GetChildren()

          if getChildren3 then
            for i11 = 1, #getChildren3 do
              local v190 = getChildren3[i11]

              if v190 ~= character5 and not v190:GetAttribute("IsBoat") then
                local primaryPart = v190.PrimaryPart

                local humanoidRootPart8 = primaryPart
                humanoidRootPart8 = primaryPart or v190:FindFirstChild("HumanoidRootPart")

                if humanoidRootPart8
                  and (position15 - humanoidRootPart8.Position).Magnitude <= v189
                  and v33:IsReady(v190) then
                  local getPlayerFromCharacter2 = v3:GetPlayerFromCharacter(v190)

                  if v190.Parent ~= v4.Characters
                    or getPlayerFromCharacter2 and f11(getPlayerFromCharacter2) then
                    table.insert(v162.Hits, { v190, humanoidRootPart8 })
                  end
                end
              end
            end
          end
        end

        if p51 or v19.attackplayers and not localPlayer:GetAttribute("PvpDisabled") then
          local characters = v4:FindFirstChild("Characters")

          local getChildren4 = characters
          getChildren4 = characters and v4.Characters:GetChildren()

          if getChildren4 then
            for i12 = 1, #getChildren4 do
              local v191 = getChildren4[i12]

              if v191 ~= character5 then
                local humanoidRootPart9 = v191:FindFirstChild("HumanoidRootPart")
                  or v191.PrimaryPart

                if humanoidRootPart9
                  and (position15 - humanoidRootPart9.Position).Magnitude <= v189 then
                  local getPlayerFromCharacter3 = v3:GetPlayerFromCharacter(v191)

                  if getPlayerFromCharacter3
                    and (v19.AutoKillPlayerinTrial or f11(getPlayerFromCharacter3)) then
                    table.insert(v162.Hits, { v191, humanoidRootPart9 })
                  end
                end
              end
            end
          end
        end

        if p52 then
          if seaBeasts then
            local getChildren5 = seaBeasts:GetChildren()

            for i13 = 1, #getChildren5 do
              local v192 = getChildren5[i13]
              local meshPart2 = v192:FindFirstChildOfClass("MeshPart")

              local basePart = meshPart2

              basePart = meshPart2 or v192:FindFirstChildWhichIsA("BasePart")
                or v192.PrimaryPart

              if basePart and (position15 - basePart.Position).Magnitude <= v189
                and v33:IsReady(v192) then
                table.insert(v162.Hits, { v192, basePart })
              end
            end
          end

          if enemies then
            local getChildren6 = enemies:GetChildren()

            for i14 = 1, #getChildren6 do
              local v193 = getChildren6[i14]

              if v193:GetAttribute("IsBoat") then
                local meshPart3 = v193:FindFirstChildOfClass("MeshPart")

                local basePart2 = meshPart3

                basePart2 = meshPart3 or v193:FindFirstChildWhichIsA("BasePart")
                  or v193.PrimaryPart

                if basePart2 and (position15 - basePart2.Position).Magnitude <= v189
                  and v33:IsReady(v193) then
                  table.insert(v162.Hits, { v193, basePart2 })
                end
              end
            end
          end
        end

        return
      end
    end

    local function f48()
      local huge3 = math.huge
      local character6 = localPlayer and localPlayer.Character or character

      local humanoidRootPart10 = character6
          and (character6:FindFirstChild("HumanoidRootPart") or character6.PrimaryPart)
        or waitForChild2

      local position16 = humanoidRootPart10 and humanoidRootPart10.Position
      local currentTarget2 = v162.CurrentTarget

      if currentTarget2 and typeof(currentTarget2) == "Instance"
        and currentTarget2:IsDescendantOf(workspace) then
        local basePart3 = currentTarget2:IsA("BasePart") and currentTarget2
          or currentTarget2:FindFirstChild("HumanoidRootPart")
          or currentTarget2:FindFirstChildWhichIsA("BasePart")
          or currentTarget2:IsA("Model") and currentTarget2.PrimaryPart

        if basePart3 and basePart3:IsDescendantOf(workspace) then
          local humanoid7 = currentTarget2:FindFirstChildOfClass("Humanoid")

          if not humanoid7 or humanoid7.Health > 0 then
            if not position16 or (position16 - basePart3.Position).Magnitude <= 400 then
              v162.Hits = { { currentTarget2, basePart3 } }
              return basePart3.Position, basePart3
            end
          end
        end
      end

      local hits2 = v162.Hits
      local v194, v195

      for i15 = 1, #hits2 do
        local v196 = hits2[i15]
        local v197 = type(v196) == "table" and v196[1] or v196

        local basePart4 = type(v196) == "table" and v196[2]
          or typeof(v196) == "Instance" and v196:IsA("BasePart") and v196

        if basePart4 and basePart4:IsDescendantOf(workspace) then
          local magnitude8 = position16 and (position16 - basePart4.Position).Magnitude or 0

          local isBoat = v194
            and (v197.Parent == seaBeasts
              or v194.Parent ~= seaBeasts and v197:GetAttribute("IsBoat"))

          if not v194
            or isBoat
            or magnitude8 < huge3
              and not (v194.Parent == seaBeasts or v194:GetAttribute("IsBoat")) then
            huge3 = magnitude8
            v194 = v197
            v195 = basePart4
          end
        end
      end

      if not v195 then
        return nil, nil
      end

      v162.Hits = { { v194, v195 } }
      return v195.Position, v195
    end

    local function f49(p53, p54, p55)
      local name, getWeaponData2, shootSoulGuitar

      if not p53 then
        return
      else
        name = p53.Name
        getWeaponData2 = nil
        pcall(function() getWeaponData2 = v162.CombatUtils:GetWeaponData(name) end)

        local shootType = getWeaponData2 and getWeaponData2.ShootType or v162.ShootStyles[name]
          or "Normal"

        p53:SetAttribute("LocalTotalShots", (p53:GetAttribute("LocalTotalShots") or 0) + 1)

        if v162.GunValidator then
          pcall(function()
            local v198, v199 = f43()

            if v198 and v199 and v198 ~= 0 then
              v162.GunValidator:FireServer(v198, v199)
            end
          end)
        end

        if shootType == "Custom" or name == "Skull Guitar" or name == "Soul Guitar" then
          shootSoulGuitar = v5:FindFirstChild("Events")
            and v5.Events:FindFirstChild("ShootSoulGuitar")

          if shootSoulGuitar and shootSoulGuitar:IsA("BindableFunction") then
            if not pcall(function() shootSoulGuitar:Invoke(p54) end) and v162.ShootGun then
              v162.ShootGun:FireServer(p54)
            end
          elseif p53:FindFirstChild("RemoteEvent") then
            p53.RemoteEvent:FireServer("TAP", p54)
          elseif v162.ShootGun then
            v162.ShootGun:FireServer(p54)
          end

          return
        end

        if shootType == "Projectile" or name == "Cannon" or name == "Bazooka" then
          if v162.ShootGun then
            v162.ShootGun:FireServer(p54)
          end

          return
        end

        if shootType == "HitscanBurst" or name == "Dual Flintlock" then
          if v162.ShootGun then
            local shootGun2 = v162.ShootGun
            local v200 = p55 and { p55 } or {}
            local v201 = workspace
            shootGun2:FireServer(p54, v200, math.random(math.floor(v201:GetServerTimeNow())))
          end

          return
        end

        if v162.ShootGun then
          local v202 = type(p55) == "table" and p55 or p55 and { p55 } or {}
          v162.ShootGun:FireServer(p54, v202)
        end

        return
      end
    end

    local function f50()
      local character7 = localPlayer and localPlayer.Character or character
      local name2, getWeaponData3

      if not character7 then
        return
      else
        local tool2 = character7:FindFirstChildOfClass("Tool")

        if not tool2 or tool2.Parent ~= character7 then
          return
        end

        tool2.Enabled = true
        name2 = tool2.Name

        if name2 == "Dragonstorm" or v162.ShootStyles[name2] == "Overheat" then
          tool2:SetAttribute("IsReloading_Client", false)
          tool2:SetAttribute("LocalShotsLeft", 100)
          tool2:SetAttribute("LocalOverheat", 0)
        end

        if v162.GunDebounce > tick() then
          if not tool2.Enabled then
            v162.GunDebounce = 0
          else
            return
          end
        end

        local humanoidRootPart11 = character7:FindFirstChild("HumanoidRootPart")
          or character7.PrimaryPart or waitForChild2

        local position17 = humanoidRootPart11 and humanoidRootPart11.Position

        if not position17 then
          return
        else
          getWeaponData3 = nil
          pcall(function() getWeaponData3 = v162.CombatUtils:GetWeaponData(name2) end)

          local shootType2 = getWeaponData3 and getWeaponData3.ShootType
            or v162.ShootStyles[name2] or "Normal"

          local shootStyle = getWeaponData3 and getWeaponData3.ShootStyle or ""

          if name2 == "Dragonstorm" or shootStyle == "Gatling" then
            local v203 = string.find(tostring(v19.DragonstormMode or "Spread Damage"), "Single")
              ~= nil

            local v204 = math.max(400, getWeaponData3 and tonumber(getWeaponData3.Range)
              or v162.OverheatData[name2] and v162.OverheatData[name2].Distance or 400)

            f47(v204, true, true)
            local currentTarget3 = v162.CurrentTarget

            if currentTarget3 and typeof(currentTarget3) == "Instance"
              and currentTarget3:IsDescendantOf(workspace) then
              local basePart5 = currentTarget3:IsA("BasePart") and currentTarget3
                or currentTarget3:FindFirstChild("HumanoidRootPart")
                or currentTarget3:FindFirstChildWhichIsA("BasePart")
                or currentTarget3:IsA("Model") and currentTarget3.PrimaryPart

              if basePart5 and (position17 - basePart5.Position).Magnitude <= v204 then
                local v205 = false

                for index8, value18 in ipairs(v162.Hits) do
                  if (type(value18) == "table" and value18[2] or value18) == basePart5 then
                    v205 = true
                    break
                  end
                end

                if not v205 then
                  table.insert(v162.Hits, 1, { currentTarget3, basePart5 })
                end
              end
            end

            if #v162.Hits == 0 then
              return
            end

            v162.GunDebounce = tick() + 0.05

            if v203 then
              local position18, v206 = f48()

              if not v206 and v162.Hits[1] then
                local v207 = v162.Hits[1]
                v206 = type(v207) == "table" and v207[2] or typeof(v207) == "Instance" and v207
                position18 = v206 and v206.Position
              end

              if not v206 or not position18 then
                return
              end

              tool2:SetAttribute(
                "LocalTotalShots", (tool2:GetAttribute("LocalTotalShots") or 0) + 1
              )

              if v162.GunValidator then
                pcall(function()
                  local v208, v209 = f43()

                  if v208 and v209 and v208 ~= 0 then
                    v162.GunValidator:FireServer(v208, v209)
                  end
                end)
              end

              if v162.ShootGun then
                v162.ShootGun:FireServer(position18, { v206 })
              end

              return
            else
              local v210 = {}
              local isDescendantOf = currentTarget3
              local v211 = {}

              if currentTarget3 then
                isDescendantOf = typeof(currentTarget3) == "Instance"
                  and currentTarget3:IsDescendantOf(workspace)
              end

              if isDescendantOf then
                local basePart6 = currentTarget3:IsA("BasePart") and currentTarget3
                  or currentTarget3:FindFirstChild("HumanoidRootPart")
                  or currentTarget3:FindFirstChildWhichIsA("BasePart")
                  or currentTarget3:IsA("Model") and currentTarget3.PrimaryPart

                if basePart6 and (position17 - basePart6.Position).Magnitude <= v204 then
                  v211[basePart6] = true
                  table.insert(v210, basePart6)
                end
              end

              for i16 = 1, #v162.Hits do
                local v212 = v162.Hits[i16]

                local basePart7 = type(v212) == "table" and v212[2]
                  or typeof(v212) == "Instance" and v212:IsA("BasePart") and v212

                if basePart7 and basePart7:IsDescendantOf(workspace) and not v211[basePart7] then
                  local parent = basePart7.Parent

                  local humanoid8 = parent
                  humanoid8 = parent and basePart7.Parent:FindFirstChildOfClass("Humanoid")

                  if not humanoid8 or humanoid8.Health > 0 then
                    v211[basePart7] = true
                    table.insert(v210, basePart7)

                    if #v210 >= 8 then
                      break
                    end
                  end
                end
              end

              if #v210 == 0 then
                return
              end

              tool2:SetAttribute(
                "LocalTotalShots", (tool2:GetAttribute("LocalTotalShots") or 0) + #v210
              )

              if v162.GunValidator then
                pcall(function()
                  local v213, v214 = f43()

                  if v213 and v214 and v213 ~= 0 then
                    v162.GunValidator:FireServer(v213, v214)
                  end
                end)
              end

              if v162.ShootGun then
                for index9, value19 in ipairs(v210) do
                  v162.ShootGun:FireServer(value19.Position, { value19 })
                end
              end

              return
            end
          elseif shootType2 == "Projectile" or name2 == "Cannon" or name2 == "Bazooka"
            or shootType2 == "Custom" or name2 == "Skull Guitar" or name2 == "Soul Guitar" then
            f47(250, true, true)
            local v215, v216 = f48()

            if not v216 then
              return
            else
              local v217 = getWeaponData3 and tonumber(getWeaponData3.Cooldown)
                or shootType2 == "Projectile" and 3.5 or 1.5

              v162.GunDebounce = tick() + v217
              f49(tool2, v215, v216)
              return
            end
          else
            f47(200, false, true)

            if #v162.Hits == 0 then
              return
            else
              local v218, v219 = f48()

              if not v219 then
                return
              else
                local v220 = getWeaponData3 and tonumber(getWeaponData3.Cooldown) or 0.4
                v162.GunDebounce = tick() + v220
                f49(tool2, v218, v219)
                return
              end
            end
          end
        end
      end
    end

    local function f51(p56, p57)
      if not p57 or not p57:FindFirstChild("LeftClickRemote") then
        return
      else
        local humanoidRootPart12 = character and character:FindFirstChild("HumanoidRootPart")

        if not humanoidRootPart12 then
          return
        else
          local position19 = humanoidRootPart12.Position

          if enemies then
            local getChildren7 = enemies:GetChildren()

            for i17 = 1, #getChildren7 do
              local v221 = getChildren7[i17]

              if not v221:GetAttribute("IsBoat") then
                local primaryPart2 = v221.PrimaryPart or v221:FindFirstChild("HumanoidRootPart")

                if primaryPart2 and (primaryPart2.Position - position19).Magnitude <= 65
                  and v33:IsReady(v221) then
                  p57.LeftClickRemote:FireServer((primaryPart2.Position - position19).Unit, p56)
                end
              end
            end
          end

          if v19.attackplayers and not localPlayer:GetAttribute("PvpDisabled")
            and v4:FindFirstChild("Characters") then
            local getChildren8 = v4.Characters:GetChildren()
            local character8 = localPlayer and localPlayer.Character

            for i18 = 1, #getChildren8 do
              local v222 = getChildren8[i18]

              if v222 ~= character8 then
                local humanoidRootPart13 = v222:FindFirstChild("HumanoidRootPart")
                  or v222.PrimaryPart

                if humanoidRootPart13
                  and (humanoidRootPart13.Position - position19).Magnitude <= 65 then
                  local getPlayerFromCharacter4 = v3:GetPlayerFromCharacter(v222)

                  if getPlayerFromCharacter4
                    and (v19.AutoKillPlayerinTrial or f11(getPlayerFromCharacter4)) then
                    p57.LeftClickRemote:FireServer(
                      (humanoidRootPart13.Position - position19).Unit, p56
                    )
                  end
                end
              end
            end
          end

          if seaBeasts then
            local getChildren9 = seaBeasts:GetChildren()

            for i19 = 1, #getChildren9 do
              local v223 = getChildren9[i19]
              local meshPart4 = v223:FindFirstChildOfClass("MeshPart") or v223.PrimaryPart

              if meshPart4 and (meshPart4.Position - position19).Magnitude <= 70
                and v33:IsReady(v223) then
                p57.LeftClickRemote:FireServer(Vector3.new(0.01, -500, 0.01), 1, true)
              end
            end
          end

          return
        end
      end
    end

    return {
      Attack = function()
        local v224 = tonumber(v19.FastAttackDelay) or 0
        local v225 = v224 > 0 and v224 or 0.08
        local v226 = tick()
        local position20, tool3, toolTip, checkToolName

        if v226 - v162.LastAttack < v225 then
          return
        else
          v162.LastAttack = v226
          local character9 = localPlayer.Character or character
          tool3 = character9 and character9:FindFirstChildOfClass("Tool")
          toolTip = tool3 and tool3.ToolTip or nil

          if v19.DoubleAttack and v33.Utilities then
            local checkfruit = v33.Utilities:Checkfruit()
            checkToolName = checkfruit and v33.Utilities:CheckToolName(checkfruit)

            if checkToolName and checkToolName:FindFirstChild("LeftClickRemote") then
              pcall(function()
                checkToolName.LeftClickRemote:FireServer(Vector3.new(0.01, -500, 0.01), 1, true)
              end)
            end
          end

          if not tool3 then
            if v19.DoubleAttack and v33.Utilities then
              local checkfruit2 = v33.Utilities:Checkfruit()
              local checkToolName2 = checkfruit2 and v33.Utilities:CheckToolName(checkfruit2)

              if checkToolName2 then
                tool3 = checkToolName2
                toolTip = "Blox Fruit"
              else
                return
              end
            else
              return
            end
          end

          if not toolTip or toolTip == "" or not v162.ValidTools[toolTip] then
            pcall(function()
              local combatUtils2 = v162.CombatUtils
              local getWeaponData4 = v162.CombatUtils:GetWeaponData((combatUtils2:GetWeaponName(tool3)))

              if getWeaponData4 and getWeaponData4.WeaponType then
                toolTip = getWeaponData4.WeaponType
              end
            end)

            if not toolTip or not v162.ValidTools[toolTip] then
              toolTip = "Melee"
            end
          end

          if not v162.ValidTools[toolTip] then
            return
          elseif v19.FastSettings == "Fast Attack" then
            if toolTip == "Gun" then
              if v19.AutoAttackGun ~= false then
                f50()
              end

              return
            end

            local v227 = f46(toolTip == "Blox Fruit"
              and tool3:FindFirstChild("LeftClickRemote") ~= nil, 80)

            if toolTip == "Blox Fruit" and not v162.NormalFruits[tool3.Name] then
              local lastCombo = v162.LastCombo

              if tick() - v162.ComboTime > 0.65 then
                lastCombo = 0
              end

              local v228 = lastCombo >= 5 and 1 or lastCombo + 1

              v162.LastCombo = v228
              v162.ComboTime = tick()

              if tool3:FindFirstChild("LeftClickRemote") then
                f51(v228, tool3)
              end
            elseif #v227 > 0 then
              v162.RegisterAttack:FireServer(0)
              f44()
              local v229 = table.remove(v227, 1)
              local v230 = v229 and v229[2]

              if v230 and v162.RegisterHit then
                v162.RegisterHit:FireServer(v230, v227)
              end
            end

            if v19.DoubleAttack and toolTip == "Blox Fruit" and v33.Utilities then
              local checkfruit3 = v33.Utilities:Checkfruit()

              local checkToolName3 = checkfruit3
              checkToolName3 = checkfruit3 and v33.Utilities:CheckToolName(checkfruit3)

              if checkToolName3 and checkToolName3 ~= tool3
                and checkToolName3:FindFirstChild("LeftClickRemote") then
                f51(v162.LastCombo or 1, checkToolName3)
              end
            end

            return
          elseif v19.FastSettings == "Legit Attack" then
            if toolTip == "Gun" then
              if v19.AutoAttackGun ~= false then
                f50()
              end

              return
            end

            if toolTip == "Blox Fruit" and tool3:FindFirstChild("LeftClickRemote")
              and not v162.NormalFruits[tool3.Name] then
              local lastCombo2 = v162.LastCombo

              if tick() - v162.ComboTime > 0.65 then
                lastCombo2 = 0
              end

              local v231 = lastCombo2 >= 5 and 1 or lastCombo2 + 1

              v162.LastCombo = v231
              v162.ComboTime = tick()

              f51(v231, tool3)
            else
              local v232 = character

              local equippedWeapon = v232
              equippedWeapon = v232 and character:FindFirstChild("EquippedWeapon")

              if equippedWeapon then
                local getDescendants = equippedWeapon:GetDescendants()

                for i20 = 1, #getDescendants do
                  local v233 = getDescendants[i20]

                  if v233:IsA("BasePart") and v233.Size.X ~= 60 then
                    v233.Size = Vector3.new(60, 60, 60)
                    v233.CanCollide = false
                    v233.Massless = true
                  end
                end
              end

              local humanoidRootPart14 = waitForChild2
                or character and character:FindFirstChild("HumanoidRootPart")

              position20 = humanoidRootPart14 and humanoidRootPart14.Position

              local function f52(p58)
                local primaryPart3 = p58.PrimaryPart or p58:FindFirstChild("HumanoidRootPart")

                if not primaryPart3 or not position20
                  or (primaryPart3.Position - position20).Magnitude > 65 then
                  return
                else
                  local upperTorso2 = p58:FindFirstChild("UpperTorso")
                    or p58:FindFirstChild("Torso") or p58:FindFirstChild("Head") or primaryPart3

                  if upperTorso2 and upperTorso2.Size.X ~= 70 then
                    upperTorso2.Size = Vector3.new(70, 70, 70)
                    upperTorso2.Transparency = 1
                    upperTorso2.CanCollide = false
                    upperTorso2.Massless = true
                  end

                  if tool3 and tool3.Parent == character then
                    pcall(function() tool3:Activate() end)
                  end

                  v162.CombatController:Attack(tool3)
                  return
                end
              end

              if enemies then
                local getChildren10 = enemies:GetChildren()

                for i21 = 1, #getChildren10 do
                  local v234 = getChildren10[i21]

                  if v33:IsReady(v234) then
                    f52(v234)
                  end
                end
              end

              if v19.attackplayers and not localPlayer:GetAttribute("PvpDisabled")
                and v4:FindFirstChild("Characters") then
                local getChildren11 = v4.Characters:GetChildren()
                local character10 = localPlayer and localPlayer.Character

                for i22 = 1, #getChildren11 do
                  local v235 = getChildren11[i22]

                  if v235 ~= character10 then
                    local getPlayerFromCharacter5 = v3:GetPlayerFromCharacter(v235)

                    if getPlayerFromCharacter5
                      and (v19.AutoKillPlayerinTrial or f11(getPlayerFromCharacter5)) then
                      f52(v235)
                    end
                  end
                end
              end
            end

            return
          else
            return
          end
        end
      end,
      ShootGun = f50,
      CustomShoot = function(p59, p60)
        local v236 = p60
        local tool4 = character and character:FindFirstChildOfClass("Tool")

        if not tool4 then
          return
        end

        if not v236 and enemies then
          local magnitude9 = 50
          local getChildren12 = enemies:GetChildren()

          for i23 = 1, #getChildren12 do
            local v237 = getChildren12[i23]

            if not v237:GetAttribute("IsBoat") then
              local humanoidRootPart15 = v237:FindFirstChild("HumanoidRootPart")
                or v237.PrimaryPart

              if humanoidRootPart15
                and (humanoidRootPart15.Position - p59).Magnitude < magnitude9
                and v33:IsReady(v237) then
                magnitude9 = (humanoidRootPart15.Position - p59).Magnitude
                v236 = humanoidRootPart15
              end
            end
          end
        end

        f49(tool4, p59, v236)
      end,
      GetHits = f46,
      AttackManager = v162,
    }
  end

  function f11(p61)
    if not p61 or p61 == localPlayer then
      return false
    end

    return not (p61.Team and localPlayer.Team and p61.Team == localPlayer.Team
        and tostring(p61.Team) == "Marines")
      and not (p61:HasTag("Ally" .. localPlayer.Name) or localPlayer:HasTag("Ally" .. p61.Name))
  end

  v33.FastAttack = f42()
  fastAttack = v33.FastAttack
  shootGun = fastAttack.ShootGun
  customShoot = fastAttack.CustomShoot

  v33.ServerStatus = {
    GetFruitStock = function()
      local function f53(p62)
        local v238, v239 = pcall(function()
          return commF:InvokeServer("GetFruits", p62 or nil)
        end)

        local v240 = v239

        if not v238 then
          v240 = nil
        end

        local v241 = {}

        local restockIn = type(v240) == "table" and v240.RestockIn
          or (p62 and 7200 or 14400) - os.time() % (p62 and 7200 or 14400)

        if type(v240) == "table" then
          for key10, value20 in pairs(v240) do
            if type(value20) == "table" and (value20.OnSale or value20.InStock) then
              local v242 = tostring(value20.Name or "Unknown")

              v241[#v241 + 1] = string.format(
                "[*] %s — $%d", v242:gsub("%-.*", ""), value20.Price or 0
              )
            end
          end
        end

        local v243 = math.floor(restockIn / 3600)
        local v244 = math.floor(restockIn % 3600 / 60)
        local v245 = restockIn % 60

        return v243 > 0 and string.format("%dh %dm %ds", v243, v244, v245)
          or v244 > 0 and string.format("%dm %ds", v244, v245) or v245 .. "s", #v241 > 0 and table.concat(v241, "\n") or "No fruits in stock"
      end

      local v246, v247 = f53(false)
      local v248, v249 = f53(true)

      return string.format([[
Normal Dealer
%s
Restock: %s

%s

Mirage Dealer
%s
Restock: %s

%s]], "_", v246, v247, "_", v248, v249)
    end,
  }

  serverStatus = v33.ServerStatus

  v33.DataList = {
    BonesList = {
      ["Reborn Skeleton"] = true,
      ["Living Zombie"] = true,
      ["Demonic Soul"] = true,
      ["Posessed Mummy"] = true,
    },
    CakesList = {
      ["Head Baker"] = true,
      ["Baking Staff"] = true,
      ["Cake Guard"] = true,
      ["Cookie Crafter"] = true,
    },
    RaceList = {
      Fishman = CFrame.new(28224.057, 14889.427, -210.587),
      Human = CFrame.new(29237.295, 14889.427, -206.95),
      Cyborg = CFrame.new(28492.414, 14894.427, -422.11),
      Skypiea = CFrame.new(28967.408, 14918.075, 234.312),
      Ghoul = CFrame.new(28672.721, 14889.128, 454.596),
      Mink = CFrame.new(29020.66, 14889.427, -379.268),
    },
    HumanRace = { Orbitus = true, Diamond = true, Jeremy = true },
    TyrantList = {
      ["Serpent Hunter"] = true,
      ["Skull Slayer"] = true,
      ["Isle Champion"] = true,
      ["Sun-kissed Warrior"] = true,
    },
  }

  local function f54()
    local v250 = {
      ActiveTweens = {},
      SpawnCache = {},
      MobCycle = {},
      NextSpawnCooldown = {},
      OrbitAngle = 0,
      OrbitSpeed = 3,
      LastTick = tick(),
    }

    function v250:GetFarmCFrame(p63)
      if not p63 then
        return nil
      else
        local posMethod = v19.PosMethod or "Above"
        local position21 = p63.Position
        local tool5 = character and character:FindFirstChildOfClass("Tool")
        local v251 = tool5 and tool5.ToolTip == "Blox Fruit"
        local v252 = tonumber(v19.PosY) or v251 and 18 or 18
        local v253 = math.clamp(v252, 3, 30)

        if posMethod == "Orbit" then
          local v254 = tick()
          local lastTick = self.LastTick

          self.LastTick = v254
          self.OrbitAngle = self.OrbitAngle + self.OrbitSpeed * (v254 - lastTick)

          local v255 = tonumber(v19.CircleRadius) or v251 and 6 or v253

          return CFrame.new(position21 + Vector3.new(
            math.cos(self.OrbitAngle) * v255, v253, math.sin(self.OrbitAngle) * v255
          ))
        end

        return CFrame.new(position21 + Vector3.new(0, v253, 0.5))
      end
    end

    function v250:GetDistance(p64)
      if typeof(p64) == "CFrame" then
        return localPlayer:DistanceFromCharacter(p64.Position)
      end

      if typeof(p64) == "Vector3" then
        return localPlayer:DistanceFromCharacter(p64)
      end
    end

    function v250:AutoHaki()
      if not localPlayer.Character:HasTag("Buso") and beli.Value >= 25000 then
        commF:InvokeServer("BuyHaki", "Buso")
      elseif localPlayer.Character:HasTag("Buso")
        and not localPlayer.Character:FindFirstChild("HasBuso") then
        commF:InvokeServer("Buso")
      end
    end

    function v250:CheckToolName(p65)
      local backpack = localPlayer and localPlayer.Backpack

      if character then
        return character:FindFirstChild(p65) or backpack:FindFirstChild(p65)
      end
    end

    local v256 = {
      ["Rocket-Rocket"] = 1,
      Rocket = 1,
      ["Spin-Spin"] = 2,
      Spin = 2,
      ["Blade-Blade"] = 3,
      Blade = 3,
      ["Chop-Chop"] = 3,
      Chop = 3,
      ["Spring-Spring"] = 4,
      Spring = 4,
      ["Bomb-Bomb"] = 5,
      Bomb = 5,
      ["Smoke-Smoke"] = 6,
      Smoke = 6,
      ["Spike-Spike"] = 7,
      Spike = 7,
      ["Flame-Flame"] = 8,
      Flame = 8,
      ["Falcon-Falcon"] = 9,
      Falcon = 9,
      ["Ice-Ice"] = 10,
      Ice = 10,
      ["Sand-Sand"] = 11,
      Sand = 11,
      ["Dark-Dark"] = 12,
      Dark = 12,
      ["Diamond-Diamond"] = 13,
      Diamond = 13,
      ["Light-Light"] = 14,
      Light = 14,
      ["Ghost-Ghost"] = 15,
      Ghost = 15,
      ["Rubber-Rubber"] = 16,
      Rubber = 16,
      ["Barrier-Barrier"] = 17,
      Barrier = 17,
      ["Magma-Magma"] = 18,
      Magma = 18,
      ["Quake-Quake"] = 19,
      Quake = 19,
      ["Human-Human: Buddha"] = 20,
      ["Buddha-Buddha"] = 20,
      Buddha = 20,
      ["Love-Love"] = 21,
      Love = 21,
      ["Spider-Spider"] = 22,
      Spider = 22,
      ["Sound-Sound"] = 23,
      Sound = 23,
      ["Phoenix-Phoenix"] = 24,
      Phoenix = 24,
      ["Portal-Portal"] = 25,
      Portal = 25,
      ["Rumble-Rumble"] = 26,
      Rumble = 26,
      ["Pain-Pain"] = 27,
      Pain = 27,
      ["Blizzard-Blizzard"] = 28,
      Blizzard = 28,
      ["Gravity-Gravity"] = 29,
      Gravity = 29,
      ["Mammoth-Mammoth"] = 30,
      Mammoth = 30,
      ["T-Rex-T-Rex"] = 31,
      ["T-Rex"] = 31,
      ["Dough-Dough"] = 32,
      Dough = 32,
      ["Shadow-Shadow"] = 33,
      Shadow = 33,
      ["Venom-Venom"] = 34,
      Venom = 34,
      ["Control-Control"] = 35,
      Control = 35,
      ["Gas-Gas"] = 36,
      Gas = 36,
      ["Spirit-Spirit"] = 37,
      Spirit = 37,
      ["Dragon-Dragon"] = 38,
      Dragon = 38,
      ["Leopard-Leopard"] = 39,
      Leopard = 39,
      ["Yeti-Yeti"] = 40,
      Yeti = 40,
      ["Kitsune-Kitsune"] = 41,
      Kitsune = 41,
      ["Dragon (East)-Dragon (East)"] = 42,
      ["Dragon (West)-Dragon (West)"] = 43,
    }

    function v250:Checkfruit(p66)
      local backpack2 = localPlayer and localPlayer.Backpack
      local character11 = localPlayer and localPlayer.Character
      local v257 = {}

      if backpack2 then
        table.insert(v257, backpack2:GetChildren())
      end

      if character11 then
        table.insert(v257, character11:GetChildren())
      end

      for index10, value21 in ipairs(v257) do
        for key11, value22 in pairs(value21) do
          if value22:IsA("Tool") then
            if value22:FindFirstChild("EatRemote") or value22:FindFirstChild("DropRemote")
              or value22:GetAttribute("IsPhysical") or value22:GetAttribute("Fruit")
              or value22.ToolTip ~= "Blox Fruit" and string.find(value22.Name, "Fruit") then
              if p66 then
                local gsub2 = value22.Name:gsub(" Fruit$", "")
                local match = gsub2:match("^(.-)%-") or gsub2
                local match2 = gsub2:match("%-(.+)$") or gsub2
                local v258 = v256[gsub2] or v256[value22.Name] or v256[match] or v256[match2]

                if not v258 then
                  for key12, value23 in pairs(v256) do
                    if value22.Name:find(key12, 1, true) or key12:find(gsub2, 1, true) then
                      v258 = value23
                      break
                    end
                  end
                end

                if v258 and v258 >= 19 then
                  return value22.Name, value22
                end
              else
                return value22.Name, value22
              end
            end
          end
        end
      end

      return nil
    end

    function v250:EquipTool(p67)
      local backpack3 = localPlayer and localPlayer.Backpack

      if backpack3 and waitForChild and backpack3:FindFirstChild(p67) then
        waitForChild:EquipTool(backpack3[p67])
      end
    end

    function v250:EquipWeapon(p68)
      local selectWeapon = p68 or v19.SelectWeapon

      for index11, value24 in ipairs((localPlayer and localPlayer.Backpack):GetChildren()) do
        if value24 and value24:IsA("Tool") and value24.ToolTip == selectWeapon then
          self:EquipTool(value24.Name)
          return true
        end
      end
    end

    local function f55()
      local v259, v260 = pcall(function()
        return v29:RemoteFunction("GetAllItemValues"):InvokeServer()
      end)

      if not v259 or not v260 then
        return {}
      else
        local v261 = {}

        for key13, value25 in next, v260, nil do
          local v262 = tostring(value25.ItemId) .. "_" .. tostring(value25.NetworkedUID)

          v261[v262] = v261[v262]
            or { ItemId = value25.ItemId, UID = value25.NetworkedUID, Attributes = {} }

          if value25.Value ~= nil then
            v261[v262].Attributes[value25.Key] = value25.Value
          end
        end

        local v263 = {}

        for key14, value26 in next, v261, nil do
          local v264 = value26
          local v265 = nil
          local v266, v267 = pcall(function() return v30.match(v264.ItemId) end)

          if v266 and v267 and v267:isOk() then
            local unwrap = v267:unwrap()

            if unwrap and unwrap.Index and unwrap.Index.DebugLabel then
              v265 = tostring(unwrap.Index.DebugLabel)
            end
          end

          local s = v265
          s = v265 and (v265:match("^(.-)%s*%[") or v265)

          if s then
            s = s:gsub("^%-%-%s*", "")
          end

          local match3 = v265 and (v265:match("%[(.-)%]") or "") or ""

          table.insert(v263, {
            Name = s or "",
            RawName = v265 or "",
            Tag = match3,
            ItemId = v264.ItemId,
            UID = v264.UID,
            Attributes = v264.Attributes,
          })
        end

        return v263
      end
    end

    v250.GetParsedInventory = f55

    function v250:CheckInventory(p69, p70, p71)
      local v268 = f55()
      local v269 = string.lower(p70 or "")

      for index12, value27 in ipairs(v268) do
        if string.lower(value27.Name) == v269 then
          local attributes = value27.Attributes

          if p69 == "Material" then
            return attributes.Quantity or 0
          elseif p69 == "Moveset" then
            return attributes.Mastery or 0
          elseif p69 == "Mastery" then
            return (attributes.Mastery or 0) >= (p71 or 0)
          end
        end
      end

      return (p69 == "Material" or p69 == "Sword") and 0 or false
    end

    function v33:CheckInventory(p72)
      for index13, value28 in ipairs((f55())) do
        if value28.Name == p72 and value28.Attributes.IsOwned == true then
          return {
            Name = value28.Name,
            ItemId = value28.ItemId,
            UID = value28.UID,
            Quantity = value28.Attributes.Quantity,
            Mastery = value28.Attributes.Mastery,
            IsOwned = value28.Attributes.IsOwned,
            IsEquipped = value28.Attributes.IsEquipped,
            Attributes = value28.Attributes,
          }
        end
      end

      return nil
    end

    function v250:GetConnectMon(p73, p74)
      local humanoidRootPart16 = localPlayer.Character
        and localPlayer.Character:FindFirstChild("HumanoidRootPart")

      local huge4 = math.huge
      local v270 = type(p73) == "table"
      local v271 = type(p73) == "string"
      local v272

      if p74 and not humanoidRootPart16 then
        return nil
      else
        local v273 = {}

        if enemies then
          table.insert(v273, enemies)
        end

        table.insert(v273, v5)

        for key15, value29 in next, v273, nil do
          local v274 = next
          local v275, v276 = value29:GetChildren()

          for v277, v278 in v274, v275, v276 do
            local v279 = false

            if v271 then
              v279 = string.lower(v278.Name) == string.lower(p73)
            elseif v270 then
              v279 = p73[v278.Name] == true or table.find(p73, v278.Name) ~= nil

              if not v279 then
                for key16, value30 in next, p73, nil do
                  if typeof(value30) == "string"
                    and string.lower(value30) == string.lower(v278.Name) then
                    v279 = true
                    break
                  end
                end
              end
            end

            if v279 then
              local isDescendantOf2 = v278:IsDescendantOf(v4)
              local v280 = v278.Parent == v5

              local isDescendantOf3 = v280
              isDescendantOf3 = v280 or v278:IsDescendantOf(v5)

              if isDescendantOf2 and v33:IsReady(v278)
                or isDescendantOf3 and v278:FindFirstChild("HumanoidRootPart") ~= nil then
                if not p74 then
                  return v278
                end

                local humanoidRootPart17 = v278:FindFirstChild("HumanoidRootPart")

                local primaryPart4 = humanoidRootPart17
                primaryPart4 = humanoidRootPart17 or v278.PrimaryPart

                if primaryPart4 then
                  local magnitude10 = (humanoidRootPart16.Position - primaryPart4.Position).Magnitude

                  if magnitude10 < huge4 then
                    huge4 = magnitude10
                    v272 = v278
                  end
                end
              end
            end
          end
        end

        return v272
      end
    end

    function v250:CheckMon(p75)
      return self:GetConnectMon(p75) ~= nil
    end

    function v250:GetEnemies(p76)
      return self:GetConnectMon(p76, true)
    end

    v250.BringCache = {}

    local v281 = {}
    local v282 = 0
    local v283 = 0

    function v250:BringEnemies(p77)
      local v284

      if not v19.BringMonster then
        return
      else
        local humanoidRootPart18 = character and character:FindFirstChild("HumanoidRootPart")

        local humanoidRootPart19 = p77
          and (p77:FindFirstChild("HumanoidRootPart") or p77.PrimaryPart)

        if not humanoidRootPart18 or not humanoidRootPart19 then
          return
        else
          local v285 = tick()

          if v285 - v282 < 0.4 then
            return
          else
            v282 = v285
            local v286 = tonumber(v19.BringMonsterRadius) or 350
            v284 = math.clamp(v286 + 50, 100, 500)

            if v285 - v283 > 3 then
              v283 = v285
              pcall(function() sethiddenproperty(localPlayer, "SimulationRadius", v284) end)
            end

            v250.BringCache[p77.Name] = humanoidRootPart19.CFrame
            local count3 = 0

            for key17 in pairs(v281) do
              local v287 = key17
              local humanoid9 = v287.Parent and v287:FindFirstChildOfClass("Humanoid")

              if not v287.Parent or not humanoid9 or humanoid9.Health <= 0 then
                v281[v287] = nil
                pcall(function() v287:RemoveTag("QuantumBringTag") end)
              else
                count3 = count3 + 1
              end
            end

            if count3 >= 6 then
              return
            else
              local v288 = {}

              for index14, value31 in ipairs(v3:GetPlayers()) do
                if value31 ~= localPlayer then
                  local character12 = value31.Character

                  local humanoidRootPart20 = character12

                  humanoidRootPart20 = character12
                    and (character12:FindFirstChild("HumanoidRootPart")
                      or character12.PrimaryPart)

                  if humanoidRootPart20 then
                    table.insert(v288, humanoidRootPart20.Position)
                  end
                end
              end

              local enemies2 = enemies or v4:FindFirstChild("Enemies")

              if not enemies2 then
                return
              else
                local count4 = 0
                local position22 = humanoidRootPart19.Position
                local position23 = humanoidRootPart18.Position
                local getChildren13 = enemies2:GetChildren()

                for i24 = 1, #getChildren13 do
                  local v289 = getChildren13[i24]

                  if v289 ~= p77 and v289.Name == p77.Name and not v281[v289]
                    and not v289:HasTag("QuantumBringTag") and v33:IsReady(v289) then
                    local humanoidRootPart21 = v289:FindFirstChild("HumanoidRootPart")
                      or v289.PrimaryPart

                    if humanoidRootPart21 then
                      local position24 = humanoidRootPart21.Position

                      if (position24 - position22).Magnitude <= v286
                        and (position24 - position23).Magnitude <= v286 then
                        local v290 = false

                        for i25 = 1, #v288 do
                          if (position24 - v288[i25]).Magnitude <= 55 then
                            v290 = true
                            break
                          end
                        end

                        if not v290 then
                          v281[v289] = true
                          v289:AddTag("QuantumBringTag")
                          count4 = count4 + 1

                          if count4 >= 3 or count3 + count4 >= 6 then
                            break
                          end
                        end
                      end
                    end
                  end
                end

                return
              end
            end
          end
        end
      end
    end

    v6:GetInstanceAddedSignal("QuantumBringTag"):Connect(function(p78)
      spawn(function()
        local humanoidRootPart22 = p78:FindFirstChild("HumanoidRootPart") or p78.PrimaryPart
        local v291 = not humanoidRootPart22
        local humanoid10 = p78:FindFirstChildOfClass("Humanoid")
        local v292 = v291 or not humanoid10
        local bringBodyPos, v293

        if v292 then
          v281[p78] = nil
          pcall(function() p78:RemoveTag("QuantumBringTag") end)
          return
        else
          local name3 = p78.Name
          bringBodyPos = humanoidRootPart22:FindFirstChild("BringBodyPos")

          if not bringBodyPos then
            bringBodyPos = Instance.new("BodyPosition")
            bringBodyPos.Name = "BringBodyPos"
            bringBodyPos.MaxForce = Vector3.new(1000000, 1000000, 1000000)
            bringBodyPos.P = 8000
            bringBodyPos.D = 600
            bringBodyPos.Position = humanoidRootPart22.Position
            bringBodyPos.Parent = humanoidRootPart22
          end

          v293 = {}

          for index15, value32 in ipairs(p78:GetChildren()) do
            if value32:IsA("BasePart") then
              value32.CanCollide = false
              table.insert(v293, value32)
            end
          end

          local v294 = tick() + 25
          local v295 = 0
          local v296 = 0

          while v19.BringMonster and p78.Parent and humanoidRootPart22.Parent
            and humanoid10.Health > 0 and p78:HasTag("QuantumBringTag") and tick() < v294 do
            local v297 = tick()
            local character13 = localPlayer.Character

            local humanoidRootPart23 = character13
            humanoidRootPart23 = character13 and character13:FindFirstChild("HumanoidRootPart")

            local bringCache = v250.BringCache and v250.BringCache[name3]
            local v298 = tonumber(v19.BringMonsterRadius) or 350

            if humanoidRootPart23 and bringCache then
              local position25 = typeof(bringCache) == "CFrame" and bringCache.Position
                or bringCache

              if (humanoidRootPart23.Position - humanoidRootPart22.Position).Magnitude
                <= v298 + 50 then
                v295 = 0

                if v297 - v296 > 1 then
                  v296 = v297

                  for i26 = 1, #v293 do
                    local v299 = v293[i26]

                    if v299.Parent and v299.CanCollide then
                      v299.CanCollide = false
                    end
                  end
                end

                if (bringBodyPos.Position - position25).Magnitude > 0.5 then
                  bringBodyPos.Position = position25
                end
              else
                v295 = v295 + 1
              end
            else
              v295 = v295 + 1
            end

            if v295 > 15 then
              break
            end

            task.wait(0.1)
          end

          v281[p78] = nil

          pcall(function()
            if bringBodyPos and bringBodyPos.Parent then
              bringBodyPos:Destroy()
            end

            if p78:HasTag("QuantumBringTag") then
              p78:RemoveTag("QuantumBringTag")
            end

            for i27 = 1, #v293 do
              local v300 = v293[i27]

              if v300.Parent then
                v300.CanCollide = true
              end
            end
          end)

          return
        end
      end)
    end)

    function v250:MobsNextSpawn(p79)
      if v250.NextSpawnCooldown[p79] then
        return task.wait()
      else
        v250.NextSpawnCooldown[p79] = true
        task.wait(1)

        if not v250.SpawnCache[p79] then
          local v301, v302 = v5:FindFirstChild("FortBuilderReplicatedSpawnPositionsFolder"):GetChildren()

          for key18, value33 in next, v301, v302 do
            if value33:IsA("BasePart") then
              local spawnCache = v250.SpawnCache
              local name4 = value33.Name
              spawnCache[name4] = v250.SpawnCache[value33.Name] or {}
              table.insert(v250.SpawnCache[value33.Name], value33.CFrame)
            end
          end
        end

        local v303 = v250.SpawnCache[p79]

        if not v303 or #v303 == 0 then
          v250.NextSpawnCooldown[p79] = nil
          return
        end

        v250.MobCycle[p79] = (v250.MobCycle[p79] or 0) % #v303 + 1

        tweenManager:topos(CFrame.new(v303[v250.MobCycle[p79]].Position
          + Vector3.new(0, math.max(tonumber(v19.PosY) or 15, 1), 0)))

        task.delay(1, function() v250.NextSpawnCooldown[p79] = nil end)
        return self:GetEnemies({ p79 })
      end
    end

    function v250:StartQuest(p80, p81, p82)
      if v19.BypassGetQuest then
        commF:InvokeServer("StartQuest", p80, p81)
        task.wait(0.3)
        return
      else
        local character14 = localPlayer.Character

        if character14 and character14:FindFirstChild("HumanoidRootPart")
          and self:GetDistance(p82) <= 25 then
          commF:InvokeServer("StartQuest", p80, p81)
          task.wait(0.5)
        else
          tweenManager:topos(p82)
        end

        return
      end
    end

    function v250:ServerHop(p83)
      v37.ServerHop(p83)
    end

    function v250.Rejoin(p84)
      v37.Rejoin()
    end

    function v250:GetLowestFruit(p85)
      local v304 = require(v5.Modules.Net)

      local v305, v306 = pcall(function()
        return v304:RemoteFunction("GetAllItemValues"):InvokeServer()
      end)

      if not v305 or not v306 or type(v306) ~= "table" then
        return nil
      else
        local v307 = {}

        for index16, value34 in ipairs(v306) do
          if value34.Key == "IsOwned" and value34.Value == true then
            v307[value34.ItemId] = true
          end
        end

        local v308 = nil
        local huge5 = math.huge

        for key19 in pairs(v307) do
          local v309 = key19
          local v310, v311 = pcall(function() return v30.match(v309) end)

          if v310 and v311 and v311.isOk and v311:isOk() then
            local unwrap2 = v311:unwrap()

            if unwrap2 and unwrap2.Index and unwrap2.Index.IdType == "PhysicalMoveset" then
              local v312 = tostring(unwrap2.Index.DebugLabel or unwrap2.Index.Name or "")
              local s2 = v312:match("^(.-)%s*%[") or v312
              local v313 = tostring(unwrap2.Index.StorageKey or s2)
              local match4 = s2:match("^(.-)%-") or s2
              local match5 = s2:match("%-(.+)$") or s2
              local v314 = v256[s2] or v256[v313] or v256[match4] or v256[match5]

              if not v314 then
                for key20, value35 in pairs(v256) do
                  if s2:find(key20, 1, true) or key20:find(s2, 1, true)
                    or v313:find(key20, 1, true) then
                    v314 = value35
                    break
                  end
                end
              end

              if v314 then
                if (p85 and v314 >= 19 or not p85 and v314 <= 18) and v314 < huge5 then
                  huge5 = v314

                  v308 = {
                    Name = s2,
                    RawName = s2,
                    StorageKey = v313,
                    ItemId = v309,
                    Rank = v314,
                  }
                end
              end
            end
          end
        end

        return v308
      end
    end

    function v250:ClickButton(p86)
      if not p86 then
        return
      end

      if firesignal then
        pcall(firesignal, p86.MouseButton1Click)
        pcall(firesignal, p86.Activated)
        pcall(firesignal, p86.MouseButton1Down)
        pcall(firesignal, p86.MouseButton1Up)
      end

      pcall(function()
        local v315 = p86.AbsolutePosition + p86.AbsoluteSize / 2 + guiService:GetGuiInset()
        virtualInputManager:SendMouseButtonEvent(v315.X, v315.Y, 0, true, game, 1)
        task.wait(0.05)
        virtualInputManager:SendMouseButtonEvent(v315.X, v315.Y, 0, false, game, 1)
      end)
    end

    return v250
  end

  v33.Utilities = f54()
  utilities = v33.Utilities

  function f12(p87)
    if not p87 then
      return ""
    else
      local v316 = string.gsub(string.gsub(string.gsub(string.gsub(
        string.lower(tostring(p87)), "%-", " "
      ), "^the%s+", ""), "men$", "man"), "ies$", "y")

      if string.sub(v316, -1) == "s" and string.sub(v316, -2) ~= "ss" then
        v316 = string.sub(v316, 1, -2)
      end

      return string.match(v316, "^%s*(.-)%s*$") or ""
    end
  end

  function f13(p88, p89)
    if not p88 or not p89 then
      return false
    else
      local v317 = f12(p88)
      local v318 = v317 == ""
      local v319 = f12(p89)

      if v318 or v319 == "" then
        return false
      elseif v317 == v319 then
        return true
      else
        return string.find(v317, v319, 1, true) ~= nil
          or string.find(v319, v317, 1, true) ~= nil
      end
    end
  end

  function HasActiveQuest()
    if v27 and v27.Data and v27.Data.QuestData then
      return true
    else
      local playerGui2 = localPlayer and localPlayer:FindFirstChild("PlayerGui")

      if not playerGui2 then
        return false
      else
        local main2 = playerGui2:FindFirstChild("Main")

        if main2 then
          local quest = main2:FindFirstChild("Quest")

          if quest and quest.Visible then
            return true
          end
        end

        local trackedQuestFrame = playerGui2:FindFirstChild("TrackedQuestFrame")

        if trackedQuestFrame and trackedQuestFrame.Enabled then
          local frame = trackedQuestFrame:FindFirstChild("Frame")

          if frame and frame.Visible then
            local description = frame:FindFirstChild("description")

            if description and description.Text and description.Text ~= "" then
              return true
            else
              local header = frame:FindFirstChild("header")
              local textLabel = header and header:FindFirstChild("textLabel")

              if textLabel and textLabel.Text and textLabel.Text ~= "" then
                return true
              end

              return false
            end
          else
            return false
          end
        else
          return false
        end
      end
    end
  end

  function f14(p90)
    if not p90 or p90 == "" then
      return nil
    else
      local v320 = string.match(string.gsub(string.gsub(string.gsub(
        string.gsub(p90, "%s*%b()", ""), "^.-:%s*", ""
      ), "^[Dd]efeat%s*", ""), "^%d+%s*", ""), "^%s*(.-)%s*$")

      if v320 and v320 ~= "" then
        return v320:gsub("^%l", string.upper)
      end

      return nil
    end
  end

  function GetActiveQuest()
    if v27 and v27.Data and v27.Data.QuestData then
      local questData = v27.Data.QuestData

      if questData.Task then
        local v321 = next(questData.Task, nil)

        if v321 then
          return tostring(v321)
        end
      end

      if questData.Name then
        return tostring(questData.Name)
      end
    end

    local playerGui3 = localPlayer and localPlayer:FindFirstChild("PlayerGui")

    if not playerGui3 then
      return nil
    else
      local main3 = playerGui3:FindFirstChild("Main")

      if main3 then
        local quest2 = main3:FindFirstChild("Quest")

        if quest2 and quest2.Visible then
          local container2 = quest2:FindFirstChild("Container")

          local questTitle = container2
          questTitle = container2 and container2:FindFirstChild("QuestTitle")

          local title = questTitle
          title = questTitle and questTitle:FindFirstChild("Title")

          if title and title.Text then
            local v322 = f14(title.Text)

            if v322 then
              return v322
            end
          end
        end
      end

      local trackedQuestFrame2 = playerGui3:FindFirstChild("TrackedQuestFrame")

      if trackedQuestFrame2 and trackedQuestFrame2.Enabled then
        local frame2 = trackedQuestFrame2:FindFirstChild("Frame")

        if frame2 and frame2.Visible then
          local description2 = frame2:FindFirstChild("description")

          if description2 and description2.Text and description2.Text ~= "" then
            local v323 = f14(description2.Text)

            if v323 then
              return v323
            end
          end

          local header2 = frame2:FindFirstChild("header")

          local textLabel2 = header2
          textLabel2 = header2 and header2:FindFirstChild("textLabel")

          if textLabel2 and textLabel2.Text and textLabel2.Text ~= "" then
            local v324 = f14(textLabel2.Text)

            if v324 then
              return v324
            end

            return nil
          end

          return nil
        end

        return nil
      end

      return nil
    end
  end

  function VerifyQuest(p91)
    if not p91 then
      return false
    elseif not HasActiveQuest() then
      return false
    else
      local v325 = GetActiveQuest()

      if not v325 then
        return false
      elseif type(p91) == "table" then
        for index17, value36 in ipairs(p91) do
          if f13(value36, v325) then
            return true
          end
        end

        return false
      elseif f13(p91, v325) then
        return true
      else
        local playerGui4 = localPlayer and localPlayer:FindFirstChild("PlayerGui")

        local main4 = playerGui4
        main4 = playerGui4 and playerGui4:FindFirstChild("Main")

        local quest3 = main4
        quest3 = main4 and main4:FindFirstChild("Quest")

        if quest3 and quest3.Visible then
          local container3 = quest3:FindFirstChild("Container")

          local questTitle2 = container3
          questTitle2 = container3 and container3:FindFirstChild("QuestTitle")

          local title2 = questTitle2
          title2 = questTitle2 and questTitle2:FindFirstChild("Title")

          if title2 and title2.Text
            and string.find(string.lower(title2.Text), string.lower(tostring(p91)), 1, true) then
            return true
          end
        end

        local trackedQuestFrame3 = playerGui4
        trackedQuestFrame3 = playerGui4 and playerGui4:FindFirstChild("TrackedQuestFrame")

        if trackedQuestFrame3 and trackedQuestFrame3.Enabled then
          local frame3 = trackedQuestFrame3:FindFirstChild("Frame")

          if frame3 and frame3.Visible then
            local header3 = frame3:FindFirstChild("header")

            local textLabel3 = header3
            textLabel3 = header3 and header3:FindFirstChild("textLabel")

            if textLabel3
              and textLabel3.Text
              and string.find(
                string.lower(textLabel3.Text), string.lower(tostring(p91)), 1, true
              ) then
              return true
            else
              local description3 = frame3:FindFirstChild("description")

              if description3 and description3.Text and string.find(
                string.lower(description3.Text), string.lower(tostring(p91)), 1, true
              ) then
                return true
              end

              return false
            end
          else
            return false
          end
        else
          return false
        end
      end
    end
  end

  function CheckQuest()
    local value37 = level.Value

    if v24 and value37 >= 1 and value37 <= 9 then
      local v326 = tostring(localPlayer.Team)

      if v326 == "Marines" then
        return { "Trainee", "MarineQuest", 1, value37 }
      elseif v326 == "Pirates" then
        return { "Bandit", "BanditQuest1", 1, value37 }
      end
    end

    local sea1 = v24 and quests.Sea_1 or v25 and quests.Sea_2 or v26 and quests.Sea_3

    if sea1 then
      for index18, value38 in ipairs(sea1) do
        if value37 >= value38[1] and value37 <= value38[2] then
          if type(value38[6]) == "table" then
            for i28 = #value38 - 1, 6, -1 do
              local v327 = value38[i28]

              if utilities:CheckMon(v327[1]) and value37 >= v327[2] then
                return { v327[1], v327[3], v327[4], value37 }
              end
            end

            return { value38[3], value38[4], value38[5], value37 }
          end

          if value38[6] and utilities:CheckMon(value38[6]) and value37 >= value38[7] then
            return { value38[6], value38[4], value38[5] + 1, value37 }
          end

          return { value38[3], value38[4], value38[5], value37 }
        end
      end

      return { "", "", 0, value37 }
    end

    return { "", "", 0, value37 }
  end

  function CheckBoss(p92)
    local sea3 = v26 and bossList.Sea_3 or v25 and bossList.Sea_2 or v24 and bossList.Sea_1

    if not sea3 then
      return nil
    end

    for key21, value39 in next, sea3, nil do
      if value39[2] == p92 then
        return value39
      end
    end

    return nil
  end

  function v33:SendNotify(title3, description4, p93, buttons, id)
    pcall(function()
      if devNiulaiLua and devNiulaiLua.Notification and devNiulaiLua.Notification.Notify then
        devNiulaiLua.Notification:Notify({
          Title = title3,
          Description = description4,
          Buttons = buttons,
          Id = id,
        }, { Time = p93 or 5 })
      end
    end)
  end

  function NPCPos(p94, p95)
    local value40 = level and level.Value or 1

    local function f56(p96, p97)
      if typeof(p96) == "Instance" then
        if p96:IsA("BasePart") then
          return p96.CFrame
        elseif p96:IsA("Model") then
          return p96:GetPivot()
        end
      elseif typeof(p96) == "CFrame" then
        return p96
      elseif typeof(p96) == "Vector3" then
        return CFrame.new(p96)
      end

      if p97 and type(p97) == "table" then
        if p97.CFrame and typeof(p97.CFrame) == "CFrame" then
          return p97.CFrame
        end

        if p97.Position and typeof(p97.Position) == "Vector3" then
          return CFrame.new(p97.Position)
        end

        if p97.Position and typeof(p97.Position) == "CFrame" then
          return p97.Position
        end

        return nil
      end

      return nil
    end

    if v27 and v27.Data and v27.Data.NPCList then
      pcall(function()
        if v27.ChangeQuest and p95 then
          v27.ChangeQuest(p95)
        end
      end)

      if p95 then
        for key22, value41 in next, v27.Data.NPCList, nil do
          if value41 and value41.InternalQuestName
            and string.lower(value41.InternalQuestName) == string.lower(p95) then
            local v328 = f56(key22, value41)

            if v328 then
              return v328
            end
          end
        end
      end

      for key23, value42 in next, v27.Data.NPCList, nil do
        if value42 and value42.Levels and table.find(value42.Levels, value40) then
          local v329 = f56(key23, value42)

          if v329 then
            return v329
          end
        end
      end

      local lower2 = p95 and p95:gsub("Quest.*", ""):gsub("%d+", ""):lower() or ""
      local lower3 = p94 and p94:match("^(%a+)") and p94:match("^(%a+)"):lower() or ""

      for key24, value43 in next, v27.Data.NPCList, nil do
        if value43 and type(value43) == "table" then
          local lower4 = tostring(value43.NPCName or ""):lower()
          local lower5 = tostring(value43.InternalQuestName or ""):lower()

          if lower2 ~= "" and (lower4:find(lower2, 1, true) or lower5:find(lower2, 1, true))
            or lower3 ~= "" and #lower3 >= 4 and lower4:find(lower3, 1, true) then
            local v330 = f56(key24, value43)

            if v330 then
              return v330
            end
          end
        end
      end

      local lastClosestNPC = v27.Data.LastClosestNPC

      if lastClosestNPC then
        for key25, value44 in next, v27.Data.NPCList, nil do
          if value44 and value44.NPCName == lastClosestNPC then
            local v331 = f56(key25, value44)

            if v331 then
              return v331
            end
          end
        end
      end
    end

    local f57

    function f57(p98)
      if not p98 then
        return nil
      else
        local lower6 = p95 and p95:gsub("Quest.*", ""):gsub("%d+", ""):lower() or ""
        local lower7 = p94 and p94:match("^(%a+)") and p94:match("^(%a+)"):lower() or ""
        local v332, v333 = p98:GetChildren()

        for key26, value45 in next, v332, v333 do
          local lower8 = value45.Name:lower()
          local v334 = false

          if lower6 ~= "" and lower8:find(lower6, 1, true)
            and (lower8:find("quest") or lower8:find("giver")) then
            v334 = true
          elseif lower7 ~= "" and #lower7 >= 4 and lower8:find(lower7, 1, true) then
            v334 = true
          elseif lower8:find("quest") and p95 and lower8:find(p95:lower():gsub("quest.*", "")) then
            v334 = true
          end

          if v334 then
            local humanoidRootPart24 = value45:FindFirstChild("HumanoidRootPart")
              or value45.PrimaryPart

            if humanoidRootPart24 then
              return humanoidRootPart24.CFrame
            end

            return value45:GetPivot()
          end
        end

        return nil
      end
    end

    local v335 = f57(v4:FindFirstChild("NPCs")) or f57(v5:FindFirstChild("NPCs"))

    if v335 then
      return v335
    end

    if p94 then
      if not utilities.SpawnCache or not utilities.SpawnCache[p94] then
        local fortBuilderReplicatedSpawnPositionsFolder = v5:FindFirstChild("FortBuilderReplicatedSpawnPositionsFolder")

        if fortBuilderReplicatedSpawnPositionsFolder then
          local v336 = next
          local v337, v338 = fortBuilderReplicatedSpawnPositionsFolder:GetChildren()

          for v339, v340 in v336, v337, v338 do
            if v340:IsA("BasePart") then
              utilities.SpawnCache = utilities.SpawnCache or {}
              local spawnCache2 = utilities.SpawnCache
              local name5 = v340.Name
              spawnCache2[name5] = utilities.SpawnCache[v340.Name] or {}
              table.insert(utilities.SpawnCache[v340.Name], v340.CFrame)
            end
          end
        end
      end

      local spawnCache3 = utilities.SpawnCache and utilities.SpawnCache[p94]

      if spawnCache3 and #spawnCache3 > 0 then
        return spawnCache3[1]
      end
    end

    if p94 then
      local getEnemies = utilities:GetEnemies(p94)

      local humanoidRootPart25 = getEnemies

      humanoidRootPart25 = getEnemies
        and (getEnemies:FindFirstChild("HumanoidRootPart") or getEnemies.PrimaryPart)

      if humanoidRootPart25 then
        return humanoidRootPart25.CFrame
      end

      return nil
    end

    return nil
  end

  function GetQuest()
    local v341 = CheckQuest()

    if not v341 or not v341[2] or v341[2] == "" then
      return
    else
      local v342 = v341[1]
      local v343 = v341[2]
      local v344 = v341[3]

      if HasActiveQuest() then
        if VerifyQuest(v342) then
          return
        end

        pcall(function() commF:InvokeServer("AbandonQuest") end)
        task.wait(0.2)
      end

      if v19.BypassGetQuest then
        commF:InvokeServer("StartQuest", v343, v344)

        if v19.QuestDebounce then
          tick()
        end

        task.wait(0.3)

        if v19.AutoSetSpawnPoint then
          commF:InvokeServer("SetSpawnPoint")
        end

        return
      else
        local v345 = NPCPos(v342, v343)

        if not v345 then
          return
        end

        if utilities:GetDistance(v345) <= 25 then
          commF:InvokeServer("StartQuest", v343, v344)

          if v19.QuestDebounce then
            tick()
          end

          task.wait(0.3)
        elseif localPlayer.Character
          and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
          local position26 = localPlayer.Character.HumanoidRootPart.Position
          local position27 = typeof(v345) == "CFrame" and v345.Position

          local position28 = position27
          position28 = position27 or typeof(v345) == "Vector3" and v345 or v345.Position

          local zero = (position28 - position26).Magnitude > 5
              and (position28 - position26).Unit * 5
            or Vector3.zero

          tweenManager:topos(CFrame.new(position28 - zero))
        else
          tweenManager:topos(v345)
        end

        if v19.AutoSetSpawnPoint then
          commF:InvokeServer("SetSpawnPoint")
        end

        return
      end
    end
  end

  function f15(p99)
    if not (p99 and p99.Parent) then
      return nil
    else
      local proximity = p99:FindFirstChild("Proximity")

      if proximity then
        if proximity:IsA("BasePart") then
          return proximity.Position
        elseif proximity:IsA("Attachment") then
          return proximity.WorldPosition
        elseif proximity:IsA("Model") then
          return proximity:GetPivot().Position
        elseif p99:IsA("BasePart") then
          return p99.Position
        else
          if p99:IsA("Model") then
            return p99:GetPivot().Position
          end

          return nil
        end
      elseif p99:IsA("BasePart") then
        return p99.Position
      else
        if p99:IsA("Model") then
          return p99:GetPivot().Position
        end

        return nil
      end
    end
  end

  function v33:IsHalloweenEventRunning()
    local v346 = workspace:GetAttribute("HalloweenEventActive") == true
      or workspace:GetAttribute("HalloweenActive") == true
      or workspace:GetAttribute("HalloweenEvent") == true
      or workspace:GetAttribute("DapperJackActive") == true
      or workspace:GetAttribute("HalloweenJackMoon") ~= nil

    local ghostChase, dapperJackGateway

    if v346 then
      return true
    elseif replicatedStorage:GetAttribute("HalloweenEventActive") == true
      or replicatedStorage:GetAttribute("HalloweenActive") == true then
      return true
    elseif lighting:GetAttribute("HalloweenEventActive") == true
      or lighting:GetAttribute("HalloweenJackMoon") ~= nil then
      return true
    else
      local enemies3 = workspace:FindFirstChild("Enemies")

      if enemies3 then
        for index19, value46 in ipairs(enemies3:GetChildren()) do
          if (value46.Name == "Unbound Werewolf" or value46.Name == "Jack o' Lantern"
              or value46.Name == "Dapper Jack" or value46.Name == "Hellfire Gas")
            and value46:FindFirstChild("Humanoid")
            and value46.Humanoid.Health > 0 then
            return true
          end
        end

        ghostChase = workspace:FindFirstChild("GhostChase")

        dapperJackGateway = ghostChase
        dapperJackGateway = ghostChase or workspace:FindFirstChild("DapperJackGateway")

        if dapperJackGateway then
          return true
        end

        return false
      end

      ghostChase = workspace:FindFirstChild("GhostChase")

      dapperJackGateway = ghostChase
      dapperJackGateway = ghostChase or workspace:FindFirstChild("DapperJackGateway")

      if dapperJackGateway then
        return true
      end

      return false
    end
  end

  v39 = {}
  v40 = 0

  function v33:GetHalloweenDoors()
    local getServerTimeNow = workspace:GetServerTimeNow()
    v33.SkippedDoors = v33.SkippedDoors or {}
    local v347 = os.clock()
    local v348, v349, f58

    if #v39 == 0 or v347 - v40 > 8 then
      v40 = v347
      v348 = {}
      v349 = {}

      function f58(p100)
        if not (p100 and p100.Parent and not v349[p100]) then
          return false
        else
          local name6 = p100.Name

          if name6 == "HalloweenDoor" or name6 == "Halloween_Door" or name6 == "EventDoor" then
            return true
          end

          if p100:GetAttribute("CooldownUntil") ~= nil or p100:GetAttribute("DoorOpen") ~= nil
            or p100:GetAttribute("DoorShut") ~= nil or p100:GetAttribute("DoorBusy") ~= nil then
            return true
          else
            local proximity2 = p100:FindFirstChild("Proximity")

            if proximity2
              and (name6:find("Door")
                or proximity2:FindFirstChildWhichIsA("ProximityPrompt", true)) then
              return true
            end

            return false
          end
        end
      end

      local function f59(p101)
        if p101 and not v349[p101] and f58(p101) then
          v349[p101] = true
          table.insert(v348, p101)
        end
      end

      for index20, value47 in ipairs({
        "Halloween Event", "HalloweenDoor", "Halloween Doors", "Halloween", "HalloweenDoors",
      }) do
        for index21, value48 in ipairs(collectionService:GetTagged(value47)) do
          if f58(value48) then
            f59(value48)
          elseif value48 and value48:IsA("Instance") then
            for index22, value49 in ipairs(value48:GetDescendants()) do
              if f58(value49) then
                f59(value49)
              end
            end
          end
        end
      end

      local map3 = workspace:FindFirstChild("Map")

      if map3 then
        for index23, value50 in ipairs(map3:GetDescendants()) do
          if f58(value50) then
            f59(value50)
          end
        end
      end

      if #v348 == 0 then
        for index24, value51 in ipairs(workspace:GetChildren()) do
          if value51.Name:find("Halloween") or value51.Name:find("Hotel")
            or value51.Name:find("Town") or value51.Name:find("Haunted")
            or value51.Name == "Turtle" then
            for index25, value52 in ipairs(value51:GetDescendants()) do
              if f58(value52) then
                f59(value52)
              end
            end
          end
        end
      end

      if #v348 > 0 then
        v39 = v348
      end
    end

    local v350 = {}
    local v351 = {}
    local v352 = {}

    for index26, value53 in ipairs(v39) do
      if value53 and value53.Parent then
        table.insert(v350, value53)
        local v353 = value53:GetAttribute("DoorOpen") == true

        if v353 then
          table.insert(v352, value53)
        end

        local cooldownUntil = value53:GetAttribute("CooldownUntil")
        local v354 = typeof(cooldownUntil) == "number" and getServerTimeNow < cooldownUntil
        local v355 = v33.SkippedDoors[value53]
        local v356 = typeof(v355) == "number" and getServerTimeNow < v355

        local v357 = value53:GetAttribute("DoorBusy") == true
          or value53:GetAttribute("Busy") == true or value53:GetAttribute("Interacting") == true
          or value53:GetAttribute("InUse") == true

        if not v353 and not v354 and not v356 and not v357 then
          table.insert(v351, value53)
        end
      end
    end

    local position29 = localPlayer.Character
      and localPlayer.Character:FindFirstChild("HumanoidRootPart")
      and localPlayer.Character.HumanoidRootPart.Position

    if position29 and #v351 > 1 then
      table.sort(v351, function(p102, p103)
        local position30 = f15(p102) or p102:GetPivot().Position
        local position31 = f15(p103) or p103:GetPivot().Position
        return (position30 - position29).Magnitude < (position31 - position29).Magnitude
      end)
    end

    if position29 and #v352 > 1 then
      table.sort(v352, function(p104, p105)
        local position32 = f15(p104) or p104:GetPivot().Position
        local position33 = f15(p105) or p105:GetPivot().Position
        return (position32 - position29).Magnitude < (position33 - position29).Magnitude
      end)
    end

    return v351, v350, v352
  end

  function v33:GetPumpkins()
    local v358 = {}
    local pumpkinHunt = workspace:FindFirstChild("PumpkinHunt")

    if not pumpkinHunt then
      return v358
    end

    local position34 = localPlayer.Character
      and localPlayer.Character:FindFirstChild("HumanoidRootPart")
      and localPlayer.Character.HumanoidRootPart.Position

    for index27, value54 in ipairs(pumpkinHunt:GetChildren()) do
      if value54 and value54.Parent then
        local pumpkinPatch = value54.Name == "PumpkinPatch" or value54.Name:find("PumpkinPatch")
          or value54.Name:find("Cursed") or value54:GetAttribute("Cursed") == true

        if pumpkinPatch
          or not pumpkinPatch and (value54.Name == "Pumpkin" or value54.Name:find("Pumpkin")) then
          local pumpkinState = value54:GetAttribute("PumpkinState")

          if pumpkinState == nil or pumpkinState == "Idle" or pumpkinState == "Hit" then
            v358[#v358 + 1] = value54
          end
        end
      end
    end

    if position34 and #v358 > 1 then
      table.sort(v358, function(p106, p107)
        return (p106:GetPivot().Position - position34).Magnitude
          < (p107:GetPivot().Position - position34).Magnitude
      end)
    end

    return v358
  end

  function f2()
    if not localPlayer.Character then
      return "None"
    else
      local tool6 = localPlayer.Character:FindFirstChildOfClass("Tool")

      if tool6 then
        return tool6.Name .. " (" .. (tool6.ToolTip ~= "" and tool6.ToolTip or "Weapon") .. ")"
      end

      return "None"
    end
  end

  function f3()
    if not v19.AutoSkills then
      return
    elseif not waitForChild then
      return
    else
      local selectSkills = v19.SelectSkills

      for key27, value55 in next, type(selectSkills) == "table" and selectSkills or { selectSkills }, nil do
        local v359 = v41[value55]

        if v359 then
          local character15 = localPlayer.Character

          local tool7 = character15
          tool7 = character15 and character15:FindFirstChildWhichIsA("Tool")

          if not tool7 or tool7.ToolTip ~= v359.tooltip then
            local v360 = next
            local v361, v362 = localPlayer.Backpack:GetChildren()

            for v363, v364 in v360, v361, v362 do
              if v364:IsA("Tool") and v364.ToolTip == v359.tooltip then
                waitForChild:EquipTool(v364)
                task.wait(0.5)
                break
              end
            end
          end

          local v365 = (v19[v359.delay] or 300) / 1000
          local v366 = v19[v359.keys]

          for key28, value56 in next, type(v366) == "table" and v366 or { v366 }, nil do
            local v367 = typeof(value56) == "EnumItem" and value56 or Enum.KeyCode[value56]

            if v367 then
              local v368 = (v19["HoldTime_"
                    .. (typeof(value56) == "EnumItem" and value56.Name or tostring(value56))]
                  or 0)
                / 1000

              v9:SendKeyEvent(true, v367, false, game)

              if v368 > 0 then
                task.wait(v368)
              else
                task.wait()
              end

              v9:SendKeyEvent(false, v367, false, game)
              task.wait(v365)
            end
          end
        end
      end

      return
    end
  end

  function f4(p108)
    local v369 = math.floor(p108 % 60)
    local v370 = math.floor(p108 / 60 % 60)
    return string.format("%02d:%02d:%02d", math.floor(p108 / 3600), v370, v369)
  end

  v41 = {
    ["Blox Fruit"] = {
      tooltip = "Blox Fruit",
      keys = "BloxFruitKeys",
      delay = "BloxFruitDelay",
    },
    Melee = { tooltip = "Melee", keys = "MeleeKeys", delay = "MeleeDelay" },
    Sword = { tooltip = "Sword", keys = "SwordKeys", delay = "SwordDelay" },
    Gun = { tooltip = "Gun", keys = "GunKeys", delay = "GunDelay" },
  }

  function checkv3boss()
    return utilities:CheckMon("Diamond") or utilities:CheckMon("Orbitus")
      or utilities:CheckMon("Jeremy")
  end

  function EquipSword(p109)
    if not localPlayer.Character:FindFirstChild(p109) then
      commF:InvokeServer("LoadItem", p109)
    end
  end

  function PostWebhook(p110, p111)
    if not p110 or p110 == "" or typeof(p110) ~= "string" or not p110:find("http") then
      return
    end

    spawn(function()
      pcall(function()
        f9({
          Url = p110,
          Method = "POST",
          Headers = { ["Content-Type"] = "application/json" },
          Body = typeof(p111) == "table" and v10:JSONEncode(p111) or tostring(p111),
        })
      end)
    end)
  end

  function WeeboLogs(p112, p113)
    local v371 = p113 or {}
    local v372 = ">>> **User:** " .. localPlayer.Name .. "\n**Event:** " .. p112

    if v371.Position then
      v372 = v372 .. "\n**Distance:** "
        .. math.floor(localPlayer:DistanceFromCharacter(v371.Position)) .. "m"
    end

    if v371.Extra then
      v372 = v372 .. "\n" .. v371.Extra
    end

    local v373 = { { name = "Event Details", value = v372, inline = true } }

    if v371.Field2 then
      table.insert(v373, {
        name = v371.Field2.name or "Info",
        value = [[
```
]] .. tostring(v371.Field2.value) .. "\n```",
        inline = false,
      })
    end

    local webhookPingId = v19 and v19.WebhookPingId and v19.WebhookPingId ~= ""
    local content2

    if webhookPingId then
      if v19.WebhookPingOnEvents
        and (p112:find("Mirage") or p112:find("Kitsune") or p112:find("Prehistoric")) then
        content2 = "<@" .. v19.WebhookPingId .. ">"
      else
        if v19.WebhookPingOnMythical
          and (tostring(v371.Extra):find("Dragon") or tostring(v371.Extra):find("Kitsune")
            or tostring(v371.Extra):find("Leopard") or tostring(v371.Extra):find("T-Rex")
            or tostring(v371.Extra):find("Mammoth") or tostring(v371.Extra):find("Dough")) then
          content2 = "<@" .. v19.WebhookPingId .. ">"
        end
      end
    end

    return {
      content = content2,
      embeds = {
        {
          type = "rich",
          color = 8202738,
          fields = v373,
          thumbnail = {
            url = "https://cdn.discordapp.com/attachments/1262751352791236620/1505931000948068513/Screenshot_2026-04-18_235959.png?ex=6a0c6b09&is=6a0b1989&hm=f43a97cbb0b52c83e79ef0247dac0e986d46d7455506a50e106993d36c1dea4b&",
          },
          timestamp = DateTime.now():ToIsoDate(),
        },
      },
    }
  end

  function f7(p114)
    local v374, v375, v376 = string.match(tostring(p114), "^([^%d]*%d)(%d*)(.-)$")

    if not v374 then
      return tostring(p114)
    end

    return v374 .. v375:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. v376
  end

  function f5()
    local v377 = {}

    for key29, value57 in next, {
      { "AutoFarmLevel", "Level Farm" }, { "AutoBone", "Bone Farm" },
      { "AutoCakePrince", "Cake Prince" }, { "AutoDoughKing", "Dough King" },
      { "AutoTaskEliteHunter", "Elite Hunter" }, { "AutoChest", "Chest Farm" },
      { "AutoMaterial", "Material Farm" }, { "AutoRaid", "Raid / Dungeon" },
      { "AutoTrialDracoTP", "Draco Trial" }, { "AutoSeaEvents", "Sea Events" },
      { "AutoFish", "Fish Farm" }, { "AutoTTK", "True Triple Katana" },
      { "AutoSoulReaper", "Soul Reaper" }, { "AutoFactoryRaid", "Factory Raid" },
      { "AutoFarmPirateRaid", "Pirate Raid" }, { "AutoKaitun", "Quantum Kaitun" },
    }, nil do
      if v19[value57[1]] then
        table.insert(v377, "[ON] " .. value57[2])
      end
    end

    if #v377 == 0 then
      return "None (Idle)"
    end

    return table.concat(v377, "\n")
  end

  function v20:SendDataLog(p115, p116)
    local dataLogWebhookUrl = v19.DataLogWebhookUrl and v19.DataLogWebhookUrl ~= ""
        and v19.DataLogWebhookUrl
      or v19.Webhook

    local v378 = not dataLogWebhookUrl or dataLogWebhookUrl == ""
      or typeof(dataLogWebhookUrl) ~= "string" or not dataLogWebhookUrl:find("http")

    local v379, v380, v381, v382, v383

    if v378 then
      return
    else
      local value58 = level and level.Value or 0
      local value59 = beli and beli.Value or 0
      local value60 = fragments and fragments.Value or 0
      local v384 = math.max(0, value58 - v17.StartLevel)
      local v385 = math.max(0, value59 - v17.StartBeli)
      local v386 = math.max(0, value60 - v17.StartFragments)

      local v387 = v24 and "Sea 1 (Old World)" or v25 and "Sea 2 (Dressrosa)"
        or v26 and "Sea 3 (Zou)" or "Unknown Sea"

      local value61 = localPlayer:FindFirstChild("leaderstats")
          and localPlayer.leaderstats:FindFirstChild("Bounty/Honor")
          and localPlayer.leaderstats["Bounty/Honor"].Value
        or "N/A"

      local activeFunction = v33.ActiveFunction
      local v388 = f4(tick() - v17.StartTime)
      local v389 = math.floor(v4:GetRealPhysicsFPS())
      v379 = 0

      pcall(function()
        local getValueString = v11.Network.ServerStatsItem["Data Ping"]:GetValueString()
        v379 = math.floor(tonumber(getValueString:match("%d+")) or 0)
      end)

      local v390 = {
        {
          name = "Player Profile",
          value = "**User:** " .. localPlayer.Name .. " (`" .. localPlayer.UserId .. [[
`)
**Sea:** ]] .. v387 .. "\n**Bounty/Honor:** " .. f7(value61),
          inline = true,
        },
        {
          name = "Statistics",
          value = "**Level:** " .. f7(value58) .. " *(+" .. f7(v384) .. [[
)*
**Beli:** $]] .. f7(value59) .. " *(+$" .. f7(v385) .. [[
)*
**Fragments:** Frags: ]] .. f7(value60) .. " *(+" .. f7(v386) .. ")*",
          inline = true,
        },
        {
          name = "Equipment & Status",
          value = "**Active Farm:** `" .. (activeFunction or "Idle") .. [[
`
**Equipped:** ]] .. f2() .. "\n**Elapsed Time:** " .. v388 .. "\n**Performance:** " .. v389 .. " FPS | " .. v379 .. " ms",
          inline = false,
        },
      }

      if v19.SendWebhookInventory ~= false then
        v380 = {}
        v381 = {}
        v382 = {}
        v383 = {}

        pcall(function()
          for index28, value62 in ipairs(utilities and utilities.GetParsedInventory
              and utilities:GetParsedInventory()
            or {}) do
            local attributes2 = value62.Attributes

            if attributes2.IsOwned == true or attributes2.Quantity and attributes2.Quantity > 0 then
              local tag = value62.Tag or ""
              local name7 = value62.Name or ""
              local quantity = attributes2.Quantity or 1

              if tag:find("PhysicalMoveset") or tag:find("Fruit") then
                local match6 = name7:match("^(.-)%-") or name7
                table.insert(v380, match6 .. (quantity > 1 and " (x" .. quantity .. ")" or ""))
              elseif tag:find("Sword") then
                table.insert(v381, name7)
              elseif tag:find("Accessory") then
                table.insert(v382, name7)
              elseif tag:find("Material") then
                table.insert(v383, name7 .. " (" .. quantity .. ")")
              end
            end
          end
        end)

        table.sort(v380)
        table.sort(v381)
        table.sort(v383)

        local v391 = #v380 > 0 and table.concat(v380, ", ") or "None"

        if #v391 > 900 then
          v391 = v391:sub(1, 897) .. "..."
        end

        table.insert(v390, {
          name = "Fruit Storage (" .. #v380 .. " Fruits)",
          value = [[
```
]] .. v391 .. "\n```",
          inline = false,
        })

        local v392 = #v381 > 0 and table.concat(v381, ", ") or "None"

        if #v392 > 900 then
          v392 = v392:sub(1, 897) .. "..."
        end

        table.insert(v390, {
          name = "Owned Swords (" .. #v381 .. ")",
          value = [[
```
]] .. v392 .. "\n```",
          inline = false,
        })

        if #v383 > 0 then
          local v393 = table.concat(v383, ", ")

          if #v393 > 900 then
            v393 = v393:sub(1, 897) .. "..."
          end

          table.insert(v390, {
            name = "Materials (" .. #v383 .. ")",
            value = [[
```
]] .. v393 .. "\n```",
            inline = false,
          })
        end
      end

      if v19.SendWebhookFarmsAll then
        table.insert(v390, {
          name = "Farms All Status",
          value = [[
```
]] .. f5() .. "\n```",
          inline = false,
        })
      end

      if p116 then
        table.insert(v390, { name = "Log Details", value = p116, inline = false })
      end

      local x2 = os.date("%X")
      local dateTime = DateTime.now()

      PostWebhook(dataLogWebhookUrl, {
        embeds = {
          {
            title = p115 or "Quantum Onyx - Blox Fruit Data Log",
            type = "rich",
            color = 3066993,
            fields = v390,
            thumbnail = {
              url = "https://www.roblox.com/headshot-thumbnail/image?userId="
                .. localPlayer.UserId .. "&width=420&height=420&format=png",
            },
            footer = { text = "Quantum Onyx | " .. x2 },
            timestamp = dateTime:ToIsoDate(),
          },
        },
      })

      v17.LastDataLogTick = tick()
      return
    end
  end

  function v20.LogError(p117, p118, p119, p120)
  end

  function f16(p121)
    for index29, value63 in ipairs(p121) do
      value63.Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
    end
  end

  function RemoveEffects()
    return function()
      local container4 = v5.Effect.Container
      local v394 = require(v5.Util.CameraShaker)
      local v395 = require(container4:FindFirstChild("Death"))
      local v396 = require(container4:FindFirstChild("Respawn"))
      local v397 = require(container4:FindFirstChild("LevelUp"))

      hookfunction(v395, function() end)
      hookfunction(v397, function() end)
      hookfunction(v396, function() end)

      v394:Stop()
    end
  end

  function round(p122)
    return math.floor(p122 + 0.5)
  end

  function GetHeadshotImage(p123)
    return string.format(
      "https://www.roblox.com/headshot-thumbnail/image?userId=%d&width=420&height=420&format=png",
      p123
    )
  end

  v33._ActiveESPs = v33._ActiveESPs or {}

  function f17()
    local character16 = localPlayer.Character
    local parent2 = character16 and character16.Parent
    local humanoidRootPart26

    if parent2 then
      humanoidRootPart26 = character16:FindFirstChild("HumanoidRootPart")
        or character16:FindFirstChild("Head") or character16.PrimaryPart

      if humanoidRootPart26 and humanoidRootPart26.Parent then
        local v398, v399 = pcall(function() return humanoidRootPart26.Position end)

        if v398 and v399 then
          return v399
        end

        return nil
      end

      return nil
    end

    return nil
  end

  function f18(p124)
    if not p124 or not p124.Parent then
      return 0
    else
      local v400 = f17()

      if not v400 then
        return 0
      else
        local v401, v402 = pcall(function() return p124.Position end)

        if not v401 or not v402 then
          return 0
        end

        return math.floor((v400 - v402).Magnitude)
      end
    end
  end

  function ClearESP(p125)
    for key30, value64 in next, v33._ActiveESPs, nil do
      local v403 = value64

      if not p125 or v403.Category == p125 then
        if v403.Folder and v403.Folder.Parent then
          pcall(function() v403.Folder:Destroy() end)
        end

        v33._ActiveESPs[key30] = nil
      end
    end
  end

  function AddESP(p126, p127, p128, p129, p130, p131)
    local esPquantumONYX = not p126 or p126:FindFirstChild("ESPquantumONYX")

    local espBillboard, iconContainer, instance, infoContainer, nameLabel, healthBar, fill,
      instance2, healthText, energyBar, fill2, instance3, energyText, v404, v405, v406

    if esPquantumONYX then
      return
    else
      local esPquantumONYX2 = Instance.new("Folder", p126)
      esPquantumONYX2.Name = "ESPquantumONYX"

      v33._ActiveESPs[p126] = { Folder = esPquantumONYX2, Category = p131 or "General" }
      local v407 = math.clamp(p126.Size.Y / 2 + 2.2, 2.6, 40)

      if p131 == "Player" then
        v407 = 2.4
      end

      espBillboard = Instance.new("BillboardGui", esPquantumONYX2)
      espBillboard.Name = "ESP_Billboard"
      espBillboard.Adornee = p126
      espBillboard.Size = UDim2.new(0, 260, 0, p130 and 42 or 26)
      espBillboard.StudsOffset = Vector3.new(0, v407, 0)
      espBillboard.AlwaysOnTop = true
      espBillboard.LightInfluence = 0
      espBillboard.MaxDistance = 100000
      espBillboard.ClipsDescendants = false

      iconContainer = Instance.new("Frame", espBillboard)
      iconContainer.Name = "IconContainer"
      iconContainer.Size = UDim2.new(0, 28, 0, 28)
      iconContainer.Position = UDim2.new(0, 0, 0.5, -14)
      iconContainer.BackgroundTransparency = 0.25
      iconContainer.BackgroundColor3 = Color3.fromRGB(15, 15, 20)

      Instance.new("UICorner", iconContainer).CornerRadius = UDim.new(1, 0)

      local instance4 = Instance.new("UIStroke", iconContainer)
      instance4.Color = p127 or Color3.fromRGB(255, 255, 255)
      instance4.Thickness = 1.2

      instance = Instance.new("ImageLabel", iconContainer)
      instance.BackgroundTransparency = 1
      instance.Size = UDim2.new(1, 0, 1, 0)
      instance.Image = "rbxassetid://0"

      Instance.new("UICorner", instance).CornerRadius = UDim.new(1, 0)

      infoContainer = Instance.new("Frame", espBillboard)
      infoContainer.Name = "InfoContainer"
      infoContainer.BackgroundTransparency = 1
      infoContainer.Position = UDim2.new(0, 0, 0, 0)
      infoContainer.Size = UDim2.new(1, 0, 1, 0)
      infoContainer.ClipsDescendants = false

      nameLabel = Instance.new("TextLabel", infoContainer)
      nameLabel.Name = "NameLabel"
      nameLabel.BackgroundTransparency = 1
      nameLabel.TextSize = 12
      nameLabel.Font = Enum.Font.GothamBold
      nameLabel.TextStrokeTransparency = 0.2
      nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
      nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
      nameLabel.RichText = true

      healthBar = nil
      fill = nil
      instance2 = nil
      healthText = nil
      energyBar = nil
      fill2 = nil
      instance3 = nil
      energyText = nil

      if p130 then
        nameLabel.Size = UDim2.new(1, 0, 0, 16)
        nameLabel.Position = UDim2.new(0, 0, 0, 1)
        nameLabel.TextYAlignment = Enum.TextYAlignment.Center
        nameLabel.TextXAlignment = Enum.TextXAlignment.Left

        local barsContainer = Instance.new("Frame", infoContainer)
        barsContainer.Name = "BarsContainer"
        barsContainer.BackgroundTransparency = 1
        barsContainer.Size = UDim2.new(0, 160, 0, 13)
        barsContainer.Position = UDim2.new(0, 0, 0, 19)
        barsContainer.ClipsDescendants = false

        healthBar = Instance.new("Frame", barsContainer)
        healthBar.Name = "HealthBar"
        healthBar.Size = UDim2.new(0, 76, 0, 13)
        healthBar.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
        healthBar.BackgroundTransparency = 0.3
        healthBar.BorderSizePixel = 0
        healthBar.ClipsDescendants = true

        Instance.new("UICorner", healthBar).CornerRadius = UDim.new(0, 3)

        instance2 = Instance.new("UIStroke", healthBar)
        instance2.Color = Color3.fromRGB(50, 255, 100)
        instance2.Thickness = 0.8
        instance2.Transparency = 0.4

        fill = Instance.new("Frame", healthBar)
        fill.Name = "Fill"
        fill.Size = UDim2.new(1, 0, 1, 0)
        fill.BackgroundColor3 = Color3.fromRGB(50, 255, 100)
        fill.BackgroundTransparency = 0.35
        fill.BorderSizePixel = 0

        Instance.new("UICorner", fill).CornerRadius = UDim.new(0, 3)

        healthText = Instance.new("TextLabel", healthBar)
        healthText.Name = "HealthText"
        healthText.BackgroundTransparency = 1
        healthText.Size = UDim2.new(1, 0, 1, 0)
        healthText.TextSize = 9
        healthText.Font = Enum.Font.GothamBold
        healthText.TextStrokeTransparency = 0.15
        healthText.TextColor3 = Color3.fromRGB(255, 255, 255)
        healthText.RichText = true

        energyBar = Instance.new("Frame", barsContainer)
        energyBar.Name = "EnergyBar"
        energyBar.Size = UDim2.new(0, 76, 0, 13)
        energyBar.Position = UDim2.new(0, 80, 0, 0)
        energyBar.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
        energyBar.BackgroundTransparency = 0.3
        energyBar.BorderSizePixel = 0
        energyBar.ClipsDescendants = true

        Instance.new("UICorner", energyBar).CornerRadius = UDim.new(0, 3)

        instance3 = Instance.new("UIStroke", energyBar)
        instance3.Color = Color3.fromRGB(70, 180, 255)
        instance3.Thickness = 0.8
        instance3.Transparency = 0.4

        fill2 = Instance.new("Frame", energyBar)
        fill2.Name = "Fill"
        fill2.Size = UDim2.new(1, 0, 1, 0)
        fill2.BackgroundColor3 = Color3.fromRGB(70, 180, 255)
        fill2.BackgroundTransparency = 0.35
        fill2.BorderSizePixel = 0

        Instance.new("UICorner", fill2).CornerRadius = UDim.new(0, 3)

        energyText = Instance.new("TextLabel", energyBar)
        energyText.Name = "EnergyText"
        energyText.BackgroundTransparency = 1
        energyText.Size = UDim2.new(1, 0, 1, 0)
        energyText.TextSize = 9
        energyText.Font = Enum.Font.GothamBold
        energyText.TextStrokeTransparency = 0.15
        energyText.TextColor3 = Color3.fromRGB(255, 255, 255)
        energyText.RichText = true
      else
        nameLabel.Size = UDim2.new(1, 0, 1, 0)
        nameLabel.Position = UDim2.new(0, 0, 0, 0)
        nameLabel.TextYAlignment = Enum.TextYAlignment.Center
        nameLabel.TextXAlignment = Enum.TextXAlignment.Center
      end

      v404 = ""
      v405 = ""
      v406 = 0.1

      spawn(function()
        while task.wait(v406) do
          if not espBillboard or not espBillboard.Parent or not p126 or not p126.Parent then
            v33._ActiveESPs[p126] = nil
            break
          end

          if p128 then
            local v408, v409 = pcall(p128)

            if v408 and v409 and v409 ~= v404 then
              v404 = v409
              nameLabel.Text = v409
            end
          end

          if p129 then
            local v410, v411 = pcall(p129)

            if v410 and v411 and v411 ~= v405 then
              v405 = v411

              if v411 ~= "" and v411 ~= "rbxassetid://0" then
                instance.Image = v411
                iconContainer.Visible = true

                infoContainer.Position = UDim2.new(0, 34, 0, 0)
                infoContainer.Size = UDim2.new(1, -34, 1, 0)

                nameLabel.TextXAlignment = Enum.TextXAlignment.Left
              else
                iconContainer.Visible = false

                infoContainer.Position = UDim2.new(0, 0, 0, 0)
                infoContainer.Size = UDim2.new(1, 0, 1, 0)

                if not p130 then
                  nameLabel.TextXAlignment = Enum.TextXAlignment.Center
                end
              end
            end
          elseif iconContainer.Visible then
            iconContainer.Visible = false

            infoContainer.Position = UDim2.new(0, 0, 0, 0)
            infoContainer.Size = UDim2.new(1, 0, 1, 0)

            if not p130 then
              nameLabel.TextXAlignment = Enum.TextXAlignment.Center
            end
          end

          if p130 and healthBar then
            local v412, v413, v414, v415, v416, v417, v418 = pcall(p130)

            if v412 and v413 then
              healthBar.Visible = true
              fill.Size = UDim2.new(math.clamp(v413, 0, 1), 0, 1, 0)

              if v414 then
                fill.BackgroundColor3 = v414
                instance2.Color = v414
              end

              healthText.Text = v415 or ""
            elseif v412 then
              healthBar.Visible = false
            end

            if v412 and v416 and energyBar then
              energyBar.Visible = true
              fill2.Size = UDim2.new(math.clamp(v416, 0, 1), 0, 1, 0)

              if v417 then
                fill2.BackgroundColor3 = v417
                instance3.Color = v417
              end

              energyText.Text = v418 or ""
            elseif v412 and energyBar then
              energyBar.Visible = false
            end
          end
        end
      end)

      return
    end
  end

  function PlayerESP()
    if not v19.ESPPlayer then
      return
    end

    for index30, value65 in ipairs(v3:GetPlayers()) do
      local v419 = value65

      if v419 ~= localPlayer and v419.Character and v419.Character.Parent then
        local head2 = v419.Character:FindFirstChild("Head")
          or v419.Character:FindFirstChild("HumanoidRootPart")

        local humanoid11 = v419.Character:FindFirstChildOfClass("Humanoid")

        if head2 and humanoid11 and humanoid11.Health > 0
          and not head2:FindFirstChild("ESPquantumONYX") then
          local v420 = localPlayer.Team ~= nil and v419.Team ~= nil
            and v419.Team == localPlayer.Team

          AddESP(head2, v420 and Color3.fromRGB(0, 255, 140) or Color3.fromRGB(255, 60, 60), function()
            if not head2 or not head2.Parent then
              return ""
            else
              local v421 = f18(head2)
              local data2 = v419:FindFirstChild("Data")

              local level2 = data2 and data2:FindFirstChild("Level")
                  and tostring(data2.Level.Value)
                or "?"

              return string.format(
                "<b>%s</b> <font color='rgb(255,215,0)'>[Lv. %s]</font> • <font color='rgb(210,210,210)'>%dm</font>",
                v419.DisplayName or v419.Name, level2, v421
              )
            end
          end, function() return GetHeadshotImage(v419.UserId) end, function()
            local character17 = v419.Character

            if not (character17 and character17.Parent) then
              return nil
            else
              local humanoid12 = character17:FindFirstChildOfClass("Humanoid")

              if not humanoid12 or humanoid12.Health <= 0 then
                return nil
              else
                local v422 = math.floor(humanoid12.Health)
                local v423 = math.max(math.floor(humanoid12.MaxHealth), 1)
                local v424 = math.clamp(v422 / v423, 0, 1)

                local color2 = v420 and Color3.fromRGB(0, 255, 140)
                  or Color3.fromRGB(50, 255, 100)

                local v425 = string.format("%d/%d HP", v422, v423)
                local v426 = 100
                local v427 = 100
                local energy = character17:FindFirstChild("Energy")

                if energy and energy.Value ~= nil then
                  v426 = math.floor(tonumber(energy.Value) or 0)
                  v427 = math.max(tonumber(energy.MaxValue) or 100, 1)
                else
                  local data3 = v419:FindFirstChild("Data")

                  if data3 and data3:FindFirstChild("Stats")
                    and data3.Stats:FindFirstChild("Melee")
                    and data3.Stats.Melee:FindFirstChild("Level") then
                    v427 = 100 + (tonumber(data3.Stats.Melee.Level.Value) or 1) * 5
                    v426 = v427
                  end
                end

                return v424, color2, v425, math.clamp(v426 / v427, 0, 1), Color3.fromRGB(70, 180, 255), (string.format("%d/%d EN", v426, v427))
              end
            end
          end, "Player")
        end
      end
    end
  end

  local function f60(p132)
    p132.CharacterAdded:Connect(function(character18)
      task.wait(0.4)

      if p132 == localPlayer then
        if v19.ESPPlayer then
          pcall(PlayerESP)
        end

        if v19.ESPIsland then
          pcall(IslandESP)
        end

        if v19.DevilFruitESP then
          pcall(FruitESP)
        end

        if v19.ESPChest then
          pcall(ChestESP)
        end

        if v19.ESP_Berries then
          pcall(BerryESP)
        end

        if v19.ESP_RealFruits then
          pcall(RealFruitESP)
        end

        if v19.ESPMyBoat then
          pcall(MyBoatESP)
        end

        if v19.ESPHalloween then
          pcall(HalloweenESP)
        end
      elseif v19.ESPPlayer then
        pcall(PlayerESP)
      end
    end)
  end

  for index31, value66 in ipairs(v3:GetPlayers()) do
    f60(value66)
  end

  v3.PlayerAdded:Connect(f60)

  function IslandESP()
    if not v19.ESPIsland then
      return
    else
      local locations = worldOrigin and worldOrigin:FindFirstChild("Locations")

      if not locations then
        return
      end

      for index32, value67 in ipairs(locations:GetChildren()) do
        local v428 = value67

        if v428:IsA("BasePart") and v428.Name ~= "Sea"
          and not v428:FindFirstChild("ESPquantumONYX") then
          AddESP(v428, Color3.fromRGB(100, 200, 255), function()
            return string.format([[
<b><font color='rgb(100,200,255)'>%s</font></b>
<font color='rgb(200,200,200)'>%d studs</font>]], v428.Name, (f18(v428)))
          end, nil, nil, "Island")
        end
      end

      return
    end
  end

  function FruitESP()
    if not v19.DevilFruitESP then
      return
    end

    for index33, value68 in ipairs(v4:GetChildren()) do
      if value68:IsA("Model") and string.find(value68.Name, "Fruit")
        and value68.Name ~= "Fruit1" then
        local handle = value68:FindFirstChild("Handle") or value68.PrimaryPart
          or value68:FindFirstChildWhichIsA("BasePart")

        if handle and not handle:FindFirstChild("ESPquantumONYX") then
          local name8 = value68.Name == "Fruit" and "Spawned Fruit" or value68.Name

          AddESP(handle, Color3.fromRGB(255, 170, 0), function()
            return string.format([[
Fruit: <b><font color='rgb(255,170,0)'>%s</font></b>
<font color='rgb(220,220,220)'>%d studs away</font>]], name8, (f18(handle)))
          end, nil, nil, "Fruit")
        end
      end
    end
  end

  function ChestESP()
    if not v19.ESPChest then
      return
    else
      local chestModels = v4:FindFirstChild("ChestModels")

      if not chestModels then
        return
      end

      for index34, value69 in ipairs(chestModels:GetChildren()) do
        local rootPart = value69:FindFirstChild("RootPart") or value69.PrimaryPart

        if rootPart and not rootPart:FindFirstChild("ESPquantumONYX") then
          local lower9 = value69.Name:lower()
          local color3 = Color3.fromRGB(255, 255, 255)
          local v429 = "rbxassetid://0"
          local v430 = "Chest"

          if lower9:find("silver") then
            color3 = Color3.fromRGB(210, 210, 220)
            v429 = "rbxassetid://97335861533611"
            v430 = "Silver Chest"
          elseif lower9:find("gold") then
            color3 = Color3.fromRGB(255, 215, 0)
            v429 = "rbxassetid://103232045481498"
            v430 = "Gold Chest"
          elseif lower9:find("diamond") then
            color3 = Color3.fromRGB(0, 230, 255)
            v429 = "rbxassetid://103232045481498"
            v430 = "Diamond Chest"
          end

          AddESP(rootPart, color3, function()
            return string.format([[
<b><font color='rgb(%d,%d,%d)'>%s</font></b>
<font color='rgb(200,200,200)'>%d studs</font>]], color3.R * 255, color3.G * 255, color3.B * 255, v430, (f18(rootPart)))
          end, function() return v429 end, nil, "Chest")
        end
      end

      return
    end
  end

  v42 = {
    ["Yellow Star Berry"] = Color3.fromRGB(255, 220, 50),
    ["Red Cherry Berry"] = Color3.fromRGB(255, 65, 65),
    ["Purple Jelly Berry"] = Color3.fromRGB(190, 80, 255),
    ["Pink Pig Berry"] = Color3.fromRGB(255, 130, 180),
    ["Blue Icicle Berry"] = Color3.fromRGB(80, 210, 255),
    ["Green Toad Berry"] = Color3.fromRGB(65, 235, 95),
    ["Orange Berry"] = Color3.fromRGB(255, 145, 35),
    ["White Cloud Berry"] = Color3.fromRGB(240, 240, 255),
  }

  color = Color3.fromRGB(255, 105, 180)
  quantumBerryAnchors = v4:FindFirstChild("Quantum_Berry_Anchors")

  if not quantumBerryAnchors then
    quantumBerryAnchors = Instance.new("Folder")
    quantumBerryAnchors.Name = "Quantum_Berry_Anchors"
    quantumBerryAnchors.Parent = v4
  end

  v43 = {}

  function f8(p133)
    if not p133 then
      return
    end

    pcall(function()
      for index35, value70 in ipairs(p133:GetDescendants()) do
        if value70.Name == "BoatProtectBP" or value70.Name == "BoatProtectBV" then
          value70:Destroy()
        end
      end
    end)
  end

  function BerryESP()
    if not v19.ESP_Berries then
      ClearESP("Berry")
      return
    else
      local v431 = {}

      for index36, value71 in ipairs(v6:GetTagged("BerryBush")) do
        local parent3 = value71.Parent

        if parent3 then
          local cframe3 = parent3:GetAttribute("CFrame")
            or parent3:IsA("Model") and parent3:GetPivot()

          for key31, value72 in pairs(value71:GetAttributes()) do
            local v432 = value72

            if type(v432) == "string" and #v432 > 0 and key31:sub(1, 12) == "_BerryCFrame" then
              local toWorldSpace = cframe3
              local getAttribute = parent3:GetAttribute(key31)

              if cframe3 then
                toWorldSpace = getAttribute and cframe3:ToWorldSpace(getAttribute)
              end

              if toWorldSpace then
                local v433 = parent3.Name .. "_" .. key31
                v431[v433] = true
                local part = v43[v433]

                if not part or not part.Parent then
                  part = Instance.new("Part")
                  part.Name = "BerryAnchor_" .. v432
                  part.Size = Vector3.new(1.2, 1.2, 1.2)
                  part.Transparency = 1
                  part.CanCollide = false
                  part.Anchored = true
                  part.CFrame = toWorldSpace
                  part.Parent = quantumBerryAnchors

                  v43[v433] = part
                else
                  part.CFrame = toWorldSpace
                end

                if part and not part:FindFirstChild("ESPquantumONYX") then
                  local v434 = v42[v432] or color

                  AddESP(part, v434, function()
                    return string.format([[
Berry: <b><font color='rgb(%d,%d,%d)'>%s</font></b>
<font color='rgb(220,220,220)'>%d studs</font>]], v434.R * 255, v434.G * 255, v434.B * 255, v432, (f18(part)))
                  end, nil, nil, "Berry")
                end
              end
            end
          end
        end
      end

      for key32, value73 in pairs(v43) do
        local v435 = value73

        if not v431[key32] then
          if v435 and v435.Parent then
            pcall(function() v435:Destroy() end)
          end

          v43[key32] = nil
        end
      end

      return
    end
  end

  function RealFruitESP()
    if not v19.ESP_RealFruits then
      return
    end

    for index37, value74 in ipairs({ "PineappleSpawner", "AppleSpawner", "BananaSpawner" }) do
      local findFirstChild2 = v4:FindFirstChild(value74)

      if findFirstChild2 and not findFirstChild2:FindFirstChild("ESPquantumONYX") then
        local gsub3 = value74:gsub("Spawner", "")

        AddESP(findFirstChild2, Color3.fromRGB(50, 205, 50), function()
          return string.format([[
Natural Fruit: <b><font color='rgb(50,205,50)'>%s</font></b>
<font color='rgb(220,220,220)'>%d studs</font>]], gsub3, (f18(findFirstChild2)))
        end, nil, nil, "RealFruit")
      end
    end

    for index38, value75 in ipairs(v4:GetChildren()) do
      local v436 = value75

      if v436:IsA("Tool")
        and (v436.Name == "Pineapple" or v436.Name == "Apple" or v436.Name == "Banana") then
        local handle2 = v436:FindFirstChild("Handle") or v436:IsA("BasePart") and v436

        if handle2 and handle2:IsA("BasePart") and not handle2:FindFirstChild("ESPquantumONYX") then
          AddESP(handle2, Color3.fromRGB(50, 205, 50), function()
            return string.format([[
Natural Fruit: <b><font color='rgb(50,205,50)'>%s</font></b>
<font color='rgb(220,220,220)'>%d studs</font>]], v436.Name, (f18(handle2)))
          end, nil, nil, "RealFruit")
        end
      end
    end
  end

  function MyBoatESP()
    if not v19.ESPMyBoat then
      ClearESP("MyBoat")
      return
    else
      local boats2 = v4:FindFirstChild("Boats")

      if not boats2 then
        return
      end

      for index39, value76 in ipairs(boats2:GetChildren()) do
        local v437 = value76
        local owner3 = v437:FindFirstChild("Owner")
        local name9 = ""

        if owner3 then
          if typeof(owner3.Value) == "Instance" then
            name9 = owner3.Value.Name
          else
            name9 = tostring(owner3.Value or "")
          end
        end

        if name9 == localPlayer.Name or owner3 and owner3.Value == localPlayer then
          local primaryPart5 = v437.PrimaryPart or v437:FindFirstChildWhichIsA("VehicleSeat")
            or v437:FindFirstChildWhichIsA("BasePart")

          if primaryPart5 and not primaryPart5:FindFirstChild("ESPquantumONYX") then
            AddESP(primaryPart5, Color3.fromRGB(0, 255, 180), function()
              local v438 = f18(primaryPart5)
              local health4 = v437:FindFirstChild("Health")
              local v439 = health4 and string.format(" [%d HP]", health4.Value) or ""

              return string.format([[
My Boat (%s)%s
%d studs away]], v437.Name, v439, v438)
            end, nil, nil, "MyBoat")
          end
        end
      end

      return
    end
  end

  function f19(p134, p135)
    local v440, getPivot

    if not p134 then
      return
    else
      v440 = p135 or 450
      getPivot = p134:GetPivot()

      if getPivot.Position.Y < v440 - 10 then
        pcall(function()
          p134:PivotTo(CFrame.new(getPivot.Position.X, v440, getPivot.Position.Z))
        end)
      end

      local findFirstChildWhichIsA = p134:FindFirstChildWhichIsA("VehicleSeat", true)
        or p134:FindFirstChild("VehicleSeat", true) or p134:FindFirstChildWhichIsA("Seat", true)
        or p134.PrimaryPart

      if findFirstChildWhichIsA and findFirstChildWhichIsA:IsA("BasePart") then
        local boatProtectBP = findFirstChildWhichIsA:FindFirstChild("BoatProtectBP")

        if not boatProtectBP then
          local boatProtectBP2 = Instance.new("BodyPosition")
          boatProtectBP2.Name = "BoatProtectBP"
          boatProtectBP2.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
          boatProtectBP2.P = 100000
          boatProtectBP2.D = 1000
          boatProtectBP2.Position = Vector3.new(getPivot.Position.X, v440, getPivot.Position.Z)
          boatProtectBP2.Parent = findFirstChildWhichIsA
        else
          boatProtectBP.Position = Vector3.new(getPivot.Position.X, v440, getPivot.Position.Z)
        end

        local boatProtectBV = findFirstChildWhichIsA:FindFirstChild("BoatProtectBV")

        if not boatProtectBV then
          local boatProtectBV2 = Instance.new("BodyVelocity")
          boatProtectBV2.Name = "BoatProtectBV"
          boatProtectBV2.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
          boatProtectBV2.Velocity = Vector3.zero
          boatProtectBV2.P = 100000
          boatProtectBV2.Parent = findFirstChildWhichIsA
        else
          boatProtectBV.Velocity = Vector3.zero
        end
      end

      return
    end
  end

  function HalloweenCursedSnowmanESP()
    if not (v19.ESPHalloween and v19.ESP_CursedSnowman) then
      ClearESP("CursedSnowman")
      return
    else
      local v441 = {}

      local function f61(p136, p137, p138, p139)
        if not (p136 and not p136:FindFirstChild("ESPquantumONYX")) then
          return
        end

        AddESP(p136, p138, function()
          local character19 = localPlayer.Character

          local humanoidRootPart27 = character19
            and (character19:FindFirstChild("HumanoidRootPart")
              or character19:FindFirstChild("Head") or character19.PrimaryPart)

          local position35 = humanoidRootPart27 and humanoidRootPart27.Position

          local v442 = position35 and p136.Parent
              and math.floor((position35 - p136.Position).Magnitude)
            or 0

          local v443 = ""

          if p139 and p139.Health > 0 then
            v443 = string.format(
              "\n<font color='rgb(255,100,100)'>[%d/%d HP]</font>", math.floor(p139.Health),
              math.max(math.floor(p139.MaxHealth), 1)
            )
          end

          return string.format([[
<b><font color='rgb(%d,%d,%d)'>%s</font></b>%s
<font color='rgb(220,220,220)'>%d studs</font>]], math.floor(p138.R * 255), math.floor(p138.G * 255), math.floor(p138.B * 255), p137, v443, v442)
        end, nil, nil, "CursedSnowman")
      end

      if enemies then
        for index40, value77 in ipairs(enemies:GetChildren()) do
          if value77 and value77.Parent and not v441[value77]
            and value77.Name == "Pumpkin Snowman" then
            local findFirstChild3 = value77.FindFirstChild
            v441[value77] = true

            f61(findFirstChild3(value77, "HumanoidRootPart") or value77.PrimaryPart
              or value77:FindFirstChildWhichIsA("BasePart"), "Pumpkin Snowman", Color3.fromRGB(120, 220, 255), value77:FindFirstChildOfClass("Humanoid"))
          end
        end
      end

      local pumpkinHunt2 = workspace:FindFirstChild("PumpkinHunt")

      if pumpkinHunt2 then
        for index41, value78 in ipairs(pumpkinHunt2:GetChildren()) do
          if value78 and value78.Parent and not v441[value78]
            and (value78.Name == "PumpkinPatch" or value78.Name:find("PumpkinPatch")) then
            local pumpkinState2 = value78:GetAttribute("PumpkinState")

            if pumpkinState2 == nil or pumpkinState2 == "Idle" or pumpkinState2 == "Hit" then
              v441[value78] = true

              f61(value78.PrimaryPart or value78:FindFirstChild("RootPart")
                or value78:FindFirstChild("Hitbox")
                or value78:FindFirstChildWhichIsA("BasePart"), "Cursed Seed", Color3.fromRGB(180, 80, 255), nil)
            end
          end
        end
      end

      return
    end
  end

  function HalloweenPumpkinsESP()
    if not (v19.ESPHalloween and v19.ESP_Pumpkins) then
      ClearESP("HalloweenPumpkin")
      return
    else
      local pumpkinHunt3 = workspace:FindFirstChild("PumpkinHunt")

      if not pumpkinHunt3 then
        return
      end

      for index42, value79 in ipairs(pumpkinHunt3:GetChildren()) do
        if value79 and value79.Parent then
          local v444 = value79.Name == "PumpkinPatch"

          local pumpkinPatch2 = v444
          pumpkinPatch2 = v444 or value79.Name:find("PumpkinPatch")

          if value79.Name == "Pumpkin" or value79.Name:find("Pumpkin") or pumpkinPatch2 then
            local pumpkinState3 = value79:GetAttribute("PumpkinState")

            if pumpkinState3 == nil or pumpkinState3 == "Idle" or pumpkinState3 == "Hit" then
              local primaryPart6 = value79.PrimaryPart or value79:FindFirstChild("RootPart")
                or value79:FindFirstChild("Hitbox") or value79:FindFirstChild("Handle")
                or value79:FindFirstChildWhichIsA("BasePart")

              if primaryPart6 and not primaryPart6:FindFirstChild("ESPquantumONYX") then
                local v445 = pumpkinPatch2 and "Cursed Seed" or "Pumpkin"

                local color4 = pumpkinPatch2 and Color3.fromRGB(180, 80, 255)
                  or Color3.fromRGB(255, 140, 0)

                AddESP(primaryPart6, color4, function()
                  local character20 = localPlayer.Character

                  local humanoidRootPart28 = character20
                    and (character20:FindFirstChild("HumanoidRootPart")
                      or character20:FindFirstChild("Head") or character20.PrimaryPart)

                  local position36 = humanoidRootPart28 and humanoidRootPart28.Position

                  local v446 = position36 and primaryPart6.Parent
                      and math.floor((position36 - primaryPart6.Position).Magnitude)
                    or 0

                  return string.format([[
<b><font color='rgb(%d,%d,%d)'>%s</font></b>
<font color='rgb(220,220,220)'>%d studs</font>]], math.floor(color4.R * 255), math.floor(color4.G * 255), math.floor(color4.B * 255), v445, v446)
                end, nil, nil, "HalloweenPumpkin")
              end
            end
          end
        end
      end

      return
    end
  end

  function HalloweenBossPortalESP()
    local espHalloweenBossesPortal = v19.ESPHalloween and v19.ESP_HalloweenBossesPortal
    local v447, v448, findFirstChildWhichIsA2

    if not espHalloweenBossesPortal then
      ClearESP("HalloweenBossPortal")
      return
    else
      v447 = {}
      v448 = {}

      local function f62(p140)
        if not (p140 and p140.Parent and not v448[p140]) then
          return
        else
          local name10 = p140.Name

          if name10 == "Dapper Jack" or name10:find("Dapper Jack")
            or name10 == "Jack o' Lantern" or name10:find("Jack o")
            or name10 == "Unbound Werewolf" or name10:find("Werewolf")
            or name10 == "Hellfire Gas" or name10:find("Hellfire Gas") then
            v448[p140] = true
            table.insert(v447, p140)
          end

          return
        end
      end

      local enemies4 = workspace:FindFirstChild("Enemies")

      if enemies4 then
        for index43, value80 in ipairs(enemies4:GetChildren()) do
          f62(value80)
        end
      end

      local seaBeasts2 = workspace:FindFirstChild("SeaBeasts")

      if seaBeasts2 then
        for index44, value81 in ipairs(seaBeasts2:GetChildren()) do
          f62(value81)
        end
      end

      for index45, value82 in ipairs(v447) do
        local name11 = value82.Name
        local findFirstChild4 = value82.FindFirstChild
        local humanoid13 = value82:FindFirstChildOfClass("Humanoid")

        local primaryPart7 = findFirstChild4(value82, "HumanoidRootPart") or value82.PrimaryPart
          or value82:FindFirstChildWhichIsA("BasePart")

        if primaryPart7 and not primaryPart7:FindFirstChild("ESPquantumONYX") then
          local color5 = name11:find("Jack") and Color3.fromRGB(255, 50, 50)
            or name11:find("Werewolf") and Color3.fromRGB(160, 90, 230)
            or Color3.fromRGB(255, 80, 80)

          AddESP(primaryPart7, color5, function()
            local character21 = localPlayer.Character

            local humanoidRootPart29 = character21
              and (character21:FindFirstChild("HumanoidRootPart")
                or character21:FindFirstChild("Head") or character21.PrimaryPart)

            local position37 = humanoidRootPart29 and humanoidRootPart29.Position

            local v449 = position37 and primaryPart7.Parent
                and math.floor((position37 - primaryPart7.Position).Magnitude)
              or 0

            local v450 = humanoid13 and humanoid13.Health > 0 and math.floor(humanoid13.Health)
              or 0

            local v451 = humanoid13 and humanoid13.MaxHealth > 0
                and math.max(math.floor(humanoid13.MaxHealth), 1)
              or 1

            local v452 = v450 > 0 and string.format(
              "\n<font color='rgb(255,80,80)'>[%d/%d HP]</font>", v450, v451
            ) or ""

            return string.format([[
<b><font color='rgb(%d,%d,%d)'>[Boss] %s</font></b>%s
<font color='rgb(220,220,220)'>%d studs</font>]], math.floor(color5.R * 255), math.floor(color5.G * 255), math.floor(color5.B * 255), name11, v452, v449)
          end, nil, nil, "HalloweenBossPortal")
        end
      end

      local dapperJackGateway2 = workspace:FindFirstChild("DapperJackGateway")
        or workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("DapperJackGateway")

      if dapperJackGateway2 then
        findFirstChildWhichIsA2 = dapperJackGateway2:FindFirstChildWhichIsA("BasePart", true)

        local findFirstChildWhichIsA3 = dapperJackGateway2:FindFirstChildWhichIsA(
          "ProximityPrompt", true
        )

        if findFirstChildWhichIsA3 and findFirstChildWhichIsA3.Parent
          and findFirstChildWhichIsA3.Parent:IsA("BasePart") then
          findFirstChildWhichIsA2 = findFirstChildWhichIsA3.Parent
        end

        if findFirstChildWhichIsA2
          and not findFirstChildWhichIsA2:FindFirstChild("ESPquantumONYX") then
          AddESP(findFirstChildWhichIsA2, Color3.fromRGB(190, 60, 255), function()
            local character22 = localPlayer.Character

            local humanoidRootPart30 = character22
              and (character22:FindFirstChild("HumanoidRootPart")
                or character22:FindFirstChild("Head") or character22.PrimaryPart)

            local position38 = humanoidRootPart30 and humanoidRootPart30.Position

            local v453 = position38 and findFirstChildWhichIsA2.Parent
                and math.floor((position38 - findFirstChildWhichIsA2.Position).Magnitude)
              or 0

            local v454 = workspace

            return string.format([[
<b><font color='rgb(190,60,255)'>Dapper Jack Portal</font></b> %s
<font color='rgb(220,220,220)'>%d studs</font>]], v454:GetAttribute("DapperJackActive") == true
                and "<font color='rgb(80,255,100)'>[Active]</font>"
              or "<font color='rgb(200,200,200)'>[Gateway]</font>", v453)
          end, nil, nil, "HalloweenBossPortal")
        end
      end

      if v33.GetHalloweenDoors then
        v33:GetHalloweenDoors()
      end

      for index46, value83 in ipairs({}) do
        if value83 and value83.Parent then
          if value83.Name:find("Jack") or value83:GetAttribute("BossDoor") == true
            or value83:GetAttribute("ArenaDoor") == true then
            local proximity3 = value83:FindFirstChild("Proximity") or value83.PrimaryPart
              or value83:FindFirstChildWhichIsA("BasePart")

            if proximity3 and not proximity3:FindFirstChild("ESPquantumONYX") then
              AddESP(proximity3, Color3.fromRGB(220, 80, 255), function()
                local character23 = localPlayer.Character

                local humanoidRootPart31 = character23
                  and (character23:FindFirstChild("HumanoidRootPart")
                    or character23:FindFirstChild("Head") or character23.PrimaryPart)

                local position39 = humanoidRootPart31 and humanoidRootPart31.Position

                local v455 = position39 and proximity3.Parent
                    and math.floor((position39 - proximity3.Position).Magnitude)
                  or 0

                return string.format([[
<b><font color='rgb(220,80,255)'>Boss Door</font></b>
<font color='rgb(220,220,220)'>%d studs</font>]], v455)
              end, nil, nil, "HalloweenBossPortal")
            end
          end
        end
      end

      return
    end
  end

  function HalloweenESP()
    if not v19.ESPHalloween then
      ClearESP("CursedSnowman")
      ClearESP("HalloweenPumpkin")
      ClearESP("HalloweenBossPortal")

      return
    end

    if v19.ESP_CursedSnowman then
      pcall(HalloweenCursedSnowmanESP)
    else
      ClearESP("CursedSnowman")
    end

    if v19.ESP_Pumpkins then
      pcall(HalloweenPumpkinsESP)
    else
      ClearESP("HalloweenPumpkin")
    end

    if v19.ESP_HalloweenBossesPortal then
      pcall(HalloweenBossPortalESP)
    else
      ClearESP("HalloweenBossPortal")
    end
  end

  function f20(p141)
    if not (p141 and p141.Character and p141.Character:FindFirstChild("HumanoidRootPart")
      and p141.Character:FindFirstChild("Humanoid")) then
      return false
    else
      local character24 = p141.Character
      local humanoidRootPart32 = p141.Character.HumanoidRootPart

      if character24:FindFirstChild("ForceField") ~= nil then
        return true
      end

      for index47, value84 in ipairs(v4:GetChildren()) do
        if value84:IsA("BasePart") and value84.Name:find("SafeZone") then
          if (humanoidRootPart32.Position - value84.Position).Magnitude
            < value84.Size.Magnitude / 2 + 10 then
            return true
          end
        end
      end

      return false
    end
  end

  local cframe4 = CFrame.new(28224.057, 14889.427, -210.587)
  local cframe5 = CFrame.new(29237.295, 14889.427, -206.95)
  local cframe6 = CFrame.new(28492, 14901, -426)
  local cframe7 = CFrame.new(28967.408, 14918.075, 234.312)
  local cframe8 = CFrame.new(28672.721, 14889.128, 454.596)
  local cframe9 = CFrame.new(29020.66, 14889.427, -379.268)

  local function f63()
    local v456 = { CurrentQuest = nil, GetPvPTarget = GetPvPTarget }

    function v456:GetNearest(p142)
      local huge6 = p142 or math.huge
      local character25 = localPlayer.Character

      local humanoidRootPart33 = character25
        and (character25:FindFirstChild("HumanoidRootPart") or character25.PrimaryPart)

      local v457

      if not humanoidRootPart33 then
        return nil
      else
        local position40 = humanoidRootPart33.Position

        for index48, value85 in ipairs(enemies:GetChildren()) do
          local humanoidRootPart34 = value85:FindFirstChild("HumanoidRootPart")
            or value85.PrimaryPart

          local humanoid14 = value85:FindFirstChildOfClass("Humanoid")

          if humanoidRootPart34 and humanoid14 and humanoid14.Health > 0 then
            local magnitude11 = (position40 - humanoidRootPart34.Position).Magnitude

            if magnitude11 <= (v19.checknearestdist or 500) and magnitude11 < huge6 then
              v457 = value85
              huge6 = magnitude11
            end
          end
        end

        return v457
      end
    end

    function v456:GetNearestPlayer()
      local huge7 = math.huge
      local character26 = localPlayer.Character

      local humanoidRootPart35 = character26
        and (character26:FindFirstChild("HumanoidRootPart") or character26.PrimaryPart)

      local v458

      if not humanoidRootPart35 then
        return nil
      else
        local position41 = humanoidRootPart35.Position

        for index49, value86 in ipairs(v3:GetPlayers()) do
          if value86 ~= localPlayer and f11(value86) and value86.Character
            and value86.Character.Parent then
            local humanoid15 = value86.Character:FindFirstChildOfClass("Humanoid")

            local humanoidRootPart36 = value86.Character:FindFirstChild("HumanoidRootPart")
              or value86.Character.PrimaryPart

            if humanoid15 and humanoid15.Health > 0 and humanoidRootPart36 and not f20(value86) then
              local magnitude12 = (humanoidRootPart36.Position - position41).Magnitude

              if magnitude12 < huge7 then
                v458 = value86
                huge7 = magnitude12
              end
            end
          end
        end

        return v458
      end
    end

    function v456:PlatesBartilo()
      local bartiloPlates = map.Dressrosa.BartiloPlates
      local sandYellow = BrickColor.new("Sand yellow")

      for i29 = 1, 8 do
        if bartiloPlates["Plate" .. i29].BrickColor == sandYellow then
          return "Plate" .. i29
        end
      end
    end

    local v459 = {}

    v456.VisitedChests = {}
    v456.CurrentChest = nil
    v456.ChestTargetTime = 0
    v456.ChestNearTime = 0

    local visitedChests = v456.VisitedChests

    local function f64()
      local chestFilterType = v19.ChestFilterType

      if not chestFilterType then
        return true
      end

      if type(chestFilterType) == "string"
        and (chestFilterType == "All" or chestFilterType == "") then
        return true
      elseif type(chestFilterType) == "table" then
        local v460 = { Diamond = false, Gold = false, Silver = false }

        for key33, value87 in pairs(chestFilterType) do
          if value87 == "Diamond" then
            v460.Diamond = true
          end

          if value87 == "Gold" then
            v460.Gold = true
          end

          if value87 == "Silver" then
            v460.Silver = true
          end
        end

        if v460.Diamond and v460.Gold and v460.Silver then
          return true
        end

        return false
      else
        return false
      end
    end

    function v456.BlacklistChest(p143, p144)
      if not p143 then
        return
      end

      v459[p143] = tick() + (p144 or 60)
    end

    local function f65(p145)
      if not p145 or not p145:IsA("Instance") then
        return
      end

      p145:GetAttributeChangedSignal("IsDisabled"):Connect(function()
        if not p145:GetAttribute("IsDisabled") then
          v459[p145] = nil
        end
      end)
    end

    for index50, value88 in ipairs(v6:GetTagged("_ChestTagged")) do
      f65(value88)
    end

    v6:GetInstanceAddedSignal("_ChestTagged"):Connect(f65)

    local function f66(p146)
      if not p146 then
        return nil
      elseif p146:IsA("BasePart") then
        return p146.CFrame
      else
        if p146:IsA("Model") then
          return p146.PrimaryPart and p146.PrimaryPart.CFrame or p146:GetPivot()
        end

        return nil
      end
    end

    local function f67(p147)
      local v461 = f66(p147)
      return v461 and v461.Position or nil
    end

    local function f68(p148)
      if not p148 or not p148.Parent then
        return false
      end

      if not v6:HasTag(p148, "_ChestTagged") then
        return false
      end

      if not p148:IsA("BasePart") and not p148:IsA("Model") then
        return false
      end

      if v459[p148] and tick() < v459[p148] then
        return false
      end

      if p148:GetAttribute("IsDisabled") == true or p148:GetAttribute("Collected") == true then
        return false
      end

      if not (p148:IsA("BasePart") and p148 or p148.PrimaryPart
        or p148:FindFirstChildWhichIsA("BasePart")) then
        return false
      end

      if not p148:FindFirstChildWhichIsA("TouchTransmitter", true) then
        return false
      end

      return true
    end

    local function f69(p149)
      local name12 = p149.Name

      if name12 == "Chest3" or name12 == "DiamondChest" or name12:lower():find("diamond") then
        return "Diamond"
      end

      if name12 == "Chest2" or name12 == "GoldChest" or name12:lower():find("gold") then
        return "Gold"
      end

      if name12 == "Chest1" or name12 == "SilverChest" or name12:lower():find("silver")
        or name12:lower():find("bronze") or name12:lower():find("wood")
        or name12:lower():find("normal") then
        return "Silver"
      elseif p149.Parent then
        local lower10 = p149.Parent.Name:lower()

        if lower10:find("diamond") then
          return "Diamond"
        elseif lower10:find("gold") then
          return "Gold"
        else
          if lower10:find("silver") or lower10:find("bronze") or lower10:find("wood")
            or lower10:find("normal") then
            return "Silver"
          end

          return "Silver"
        end
      else
        return "Silver"
      end
    end

    local function f70(p150)
      local v462 = f69(p150)

      if v462 == "Diamond" then
        return 3
      elseif v462 == "Gold" then
        return 2
      else
        if v462 == "Silver" then
          return 1
        end

        return 0
      end
    end

    local function f71(p151)
      local chestFilterType2 = v19.ChestFilterType

      if not chestFilterType2 or chestFilterType2 == "All" then
        return true
      else
        local v463 = f69(p151)

        if type(chestFilterType2) == "table" then
          if #chestFilterType2 == 0 then
            return true
          end

          for key34, value89 in pairs(chestFilterType2) do
            if value89 == v463 or type(value89) == "string" and value89:find(v463) then
              return true
            end
          end

          if chestFilterType2[v463] == true then
            return true
          end

          return false
        elseif type(chestFilterType2) == "string" then
          if chestFilterType2 == "Diamond" or chestFilterType2 == "Diamond Only" then
            return v463 == "Diamond"
          end

          if chestFilterType2 == "Gold" or chestFilterType2 == "Gold Only" then
            return v463 == "Gold"
          end

          if chestFilterType2 == "Silver" or chestFilterType2 == "Silver Only"
            or chestFilterType2 == "Normal" or chestFilterType2 == "Normal Only" then
            return v463 == "Silver"
          elseif chestFilterType2 == "Diamond & Gold" then
            return v463 == "Diamond" or v463 == "Gold"
          else
            if chestFilterType2 == "Gold & Silver" then
              return v463 == "Gold" or v463 == "Silver"
            end

            return true
          end
        else
          return true
        end
      end
    end

    function v456:DetectChest()
      local humanoidRootPart37 = localPlayer.Character
        and (localPlayer.Character:FindFirstChild("HumanoidRootPart")
          or localPlayer.Character.PrimaryPart)

      if not humanoidRootPart37 then
        return nil
      else
        local v464 = f64()
        local v465 = nil
        local v466 = -1
        local v467 = false
        local huge8 = math.huge
        local chestTagged = v6:GetTagged("_ChestTagged")

        if v464 then
          for key35, value90 in pairs(visitedChests) do
            if not key35 or not key35.Parent or not v6:HasTag(key35, "_ChestTagged") then
              visitedChests[key35] = nil
            end
          end

          local count5 = 0
          local count6 = 0

          for index51, value91 in ipairs(chestTagged) do
            if f68(value91) and f71(value91) then
              count5 = count5 + 1

              if not visitedChests[value91] then
                count6 = count6 + 1
              end
            end
          end

          if count5 > 0 and count6 == 0 then
            table.clear(visitedChests)
          end

          for index52, value92 in ipairs(chestTagged) do
            if f68(value92) and f71(value92) and not visitedChests[value92] then
              local v468 = f67(value92)

              if v468 then
                local magnitude13 = (humanoidRootPart37.Position - v468).Magnitude
                local isDescendantOf4 = value92:IsDescendantOf(workspace)
                local v469 = false

                if isDescendantOf4 and not v467 then
                  v469 = true
                elseif isDescendantOf4 == v467 and magnitude13 < huge8 then
                  v469 = true
                end

                if v469 then
                  v467 = isDescendantOf4
                  v465 = value92
                  huge8 = magnitude13
                end
              end
            end
          end
        else
          for index53, value93 in ipairs(chestTagged) do
            if f68(value93) and f71(value93) then
              local v470 = f67(value93)

              if v470 then
                local magnitude14 = (humanoidRootPart37.Position - v470).Magnitude
                local v471 = f70(value93)
                local isDescendantOf5 = value93:IsDescendantOf(workspace)
                local v472 = false

                if v471 > v466 then
                  v472 = true
                elseif v471 == v466 then
                  if isDescendantOf5 and not v467 then
                    v472 = true
                  elseif isDescendantOf5 == v467 and magnitude14 < huge8 then
                    v472 = true
                  end
                end

                if v472 then
                  v467 = isDescendantOf5
                  v466 = v471
                  v465 = value93
                  huge8 = magnitude14
                end
              end
            end
          end
        end

        return v465
      end
    end

    function v456:GetRaidIslands()
      local locations2 = worldOrigin:WaitForChild("Locations")

      for i30 = 5, 1, -1 do
        local v473 = "Island " .. i30

        for index54, value94 in ipairs(locations2:GetChildren()) do
          if value94.Name == v473 and value94:IsA("Part")
            and (localPlayer.Character.PrimaryPart.Position - value94.Position).Magnitude < 3500 then
            return value94
          end
        end
      end
    end

    function v456:GetCurrentRaidIslandIndex()
      local getRaidIslands = self:GetRaidIslands()

      if getRaidIslands and getRaidIslands.Name:match("Island (%d+)") then
        return tonumber(getRaidIslands.Name:match("Island (%d+)"))
      end

      return nil
    end

    function v456:GetDungeonProps(p152)
      if not p152 then
        return nil
      elseif not p152:FindFirstChild("Props") then
        return nil
      else
        local v474, v475 = p152.Props:GetChildren()

        for key36, value95 in next, v474, v475 do
          if value95:GetAttribute("KitsuneMarkActive") == true
            or value95:GetAttribute("Speed") == 5 then
            return value95
          end
        end

        return nil
      end
    end

    function v456:Checkelites()
      for key37, value96 in pairs({ "Urban", "Deandre", "Diablo" }) do
        if utilities:CheckMon(value96) then
          return value96
        end
      end

      for key38, value97 in pairs({ "Urban", "Deandre", "Diablo" }) do
        if VerifyQuest(value97) then
          return value97
        end
      end

      return nil
    end

    function v456:DetectPirateRaid()
      local vector7 = Vector3.new(-5542, 314, -2971)

      for index55, value98 in ipairs(v4.Enemies:GetChildren()) do
        local humanoidRootPart38 = value98:FindFirstChild("HumanoidRootPart")
          or value98.PrimaryPart

        local v476 = humanoidRootPart38
        local humanoid16 = value98:FindFirstChildOfClass("Humanoid")

        if humanoidRootPart38 then
          local v477 = humanoid16

          if humanoid16 then
            local v478 = humanoid16.Health > 0
            local v479 = v478

            if v478 then
              local v480 = (humanoidRootPart38.Position - vector7).Magnitude <= 1200
              local v481 = v480

              if v480 then
                local name13 = value98.Name

                v481 = not string.find(name13:lower(), "indra")
                  and not string.find(value98.Name, "Boss") and value98.Name ~= "Blank Buddy"
              end

              v479 = v481
            end

            v477 = v479
          end

          v476 = v477
        end

        if v476 then
          return value98
        end
      end

      return nil
    end

    function v456.PreventHappen(p153)
      if utilities:Checkfruit() or utilities:CheckToolName("Microchip")
        or utilities:CheckToolName("Special Microchip")
        or utilities:CheckToolName("Fist of Darkness")
        or utilities:CheckToolName("God's Chalice")
        or localPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible
        or localPlayer:GetAttribute("IslandRaiding") then
        return true
      end

      return false
    end

    function v456:GetDungeonIslands()
      local dungeon = map:FindFirstChild("Dungeon")

      if not dungeon then
        return nil
      else
        local huge9 = math.huge
        local v482 = nil
        local v483 = 0

        for i31 = 1, 100 do
          local findFirstChild5 = dungeon:FindFirstChild(tostring(i31))

          if findFirstChild5 then
            local magnitude15 = (waitForChild2.Position - findFirstChild5:GetPivot().Position).Magnitude
            local getExtentsSize = findFirstChild5:GetExtentsSize()

            if magnitude15
                < math.max(getExtentsSize.X, getExtentsSize.Y, getExtentsSize.Z) / 2 + 100
              and magnitude15 < huge9 then
              v483 = i31
              v482 = findFirstChild5
              huge9 = magnitude15
            end
          end
        end

        if not v482 then
          return nil
        elseif not dungeon:FindFirstChild(tostring(v483 + 1)) then
          return nil
        else
          if v482:FindFirstChild("ExitTeleporter")
            and v482.ExitTeleporter:FindFirstChild("Root") then
            return v482.ExitTeleporter.Root
          end

          return nil
        end
      end
    end

    function v456.HazePosition(p154)
      local questHaze = localPlayer:FindFirstChild("QuestHaze")

      if not questHaze then
        return nil
      else
        local position42 = nil
        local huge10 = math.huge

        for index56, value99 in ipairs(questHaze:GetChildren()) do
          if value99.Value > 0 then
            for key39, value100 in pairs(enemies:GetChildren()) do
              if value100:IsA("Model") and string.find(value100.Name, value99.Name)
                and value100:FindFirstChild("HumanoidRootPart")
                and value100:FindFirstChild("HazeESP") then
                local distanceFromCharacter = localPlayer:DistanceFromCharacter(value100.HumanoidRootPart.Position)

                if distanceFromCharacter < huge10 then
                  position42 = value100.HumanoidRootPart.Position
                  huge10 = distanceFromCharacter
                end
              end
            end

            if not position42 then
              local v484 = nil

              for key40, value101 in pairs(worldOrigin.EnemySpawns:GetChildren()) do
                if string.find(value101.Name, value99.Name)
                  and not value101:FindFirstChild("Ignored") then
                  local distanceFromCharacter2 = localPlayer:DistanceFromCharacter(value101.Position)

                  if distanceFromCharacter2 < huge10 then
                    huge10 = distanceFromCharacter2
                    position42 = value101.Position
                    v484 = value101
                  end
                end
              end

              if v484 and huge10 <= 100 then
                Instance.new("IntValue", v484).Name = "Ignored"
              elseif not v484 then
                for key41, value102 in pairs(worldOrigin.EnemySpawns:GetChildren()) do
                  if string.find(value102.Name, value99.Name)
                    and value102:FindFirstChild("Ignored") then
                    value102.Ignored:Destroy()
                  end
                end
              end
            end
          end
        end

        return position42
      end
    end

    function v456.HazeMobs(p155)
      local questHaze2 = localPlayer:FindFirstChild("QuestHaze")

      if not questHaze2 then
        return nil
      else
        local v485 = nil
        local huge11 = math.huge

        for index57, value103 in ipairs(questHaze2:GetChildren()) do
          if value103.Value > 0 then
            for key42, value104 in pairs(enemies:GetChildren()) do
              if value104:IsA("Model") and string.find(value104.Name, value103.Name)
                and value104:FindFirstChild("HumanoidRootPart")
                and value104:FindFirstChild("Humanoid") and value104.Humanoid.Health > 0
                and value104:FindFirstChild("HazeESP") and v33:IsReady(value104) then
                local distanceFromCharacter3 = localPlayer:DistanceFromCharacter(value104.HumanoidRootPart.Position)

                if distanceFromCharacter3 < huge11 then
                  v485 = value104
                  huge11 = distanceFromCharacter3
                end
              end
            end
          end
        end

        return v485
      end
    end

    function v456:GetPathButton()
      local v486, v487 = map["Boat Castle"].Summoner:FindFirstChild("Circle"):GetChildren()

      for key43, value105 in next, v486, v487 do
        if value105 and value105.Name == "Part" and value105:FindFirstChild("Part")
          and value105.Part.BrickColor ~= BrickColor.new("Lime green") then
          return value105.Part
        end
      end
    end

    function v456:GetPathFruit()
      local v488, v489 = v4:GetChildren()

      for key44, value106 in next, v488, v489 do
        if value106:IsA("Tool") or value106:IsA("Model") and string.find(value106.Name, "Fruit") then
          return value106
        end
      end
    end

    function v456:CheckQuestStatus()
      pcall(function()
        net:WaitForChild("RF/DragonHunter"):InvokeServer({ Context = "RequestQuest" })
      end)

      local invokeServer

      pcall(function()
        invokeServer = net:WaitForChild("RF/DragonHunter"):InvokeServer({ Context = "Check" })
      end)

      local v490 = false
      local v491, v492, v493

      if invokeServer and invokeServer.Text then
        local v494 = tostring(invokeServer.Text)

        if v494:find("Destroy") or v494:find("Tree") then
          v490 = true
          v492 = 2
          v491 = tonumber(v494:match("%d+")) or 10
          v493 = "Tree"
        elseif v494:find("Defeat") or v494:find("Enforcer") or v494:find("Assailant")
          or v494:find("Venomous") then
          v492 = 1
          v490 = true
          v491 = tonumber(v494:match("%d+")) or 0

          for index58, value107 in ipairs({ "Hydra Enforcer", "Venomous Assailant" }) do
            if v494:find(value107) or v494:find(value107:gsub(" ", "")) then
              v493 = value107
              break
            end
          end

          if not v493 then
            if v494:find("Venomous") or v494:find("Assailant") then
              v493 = "Venomous Assailant"
            else
              v493 = "Hydra Enforcer"
            end
          end
        end
      end

      return v490, v493, v491, v492
    end

    function v456:TaskDone()
      local notifications = localPlayer.PlayerGui:FindFirstChild("Notifications")

      if notifications then
        for index59, value108 in ipairs(notifications:GetChildren()) do
          for index60, value109 in ipairs(value108:GetChildren()) do
            if value109:IsA("TextLabel")
              and (string.find(value109.Text, "Task completed!")
                or string.find(value109.Text, "Head back to the Dojo")) then
              return true
            end
          end
        end

        return false
      end

      return false
    end

    function v456:DodgeSeabeast()
      for index61, value110 in ipairs(worldOrigin:GetChildren()) do
        if value110:IsA("Part") then
          if value110.BrickColor == BrickColor.new("Toothpaste")
            or value110.BrickColor == BrickColor.new("Institutional white")
            or value110.Name:find("LightBullet") then
            return true
          end
        end
      end

      return false
    end

    function v456:TerrorDodge()
      for index62, value111 in ipairs(worldOrigin:GetChildren()) do
        local lower11 = value111.Name:lower()

        if lower11:find("sharkslam") or lower11:find("spin") or lower11:find("chargemodel") then
          return true
        end
      end

      return false
    end

    local v495 = {
      ["Sea Beast"] = "SeaBeast",
      ["Terror Shark"] = "Terrorshark",
      Shark = "Shark",
      Piranha = "Piranha",
      ["Fish Crew Member"] = "Fish Crew Member",
      ["Pirate Brigade"] = "PirateBrigade",
      ["Pirate Grand Brigade"] = "PirateGrandBrigade",
      ["Ghost Ship"] = "FishBoat",
    }

    local v496 = {}

    function v456:GetSeaEventTargets()
      local seaEventTargets = v19.SeaEventTargets
      local v497 = clearNew(v496)

      if not seaEventTargets then
        return v497
      end

      if type(seaEventTargets) == "table" then
        for key45, value112 in pairs(seaEventTargets) do
          if value112 == true then
            local v498 = v495[key45] or key45
            table.insert(v497, v498)
          elseif type(key45) == "number" and type(value112) == "string" then
            local v499 = v495[value112] or value112
            table.insert(v497, v499)
          end
        end
      elseif type(seaEventTargets) == "string" then
        local v500 = v495[seaEventTargets] or seaEventTargets
        table.insert(v497, v500)
      end

      return v497
    end

    function v456:TyrantEyes()
      local islandModel = map:FindFirstChild("TikiOutpost")
        and map.TikiOutpost:FindFirstChild("IslandModel")

      if not islandModel then
        return 0
      else
        local e = islandModel:FindFirstChild("IslandChunks")
          and islandModel.IslandChunks:FindFirstChild("E")

        local count7 = 0

        for index63, value113 in ipairs({
          islandModel:FindFirstChild("Eye1"), islandModel:FindFirstChild("Eye2"),
          e:FindFirstChild("Eye3"), e:FindFirstChild("Eye4"),
        }) do
          if value113 and value113.Transparency == 0 then
            count7 = count7 + 1
          end
        end

        return count7
      end
    end

    function v456:CheckSeaLevel()
      local v501 = {
        "Level 1", "Level 2", "Level 3", "Level 4", "Level 5", "Level 6", "Infinite",
      }

      local v502 = {
        ["Level 1"] = CFrame.new(-21998.375, 30.0006, -682.309),
        ["Level 2"] = CFrame.new(-26779.5215, 30.0005, -822.858),
        ["Level 3"] = CFrame.new(-31171.957, 30.0001, -2256.9377),
        ["Level 4"] = CFrame.new(-34054.6875, 30.2187, -2560.1201),
        ["Level 5"] = CFrame.new(-38887.5547, 30.0004, -2162.9902),
        ["Level 6"] = CFrame.new(-44541.7617, 30.0003, -1244.8584),
        Infinite = CFrame.new(-10000000, 31, 37016.25),
      }

      local seaLevelSelected = v19.SeaLevelSelected

      if typeof(seaLevelSelected) == "number" then
        seaLevelSelected = v501[seaLevelSelected] or "Level 6"
      end

      return v502[seaLevelSelected] or v502["Level 6"] or v502["Level 1"]
    end

    function v456:CheckBerries()
      local v503, v504 = v6:GetTagged("BerryBush")

      for key46, value114 in next, v503, v504 do
        for key47, value115 in pairs(value114:GetAttributes()) do
          if key47:sub(1, 12) == "_BerryCFrame" and type(value115) == "string" and #value115 > 0 then
            return true
          end
        end

        for index64, value116 in ipairs(value114:GetChildren()) do
          if value116:IsA("Model") or value116:IsA("BasePart") then
            return true
          end
        end
      end

      return false
    end

    return v456
  end

  v44 = {
    Fishman = cframe4,
    Human = cframe5,
    Cyborg = cframe6,
    Skypiea = cframe7,
    Ghoul = cframe8,
    Mink = cframe9,
  }

  v33.GameData = f63()

  local function f72()
    local v505 = {}

    function v505:Attack(p156, p157)
      if not p156 then
        return
      elseif not character then
        return
      else
        local humanoid17 = p156:FindFirstChildOfClass("Humanoid")
        local humanoidRootPart39 = p156:FindFirstChild("HumanoidRootPart") or p156.PrimaryPart

        if not humanoidRootPart39 then
          return
        end

        if p156:IsDescendantOf(v4) and humanoid17 and humanoid17.Health <= 0 then
          return
        end

        tweenManager:topos(utilities:GetFarmCFrame(humanoidRootPart39), true)

        if p156:IsDescendantOf(v4) then
          if v19.MasteryFarm then
            if humanoid17 and humanoid17.Health / humanoid17.MaxHealth > v19.HealthMob / 100 then
              AimbotMob = nil
              utilities:EquipWeapon()
            else
              AimbotMob = humanoidRootPart39
              f3()
              AimbotMob = nil
            end
          else
            AimbotMob = nil

            if v19.AutoMasterySwords then
              utilities:EquipWeapon("Sword")
            else
              utilities:EquipWeapon()
            end
          end

          utilities:AutoHaki()

          if p157 ~= false and v19.BringMonster then
            utilities:BringEnemies(p156)
          end
        end

        return
      end
    end

    function GetNearestBoatDealerCF()
      local position43 = localPlayer.Character and localPlayer.Character:GetPivot().Position
        or Vector3.zero

      local huge12 = math.huge
      local npCs = v4:FindFirstChild("NPCs")
      local cframe10

      if npCs then
        for index65, value117 in ipairs(npCs:GetChildren()) do
          if value117.Name:find("Boat Dealer") or value117.Name:find("Luxury Boat") then
            local getPivot2 = value117:GetPivot()
            local magnitude16 = (getPivot2.Position - position43).Magnitude

            if magnitude16 < huge12 then
              huge12 = magnitude16
              cframe10 = getPivot2
            end
          end
        end
      end

      local v506

      if not cframe10 or huge12 > 15000 then
        if v26 then
          v506 = {
            Vector3.new(-16927.451, 9.086, 433.864), Vector3.new(-5400, 15, -2900),
            Vector3.new(-6078, 15, -2207), Vector3.new(-13274, 15, -7814),
            Vector3.new(5200, 15, 1000), Vector3.new(2284, 15, 905),
          }
        elseif v25 then
          v506 = {
            Vector3.new(-5330, 5, -714), Vector3.new(-25, 15, 874),
            Vector3.new(-2200, 15, -3000), Vector3.new(600, 15, -5300),
            Vector3.new(-3000, 15, -10000),
          }
        else
          v506 = {
            Vector3.new(94, 5, 1374), Vector3.new(-2800, 5, 2100), Vector3.new(-1400, 15, 300),
            Vector3.new(-1100, 15, 3900), Vector3.new(1060, 16, 1428),
            Vector3.new(-650, 15, 1500), Vector3.new(1100, 15, -1200),
            Vector3.new(-4800, 15, 4200), Vector3.new(4800, 15, 700),
            Vector3.new(5100, 15, 4100),
          }
        end

        for index66, value118 in ipairs(v506) do
          local magnitude17 = (value118 - position43).Magnitude

          if magnitude17 < huge12 then
            huge12 = magnitude17
            cframe10 = CFrame.new(value118)
          end
        end
      end

      return cframe10 or v26 and CFrame.new(-16927.451, 9.086, 433.864)
        or v25 and CFrame.new(-5330, 5, -714) or CFrame.new(94, 5, 1374)
    end

    function NormalizeBoatName(p158)
      local boatSelected = p158 or v19.BoatSelected

      if typeof(boatSelected) == "number" and Data and Data.BoatsList then
        boatSelected = Data.BoatsList[boatSelected]
      end

      if typeof(boatSelected) ~= "string" or boatSelected == "" then
        boatSelected = v26 and "Beast Hunter" or "PirateBrigade"
      end

      local team = localPlayer and localPlayer.Team and tostring(localPlayer.Team) or "Pirates"

      if string.find(team, "Marine") ~= nil then
        if boatSelected == "PirateSloop" or boatSelected == "Sloop" then
          return "MarineSloop"
        end

        if boatSelected == "PirateBrigade" or boatSelected == "Brigade" then
          return "MarineBrigade"
        end

        if boatSelected == "PirateGrandBrigade" or boatSelected == "Grand Brigade" then
          return "MarineGrandBrigade"
        end

        return boatSelected
      end

      if boatSelected == "MarineSloop" or boatSelected == "Sloop" then
        return "PirateSloop"
      end

      if boatSelected == "MarineBrigade" or boatSelected == "Brigade" then
        return "PirateBrigade"
      end

      if boatSelected == "MarineGrandBrigade" or boatSelected == "Grand Brigade" then
        return "PirateGrandBrigade"
      end

      return boatSelected
    end

    v33.NormalizeBoatName = NormalizeBoatName

    function BuyBoatSafe(p159, p160)
      local v507 = NormalizeBoatName(p159)
      local v508 = not p160
      local v509 = GetNearestBoatDealerCF()

      if v508 and utilities and utilities:GetDistance(v509) > 25 then
        tweenManager:topos(v509)
        return false
      end

      commF:InvokeServer("BuyBoat", v507)
      return true
    end

    function v505:AutoBoatSail(p161)
      local character27 = localPlayer.Character
      local humanoid18 = character27 and character27:FindFirstChildOfClass("Humanoid")

      local humanoidRootPart40 = character27
        and (character27:FindFirstChild("HumanoidRootPart") or character27.PrimaryPart)

      if not character27 or not humanoid18 or humanoid18.Health <= 0 or not humanoidRootPart40 then
        tweenManager:StopBoatTween()
        return
      else
        local v510 = GetSelectedBoat()
        local v511 = false

        if not v510 or not IsBoatAlive(v510) then
          v511 = true
        elseif (humanoidRootPart40.Position - v510:GetPivot().Position).Magnitude > 3000 then
          v511 = true
        end

        if v511 then
          tweenManager:StopBoatTween()
          local tikiOutpost = worldOrigin.Locations:FindFirstChild("Tiki Outpost")
          local position44 = tikiOutpost and tikiOutpost.Position

          local vector8 = position44
          vector8 = position44 or Vector3.new(-16641.5, 213.3, 435.4)

          if (humanoidRootPart40.Position - vector8).Magnitude > 3000 then
            if character27:FindFirstChild("Head") then
              character27.Head:Destroy()
            else
              humanoid18.Health = 0
            end

            return
          else
            local v512 = GetNearestBoatDealerCF()

            if (humanoidRootPart40.Position - v512.Position).Magnitude <= 25 then
              BuyBoatSafe(v19.BoatSelected)
            else
              tweenManager:topos(v512)
            end

            return
          end
        else
          local findFirstChildWhichIsA4 = v510:FindFirstChildWhichIsA("VehicleSeat", true)
            or v510:FindFirstChild("VehicleSeat", true)
            or v510:FindFirstChildWhichIsA("Seat", true)

          if v19.AutoRepairBoat and v505:AutoRepairBoat(v510) then
            tweenManager:StopBoatTween()
            return
          elseif not humanoid18.Sit then
            tweenManager:StopBoatTween()

            if findFirstChildWhichIsA4 and findFirstChildWhichIsA4:IsA("BasePart") then
              tweenManager:topos(findFirstChildWhichIsA4.CFrame * CFrame.new(0, 1.5, 0))
              task.wait(0.3)
            end

            return
          else
            tweenManager:toposboat(p161 or gameData:CheckSeaLevel())
            return
          end
        end
      end
    end

    function v505:AutoRepairBoat(p162)
      local character28 = localPlayer.Character
      local humanoid19 = character28 and character28:FindFirstChildOfClass("Humanoid")

      if not (character28 and humanoid19 and humanoid19.Health > 0) then
        return false
      else
        local playerGui5 = localPlayer:FindFirstChild("PlayerGui")
        local main5 = playerGui5 and playerGui5:FindFirstChild("Main")
        local bottomHUDList = main5 and main5:FindFirstChild("BottomHUDList")
        local shipHealthBar = bottomHUDList and bottomHUDList:FindFirstChild("ShipHealthBar")

        if not (shipHealthBar and shipHealthBar.Visible) then
          return false
        else
          local textLabel4 = shipHealthBar:FindFirstChild("TextLabel")

          if not (textLabel4 and textLabel4.Text) then
            return false
          else
            local v513 = string.split(string.gsub(textLabel4.Text, "Ship ", ""), "/")
            local v514 = tonumber(v513[1])
            local v515 = tonumber(v513[2])

            if not (v514 and v515 and v514 < v515) then
              return false
            else
              local v516 = p162 or GetSelectedBoat()

              if not v516 then
                return false
              else
                local primaryPart8 = v516.PrimaryPart or v516:FindFirstChild("VehicleSeat")
                  or v516:FindFirstChildWhichIsA("BasePart")

                if not primaryPart8 then
                  return false
                end

                if localPlayer:DistanceFromCharacter(primaryPart8.Position) < 20 then
                  if not humanoid19.Sit then
                    local repairHammer = character28:FindFirstChild("_RepairHammer")

                    if repairHammer then
                      local m1UP = repairHammer:FindFirstChild("M1UP")

                      if m1UP then
                        m1UP:Destroy()
                      elseif not repairHammer:GetAttribute("Repairing") then
                        local m1Down = repairHammer:FindFirstChild("M1Down")

                        if m1Down then
                          m1Down:FireServer("Default")
                          task.wait(0.5)
                        end
                      end
                    else
                      local repairHammer2 = utilities:CheckToolName("_RepairHammer")

                      if repairHammer2 and repairHammer2.Parent == localPlayer.Backpack then
                        humanoid19:EquipTool(repairHammer2)
                        task.wait(0.2)
                      else
                        local subclassNetwork = remotes:FindFirstChild("SubclassNetwork")

                        local useSubclass = subclassNetwork

                        useSubclass = subclassNetwork
                          and subclassNetwork:FindFirstChild("UseSubclass")

                        if useSubclass then
                          useSubclass:InvokeServer({ Action = "RequestHammer" })
                          task.wait(3)
                        end
                      end
                    end
                  else
                    humanoid19.Sit = false
                    tweenManager:topos(primaryPart8.CFrame * CFrame.new(0, 15, 0))
                  end
                else
                  tweenManager:topos(primaryPart8.CFrame * CFrame.new(0, 15, 0))
                end

                return true
              end
            end
          end
        end
      end
    end

    function v505:AttackTree()
      local eagleBossArena = map:FindFirstChild("TikiOutpost")
        and map.TikiOutpost:FindFirstChild("IslandModel")
        and map.TikiOutpost.IslandModel:FindFirstChild("IslandChunks")
        and map.TikiOutpost.IslandModel.IslandChunks:FindFirstChild("D")
        and map.TikiOutpost.IslandModel.IslandChunks.D:FindFirstChild("EagleBossArena")

      if not eagleBossArena then
        return
      end

      for index67, value119 in ipairs(eagleBossArena:GetChildren()) do
        if value119.Name == "Tree" and value119:IsA("Model")
          and value119:FindFirstChild("Group") then
          local v517 = value119.Group:GetChildren()[1]

          if v517 then
            local position45 = v517.CFrame.Position
            tweenManager:topos(v517.CFrame * CFrame.new(0, 15, 0))

            if localPlayer:DistanceFromCharacter(position45) <= 75 then
              if v19.ShootGunTyrant then
                local selectGunTyrant = v19.SelectGunTyrant or "Skull Guitar"

                if not localPlayer.Character:FindFirstChild(selectGunTyrant) then
                  local findFirstChild6 = localPlayer.Backpack:FindFirstChild(selectGunTyrant)

                  local skullGuitar = findFirstChild6

                  skullGuitar = findFirstChild6
                    or localPlayer.Backpack:FindFirstChild("Skull Guitar")

                  if skullGuitar and localPlayer.Character:FindFirstChild("Humanoid") then
                    localPlayer.Character.Humanoid:EquipTool(skullGuitar)
                  else
                    commF:InvokeServer("LoadItem", selectGunTyrant)
                  end

                  task.wait(0.2)
                end

                utilities:EquipWeapon("Gun")
                task.wait(0.15)
                customShoot(position45)
              else
                Aimbot = position45
                f3()
                Aimbot = nil
              end

              break
            end
          end
        end
      end
    end

    function v505:AttackTarget(p163)
      if not p163 or not p163.Parent then
        return
      else
        local net2 = v5:FindFirstChild("Modules") and v5.Modules:FindFirstChild("Net")

        if not self._RegisterAttack then
          self._RegisterAttack = net2 and net2:FindFirstChild("RE/RegisterAttack")
        end

        if not self._RegisterHit then
          self._RegisterHit = net2 and net2:FindFirstChild("RE/RegisterHit")
        end

        local basePart8 = p163:IsA("BasePart") and p163 or p163.PrimaryPart
          or p163:FindFirstChild("RootPart") or p163:FindFirstChild("Hitbox")
          or p163:FindFirstChild("Handle") or p163:FindFirstChildWhichIsA("BasePart", true)

        if not basePart8 then
          return
        end

        if fastAttack and fastAttack.CurrentTarget then
          fastAttack.CurrentTarget(p163)
        end

        if fastAttack and fastAttack.Attack then
          fastAttack.Attack()
        end

        if self._RegisterAttack then
          pcall(function() self._RegisterAttack:FireServer(0) end)
        end

        if self._RegisterHit then
          pcall(function()
            self._RegisterHit:FireServer(basePart8, { { nil, basePart8 } })
            self._RegisterHit:FireServer(basePart8)
          end)
        end

        return
      end
    end

    return v505
  end

  gameData = v33.GameData
  v33.SubFunction = f72()
  subFunction = v33.SubFunction

  v33.Functions = v33.Functions or {}
  v33.Loops = v33.Loops or {}
  v33.FunctionList = v33.FunctionList or {}
  v33.ActiveFunction = v33.ActiveFunction or nil
  v33.FunctionDisplayNames = v33.FunctionDisplayNames or {}

  v45 = {
    "AutoFactoryRaid", "AutoFarmPirateRaid", "AutoSoulReaper", "AutoTaskEliteHunter",
    "AutoTrickOrTreat", "AutoCollectPumpkin", "Tweenfruit", "AutoBerrySafe",
  }

  function v33.IsMultiFunction(p164)
    for index68, value120 in ipairs(v45) do
      if value120 == p164 then
        return true
      end
    end

    return false
  end

  bossMap = utilBloxFruitModulePreloadDataLua.BossMap or {}
  bossHopNames = utilBloxFruitModulePreloadDataLua.BossHopNames or {}

  function v33.LoadLibrary()
    local window = devNiulaiLua:CreateWindow({
      Title = "CAT HUB",
      Subtitle = "Blox Fruits | Created by CATJack.gg",
      Logo = "rbxassetid://126031329785796",
      Version = "v.Freemium",
      Key = true,
      Theme = "Gold",
      Weather = "Sakura",
      Credits = {
        { Name = "CATJack.gg", Role = "Credit" },
      },
      SaveFile = "CAT_HUB_BloxFruits",
    })

    -- Compatibility bridge: keep Catblox's existing control calls while using
    -- the embedded rose-petal library's current API.
    function window:AddTab(name, icon)
      local tab = self:Tab({ Name = name, Icon = icon })

      function tab:addToggle(title, default, callback, locked, description, flag, condition, subtoggles)
        return self:Toggle({
          Name = title,
          Default = default,
          Callback = callback,
          Disabled = locked == true,
          Description = description,
          Flag = flag,
        })
      end

      function tab:addDropdown(title, options, default, callback, locked, description, flag)
        return self:Dropdown({
          Name = title,
          Options = options,
          Default = default,
          Callback = callback,
          Disabled = locked == true,
          Description = description,
          Flag = flag,
        })
      end

      function tab:addSlider(title, minValue, maxValue, default, callback, locked, step, flag)
        return self:Slider({
          Name = title,
          Min = minValue,
          Max = maxValue,
          Default = default,
          Step = step or 1,
          Callback = callback,
          Disabled = locked == true,
          Flag = flag,
        })
      end

      function tab:addTextbox(title, callback, confirmText, flag)
        return self:Input({
          Name = title,
          Placeholder = confirmText or "",
          Callback = callback,
          Flag = flag,
        })
      end

      return tab
    end

    pcall(function()
      window:SetWeather("Sakura")
    end)

    -- CAT HUB branding: replace any library-provided header logo with the CAT HUB logo.
    -- Only image objects whose names identify them as logos are changed.
    local CAT_HUB_LOGO = "rbxassetid://126031329785796"
    local function applyCatHubLogo(root)
      if not root then
        return
      end

      for _, guiObject in ipairs(root:GetDescendants()) do
        if guiObject:IsA("ImageLabel") or guiObject:IsA("ImageButton") then
          local objectName = guiObject.Name:lower()
          local replaceImage = objectName:find("logo", 1, true) ~= nil

          if replaceImage then
            pcall(function()
              guiObject.Image = CAT_HUB_LOGO
            end)
          end
        end
      end
    end

    task.spawn(function()
      local coreGui = game:GetService("CoreGui")
      for _ = 1, 16 do
        pcall(function()
          applyCatHubLogo(localPlayer:FindFirstChildOfClass("PlayerGui"))
        end)
        pcall(function()
          applyCatHubLogo(coreGui)
        end)
        task.wait(0.25)
      end
    end)

    local v518 = {
      Home = window:AddTab("Home", "home-quantum"),
      Sub = window:AddTab("Sub Farm", "swords-quantum"),
      Sevent = window:AddTab("Sea Event", "ship-quantum"),
      Player = window:AddTab("Player", "user-quantum"),
      Dragon = window:AddTab("Dragon Update", "visual-quantum"),
      Raid = window:AddTab("Dungeon", "raid-quantum"),
      Trial = window:AddTab("Trials", "rabbit-quantum"),
      Travel = window:AddTab("Travel", "map-quantum"),
      Shop = window:AddTab("Tiktok Shop", "cart-quantum"),
      Misc = window:AddTab("Misc", "misc-quantum"),
      Web = window:AddTab("Webhook", "cat-quantum"),
    }

    local v519 = {}

    function v519:CreateToggle(p165, p166, p167, p168, p169)
      local v520 = p169
      v520 = v520 or {}

      if v520.global then
        v19[p167] = p168
      end

      v33.Toggles = v33.Toggles or {}
      local v521 = v520.save ~= false and p167 or nil

      local f73

      function f73(p170, p171)
        local v522 = p170 and p170[p167]

        if not v522 then
          return
        end

        if p171 and v522.Start then
          v522.Start()
        elseif not p171 and v522.Stop then
          v522.Stop()
        elseif not p171 then
          v522.Running = false
        end
      end

      local addToggle = p165:addToggle(p166, p168, function(p172)
        v19[p167] = p172

        f73(v33.Functions, p172)
        f73(v33.Loops, p172)

        if not p172 and v33.ActiveFunction == p167 then
          v33.ActiveFunction = nil
        end

        if type(v520.callback) == "function" then
          v520.callback(p172)
        end
      end, v520.locked, v520.description, v521, v520.condition, v520.subtoggles or v520.SubToggles)

      if p167 then
        v33.Toggles[p167] = addToggle
      end

      return addToggle
    end

    function v519:CreateDropdown(p173, p174, p175, p176, p177, p178, p179)
      local v523 = p178
      v523 = v523 or {}

      if v523.global then
        v19[p175] = p176
      end

      local v524 = v523.save ~= false and p175 or nil

      return p173:addDropdown(p174, p176, p177, function(p180)
        if v523.global then
          v19[p175] = p180
        end

        v19[p175] = p180

        if type(v523.callback) == "function" then
          v523.callback(p180)
        end
      end, v523.locked, p179, v524)
    end

    function v519:CreateSlider(p181, p182, p183, p184, p185, p186, p187)
      local v525 = p187
      v525 = v525 or {}

      if v525.global then
        v19[p183] = p186
      end

      local v526 = v525.save ~= false and p183 or nil

      return p181:addSlider(p182, p184, p185, p186, function(p188)
        if v525.global then
          v19[p183] = p188
        end

        v19[p183] = p188

        if type(v525.callback) == "function" then
          v525.callback(p188)
        end
      end, v525.locked, v525.step, v526)
    end

    function v519:CreateTextbox(p189, p190, p191, p192)
      local v527 = p192
      v527 = v527 or {}

      if v527.global then
        v19[p191] = v527.default or ""
      end

      local v528 = v527.save ~= false and p191 or nil

      return p189:addTextbox(p190, function(p193)
        if v527.global then
          v19[p191] = p193
        end

        v19[p191] = p193

        if type(v527.callback) == "function" then
          v527.callback(p193)
        end
      end, v527.confirmText, v528)
    end

    local v529 = v24 and "Sea_1" or v25 and "Sea_2" or v26 and "Sea_3"

    local v530 = {}

    v530.Materials = utilBloxFruitModulePreloadDataLua.Materials and v529
        and utilBloxFruitModulePreloadDataLua.Materials[v529]
      or {}

    v530.BossNames = utilBloxFruitModulePreloadDataLua.BossNames and v529
        and utilBloxFruitModulePreloadDataLua.BossNames[v529]
      or {}

    v530.BoatsList = utilBloxFruitModulePreloadDataLua.BoatsList or {}
    v530.ZoneList = utilBloxFruitModulePreloadDataLua.ZoneList or {}
    v530.SeaEventTargets = utilBloxFruitModulePreloadDataLua.SeaEventTargets or {}
    v530.RodsList = utilBloxFruitModulePreloadDataLua.RodsList or {}
    v530.BaitsList = utilBloxFruitModulePreloadDataLua.BaitsList or {}

    local v531 = {}

    pcall(function()
      local v532 = require(v5.Raids)

      for key48, value121 in pairs(v532.raids) do
        table.insert(v531, value121)
      end

      for key49, value122 in pairs(v532.advancedRaids) do
        table.insert(v531, value122)
      end
    end)

    v530.Raids_Chip = v531
    v530.DungeonCards = utilBloxFruitModulePreloadDataLua.DungeonCards or {}
    v530.TrainMethods = utilBloxFruitModulePreloadDataLua.TrainMethods or {}

    local v533 = v24 and "Sea 1" or v25 and "Sea 2" or v26 and "Sea 3" or nil
    v530.ActiveIslands = v533 and islands and islands[v533] or {}
    local v534 = {}

    for key50, value123 in next, v530.ActiveIslands, nil do
      table.insert(v534, key50)
    end

    v530.IslandsList = v534
    local v535 = {}
    local ignoreNPC = utilBloxFruitModulePreloadDataLua.IgnoreNPC or { "Quest", "Boat", "Home" }
    local v536 = next
    local v537, v538 = v5.NPCs:GetChildren()

    for v539, v540 in v536, v537, v538 do
      local v541 = false
      local lower12 = v540.Name:lower()

      for key51, value124 in next, ignoreNPC, nil do
        if lower12:find(value124:lower(), 1, true) then
          v541 = true
          break
        end
      end

      if not v541 then
        table.insert(v535, v540.Name)
      end
    end

    v530.NPCList = v535
    v530.LegendarySwordNames = utilBloxFruitModulePreloadDataLua.LegendarySwordNames or {}
    v530.BossHopNames = utilBloxFruitModulePreloadDataLua.BossHopNames or bossHopNames or {}

    local v542 = {}

    for key52 in pairs(v35 or {}) do
      table.insert(v542, key52)
    end

    table.sort(v542)
    v530.MeleeNames = v542

    local function f74(p194)
      local v543 = {}

      for key53, value125 in pairs(p194 or {}) do
        table.insert(v543, key53)
      end

      return v543
    end

    v530.AbilityNames = f74(itemsToBuy and itemsToBuy.Ability)
    v530.GunNames = f74(itemsToBuy and itemsToBuy.Gun)
    v530.AccessoryNames = f74(itemsToBuy and itemsToBuy.Accessory)
    v530.DealerFruitList = utilBloxFruitModulePreloadDataLua.DealerFruitList or {}
    v530.ScrollList = utilBloxFruitModulePreloadDataLua.ScrollList or {}

    v530.ChestTiers = utilBloxFruitModulePreloadDataLua.ChestTiers
      or { "Diamond", "Gold", "Silver" }

    local v544 = {}

    function v544.OnAutoLoadScript()
      if v19.AutoLoadScriptonLoad then
        local v545 = string.format(
          " task.wait(1) getgenv().Team = \"%s\" loadstring(game:HttpGet(\"https://raw.githubusercontent.com/jackiopyu-web/CATHUB./refs/heads/main/Catblox.lua\"))() ",
          v19.TeamSelectLoad or "Pirates"
        )

        if not pcall(function() syn.queue_on_teleport(v545) end) then
          pcall(function() queue_on_teleport(v545) end)
        end
      end
    end

    local function f75()
      if not v26 then
        return "None | 0"
      else
        local v546 = 0

        local v547, v548 = pcall(function()
          return commF:InvokeServer("EliteHunter", "Progress")
        end)

        if v547 and tonumber(v548) then
          v546 = tonumber(v548)
        end

        local checkelites = gameData.Checkelites and gameData:Checkelites()

        return string.format(
          "%s | %s", checkelites and tostring(checkelites) or "None", tostring(v546)
        )
      end
    end

    function v544.ToggleDamageCounter(p195)
      pcall(function() v5.Assets.GUI.DamageCounter.Enabled = not p195 end)
    end

    function v544.ToggleNotifications(p196)
      pcall(function() localPlayer.PlayerGui.Notifications.Enabled = not p196 end)
    end

    local v549

    function v544.ToggleWalkInWater(p197)
      v19.Water = p197

      if p197 then
        if v549 then
          task.cancel(v549)
          v549 = nil
        end

        v549 = spawn(function()
          local map4 = v4:FindFirstChild("Map") or v4:WaitForChild("Map", 5)

          local waterBasePlane = map4
            and (map4:FindFirstChild("WaterBase-Plane")
              or map4:WaitForChild("WaterBase-Plane", 5))

          while v19.Water do
            if waterBasePlane then
              waterBasePlane.Size = Vector3.new(1000, 113, 1000)
            end

            task.wait(0.5)
          end

          if waterBasePlane then
            waterBasePlane.Size = Vector3.new(1000, 80, 1000)
          end
        end)
      end
    end

    local v550 = {
      "red_game43", "rip_indra", "Axiore", "Polkster", "wenlocktoad", "Daigrock",
      "toilamvidamme", "oofficialnoobie", "Uzoth", "Azarth", "arlthmetic", "Death_King",
      "Lunoven", "TheGreateAced", "rip_fud", "drip_mama", "layandikit12", "Hingoi",
    }

    local v551

    function v544.ToggleHopAdmin(p198)
      v19.HopWhenAdmin = p198

      if p198 then
        if v551 then
          task.cancel(v551)
          v551 = nil
        end

        v551 = spawn(function()
          while v19.HopWhenAdmin do
            task.wait(1.5)

            for index69, value126 in ipairs(v3:GetPlayers()) do
              if table.find(v550, value126.Name) then
                if v33 and v33.SendNotify then
                  v33:SendNotify(
                    "Server Hop", "Admin detected (" .. value126.Name .. ")! Hopping...", 5
                  )
                end

                utilities:ServerHop(0)
                break
              end
            end
          end
        end)
      end
    end

    local v552

    function v544.ToggleAntiAFK(p199)
      v19.AntiAFK = p199

      if p199 then
        if v552 then
          task.cancel(v552)
          v552 = nil
        end

        v552 = spawn(function()
          while v19.AntiAFK do
            if v13 then
              pcall(function()
                v13:CaptureController()
                v13:ClickButton1(Vector2.new(0, 0))
              end)
            end

            task.wait(300)
          end
        end)
      end
    end

    local function f76(p200, p201)
      local moonPhase = v8:GetAttribute("MoonPhase") or 1
      local v553 = p201 >= 18 or p201 <= 5.5

      if v8:GetAttribute("IsBlueMoon") == true then
        return "Kitsune Shrine Active"
      elseif v553 then
        local v554 = p201 <= 5.5 and 5.5 - p201 or 24 - p201 + 5.5
        local v555 = math.max(0, math.floor(v554 * 60))
        return string.format("Night Ends in %dm %02ds", math.floor(v555 / 60), v555 % 60)
      else
        local v556 = math.max(0, math.floor((18 - p201) * 60))

        if moonPhase == 5 or p200 and p200:find("Full Moon") then
          return string.format("Rises in %dm %02ds", math.floor(v556 / 60), v556 % 60)
        end

        return string.format("Next Night in %dm %02ds", math.floor(v556 / 60), v556 % 60)
      end
    end

    function v544.RemoveEffects()
      if RemoveEffects then
        RemoveEffects()()
      end
    end

    local function f77()
      if v26 then
        local v557, v558 = pcall(function() return commF:InvokeServer("InfoLeviathan", "1") end)

        if not v557 or not v558 or v558 == -1 then
          return "I don't know anything yet."
        end

        return ({
          [1] = "I haven't heard a thing, mate. It's quiet as a ghost ship out there.",
          [2] = "Some citizens claim they heard something strange, I doubt it though..",
          [3] = "I heard it's been a bit chilly outside. That's a bit strange..",
          [4] = "It's just downright freezing out! What's with these ominous clouds? Something's happening..",
          [5] = "The Leviathan is out there! Go find it before it causes more destruction.",
        })[v558] or "Unknown"
      end

      return "Not Sea 3"
    end

    function v544.BribeLeviathan()
      commF:InvokeServer("InfoLeviathan", "2")
    end

    function v544.GetAllBoats()
      local v559 = { "My Boat" }

      if v4:FindFirstChild("Boats") then
        for index70, value127 in ipairs(v4.Boats:GetChildren()) do
          if value127.Name ~= "Boat" and not table.find(v559, value127.Name) then
            table.insert(v559, value127.Name)
          end
        end
      end

      return v559
    end

    function v544.BuyNewBoat()
      commF:InvokeServer("BuyBoat", NormalizeBoatName and NormalizeBoatName(v19.BoatSelected))
    end

    function v544.OpenFishIndex()
      pcall(function()
        localPlayer:WaitForChild("PlayerGui"):SetAttribute("FishIndexVisible", true)
      end)
    end

    local function f78()
      if v26 then
        if not localPlayer.Character
          or not localPlayer.Character:FindFirstChild("RaceTransformed") then
          if v26 then
            local v560, v561 = pcall(function()
              return v4.HydraIslandClient.RemoteFunction:InvokeServer("Interacted")
            end)

            if v560 and v561 and (v561 == 1 or v561 == 2 or v561 == 3 or v561 == 4) then
              return "Ready For Trial"
            end

            return "Not Ready"
          end

          return "Not Ready"
        else
          local v562, v563, v564, v565 = pcall(function()
            return commF:InvokeServer("UpgradeRace", "Check", 2)
          end)

          if not v562 then
            return "Unknown"
          end

          return ({
            [0] = "Ready For Trial",
            [1] = "Need More Training",
            [2] = "Can Buy Gear With " .. v565 .. " Fragments",
            [3] = "Need More Training",
            [4] = "Can Buy Gear With " .. v565 .. " Fragments",
            [5] = "Race Complete",
            [6] = (v564 or 2) - 2 .. "/3 Upgrades Done",
            [7] = "Can Buy Gear With " .. v565 .. " Fragments",
            [8] = 10 - (v564 or 10) .. " Training Sessions Left",
          })[v563]
        end
      else
        return
      end
    end

    local function f79()
      if not localPlayer.Character
        or not localPlayer.Character:FindFirstChild("RaceTransformed") then
        return "Not Ready"
      else
        local v566, v567, v568, v569 = pcall(function()
          return commF:InvokeServer("UpgradeRace", "Check")
        end)

        if not v566 then
          return "Unknown"
        end

        return ({
          [0] = "Ready For Trial",
          [1] = "Need More Training",
          [2] = "Can Buy Gear With " .. (v569 or "?") .. " Fragments",
          [3] = "Need More Training",
          [4] = "Can Buy Gear With " .. (v569 or "?") .. " Fragments",
          [5] = "Race Complete",
          [6] = (v568 or 2) - 2 .. "/3 Upgrades Done",
          [7] = "Can Buy Gear With " .. (v569 or "?") .. " Fragments",
          [8] = 10 - (v568 or 10) .. " Training Sessions Left",
        })[v567] or "Unknown"
      end
    end

    function v544.GetStatsInfo()
      if not localPlayer:FindFirstChild("Data") or not data then
        return "Loading..."
      else
        local points = data.Points
        local stats2 = data.Stats

        if not stats2 or not points then
          return "No Stats"
        else
          local v570 = { "Points Available: " .. tostring(points.Value) }

          for index71, value128 in ipairs({ "Melee", "Defense", "Sword", "Gun", "Demon Fruit" }) do
            local value129 = stats2:FindFirstChild(value128)
                and stats2[value128]:FindFirstChild("Level") and stats2[value128].Level.Value
              or 0

            table.insert(v570, value128 .. ": " .. value129)
          end

          return table.concat(v570, "\n")
        end
      end
    end

    local function f80()
      local v571, v572 = pcall(function()
        return commF:InvokeServer("LegendarySwordDealer", "1")
      end)

      return v571 and v572 or "Unknown"
    end

    local v573

    function v544.AutoStats()
      local function f81(p202)
        if not data or not data.Points then
          return
        else
          local value130 = data.Points.Value

          if value130 >= 1 and v19.PointsSlider and v19.PointsSlider > 0 then
            commF:InvokeServer("AddPoint", p202, (math.clamp(v19.PointsSlider, 1, value130)))
          end

          return
        end
      end

      if v573 then
        task.cancel(v573)
        v573 = nil
      end

      v573 = spawn(function()
        while v19.AutoStats do
          task.wait(0.3)

          if v19.Melee then
            f81("Melee")
          end

          if v19.Defense then
            f81("Defense")
          end

          if v19.Sword then
            f81("Sword")
          end

          if v19.Gun then
            f81("Gun")
          end

          if v19.DemonFruit then
            f81("Demon Fruit")
          end
        end
      end)
    end

    function v544.GetPlayerList()
      local v574 = { "Nearest" }

      for index72, value131 in ipairs(v3:GetChildren()) do
        if value131.Name ~= localPlayer.Name then
          table.insert(v574, value131.Name)
        end
      end

      return v574
    end

    local connect2 = nil

    function v544.OnCamLockToggle(p203)
      v19.CamLock = p203

      if connect2 then
        connect2:Disconnect()
        connect2 = nil
      end

      if p203 then
        connect2 = v7.RenderStepped:Connect(function()
          if not v19.CamLock then
            if connect2 then
              connect2:Disconnect()
              connect2 = nil
            end

            return
          end

          pcall(function()
            local getNearestPlayer = (v19.SelectPlayer == "Nearest" or not v19.SelectPlayer)
                and gameData:GetNearestPlayer()
              or v3:FindFirstChild(v19.SelectPlayer)

            local character29 = getNearestPlayer and getNearestPlayer.Character
            local humanoid20 = character29 and character29:FindFirstChildOfClass("Humanoid")

            local head3 = character29
              and (character29:FindFirstChild("Head")
                or character29:FindFirstChild("HumanoidRootPart") or character29.PrimaryPart)

            if head3 and humanoid20 and humanoid20.Health > 0 then
              local currentCamera = v4.CurrentCamera or v4.Camera

              if currentCamera then
                currentCamera.CFrame = CFrame.new(currentCamera.CFrame.Position, head3.Position)
              end
            end
          end)
        end)
      end
    end

    local function f82()
      pcall(function()
        local currentCamera2 = v4.CurrentCamera or v4.Camera

        local humanoid21 = localPlayer.Character
          and localPlayer.Character:FindFirstChildOfClass("Humanoid")

        if currentCamera2 and humanoid21 then
          currentCamera2.CameraSubject = humanoid21
        end
      end)
    end

    local function f83()
      if not v19.SpectatePlayer then
        f82()
        return
      end

      pcall(function()
        local getNearestPlayer2 = (v19.SelectPlayer == "Nearest" or not v19.SelectPlayer)
            and gameData:GetNearestPlayer()
          or v3:FindFirstChild(v19.SelectPlayer)

        local humanoid22 = getNearestPlayer2 and getNearestPlayer2.Character
          and getNearestPlayer2.Character:FindFirstChildOfClass("Humanoid")

        local currentCamera3 = v4.CurrentCamera or v4.Camera

        if currentCamera3 then
          if humanoid22 and humanoid22.Health > 0 then
            currentCamera3.CameraSubject = humanoid22
          else
            local humanoid23 = localPlayer.Character
              and localPlayer.Character:FindFirstChildOfClass("Humanoid")

            if humanoid23 then
              currentCamera3.CameraSubject = humanoid23
            end
          end
        end
      end)
    end

    function v544.OnSpectateToggle(p204)
      v19.SpectatePlayer = p204

      if not p204 then
        f82()
      else
        f83()
      end
    end

    local function f84()
      local v575, v576 = pcall(function()
        return commF:InvokeServer("CakePrinceSpawner", true)
      end)

      local v577 = v575 and type(v576) == "string" and tonumber(string.match(v576, "%d+"))
        or nil

      if v577 then
        return v577
      end

      if utilities:CheckMon("Cake Prince") then
        return "Cake Prince"
      end

      if utilities:CheckMon("Dough King") then
        return "Dough King"
      end

      return "None"
    end

    function v544.OnTPPlayerToggle(p205)
      v19.TeleporttoPlayer = p205

      if not p205 then
        tweenManager:StopTween()
      end
    end

    function v544.GetPlayerHunterQuest()
      if v26 then
        pcall(function() commF:InvokeServer("PlayerHunter") end)
      end
    end

    local f85

    local function f86()
      local moonPhase2 = v8:GetAttribute("MoonPhase")
      local v578 = tostring(f85())
      local clockTime = v8.ClockTime
      local v579 = clockTime >= 18 or clockTime <= 5.5

      if v8:GetAttribute("IsBlueMoon") == true then
        return "Blue Moon (Active)"
      end

      if moonPhase2 == 5 or v578:find("9709149431") then
        return v579 and "Full Moon (Active)" or "Full Moon (Tonight)"
      elseif moonPhase2 == 4 then
        return "Phase 4 (Next Night Full Moon)"
      else
        if moonPhase2 then
          return string.format("Phase %d (%d nights left)", moonPhase2, (5 - moonPhase2) % 8)
        end

        return "Phase 1"
      end
    end

    function f85()
      local fantasySky = v8:FindFirstChild("FantasySky") or v8:FindFirstChild("Sky")
      return fantasySky and fantasySky.MoonTextureId or ""
    end

    local function f87(p206)
      local v580 = math.floor(p206 / 3600)
      local v581 = math.floor(p206 % 3600 / 60)
      local v582 = math.floor(p206 % 60)

      return v580 > 0 and string.format("%dh %02dm %02ds", v580, v581, v582)
        or string.format("%dm %02ds", v581, v582)
    end

    local f88

    local function f89()
      return f88("Mirage Island")
    end

    local v583 = 0
    local v584 = nil

    local function f90()
      if not v24 then
        return "None"
      end

      if tick() - v583 >= 3 then
        v583 = tick()

        local v585, v586 = pcall(function()
          local requestNextRaidHint = v29 and v29:RemoteFunction("RequestNextRaidHint")

          if requestNextRaidHint then
            return requestNextRaidHint:InvokeServer()
          end
        end)

        if v585 and type(v586) == "table" and v586.Boss then
          v584 = v586
          v584._fetchTick = tick()
        else
          v584 = nil
        end
      end

      if not v584 then
        return "None"
      else
        local boss = v584.Boss or "Boss"
        local island = v584.Island or "Unknown Island"
        local state = v584.State

        if state == "Armed" or state == "Triggered" then
          return string.format("[Spawned] %s (%s)", tostring(boss), tostring(island))
        elseif state == "Arming" then
          return string.format("[Arming] %s (%s)", tostring(boss), tostring(island))
        elseif state == "Deferred" then
          return string.format("[Deferred] %s (%s)", tostring(boss), tostring(island))
        else
          local fetchTick = v584._fetchTick and tick() - v584._fetchTick or 0
          local v587 = math.max(0, math.floor((tonumber(v584.Seconds) or 0) - fetchTick))

          if v587 > 0 then
            local v588 = math.floor(v587 / 60)
            local v589 = math.floor(v587 % 60)

            return string.format(
              "%s (%s) in %dm %02ds", tostring(boss), tostring(island), v588, v589
            )
          end

          return string.format("%s (%s) [Stirring Soon]", tostring(boss), tostring(island))
        end
      end
    end

    function f88(p207)
      local locations3 = worldOrigin and worldOrigin:FindFirstChild("Locations")
      return locations3 and locations3:FindFirstChild(p207) and "[Spawned]" or "[None]"
    end

    local function f91()
      return f88("Frozen Dimension")
    end

    local function f92()
      return f88("Kitsune Island")
    end

    local function f93()
      return f88("Prehistoric Island")
    end

    local f94

    local function f95()
      if enemies then
        local v590, v591 = enemies:GetChildren()

        for key54, value132 in next, v590, v591 do
          local humanoid24 = value132:FindFirstChildOfClass("Humanoid")

          if humanoid24 and humanoid24.Health > 0 then
            if value132.Name:find("indra") then
              return "[Used - rip_indra Active!]"
            end

            if value132.Name:find("Dough King") then
              return "[Used - Dough King Active!]"
            end

            if value132.Name:find("Darkbeard") then
              return "[Used - Darkbeard Active!]"
            end
          end
        end
      end

      local v592, v593 = v3:GetPlayers()

      for key55, value133 in next, v592, v593 do
        local character30 = value133.Character
        local backpack4 = value133:FindFirstChild("Backpack")

        if character30 and character30:FindFirstChild("God's Chalice")
          or backpack4 and backpack4:FindFirstChild("God's Chalice") then
          return "[Spawned - Held by " .. (value133.DisplayName or value133.Name) .. "]"
        elseif character30 and character30:FindFirstChild("Sweet Chalice")
          or backpack4 and backpack4:FindFirstChild("Sweet Chalice") then
          return "[Sweet Chalice - Held by " .. (value133.DisplayName or value133.Name) .. "]"
        elseif character30 and character30:FindFirstChild("Fist of Darkness")
          or backpack4 and backpack4:FindFirstChild("Fist of Darkness") then
          return "[Fist of Darkness - Held by " .. (value133.DisplayName or value133.Name)
            .. "]"
        end
      end

      local v594 = f94()

      if v594 then
        local v595 = os.time() - v594

        if v595 < 14400 then
          local v596 = 14400 - v595

          return string.format(
            "Not Spawned (Wait %dh %02dm %02ds)", math.floor(v596 / 3600),
            math.floor(v596 % 3600 / 60), (math.floor(v596 % 60))
          )
        else
          local v597 = 14400 - v595 % 14400

          return string.format(
            "Available in Chests (Next: %dh %02dm)", math.floor(v597 / 3600),
            (math.floor(v597 % 3600 / 60))
          )
        end
      else
        return "Unknown"
      end
    end

    function f94()
      local locations4 = worldOrigin and worldOrigin:FindFirstChild("Locations")

      if not locations4 then
        return nil
      else
        local v598 = nil

        for index73, value134 in ipairs(locations4:GetChildren()) do
          local timeIn = value134:GetAttribute("TimeIn")

          if timeIn and timeIn > 1700000000 then
            if v598 == nil or timeIn < v598 then
              v598 = timeIn
            end
          end
        end

        return v598
      end
    end

    local function f96()
      local v599 = f94()

      if v599 then
        return f87(os.time() - v599)
      end

      return "Unknown"
    end

    local function f97()
      local function f98(p208)
        local v600, v601 = pcall(p208)
        return v600 and v601 or "Error"
      end

      local v602 = {}
      local v603 = f98(f96)

      table.insert(v602, "Server Uptime: " .. v603)

      table.insert(
        v602, "Time in Server: " .. f98(function() return f87(os.time() - JoinTime) end)
      )

      table.insert(v602, "Next Fruit Spawn: " .. f98(function()
        local distributedGameTime = v4.DistributedGameTime
        local v604 = os.date("!*t").wday == 1 or os.date("!*t").wday == 7
        local v605 = v604 and 2700 or 3600
        local v606 = v605 - distributedGameTime % v605
        local v607 = math.floor(v606 / 60)
        local v608 = math.floor(v606 % 60)
        local v609 = {}
        local v610, v611 = v4:GetChildren()

        for key56, value135 in next, v610, v611 do
          if value135:IsA("Model") and value135.Name:find("Fruit") and value135:FindFirstChild("Handle") then
            table.insert(v609, value135.Name == "Fruit" and "Spawned Fruit" or value135.Name)
          end
        end

        if #v609 > 0 then
          return string.format("Spawned Now! (%s)", table.concat(v609, ", "))
        end

        return string.format(
          "%02dm %02ds (%s)", v607, v608, v604 and "Weekend Boost" or "Weekday"
        )
      end))

      if v26 then
        table.insert(v602, "God's Chalice: " .. f98(f95))
      elseif v25 then
        table.insert(v602, "Fist of Darkness: " .. f98(f95))
      end

      if v26 then
        table.insert(v602, "Elite Hunter: " .. f98(f75))
      end

      if v24 then
        table.insert(v602, "Next Secret Boss: " .. f98(f90))
      end

      table.insert(v602, "Moon: " .. f98(function()
        local v612 = f86()
        local v613 = f76(v612, v8.ClockTime)
        return v612 .. (v613 and " | " .. v613 or "")
      end))

      table.insert(v602, "Sword: " .. f98(f80))
      table.insert(v602, "Cake Stats: " .. f98(function() return tostring(f84()) end))
      table.insert(v602, "Ancient One: " .. f98(f79))

      table.insert(
        v602, "Ancient One (Draco): " .. f98(function() return tostring(f78() or "N/A") end)
      )

      table.insert(v602, "Bribe: " .. f98(f77))
      table.insert(v602, "Mirage: " .. f98(f89))
      table.insert(v602, "Kitsune: " .. f98(f92))
      table.insert(v602, "Frozen Dimension: " .. f98(f91))
      table.insert(v602, "Prehistoric: " .. f98(f93))

      return table.concat(v602, "\n")
    end

    v544.StatusServer = f97
    v33._StatusServer = f97

    local function f99()
      local v614, v615, v616, v617, v618, v619 = pcall(function()
        return commF:InvokeServer("Bones", "Check")
      end)

      local v620, v621

      if v614 then
        if type(v615) == "table" then
          local v622 = tonumber(v615[3] or v615.PurchasesLeft or v615.left)
          local v623 = tonumber
          local v624 = v615[4]
          v621 = v622
          v620 = v623(v624 or v615.WaitMinutes or v615.wait)
        else
          v621 = tonumber(v617)
          v620 = tonumber(v618)
        end
      end

      if not v614 or not v621 then
        return "Error"
      end

      if v621 <= 0 then
        return "No purchases left — wait " .. tostring(v620 or "?") .. " min"
      end

      return v621 .. " purchase(s) left"
    end

    local function f100()
      local v625, v626 = pcall(function()
        local gachaNetworkRF = v29 and v29:RemoteFunction("GachaNetworkRF")

        if gachaNetworkRF then
          return gachaNetworkRF:InvokeServer({
            Context = "Check",
            BoxName = "ZiolesGacha",
            SpokeNPC = "Blox Fruit Gacha",
          })
        end
      end)

      if v625 and type(v626) == "table" then
        if v626.RequirementsMet == true then
          local value136 = v626.Price and v626.Price.Value or 0
          return "Ready ($" .. (f7 and f7(value136) or tostring(value136)) .. ")"
        end

        if v626.Level and v626.Level.RequirementMet == false then
          return "Need level 50"
        end

        if v626.Price and v626.Price.RequirementMet == false then
          return "Need $"
            .. (f7 and f7(v626.Price.Value or 0) or tostring(v626.Price.Value or 0))
        end

        if v626.Cooldown then
          local errorMessage = v626.Cooldown.ErrorMessage or v626.ErrorMessage

          if errorMessage and errorMessage ~= "" then
            local dD = tostring(errorMessage):match("%d+:%d+")

            if dD then
              return dD
            end

            return tostring(errorMessage):gsub("[%%%[%]]", "")
          elseif v626.Cooldown.TimeEnds then
            local v627 = math.max(0, math.floor(v626.Cooldown.TimeEnds - os.time()))
            return string.format("%02d:%02d", math.floor(v627 / 60), v627 % 60)
          end
        end

        if v626.ErrorMessage and v626.ErrorMessage ~= "" then
          local dD2 = tostring(v626.ErrorMessage):match("%d+:%d+")

          if dD2 then
            return dD2
          end

          return tostring(v626.ErrorMessage):gsub("[%%%[%]]", "")
        end
      end

      local v628, v629, v630, v631 = pcall(function()
        return commF:InvokeServer("Cousin", "Check", "DLCBoxData")
      end)

      if v628 and tonumber(v630) and tonumber(v630) < 50 then
        return "Need level 50"
      else
        local v632, v633 = pcall(function()
          return commF:InvokeServer("Cousin", "CheckTime", "DLCBoxData")
        end)

        if v632 and v633 == true then
          return "Ready ($" .. math.floor(tonumber(v631 or 0)) .. ")"
        end

        if v632 and type(v633) == "string" then
          return v633
        end

        return "Unknown"
      end
    end

    local function f101()
      local v634 = tonumber
      local invokeServer2 = commF:InvokeServer("KenTalk", "Status")

      local value137 = v634(invokeServer2 and string.match(tostring(invokeServer2), "%d+"))
        or localPlayer:FindFirstChild("VisionRadius") and localPlayer.VisionRadius.Value or 0

      local kenMaxDodges = localPlayer:GetAttribute("KenMaxDodges") or 0
      local kenDodgesLeft = localPlayer:GetAttribute("KenDodgesLeft") or 0

      local v635 = value137 >= 5000 and "Max" or value137 >= 4500 and "7"
        or value137 >= 3000 and "6" or value137 >= 1800 and "5" or value137 >= 900 and "4"
        or value137 >= 300 and "3" or value137 >= 50 and "2" or "1"

      local v636 = kenMaxDodges > 0 and kenMaxDodges or value137 >= 4500 and 8
        or value137 >= 3000 and 7 or value137 >= 1800 and 6 or value137 >= 900 and 5
        or value137 >= 300 and 4 or value137 >= 50 and 3 or 2

      return string.format(
        "%d/5000 (Lvl %s • %d/%d Dodges)", math.floor(value137), tostring(v635),
        kenDodgesLeft, v636
      )
    end

    function v544.PlayerStatus()
      return table.concat({
        "Next Roll: " .. f100() .. "\n", "Bone Roll: " .. f99() .. "\n",
        "Observation: " .. f101() .. "\n",
        "Simulation Data: " .. tostring(localPlayer:GetAttribute("SimulationData") or "N/A"),
      }, "\n")
    end

    function v544.GetFruitStock()
      return serverStatus and serverStatus.GetFruitStock() or "No fruit stock data"
    end

    function v544.TPDojoTrainer()
      tweenManager:topos(CFrame.new(5867, 1208, 870))
    end

    function v544.TPDragonHunter()
      tweenManager:topos(CFrame.new(5864, 1209, 808))
    end

    function v544.TPDragonWizard()
      tweenManager:topos(CFrame.new(5775, 1209, 806))
    end

    function v544.ToggleUpgradeDragonTalon(p209)
      v19.AutoUpgradeDragonTalon = p209

      if not p209 then
        return tweenManager:StopTween()
      end

      spawn(function()
        while v19.AutoUpgradeDragonTalon and task.wait(0.5) do
          local cframe11 = CFrame.new(
            5661.89014, 1211.31909, 864.836731, 0.811413169, -1.36805838e-8, -0.584473014,
            4.75227395e-8, 1, 4.25682458e-8, 0.584473014, -6.23161966e-8, 0.811413169
          )

          tweenManager:topos(cframe11)

          if localPlayer.Character
            and localPlayer.Character:FindFirstChild("HumanoidRootPart")
            and (cframe11.Position - localPlayer.Character.HumanoidRootPart.Position).Magnitude
              <= 5 then
            v5.Modules.Net["RF/InteractDragonQuest"]:InvokeServer({
              NPC = "Uzoth",
              Command = "Upgrade",
            })
          end
        end
      end)
    end

    function v544.CraftPrehistoricItem(p210)
      net:WaitForChild("RF/Craft"):InvokeServer("Craft", p210, 1, {})
    end

    function v544.ChangeDracoRace()
      if localPlayer:DistanceFromCharacter(Vector3.new(5773, 1210, 807)) <= 5 then
        net("RF/InteractDragonQuest"):InvokeServer({
          NPC = "Dragon Wizard",
          Command = "DragonRace",
        })
      else
        tweenManager:topos(CFrame.new(5773, 1210, 807))
      end
    end

    function v544.UnlockDungeonDifficulty()
      pcall(function()
        v5.DungeonShared.DataRemote:InvokeServer("TryUnlockDifficulty", "Simulation", "Hard")
      end)

      pcall(function()
        v5.DungeonShared.DataRemote:InvokeServer(
          "TryUnlockDifficulty", "Simulation", "Challenge"
        )
      end)

      pcall(function() net["RF/DungeonNPCNetworkFunction"]:InvokeServer("UnlockDifficulty") end)
      pcall(function() net["RF/DungeonNPCNetworkFunction"]:InvokeServer("UnlockNext") end)

      v33:SendNotify("Dungeon", "Attempted to unlock difficulty", 4)
    end

    function v544.TPDungeonHub()
      net["RF/DungeonNPCNetworkFunction"]:InvokeServer("TeleportToDungeonHub", false)
    end

    function v544.TPDungeonBack()
      net["RF/DungeonNPCNetworkFunction"]:InvokeServer("TeleportBack")
    end

    function v544.OpenNormalFruitShop()
      require(v5.Controllers.UI.FruitShop):Open()
    end

    function v544.OpenAdvFruitShop()
      require(v5.Controllers.UI.FruitShop):Open("AdvancedFruitDealer")
    end

    function v544.GetFruitSpawnStatus()
      local count8 = 0
      local huge13 = math.huge

      if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
        and localPlayer.Character.HumanoidRootPart.Position then
        local v637, v638 = v4:GetChildren()

        for key57, value138 in next, v637, v638 do
          if value138:IsA("Model") and string.find(value138.Name, "Fruit") then
            local handle3 = value138:FindFirstChild("Handle")

            if handle3 and handle3:IsA("BasePart") then
              count8 = count8 + 1
              local distanceFromCharacter4 = localPlayer:DistanceFromCharacter(handle3.Position)

              if distanceFromCharacter4 < huge13 then
                huge13 = distanceFromCharacter4
              end
            end
          end
        end

        return count8 > 0 and string.format([[
Fruits Found: %d
Position: %.2f Studs Away]], count8, huge13) or "No fruits detected nearby."
      end

      return "Scanning for fruit..."
    end

    function v544.TPAdvFruitDealer()
      if map:FindFirstChild("MysticIsland") then
        local v639 = getnilinstances()
        local v640, v641 = v5.NPCs:GetChildren()

        for key58, value139 in next, v640, v641 do
          table.insert(v639, value139)
        end

        for key59, value140 in pairs(v639) do
          if value140.Name == "Advanced Fruit Dealer" then
            tweenManager:topos(value140.PrimaryPart.CFrame)
          end
        end
      end
    end

    local function f102()
      local v642 = {}

      local v643, v644 = pcall(function()
        return v29:RemoteFunction("GetAllItemValues"):InvokeServer()
      end)

      if v643 and v644 then
        for key60, value141 in next, v644, nil do
          if value141.Key == "AccessoryType" and value141.Value == "Trinket"
            or value141.Key == "Type" and value141.Value == "Trinket" then
            if value141.NetworkedUID then
              table.insert(v642, value141.NetworkedUID)
            end
          end
        end
      end

      return v642
    end

    function v544.BuyTrinket()
      v33:SendNotify("Trinkets", pcall(function() return v5.Remotes.AccessoryInteract:InvokeServer("d") end)
          and "Purchased Trinket!"
        or "Failed to purchase trinket.", 4)
    end

    function v544.FuseTrinkets()
      local v645 = f102()

      if #v645 >= 3 then
        v33:SendNotify("Trinkets", pcall(function()
          return v5.Remotes.AccessoryInteract:InvokeServer("a", v645[1], v645[2], v645[3])
        end) and "Fused 3 Trinkets successfully!" or "Failed to fuse trinkets.", 4)
      else
        v33:SendNotify(
          "Trinkets", "Need at least 3 trinkets (Found: " .. tostring(#v645) .. ")", 4
        )
      end
    end

    function v544.RefineTrinket()
      local v646 = f102()

      if #v646 >= 1 then
        v33:SendNotify("Trinket Refiner", pcall(function()
          return v5.Remotes.AccessoryInteract:InvokeServer("c", v646[1])
        end) and "Refined trinket!" or "Failed to refine trinket.", 4)
      else
        v33:SendNotify("Trinket Refiner", "No trinket available to refine.", 4)
      end
    end

    function v544.OpenTrinketMergeGUI()
      pcall(function()
        localPlayer:WaitForChild("PlayerGui"):WaitForChild("AccessoryMerge").Open:Fire(false)
      end)
    end

    function v544.OpenTrinketRefineGUI()
      pcall(function()
        localPlayer:WaitForChild("PlayerGui"):WaitForChild("AccessoryMerge").Open:Fire(true)
      end)
    end

    function v544.OpenTrinketScrapGUI()
      pcall(function()
        localPlayer:WaitForChild("PlayerGui"):WaitForChild("AccessoryTrasher").Open:Fire()
      end)
    end

    function v544.InitTempleOfTime()
      pcall(function()
        local mapStash = v5:FindFirstChild("MapStash")
        mapStash:FindFirstChild("Temple of Time").Parent = v4:FindFirstChild("Map")
      end)
    end

    function v544.TPRaceDoor()
      if data and data.Race and v44[data.Race.Value] then
        tweenManager:topos(v44[data.Race.Value])
      end
    end

    function v544.ResetCharHead()
      if localPlayer.Character and localPlayer.Character:FindFirstChild("Head") then
        localPlayer.Character.Head:Destroy()
      end
    end

    local v647 = {
      GreatTree = CFrame.new(2948, 2282, -7214),
      TempleOfTime = CFrame.new(28286, 14895, 103),
      AncientOne = CFrame.new(28982, 14888, -120),
      LeverPull = CFrame.new(28575, 14937, 72),
      SafeZone = CFrame.new(28273, 14897, 157),
      PvpZone = CFrame.new(28767, 14967, -164),
      Clock = CFrame.new(29552, 15069, -86),
    }

    function v544.TPTrialArea(p211)
      if v647[p211] then
        tweenManager:topos(v647[p211])
      end
    end

    function v544.TeleportJobID(p212)
      local gsub4 = tostring(p212):gsub("`", ""):gsub("lua", "")
      v5.__ServerBrowser:InvokeServer("teleport", (gsub4:gsub("%s+", "")))
    end

    function v544.TeleportQuantumPremium(p213)
      local gsub5 = tostring(p213):gsub("`", ""):gsub("lua", ""):gsub("QuantumOnyx%-", ""):gsub(
        "%s+", ""
      )

      if f10 then
        gsub5 = f10(gsub5)
      end

      v5.__ServerBrowser:InvokeServer("teleport", gsub5)
    end

    function v544.RejoinServer()
      v5.__ServerBrowser:InvokeServer("teleport", v5.__ServerBrowser:InvokeServer("getjob"))
    end

    function v544.ServerHop()
      utilities:ServerHop()
    end

    v544.JoinAPI = f6

    function v544.JoinRaidBossServer()
      local selectBosstoHop = v19.SelectBosstoHop

      if type(selectBosstoHop) == "number" or not selectBosstoHop or selectBosstoHop == "" then
        selectBosstoHop = bossHopNames[selectBosstoHop] or bossHopNames[1]
          or "rip_indra True Form"
      end

      local v648 = bossMap[selectBosstoHop] or selectBosstoHop or "Ripindra"

      if f6 then
        f6(tostring(v648))
      end
    end

    function v544.BuyItem(p214, p215)
      local v649 = itemsToBuy and itemsToBuy[p215] and itemsToBuy[p215][p214]

      if not v649 then
        return
      end

      if p215 == "Frags" or p215 == "Ability" or p215 == "Accessory" then
        commF:InvokeServer(unpack(v649))
      elseif p215 == "Sword" then
        task.wait(0.1)
        commF:InvokeServer(p214 == "Pole v.2" and v649 or "BuyItem", v649)
      elseif p215 == "Gun" then
        task.wait(0.5)

        if p214 == "Kabucha" then
          commF:InvokeServer(v649[1], v649[2], v649[3])
          commF:InvokeServer(v649[1], v649[2], "2")
        else
          commF:InvokeServer(unpack(v649))
        end
      end
    end

    function v544.BuySelectedFruit()
      local selectFruitDealerFruit = v19.SelectFruitDealerFruit

      if not selectFruitDealerFruit or selectFruitDealerFruit == "" then
        v33:SendNotify("Fruit Dealer", "Please select a fruit first.", 4)
        return
      else
        local v650, v651 = pcall(function() return commF:InvokeServer("GetFruits") end)

        if v650 and typeof(v651) == "table" then
          for key61, value142 in next, v651, nil do
            local v652 = value142

            if v652
              and (v652.Name == selectFruitDealerFruit
                or v652.Name:match("^(.-)%-") == selectFruitDealerFruit:match("^(.-)%-")) then
              if v652.OnSale then
                pcall(function()
                  return commF:InvokeServer("PurchaseRawFruit", v652.Name, false)
                end)
              else
                v33:SendNotify("Fruit Dealer", v652.Name .. " is currently out of stock!", 4)
              end

              return
            end
          end

          v33:SendNotify("Fruit Dealer", "Could not check fruit stock.", 4)
          return
        end

        v33:SendNotify("Fruit Dealer", "Could not check fruit stock.", 4)
        return
      end
    end

    function v544.BuyCyborgRace()
      commF:InvokeServer("CyborgTrainer", "Buy")
    end

    function v544.BuyGhoulRace()
      commF:InvokeServer("Ectoplasm", "BuyCheck", 4)
      commF:InvokeServer("Ectoplasm", "Change", 4)
    end

    local v653 = {
      ["Common Scroll"] = "CommonScroll",
      ["Rare Scroll"] = "RareScroll",
      ["Legendary Scroll"] = "LegendaryScroll",
      ["Mythical Scroll"] = "MythicalScroll",
    }

    function v544.CraftScroll()
      local selectScrollType = v19.SelectScrollType or "Common Scroll"
      local v654 = v653[selectScrollType] or "CommonScroll"
      local v655 = tonumber(v19.ScrollCraftAmount) or 1

      v33:SendNotify("Scroll Craft", pcall(function()
        return v29:RemoteFunction("Craft"):InvokeServer(v654, v655)
      end) and "Crafted " .. tostring(v655) .. "x " .. selectScrollType .. "!" or "Failed to craft scroll (check materials)", 5)
    end

    function v544.OpenTitleNames()
      pcall(function()
        localPlayer:WaitForChild("PlayerGui"):WaitForChild("TitlesMenu").Open:Fire()
      end)
    end

    function v544.OpenAwakenings()
      pcall(function() localPlayer.PlayerGui.Main.AwakeningToggler.Visible = true end)
    end

    function v544.OpenHakiColors()
      pcall(function() localPlayer.PlayerGui.Main.Colors.Visible = true end)
    end

    function v544.SetWalkSpeed(walkSpeed)
      v19.WalkSpeed = walkSpeed

      if v19.WalkSpeed and localPlayer.Character
        and localPlayer.Character:FindFirstChild("Humanoid") then
        localPlayer.Character.Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
          localPlayer.Character.Humanoid.WalkSpeed = v19.WalkSpeed
        end)

        localPlayer.Character.Humanoid.WalkSpeed = v19.WalkSpeed
      end
    end

    function v544.SetJumpPower(jumpPower)
      v19.JumpPower = jumpPower

      if v19.JumpPower and localPlayer.Character
        and localPlayer.Character:FindFirstChild("Humanoid") then
        localPlayer.Character.Humanoid.JumpPower = v19.JumpPower
      end
    end

    local function f103(p216)
      for key62, value143 in pairs(v4:GetDescendants()) do
        if value143:IsA("BasePart") and not value143.Parent:FindFirstChild("Humanoid")
          and not value143.Parent.Parent:FindFirstChild("Humanoid") then
          value143.LocalTransparencyModifier = p216 and 0.7 or 0
        end
      end
    end

    function v544.ToggleXray(p217)
      f103(p217)
    end

    local cameraMaxZoomDistance = localPlayer.CameraMaxZoomDistance

    function v544.ToggleInfiniteZoom(p218)
      localPlayer.CameraMaxZoomDistance = p218 and math.huge or cameraMaxZoomDistance
    end

    function v544.ToggleWhiteScreen(p219)
      v19.White_Screen = p219
      v7:Set3dRenderingEnabled(not p219)
    end

    function v544.ToggleBlackScreen(p220)
      v19.BlackScreen = p220

      pcall(function()
        if localPlayer.PlayerGui.Main:FindFirstChild("Blackscreen") then
          local blackscreen = localPlayer.PlayerGui.Main.Blackscreen

          blackscreen.Size = p220 and UDim2.new(1000, 0, 1000, 1000)
            or UDim2.new(1, 0, 1000, 1000)
        end
      end)
    end

    function v544.RedeemAllCodes()
      spawn(function()
        local v656 = {}
        local v657 = {}

        local function f104(p221)
          if type(p221) == "string" then
            local gsub6 = p221:gsub("%s+", ""):gsub("\"", ""):gsub("'", ""):gsub("&#39;", "")

            if gsub6 ~= "" and #gsub6 >= 3 and #gsub6 <= 40 and not v657[gsub6] then
              v657[gsub6] = true
              table.insert(v656, gsub6)
            end
          end
        end

        for index74, value144 in ipairs({
          "SECRET_ADMIN", "ADMIN", "SUB2GAMERROBOT_EXP1", "SUB2GAMERROBOT_RESET1", "fudd10",
          "fudd10_v2", "BYAKUYAx10", "STAT_REFUND", "UPD17_TESTER", "ResetStatsSorry",
          "kittgaming", "chandler", "StrawHatMaine", "Enyu_is_Pro", "Magicbus", "JCWK",
          "Starcode_JCWK", "SUB2OFFICIALNOOBIE", "Sub2NoobMaster123", "TheGreatAce", "Axiore",
          "Starcode_Axiore", "TantaiGaming", "Starcode_TantaiGaming", "Sub2Fer999",
          "Starcode_Fer999", "SUB2TOKIOCODES", "SUBGOD", "StrawHat", "BLXFRUIT", "DRAGONBALL",
        }) do
          f104(value144)
        end

        local redeem = v5:FindFirstChild("Remotes") and v5.Remotes:FindFirstChild("Redeem")

        if redeem then
          for index75, value145 in ipairs(v656) do
            local v658 = value145
            local v659, v660 = pcall(function() return redeem:InvokeServer(v658) end)

            if v659 and v660 then
              local v661 = tostring(v660)

              if not (v660 == true) then
                if not (v660 == "SUCCESS") then
                  v661:lower():find("success")
                end
              end
            end

            task.wait(0.08)
          end
        end
      end)
    end

    function v544.ForceFPSBoost()
      local terrain = v4:FindFirstChildOfClass("Terrain")

      if terrain then
        terrain.WaterWaveSize = 0
        terrain.WaterWaveSpeed = 0
        terrain.WaterReflectance = 0
        terrain.WaterTransparency = 0
      end

      v8.GlobalShadows = false
      v8.FogEnd = 9000000000

      settings().Rendering.QualityLevel = 1

      for key63, value146 in pairs(game:GetDescendants()) do
        if value146:IsA("Part") or value146:IsA("UnionOperation") or value146:IsA("MeshPart")
          or value146:IsA("CornerWedgePart") or value146:IsA("TrussPart") then
          value146.Material = "Plastic"
          value146.Reflectance = 0
        elseif value146:IsA("Decal") then
          value146.Transparency = 1
        elseif value146:IsA("ParticleEmitter") or value146:IsA("Trail") then
          value146.Lifetime = NumberRange.new(0)
        elseif value146:IsA("Explosion") then
          value146.BlastPressure = 1
          value146.BlastRadius = 1
        end
      end

      for key64, value147 in pairs(v8:GetDescendants()) do
        if value147:IsA("BlurEffect") or value147:IsA("SunRaysEffect")
          or value147:IsA("ColorCorrectionEffect") or value147:IsA("BloomEffect")
          or value147:IsA("DepthOfFieldEffect") then
          value147.Enabled = false
        end
      end

      local v662, v663 = v4:GetChildren()

      for key65, value148 in next, v662, v663 do
        local v664 = value148

        if v664:IsA("ForceField") or v664:IsA("Sparkles") or v664:IsA("Smoke")
          or v664:IsA("Fire") then
          pcall(function() v664:Destroy() end)
        end
      end
    end

    function v544.OpenDevConsole()
      pcall(function() starterGui:SetCore("DevConsoleVisible", true) end)
    end

    function v544.CleanMemory()
      if v36.CleanMemory then
        v36.CleanMemory()
      end

      v33:SendNotify("Memory Cleaner", "Garbage collection completed & memory trimmed!", 4)
    end

    function v544.OnFastModeToggle(p222)
      spawn(function()
        if v36.SetFastMode then
          v36.SetFastMode(p222)
        end
      end)
    end

    function v544.SendTestWebhook()
      if v19.Webhook and v19.Webhook ~= "" then
        if PostWebhook and WeeboLogs then
          PostWebhook(v19.Webhook, WeeboLogs("Test Notification", {
            Extra = "**Status:** Webhook connection is active & working properly!",
            Field2 = { name = "User", value = localPlayer.Name },
          }))
        end

        v33:SendNotify("Webhook", "Test webhook dispatched!", 4)
      else
        v33:SendNotify("Webhook", "Please enter a valid Webhook URL first.", 4)
      end
    end

    function v544.SendDataLogNow()
      if v20.SendDataLog then
        v20:SendDataLog(
          "Quantum Onyx - Manual Data Log Request", "Triggered manually via UI button."
        )
      end

      v33:SendNotify("Data Log", "Data Log webhook sent successfully!", 5)
    end

    spawn(function()
      while task.wait(3) do
        if v19.AutoFastMode and not v36.FastMode then
          v36.SetFastMode(true)
        end
      end
    end)

    local addSection = v518.Home:addSection()
    local halloweenEvent = addSection:addMenu("Halloween Event")

    v519:CreateToggle(halloweenEvent, "Auto Trick or Treat", "AutoTrickOrTreat", false, {
      global = true,
      stop = true,
    })

    v519:CreateToggle(halloweenEvent, "Auto Hunt Pumpkin", "AutoCollectPumpkin", false, {
      global = true,
      stop = true,
    })

    v519:CreateToggle(halloweenEvent, "Auto Spooky Gacha", "AutoRollSpookyGacha", false, {
      global = true,
      save = true,
    })

    v519:CreateToggle(halloweenEvent, "ESP Halloween", "ESPHalloween", false, {
      global = true,
      save = true,
      subtoggles = {
        {
          Title = "ESP Pumpkin Snowman",
          SaveKey = "ESP_CursedSnowman",
          Default = false,
          Callback = function(value149)
            v19.ESP_CursedSnowman = value149

            if not value149 then
              if ClearESP then
                ClearESP("CursedSnowman")
              end
            elseif v19.ESPHalloween and HalloweenCursedSnowmanESP then
              HalloweenCursedSnowmanESP()
            end
          end,
        },
        {
          Title = "ESP Pumpkins",
          SaveKey = "ESP_Pumpkins",
          Default = false,
          Callback = function(value150)
            v19.ESP_Pumpkins = value150

            if not value150 then
              if ClearESP then
                ClearESP("HalloweenPumpkin")
              end
            elseif v19.ESPHalloween and HalloweenPumpkinsESP then
              HalloweenPumpkinsESP()
            end
          end,
        },
        {
          Title = "ESP Bosses in Doors & Door Portal",
          SaveKey = "ESP_HalloweenBossesPortal",
          Default = false,
          Callback = function(value151)
            v19.ESP_HalloweenBossesPortal = value151

            if not value151 then
              if ClearESP then
                ClearESP("HalloweenBossPortal")
              end
            elseif v19.ESPHalloween and HalloweenBossPortalESP then
              HalloweenBossPortalESP()
            end
          end,
        },
      },
      callback = function(p223)
        v19.ESPHalloween = p223

        if not p223 then
          if ClearESP then
            ClearESP("CursedSnowman")
            ClearESP("HalloweenPumpkin")
            ClearESP("HalloweenBossPortal")
          end
        else
          if v19.ESP_CursedSnowman == nil then
            v19.ESP_CursedSnowman = true
          end

          if v19.ESP_Pumpkins == nil then
            v19.ESP_Pumpkins = true
          end

          if v19.ESP_HalloweenBossesPortal == nil then
            v19.ESP_HalloweenBossesPortal = true
          end

          if HalloweenESP then
            HalloweenESP()
          end
        end
      end,
    })

    local secretQuests = addSection:addMenu("Secret Quests")

    v519:CreateToggle(
      secretQuests, "Auto Complete Secret Quests", "AutoCompleteSecretQuests", false,
      { global = true, stop = true }
    )

    v33.SecretTrackerLabel = secretQuests:addLabel(
      "Secret Quests Tracker", "Checking progress..."
    )

    v33.SecretTrackerDropdown = v519:CreateDropdown(
      secretQuests, "Finished Secret Quests", "FinishedSecretQuestsTracker", "None", { "None" },
      { global = false, save = false }
    )

    secretQuests:addButton("Refresh Secret Quests Tracker", function()
      if v33 and v33.UpdateSecretTracker then
        v33.UpdateSecretTracker()
      end
    end)

    local mainFarm = addSection:addMenu("Main Farm")

    v519:CreateDropdown(
      mainFarm, "Weapon", "SelectWeapon", "Melee", { "Melee", "Sword", "Blox Fruit", "Gun" },
      { global = true }
    )

    v519:CreateDropdown(
      mainFarm, "Farm Method", "FarmMode", "Quest", { "Quest", "No Quest", "Nearest" },
      { global = true }
    )

    v519:CreateSlider(mainFarm, "Nearest (Distance)", "checknearestdist", 1000, 5000, 1500, {
      global = true,
    })

    v519:CreateToggle(mainFarm, "Auto Farm", "AutoFarm", false, {
      global = true,
      save = true,
      stop = true,
    })

    v519:CreateToggle(mainFarm, "Take Quest", "AcceptQuests", false, {
      global = true,
      save = true,
      description = "Accept Quest for Bones/Cakes",
    })

    v519:CreateToggle(mainFarm, "Auto Bones", "AutoFarmBones", false, {
      global = true,
      save = true,
      stop = true,
    })

    v519:CreateToggle(mainFarm, "Enable Mastery", "MasteryFarm", false, {
      global = true,
      save = true,
    })

    v519:CreateSlider(mainFarm, "Health Mob%", "HealthMob", 15, 100, 25, { global = true })

    v519:CreateToggle(mainFarm, "Auto Random Surprise", "Auto_Random_Surprise", false, {
      global = true,
      save = true,
    })

    v519:CreateToggle(mainFarm, "Auto Pray", "AutoPray", false, { global = true })
    v519:CreateToggle(mainFarm, "Auto Try Luck", "AutoTryLuck", false, { global = true })

    v519:CreateToggle(mainFarm, "Auto Katakuri", "AutoFarmPrince", false, {
      global = true,
      save = true,
      stop = true,
    })

    v519:CreateToggle(mainFarm, "Ignore Katakuri", "IgnoreCakePrince", false, { global = true })

    v519:CreateToggle(mainFarm, "Auto Dough King", "AutoDoughKing", false, {
      global = true,
      save = true,
      stop = true,
    })

    v519:CreateToggle(mainFarm, "Ignore Farm Dough King Item", "IgnoreDoughChaliceFarm", false, {
      global = true,
      save = true,
      description = "this function will make the Auto Dough King only focus on boss and will not try to get chalice",
    })

    v519:CreateDropdown(
      mainFarm, "Select Material", "SelectMaterial",
      v530.Materials and v530.Materials[1] or "Leather + Scrap Metal", v530.Materials or {},
      { global = true }
    )

    v519:CreateToggle(mainFarm, "Auto Farm Material", "AutoMaterial", false, {
      global = true,
      stop = true,
    })

    local bossFarm = addSection:addMenu("Boss Farm")

    v519:CreateDropdown(bossFarm, "Select Boss", "SelectBoss", 1, v530.BossNames or {}, {
      global = true,
    })

    v519:CreateToggle(bossFarm, "Auto Farm Boss", "AutoFarmBoss", false, {
      global = true,
      save = true,
      stop = true,
    })

    v519:CreateToggle(bossFarm, "Auto Kill All Bosses", "AutoKillAllBosses", false, {
      global = true,
      save = true,
      stop = true,
    })

    v519:CreateToggle(bossFarm, "Get Boss Quest", "GetBossQuest", false, {
      global = true,
      save = true,
      description = "Automatically takes the boss quest before attacking",
    })

    local tyrantFarm = addSection:addMenu("Tyrant Farm")

    v519:CreateToggle(tyrantFarm, "Auto Summon Kill Tyrant Of The Skies", "AutoTyrantOfTheSkies", false, {
      global = true,
      save = true,
      stop = true,
      description = "turn on auto skill or gun shooting for destroying vases",
    })

    v519:CreateToggle(tyrantFarm, "Use Skull Guitar for Vases", "ShootGunTyrant", true, {
      global = true,
      save = true,
      description = "Uses Skull Guitar custom shoot to destroy Tyrant vases",
    })

    local chestFarm = addSection:addMenu("Chest Farm")

    v519:CreateToggle(chestFarm, "Start Farming Chest", "AutoChest", false, {
      global = true,
      save = true,
      stop = true,
    })

    v519:CreateDropdown(chestFarm, "Chest Type", "ChestFilterType", { "Diamond", "Gold", "Silver" }, { "Diamond", "Gold", "Silver" }, {
      global = true,
      save = true,
      description = "Select which chest tiers to collect",
    }, true)

    v519:CreateToggle(chestFarm, "Stop If Items", "StopChest", false, {
      global = true,
      save = true,
    })

    v519:CreateToggle(chestFarm, "Auto Hop Server On Chests", "AutoHopChest", false, {
      global = true,
      save = true,
    })

    v519:CreateSlider(chestFarm, "Chest Hop Target Count", "ChestHopCount", 1, 50, 10, {
      global = true,
      save = true,
    })

    v519:CreateToggle(chestFarm, "Stop Hop If Chalice / Fist", "StopHopChestIfChalice", true, {
      global = true,
      save = true,
    })

    local addSection2 = v518.Home:addSection()
    local farmSettings = addSection2:addMenu("Farm Settings")

    v519:CreateDropdown(
      farmSettings, "Tween Option", "TweenMode", "Lerp", { "TweenService", "Lerp" },
      { global = true, save = true }
    )

    v519:CreateSlider(farmSettings, "Tweening Speed", "TweenSpeed", 10, 200, 200, {
      global = true,
      save = true,
    })

    v519:CreateSlider(farmSettings, "Farm Distance", "PosY", 0, 30, 18, { global = true })

    v519:CreateSlider(farmSettings, "Bring Radius", "BringMonsterRadius", 150, 400, 350, {
      global = true,
    })

    v519:CreateDropdown(farmSettings, "Pos Method", "PosMethod", "Above", { "Above", "Orbit" }, {
      global = true,
    })

    v519:CreateToggle(farmSettings, "Start Bring", "BringMonster", true, {
      global = true,
      save = true,
    })

    v519:CreateDropdown(
      farmSettings, "Attack Method", "FastSettings", "Fast Attack",
      { "Fast Attack", "Legit Attack" }, { global = true }
    )

    v519:CreateSlider(farmSettings, "Fast Attack Delay", "FastAttackDelay", 0, 1, 0, {
      global = true,
      step = 0.01,
    })

    v519:CreateToggle(farmSettings, "Fast Attack", "AutoAttack", true, {
      global = true,
      save = true,
    })

    v519:CreateToggle(farmSettings, "Quantum Attack", "QuantumAttack", false, { global = true })

    v519:CreateToggle(farmSettings, "Auto Attack Gun", "AutoAttackGun", true, {
      global = true,
      save = true,
    })

    v519:CreateDropdown(farmSettings, "Dragonstorm Mode", "DragonstormMode", "Spread Damage", { "Spread Damage", "Single Damage" }, {
      global = true,
      save = true,
      description = "Choose between Spread Damage or Single Damage for Dragonstorm gun",
    })

    v519:CreateSlider(farmSettings, "Gun Shoot Amount", "ShootAmount", 1, 10, 1, {
      global = true,
      save = true,
      description = "Number of shots to fire per attack cycle",
    })

    v519:CreateToggle(
      farmSettings, "Remove Fast Attack Animation", "RemoveAnimationFast", true,
      { global = true, save = true }
    )

    v519:CreateToggle(farmSettings, "attack mobs", "attackmobs", true, {
      global = true,
      save = true,
    })

    v519:CreateToggle(farmSettings, "attack players", "attackplayers", true, {
      global = true,
      save = true,
    })

    v519:CreateToggle(
      farmSettings, "Auto Activate Observation Haki", "AutoActivateObservationHaki", false,
      { global = true, save = true }
    )

    v519:CreateToggle(farmSettings, "Auto Set Spawn Point", "AutoSetSpawnPoint", false, {
      global = true,
      save = true,
    })

    v519:CreateToggle(farmSettings, "Debounce Quests", "QuestDebounce", false, { global = true })

    v519:CreateToggle(farmSettings, "Bypass Get Quest", "BypassGetQuest", false, {
      global = true,
      save = true,
      description = "Gets the quest without teleporting to the quest NPC",
    })

    v519:CreateDropdown(
      farmSettings, "Select Team", "TeamSelectLoad", 1, { "Pirates", "Marines" },
      { global = true }
    )

    v519:CreateToggle(farmSettings, "Auto Load Script on Load", "AutoLoadScriptonLoad", false, {
      global = true,
      save = true,
      description = "Works on higher unc executors",
      callback = v544.OnAutoLoadScript,
    })

    v519:CreateToggle(farmSettings, "Disable Damage Counter", "DisableDamageCounter", false, {
      callback = v544.ToggleDamageCounter,
    })

    v519:CreateToggle(farmSettings, "Disable Notifications", "DisableNotifications", false, {
      callback = v544.ToggleNotifications,
    })

    v519:CreateToggle(farmSettings, "Walk in Water", "Water", true, {
      callback = v544.ToggleWalkInWater,
    })

    v519:CreateToggle(farmSettings, "Auto Hop When Admin Joined", "HopWhenAdmin", true, {
      callback = v544.ToggleHopAdmin,
    })

    v519:CreateToggle(farmSettings, "Anti Afk", "AntiAFK", true, {
      callback = v544.ToggleAntiAFK,
    })

    if v544.RemoveEffects then
      farmSettings:addButton("Remove Effects", v544.RemoveEffects)
    end

    local farmSettings2 = addSection2:addMenu("Farm Settings")

    v519:CreateDropdown(
      farmSettings2, "Select Skills", "SelectSkills", "Blox Fruit",
      { "Blox Fruit", "Melee", "Sword", "Gun" }, { global = true }, true
    )

    v519:CreateDropdown(
      farmSettings2, "Blox Fruit Skills", "BloxFruitKeys", "Z", { "Z", "X", "C", "V", "F" },
      { global = true }, true
    )

    v519:CreateDropdown(
      farmSettings2, "Melee Skills", "MeleeKeys", "Z", { "Z", "X", "C" }, { global = true },
      true
    )

    v519:CreateDropdown(
      farmSettings2, "Sword Skills", "SwordKeys", "Z", { "Z", "X" }, { global = true }, true
    )

    v519:CreateDropdown(
      farmSettings2, "Gun Skills", "GunKeys", "Z", { "Z", "X" }, { global = true }, true
    )

    v519:CreateToggle(farmSettings2, "Auto Use Skills", "AutoSkills", false, {
      global = true,
      save = true,
    })

    local skillsSettings = addSection2:addMenu("Skills Settings")

    v519:CreateSlider(skillsSettings, "Z Hold Time (ms)", "HoldTime_Z", 0, 5, 0, {
      global = true,
      save = true,
      step = 0.1,
    })

    v519:CreateSlider(skillsSettings, "X Hold Time (ms)", "HoldTime_X", 0, 5, 0, {
      global = true,
      save = true,
      step = 0.1,
    })

    v519:CreateSlider(skillsSettings, "C Hold Time (ms)", "HoldTime_C", 0, 5, 0, {
      global = true,
      save = true,
      step = 0.1,
    })

    v519:CreateSlider(skillsSettings, "V Hold Time (ms)", "HoldTime_V", 0, 5, 0, {
      global = true,
      save = true,
      step = 0.1,
    })

    v519:CreateSlider(skillsSettings, "F Hold Time (ms)", "HoldTime_F", 0, 5, 0, {
      global = true,
      save = true,
      step = 0.1,
    })

    v519:CreateSlider(skillsSettings, "Blox Fruit Skill Delay (ms)", "BloxFruitDelay", 0, 5, 0, {
      global = true,
      save = true,
      step = 0.1,
    })

    v519:CreateSlider(skillsSettings, "Melee Skill Delay (ms)", "MeleeDelay", 0, 5, 0, {
      global = true,
      save = true,
      step = 0.1,
    })

    v519:CreateSlider(skillsSettings, "Sword Skill Delay (ms)", "SwordDelay", 0, 5, 0, {
      global = true,
      save = true,
      step = 0.1,
    })

    v519:CreateSlider(skillsSettings, "Gun Skill Delay (ms)", "GunDelay", 0, 5, 0, {
      global = true,
      save = true,
      step = 0.1,
    })

    local addSection3 = v518.Sub:addSection()
    local worldFarm = addSection3:addMenu("World Farm")

    v519:CreateToggle(worldFarm, "Auto Second Sea Quest", "AutoSecondSea", false, {
      global = true,
      stop = true,
    })

    v519:CreateToggle(worldFarm, "Auto Third Sea Quest", "AutoThirdSea", false, {
      global = true,
      stop = true,
    })

    local questFarm = addSection3:addMenu("Quest Farm")

    v519:CreateToggle(questFarm, "Complete Saber Quest", "AutoUnlockSaber", false, {
      global = true,
      stop = true,
    })

    v519:CreateToggle(questFarm, "Complete Bartilo Quest", "AutoBartiloQuest", false, {
      global = true,
      stop = true,
    })

    v519:CreateToggle(questFarm, "Complete Citizen Quest", "CompleteCitizenQuest", false, {
      global = true,
      stop = true,
    })

    v519:CreateToggle(questFarm, "Complete Rainbow Haki Quest", "GetRainbowHaki", false, {
      global = true,
      stop = true,
    })

    local itemsFarm = addSection3:addMenu("Items Farm")

    v519:CreateToggle(itemsFarm, "Auto Get Yama (Fully)", "AutoYama", false, {
      global = true,
      save = true,
      stop = true,
    })

    v519:CreateToggle(itemsFarm, "Auto Get Tushita (Fully)", "AutoTushita", false, {
      global = true,
      save = true,
      stop = true,
    })

    v519:CreateToggle(itemsFarm, "Auto Get Rengoku (Fully)", "AutoRengoku", false, {
      global = true,
      stop = true,
    })

    v519:CreateToggle(itemsFarm, "Auto Get TTK (Fully)", "AutoTTK", false, {
      global = true,
      save = true,
      stop = true,
    })

    v519:CreateToggle(
      addSection3:addMenu("Sword Mastery"), "Auto Mastery Swords (Fully)", "AutoMasterySwords",
      false, { global = true, save = true }
    )

    local fightStyleObtainment = addSection3:addMenu("Fight Style Obtainment")

    v519:CreateToggle(fightStyleObtainment, "Auto Death Step", "AutoDeathStep", false, {
      global = true,
      stop = true,
    })

    v519:CreateToggle(
      fightStyleObtainment, "Auto Sharkman Karate", "AutoSharkmanKarate", false,
      { global = true, stop = true }
    )

    v519:CreateToggle(fightStyleObtainment, "Auto Electric Claw", "AutoElectricClaw", false, {
      global = true,
      stop = true,
    })

    v519:CreateToggle(fightStyleObtainment, "Auto Dragon Talon", "AutoDragonTalon", false, {
      global = true,
      stop = true,
    })

    local addSection4 = v518.Sub:addSection()
    local timelyFarm = addSection4:addMenu("Timely Farm")

    v519:CreateToggle(timelyFarm, "Auto Elite Hunter", "AutoTaskEliteHunter", false, {
      global = true,
      save = true,
      stop = true,
    })

    v519:CreateToggle(timelyFarm, "Auto Factory Raid", "AutoFactoryRaid", false, {
      global = true,
      save = true,
      stop = true,
    })

    v519:CreateToggle(timelyFarm, "Auto Pirate Raid", "AutoFarmPirateRaid", false, {
      global = true,
      save = true,
      stop = true,
    })

    v519:CreateToggle(timelyFarm, "Auto Soul Reaper", "AutoSoulReaper", false, {
      global = true,
      save = true,
      stop = true,
    })

    v519:CreateToggle(timelyFarm, "Auto Darkbeard", "AutoDarkbeard", false, {
      global = true,
      save = true,
      stop = true,
    })

    v519:CreateToggle(timelyFarm, "Auto Greybeard", "AutoGreybeard", false, {
      global = true,
      save = true,
      stop = true,
    })

    v519:CreateToggle(timelyFarm, "Auto Cursed Captain", "AutoCursedCaptain", false, {
      global = true,
      save = true,
      stop = true,
    })

    v519:CreateToggle(timelyFarm, "Auto Open Colors Plate", "AutoOpenColorsTask", false, {
      global = true,
      save = false,
      stop = true,
    })

    v519:CreateToggle(timelyFarm, "Auto True Form Rip Indra", "AutoRipIndra", false, {
      global = true,
      save = true,
      stop = true,
    })

    local otherFarm = addSection4:addMenu("Other Farm")

    v519:CreateToggle(otherFarm, "Start Farm Observation", "AutoFarmObservation", false, {
      global = true,
      save = true,
      stop = true,
    })

    v519:CreateToggle(otherFarm, "Auto Get Observation V2", "AutoKenV2", false, {
      global = true,
      save = true,
      stop = true,
    })

    v519:CreateToggle(otherFarm, "Farm Observation Hopping", "StartObsHop", false, {
      global = true,
      save = true,
    })

    v519:CreateToggle(otherFarm, "Auto Dummy Training", "DummyTraining", false, {
      global = true,
      save = true,
      stop = true,
    })

    local addSection5 = v518.Sevent:addSection()
    local mirageEvent = addSection5:addMenu("Mirage Event")

    v519:CreateToggle(mirageEvent, "Auto Find Mirage Island", "AutoFindMirageIsland", false, {
      global = true,
      save = true,
      stop = true,
    })

    v519:CreateToggle(mirageEvent, "Teleport to Mirage", "AutoTeleportMirage", false, {
      global = true,
      save = true,
      stop = true,
    })

    local kitsuneEvent = addSection5:addMenu("Kitsune Event")

    v519:CreateToggle(kitsuneEvent, "Auto Find Kitsune Island", "AutoFindKitsuneIsland", false, {
      global = true,
      save = true,
      stop = true,
    })

    v519:CreateToggle(kitsuneEvent, "Teleport to Shrine", "AutoTeleportKitsune", false, {
      global = true,
      save = true,
      stop = true,
    })

    v519:CreateToggle(kitsuneEvent, "Auto Collect Azure Embers", "CollectAzure", false, {
      global = true,
      save = true,
      stop = true,
    })

    v519:CreateSlider(kitsuneEvent, "Set Azure Ember", "SetAzureEmber", 1, 25, 1, {
      global = true,
    })

    v519:CreateToggle(kitsuneEvent, "Auto Trade Azure Ember", "TradeAzureEmber", false, {
      global = true,
      save = true,
    })

    addSection5:addMenu("Leviathan Hunt"):addButton(
      "Bribe", v544.BribeLeviathan or function() end
    )

    local addSection6 = v518.Sevent:addSection()
    local seaFarm = addSection6:addMenu("Sea Farm")

    v519:CreateDropdown(
      seaFarm, "Select Boat", "BoatSelected", "PirateBrigade", v530.BoatsList or {},
      { global = true, save = true }
    )

    v519:CreateDropdown(seaFarm, "Select Zone", "SeaLevelSelected", 6, v530.ZoneList or {}, {
      global = true,
    })

    v519:CreateSlider(seaFarm, "Boat Speed", "SpeedBoat", 10, 350, 275, { global = true })

    v519:CreateDropdown(
      seaFarm, "Sea Event Targets", "SeaEventTargets", 1, v530.SeaEventTargets or {},
      { global = true }, true
    )

    local getAllBoats = v544.GetAllBoats and v544.GetAllBoats() or { "My Boat" }

    local dropdown = v519:CreateDropdown(
      seaFarm, "Select Owned Boat", "SailTargetBoat", "My Boat", getAllBoats, { global = true }
    )

    seaFarm:addButton("Refresh Boats", function()
      if v544.GetAllBoats then
        getAllBoats = v544.GetAllBoats()
        dropdown:Refresh(getAllBoats)
      end
    end)

    v519:CreateToggle(seaFarm, "ESP My Boat", "ESPMyBoat", false, {
      global = true,
      callback = function(p224)
        v19.ESPMyBoat = p224

        if not p224 then
          if ClearESP then
            ClearESP("MyBoat")
          end
        elseif MyBoatESP then
          MyBoatESP()
        end
      end,
    })

    v519:CreateToggle(seaFarm, "Auto Drive", "AutoSail", false, { global = true, stop = true })

    seaFarm:addButton("Buy New Boat", v544.BuyNewBoat or function() end)

    v519:CreateToggle(seaFarm, "Auto Farm Sea Events", "AutoFarmSeaEvents", false, {
      global = true,
      description = "don't turn off Auto Drive when farming sea events, it's connected",
    })

    v519:CreateToggle(seaFarm, "Auto Repair Boat", "AutoRepairBoat", false, {
      global = true,
      save = true,
    })

    v519:CreateToggle(seaFarm, "Protect Boat (Float in Combat)", "ProtectBoat", true, {
      global = true,
      save = true,
      description = "Floats your boat high in the air when fighting sea events to prevent damage",
    })

    v519:CreateToggle(seaFarm, "Auto Buy New Boat When dies", "AutoBuyNewBoatWhendies", false, {
      global = true,
    })

    v519:CreateToggle(
      seaFarm, "Auto Reset Charater if boat destroyed", "ResetPlayerdestroyboat", true,
      { global = true }
    )

    v519:CreateToggle(seaFarm, "Auto Dodge Terror Shark", "DodgeTerror", true, {
      global = true,
      save = true,
    })

    v519:CreateToggle(seaFarm, "Auto Dodge Seabeast", "DodgefSeabeast", true, {
      global = true,
      save = true,
    })

    v519:CreateToggle(
      seaFarm, "Use M1 DragonStorm for Seabeast/ships", "UseDragonSforSeabeasts", false,
      { global = true }
    )

    v519:CreateSlider(seaFarm, "Manual Speed", "ManualBoatSpeed", 20, 350, 220, {
      global = true,
      save = true,
    })

    v519:CreateToggle(seaFarm, "Manual Increase Boat Speed", "ManualIncreaseBoatSpeed", false, {
      global = true,
      save = true,
    })

    local fishing = addSection6:addMenu("Fishing")

    v519:CreateDropdown(fishing, "Fishing Rods", "SelectedRod", 1, v530.RodsList or {}, {
      global = true,
    })

    v519:CreateDropdown(fishing, "Baits", "SelectedBait", 1, v530.BaitsList or {}, {
      global = true,
    })

    fishing:addButton("Open Fish Index", v544.OpenFishIndex or function() end)

    v519:CreateToggle(fishing, "Auto Fishing", "Auto_Fishing", false, { global = true })
    v519:CreateToggle(fishing, "Auto Catch Chest", "AutoGetChest", false, { global = true })
    v519:CreateToggle(fishing, "Auto Craft Bait", "AutoCraftBait", false, { global = true })

    v519:CreateToggle(fishing, "Auto Get / Complete Angler Quest", "AutoGetAnglerQuest", false, {
      global = true,
      save = true,
    })

    v519:CreateToggle(fishing, "Auto Sell Fish", "AutoSellFish", false, { global = true })
    v519:CreateToggle(fishing, "Auto Use Rod Skill", "AutoUseRodSkill", false, { global = true })

    v519:CreateToggle(
      addSection6:addMenu("FishSlap Minigame"), "Auto Fish Slap", "AutoSlap", false,
      { global = true }
    )

    local playerStats = v518.Player:addSection():addMenu("Player Stats")
    local addLabel = playerStats:addLabel("Player Status", "Scanning for Information...")

    spawn(function()
      while task.wait(0.5) do
        if v544.GetStatsInfo then
          addLabel:RefreshDesc(v544.GetStatsInfo())
        end
      end
    end)

    v519:CreateSlider(playerStats, "Select Points", "PointsSlider", 0, 1000, 10, {
      global = true,
    })

    v519:CreateToggle(playerStats, "Melee", "Melee", false, { global = true })
    v519:CreateToggle(playerStats, "Defense", "Defense", false, { global = true })
    v519:CreateToggle(playerStats, "Sword", "Sword", false, { global = true })
    v519:CreateToggle(playerStats, "Gun", "Gun", false, { global = true })
    v519:CreateToggle(playerStats, "Devil Fruit", "DemonFruit", false, { global = true })

    v519:CreateToggle(playerStats, "Start Adding Stats", "AutoStats", false, {
      global = true,
      callback = function(p225)
        if p225 and v544.AutoStats then
          v544.AutoStats()
        end
      end,
    })

    task.wait(0.02)
    local addSection7 = v518.Player:addSection()
    local espMenu = addSection7:addMenu("ESP Menu")

    for key66, value152 in next, {
      { "Players ESP", "ESPPlayer", "Player", PlayerESP },
      { "Islands ESP", "ESPIsland", "Island", IslandESP },
      { "Fruits ESP", "DevilFruitESP", "Fruit", FruitESP },
      { "Chests ESP", "ESPChest", "Chest", ChestESP },
      { "Berries ESP", "ESP_Berries", "Berry", BerryESP },
      { "Natural Fruits ESP (Pineapple, etc.)", "ESP_RealFruits", "RealFruit", RealFruitESP },
    }, nil do
      local v665 = value152

      v519:CreateToggle(espMenu, v665[1], v665[2], false, {
        callback = function(p226)
          v19[v665[2]] = p226

          if not p226 then
            if ClearESP then
              ClearESP(v665[3])
            end
          elseif v665[4] then
            v665[4]()
          end
        end,
      })
    end

    local pvpMenu = addSection7:addMenu("PVP Menu")

    local function f105()
      return v544.GetPlayerList and v544.GetPlayerList() or { "Nearest" }
    end

    local dropdown2 = v519:CreateDropdown(pvpMenu, "Select Player", "SelectPlayer", 1, f105(), {
      global = true,
    })

    pvpMenu:addButton("Refresh Player List", function()
      if dropdown2 and dropdown2.Refresh then
        dropdown2:Refresh(f105())
      end
    end)

    v519:CreateToggle(pvpMenu, "Cam Lock", "CamLock", false, {
      global = true,
      callback = v544.OnCamLockToggle,
    })

    v519:CreateToggle(pvpMenu, "Spectate Player", "SpectatePlayer", false, {
      global = true,
      callback = v544.OnSpectateToggle,
    })

    v519:CreateToggle(pvpMenu, "Teleport to Player", "TeleporttoPlayer", false, {
      global = true,
      stop = true,
      callback = v544.OnTPPlayerToggle,
    })

    v519:CreateToggle(pvpMenu, "Enable Aimbot ", "EnableAimbot", false, { global = true })

    pvpMenu:addButton("Get Player Quest", v544.GetPlayerHunterQuest or function() end)
    local serverMenu = addSection7:addMenu("Server Menu")
    local addLabel2 = serverMenu:addLabel("Server Status", "Loading...")
    v33._ServerInfo = addLabel2

    serverMenu:addButton("Refresh Server Info", function()
      pcall(function()
        if v544.StatusServer then
          addLabel2:RefreshDesc(v544.StatusServer())
        end
      end)
    end)

    local addLabel3 = serverMenu:addLabel("Player Status", "Loading...")

    serverMenu:addButton("Refresh Player Info", function()
      if v544.PlayerStatus then
        addLabel3:RefreshDesc(v544.PlayerStatus())
      end
    end)

    local addLabel4 = serverMenu:addLabel("Fruit Stock", "Loading fruit stock...")

    serverMenu:addButton("Refresh Fruit Stock", function()
      if v544.GetFruitStock then
        addLabel4:RefreshDesc(v544.GetFruitStock())
      end
    end)

    spawn(function()
      task.wait(0.5)

      pcall(function()
        if v544.StatusServer and addLabel2 then
          addLabel2:RefreshDesc(v544.StatusServer())
        end
      end)
    end)

    local addSection8 = v518.Dragon:addSection()
    local berryFarm = addSection8:addMenu("Berry Farm")

    v519:CreateToggle(berryFarm, "Auto Collect Berries", "AutoBerrySafe", false, {
      global = true,
      stop = true,
    })

    v519:CreateToggle(berryFarm, "Hop If No Berries", "HopIfNoBerries", false, {
      global = true,
      save = true,
    })

    local beltObtainment = addSection8:addMenu("Belt Obtainment")
    beltObtainment:addButton("Teleport to Dojo Trainer", v544.TPDojoTrainer or function() end)

    v519:CreateToggle(beltObtainment, "Auto White Belt", "AutoWhiteBelt", false, {
      global = true,
      stop = true,
    })

    v519:CreateToggle(beltObtainment, "Auto Purple Belt", "AutoPurpleBelt", false, {
      global = true,
      stop = true,
    })

    local addSection9 = v518.Dragon:addSection()
    local prehistoricEvent = addSection9:addMenu("Prehistoric Event")

    v33._FindPrehistoricIsland = v519:CreateToggle(
      prehistoricEvent, "Auto Find Prehistoric Island", "AutoFindPrehistoricIsland", false,
      { global = true, save = true, stop = true }
    )

    v519:CreateToggle(
      prehistoricEvent, "Teleport to Prehistoric Island", "AutoTeleportPrehistoric", false,
      { global = true, save = true, stop = true }
    )

    v519:CreateToggle(
      prehistoricEvent, "Auto Complete Volcanic Event", "AutoVolcanicEvent", false,
      { global = true, stop = true }
    )

    v519:CreateToggle(prehistoricEvent, "Use Skull Guitar for Volcano", "ShootGunVolcano", true, {
      global = true,
      save = true,
      description = "Uses Skull Guitar custom shoot to patch the volcano",
    })

    v519:CreateToggle(prehistoricEvent, "Auto Collect Bones", "AutoCollectBones", false, {
      global = true,
      save = true,
      stop = true,
    })

    v519:CreateToggle(prehistoricEvent, "Auto Collect Dragon Eggs", "AutoCollectEgg", false, {
      global = true,
      save = true,
      stop = true,
    })

    v519:CreateToggle(prehistoricEvent, "Auto Farm Blaze Ember", "AutoQuestBlaze", false, {
      global = true,
      save = true,
      stop = true,
    })

    v519:CreateDropdown(
      prehistoricEvent, "Select Gun", "SelectGunBlaze", 1, { "Skull Guitar", "Bazooka" },
      { global = true }
    )

    v519:CreateToggle(prehistoricEvent, "Use Shoot Gun for tree quest", "ShootGunBlaze", false, {
      global = true,
      save = true,
    })

    prehistoricEvent:addButton(
      "Teleport to Dragon Hunter", v544.TPDragonHunter or function() end
    )

    prehistoricEvent:addButton(
      "Teleport to Dragon Wizard", v544.TPDragonWizard or function() end
    )

    v519:CreateToggle(
      prehistoricEvent, "Auto Upgrade Dragon Talon", "AutoUpgradeDragonTalon", false,
      { callback = v544.ToggleUpgradeDragonTalon }
    )

    prehistoricEvent:addButton("Craft Volcanic Magnet", function()
      v544.CraftPrehistoricItem("Volcanic Magnet")
    end)

    prehistoricEvent:addButton("Craft Dragonheart", function()
      v544.CraftPrehistoricItem("Dragonheart")
    end)

    prehistoricEvent:addButton("Craft Dragonstorm", function()
      v544.CraftPrehistoricItem("Dragonstorm")
    end)

    prehistoricEvent:addButton("Craft Dino Hood", function()
      v544.CraftPrehistoricItem("DinoHood")
    end)

    prehistoricEvent:addButton("Craft T-Rex Skull", function()
      v544.CraftPrehistoricItem("TRexSkull")
    end)

    local dracoRace = addSection9:addMenu("Draco Race")

    v33._AutoTrialDracoToggle = v519:CreateToggle(
      dracoRace, "Teleport to Draco Trial", "AutoTrialDracoTP", false,
      { global = true, stop = true }
    )

    dracoRace:addButton("Change to Draco Race", v544.ChangeDracoRace or function() end)

    v519:CreateToggle(dracoRace, "Auto Draco Race V2 ", "AutoCollectFireFlowers", false, {
      global = true,
      stop = true,
    })

    local addSection10 = v518.Raid:addSection()
    local raidMenu = addSection10:addMenu("Raid Menu")

    v519:CreateDropdown(raidMenu, "Raid Chip", "SelectRaid", 1, v530.Raids_Chip or {}, {
      global = true,
    })

    v519:CreateToggle(raidMenu, "Auto Buy Chip", "AutoBuyChip", false, {
      global = true,
      save = true,
    })

    v33._AutoRaidToggle = v519:CreateToggle(
      raidMenu, "Auto Complete Raid", "AutoRaidFull", false, { global = true, stop = true }
    )

    v519:CreateToggle(raidMenu, "Auto Unstore Below 1m Fruit", "AutoUnstoreBelowFruit", false, {
      global = true,
      save = true,
      description = "this will ignore fruit skins",
    })

    v519:CreateToggle(raidMenu, "Auto Awaken", "AutoAwaken", false, {
      global = true,
      save = true,
    })

    v519:CreateSlider(raidMenu, "Frags Cap", "FragsCap", 1000, 1000000, 1000, { global = true })

    v519:CreateToggle(
      raidMenu, "Auto stop raid when fragments reach cap", "Autostopraid", false,
      { global = true, save = true }
    )

    local dungeonMenu = addSection10:addMenu("Dungeon Menu")

    v519:CreateToggle(dungeonMenu, "Auto Unlock Difficulties", "AutoUnlockDifficulties", false, {
      global = true,
      save = true,
      description = "Automatically unlocks Hard and Challenge difficulties using Simulation Data",
    })

    v519:CreateToggle(dungeonMenu, "Auto Complete Dungeon", "AutoDungeonFull", false, {
      global = true,
      stop = true,
    })

    v519:CreateToggle(
      dungeonMenu, "Auto Destroy Shrines and Vents", "AutoDungeonShrine", false,
      { global = true, stop = true }
    )

    v519:CreateDropdown(
      dungeonMenu, "Select Cards", "CardsSelection", 1, v530.DungeonCards or {},
      { global = true }, true
    )

    v519:CreateToggle(dungeonMenu, "Auto Select Cards", "AutoCardsDungeon", false, {
      global = true,
    })

    dungeonMenu:addButton(
      "Unlock Next Difficulty", v544.UnlockDungeonDifficulty or function() end
    )

    dungeonMenu:addButton("Teleport to Dungeon Map", v544.TPDungeonHub or function() end)
    dungeonMenu:addButton("Return to Previous Sea", v544.TPDungeonBack or function() end)

    v519:CreateToggle(
      addSection10:addMenu("Law Menu"), "Start Law Raid Farm", "AutoLawRaid", false,
      { global = true, stop = true, save = true }
    )

    task.wait(0.02)
    local addSection11 = v518.Raid:addSection()

    local fruitMenu = addSection11:addMenu("Fruit Menu")
    fruitMenu:addButton("Open Normal Shop", v544.OpenNormalFruitShop or function() end)
    fruitMenu:addButton("Open Advanced Shop", v544.OpenAdvFruitShop or function() end)

    v519:CreateToggle(fruitMenu, "Auto Roll Fruit", "Random_Auto", false, {
      global = true,
      save = true,
    })

    v519:CreateToggle(fruitMenu, "Auto Store Fruit", "AutoStoreFruit", false, {
      global = true,
      save = true,
    })

    local addLabel5 = fruitMenu:addLabel("Fruit Spawn Status", "Scanning for fruit...")

    spawn(function()
      while task.wait(1.5) do
        if v544.GetFruitSpawnStatus then
          addLabel5:RefreshDesc(v544.GetFruitSpawnStatus())
        end
      end
    end)

    v519:CreateToggle(fruitMenu, "Teleport to Fruit", "Tweenfruit", false, {
      global = true,
      save = true,
      stop = true,
    })

    v519:CreateToggle(fruitMenu, "Hop If No Fruit In Server", "HopIfNoFruit", false, {
      global = true,
      save = true,
    })

    v519:CreateToggle(fruitMenu, "Fruit Notification", "FruitCheck", false, {
      global = true,
      save = true,
    })

    fruitMenu:addButton(
      "Teleport To Advanced Fruit Dealer", v544.TPAdvFruitDealer or function() end
    )

    local trinketsRefiner = addSection11:addMenu("Trinkets & Refiner")
    trinketsRefiner:addButton("Buy Trinket", v544.BuyTrinket or function() end)

    v519:CreateToggle(trinketsRefiner, "Auto Buy Trinkets", "AutoBuyTrinkets", false, {
      global = true,
      save = true,
      description = "Automatically buys trinkets when fragments/currency available",
    })

    trinketsRefiner:addButton("Fuse / Merge 3 Trinkets", v544.FuseTrinkets or function() end)

    v519:CreateToggle(trinketsRefiner, "Auto Fuse / Merge Trinkets", "AutoFuseTrinkets", false, {
      global = true,
      save = true,
      description = "Automatically merges 3 matching trinkets to upgrade grade",
    })

    trinketsRefiner:addButton("Reforge / Refine Trinket", v544.RefineTrinket or function() end)

    v519:CreateToggle(trinketsRefiner, "Auto Refine Trinket", "AutoRefineTrinkets", false, {
      global = true,
      save = true,
      description = "Automatically rerolls/refines trinket stats",
    })

    trinketsRefiner:addButton(
      "Open Trinket Merge GUI", v544.OpenTrinketMergeGUI or function() end
    )

    trinketsRefiner:addButton(
      "Open Trinket Refiner GUI", v544.OpenTrinketRefineGUI or function() end
    )

    trinketsRefiner:addButton(
      "Open Trinket Scrap / Trash GUI", v544.OpenTrinketScrapGUI or function() end
    )

    v519:CreateToggle(trinketsRefiner, "Auto Scrap Junk Trinkets", "AutoScrapTrinkets", false, {
      global = true,
      save = true,
      description = "Automatically scraps surplus trinkets for simulation data",
    })

    local addSection12 = v518.Trial:addSection()
    local trials = addSection12:addMenu("Trials")

    if v544.InitTempleOfTime then
      v544.InitTempleOfTime()
    end

    trials:addButton("Go to Race Door", v544.TPRaceDoor or function() end)

    local v666 = {
      "Last Resort", "Agility", "Water Body", "Heavenly Blood", "Heightened Senses",
      "Energy Core", "Primordial Reign",
    }

    local function f106()
      local v667 = {}

      for index76, value153 in ipairs(players:GetPlayers()) do
        if value153 ~= localPlayer and value153:FindFirstChild("Data")
          and value153.Data:FindFirstChild("Race") then
          v667[value153.Name] = value153.Data.Race.Value
        end
      end

      return v667
    end

    local function f107()
      local count9 = 0

      local templeOfTime = map and map:FindFirstChild("Temple of Time")
        or v4:FindFirstChild("Map") and v4.Map:FindFirstChild("Temple of Time")

      if not templeOfTime then
        if v544 and v544.InitTempleOfTime then
          v544.InitTempleOfTime()
        end

        templeOfTime = map and map:FindFirstChild("Temple of Time")
          or v4:FindFirstChild("Map") and v4.Map:FindFirstChild("Temple of Time")
      end

      if not templeOfTime then
        return false
      else
        local getChildren14 = v4.Characters:GetChildren()

        for key67, value154 in pairs(f106()) do
          local findFirstChild7 = templeOfTime:FindFirstChild(value154 .. "Corridor")

          if findFirstChild7 then
            local union = findFirstChild7:FindFirstChild("Door")
              and findFirstChild7.Door:FindFirstChild("Door")
              and findFirstChild7.Door.Door:FindFirstChild("RightDoor")
              and (findFirstChild7.Door.Door.RightDoor:FindFirstChild("Union")
                or findFirstChild7.Door.Door.RightDoor:FindFirstChildWhichIsA("BasePart"))

            if not union and findFirstChild7:FindFirstChild("Door") then
              union = findFirstChild7.Door:FindFirstChildWhichIsA("BasePart", true)
            end

            if union then
              for index77, value155 in ipairs(getChildren14) do
                if value155.Name == key67 then
                  local humanoidRootPart41 = value155:FindFirstChild("HumanoidRootPart")
                  local v668 = false

                  if humanoidRootPart41 then
                    for index78, value156 in ipairs(v666) do
                      if humanoidRootPart41:FindFirstChild(value156)
                        or value155:FindFirstChild(value156) then
                        v668 = true
                        break
                      end
                    end
                  end

                  if v668 and (humanoidRootPart41.Position - union.Position).Magnitude <= 50 then
                    count9 = count9 + 1
                  end

                  break
                end
              end
            end
          end
        end

        return count9 >= 2
      end
    end

    v519:CreateToggle(trials, "Auto (Activate) Race", "AutoActiveRacenear", false, {
      global = true,
      description = "instantly activates the race the moment 2+ accounts are ready there",
    })

    spawn(function()
      local v669 = 0

      while task.wait() do
        pcall(function()
          if v19.AutoActiveRacenear and tick() - v669 > 1 and f107() then
            v669 = tick()
            v5.Remotes.CommE:FireServer("ActivateAbility")
          end
        end)
      end
    end)

    v519:CreateToggle(trials, "Auto Complete Trials", "AutoFinishTrial", false, {
      global = true,
      stop = true,
    })

    v519:CreateToggle(trials, "Kill Players after Trial", "AutoKillPlayerinTrial", false, {
      global = true,
      stop = true,
    })

    trials:addButton("Reset Character", v544.ResetCharHead or function() end)

    v519:CreateToggle(trials, "Auto Choose Gear", "AutoChooseGear", false, {
      global = true,
      stop = true,
      description = "Automatically selects and places your gear in the Ancient Clock upon winning the trial",
    })

    v519:CreateDropdown(
      trials, "Train Method", "TrainMethod", "Bones", v530.TrainMethods or { "Bones", "Cakes" },
      { global = true }
    )

    v519:CreateToggle(trials, "Start Auto Train", "AutoTrainGear", false, {
      global = true,
      stop = true,
    })

    v519:CreateToggle(trials, "Teleport To Blue Gear", "TweenMGear", false, { global = true })

    local area = addSection12:addMenu("Area")
    area:addButton("Teleport to Top of Great Tree", function() v544.TPTrialArea("GreatTree") end)
    area:addButton("Teleport to Temple of Time", function() v544.TPTrialArea("TempleOfTime") end)
    area:addButton("Teleport to Ancient One", function() v544.TPTrialArea("AncientOne") end)
    area:addButton("Teleport to Lever Pull", function() v544.TPTrialArea("LeverPull") end)
    area:addButton("Teleport to Safe Zone", function() v544.TPTrialArea("SafeZone") end)
    area:addButton("Teleport back to Pvp Zone", function() v544.TPTrialArea("PvpZone") end)
    area:addButton("Teleport to Clock", function() v544.TPTrialArea("Clock") end)

    local addSection13 = v518.Trial:addSection()
    local miscTrial = addSection13:addMenu("Misc Trial")

    v519:CreateToggle(miscTrial, "Auto Upgrade Gear", "BuyGear", false, { global = true })

    v519:CreateToggle(miscTrial, "Auto Activate V3", "AutoAgility", false, {
      global = true,
      save = true,
    })

    v519:CreateToggle(miscTrial, "Auto Activate V4", "AutoActiveRaceV4", false, {
      global = true,
      save = true,
    })

    v519:CreateToggle(miscTrial, "Auto Look Moon", "AutoLookMoon", false, { global = true })

    local upgrades = addSection13:addMenu("Upgrades")

    v519:CreateToggle(upgrades, "Auto Race Evolve V2", "AutoStartRaceV2", false, {
      global = true,
      stop = true,
    })

    v519:CreateToggle(upgrades, "Auto Race Evolve V3", "AutoStartRaceV3", false, {
      global = true,
      stop = true,
    })

    local raceObtainment = addSection13:addMenu("Race Obtainment")

    v519:CreateToggle(raceObtainment, "Auto Get Ghoul Race [Fully]", "AutoGetGhoulRace", false, {
      global = true,
      stop = true,
    })

    v519:CreateToggle(
      raceObtainment, "Auto Get Cyborg Race [Fully]", "AutoGetCyborgRace", false,
      { global = true, stop = true }
    )

    local addSection14 = v518.Travel:addSection()

    local worldTravel = addSection14:addMenu("World Travel")
    worldTravel:addButton("Teleport to World 1", function() commF:InvokeServer("TravelMain") end)

    worldTravel:addButton("Teleport to World 2", function()
      commF:InvokeServer("TravelDressrosa")
    end)

    worldTravel:addButton("Teleport to World 3", function() commF:InvokeServer("TravelZou") end)

    local islandTravel = addSection14:addMenu("Island Travel")
    v33._ActiveIslands = v530.ActiveIslands or {}

    v519:CreateDropdown(
      islandTravel, "Select Island", "TeleportIslandSelect", "walang kayo sorry",
      v530.IslandsList or {}, { global = true }
    )

    v33._TravelToggle = v519:CreateToggle(
      islandTravel, "Start Traveling", "TeleportToIsland", false, { global = true, stop = true }
    )

    local npcTravel = addSection14:addMenu("NPC Travel")

    v519:CreateDropdown(npcTravel, "Select Npc", "NpcTween", 1, v530.NPCList or {}, {
      global = true,
    })

    v519:CreateToggle(npcTravel, "Start Traveling", "TPtoNPC", false, {
      global = true,
      stop = true,
    })

    local addSection15 = v518.Travel:addSection()
    local serverTravel = addSection15:addMenu("Server Travel")

    v519:CreateTextbox(serverTravel, "JobID [" .. game.PlaceId .. "]", "JobID", {
      save = false,
      callback = v544.TeleportJobID,
    })

    v519:CreateTextbox(
      serverTravel, "Quantum Premium [" .. game.PlaceId .. "]", "QuantumPremium",
      { save = false, callback = v544.TeleportQuantumPremium }
    )

    serverTravel:addButton("Copy Current Job ID", function()
      setclipboard(tostring(game.JobId))
    end)

    local miscTravel = addSection15:addMenu("Misc Travel")
    miscTravel:addButton("Rejoin Server", v544.RejoinServer or function() end)
    miscTravel:addButton("Server Hop, Random Server", v544.ServerHop or function() end)

    local quantumJoiner = addSection15:addMenu("Quantum Joiner")
    quantumJoiner:addButton("Join Full Moon Server", function() v544.JoinAPI("FullMoon") end)

    quantumJoiner:addButton("Join Near Full Moon Server", function()
      v544.JoinAPI("NearFullMoon")
    end)

    quantumJoiner:addButton("Join Mirage Island Server", function() v544.JoinAPI("mirage") end)
    quantumJoiner:addButton("Join Elite Hunter Server", function() v544.JoinAPI("elites") end)
    quantumJoiner:addButton("Join Kitsune Island Server", function() v544.JoinAPI("kitsune") end)

    quantumJoiner:addButton("Join Prehistoric Island Server", function()
      v544.JoinAPI("prehistoric")
    end)

    quantumJoiner:addButton("Join Factory Raid Server", function() v544.JoinAPI("factory") end)
    quantumJoiner:addButton("Join 4 Hours Server", function() v544.JoinAPI("fourhours") end)
    quantumJoiner:addButton("Join Castle Raid Server", function() v544.JoinAPI("pirate") end)

    v519:CreateDropdown(
      quantumJoiner, "Select Legendary Sword", "SelectLegendarySword", 1,
      v530.LegendarySwordNames or { "Shizu", "Oroshi", "Saishi" }, { global = true }
    )

    quantumJoiner:addButton("Join Legendary Sword Server", function()
      v544.JoinAPI("legendarysword")
    end)

    quantumJoiner:addButton("Join Fruit Server", function() v544.JoinAPI("fruit") end)

    v519:CreateDropdown(
      quantumJoiner, "Select Boss", "SelectBosstoHop", 1, v530.BossHopNames or {},
      { global = true }
    )

    quantumJoiner:addButton("Join Raid Boss Server", v544.JoinRaidBossServer or function() end)
    local addSection16 = v518.Shop:addSection()
    local selectionShop = addSection16:addMenu("Selection Shop")

    v519:CreateDropdown(selectionShop, "Select Melee", "SelectMelee", 1, v530.MeleeNames or {}, {
      global = true,
    })

    v519:CreateToggle(selectionShop, "Auto Buy Melee", "AutoBuyMelee", false, {
      global = true,
      stop = true,
    })

    v519:CreateDropdown(
      selectionShop, "Abilities", "BuyAbility", "Geppo", v530.AbilityNames or {},
      { global = true }
    )

    selectionShop:addButton("Buy Ability", function()
      if v19.BuyAbility and v544.BuyItem then
        v544.BuyItem(v19.BuyAbility, "Ability")
      end
    end)

    v519:CreateDropdown(
      selectionShop, "Gun list", "GunSelect", "Slingshot", v530.GunNames or {},
      { global = true }
    )

    selectionShop:addButton("Buy Gun", function()
      if v19.GunSelect and v544.BuyItem then
        v544.BuyItem(v19.GunSelect, "Gun")
      end
    end)

    v519:CreateDropdown(
      selectionShop, "Accessories", "BuyAccessories", 1, v530.AccessoryNames or {},
      { global = true }
    )

    selectionShop:addButton("Buy Accessory", function()
      if v19.BuyAccessories and v544.BuyItem then
        v544.BuyItem(v19.BuyAccessories, "Accessory")
      end
    end)

    local itemShop = addSection16:addMenu("Item Shop")

    v519:CreateToggle(itemShop, "Buy Haki Color", "AutoBuyEnchancementColor", false, {
      global = true,
      save = true,
    })

    v519:CreateToggle(itemShop, "Buy Legendary Sword", "BuyLegendSword", false, {
      global = true,
      save = true,
    })

    v519:CreateToggle(itemShop, "Buy True Triple Katana", "BuyTTK", false, {
      global = true,
      save = true,
    })

    local addSection17 = v518.Shop:addSection()
    local normalFruitDealer = addSection17:addMenu("Normal Fruit Dealer")

    v519:CreateDropdown(
      normalFruitDealer, "Select Fruit to Buy", "SelectFruitDealerFruit", "Buddha-Buddha",
      v530.DealerFruitList or {}, { global = true, save = true }
    )

    v519:CreateToggle(
      normalFruitDealer, "Auto Buy Fruit (Normal Dealer)", "AutoBuyFruitDealer", false,
      { global = true, save = true }
    )

    normalFruitDealer:addButton("Buy Selected Fruit", v544.BuySelectedFruit or function() end)

    local raceShop = addSection17:addMenu("Race Shop")
    raceShop:addButton("Cyborg Race", v544.BuyCyborgRace or function() end)
    raceShop:addButton("Ghoul Race", v544.BuyGhoulRace or function() end)

    local fragmentShop = addSection17:addMenu("Fragment Shop")

    fragmentShop:addButton("Reroll Race", function()
      if v544.BuyItem then
        v544.BuyItem("Race Rerol", "Frags")
      end
    end)

    fragmentShop:addButton("Reset Player Stats", function()
      if v544.BuyItem then
        v544.BuyItem("Reset Stats", "Frags")
      end
    end)

    local scrollCraftingTrade = addSection17:addMenu("Scroll Crafting & Trade")

    v519:CreateDropdown(
      scrollCraftingTrade, "Select Scroll", "SelectScrollType", "Common Scroll",
      { "Common Scroll", "Rare Scroll", "Legendary Scroll", "Mythical Scroll" },
      { global = true, save = true }
    )

    v519:CreateSlider(scrollCraftingTrade, "Craft Amount", "ScrollCraftAmount", 1, 10, 1, {
      global = true,
    })

    scrollCraftingTrade:addButton("Craft Selected Scroll", v544.CraftScroll or function() end)

    v519:CreateToggle(scrollCraftingTrade, "Auto Craft Selected Scroll", "AutoCraftScrolls", false, {
      global = true,
      save = true,
      description = "Automatically crafts scrolls when you have sufficient materials",
    })

    local addSection18 = v518.Misc:addSection()

    local teamSelection = addSection18:addMenu("Team Selection")

    teamSelection:addButton("Join Marines Team", function()
      commF:InvokeServer("SetTeam", "Marines")
    end)

    teamSelection:addButton("Join Pirates Team", function()
      commF:InvokeServer("SetTeam", "Pirates")
    end)

    local menuOpenings = addSection18:addMenu("Menu Openings")
    menuOpenings:addButton("Open Title Names", v544.OpenTitleNames or function() end)
    menuOpenings:addButton("Open Awakenings", v544.OpenAwakenings or function() end)

    local playersClients = v518.Misc:addSection():addMenu("Players Clients")

    v519:CreateToggle(
      playersClients, "Remove Observation Effect", "RemoveObservationEffect", false,
      { global = true, save = true }
    )

    v519:CreateSlider(playersClients, "Walk Speed", "WalkSpeed", 50, 500, 50, {
      callback = v544.SetWalkSpeed,
    })

    v519:CreateSlider(playersClients, "Jump Power", "JumpPower", 50, 500, 50, {
      callback = v544.SetJumpPower,
    })

    v519:CreateToggle(playersClients, "X-ray Vision", "XrayVision", false, {
      callback = v544.ToggleXray,
    })

    v519:CreateToggle(playersClients, "Infinite Zoom", "InfiniteZoom", false, {
      callback = v544.ToggleInfiniteZoom,
    })

    v519:CreateToggle(playersClients, "White Screen", "White_Screen", false, {
      callback = v544.ToggleWhiteScreen,
    })

    v519:CreateToggle(playersClients, "Black Screen", "BlackScreen", false, {
      callback = v544.ToggleBlackScreen,
    })

    playersClients:addButton("Redeem all Codes", v544.RedeemAllCodes or function() end)

    v519:CreateToggle(playersClients, "Remove Fog", "NoFog", false, {
      global = true,
      save = true,
    })

    playersClients:addButton("Force FPS BOOST", v544.ForceFPSBoost or function() end)
    playersClients:addButton("Developer Console", v544.OpenDevConsole or function() end)
    playersClients:addButton("Clean Memory / Free RAM (GC)", v544.CleanMemory or function() end)

    v519:CreateToggle(playersClients, "Auto Memory Cleaner (60s)", "AutoCleanMemory", true, {
      global = true,
      save = true,
    })

    v519:CreateToggle(playersClients, "Auto Turn On Fast Mode", "AutoFastMode", false, {
      global = true,
      save = true,
      description = "Automatically enables the game's built-in Fast Mode setting to maximize FPS",
      callback = v544.OnFastModeToggle,
    })

    local addSection19 = v518.Web:addSection()
    local generalWebhook = addSection19:addMenu("General Webhook")

    v519:CreateTextbox(generalWebhook, "Main Webhook Url", "Webhook", {
      save = true,
      global = true,
    })

    v519:CreateToggle(generalWebhook, "Enable Send Webhook", "AutoWebhook", false, {
      global = true,
      save = true,
    })

    generalWebhook:addButton("Send Test Webhook", v544.SendTestWebhook or function() end)
    local worldFruitEvents = addSection19:addMenu("World & Fruit Events")

    v519:CreateToggle(
      worldFruitEvents, "Send Webhook Prehistoric", "SendWebhookPrehistoric", false,
      { global = true, save = true }
    )

    v519:CreateToggle(worldFruitEvents, "Send Webhook Kitsune", "SendWebhookKitsune", false, {
      global = true,
      save = true,
    })

    v519:CreateToggle(worldFruitEvents, "Send Webhook Mirage", "SendWebhookMirage", false, {
      global = true,
      save = true,
    })

    v519:CreateToggle(
      worldFruitEvents, "Send Webhook Rolled Fruit", "SendWebhookRolledFruit", false,
      { global = true, save = true }
    )

    v519:CreateToggle(
      worldFruitEvents, "Send Webhook Store Fruit", "SendWebhookStoreFruit", false,
      { global = true, save = true }
    )

    local addSection20 = v518.Web:addSection()
    local dataLogFarmTracker = addSection20:addMenu("Data Log & Farm Tracker")

    v519:CreateToggle(
      dataLogFarmTracker, "Enable Data Log Webhook", "SendWebhookDataLog", false,
      { global = true, save = true }
    )

    v519:CreateTextbox(
      dataLogFarmTracker, "DataLog Webhook URL (Optional)", "DataLogWebhookUrl",
      { save = true, global = true }
    )

    v519:CreateSlider(
      dataLogFarmTracker, "Data Log Interval (Minutes)", "DataLogInterval", 1, 60, 5,
      { global = true, save = true }
    )

    v519:CreateToggle(dataLogFarmTracker, "Send on Level Up", "SendWebhookLevelUp", false, {
      global = true,
      save = true,
    })

    v519:CreateToggle(
      dataLogFarmTracker, "Include Inventory in Data Log", "SendWebhookInventory", true,
      { global = true, save = true }
    )

    v519:CreateToggle(
      dataLogFarmTracker, "Include Farms All Summary", "SendWebhookFarmsAll", true,
      { global = true, save = true }
    )

    dataLogFarmTracker:addButton("Send Data Log Now", v544.SendDataLogNow or function() end)
    local webhookPingSettings = addSection20:addMenu("Webhook Ping & Settings")

    v519:CreateTextbox(webhookPingSettings, "Discord User ID (For Ping)", "WebhookPingId", {
      save = true,
      global = true,
    })

    v519:CreateToggle(
      webhookPingSettings, "Ping on Mirage / Kitsune", "WebhookPingOnEvents", false,
      { global = true, save = true }
    )

    v519:CreateToggle(
      webhookPingSettings, "Ping on Mythical Fruit", "WebhookPingOnMythical", false,
      { global = true, save = true }
    )
  end

  function v33.LoadLoops()
    v33.Loops = v33.Loops or {}
    local v670 = {}

    local function f108(p227, p228, p229, p230)
      if not p227 or type(p229) ~= "function" then
        return
      end

      if v670[p227] then
        v670[p227].Active = false

        if v670[p227].Thread then
          task.cancel(v670[p227].Thread)
          v670[p227].Thread = nil
        end
      end

      local v671 = {
        Name = p227,
        Interval = p228 or 0,
        Func = p229,
        NoCheck = p230 or false,
        Running = false,
        Active = true,
        Stop = function()
          if v19 then
            v19[p227] = false
          end

          if v33.Loops[p227] then
            v33.Loops[p227].Running = false
          end
        end,
      }

      v33.Loops[p227] = v671
      v670[p227] = v671

      v671.Thread = spawn(function()
        local v672 = p228 and p228 > 0 and p228 or 0.03

        while v671.Active do
          if v671.NoCheck or v19 and v19[p227] then
            v671.Running = true
            pcall(p229)
            v671.Running = false
            task.wait(v672)
          else
            task.wait(0.5)
          end
        end
      end)
    end

    f108("ESPPlayer", 0.5, PlayerESP)
    f108("ESPIsland", 2, IslandESP)
    f108("DevilFruitESP", 1, FruitESP)
    f108("ESPChest", 1.5, ChestESP)
    f108("ESP_Berries", 1.5, BerryESP)
    f108("ESP_RealFruits", 1.5, RealFruitESP)
    f108("ESPMyBoat", 1.5, MyBoatESP)
    f108("ESPHalloween", 1.5, HalloweenESP)
    f108("ESP_CursedSnowman", 1.5, HalloweenCursedSnowmanESP)
    f108("ESP_Pumpkins", 1.5, HalloweenPumpkinsESP)
    f108("ESP_HalloweenBossesPortal", 1.5, HalloweenBossPortalESP)

    f108("AutoFastMode", 3, function()
      if not v36.FastMode then
        v36.SetFastMode(true)
      end
    end)

    local v673 = nil

    f108("QuantumAttack", 0.5, function()
      if v19.QuantumAttack then
        if not v673 then
          v673 = hookfunction(task.delay, function(p231, p232, ...)
            if p231 > 0.1 then
              return v673(0, p232, ...)
            end

            return v673(p231, p232, ...)
          end)

          require(v5.Util.CameraShaker):Stop()
        end
      elseif v673 then
        hookfunction(task.delay, v673)
        v673 = nil
      end
    end, true)

    tick()
    tick()
    tick()
    tick()
    tick()

    local v674 = false
    local value157 = level and level.Value or 0

    f108("AutoDataLogWebhook", 5, function()
      if level and level.Value then
        if level.Value > value157 then
          local v675 = level.Value - value157
          value157 = level.Value

          if v19.SendWebhookLevelUp and (v19.AutoWebhook or v19.SendWebhookDataLog) then
            v20:SendDataLog("Level Up Detected!", "**New Level Reached:** " .. f7(level.Value) .. " *(+" .. v675
              .. ")*")
          end
        elseif level.Value < value157 then
          value157 = level.Value
        end
      end

      if v19.SendWebhookDataLog
        and (v19.AutoWebhook or v19.DataLogWebhookUrl and v19.DataLogWebhookUrl ~= "") then
        local v676 = tonumber(v19.DataLogInterval)
        local v677 = math.max(60, (v676 or 5) * 60)

        if tick() - v17.LastDataLogTick >= v677 then
          v20:SendDataLog("Quantum Onyx - Periodic Farm Data Log")
        end
      end
    end, true)

    f108("AutoMemoryCleaner", 60, function()
      if v19.AutoCleanMemory ~= false then
        v36.CleanMemory()
      end
    end, true)

    f108("AutoDebrisLagCleaner", 15, function()
      if v19.AutoClearDebris ~= false then
        v36.ClearDebris()
      end

      if v19.AutoAggressiveGC ~= false then
        v36.CleanMemory()
      end
    end, true)

    f108("RemoveObservationEffect", 0.2, function()
      if not v19.RemoveObservationEffect then
        return
      end

      pcall(function()
        if localPlayer:GetAttribute("KenActive") then
          local v678, v679 = v8:GetChildren()

          for key68, value158 in next, v678, v679 do
            if value158:IsA("BlurEffect") and value158.Name == "Blur" then
              value158.Enabled = false
            elseif value158:IsA("ColorCorrectionEffect")
              and value158.Name == "ColorCorrection" then
              value158.Enabled = false
            end
          end

          local currentCamera4 = workspace.CurrentCamera

          if currentCamera4 then
            local v680, v681 = currentCamera4:GetChildren()

            for key69, value159 in next, v680, v681 do
              if value159:IsA("BasePart") and value159.Name:lower():find("ken") then
                value159.Transparency = 1
              end
            end
          end
        end
      end)
    end, true)

    f108("AutoWebhook", 1, function()
      if v19.SendWebhookPrehistoric or v19.SendWebhookKitsune or v19.SendWebhookMirage then
        for key70, value160 in next, {
          ["Prehistoric Island"] = v19.SendWebhookPrehistoric,
          ["Kitsune Island"] = v19.SendWebhookKitsune,
          ["Mirage Island"] = v19.SendWebhookMirage,
        }, nil do
          if value160 then
            local findFirstChild8 = worldOrigin.Locations:FindFirstChild(key70)

            if findFirstChild8 and not v23[key70] then
              v23[key70] = true

              PostWebhook(
                v19.Webhook,
                WeeboLogs(key70, { Position = findFirstChild8:GetPivot().Position })
              )
            elseif not findFirstChild8 then
              v23[key70] = false
            end
          end
        end
      end

      if not v674 then
        v674 = true

        commE.OnClientEvent:Connect(function(p233, p234, p235)
          if p233 == "ItemChanged" and p235 == "stored" and p234 and p234.Name then
            if v19.SendWebhookStoreFruit then
              local v682 = {}

              for key71, value161 in pairs((commF:InvokeServer("getInventory"))) do
                if value161.Type == "Blox Fruit" then
                  table.insert(v682, value161.Name)
                end
              end

              PostWebhook(v19.Webhook, WeeboLogs("Stored Fruit", {
                Extra = "**Fruit:** " .. p234.Name,
                Field2 = {
                  name = "Inventory",
                  value = #v682 > 0 and table.concat(v682, ", ") or "Empty",
                },
              }))
            end
          end
        end)

        replicatedStorage.Modules.Net["RE/SpinGacha"].OnClientEvent:Connect(function(p236)
          if p236 and p236.Winners and p236.Winners[1] then
            if v19.SendWebhookRolledFruit then
              local v683 = p236.Winners[1]

              if v683.ItemType == "Fruit" and v683.DisplayName then
                PostWebhook(v19.Webhook, WeeboLogs("Rolled Fruit", {
                  Extra = "**Fruit:** " .. v683.DisplayName,
                }))
              end
            end
          end
        end)
      end
    end)

    local v684 = 0

    f108("AutoServerRefresh", 3, function()
      if tick() - v684 < 3 then
        return
      end

      v684 = tick()

      if v33._ServerInfo and type(v33._ServerInfo.RefreshDesc) == "function"
        and type(v33._StatusServer) == "function" then
        pcall(function()
          local v685 = v33._StatusServer()

          if v685 then
            v33._ServerInfo:RefreshDesc(v685)
          end
        end)
      end
    end, true)

    f108("TradeAzureEmber", 0.5, function()
      if utilities:CheckInventory("Material", "Azure Ember") >= v19.SetAzureEmber then
        net:FindFirstChild("RF/KitsuneStatuePray"):InvokeServer()
        commF:InvokeServer("KitsuneStatuePray")
      end
    end)

    f108("AutoGetAnglerQuest", 2, function()
      local rfJobsRemoteFunction = net:FindFirstChild("RF/JobsRemoteFunction")

      if rfJobsRemoteFunction then
        pcall(function()
          rfJobsRemoteFunction:InvokeServer("FishingNPC", "Angler", "CheckQuest")

          local invokeServer3 = rfJobsRemoteFunction:InvokeServer(
            "FishingNPC", "Angler", "Speak"
          )

          if invokeServer3 and (invokeServer3.canAccept or not invokeServer3.IsInQuest) then
            rfJobsRemoteFunction:InvokeServer("FishingNPC", "Angler", "AskQuest")
          end
        end)
      end
    end)

    f108("AutoUseRodSkill", 0.5, function()
      net:WaitForChild("RF/JobToolAbilities"):InvokeServer("Z", true)
    end)

    f108("FruitCheck", 1, function()
      local v686, v687 = v4:GetChildren()

      for key72, value162 in next, v686, v687 do
        if value162:IsA("Model") and string.find(value162.Name, "Fruit")
          and not string.find(value162.Name, "Fruit1") then
          local name14 = value162.Name

          if name14 == "Fruit" then
            name14 = "Spawned Unknown Fruit"
          end

          v33:SendNotify("Blox Fruit Spawned", "" .. name14 .. " has spawned in the map!", 15)
        end
      end
    end)

    f108("AutoAwaken", 0.5, function()
      commF:InvokeServer("Awakener", "Check")
      commF:InvokeServer("Awakener", "Awaken")
    end)

    local v688 = 0

    f108("AutoBuyFruitDealer", 5, function()
      if not v19.AutoBuyFruitDealer or not v19.SelectFruitDealerFruit then
        return
      elseif tick() - v688 < 10 then
        return
      else
        local selectFruitDealerFruit2 = v19.SelectFruitDealerFruit

        if not selectFruitDealerFruit2 or selectFruitDealerFruit2 == "" then
          return
        else
          local v689, v690 = pcall(function() return commF:InvokeServer("GetFruits") end)

          if v689 and typeof(v690) == "table" then
            for key73, value163 in next, v690, nil do
              local v691 = value163

              if v691
                and (v691.Name == selectFruitDealerFruit2
                  or v691.Name:match("^(.-)%-") == selectFruitDealerFruit2:match("^(.-)%-")) then
                if v691.OnSale == true then
                  local value164 = beli and beli.Value or 0
                  local v692 = tonumber(v691.Price) or 0

                  if value164 >= v692 then
                    v688 = tick()

                    if pcall(function()
                      return commF:InvokeServer("PurchaseRawFruit", v691.Name, false)
                    end) then
                      v33:SendNotify(
                        "Fruit Dealer",
                        "Auto-bought " .. v691.Name .. " for $" .. f7(v692) .. "!", 6
                      )

                      if v19.SendWebhookStoreFruit or v19.AutoWebhook then
                        local dataLogWebhookUrl2 = v19.DataLogWebhookUrl
                            and v19.DataLogWebhookUrl ~= "" and v19.DataLogWebhookUrl
                          or v19.Webhook

                        if dataLogWebhookUrl2 and dataLogWebhookUrl2 ~= "" then
                          PostWebhook(dataLogWebhookUrl2, WeeboLogs("Fruit Dealer Purchase", {
                            Extra = "**Auto Purchased Fruit:** " .. v691.Name .. " ($"
                              .. f7(v692) .. ")",
                            Field2 = {
                              name = "Beli Remaining",
                              value = "$" .. f7((beli and beli.Value or 0) - v692),
                            },
                          }))
                        end
                      end
                    end
                  end
                end

                break
              end
            end
          end

          return
        end
      end
    end, true)

    local v693 = 0

    f108("AutoCraftScrolls", 5, function()
      local v694, v695

      if not v19.AutoCraftScrolls then
        return
      elseif tick() - v693 < 5 then
        return
      else
        v693 = tick()

        v694 = ({
          ["Common Scroll"] = "CommonScroll",
          ["Rare Scroll"] = "RareScroll",
          ["Legendary Scroll"] = "LegendaryScroll",
          ["Mythical Scroll"] = "MythicalScroll",
        })[v19.SelectScrollType or "Common Scroll"] or "CommonScroll"

        v695 = tonumber(v19.ScrollCraftAmount) or 1
        pcall(function() v29:RemoteFunction("Craft"):InvokeServer(v694, v695) end)
        return
      end
    end, true)

    f108("AutoActivateObservationHaki", 0.5, function()
      remotes.CommE:FireServer("Ken", true)
    end)

    f108("AutoSellFish", 0.5, function()
      net:WaitForChild("RF/JobsRemoteFunction"):InvokeServer("FishingNPC", "SellFish")
    end)

    f108("AutoAgility", 0.5, function() v5.Remotes.CommE:FireServer("ActivateAbility") end)

    f108("AutoActiveRaceV4", 0.5, function()
      if localPlayer.Character and localPlayer.Character:FindFirstChild("RaceEnergy")
        and localPlayer.Character:FindFirstChild("RaceTransformed") then
        if localPlayer.Character.RaceEnergy.Value >= 1
          and not localPlayer.Character.RaceTransformed.Value then
          localPlayer.Backpack.Awakening.RemoteFunction:InvokeServer({ [1] = true })
        end
      end
    end)

    f108("AutoLookMoon", 0.2, function()
      v4.CurrentCamera.CFrame = CFrame.lookAt(v4.CurrentCamera.CFrame.p, v4.CurrentCamera.CFrame.p
        + v8:GetMoonDirection() * 100)
    end)

    f108("ManualIncreaseBoatSpeed", 0.2, function()
      if localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid")
        and localPlayer.Character.Humanoid.Sit then
        local seatPart = localPlayer.Character.Humanoid.SeatPart

        if seatPart and seatPart:IsA("VehicleSeat") then
          seatPart.MaxSpeed = tonumber(v19.ManualBoatSpeed) or 150
          seatPart.Torque = 0.2
          seatPart.TurnSpeed = 5
        else
          local v696, v697 = boats:GetChildren()

          for key74, value165 in next, v696, v697 do
            local vehicleSeat2 = value165:FindFirstChildWhichIsA("VehicleSeat")

            local vehicleSeat3 = vehicleSeat2
            vehicleSeat3 = vehicleSeat2 or value165:FindFirstChild("VehicleSeat")

            if vehicleSeat3 then
              vehicleSeat3.MaxSpeed = tonumber(v19.ManualBoatSpeed) or 150
              vehicleSeat3.Torque = 0.2
              vehicleSeat3.TurnSpeed = 5
            end
          end
        end
      end
    end)

    f108("BuyGear", 0.5, function() commF:InvokeServer("UpgradeRace", "Buy") end)

    f108("AutoBuyEnchancementColor", 0.5, function()
      commF:InvokeServer("ColorsDealer", "1")
      commF:InvokeServer("ColorsDealer", "2")
    end)

    f108("BuyTTK", 0.5, function() commF:InvokeServer("MysteriousMan", "2") end)

    f108("BuyLegendSword", 0.5, function()
      commF:InvokeServer("LegendarySwordDealer", "1")
      commF:InvokeServer("LegendarySwordDealer", "2")
    end)

    f108("Random_Auto", 2, function()
      local gachaNetworkRF2 = v29:RemoteFunction("GachaNetworkRF")

      local invokeServer4 = gachaNetworkRF2:InvokeServer({
        Context = "Check",
        BoxName = "ZiolesGacha",
      })

      if invokeServer4 and invokeServer4.RequirementsMet then
        gachaNetworkRF2:InvokeServer({ Context = "Purchase", BoxName = "ZiolesGacha" })

        if v33 and v33.SendNotify then
          v33:SendNotify("Random Fruit", "Successfully purchased!", 5)
        end

        task.wait(0.5)
        pcall(function() require(v5.Controllers.UI.Spinner).Close() end)
      end
    end)

    local v698 = {}

    f108("AutoStoreFruit", 1, function()
      local characters2 = v4.Characters

      for index79, value166 in ipairs({
        localPlayer.Backpack, localPlayer.Character,
        characters2:FindFirstChild(localPlayer.Name),
      }) do
        if value166 then
          for index80, value167 in ipairs(value166:GetChildren()) do
            if value167:IsA("Tool") and string.find(value167.Name, "Fruit") then
              local originalName = value167:GetAttribute("OriginalName")

              local match7 = originalName
              match7 = originalName or value167.Name:match("^(.-)%-") or value167.Name

              if tick() - (v698[match7] or 0) > 45 then
                local invokeServer5 = commF:InvokeServer("StoreFruit", match7, value167)
                task.wait(0.3)

                if not value167:IsDescendantOf(game) or value167.Parent == nil
                  or invokeServer5 == true then
                  v698[match7] = nil

                  if v19.SendWebhookStoreFruit then
                    local webhook = v19.Webhook

                    if webhook and webhook ~= "" then
                      local v699 = {}

                      pcall(function()
                        local invokeServer6 = v29:RemoteFunction("GetAllItemValues"):InvokeServer()

                        if invokeServer6 and typeof(invokeServer6) == "table" then
                          for key75, value168 in next, invokeServer6, nil do
                            local v700 = value168

                            if v700.Key == "IsOwned" and v700.Value == true then
                              local v701, v702 = pcall(function()
                                return v30.match(v700.ItemId)
                              end)

                              if v701 and v702 and v702.isOk and v702:isOk() then
                                local unwrap3 = v702:unwrap()

                                if unwrap3 and unwrap3.Index and unwrap3.Index.DebugLabel then
                                  local v703 = tostring(unwrap3.Index.DebugLabel)

                                  if v703:find("PhysicalMoveset") or v703:find("Fruit") then
                                    local s3 = v703:match("^(.-)%s*%[") or v703
                                    local match8 = s3:match("^(.-)%-") or s3
                                    table.insert(v699, match8)
                                  end
                                end
                              end
                            end
                          end
                        end
                      end)

                      PostWebhook(webhook, WeeboLogs("Stored Fruit", {
                        Extra = "**Stored Fruit:** " .. match7,
                        Field2 = {
                          name = "Storage Count",
                          value = tostring(#v699) .. " Fruits Stored",
                        },
                      }))
                    end
                  end
                else
                  v698[match7] = tick()
                end
              end
            end
          end
        end
      end
    end)

    f108("Auto_Random_Surprise", 2, function()
      if utilities:CheckInventory("Material", "Bones") >= 50 then
        commF:InvokeServer("Bones", "Buy", 1, 1)
        task.wait(1.5)
      end
    end)

    f108("AutoRollSpookyGacha", 2, function()
      local v704 = false

      pcall(function()
        local gachaNetworkRF3 = v29 and v29:RemoteFunction("GachaNetworkRF")

        if gachaNetworkRF3 then
          for index81, value169 in ipairs({
            "Halloween26Gacha", "HalloweenGacha26", "HalloweenGacha25",
          }) do
            local invokeServer7 = gachaNetworkRF3:InvokeServer({
              Context = "Check",
              BoxName = value169,
            })

            if invokeServer7 and invokeServer7.RequirementsMet then
              gachaNetworkRF3:InvokeServer({ Context = "Purchase", BoxName = value169 })
              v704 = true

              if v33 and v33.SendNotify then
                v33:SendNotify("Spooky Gacha", "Rolled Spooky Gacha (" .. value169 .. ")!", 5)
              end

              task.wait(0.5)
              pcall(function() require(v5.Controllers.UI.Spinner).Close() end)
              break
            end
          end
        end
      end)

      if not v704 then
        pcall(function()
          for index82, value170 in ipairs({ "HalloweenGacha26", "HalloweenGacha25" }) do
            if commF:InvokeServer("Cousin", value170) ~= nil then
              pcall(function() require(v5.Controllers.UI.Spinner).Close() end)
              break
            end
          end
        end)
      end
    end)

    f108("AutoPray", 1, function() commF:InvokeServer("gravestoneEvent", 1) end)
    f108("AutoTryLuck", 1, function() commF:InvokeServer("gravestoneEvent", 2) end)

    f108("AutoAttack", 0, function()
      if v19.AutoAttack ~= false and fastAttack and fastAttack.Attack then
        fastAttack.Attack()
      end
    end, true)

    f108("NoFog", 2.5, function()
      if v19.NoFog then
        v8.FogEnd = math.huge

        if v8:FindFirstChild("FantasySky") then
          v8.FantasySky:Destroy()
        elseif v8:FindFirstChild("Sky") then
          v8.Sky:Destroy()
        elseif v8:FindFirstChild("SeaTerrorCC") then
          v8.SeaTerrorCC:Destroy()
        end

        local lightingLayers = v8:FindFirstChild("LightingLayers")

        if lightingLayers then
          for index83, value171 in ipairs(lightingLayers:GetChildren()) do
            if value171:IsA("Atmosphere") or value171:IsA("Sky") then
              value171:Destroy()
            end
          end
        end
      end
    end)

    f108("AutoCardsDungeon", 0.3, function()
      local cardsSelection = v19.CardsSelection

      if not cardsSelection then
        return
      end

      if type(cardsSelection) == "string" then
        cardsSelection = { cardsSelection }
      end

      if #cardsSelection == 0 then
        return
      end

      for index84, value172 in ipairs(localPlayer.PlayerGui:GetDescendants()) do
        if value172:IsA("TextLabel") and value172.Name == "DisplayName" and value172.Text then
          local text = value172.Text
          local v705 = string.lower(text:gsub("<[^>]+>", ""))

          for index85, value173 in ipairs(cardsSelection) do
            if string.find(v705, string.lower(value173)) then
              local parent4 = value172.Parent

              if parent4 and parent4.Activated then
                firesignal(parent4.Activated)
                return true
              end
            end
          end
        end
      end
    end)
  end

  function v33.LoadFunctions()
    v33.Functions = v33.Functions or {}
    v33.FunctionList = v33.FunctionList or {}
    v33.ActiveFunction = v33.ActiveFunction or nil

    local functions = v33.Functions
    local functionList = v33.FunctionList
    local v706 = {}

    local v707 = {
      "AutoFactoryRaid", "AutoFarmPirateRaid", "AutoSoulReaper", "AutoTaskEliteHunter",
      "AutoTrickOrTreat", "AutoCollectPumpkin", "Tweenfruit", "AutoBerrySafe",
    }

    function v33.IsMultiFunction(p237)
      for index86, value174 in ipairs(v707) do
        if value174 == p237 then
          return true
        end
      end

      return false
    end

    local v708

    local function f109()
      if v19.AutoFarmPirateRaid and v26 then
        if gameData:DetectPirateRaid() then
          v708 = tick()
          v33.ActiveFunction = "AutoFarmPirateRaid"
          return true
        end

        if v708 and tick() - v708 < 8 then
          v33.ActiveFunction = "AutoFarmPirateRaid"
          return true
        end
      end

      if v19.AutoFactoryRaid and utilities:CheckMon("Core") and v25 then
        v33.ActiveFunction = "AutoFactoryRaid"
        return true
      end

      if v19.AutoSoulReaper and v26 then
        if utilities:CheckMon("Soul Reaper") or utilities:CheckToolName("Hallow Essence") then
          v33.ActiveFunction = "AutoSoulReaper"
          return true
        end
      end

      if v19.AutoTaskEliteHunter and v26 then
        if gameData:Checkelites() then
          v33.ActiveFunction = "AutoTaskEliteHunter"
          return true
        end
      end

      if v19.AutoTrickOrTreat and v33:IsHalloweenEventRunning() then
        local dapperJackGateway3 = workspace:FindFirstChild("DapperJackGateway")
          or workspace.GetAttribute and workspace:GetAttribute("DapperJackActive") == true

        local ghostChase2 = workspace:FindFirstChild("GhostChase")
        local v709 = nil
        local enemies5 = workspace:FindFirstChild("Enemies")

        if enemies5 then
          for index87, value175 in ipairs(enemies5:GetChildren()) do
            if (value175.Name == "Hellfire Gas" or value175.Name == "Unbound Werewolf"
                or value175.Name == "Jack o' Lantern" or value175.Name == "Dapper Jack")
              and value175:FindFirstChild("Humanoid")
              and value175.Humanoid.Health > 0 then
              v709 = value175
              break
            end
          end
        end

        if dapperJackGateway3 or ghostChase2 or v709
          or #(v33.GetHalloweenDoors and v33:GetHalloweenDoors() or {}) > 0 then
          v33.ActiveFunction = "AutoTrickOrTreat"
          return true
        end
      end

      if v19.Tweenfruit then
        if gameData:GetPathFruit() or v19.HopIfNoFruit then
          v33.ActiveFunction = "Tweenfruit"
          return true
        end
      end

      if v19.AutoCollectPumpkin then
        local jackOLantern = utilities:GetEnemies("Jack o' Lantern")
          or utilities:GetEnemies("Pumpkin Snowman")

        local getPumpkins = v33.GetPumpkins and v33:GetPumpkins() or {}
        local autoFarm = v19.AutoFarm or v19.AutoFarmLevel

        if jackOLantern or #getPumpkins > 0 or not autoFarm then
          if jackOLantern or #getPumpkins > 0 then
            v33.ActiveFunction = "AutoCollectPumpkin"
            return true
          end
        end
      end

      if v19.AutoBerrySafe then
        if gameData:CheckBerries() or v19.HopIfNoBerries then
          v33.ActiveFunction = "AutoBerrySafe"
          return true
        end

        v33.ActiveFunction = nil
        return false
      end

      v33.ActiveFunction = nil
      return false
    end

    local function f110(p238, p239, p240, p241)
      if not p238 or type(p239) ~= "function" or not p240 then
        return
      else
        if v706[p238] then
          if functions[p238] then
            functions[p238]._StopFlag = true
          end

          task.cancel(v706[p238])
          v706[p238] = nil
        end

        functions[p238] = {
          Enable = p240,
          Running = false,
          Func = p239,
          NoLock = p241 or false,
          _StopFlag = false,
          Stop = function()
            if v19 then
              v19[p238] = false
            end

            functions[p238].Running = false

            if v33.ActiveFunction == p238 then
              v33.ActiveFunction = nil
            end

            tweenManager:StopTween()
          end,
          Call = function()
            local activeFunction2 = v33.ActiveFunction
            v33.ActiveFunction = nil
            pcall(p239)
            v33.ActiveFunction = activeFunction2
          end,
        }

        local v710 = false

        for index88, value176 in ipairs(functionList) do
          if value176.Name == p238 then
            value176.Func = p239
            v710 = true
            break
          end
        end

        if not v710 then
          table.insert(functionList, { Name = p238, Func = p239 })
        end

        v706[p238] = task.spawn(function()
          local v711 = functions[p238]

          while v711 and not v711._StopFlag do
            if v19 and v19[p238] then
              if v711.NoLock then
                v711.Running = true
                pcall(p239)
                task.wait(0.25)
              elseif v33.IsMultiFunction(p238) then
                if f109() and v33.ActiveFunction == p238 then
                  v711.Running = true
                  pcall(p239)
                  task.wait(0.25)
                else
                  if v711.Running then
                    v711.Running = false
                  end

                  task.wait(0.25)
                end
              elseif f109() then
                if v711.Running then
                  v711.Running = false
                end

                task.wait(0.25)
              elseif v33.ActiveFunction == nil or v33.ActiveFunction == p238 then
                v33.ActiveFunction = p238
                v711.Running = true
                pcall(p239)
                task.wait(0.25)
                v33.ActiveFunction = nil
              else
                if v711.Running then
                  v711.Running = false
                end

                task.wait(0.25)
              end
            else
              if v33.ActiveFunction == p238 then
                v33.ActiveFunction = nil
              end

              if v711.Running then
                v711.Running = false
              end

              task.wait(0.5)
            end
          end

          if v33.ActiveFunction == p238 then
            v33.ActiveFunction = nil
          end
        end)

        if v19 and v19[p238] then
          functions[p238].Running = true
        end

        return
      end
    end

    f110("AutoTaskEliteHunter", function()
      local checkelites2 = gameData:Checkelites()

      if checkelites2 then
        if not VerifyQuest(checkelites2) then
          commF:InvokeServer("AbandonQuest")
          task.wait(0.1)
          commF:InvokeServer("EliteHunter")
          return
        else
          local getEnemies2 = utilities:GetEnemies(checkelites2)

          if getEnemies2 then
            return subFunction:Attack(getEnemies2)
          end

          return
        end
      else
        return
      end
    end, v26)

    f110("AutoFarmBones", function()
      if v19.AcceptQuests and not VerifyQuest("Demonic Soul") then
        return utilities:StartQuest("HauntedQuest2", 1, CFrame.new(-9517, 172, 6078))
      else
        local getEnemies3 = utilities:GetEnemies(v33.DataList.BonesList)

        if getEnemies3 then
          return subFunction:Attack(getEnemies3, true)
        end

        utilities:MobsNextSpawn("Reborn Skeleton")
        return
      end
    end, v26)

    f110("AutoFarmBoss", function()
      local v712 = CheckBoss(v19.SelectBoss)

      if not v712 then
        return task.wait(1)
      end

      v19.SelectBoss = v712[2]

      if v19.GetBossQuest and not VerifyQuest(v712[2]) and utilities:CheckMon(v712[2])
        and level.Value >= (v712[1] or 0) then
        return utilities:StartQuest(v712[3], v712[4], v712[5])
      else
        local getEnemies4 = utilities:GetEnemies(v712[2])

        if getEnemies4 then
          subFunction:Attack(getEnemies4)
        else
          utilities:MobsNextSpawn(v712[2])
        end

        return
      end
    end, true)

    f110("AutoKillAllBosses", function()
      local sea32 = v26 and bossList.Sea_3 or v25 and bossList.Sea_2 or v24 and bossList.Sea_1

      if not sea32 or #sea32 == 0 then
        return task.wait(1)
      end

      for key76, value177 in next, sea32, nil do
        local v713 = value177[2]

        if level.Value >= (value177[1] or 0) and utilities:CheckMon(v713) then
          local getEnemies5 = utilities:GetEnemies(v713)

          if getEnemies5 and v33:IsReady(getEnemies5) then
            if v19.GetBossQuest and not VerifyQuest(v713) then
              if localPlayer.PlayerGui.Main:FindFirstChild("Quest")
                and localPlayer.PlayerGui.Main.Quest.Visible then
                pcall(function() commF:InvokeServer("AbandonQuest") end)
                task.wait(0.2)
              end

              return utilities:StartQuest(value177[3], value177[4], value177[5])
            end

            return subFunction:Attack(getEnemies5)
          end
        end
      end

      for key77, value178 in next, sea32, nil do
        local v714 = value178[2]

        if level.Value >= (value178[1] or 0) then
          if value178[5] then
            return utilities:MobsNextSpawn(v714)
          end
        end
      end
    end, true)

    f110("TeleportToIsland", function()
      for key78, value179 in next, v33._ActiveIslands, nil do
        if key78 == v19.TeleportIslandSelect then
          if (character.HumanoidRootPart.Position
              - Vector3.new(value179.X, value179.Y, value179.Z)).Magnitude
            <= 10 then
            v33._TravelToggle.Update(false)
          else
            tweenManager:topos(value179)
          end
        end
      end
    end, true)

    f110("TPtoNPC", function()
      local v715 = DetectNpc(v19.NpcTween)

      if v715 then
        tweenManager:topos(v715:GetPivot())
      end
    end, true)

    f110("TeleporttoPlayer", function()
      local getNearestPlayer3 = (v19.SelectPlayer == "Nearest" or not v19.SelectPlayer)
          and gameData:GetNearestPlayer()
        or v3:FindFirstChild(v19.SelectPlayer)

      if getNearestPlayer3 and getNearestPlayer3 ~= localPlayer and getNearestPlayer3.Character then
        local humanoidRootPart42 = getNearestPlayer3.Character:FindFirstChild("HumanoidRootPart")
          or getNearestPlayer3.Character.PrimaryPart

        local humanoid25 = getNearestPlayer3.Character:FindFirstChildOfClass("Humanoid")

        if humanoidRootPart42 and humanoid25 and humanoid25.Health > 0 then
          tweenManager:topos(humanoidRootPart42.CFrame)
        end
      end
    end, true)

    f110("AutoFarm", function()
      local v716 = CheckQuest()

      if not v716 or not v716[1] or v716[1] == "" then
        return
      else
        local v717 = v716[1]
        local v718 = v716[2]
        local getEnemies6 = utilities:GetEnemies(v717)
        local getNearest = gameData:GetNearest()
        local farmMode = v19.FarmMode or "Quest"

        if v26 and v718 and v718:lower():find("submerged") and farmMode ~= "Nearest" then
          if (localPlayer.Character.HumanoidRootPart.Position.Y or 0) > -500 then
            if localPlayer:DistanceFromCharacter(Vector3.new(-16269.1016, 29.5177539, 1372.3204))
              > 15 then
              tweenManager:topos(CFrame.new(-16269.1016, 29.5177539, 1372.3204))
              task.wait(0.5)

              for i32 = 1, 2 do
                net:WaitForChild("RF/SubmarineWorkerSpeak"):InvokeServer("TravelToSubmergedIsland")
              end

              return
            end
          end
        end

        if farmMode == "Quest" then
          if not VerifyQuest(v717) then
            return GetQuest()
          elseif getEnemies6 then
            return subFunction:Attack(getEnemies6, true)
          else
            return utilities:MobsNextSpawn(v717)
          end
        elseif farmMode == "No Quest" then
          if getEnemies6 then
            return subFunction:Attack(getEnemies6, true)
          end

          return utilities:MobsNextSpawn(v717)
        elseif farmMode == "Nearest" then
          if getNearest then
            return subFunction:Attack(getNearest, true)
          end

          return
        else
          return
        end
      end
    end, true)

    local v719 = 0
    local v720 = ""

    f110("AutoFarmPrince", function()
      if not v19.IgnoreCakePrince and utilities:CheckMon("Cake Prince") then
        local cakePrince = utilities:GetEnemies("Cake Prince")

        if cakePrince then
          if localPlayer:GetAttribute("CurrentLocation") ~= "Dimensional Shift" then
            tweenManager:topos(CFrame.new(-2168, 84, -12397))
            task.wait(1)
            return
          end

          return subFunction:Attack(cakePrince)
        end
      end

      local v721 = tick()

      if v721 - v719 > 4 then
        v719 = v721
        local v722, v723 = pcall(function() return commF:InvokeServer("CakePrinceSpawner") end)

        if v722 and type(v723) == "string" then
          v720 = v723
        end
      end

      if string.find(v720, "open the portal now") then
        commF:InvokeServer("CakePrinceSpawner")
        task.wait(1)
        return
      end

      if v19.AcceptQuests and not VerifyQuest("Cookie Crafter") then
        return utilities:StartQuest("CakeQuest1", 1, CFrame.new(-2021, 38, -12029))
      else
        local getEnemies7 = utilities:GetEnemies(v33.DataList.CakesList)

        if getEnemies7 then
          return subFunction:Attack(getEnemies7, true)
        end

        tweenManager:topos(CFrame.new(-2304, 228, -12240))
        return
      end
    end, v26)

    f110("AutoTeleportMirage", function()
      if v19.AutoTeleportMirage then
        for key79, value180 in pairs(v4._WorldOrigin.Locations:GetChildren()) do
          if value180.Name == "Mirage Island" then
            tweenManager:topos(value180.CFrame * CFrame.new(0, 333, 0), true)
          end
        end
      end
    end, v26)

    f110("AutoTeleportPrehistoric", function()
      if v19.AutoTeleportPrehistoric then
        for key80, value181 in pairs(v4._WorldOrigin.Locations:GetChildren()) do
          if value181.Name == "Prehistoric Island" then
            tweenManager:topos(value181.CFrame * CFrame.new(0, 333, 0), true)
          end
        end
      end
    end, v26)

    f110("AutoTeleportKitsune", function()
      if v19.AutoTeleportKitsune then
        for key81, value182 in pairs(v4._WorldOrigin.Locations:GetChildren()) do
          if value182.Name == "Kitsune Island" then
            tweenManager:topos(value182.CFrame * CFrame.new(0, 300, 0), true)
          end
        end
      end
    end, v26)

    f110("AutoDoughKing", function()
      if utilities:CheckMon("Dough King") then
        local doughKing = utilities:GetEnemies("Dough King")

        if doughKing then
          if localPlayer:GetAttribute("CurrentLocation") ~= "Dimensional Shift" then
            tweenManager:topos(CFrame.new(-2168, 84, -12397))
            task.wait(1)
            return
          end

          return subFunction:Attack(doughKing)
        end

        return
      elseif not v19.IgnoreDoughChaliceFarm then
        if not utilities:CheckToolName("Sweet Chalice") then
          if commF:InvokeServer("SweetChaliceNpc") == "Where are the items?" then
            if utilities:CheckInventory("Material", "Conjured Cocoa") < 10 then
              local getEnemies8 = utilities:GetEnemies({
                "Chocolate Bar Battler", "Cocoa Warrior",
              })

              if getEnemies8 then
                subFunction:Attack(getEnemies8, true)
              else
                utilities:MobsNextSpawn("Chocolate Bar Battler")
              end
            elseif not utilities:CheckToolName("God's Chalice") then
              local checkelites3 = gameData:Checkelites()

              if checkelites3 then
                if not VerifyQuest(checkelites3) then
                  commF:InvokeServer("AbandonQuest")
                  task.wait(0.1)
                  commF:InvokeServer("EliteHunter")
                else
                  local getEnemies9 = utilities:GetEnemies(checkelites3)

                  if getEnemies9 then
                    subFunction:Attack(getEnemies9)
                  end
                end
              else
                functions.AutoChest.Call()
              end
            end
          end

          return
        else
          local v724 = tick()

          if v724 - v719 > 4 then
            v719 = v724

            local v725, v726 = pcall(function()
              return commF:InvokeServer("CakePrinceSpawner")
            end)

            if v725 and type(v726) == "string" then
              v720 = v726
            end
          end

          if string.find(v720, "open the portal now") then
            commF:InvokeServer("CakePrinceSpawner")
            task.wait(1)
            return
          else
            local getEnemies10 = utilities:GetEnemies(v33.DataList.CakesList)

            if getEnemies10 then
              return subFunction:Attack(getEnemies10, true)
            end

            utilities:MobsNextSpawn("Head Baker")
            return
          end
        end
      else
        return
      end
    end, v26)

    f110("AutoTyrantOfTheSkies", function()
      local tyrantOfTheSkies = utilities:GetEnemies("Tyrant of the Skies")
      local getEnemies11 = utilities:GetEnemies(v33.DataList.TyrantList)

      if utilities:CheckMon("Tyrant of the Skies") then
        return subFunction:Attack(tyrantOfTheSkies)
      elseif gameData:TyrantEyes() >= 4 then
        subFunction:AttackTree()
        return
      elseif getEnemies11 then
        return subFunction:Attack(getEnemies11, true)
      else
        tweenManager:topos(CFrame.new(-16257, 22, 1062))
        return
      end
    end, v26)

    f110("AutoMaterial", function()
      local selectMaterial = v19.SelectMaterial
      local v727

      if v24 then
        v727 = materialEnemies.Sea_1[selectMaterial]
      elseif v25 then
        v727 = materialEnemies.Sea_2[selectMaterial]
      elseif v26 then
        v727 = materialEnemies.Sea_3[selectMaterial]
      end

      if v727 and #v727 > 0 then
        local getEnemies12 = utilities:GetEnemies(v727)

        if getEnemies12 then
          return subFunction:Attack(getEnemies12, true)
        end

        return utilities:MobsNextSpawn(v727[1])
      end
    end, true)

    f110("AutoSecondSea", function()
      if not (v24 and level.Value >= 700) then
        return nil
      elseif commF:InvokeServer("DressrosaQuestProgress").KilledIceBoss then
        commF:InvokeServer("TravelDressrosa")
        return
      elseif map.Ice.Door.CanCollide then
        if not utilities:CheckToolName("Key") then
          if localPlayer:DistanceFromCharacter(Vector3.new(4852, 6, 719)) < 5 then
            commF:InvokeServer("DressrosaQuestProgress", "Detective")
          else
            tweenManager:topos(CFrame.new(4852, 6, 719))
          end
        else
          utilities:EquipTool("Key")

          if utilities:CheckToolName("Key") then
            tweenManager:topos(map.Ice.Door.CFrame)
          end
        end

        return
      else
        local iceAdmiral = utilities:GetEnemies("Ice Admiral")

        if iceAdmiral then
          return subFunction:Attack(iceAdmiral)
        end

        return
      end
    end, v24)

    local cframe12 = CFrame.new(-339.798, 331.861, 643.832)

    f110("AutoThirdSea", function()
      if level.Value >= 1500 then
        if commF:InvokeServer("BartiloQuestProgress", "Bartilo") == 3 then
          local v728 = commF:InvokeServer("TalkTrevor", "1") ~= 0
          local getUnlockables3 = commF:InvokeServer("GetUnlockables")

          if v728 and (getUnlockables3 == nil or getUnlockables3.FlamingoAccess == nil) then
            local v729, v730 = utilities:Checkfruit(true)
            local v731 = v730

            if not v729 then
              local getLowestFruit = utilities:GetLowestFruit(true)

              if getLowestFruit then
                commF:InvokeServer(
                  "LoadFruit", getLowestFruit.StorageKey or getLowestFruit.Name
                )

                task.wait(0.5)

                local v732
                v732, v731 = utilities:Checkfruit(true)
              else
                v33:SendNotify(
                  "Auto Third Sea", "Need a 1M+ fruit in storage or inventory for Trevor!", 5
                )

                return
              end
            end

            local character31 = localPlayer.Character

            local humanoidRootPart43 = character31

            humanoidRootPart43 = character31
              and localPlayer.Character:FindFirstChild("HumanoidRootPart")

            if not humanoidRootPart43 then
              return
            else
              local trevor = DetectNpc("Trevor")
                or v4:FindFirstChild("NPCs") and v4.NPCs:FindFirstChild("Trevor")

              local humanoidRootPart44 = trevor

              humanoidRootPart44 = trevor
                and (trevor:FindFirstChild("HumanoidRootPart") or trevor.PrimaryPart)

              local cframe13 = humanoidRootPart44 and humanoidRootPart44.CFrame or cframe12

              if (humanoidRootPart43.Position - cframe13.Position).Magnitude > 8 then
                tweenManager:topos(cframe13)
                return
              end

              if v731 and v731.Parent == localPlayer.Backpack and localPlayer.Character
                and localPlayer.Character:FindFirstChildOfClass("Humanoid") then
                localPlayer.Character.Humanoid:EquipTool(v731)
                task.wait(0.3)
              end

              if commF:InvokeServer("TalkTrevor", "1") ~= 1 then
                commF:InvokeServer("TalkTrevor", "1")
                task.wait(0.2)
                commF:InvokeServer("TalkTrevor", "2")
                task.wait(0.2)
                commF:InvokeServer("TalkTrevor", "3")
              end

              return
            end
          elseif not commF:InvokeServer("ZQuestProgress", "Check") then
            if utilities:CheckMon("Don Swan") then
              local donSwan = utilities:GetEnemies("Don Swan")

              if donSwan then
                return subFunction:Attack(donSwan)
              end

              utilities:MobsNextSpawn("Don Swan")
              return
            end

            return
          elseif commF:InvokeServer("ZQuestProgress", "Check") == 0 then
            local part2 = v4:FindFirstChild("Map") and v4.Map:FindFirstChild("IndraIsland")
              and v4.Map.IndraIsland:FindFirstChild("Part")

            local position46 = part2 and part2.Position

            local vector9 = position46
            vector9 = position46 or Vector3.new(-1926.788, 12.168, 1739.809)

            local character32 = localPlayer.Character

            local humanoidRootPart45 = character32

            humanoidRootPart45 = character32
              and localPlayer.Character:FindFirstChild("HumanoidRootPart")

            if humanoidRootPart45 and (humanoidRootPart45.Position - vector9).Magnitude > 1000 then
              local cframe14 = CFrame.new(
                -1926.78772, 12.1678171, 1739.80884, 0.956294656, 0, -0.292404652, 0, 1, 0,
                0.292404652, 0, 0.956294656
              )

              tweenManager:topos(cframe14)

              if (humanoidRootPart45.Position - cframe14.Position).Magnitude <= 8 then
                commF:InvokeServer("ZQuestProgress", "Begin")
              end

              return
            else
              local ripIndra = utilities:GetEnemies("rip_indra")

              if ripIndra then
                return subFunction:Attack(ripIndra)
              end

              return
            end
          elseif commF:InvokeServer("TalkTrevor", "1") == 0
            and commF:InvokeServer("ZQuestProgress", "Check") == 1
            and commF:InvokeServer("ZQuestProgress", "Zou") == 0 then
            commF:InvokeServer("TravelZou")
          end
        else
          return
        end
      else
        return
      end
    end, v25)

    f110("AutoTushita", function()
      if utilities:CheckInventory("Moveset", "Tushita") then
        return
      else
        local tushitaProgress = commF:InvokeServer("TushitaProgress")

        if typeof(tushitaProgress) ~= "table" then
          tushitaProgress = { Torches = { false, false, false, false, false } }
        end

        if tushitaProgress.OpenedDoor then
          local longma = utilities:GetEnemies("Longma")

          if longma then
            return subFunction:Attack(longma)
          end

          tweenManager:topos(CFrame.new(-10237, 339, 8758))
          return
        end

        if utilities:CheckMon("rip_indra True Form") or utilities:CheckToolName("Holy Torch") then
          if not utilities:CheckToolName("Holy Torch") then
            return tweenManager:topos(CFrame.new(5713, 19, 255))
          else
            utilities:EquipTool("Holy Torch")
            local torches = tushitaProgress.Torches or {}

            for i33 = 1, #torches do
              if not torches[i33] then
                commF:InvokeServer("TushitaProgress", "Torch", i33)
              end
            end

            return true
          end
        elseif utilities:CheckToolName("God's Chalice") then
          utilities:EquipTool("God's Chalice")
          return tweenManager:topos(CFrame.new(-5561, 314, -2663))
        else
          local checkelites4 = gameData:Checkelites()

          if checkelites4 then
            if not VerifyQuest(checkelites4) then
              commF:InvokeServer("AbandonQuest")
              task.wait(0.1)
              commF:InvokeServer("EliteHunter")
              return
            else
              local getEnemies13 = utilities:GetEnemies(checkelites4)

              if getEnemies13 then
                return subFunction:Attack(getEnemies13)
              end

              return
            end
          else
            functions.AutoChest.Call()
            return
          end
        end
      end
    end, v26)

    f110("AutoYama", function()
      if utilities:CheckInventory("Moveset", "Yama") then
        return nil
      elseif (tonumber(commF:InvokeServer("EliteHunter", "Progress")) or 0) < 30 then
        local checkelites5 = gameData:Checkelites()

        if checkelites5 then
          if not VerifyQuest(checkelites5) then
            commF:InvokeServer("AbandonQuest")
            task.wait(0.1)
            commF:InvokeServer("EliteHunter")
            return
          else
            local getEnemies14 = utilities:GetEnemies(checkelites5)

            if getEnemies14 then
              return subFunction:Attack(getEnemies14)
            end

            return
          end
        else
          f6("elites", 1)
          return
        end
      else
        local sealedKatana = map:FindFirstChild("Waterfall")
          and map.Waterfall:FindFirstChild("SealedKatana")

        local hitbox = sealedKatana and sealedKatana:FindFirstChild("Hitbox")

        if hitbox then
          if localPlayer:DistanceFromCharacter(hitbox.Position) > 10 then
            tweenManager:topos(hitbox.CFrame * CFrame.new(0, 3, 0))
          else
            local clickDetector = hitbox:FindFirstChildOfClass("ClickDetector")
              or hitbox:FindFirstChildWhichIsA("ClickDetector", true)

            if clickDetector then
              fireclickdetector(clickDetector)
            end
          end
        else
          tweenManager:topos(CFrame.new(5289, 1005, 393))
        end

        return
      end
    end, v26)

    f110("AutoRengoku", function()
      if utilities:CheckMon("Awakened Ice Admiral") then
        local getEnemies15 = utilities:GetEnemies({ "Awakened Ice Admiral" })

        if getEnemies15 then
          return subFunction:Attack(getEnemies15)
        end
      end

      if utilities:CheckToolName("Hidden Key") then
        if localPlayer:DistanceFromCharacter(CFrame.new(6571, 299, -6968).Position) > 2 then
          tweenManager:topos(CFrame.new(6571, 299, -6968))
        else
          utilities:EquipTool("Hidden Key")
        end

        return
      elseif utilities:CheckToolName("Library Key") then
        if localPlayer:DistanceFromCharacter(CFrame.new(6373, 293, -6839).Position) > 2 then
          tweenManager:topos(CFrame.new(6571, 299, -6968))
        else
          utilities:EquipTool("Library Key")
        end

        return
      else
        local getEnemies16 = utilities:GetEnemies({ "Arctic Warrior", "Snow Lurker" })

        if getEnemies16 then
          return subFunction:Attack(getEnemies16, true)
        end

        utilities:MobsNextSpawn("Arctic Warrior")
        return
      end
    end, v25)

    local v733 = 0
    local v734 = 0

    pcall(function()
      local bonusMomentsRemoteEvent = v5.Remotes:FindFirstChild("BonusMomentsRemoteEvent")

      if bonusMomentsRemoteEvent then
        bonusMomentsRemoteEvent.OnClientEvent:Connect(function(p242, p243, ...)
          if p242 == "Prickly Harvest" then
            local v735 = ...

            if p243 == "UpdateProgress" and typeof(v735) == "number" then
              v734 = math.max(v734, v735)
            elseif p243 == "CactusHarvested" then
              v734 = math.min(10, v734 + 1)
            elseif p243 == "ResetCacti" then
              v734 = 0
            end
          end
        end)
      end
    end)

    local function f111(p244)
      local v736 = not p244 or not p244:IsA("BasePart")
      local tool8

      if v736 then
        return
      else
        local character33 = localPlayer.Character

        if not character33 then
          return
        end

        tool8 = character33:FindFirstChildOfClass("Tool")

        if not tool8 then
          if utilities and utilities.EquipWeapon then
            utilities:EquipWeapon()
          end

          tool8 = character33:FindFirstChildOfClass("Tool")
        end

        if tool8 then
          pcall(function() tool8:Activate() end)
        end

        pcall(function()
          local v737 = require(v5.Modules.Net)
          local registerAttack = v737:RemoteEvent("RegisterAttack")

          if registerAttack then
            registerAttack:FireServer(0.3)
          end

          local remoteEvent = v737:RemoteEvent("RegisterHit", true)

          if remoteEvent then
            remoteEvent:FireServer(p244, { { nil, p244 } })
            remoteEvent:FireServer(p244)
          end
        end)

        return
      end
    end

    local data4

    local function f112()
      local v738 = tick()

      if not data4 or v738 - v733 > 2 then
        v733 = v738

        pcall(function()
          local invokeServer8 = require(v5.Modules.Net):RemoteFunction("RequestBonusMomentReplication"):InvokeServer({
            Type = "GetMomentProgress",
          })

          if invokeServer8 and invokeServer8.Data then
            data4 = invokeServer8.Data

            if v33 and v33.UpdateSecretTracker then
              v33.UpdateSecretTracker(data4)
            end
          end
        end)
      end

      return data4 or {}
    end

    local v739 = {
      { Name = "Windmill Maintenance", Address = "Sea1/Pirate Village/Windmill Maintenance" },
      { Name = "Archaeologist's Tablet", Address = "Sea1/Desert/Archaeologist's Tablet" },
      { Name = "Rescue Hasan", Address = "Sea1/Desert/Rescue Hasan" },
      { Name = "Prickly Harvest", Address = "Sea1/Desert/Prickly Harvest" },
      { Name = "Breaking the Ice", Address = "Sea1/Frozen Village/Breaking the Ice" },
      { Name = "Evil Slimes", Address = "Sea1/Magma Village/Evil Slimes" },
      { Name = "Zipline Repair", Address = "Sea1/Jungle/Zipline Repair" },
      { Name = "Don Megalo", Address = "Sea1/Prison/Don Megalo" },
      { Name = "Escape from Alcatraz", Address = "Sea1/Prison/Escape from Alcatraz" },
      { Name = "Fishman Karate", Address = "Sea1/Underwater City/Fishman Karate" },
      { Name = "Fountain Pipe Repair", Address = "Sea1/Fountain/Fountain Pipe Repair" },
      { Name = "King's Apprentice", Address = "Sea1/Colosseum/King's Apprentice" },
    }

    function v33.UpdateSecretTracker(p245)
      local v740 = p245 or f112()
      local v741 = {}
      local count10 = 0

      for index89, value183 in ipairs(v739) do
        if v740[value183.Address] == true then
          count10 = count10 + 1
          table.insert(v741, value183.Name)
        end
      end

      local v742 = math.floor(count10 / #v739 * 100)

      if v33 and v33.SecretTrackerLabel then
        pcall(function()
          v33.SecretTrackerLabel:RefreshTitle(string.format(
            "Secret Quests: %d/%d (%d%%)", count10, #v739, v742
          ))

          if count10 == #v739 then
            v33.SecretTrackerLabel:RefreshDesc("All Completed!")
          else
            v33.SecretTrackerLabel:RefreshDesc(string.format(
              "Completed: %d | Remaining: %d", count10, #v739 - count10
            ))
          end
        end)
      end

      if v33 and v33.SecretTrackerDropdown then
        pcall(function()
          if #v741 == 0 then
            v33.SecretTrackerDropdown:Refresh({ "None Completed Yet" })
          else
            v33.SecretTrackerDropdown:Refresh(v741)
          end
        end)
      end

      return count10, v741
    end

    spawn(function()
      task.wait(3)

      if v33 and v33.UpdateSecretTracker then
        v33.UpdateSecretTracker()
      end
    end)

    f110("AutoCompleteSecretQuests", function()
      local kingSApprentice, bonusMomentsRemoteFunction, cframe15, position47, grapplingHook,
        bonusMomentsRemoteFunction2

      if not v24 then
        return
      else
        local v743 = f112()

        if not v743["Sea1/Pirate Village/Windmill Maintenance"] then
          local humanoidRootPart46 = localPlayer.Character
            and (localPlayer.Character:FindFirstChild("HumanoidRootPart")
              or localPlayer.Character.PrimaryPart)

          if not humanoidRootPart46 then
            return
          end

          local bonusMomentsRemoteEvent2 = v5.Remotes:FindFirstChild("BonusMomentsRemoteEvent")

          if bonusMomentsRemoteEvent2 then
            bonusMomentsRemoteEvent2:FireServer("Windmill Maintenance", "Init")
          end

          local findFirstChild9 = v4.Map:FindFirstChild("Pirate")
            and v4.Map.Pirate:FindFirstChild("WindmillRig", true)

          if findFirstChild9 then
            local findFirstChild10 = findFirstChild9:FindFirstChild("Windmill_rig", true)
              or findFirstChild9

            local v744 = nil
            local huge14 = math.huge

            for index90, value184 in ipairs(findFirstChild10:GetChildren()) do
              if value184:IsA("MeshPart") and value184.Name:find("Rope%d")
                and value184.Transparency < 1 then
                local magnitude18 = (humanoidRootPart46.Position - value184.Position).Magnitude

                if magnitude18 < huge14 then
                  huge14 = magnitude18
                  v744 = value184
                end
              end
            end

            if v744 then
              utilities:EquipWeapon("Sword")
              tweenManager:topos(v744.CFrame * CFrame.new(0, 0, 2), true)
              f111(v744)
            else
              tweenManager:topos(CFrame.new(-1249, 115, 4044), true)
            end
          else
            tweenManager:topos(CFrame.new(-1249, 115, 4044), true)
          end

          return
        elseif not v743["Sea1/Desert/Archaeologist's Tablet"] then
          local findFirstChild11 = v4:FindFirstChild("Archaeologist's Tablet", true)
          local v745 = nil

          if findFirstChild11 then
            local pillars = findFirstChild11:FindFirstChild("Pillars")

            if pillars then
              for index91, value185 in ipairs(pillars:GetChildren()) do
                if value185:IsA("Model") then
                  if (value185:GetAttribute("NumHits") or 0) < 3 then
                    v745 = value185
                    break
                  end
                end
              end
            end
          end

          if v745 then
            local findFirstChild12 = v745:FindFirstChild("SandLayer"
                .. tostring((v745:GetAttribute("NumHits") or 0) + 1))
              or v745:FindFirstChild("SandLayer1")
              or v745:FindFirstChildWhichIsA("BasePart")

            if findFirstChild12 then
              tweenManager:topos(findFirstChild12.CFrame * CFrame.new(0, 2, 3))
              f111(findFirstChild12)
            end
          else
            tweenManager:topos(CFrame.new(1270, 24, 4648))
            local bonusMomentsRemoteFunction3 = v5.Remotes:FindFirstChild("BonusMomentsRemoteFunction")

            if bonusMomentsRemoteFunction3 then
              bonusMomentsRemoteFunction3:InvokeServer("Archaeologist's Tablet", "ClaimReward")
            end

            local bonusMomentsRemoteEvent3 = v5.Remotes:FindFirstChild("BonusMomentsRemoteEvent")

            if bonusMomentsRemoteEvent3 then
              bonusMomentsRemoteEvent3:FireServer("Archaeologist's Tablet", "ClaimReward")
            end

            local commF2 = v5.Remotes:FindFirstChild("CommF_")

            if commF2 then
              commF2:InvokeServer("ClaimReward", "Archaeologist's Tablet")
            end
          end

          return
        elseif not v743["Sea1/Desert/Rescue Hasan"] then
          local disableMovement = localPlayer.Character:FindFirstChild("DisableMovement")

          if disableMovement then
            disableMovement:Destroy()
          end

          local vector10 = Vector3.new(1320, 25, 4450)
          local v746 = nil
          local enemies6 = v4:FindFirstChild("Enemies")

          if enemies6 then
            for index92, value186 in ipairs(enemies6:GetChildren()) do
              local humanoid26 = value186:FindFirstChildOfClass("Humanoid")

              if humanoid26 and humanoid26.Health > 0 then
                if (value186:GetPivot().Position - vector10).Magnitude <= 200 then
                  v746 = value186
                  break
                end
              end
            end
          end

          if v746 then
            subFunction:Attack(v746, true)
          else
            tweenManager:topos(CFrame.new(1308, 23, 4492))
            local bonusMomentsRemoteEvent4 = v5.Remotes:FindFirstChild("BonusMomentsRemoteEvent")

            if bonusMomentsRemoteEvent4 then
              bonusMomentsRemoteEvent4:FireServer("Rescue Hasan", "StartWaves")
              bonusMomentsRemoteEvent4:FireServer("Rescue Hasan", "Interact")
            end

            bonusMomentsRemoteFunction2 = v5.Remotes:FindFirstChild("BonusMomentsRemoteFunction")

            if bonusMomentsRemoteFunction2 then
              pcall(function()
                bonusMomentsRemoteFunction2:InvokeServer("Rescue Hasan", "StartWaves")
                bonusMomentsRemoteFunction2:InvokeServer("Rescue Hasan", "Interact")
              end)
            end
          end

          return
        elseif not v743["Sea1/Desert/Prickly Harvest"] then
          local cframe16 = CFrame.new(862, 5, 4453)
          local bonusMomentsRemoteFunction4 = v5.Remotes:FindFirstChild("BonusMomentsRemoteFunction")
          local bonusMomentsRemoteEvent5 = v5.Remotes:FindFirstChild("BonusMomentsRemoteEvent")

          if v734 >= 10 then
            tweenManager:topos(cframe16)

            if bonusMomentsRemoteFunction4 then
              bonusMomentsRemoteFunction4:InvokeServer("Prickly Harvest", "Interact")
              bonusMomentsRemoteFunction4:InvokeServer("Prickly Harvest", "ClaimReward")
            end

            if bonusMomentsRemoteEvent5 then
              bonusMomentsRemoteEvent5:FireServer("Prickly Harvest", "ClaimReward")
            end

            local commF3 = v5.Remotes:FindFirstChild("CommF_")

            if commF3 then
              commF3:InvokeServer("ClaimReward", "Prickly Harvest")
            end

            v734 = 0
            return
          end

          if bonusMomentsRemoteFunction4 and v734 == 0 then
            local v747, v748 = bonusMomentsRemoteFunction4:InvokeServer(
              "Prickly Harvest", "Interact"
            )

            if typeof(v748) == "number" then
              v734 = math.max(v734, v748)
            end

            if v747 == "Reward" or v734 >= 10 then
              tweenManager:topos(cframe16)
              return
            end
          end

          local v749 = nil
          local findFirstChild13 = v4:FindFirstChild("Cacti", true)

          if findFirstChild13 then
            for index93, value187 in ipairs(findFirstChild13:GetChildren()) do
              if value187:IsA("Model") then
                local trunk = value187:FindFirstChild("Trunk")

                local spike = trunk
                spike = trunk or value187:FindFirstChild("Spike") or value187.PrimaryPart

                if spike and spike:IsA("BasePart") and spike.Transparency < 0.9 then
                  v749 = spike
                  break
                end
              end
            end
          end

          if v749 then
            tweenManager:topos(v749.CFrame * CFrame.new(0, 2, 3))
            f111(v749)
          else
            tweenManager:topos(CFrame.new(1160, 15, 4350))
          end

          return
        elseif not v743["Sea1/Frozen Village/Breaking the Ice"] then
          local bonusMomentsRemoteEvent6 = v5.Remotes:FindFirstChild("BonusMomentsRemoteEvent")

          if bonusMomentsRemoteEvent6 then
            bonusMomentsRemoteEvent6:FireServer("Breaking the Ice", "Init")
            bonusMomentsRemoteEvent6:FireServer("Breaking the Ice", "IcebergHit")
          end

          local findFirstChild14 = v4:FindFirstChild("Iceberg", true)

          if findFirstChild14 then
            local basePart9 = findFirstChild14:IsA("BasePart") and findFirstChild14
              or findFirstChild14.PrimaryPart
              or findFirstChild14:FindFirstChildWhichIsA("BasePart")

            if basePart9 then
              tweenManager:topos(basePart9.CFrame * CFrame.new(0, 2, 3))
              f111(basePart9)
              return
            end

            return
          end

          tweenManager:topos(CFrame.new(1298, 87, -1344))
          return
        elseif not v743["Sea1/Magma Village/Evil Slimes"] then
          local vector11 = Vector3.new(-5472.8, 17.2, 8303.6)
          local v750 = nil
          local huge15 = math.huge
          local enemies7 = v4:FindFirstChild("Enemies")

          if enemies7 then
            for index94, value188 in ipairs(enemies7:GetChildren()) do
              local humanoid27 = value188:FindFirstChildOfClass("Humanoid")

              local humanoidRootPart47 = value188:FindFirstChild("HumanoidRootPart")
                or value188.PrimaryPart

              if humanoid27
                and humanoid27.Health > 0
                and humanoidRootPart47
                and (value188.Name == "Evil Slime"
                  or (humanoidRootPart47.Position - vector11).Magnitude <= 350)
                and localPlayer:DistanceFromCharacter(humanoidRootPart47.Position) <= 15
                and localPlayer:DistanceFromCharacter(humanoidRootPart47.Position) < huge15 then
                huge15 = localPlayer:DistanceFromCharacter(humanoidRootPart47.Position)
                v750 = value188
              end
            end
          end

          if not v750 then
            local bonusMomentsRemoteEvent7 = v5.Remotes:FindFirstChild("BonusMomentsRemoteEvent")

            if bonusMomentsRemoteEvent7 then
              bonusMomentsRemoteEvent7:FireServer("Evil Slimes", "Init")
              bonusMomentsRemoteEvent7:FireServer("Evil Slimes", "Interact")
            end

            local slimeGeyser = v4.Map:FindFirstChild("Magma")
                and v4.Map.Magma:FindFirstChild("BonusMoment_Locations", true)
                and v4.Map.Magma.BonusMoment_Locations:FindFirstChild("SlimeGeyser")
              or v4:FindFirstChild("SlimeGeyser", true)

            local lava001 = slimeGeyser
              and (slimeGeyser:FindFirstChild("Lava.001")
                or slimeGeyser:FindFirstChild("Cube_cell.006"))

            local v751 = lava001
            v751 = lava001 and lava001.CFrame * CFrame.new(0, 3, 0)

            if not lava001 then
              tweenManager:topos(CFrame.new(-5290, 9, 8349))
            else
              tweenManager:topos(v751, true)
              f111(lava001)
            end
          else
            subFunction:Attack(v750, true)
          end

          return
        elseif not v743["Sea1/Jungle/Zipline Repair"] then
          bonusMomentsRemoteFunction = v5.Remotes:FindFirstChild("BonusMomentsRemoteFunction")
          local bonusMomentsRemoteEvent8 = v5.Remotes:FindFirstChild("BonusMomentsRemoteEvent")

          if bonusMomentsRemoteEvent8 then
            bonusMomentsRemoteEvent8:FireServer("Zipline Repair", "Initialize")
          end

          if bonusMomentsRemoteFunction then
            pcall(function()
              bonusMomentsRemoteFunction:InvokeServer("Zipline Repair", "Initialize")
            end)
          end

          local character34 = localPlayer.Character

          local humanoidRootPart48 = character34

          humanoidRootPart48 = character34
            and (localPlayer.Character:FindFirstChild("HumanoidRootPart")
              or localPlayer.Character.PrimaryPart)

          if not humanoidRootPart48 then
            return
          else
            local grapplingHook2 = localPlayer.Character:FindFirstChild("Grappling Hook")
              or localPlayer.Backpack and localPlayer.Backpack:FindFirstChild("Grappling Hook")

            if not grapplingHook2 then
              local findFirstChild15 = v4:FindFirstChild("GroundPickupGrapplingHook") and v4.GroundPickupGrapplingHook:FindFirstChild(
                "hook.001", true
              ) or v4:FindFirstChild("hook.001", true)

              local v752 = findFirstChild15
              v752 = findFirstChild15 and findFirstChild15.CFrame * CFrame.new(0, 0, 2)

              local cframe17 = v752
              cframe17 = v752 or CFrame.new(-1237.5, 0, -287.5)

              tweenManager:topos(cframe17, true)

              if (humanoidRootPart48.Position - cframe17.Position).Magnitude <= 15 then
                local proximityPrompt = findFirstChild15 and findFirstChild15:FindFirstChildWhichIsA("ProximityPrompt") or v4:FindFirstChild("GroundPickupGrapplingHook") and v4.GroundPickupGrapplingHook:FindFirstChildWhichIsA(
                  "ProximityPrompt", true
                )

                if proximityPrompt then
                  fireproximityprompt(proximityPrompt, 0)
                  fireproximityprompt(proximityPrompt)
                end

                if bonusMomentsRemoteEvent8 then
                  bonusMomentsRemoteEvent8:FireServer("Zipline Repair", "PickupTool")
                end

                if bonusMomentsRemoteFunction then
                  pcall(function()
                    bonusMomentsRemoteFunction:InvokeServer("Zipline Repair", "PickupTool")
                  end)
                end
              end
            else
              if grapplingHook2.Parent ~= localPlayer.Character
                and localPlayer.Character:FindFirstChild("Humanoid") then
                localPlayer.Character.Humanoid:EquipTool(grapplingHook2)
              end

              local ziplinePair = v4:FindFirstChild("Map") and v4.Map:FindFirstChild("Jungle")
                  and v4.Map.Jungle:FindFirstChild("ZiplinePair")
                or v6:GetTagged("ZiplinePair")[1]

              local v753 = {}

              if ziplinePair then
                for index95, value189 in ipairs(ziplinePair:GetChildren()) do
                  if value189:IsA("Model") and value189.Name == "zipline" then
                    local primaryPart9 = value189.PrimaryPart
                      or value189:FindFirstChild("Cube.003")
                      or value189:FindFirstChildWhichIsA("BasePart")

                    if primaryPart9 then
                      table.insert(v753, primaryPart9)
                    end
                  end
                end
              end

              local v754 = v753[1]
              local v755 = v753[2]

              cframe15 = v754 and v754.CFrame * CFrame.new(0, 4, 3)
                or CFrame.new(-1280.9, 82, -247.1)

              position47 = v755 and v755.Position or Vector3.new(-1482.8, 78.1, -15.3)
              tweenManager:topos(cframe15, true)

              if (humanoidRootPart48.Position - cframe15.Position).Magnitude <= 15 then
                grapplingHook = localPlayer.Character:FindFirstChild("Grappling Hook")

                if grapplingHook then
                  pcall(function() grapplingHook:Activate() end)
                end

                pcall(function()
                  local v756 = require(v5.Util.Trajectory).getArcAim(
                    cframe15.Position, position47
                  )

                  if bonusMomentsRemoteFunction then
                    bonusMomentsRemoteFunction:InvokeServer(
                      "Zipline Repair", "Throw", "Grappling Hook", v756
                    )
                  end
                end)
              end
            end

            return
          end
        elseif not v743["Sea1/Prison/Don Megalo"] then
          local bonusMomentsRemoteFunction5 = v5.Remotes:FindFirstChild("BonusMomentsRemoteFunction")
          local bonusMomentLocations = v4.Map.Prison:FindFirstChild("BonusMoment_Locations")

          if bonusMomentsRemoteFunction5 then
            bonusMomentsRemoteFunction5:InvokeServer("Don Megalo", "Init")
          end

          local key82 = bonusMomentLocations
          key82 = bonusMomentLocations and bonusMomentLocations:FindFirstChild("Key")

          local megaloGate = bonusMomentLocations

          megaloGate = bonusMomentLocations
            and bonusMomentLocations:FindFirstChild("MegaloGate")

          local sharkCape = bonusMomentLocations
          sharkCape = bonusMomentLocations and bonusMomentLocations:FindFirstChild("SharkCape")

          local rootPart2 = sharkCape
            and (sharkCape:FindFirstChild("RootPart")
              or sharkCape:FindFirstChildWhichIsA("BasePart", true))

          local function f113(p246)
            local findFirstChildWhichIsA5 = p246
              and p246:FindFirstChildWhichIsA("ProximityPrompt", true)

            return findFirstChildWhichIsA5 ~= nil and findFirstChildWhichIsA5.Enabled
          end

          local v757 = not key82 or not f113(key82)
          local v758 = not megaloGate or not f113(megaloGate)

          if not v757 then
            tweenManager:topos(key82.CFrame, true)

            if bonusMomentsRemoteFunction5 then
              bonusMomentsRemoteFunction5:InvokeServer("Don Megalo", "TakeKey")
            end
          elseif not v758 then
            tweenManager:topos(megaloGate.CFrame * CFrame.new(0, 0, 3), true)

            if bonusMomentsRemoteFunction5 then
              bonusMomentsRemoteFunction5:InvokeServer("Don Megalo", "Unlock")
            end
          elseif utilities:CheckMon("Megalo Guard") then
            local megaloGuard = utilities:GetEnemies("Megalo Guard")

            if megaloGuard then
              subFunction:Attack(megaloGuard, true)
            end
          elseif utilities:CheckMon("Don Megalo") then
            local donMegalo = utilities:GetEnemies("Don Megalo")

            if donMegalo then
              subFunction:Attack(donMegalo, true)
            end
          elseif rootPart2 and sharkCape and sharkCape.Parent then
            tweenManager:topos(rootPart2.CFrame * CFrame.new(0, 0, 2), true)

            if bonusMomentsRemoteFunction5 then
              bonusMomentsRemoteFunction5:InvokeServer("Don Megalo", "TakeCape")
            end
          elseif rootPart2 then
            tweenManager:topos(rootPart2.CFrame * CFrame.new(0, 0, 2), true)

            if bonusMomentsRemoteFunction5 then
              bonusMomentsRemoteFunction5:InvokeServer("Don Megalo", "ClaimCape")
            end
          else
            tweenManager:topos(CFrame.new(5351, 8, 1100))
          end
        elseif not v743["Sea1/Prison/Escape from Alcatraz"] then
          local bonusMomentsRemoteFunction6 = v5.Remotes:FindFirstChild("BonusMomentsRemoteFunction")

          if bonusMomentsRemoteFunction6 then
            bonusMomentsRemoteFunction6:InvokeServer(
              "Escape from Alcatraz", "Provoke", "Puncher"
            )

            bonusMomentsRemoteFunction6:InvokeServer(
              "Escape from Alcatraz", "Provoke", "Digger"
            )

            bonusMomentsRemoteFunction6:InvokeServer("Escape from Alcatraz", "Provoke", "Raft")
            bonusMomentsRemoteFunction6:InvokeServer("Escape from Alcatraz", "Provoke", 1)
          end

          local v759 = nil
          local enemies8 = v4:FindFirstChild("Enemies")

          if enemies8 then
            for index96, value190 in ipairs(enemies8:GetChildren()) do
              if value190.Name:find("Prisoner") then
                local humanoid28 = value190:FindFirstChildOfClass("Humanoid")

                if humanoid28 and humanoid28.Health > 0 then
                  v759 = value190
                  break
                end
              end
            end
          end

          if v759 then
            subFunction:Attack(v759, true)
          else
            tweenManager:topos(CFrame.new(5351, 8, 1100))
          end
        elseif not v743["Sea1/Fountain/Fountain Pipe Repair"] then
          local findFirstChild16 = v4:FindFirstChild("FountainPipeNodes", true)
          local v760 = nil

          if findFirstChild16 then
            for index97, value191 in ipairs(findFirstChild16:GetChildren()) do
              if value191:IsA("BasePart") and not value191.CanCollide then
                v760 = value191
                break
              end
            end
          end

          if v760 then
            tweenManager:topos(v760.CFrame * CFrame.new(0, 0, 2))
            f111(v760)
          else
            local grandBrigade = v4:FindFirstChild("Grand Brigade")

            local fakeVehicleSeat = grandBrigade
            fakeVehicleSeat = grandBrigade and grandBrigade:FindFirstChild("FakeVehicleSeat")

            if fakeVehicleSeat then
              tweenManager:topos(fakeVehicleSeat.CFrame * CFrame.new(0, 0, 2), true)
            else
              tweenManager:topos(CFrame.new(5616, 402, 4478), true)
            end

            local bonusMomentsRemoteFunction7 = v5.Remotes:FindFirstChild("BonusMomentsRemoteFunction")

            if bonusMomentsRemoteFunction7 then
              bonusMomentsRemoteFunction7:InvokeServer("Fountain Pipe Repair", "TurnIn")
            end
          end
        elseif not v743["Sea1/Colosseum/King's Apprentice"] then
          kingSApprentice = v4:FindFirstChild("King's Apprentice")

          local startMatchHitbox = kingSApprentice
            and kingSApprentice:FindFirstChild("StartMatchHitbox")

          local vector12 = Vector3.new(-1726.6, 9.87, -3250.5)

          pcall(function()
            if kingSApprentice then
              local v761 = kingSApprentice:GetAttribute("MatchActive") == true
            end
          end)

          local v762 = nil
          local huge16 = math.huge
          local enemies9 = v4:FindFirstChild("Enemies")

          if enemies9 then
            for index98, value192 in ipairs(enemies9:GetChildren()) do
              local humanoid29 = value192:FindFirstChildOfClass("Humanoid")

              local humanoidRootPart49 = value192:FindFirstChild("HumanoidRootPart")
                or value192.PrimaryPart

              if humanoid29
                and humanoid29.Health > 0
                and humanoidRootPart49
                and ((humanoidRootPart49.Position - vector12).Magnitude <= 350
                  or value192.Name == "Gladiator")
                and localPlayer:DistanceFromCharacter(humanoidRootPart49.Position) <= 15
                and localPlayer:DistanceFromCharacter(humanoidRootPart49.Position) < huge16 then
                huge16 = localPlayer:DistanceFromCharacter(humanoidRootPart49.Position)
                v762 = value192
              end
            end
          end

          if not v762 then
            pcall(function()
              local bonusMomentsGuide = require(v5.Modules.Net):RemoteFunction("BonusMomentsGuide")

              if bonusMomentsGuide then
                bonusMomentsGuide:InvokeServer("InteractQuestGiver", "ColosseumEmperor")
              end
            end)

            local bonusMomentsRemoteEvent9 = v5.Remotes:FindFirstChild("BonusMomentsRemoteEvent")

            if bonusMomentsRemoteEvent9 then
              bonusMomentsRemoteEvent9:FireServer("King's Apprentice", "Interact")
            end

            task.wait(0.5)

            tweenManager:topos(startMatchHitbox and startMatchHitbox.CFrame * CFrame.new(0, 2, 0)
              or CFrame.new(-1726.6, 12, -3250.5), true)
          else
            subFunction:Attack(v762, true)
          end
        else
          tweenManager:topos(CFrame.new(-688, 15, 1585))

          if v33 and v33.SendNotify then
            v33:SendNotify("Secret Quests", "All Secret Quests Completed!", 5)
          end
        end
      end
    end, v24)

    f110("AutoUnlockSaber", function()
      if data.Level.Value >= 200 then
        if v4.Map.Jungle.Final.Part.CanCollide then
          if v4.Map.Jungle.QuestPlates.Door.CanCollide then
            local v763, v764 = v4.Map.Jungle.QuestPlates:GetChildren()

            for key83, value193 in next, v763, v764 do
              if value193:FindFirstChild("Button")
                and value193.Button:FindFirstChild("TouchInterest") then
                tweenManager:topos(value193.Button.CFrame)
              end
            end

            return
          elseif not v4.Map.Desert.Burn.Part.CanCollide then
            if commF:InvokeServer("ProQuestProgress", "RichSon") ~= 0
              and commF:InvokeServer("ProQuestProgress", "RichSon") ~= 1 then
              if not utilities:CheckToolName("Cup") then
                if (localPlayer.Character.HumanoidRootPart.Position
                    - CFrame.new(1112, 5, 4365).Position).Magnitude
                  < 5 then
                  tweenManager:topos(CFrame.new(1114, 8, 4365))

                  firetouchinterest(
                    v4.Map.Desert.Cup, localPlayer.Character.HumanoidRootPart, 0
                  )

                  firetouchinterest(
                    v4.Map.Desert.Cup, localPlayer.Character.HumanoidRootPart, 1
                  )

                  return
                end

                tweenManager:topos(CFrame.new(1112, 5, 4365))
                return
              end

              utilities:EquipTool("Cup")

              if utilities:CheckToolName("Cup")
                and utilities:CheckToolName("Cup").Handle:FindFirstChild("TouchInterest") then
                commF:InvokeServer(
                  "ProQuestProgress", "FillCup", localPlayer.Character:FindFirstChild("Cup")
                )

                commF:InvokeServer("ProQuestProgress", "SickMan")
              end

              return
            elseif commF:InvokeServer("ProQuestProgress", "RichSon") == 0 then
              local mobLeader = utilities:GetEnemies("Mob Leader")

              if mobLeader then
                return subFunction:Attack(mobLeader)
              end

              return
            elseif commF:InvokeServer("ProQuestProgress", "RichSon") == 1 then
              if not utilities:CheckToolName("Relic") then
                if (localPlayer.Character.HumanoidRootPart.Position - CFrame.new(-1404, 30, 5)).Magnitude
                  > 8 then
                  tweenManager:topos(CFrame.new(-1404, 30, 5))
                else
                  commF:InvokeServer("ProQuestProgress", "RichSon")
                end
              else
                utilities:EquipTool("Relic")
                tweenManager:topos(CFrame.new(-1405, 30, 5))
              end
            end
          else
            if not utilities:CheckToolName("Torch") and v4.Map.Desert.Burn.Part.CanCollide then
              tweenManager:topos(v4.Map.Jungle.Torch.CFrame)
              return
            end

            utilities:EquipTool("Torch")

            if (localPlayer.Character.HumanoidRootPart.Position
                - CFrame.new(1115, 5, 4349).Position).Magnitude
              < 5 then
              tweenManager:topos(CFrame.new(1115, 5, 4351))

              firetouchinterest(localPlayer.Character.Torch.Handle, v4.Map.Desert.Burn.Fire, 0)
              firetouchinterest(localPlayer.Character.Torch.Handle, v4.Map.Desert.Burn.Fire, 1)

              return
            end

            tweenManager:topos(CFrame.new(1115, 5, 4349))
            return
          end
        else
          local saberExpert = utilities:GetEnemies("Saber Expert")

          if saberExpert then
            return subFunction:Attack(saberExpert)
          end

          return
        end
      else
        return
      end
    end, v24)

    f110("AutoBartiloQuest", function()
      if level.Value >= 850 then
        if commF:InvokeServer("BartiloQuestProgress", "Bartilo") == 0 then
          if VerifyQuest("Swan Pirates") and VerifyQuest("50")
            and localPlayer.PlayerGui.Main.Quest.Visible then
            local swanPirate = utilities:GetEnemies("Swan Pirate")

            if swanPirate then
              return subFunction:Attack(swanPirate, true)
            end

            utilities:MobsNextSpawn("Swan Pirate")
            return
          end

          if (localPlayer.Character.HumanoidRootPart.Position
              - CFrame.new(-456.28952, 73.0200958, 299.895966).Position).Magnitude
            > 8 then
            tweenManager:topos(CFrame.new(-456.28952, 73.0200958, 299.895966))
          else
            commF:InvokeServer("StartQuest", "BartiloQuest", 1)
          end

          return
        elseif commF:InvokeServer("BartiloQuestProgress", "Bartilo") == 1 then
          if utilities:CheckMon("Jeremy") then
            local jeremy = utilities:GetEnemies("Jeremy")

            if jeremy then
              return subFunction:Attack(jeremy)
            end

            return
          end

          v33:SendNotify("Bartilo Quest", "boss jeremy, not spawned", 8)
          return
        elseif commF:InvokeServer("BartiloQuestProgress", "Bartilo") == 2 then
          if (localPlayer.Character.HumanoidRootPart.Position
              - Vector3.new(-1835.65, 10.4325, 1679.75)).Magnitude
            > 100 then
            tweenManager:topos(CFrame.new(-1835.65, 10.4325, 1679.75))
          else
            localPlayer.Character.HumanoidRootPart.CFrame = map.Dressrosa.BartiloPlates[gameData:PlatesBartilo()].CFrame
            task.wait()

            firetouchinterest(
              map.Dressrosa.BartiloPlates[gameData:PlatesBartilo()],
              localPlayer.Character.HumanoidRootPart, 0
            )

            firetouchinterest(
              map.Dressrosa.BartiloPlates[gameData:PlatesBartilo()],
              localPlayer.Character.HumanoidRootPart, 1
            )
          end
        elseif commF:InvokeServer("BartiloQuestProgress", "Bartilo") == 3 then
          v33:SendNotify("Bartilo Quest", "Quest Completed", 8)
        end
      else
        return
      end
    end, v25)

    local v765 = 0

    f110("AutoChest", function()
      local detectChest = gameData:DetectChest()

      if not detectChest then
        gameData.CurrentChest = nil

        if v19.AutoHopChest then
          if v765 >= (tonumber(v19.ChestHopCount) or 10) then
            v765 = 0
            local v766 = tonumber(v19.HopDelay) or 10

            v33:SendNotify(
              "Chest Farm", "Target reached. Hopping in " .. math.floor(v766) .. "s...",
              math.min(math.floor(v766), 5)
            )

            utilities:ServerHop(v766)
            task.wait(v766 + 5)
          end
        end

        return
      else
        local character35 = localPlayer.Character

        local humanoidRootPart50 = character35

        humanoidRootPart50 = character35
          and localPlayer.Character:FindFirstChild("HumanoidRootPart")

        if not humanoidRootPart50 then
          return
        else
          if gameData.CurrentChest ~= detectChest then
            gameData.CurrentChest = detectChest
            gameData.ChestTargetTime = tick()
            gameData.ChestNearTime = 0
          end

          local cframe18 = detectChest:IsA("BasePart") and detectChest.CFrame
            or detectChest:IsA("Model")
              and (detectChest.PrimaryPart and detectChest.PrimaryPart.CFrame
                or detectChest:GetPivot())

          if not cframe18 then
            return
          else
            local magnitude19 = (humanoidRootPart50.Position - cframe18.Position).Magnitude

            if magnitude19 <= 15 then
              if detectChest:GetAttribute("IsDisabled") == true
                or detectChest:GetAttribute("Collected") == true
                or not detectChest:FindFirstChildWhichIsA("TouchTransmitter", true)
                or not detectChest:IsDescendantOf(workspace) then
                gameData.BlacklistChest(detectChest, 90)
                gameData.VisitedChests[detectChest] = true

                v765 = v765 + 1

                gameData.CurrentChest = nil
                gameData.ChestNearTime = 0
                gameData.ChestTargetTime = 0

                tweenManager:StopTween()
                task.wait(0.15)
                return
              end

              if gameData.ChestNearTime == 0 then
                gameData.ChestNearTime = tick()
              elseif tick() - gameData.ChestNearTime > 2 then
                gameData.BlacklistChest(detectChest, 60)
                gameData.CurrentChest = nil
                gameData.ChestNearTime = 0
                gameData.ChestTargetTime = 0

                tweenManager:StopTween()
              end

              return
            else
              local v767 = math.max(30, magnitude19 / 140 + 10)

              if tick() - gameData.ChestTargetTime > v767 then
                gameData.BlacklistChest(detectChest, 60)
                gameData.CurrentChest = nil
                gameData.ChestTargetTime = 0

                tweenManager:StopTween()
                return
              end

              tweenManager:topos(cframe18 * CFrame.new(0, 1.5, 0), true)
              task.wait(0.1)

              if v19.StopChest or v19.StopHopChestIfChalice then
                if utilities:CheckToolName("God's Chalice")
                  or utilities:CheckToolName("Fist of Darkness")
                  or utilities:CheckToolName("Sweet Chalice") then
                  v19.AutoChest = false
                  v19.AutoHopChest = false
                end
              end

              return
            end
          end
        end
      end
    end, true)

    f110("AutoFactoryRaid", function()
      if utilities:CheckMon("Core") then
        local core = utilities:GetEnemies("Core")

        if core then
          return subFunction:Attack(core)
        end

        return
      end
    end, v25)

    f110("AutoFarmPirateRaid", function()
      local enemies10 = v4.Enemies
      local v768

      for key84, value194 in pairs(enemies10:GetChildren()) do
        if value194.Name ~= "rip_indra True Form" then
          local humanoid30 = value194:FindFirstChild("Humanoid")

          if humanoid30 and humanoid30.Health > 0 then
            if value194
              and value194.PrimaryPart
              and (value194.PrimaryPart.Position - Vector3.new(-5556, 314, -2988)).Magnitude
                < 700 then
              v768 = value194
            end
          end
        end
      end

      if v768 then
        return subFunction:Attack(v768, true)
      end
    end, v26)

    f110("AutoSoulReaper", function()
      local soulReaper = utilities:GetEnemies("Soul Reaper")

      if soulReaper then
        return subFunction:Attack(soulReaper)
      end

      if utilities:CheckToolName("Hallow Essence") then
        utilities:EquipTool("Hallow Essence")
        return tweenManager:topos(CFrame.new(-8932.322265625, 146.83154296875, 6062.55078125))
      end
    end, v26)

    f110("AutoGreybeard", function()
      if utilities:CheckMon("Greybeard") then
        local greybeard = utilities:GetEnemies("Greybeard")

        if greybeard then
          return subFunction:Attack(greybeard)
        end

        return
      end
    end, v24)

    f110("AutoDarkbeard", function()
      if utilities:CheckMon("Darkbeard") then
        local darkbeard = utilities:GetEnemies("Darkbeard")

        if darkbeard then
          return subFunction:Attack(darkbeard)
        end

        if utilities:CheckToolName("Fist of Darkness") then
          utilities:EquipTool("Fist of Darkness")
          return tweenManager:topos(CFrame.new(3777, 14, -3499))
        end

        return
      end

      if utilities:CheckToolName("Fist of Darkness") then
        utilities:EquipTool("Fist of Darkness")
        return tweenManager:topos(CFrame.new(3777, 14, -3499))
      end
    end, v25)

    f110("AutoCursedCaptain", function()
      if utilities:CheckMon("Cursed Captain") then
        local cursedCaptain = utilities:GetEnemies("Cursed Captain")

        if cursedCaptain then
          return subFunction:Attack(cursedCaptain)
        end

        return
      end
    end, v25)

    f110("AutoRipIndra", function()
      if utilities:CheckMon("rip_indra True Form") then
        local ripIndraTrueForm = utilities:GetEnemies("rip_indra True Form")

        if ripIndraTrueForm then
          return subFunction:Attack(ripIndraTrueForm)
        end

        if utilities:CheckToolName("God's Chalice") then
          utilities:EquipTool("God's Chalice")
          return tweenManager:topos(CFrame.new(-5561, 314, -2663))
        end

        return
      end

      return tweenManager:topos(CFrame.new(-5333, 424, -2673))
    end, v26)

    f110("AutoFarmObservation", function()
      if not v6:HasTag(localPlayer.Character, "Ken") then
        return nil
      else
        if localPlayer:GetAttribute("KenDodgesLeft") > 1 then
          remotes.CommE:FireServer("Ken", true)
        end

        local visionRadius = localPlayer:FindFirstChild("VisionRadius")
        local kenMaxDodges2 = localPlayer:GetAttribute("KenMaxDodges") or 8
        local kenDodgesLeft2 = localPlayer:GetAttribute("KenDodgesLeft") or 0

        if visionRadius and not (kenDodgesLeft2 <= 0) then
          local cframe19 = nil
          local getEnemies17 = nil

          if v24 then
            getEnemies17 = utilities:GetEnemies({ "Galley Captain" })
            cframe19 = CFrame.new(5533, 88, 4852)
          elseif v25 then
            getEnemies17 = utilities:GetEnemies({ "Lava Pirate" })
            cframe19 = CFrame.new(-5478, 16, -5247)
          elseif v26 then
            getEnemies17 = utilities:GetEnemies({ "Venomous Assailant" })
            cframe19 = CFrame.new(4731.2719, 1090.178, 1078.1713)
          end

          if getEnemies17 and getEnemies17:FindFirstChild("HumanoidRootPart") then
            if kenDodgesLeft2 >= 1 then
              tweenManager:topos(
                getEnemies17.HumanoidRootPart.CFrame * CFrame.new(3, 0, 0), true
              )
            else
              tweenManager:topos(
                getEnemies17.HumanoidRootPart.CFrame * CFrame.new(0, 50, 10), true
              )

              if kenDodgesLeft2 == 0.5 and v19.StartObsHop then
                v5.__ServerBrowser:InvokeServer(
                  "teleport", v5.__ServerBrowser:InvokeServer("getjob")
                )
              end
            end

            if kenDodgesLeft2 <= 0.5 then
              remotes.CommE:FireServer("Ken", true)

              v33:SendNotify(
                "Observation", "Dodges low! (" .. kenDodgesLeft2 .. "/" .. kenMaxDodges2 .. ")",
                10
              )
            end
          else
            tweenManager:topos(cframe19, true)
          end
        else
          v33:SendNotify("Observation", "Max Vision reached!", 10)
        end

        return
      end
    end, true)

    f110("DummyTraining", function()
      if not VerifyQuest("Training Dummy")
        and not localPlayer.PlayerGui.Main:FindFirstChild("Quest").Visible then
        return commF:InvokeServer("ArenaTrainer")
      else
        local trainingDummy = utilities:GetEnemies("Training Dummy")

        if trainingDummy then
          return subFunction:Attack(trainingDummy)
        end

        utilities:MobsNextSpawn("Training Dummy")
        return
      end
    end, v26)

    f110("AutoStartRaceV2", function()
      if not data.Race:FindFirstChild("Evolved") then
        local invokeServer9 = commF:InvokeServer("Alchemist", "1")

        if invokeServer9 == 0 or invokeServer9 == 2 then
          if localPlayer:DistanceFromCharacter(Vector3.new(-2777, 73, -3570)) <= 4 then
            commF:InvokeServer("Alchemist", invokeServer9 == 0 and "2" or "3")
          else
            tweenManager:topos(CFrame.new(-2777, 73, -3570))
          end

          return
        end

        if invokeServer9 == 1 then
          local v769 = { "Flower 1", "Flower 2", "Flower 3" }

          for index99, value195 in ipairs(v769) do
            if not utilities:CheckToolName(value195) then
              if index99 == 3 then
                local flower1 = v4:FindFirstChild("Flower1")
                local flower2 = v4:FindFirstChild("Flower2")
                local v770 = not flower1 or flower1.Transparency == 1

                local v771 = v770
                v771 = v770 and (not flower2 or flower2.Transparency == 1)

                local flower12 = utilities:CheckToolName("Flower 1")
                local flower22 = flower12
                local v772 = v771

                if flower12 then
                  flower22 = utilities:CheckToolName("Flower 2")
                end

                if flower22 or v772 then
                  local swanPirate2 = utilities:GetEnemies("Swan Pirate")

                  if swanPirate2 then
                    subFunction:Attack(swanPirate2, true)
                  else
                    utilities:MobsNextSpawn("Swan Pirate")
                  end

                  return
                end
              else
                local findFirstChild17 = v4:FindFirstChild("Flower" .. index99)

                if findFirstChild17 and findFirstChild17.Transparency ~= 1 then
                  tweenManager:topos(findFirstChild17.CFrame)
                  task.wait(0.5)
                  return
                else
                  local v773 = false

                  for i34 = index99 + 1, 2 do
                    if not utilities:CheckToolName(v769[i34]) then
                      local findFirstChild18 = v4:FindFirstChild("Flower" .. i34)

                      if findFirstChild18 and findFirstChild18.Transparency ~= 1 then
                        v773 = true
                        break
                      end
                    end
                  end

                  if not v773 then
                    tweenManager:topos(CFrame.new(-382, 73, 290))
                    v33:SendNotify("Race V1-V2 Quest", "Waiting for night time", 8)
                    return
                  end
                end
              end
            end
          end

          return
        end

        return
      end
    end, v25)

    f110("AutoStartRaceV3", function()
      local race = data.Race
      local v774, v775

      if not race:FindFirstChild("Evolved") then
        return nil
      else
        local invokeServer10 = commF:InvokeServer("Wenlocktoad", "1")

        if invokeServer10 == 0 or invokeServer10 == 2 then
          if localPlayer:DistanceFromCharacter(Vector3.new(-1992, 125, -73)) <= 4 then
            commF:InvokeServer("Wenlocktoad", invokeServer10 == 0 and "2" or "3")
          else
            tweenManager:topos(Vector3.new(-1992, 125, -73))
          end

          return
        elseif invokeServer10 == 1 then
          if data.Race.Value == "Mink" then
            functions.AutoChest.Call()
            return
          elseif data.Race.Value == "Human" then
            if checkv3boss() then
              local getEnemies18 = utilities:GetEnemies({ "Diamond", "Orbitus", "Jeremy" })

              if getEnemies18 then
                return subFunction:Attack(getEnemies18)
              end

              return
            end

            tweenManager:topos(CFrame.new(-382, 73, 290))

            v33:SendNotify(
              "Human V3 Quest", "Diamond, Orbitus, or Jeremy not currently spawned.", 8
            )

            return
          elseif data.Race.Value == "Ghoul" then
            local v776 = nil
            local huge17 = math.huge

            for key85, value196 in pairs(v3:GetChildren()) do
              if value196.Name ~= localPlayer.Name
                and not value196:GetAttribute("IslandRaiding")
                and not value196:GetAttribute("PvpDisabled") then
                local findFirstChild19 = v4.Characters:FindFirstChild(value196.Name)

                if findFirstChild19 then
                  local humanoidRootPart51 = findFirstChild19:FindFirstChild("HumanoidRootPart")
                  local humanoid31 = findFirstChild19:FindFirstChildOfClass("Humanoid")

                  if humanoidRootPart51 and humanoid31 and humanoid31.Health > 0 then
                    local v777 = value196.Data.Level.Value - localPlayer.Data.Level.Value

                    if v777 < 500 and v777 > -500 then
                      if not f20(findFirstChild19) then
                        local magnitude20 = (humanoidRootPart51.Position
                          - localPlayer.Character.HumanoidRootPart.Position).Magnitude

                        if magnitude20 < huge17 then
                          huge17 = magnitude20
                          v776 = humanoidRootPart51
                        end
                      end
                    end
                  end
                end
              end
            end

            if v776 then
              local parent5 = v776.Parent
              local humanoid32 = parent5:FindFirstChildOfClass("Humanoid")
              local v778 = v776

              repeat
                task.wait()

                utilities:AutoHaki()
                utilities:EquipWeapon()

                tweenManager:topos(v776.CFrame * CFrame.new(0, 8, 0)
                  * CFrame.Angles(math.rad(-45), 0, 0), true)

                if v778 and v778.Parent and humanoid32 and humanoid32.Health > 0 then
                  AimbotTargetInstance = parent5
                  Aimbot = v778.Position
                  f3()
                  local v779 = not v19.AutoStartRaceV3

                  v775 = v779
                  v775 = v779 or not humanoid32 or humanoid32.Health <= 0 or not v776.Parent
                else
                  AimbotTargetInstance = nil
                  Aimbot = nil
                  break
                end
              until v775

              AimbotTargetInstance = nil
              Aimbot = nil
            end
          elseif data.Race.Value == "Skypiea" then
            local v780 = nil
            local huge18 = math.huge

            for key86, value197 in pairs(v3:GetChildren()) do
              if value197.Name ~= localPlayer.Name
                and not value197:GetAttribute("IslandRaiding")
                and not value197:GetAttribute("PvpDisabled")
                and tostring(value197.Data.Race.Value) == "Skypiea" then
                local findFirstChild20 = v4.Characters:FindFirstChild(value197.Name)

                if findFirstChild20 then
                  local humanoidRootPart52 = findFirstChild20:FindFirstChild("HumanoidRootPart")
                  local humanoid33 = findFirstChild20:FindFirstChildOfClass("Humanoid")

                  if humanoidRootPart52 and humanoid33 and humanoid33.Health > 0 then
                    local v781 = value197.Data.Level.Value - localPlayer.Data.Level.Value

                    if v781 < 500 and v781 > -500 then
                      if not f20(findFirstChild20) then
                        local magnitude21 = (humanoidRootPart52.Position
                          - localPlayer.Character.HumanoidRootPart.Position).Magnitude

                        if magnitude21 < huge18 then
                          huge18 = magnitude21
                          v780 = humanoidRootPart52
                        end
                      end
                    end
                  end
                end
              end
            end

            if v780 then
              local parent6 = v780.Parent
              local humanoid34 = parent6:FindFirstChildOfClass("Humanoid")
              local v782 = v780

              repeat
                task.wait()

                utilities:AutoHaki()
                utilities:EquipWeapon()

                tweenManager:topos(v780.CFrame * CFrame.new(0, 8, 0)
                  * CFrame.Angles(math.rad(-45), 0, 0), true)

                if v782 and v782.Parent and humanoid34 and humanoid34.Health > 0 then
                  AimbotTargetInstance = parent6
                  Aimbot = v782.Position
                  f3()
                  local v783 = not v19.AutoStartRaceV3

                  v774 = v783
                  v774 = v783 or not humanoid34 or humanoid34.Health <= 0 or not v780.Parent
                else
                  AimbotTargetInstance = nil
                  Aimbot = nil
                  break
                end
              until v774

              AimbotTargetInstance = nil
              Aimbot = nil
            end
          else
            v33:SendNotify(
              "Supports Rabbit/Human/Sky V3",
              "wait for me to update all v3, love from flazhy...", 8
            )
          end
        else
          return
        end
      end
    end, v25)

    f110("AutoRaidFull", function()
      if v19.Autostopraid then
        if fragments.Value >= (tonumber(v19.FragsCap) or 10000) then
          v33._AutoRaidToggle.Update(false)
          return
        end
      end

      if localPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible
        and localPlayer:GetAttribute("IslandRaiding") then
        local v784 = {}

        for index100, value198 in ipairs(v4.Enemies:GetChildren()) do
          if value198:FindFirstChild("Humanoid") and value198:FindFirstChild("HumanoidRootPart")
            and value198.Humanoid.Health > 0
            and localPlayer:DistanceFromCharacter(value198.HumanoidRootPart.Position) < 500 then
            table.insert(v784, value198)
          end
        end

        if #v784 > 0 then
          local getCurrentRaidIslandIndex = gameData:GetCurrentRaidIslandIndex()

          if v19.InstantKillLateIslands and getCurrentRaidIslandIndex
            and (getCurrentRaidIslandIndex == 4 or getCurrentRaidIslandIndex == 5) then
            f16(v784)
            task.wait(0.2)
          else
            local v785 = v784[1]

            if v785 then
              subFunction:Attack(v785, true)
            end
          end
        else
          local getRaidIslands2 = gameData:GetRaidIslands()

          if getRaidIslands2 then
            tweenManager:topos(
              CFrame.new(getRaidIslands2.Position + Vector3.new(0, 80, 0)), true
            )
          end
        end
      end

      if utilities:CheckToolName("Special Microchip")
        and not localPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible
        and not gameData:GetRaidIslands() and not localPlayer:GetAttribute("IslandRaiding") then
        if v25 then
          local vector13 = Vector3.new(-6522, 308, -4658)
          tweenManager:topos(CFrame.new(vector13))

          if (waitForChild2.Position - vector13).Magnitude <= 5 then
            fireclickdetector(map.CircleIsland.RaidSummon2.Button.Main.ClickDetector)
          end
        elseif v26 then
          local vector14 = Vector3.new(-5073, 315, -3153)
          tweenManager:topos(CFrame.new(vector14))

          if (waitForChild2.Position - vector14).Magnitude <= 5 then
            fireclickdetector(map["Boat Castle"].RaidSummon2.Button.Main.ClickDetector)
          end
        end
      elseif v19.SelectRaid and v19.AutoBuyChip
        and not utilities:CheckToolName("Special Microchip") then
        if v19.AutoUnstoreBelowFruit and not utilities:Checkfruit()
          and not localPlayer:GetAttribute("IslandRaiding") then
          local getLowestFruit2 = utilities:GetLowestFruit()

          if getLowestFruit2 then
            commF:InvokeServer("LoadFruit", getLowestFruit2.StorageKey or getLowestFruit2.Name)
            task.wait(0.5)
            local checkfruit4 = utilities:Checkfruit()

            if checkfruit4 and localPlayer.Character
              and localPlayer.Character:FindFirstChildOfClass("Humanoid") then
              local findFirstChild21 = localPlayer.Backpack:FindFirstChild(checkfruit4)

              if findFirstChild21 then
                localPlayer.Character.Humanoid:EquipTool(findFirstChild21)
              end
            end
          end
        elseif not localPlayer:GetAttribute("IslandRaiding") then
          local checkfruit5 = utilities:Checkfruit()

          if checkfruit5 and localPlayer.Character
            and localPlayer.Character:FindFirstChildOfClass("Humanoid") then
            local findFirstChild22 = localPlayer.Backpack:FindFirstChild(checkfruit5)

            if findFirstChild22 then
              localPlayer.Character.Humanoid:EquipTool(findFirstChild22)
            end
          end

          commF:InvokeServer("RaidsNpc", "Select", v19.SelectRaid)
          task.wait(1)
        else
          task.wait(1)
        end
      end
    end, v25 or v26)

    local v786 = 0

    f110("AutoDungeonFull", function()
      local dungeon2 = map:FindFirstChild("Dungeon")
      local v787

      if not dungeon2 then
        return
      else
        local function f114()
          local huge19 = math.huge
          local v788 = 0
          local position48 = waitForChild2.Position
          local v789

          for i35 = 1, 100 do
            local findFirstChild23 = dungeon2:FindFirstChild(tostring(i35))

            if findFirstChild23 then
              local position49 = findFirstChild23:GetPivot().Position

              local v790 = math.sqrt((position48.X - position49.X) ^ 2
                + (position48.Z - position49.Z) ^ 2)

              local getExtentsSize2 = findFirstChild23:GetExtentsSize()

              if v790 < math.max(getExtentsSize2.X, getExtentsSize2.Z) / 2 + 300
                and v790 < huge19 then
                huge19 = v790
                v789 = findFirstChild23
                v788 = i35
              end
            end
          end

          return v789, v788
        end

        local v791, v792 = f114()

        local function f115(p247)
          local v793 = {}

          if not p247 then
            return v793
          else
            local getExtentsSize3 = p247:GetExtentsSize()
            local v794 = math.max(getExtentsSize3.X, getExtentsSize3.Z) / 2 + 300
            local position50 = p247:GetPivot().Position

            for index101, value199 in ipairs(v4.Enemies:GetChildren()) do
              if value199:IsDescendantOf(v4) and value199:FindFirstChild("Humanoid")
                and value199.Humanoid.Health > 0 and value199:FindFirstChild("HumanoidRootPart")
                and value199.Name ~= "Blank Buddy"
                and not string.find(string.lower(value199.Name), "shadow") then
                local position51 = value199.HumanoidRootPart.Position

                if math.sqrt((position50.X - position51.X) ^ 2
                    + (position50.Z - position51.Z) ^ 2)
                  < v794 then
                  table.insert(v793, value199)
                end
              end
            end

            return v793
          end
        end

        local v795 = f115(v791)

        if v19.AutoDungeonShrine and v792 == v786 then
          local getDungeonProps = gameData:GetDungeonProps(v791)

          if getDungeonProps then
            local position52 = getDungeonProps:GetPivot().Position

            if localPlayer:DistanceFromCharacter(position52) > 10 then
              tweenManager:topos(CFrame.new(position52 + Vector3.new(0, 5, 0)), true)
            else
              f3()
            end

            return
          end
        end

        if #v795 == 0 then
          local v796 = tick()

          repeat
            task.wait(0.5)

            local v797
            v797, v792 = f114()

            v791 = v797
            v795 = f115(v791)
            v787 = #v795 > 0 or tick() - v796 > 2
          until v787
        end

        if #v795 > 0 then
          v786 = v792
          local v798 = v795[1]
          local tool9 = localPlayer.Character:FindFirstChildOfClass("Tool")

          local position53 = v798

          position53 = v798 and v798:FindFirstChild("HumanoidRootPart")
            and v798.HumanoidRootPart.Position

          local position54 = v791
          position54 = v791 and v791:GetPivot().Position

          local zero2 = position54
          zero2 = position54 or position53 or Vector3.zero

          local doubleAttack = v798 and position53 and position53.Y > zero2.Y + 100 and 0
            or v19.DoubleAttack and 20
            or tool9 and tool9.ToolTip == "Blox Fruit" and tool9.Name ~= "Ice-Ice"
              and tool9.Name ~= "Light-Light" and 20
            or 30

          if v798 and v798.Parent and v798:FindFirstChild("HumanoidRootPart") then
            tweenManager:topos(CFrame.new(v798.HumanoidRootPart.Position
              + Vector3.new(0, doubleAttack, 0)), true)

            utilities:EquipWeapon()
            utilities:AutoHaki()
            utilities:BringEnemies(v798)

            subFunction:Attack(v798, true)
          end
        elseif v792 <= v786 then
          local getDungeonIslands = gameData:GetDungeonIslands()

          if getDungeonIslands
            and localPlayer:DistanceFromCharacter(getDungeonIslands.Position) > 20 then
            tweenManager:topos(
              CFrame.new(getDungeonIslands.Position + Vector3.new(0, 10, 0)), true
            )

            task.wait(1)
          end
        end

        return
      end
    end, true)

    f110("AutoUnlockDifficulties", function()
      if map:FindFirstChild("Dungeon") then
        return
      end

      pcall(function()
        game.ReplicatedStorage.DungeonShared.DataRemote:InvokeServer(
          "TryUnlockDifficulty", "Simulation", "Hard"
        )
      end)

      pcall(function()
        game.ReplicatedStorage.DungeonShared.DataRemote:InvokeServer(
          "TryUnlockDifficulty", "Simulation", "Challenge"
        )
      end)

      pcall(function() net["RF/DungeonNPCNetworkFunction"]:InvokeServer("UnlockDifficulty") end)
      pcall(function() net["RF/DungeonNPCNetworkFunction"]:InvokeServer("UnlockNext") end)
      pcall(function() net["RF/DungeonNPCNetworkFunction"]:InvokeServer("Unlock") end)

      task.wait(5)
    end, true, true)

    f110("AutoBuyTrinkets", function()
      pcall(function() v5.Remotes.AccessoryInteract:InvokeServer("d") end)
      task.wait(1.5)
    end, true, true)

    f110("AutoFuseTrinkets", function()
      local v799 = {}

      local v800, v801 = pcall(function()
        return v29:RemoteFunction("GetAllItemValues"):InvokeServer()
      end)

      if v800 and v801 then
        for key87, value200 in next, v801, nil do
          if value200.Key == "AccessoryType" and value200.Value == "Trinket"
            or value200.Key == "Type" and value200.Value == "Trinket" then
            if value200.NetworkedUID then
              table.insert(v799, value200.NetworkedUID)
            end
          end
        end
      end

      if #v799 >= 3 then
        pcall(function()
          v5.Remotes.AccessoryInteract:InvokeServer("a", v799[1], v799[2], v799[3])
        end)
      end

      task.wait(2)
    end, true, true)

    f110("AutoRefineTrinkets", function()
      local v802 = {}

      local v803, v804 = pcall(function()
        return v29:RemoteFunction("GetAllItemValues"):InvokeServer()
      end)

      if v803 and v804 then
        for key88, value201 in next, v804, nil do
          if value201.Key == "AccessoryType" and value201.Value == "Trinket"
            or value201.Key == "Type" and value201.Value == "Trinket" then
            if value201.NetworkedUID then
              table.insert(v802, value201.NetworkedUID)
            end
          end
        end
      end

      if #v802 >= 1 then
        pcall(function() v5.Remotes.AccessoryInteract:InvokeServer("c", v802[1]) end)
      end

      task.wait(2)
    end, true, true)

    f110("AutoScrapTrinkets", function()
      local getPlayerTrinketUIDs = GetPlayerTrinketUIDs and GetPlayerTrinketUIDs() or {}
      local v805

      if #getPlayerTrinketUIDs > 3 then
        v805 = {}

        for i36 = 4, math.min(#getPlayerTrinketUIDs, 10) do
          table.insert(v805, getPlayerTrinketUIDs[i36])
        end

        if #v805 > 0 then
          pcall(function() v5.Remotes.AccessoryInteract:InvokeServer("b", v805) end)
        end
      end

      task.wait(3)
    end, true, true)

    f110("AutoOpenColorsTask", function()
      if localPlayer.Character and localPlayer.Character.PrimaryPart then
        for key89, value202 in next, {
          { pos = Vector3.new(-5415, 314, -2212), color = "Pure Red" },
          { pos = Vector3.new(-4972, 336, -3720), color = "Snow White" },
          { pos = Vector3.new(-5420, 1089, -2667), color = "Winter Sky" },
        }, nil do
          if localPlayer:DistanceFromCharacter(value202.pos) < 5 then
            v5.Modules.Net["RF/FruitCustomizerRF"]:InvokeServer({
              StorageName = value202.color,
              Type = "AuraSkin",
              Context = "Equip",
            })

            break
          end
        end
      end

      if not v19.AutoFarm and not v19.AutoFarmBones and not v19.AutoFarmPrince then
        local getPathButton = gameData:GetPathButton()

        if getPathButton then
          tweenManager:topos(getPathButton.CFrame)
        elseif not v19.AutoRipIndra then
          tweenManager:topos(CFrame.new(-5119, 315, -2964))
        end
      end
    end, v26)

    f110("AutoVolcanicEvent", function()
      local prehistoricIsland = map:FindFirstChild("PrehistoricIsland")
      local v806, position55, tool10

      if not prehistoricIsland then
        return
      else
        local core2 = prehistoricIsland:FindFirstChild("Core")

        if not core2 then
          return
        else
          local interiorLava = core2:FindFirstChild("InteriorLava")

          if interiorLava then
            local parent7 = interiorLava.Parent
            interiorLava:Destroy()

            if parent7 and parent7 ~= core2 then
              parent7:Destroy()
            end
          end

          local volcanoRocks = core2:FindFirstChild("VolcanoRocks")

          if volcanoRocks and prehistoricIsland then
            for index102, value203 in ipairs(prehistoricIsland:GetDescendants()) do
              local v807 = value203
              local v808 = string.lower(v807.Name)

              if v808:find("lava") or v808:find("beam") then
                pcall(function() v807:Destroy() end)
              end
            end
          end

          local activationPrompt = core2:FindFirstChild("ActivationPrompt")

          local proximityPrompt2 = activationPrompt

          proximityPrompt2 = activationPrompt
            and activationPrompt:FindFirstChildOfClass("ProximityPrompt")

          if proximityPrompt2 and proximityPrompt2.Enabled then
            if localPlayer:DistanceFromCharacter(activationPrompt.CFrame.Position) <= 50 then
              fireproximityprompt(activationPrompt.ProximityPrompt, math.huge)
            else
              tweenManager:topos(activationPrompt.CFrame)
            end

            return
          else
            if utilities:CheckMon("Lava Golem") then
              local lavaGolem = utilities:GetEnemies("Lava Golem")

              if lavaGolem then
                local humanoidRootPart53 = lavaGolem:FindFirstChild("HumanoidRootPart")
                local humanoid35 = lavaGolem:FindFirstChildOfClass("Humanoid")

                if humanoidRootPart53 then
                  humanoidRootPart53.Velocity = Vector3.zero
                  humanoidRootPart53.AssemblyLinearVelocity = Vector3.zero
                end

                if humanoid35 then
                  humanoid35.WalkSpeed = 0
                  humanoid35.JumpPower = 0
                end

                return subFunction:Attack(lavaGolem, true)
              end
            end

            if volcanoRocks then
              for key90, value204 in pairs(volcanoRocks:GetChildren()) do
                if value204:FindFirstChild("VFXLayer")
                  and value204.VFXLayer.At0.Glow.Enabled == true then
                  position55 = value204.VFXLayer.CFrame.Position

                  local findFirstChild24 = prehistoricIsland:FindFirstChild(
                    "Meshes/volcanoisland_Plane.005", true
                  )

                  local unit = findFirstChild24
                    and (position55 - findFirstChild24.Position).Unit

                  local v809 = position55 + unit * 30

                  if findFirstChild24 and (v809 - findFirstChild24.Position).Magnitude < 40 then
                    local v810 = math.atan(unit.Z, unit.X) + tick() * 0.5
                    v806 = position55 + Vector3.new(math.cos(v810) * 30, 5, math.sin(v810) * 30)
                  else
                    v806 = v809
                  end

                  tweenManager:topos(CFrame.new(v806), true)

                  if localPlayer:DistanceFromCharacter(position55) <= 150 then
                    if v19.ShootGunVolcano then
                      local selectGunVolcano = v19.SelectGunVolcano or "Skull Guitar"

                      if not localPlayer.Character:FindFirstChild(selectGunVolcano) then
                        local findFirstChild25 = localPlayer.Backpack:FindFirstChild(selectGunVolcano)

                        local skullGuitar2 = findFirstChild25

                        skullGuitar2 = findFirstChild25
                          or localPlayer.Backpack:FindFirstChild("Skull Guitar")

                        if skullGuitar2 and localPlayer.Character:FindFirstChild("Humanoid") then
                          localPlayer.Character.Humanoid:EquipTool(skullGuitar2)
                        else
                          commF:InvokeServer("LoadItem", selectGunVolcano)
                        end

                        task.wait(0.2)
                      end

                      utilities:EquipWeapon("Gun")
                      task.wait(0.15)
                      customShoot(position55)
                      tool10 = localPlayer.Character:FindFirstChildOfClass("Tool")

                      if tool10 and tool10:FindFirstChild("RemoteEvent") then
                        pcall(function() tool10.RemoteEvent:FireServer("TAP", position55) end)
                      end
                    else
                      Aimbot = position55
                      f3()
                      Aimbot = nil
                    end
                  end

                  return
                end
              end
            end

            local prehistoricRelic = core2:FindFirstChild("PrehistoricRelic")

            if prehistoricRelic and prehistoricRelic:FindFirstChild("Shield") then
              tweenManager:topos(prehistoricRelic.Shield.CFrame + Vector3.new(0, 3, 0), true)
              return
            end

            return
          end
        end
      end
    end, v26)

    f110("AutoWhiteBelt", function()
      if localPlayer:DistanceFromCharacter(Vector3.new(5867, 1208, 870)) <= 5 then
        net["RF/InteractDragonQuest"]:InvokeServer({
          NPC = "Dojo Trainer",
          Command = "ClaimQuest",
        })

        task.wait(1)

        net["RF/InteractDragonQuest"]:InvokeServer({
          NPC = "Dojo Trainer",
          Command = "RequestQuest",
        })

        task.wait(1)
      else
        tweenManager:topos(CFrame.new(5867, 1208, 870))
      end

      local getEnemies19 = utilities:GetEnemies(CheckQuest()[2])

      if getEnemies19 then
        return subFunction:Attack(getEnemies19)
      end

      utilities:MobsNextSpawn(CheckQuest()[2])
    end, v26)

    f110("AutoPurpleBelt", function()
      if localPlayer:DistanceFromCharacter(Vector3.new(5867, 1208, 870)) <= 5 then
        net["RF/InteractDragonQuest"]:InvokeServer({
          NPC = "Dojo Trainer",
          Command = "ClaimQuest",
        })

        task.wait(1)

        net["RF/InteractDragonQuest"]:InvokeServer({
          NPC = "Dojo Trainer",
          Command = "RequestQuest",
        })

        task.wait(1)
      else
        tweenManager:topos(CFrame.new(5867, 1208, 870))
      end

      functions.AutoTaskEliteHunter.Call()
    end, v26)

    f110("AutoCollectBones", function()
      if localPlayer:GetAttribute("PrehistoricIslandParticipant") then
        if v4:FindFirstChild("DinoBone") then
          for key91, value205 in pairs(v4:GetChildren()) do
            if value205.Name == "DinoBone" then
              tweenManager:topos(value205.CFrame)
            end
          end
        end
      end
    end, v26)

    f110("AutoCollectEgg", function()
      local prehistoricIsland2 = map:FindFirstChild("PrehistoricIsland")

      if prehistoricIsland2 then
        local core3 = prehistoricIsland2:FindFirstChild("Core")

        if core3 then
          core3 = core3:FindFirstChild("SpawnedDragonEggs")
        end

        if core3 and #core3:GetChildren() > 0 then
          local v811, v812 = core3:GetChildren()

          for key92, value206 in next, v811, v812 do
            if value206.Name == "DragonEgg" then
              local molten = value206:FindFirstChild("Molten")

              if molten and molten:FindFirstChild("ProximityPrompt") then
                local proximityPrompt3 = molten.ProximityPrompt

                if proximityPrompt3.Enabled then
                  tweenManager:topos(molten.CFrame)
                  fireproximityprompt(proximityPrompt3)
                end
              end
            end
          end
        end
      end
    end, v26)

    local v813 = 1
    local v814 = tick()

    f110("AutoQuestBlaze", function()
      local emberTemplate = v4:FindFirstChild("EmberTemplate")

      if emberTemplate and emberTemplate:FindFirstChild("Part")
        and emberTemplate.Part.Position.Y > 10 then
        tweenManager:topos(emberTemplate.Part.CFrame * CFrame.new(0, 3, 0), true)
        return
      end

      if not gameData.CurrentQuest or gameData:TaskDone() then
        local v815, mobs, progress, questType = gameData:CheckQuestStatus()

        gameData.CurrentQuest = v815 and {
          HasQuest = v815,
          Mobs = mobs,
          Progress = progress,
          QuestType = questType,
        } or nil
      end

      if not gameData.CurrentQuest then
        tweenManager:topos(CFrame.new(5864, 1209, 808))
        return
      end

      if gameData.CurrentQuest.QuestType == 1
        and (gameData.CurrentQuest.Mobs == "Hydra Enforcer"
          or gameData.CurrentQuest.Mobs == "Venomous Assailant") then
        local getEnemies20 = utilities:GetEnemies(gameData.CurrentQuest.Mobs)

        if getEnemies20 then
          return subFunction:Attack(getEnemies20, true)
        end

        utilities:MobsNextSpawn(gameData.CurrentQuest.Mobs)
        return
      elseif gameData.CurrentQuest.QuestType == 2 then
        local v816 = {
          Vector3.new(5326, 1000.5, 441.52), Vector3.new(5344.88, 1000.5, 359.94),
          Vector3.new(5260.73, 1000.5, 345.5), Vector3.new(5237.99, 1000.5, 429.64),
        }

        if tick() - v814 >= 2 then
          v813 = v813 % #v816 + 1
          v814 = tick()
        end

        local v817 = v816[v813]
        local character36 = localPlayer.Character

        local humanoidRootPart54 = character36

        humanoidRootPart54 = character36
          and localPlayer.Character:FindFirstChild("HumanoidRootPart")

        if not humanoidRootPart54 then
          return
        end

        tweenManager:topos(CFrame.new(v817 + Vector3.new(0, 15, 0)), true)

        if (humanoidRootPart54.Position - v817).Magnitude > 150 then
          return
        else
          local selectGunBlaze = v19.SelectGunBlaze or "Skull Guitar"

          if not localPlayer.Character:FindFirstChild(selectGunBlaze)
            and not (localPlayer.Character:FindFirstChildOfClass("Tool")
              and localPlayer.Character:FindFirstChildOfClass("Tool").ToolTip == "Gun") then
            if localPlayer.Backpack:FindFirstChild("Skull Guitar")
              and localPlayer.Character:FindFirstChild("Humanoid") then
              localPlayer.Character.Humanoid:EquipTool(toolInBp)
            else
              commF:InvokeServer("LoadItem", selectGunBlaze)
            end

            task.wait(0.05)
          end

          utilities:EquipWeapon("Gun")
          customShoot(v817)

          if not v19.ShootGunBlaze then
            Aimbot = v817
            f3()
            Aimbot = nil
          end

          return
        end
      else
        return
      end
    end, v26)

    f110("AutoCollectFireFlowers", function()
      local fireFlowers = v4:FindFirstChild("FireFlowers")
      local forestPirate

      if fireFlowers then
        local getChildren15 = fireFlowers:GetChildren()

        for i37 = 1, #getChildren15 do
          local v818 = getChildren15[i37]
          local model = v818:IsA("Model")

          if model then
            model = v818.PrimaryPart or v818:FindFirstChildOfClass("MeshPart")
          end

          if model then
            if localPlayer:DistanceFromCharacter(model.Position) > 3 then
              tweenManager:topos(model.CFrame)
            else
              fireproximityprompt(v818.ProximityPrompt, math.huge)
              task.wait(0.5)
            end

            return
          end
        end

        forestPirate = utilities:GetEnemies("Forest Pirate")

        if forestPirate then
          return subFunction:Attack(forestPirate, true)
        end

        utilities:MobsNextSpawn("Forest Pirate")
        return
      end

      forestPirate = utilities:GetEnemies("Forest Pirate")

      if forestPirate then
        return subFunction:Attack(forestPirate, true)
      end

      utilities:MobsNextSpawn("Forest Pirate")
    end, v26)

    f110("AutoTrainGear", function()
      if localPlayer.Character:FindFirstChild("RaceEnergy")
        and localPlayer.Character:FindFirstChild("RaceTransformed") then
        if localPlayer.Character.RaceEnergy.Value >= 1
          and not localPlayer.Character.RaceTransformed.Value then
          localPlayer.Backpack.Awakening.RemoteFunction:InvokeServer({ [1] = true })
        end
      end

      if data.Race.Value == "Draco" then
        commF:InvokeServer("UpgradeRace", "Buy", 2)
      else
        commF:InvokeServer("UpgradeRace", "Buy")
      end

      if v19.TrainMethod == "Bones" then
        local getEnemies21 = utilities:GetEnemies(v33.DataList.BonesList)

        if getEnemies21 then
          return subFunction:Attack(getEnemies21, true)
        end

        utilities:MobsNextSpawn("Reborn Skeleton")
        return
      elseif v19.TrainMethod == "Cakes" then
        local getEnemies22 = utilities:GetEnemies(v33.DataList.CakesList)

        if getEnemies22 then
          return subFunction:Attack(getEnemies22, true)
        end

        utilities:MobsNextSpawn("Baking Staff")
        return
      else
        return
      end
    end, v26)

    f110("TweenMGear", function()
      local mysticIsland = map:FindFirstChild("MysticIsland")

      if mysticIsland then
        local v819, v820 = mysticIsland:GetChildren()

        for key93, value207 in next, v819, v820 do
          if value207.Name == "Part" and value207:IsA("MeshPart") then
            tweenManager:topos(value207.CFrame)
          end
        end
      end
    end, v26)

    f110("AutoGetGhoulRace", function()
      if localPlayer.Data.Race.Value == "Ghoul" then
        return nil
      elseif utilities:CheckInventory("Material", "Ectoplasm") < 100 then
        local getEnemies23 = utilities:GetEnemies({
          "Ship Deckhand", "Ship Engineer", "Ship Steward", "Ship Officer",
        })

        if getEnemies23 then
          return subFunction:Attack(getEnemies23, true)
        end

        return utilities:MobsNextSpawn("Ship Deckhand")
      elseif utilities:CheckToolName("Hellfire Torch") then
        if localPlayer:DistanceFromCharacter(Vector3.new(921, 125, 33453)) < 10 then
          commF:InvokeServer("Ectoplasm", "BuyCheck", 4)
          task.wait()
          commF:InvokeServer("Ectoplasm", "Buy", 4)
        else
          tweenManager:topos(CFrame.new(921, 125, 33453))
        end

        return
      elseif utilities:CheckMon("Cursed Captain") then
        local cursedCaptain2 = utilities:GetEnemies("Cursed Captain")

        if cursedCaptain2 then
          return subFunction:Attack(cursedCaptain2)
        end

        return utilities:MobsNextSpawn("Cursed Captain")
      else
        f6("CursedCaptain", 5)
        return
      end
    end, v25)

    f110("AutoGetCyborgRace", function()
      if data.Race.Value == "Cyborg" and commF:InvokeServer("CyborgTrainer", "Check") == 2 then
        return nil
      end

      local v821

      if commF:InvokeServer("CyborgTrainer", "Check") == 1
        or map.CircleIsland and map.CircleIsland:FindFirstChild("RaidSummon")
          and map.CircleIsland.RaidSummon:FindFirstChild("Button")
          and map.CircleIsland.RaidSummon.Button:FindFirstChild("Main")
          and not map.CircleIsland.RaidSummon.Button.Main.CanCollide then
        if fragments.Value >= 2500 then
          commF:InvokeServer("CyborgTrainer", "Buy")
        else
          v33:SendNotify("Auto Cyborg Race", "Not enough fragments to buy Cyborg", 10)
        end

        return
      else
        v821 = "Quantum Onyx Hub/" .. localPlayer.Name .. "CyborgRace.json"

        if isfolder and makefolder and not isfolder("Quantum Onyx Hub") then
          makefolder("Quantum Onyx Hub")
        end

        local v822 = nil

        if isfile and isfile(v821) then
          local v823, v824 = pcall(readfile, v821)

          if v823 and v824 and v824 ~= "" then
            v822 = v824
          end
        end

        local function f116(p248)
          if writefile then
            pcall(writefile, v821, tostring(p248))
          end
        end

        local vector15 = Vector3.new(-5544, 229, -5938)

        if utilities:CheckToolName("Core Brain") then
          f116("Unlocked")

          local coreBrain = localPlayer.Backpack:FindFirstChild("Core Brain")
            or localPlayer.Character and localPlayer.Character:FindFirstChild("Core Brain")

          if coreBrain and coreBrain.Parent == localPlayer.Backpack
            and localPlayer.Character:FindFirstChildOfClass("Humanoid") then
            localPlayer.Character.Humanoid:EquipTool(coreBrain)
          end

          tweenManager:topos(CFrame.new(vector15))

          if (waitForChild2.Position - vector15).Magnitude <= 8 then
            fireclickdetector(map.CircleIsland.RaidSummon.Button.Main.ClickDetector)
            task.wait(0.5)
          end

          return
        end

        if v822 == nil and not utilities:CheckToolName("Fist of Darkness") then
          tweenManager:topos(CFrame.new(vector15))

          if (waitForChild2.Position - vector15).Magnitude <= 8 then
            fireclickdetector(map.CircleIsland.RaidSummon.Button.Main.ClickDetector)
            task.wait(0.5)

            if localPlayer.PlayerGui:FindFirstChild("Notifications") then
              for index103, value208 in ipairs(localPlayer.PlayerGui.Notifications:GetChildren()) do
                if value208:IsA("TextLabel") and value208.Text and value208.Text ~= "" then
                  local v825 = string.lower(value208.Text)

                  if v825:find("core brain") or v825:find("supply a <core brain>")
                    or v825:find("has been processed") then
                    f116("Unlocked")
                    break
                  elseif v825:find("microchip not found") then
                    f116("Chest")
                    break
                  end
                end
              end
            end
          end

          return
        else
          if localPlayer.PlayerGui:FindFirstChild("Notifications") then
            for index104, value209 in ipairs(localPlayer.PlayerGui.Notifications:GetChildren()) do
              if value209:IsA("TextLabel") and value209.Text and value209.Text ~= "" then
                local v826 = string.lower(value209.Text)

                if v826:find("core brain") or v826:find("supply a <core brain>")
                  or v826:find("has been processed") then
                  f116("Unlocked")
                  v822 = "Unlocked"
                end
              end
            end
          end

          local circleIsland = map.CircleIsland

          local secretLabDoors = circleIsland
          secretLabDoors = circleIsland and map.CircleIsland:FindFirstChild("SecretLabDoors")

          if not (v822 == "Unlocked"
            or secretLabDoors and secretLabDoors:FindFirstChild("colormodel")
              and secretLabDoors.colormodel.Color.G > secretLabDoors.colormodel.Color.R) then
            if not utilities:CheckToolName("Fist of Darkness") then
              functions.AutoChest.Call()
            else
              local fistOfDarkness = localPlayer.Backpack:FindFirstChild("Fist of Darkness")
                or localPlayer.Character
                  and localPlayer.Character:FindFirstChild("Fist of Darkness")

              if fistOfDarkness and fistOfDarkness.Parent == localPlayer.Backpack
                and localPlayer.Character:FindFirstChildOfClass("Humanoid") then
                localPlayer.Character.Humanoid:EquipTool(fistOfDarkness)
              end

              tweenManager:topos(CFrame.new(vector15))

              if (waitForChild2.Position - vector15).Magnitude <= 8 then
                fireclickdetector(map.CircleIsland.RaidSummon.Button.Main.ClickDetector)
                f116("Unlocked")
                task.wait(0.5)
              end
            end

            return
          elseif utilities:CheckMon("Order") then
            local order = utilities:GetEnemies("Order")

            if order then
              return subFunction:Attack(order)
            end

            tweenManager:topos(CFrame.new(-6300, 16, -4997))
            return
          elseif utilities:CheckToolName("Microchip") then
            local microchip = localPlayer.Backpack:FindFirstChild("Microchip")
              or localPlayer.Character and localPlayer.Character:FindFirstChild("Microchip")

            if microchip and microchip.Parent == localPlayer.Backpack
              and localPlayer.Character:FindFirstChildOfClass("Humanoid") then
              localPlayer.Character.Humanoid:EquipTool(microchip)
            end

            tweenManager:topos(CFrame.new(vector15))

            if (waitForChild2.Position - vector15).Magnitude <= 8 then
              fireclickdetector(map.CircleIsland.RaidSummon.Button.Main.ClickDetector)
              task.wait(1)
            end
          elseif fragments.Value >= 1000 then
            commF:InvokeServer("BlackbeardReward", "Microchip", "2")
            task.wait(1)
          else
            v33:SendNotify("Auto Cyborg Race", "Not enough fragments to buy Microchip", 10)
          end
        end
      end
    end, v25)

    f110("AutoLawRaid", function()
      if utilities:CheckMon("Order") then
        local order2 = utilities:GetEnemies("Order")

        if order2 then
          subFunction:Attack(order2)
        else
          tweenManager:topos(CFrame.new(-6300, 16, -4997))
        end

        return
      end

      if not utilities:CheckMon("Order") and not utilities:CheckToolName("Microchip") then
        commF:InvokeServer("BlackbeardReward", "Microchip", "2")
      elseif not utilities:CheckMon("Order") and utilities:CheckToolName("Microchip") then
        local vector16 = Vector3.new(-5544, 229, -5938)
        tweenManager:topos(CFrame.new(vector16))

        if (waitForChild2.Position - vector16).Magnitude <= 5 then
          fireclickdetector(map.CircleIsland.RaidSummon.Button.Main.ClickDetector)
        end
      elseif not commF:InvokeServer("BlackbeardReward", "Microchip", "1") then
        v33:SendNotify("Auto Law Raid", "Not Enough Frags", 8)
      end
    end, v25)

    f110("AutoBuyMelee", function()
      local v827 = v35 and v35[v19.SelectMelee]

      if not v827 then
        return
      else
        local v828 = v24 and 1 or v25 and 2 or v26 and 3 or 1

        if v827.Sea and v827.Sea ~= v828 then
          return
        else
          local humanoidRootPart55 = localPlayer.Character
            and localPlayer.Character:FindFirstChild("HumanoidRootPart")

          if not humanoidRootPart55 then
            return
          else
            local v829 = DetectNpc(v827.Npc)

            if not v829 then
              return
            else
              local humanoidRootPart56 = v829:FindFirstChild("HumanoidRootPart")
                or v829.PrimaryPart or v829:FindFirstChildWhichIsA("BasePart")

              if not humanoidRootPart56 then
                return
              end

              if (humanoidRootPart55.Position - humanoidRootPart56.Position).Magnitude > 15 then
                tweenManager:topos(humanoidRootPart56.CFrame * CFrame.new(0, 0, -4), true)
              else
                local remote = v827.Remote

                if remote then
                  if typeof(remote[1]) == "table" then
                    for key94, value210 in next, remote, nil do
                      commF:InvokeServer(unpack(value210))
                      task.wait(0.15)
                    end
                  else
                    commF:InvokeServer(unpack(remote))
                  end
                end

                task.wait(0.5)
              end

              return
            end
          end
        end
      end
    end, true)

    f110("Auto_Fishing", function()
      local selectedRod = v19.SelectedRod
      local fishingRequest

      if not selectedRod then
        return
      else
        if not utilities:CheckToolName(selectedRod) then
          pcall(function()
            net:FindFirstChild("RF/JobsRemoteFunction"):InvokeServer(
              "FishingNPC", "FirstTimeFreeRod"
            )
          end)

          commF:InvokeServer("LoadItem", selectedRod, { "Gear" })
        end

        if v19.AutoCraftBait and v19.SelectedBait then
          local v830 = false

          local v831, v832 = pcall(function()
            return v29:RemoteFunction("GetAllItemValues"):InvokeServer()
          end)

          if v831 and v832 then
            local v833 = {}

            for key95, value211 in next, v832, nil do
              local v834 = tostring(value211.ItemId) .. "_" .. tostring(value211.NetworkedUID)
              v833[v834] = v833[v834] or { ItemId = value211.ItemId, Attributes = {} }

              if value211.Value ~= nil then
                v833[v834].Attributes[value211.Key] = value211.Value
              end
            end

            for key96, value212 in next, v833, nil do
              local v835 = value212
              local v836 = nil
              local v837, v838 = pcall(function() return v30.match(v835.ItemId) end)

              if v837 and v838 and v838:isOk() then
                local unwrap4 = v838:unwrap()

                if unwrap4 and unwrap4.Index and unwrap4.Index.DebugLabel then
                  v836 = tostring(unwrap4.Index.DebugLabel)
                end
              end

              local s4 = v836
              s4 = v836 and (v836:match("^(.-)%s*%[") or v836)

              local attributes3 = v835.Attributes

              if s4 == v19.SelectedBait and attributes3.IsOwned == true
                and (attributes3.Quantity or 0) > 0 then
                commF:InvokeServer("LoadItem", s4, { "Usables" })
                v830 = true
                task.wait(0.5)
                break
              end
            end
          end

          if not v830 then
            if net["RF/Craft"] and net["RF/Craft"]:InvokeServer("Check", v19.SelectedBait) then
              net["RF/Craft"]:InvokeServer("Craft", v19.SelectedBait, 1, {})
              task.wait(1.5)
              commF:InvokeServer("LoadItem", v19.SelectedBait, { "Usables" })
              task.wait(0.5)
            end
          end
        end

        utilities:EquipTool(selectedRod)
        local character37 = localPlayer.Character or character

        local humanoidRootPart57 = character37
        humanoidRootPart57 = character37 and character37:FindFirstChild("HumanoidRootPart")

        if not humanoidRootPart57 then
          return
        else
          local v839 = v28(humanoidRootPart57.Position)
          local v840 = require(v5.FishReplicated.FishingClient.Config)
          local maxLaunchDistance = v840 and v840.Rod and v840.Rod.MaxLaunchDistance or 150
          local lookVector = humanoidRootPart57.CFrame.LookVector
          local position56 = character37:FindFirstChild("Head") and character37.Head.Position

          local v841 = position56
          v841 = position56 or humanoidRootPart57.Position + Vector3.new(0, 2, 0)

          local v842, v843 = v4:FindPartOnRayWithIgnoreList(Ray.new(v841, lookVector * maxLaunchDistance
            * 0.99751243781095), {
            character37, v4.Characters, v4.Enemies,
          })

          local v844, v845 = v4:FindPartOnRayWithIgnoreList(Ray.new((v843
              or humanoidRootPart57.Position + lookVector * 40)
            + Vector3.new(0, 3, 0), Vector3.new(0, -500, 0)), {
            character37, v4.Characters, v4.Enemies,
          })

          v19.LastCastLocation = Vector3.new(v843 and v843.X
            or (humanoidRootPart57.Position + lookVector * 40).X, math.max(v845 and v845.Y or v839, v839), v843 and v843.Z
            or (humanoidRootPart57.Position + lookVector * 40).Z)

          local findFirstChild26 = character37:FindFirstChild(selectedRod)

          if not findFirstChild26 then
            return
          else
            local serverState = findFirstChild26:GetAttribute("ServerState")
            local state2 = findFirstChild26:GetAttribute("State")
            local fishingReeling = localPlayer.PlayerGui:FindFirstChild("Fishing_Reeling")
            local v846 = serverState == "Biting" or state2 == "Biting"

            if fishingReeling and fishingReeling.Enabled then
              local minigame = fishingReeling:FindFirstChild("Minigame")

              local container5 = minigame
              container5 = minigame and minigame:FindFirstChild("Container")

              local reelZone = container5
              reelZone = container5 and container5:FindFirstChild("ReelZone")

              local fish = container5
              fish = container5 and container5:FindFirstChild("Fish")

              local treasure = container5
              treasure = container5 and container5:FindFirstChild("Treasure")

              local visible = v19.AutoGetChest and treasure and treasure.Visible and treasure
                or fish

              if reelZone and visible and visible.Visible then
                local v847 = visible.Position.X.Scale + visible.Size.X.Scale * 0.5
                  - (reelZone.Position.X.Scale + reelZone.Size.X.Scale * 0.5)

                if v847 > 0.03 then
                  v9:SendMouseButtonEvent(0, 0, 0, true, game, 1)
                elseif v847 < -0.03 then
                  v9:SendMouseButtonEvent(0, 0, 0, false, game, 1)
                else
                  v9:SendMouseButtonEvent(0, 0, 0, true, game, 1)
                  task.wait(0.02)
                  v9:SendMouseButtonEvent(0, 0, 0, false, game, 1)
                end
              else
                v9:SendMouseButtonEvent(0, 0, 0, true, game, 1)
                task.wait(0.05)
                v9:SendMouseButtonEvent(0, 0, 0, false, game, 1)
              end

              fishingRequest = v5:FindFirstChild("FishReplicated")
                and v5.FishReplicated:FindFirstChild("FishingRequest")

              if fishingRequest then
                if v19.AutoGetChest then
                  pcall(function() fishingRequest:InvokeServer("Catch", 1, 1) end)
                else
                  pcall(function() fishingRequest:InvokeServer("Catch", 1) end)
                end
              end
            elseif v846 then
              v9:SendMouseButtonEvent(0, 0, 0, true, game, 1)
              task.wait(0.08)
              v9:SendMouseButtonEvent(0, 0, 0, false, game, 1)
              task.wait(0.15)
            elseif state2 == "ReeledIn" or serverState == "ReeledIn" or not serverState
              or serverState == "Waiting" then
              v9:SendMouseButtonEvent(0, 0, 0, true, game, 1)
              local v848 = tick()

              repeat
                task.wait(0.015)

                local fishingCastMeter = localPlayer.Character
                    and localPlayer.Character:FindFirstChild("Fishing_Cast Meter")
                  or v4:FindFirstChild("Fishing_Cast Meter")

                local bar = fishingCastMeter and fishingCastMeter:FindFirstChild("CastMeter")
                  and fishingCastMeter.CastMeter:FindFirstChild("Bar")

                local frame4 = bar
                frame4 = bar and bar:FindFirstChild("Frame")

                if frame4 and frame4.Size.Y.Scale >= 0.95 then
                  break
                end

                goto L12741245
              until tick() - v848 >= 1.2

              v9:SendMouseButtonEvent(0, 0, 0, false, game, 1)
              task.wait(0.3)
            end

            return
          end
        end
      end
    end, true)

    local v849 = 0

    f110("AutoSlap", function()
      local fishSlapMinigame = localPlayer.PlayerGui:FindFirstChild("FishSlapMinigame")

      if fishSlapMinigame and fishSlapMinigame.Enabled then
        local bar2 = fishSlapMinigame:FindFirstChild("Bar")
        local greenZone = bar2 and bar2:FindFirstChild("GreenZone")
        local v850 = bar2 and bar2:FindFirstChild("Tick")
        local v851 = greenZone
        local slapButton = fishSlapMinigame:FindFirstChild("SlapButton")

        if greenZone then
          v851 = v850 and slapButton and tick() - v849 >= 0.1
        end

        if v851 then
          if math.abs(v850.AbsolutePosition.Y + v850.AbsoluteSize.Y * 0.5
              - (greenZone.AbsolutePosition.Y + greenZone.AbsoluteSize.Y * 0.5))
            <= greenZone.AbsoluteSize.Y * 0.45 then
            v849 = tick()

            if firesignal then
              firesignal(slapButton.Activated)
            end
          end
        end
      end
    end, true)

    f110("AutoMasterySwords", function()
      local v852, v853 = pcall(function()
        return v29:RemoteFunction("GetAllItemValues"):InvokeServer()
      end)

      if not v852 or not v853 then
        return
      else
        local v854 = {}

        for key97, value213 in next, v853, nil do
          local v855 = tostring(value213.ItemId) .. "_" .. tostring(value213.NetworkedUID)
          v854[v855] = v854[v855] or { ItemId = value213.ItemId, Attributes = {} }

          if value213.Value ~= nil then
            v854[v855].Attributes[value213.Key] = value213.Value
          end
        end

        local v856 = {}

        for key98, value214 in next, v854, nil do
          local v857 = value214
          local attributes4 = v857.Attributes

          if attributes4.IsOwned == true and attributes4.Mastery ~= nil then
            local v858, v859 = pcall(function() return v30.match(v857.ItemId) end)

            if v858 and v859 and v859:isOk() then
              local v860 = tostring(v859:unwrap().Index.DebugLabel)
              local s5 = v860:match("^(.-)%s*%[") or v860
              local v861 = swordData[s5]

              if v861 then
                table.insert(v856, {
                  Name = s5,
                  Mastery = attributes4.Mastery,
                  Order = v861.Order,
                })
              end
            end
          end
        end

        table.sort(v856, function(p249, p250)
          if p249.Order == p250.Order then
            return p249.Mastery < p250.Mastery
          end

          return p249.Order < p250.Order
        end)

        for key99, value215 in next, v856, nil do
          if utilities:CheckToolName(value215.Name) then
            if value215.Mastery < (v19.SelectSwordMastery or 600) then
              return
            end
          end
        end

        for key100, value216 in next, v856, nil do
          if value216.Mastery < (v19.SelectSwordMastery or 600) then
            if not utilities:CheckToolName(value216.Name) then
              commF:InvokeServer("LoadItem", value216.Name)
              task.wait(0.5)
            end

            return
          end
        end

        return
      end
    end, true, true)

    local v862 = {
      CFrame.new(-4602, 16, -2881), CFrame.new(-6126, 16, -2250), CFrame.new(3911, 7, -2582),
      CFrame.new(-426, 11, 5301),
    }

    f110("GetRainbowHaki", function()
      for index105, value217 in ipairs({
        "Stone", "Hydra Leader", "Kilo Admiral", "Captain Elephant", "Beautiful Pirate",
      }) do
        if VerifyQuest(value217) then
          local getEnemies24 = utilities:GetEnemies(value217)

          if getEnemies24 then
            return subFunction:Attack(getEnemies24)
          end

          utilities:MobsNextSpawn(value217)
          return
        end
      end

      if localPlayer:DistanceFromCharacter(HornedQuest.Position) <= 10 then
        commF:InvokeServer("HornedMan", "Bet")
      else
        tweenManager:topos(HornedQuest)
      end
    end, v26)

    f110("CompleteCitizenQuest", function()
      local citizenQuestProgress = commF:InvokeServer("CitizenQuestProgress")

      if citizenQuestProgress then
        local killedBandits = citizenQuestProgress.KilledBandits
        local killedBoss = citizenQuestProgress.KilledBoss

        if citizenQuestProgress.FoundTreasure then
          return nil
        elseif killedBoss then
          tweenManager:topos(CFrame.new(-12512, 340, -9872))
          return true
        elseif not killedBandits then
          local forestPirate2 = VerifyQuest("Forest Pirate")

          if forestPirate2 then
            forestPirate2 = VerifyQuest("50")
          end

          if forestPirate2 then
            local forestPirate3 = utilities:GetEnemies("Forest Pirate")

            if forestPirate3 then
              return subFunction:Attack(forestPirate3, true)
            end

            tweenManager:topos(CFrame.new(-13497, 391, -7909))
            return
          end

          if localPlayer:DistanceFromCharacter(Vector3.new(-12445, 332, -7676)) <= 8 then
            commF:InvokeServer("StartQuest", "CitizenQuest", 1)
          else
            tweenManager:topos(CFrame.new(-12445, 332, -7676))
          end

          return
        else
          local captainElephant = utilities:GetEnemies("Captain Elephant")

          if VerifyQuest("Captain Elephant") then
            if captainElephant then
              return subFunction:Attack(captainElephant)
            end

            tweenManager:topos(CFrame.new(-13382, 367, -8539))
            return
          end

          if localPlayer:DistanceFromCharacter(Vector3.new(-12445, 332, -7676)) <= 8 then
            commF:InvokeServer("CitizenQuestProgress", "Citizen")
          else
            tweenManager:topos(CFrame.new(-12445, 332, -7676))
          end

          return
        end
      else
        return
      end
    end, v26)

    f110("AutoKenV2", function()
      if not commF:InvokeServer("CitizenQuestProgress").FoundTreasure then
        functions.CompleteCitizenQuest.Call()
      end

      if not utilities:CheckToolName("Fruit Bowl") then
        if not utilities:CheckToolName("Apple") then
          for key101, value218 in pairs(v4:GetChildren()) do
            if value218.Name == "Apple" then
              tweenManager:topos(CFrame.new(value218.Handle.Position))
              task.wait()
            end
          end
        elseif not utilities:CheckToolName("Banana") then
          for key102, value219 in pairs(v4:GetChildren()) do
            if value219.Name == "Banana" then
              tweenManager:topos(CFrame.new(value219.Handle.Position))
              task.wait()
            end
          end
        elseif not utilities:CheckToolName("Pineapple") then
          for key103, value220 in pairs(v4:GetChildren()) do
            if value220.Name == "Pineapple" then
              tweenManager:topos(CFrame.new(value220.Handle.Position))
            end
          end
        end

        if utilities:CheckToolName("Banana") and utilities:CheckToolName("Apple")
          and utilities:CheckToolName("Pineapple") then
          tweenManager:topos(CFrame.new(-12445, 332, -7673))
          commF:InvokeServer("CitizenQuestProgress", "Citizen")
        end
      end

      if utilities:CheckToolName("Fruit Bowl") then
        tweenManager:topos(CFrame.new(-10920, 624, -10267))
        task.wait(0.5)
        commF:InvokeServer("KenTalk2", "Start")
        task.wait(0.1)
        commF:InvokeServer("KenTalk2", "Buy")
      end
    end, v26)

    f110("AutoDeathStep", function()
      if utilities:CheckToolName("Death Step") then
        return
      else
        local blackLeg = utilities:CheckToolName("Black Leg")

        if not blackLeg or blackLeg.Level.Value < 400 then
          v19.SelectMelee = "Black Leg"
          functions.AutoBuyMelee.Call()

          if blackLeg and blackLeg.Level.Value < 400 then
            local getEnemies25 = utilities:GetEnemies({ "Arctic Warrior", "Snow Lurker" })

            if getEnemies25 then
              return subFunction:Attack(getEnemies25)
            end

            utilities:MobsNextSpawn("Arctic Warrior")
            return
          end

          return
        end

        v19.SelectMelee = "Death Step"
        functions.AutoBuyMelee.Call()

        if v4.Map.IceCastle.Hall.LibraryDoor.PhoeyuDoor.Transparency == 0 then
          if utilities:CheckToolName("Library Key") then
            tweenManager:topos(CFrame.new(6371, 297, -6841))
            task.wait(0.3)
            commF:InvokeServer("BuyDeathStep")
            return
          else
            local awakenedIceAdmiral = utilities:GetEnemies("Awakened Ice Admiral")

            if awakenedIceAdmiral then
              return subFunction:Attack(awakenedIceAdmiral)
            end

            tweenManager:topos(CFrame.new(5669, 29, -6483))
            return
          end
        else
          return
        end
      end
    end, v25)

    f110("AutoSharkmanKarate", function()
      if utilities:CheckToolName("Sharkman Karate") then
        return
      else
        local fishmanKarate = utilities:CheckToolName("Fishman Karate")

        if not fishmanKarate or fishmanKarate.Level.Value < 400 then
          v19.SelectMelee = "Fishman Karate"
          functions.AutoBuyMelee.Call()

          if fishmanKarate and fishmanKarate.Level.Value < 400 then
            local waterFighter = utilities:GetEnemies("Water Fighter")

            if waterFighter then
              return subFunction:Attack(waterFighter)
            end

            utilities:MobsNextSpawn("Water Fighter")
            return
          end

          return
        else
          local buySharkmanKarate = commF:InvokeServer("BuySharkmanKarate")

          if type(buySharkmanKarate) == "string" and buySharkmanKarate:find("keys") then
            if utilities:CheckToolName("Water Key") then
              tweenManager:topos(CFrame.new(-2605, 239, -10315))
              task.wait(0.3)
              commF:InvokeServer("BuySharkmanKarate")
              return
            else
              local tideKeeper = utilities:GetEnemies("Tide Keeper")

              if tideKeeper then
                return subFunction:Attack(tideKeeper)
              end

              tweenManager:topos(CFrame.new(-3054, 237, -10145))
              return
            end
          else
            v19.SelectMelee = "Sharkman Karate"
            functions.AutoBuyMelee.Call()
            return
          end
        end
      end
    end, v25)

    f110("AutoElectricClaw", function()
      if utilities:CheckToolName("Electric Claw") then
        return
      else
        local electro = utilities:CheckToolName("Electro")

        if not electro or electro.Level.Value < 400 then
          v19.SelectMelee = "Electro"
          functions.AutoBuyMelee.Call()

          if electro and electro.Level.Value < 400 then
            local fishmanRaider = utilities:GetEnemies("Fishman Raider")

            if fishmanRaider then
              return subFunction:Attack(fishmanRaider)
            end

            utilities:MobsNextSpawn("Fishman Raider")
            return
          end

          return
        end

        if commF:InvokeServer("BuyElectricClaw", "Start") == nil then
          tweenManager:topos(CFrame.new(-12548, 337, -7481))
          task.wait(0.3)
        else
          v19.SelectMelee = "Electric Claw"
          functions.AutoBuyMelee.Call()
        end

        return
      end
    end, v26)

    f110("AutoDragonTalon", function()
      if utilities:CheckToolName("Dragon Talon") then
        return
      else
        local dragonClaw = utilities:CheckToolName("Dragon Claw")

        if not dragonClaw or dragonClaw.Level.Value < 400 then
          v19.SelectMelee = "Dragon Claw"
          functions.AutoBuyMelee.Call()

          if dragonClaw and dragonClaw.Level.Value < 400 then
            local rebornSkeleton = utilities:GetEnemies("Reborn Skeleton")

            if rebornSkeleton then
              return subFunction:Attack(rebornSkeleton, true)
            end

            utilities:MobsNextSpawn("Reborn Skeleton")
            return
          end

          return
        end

        if not utilities:CheckToolName("Fire Essence") then
          commF:InvokeServer("Bones", "Buy", 1, 1)
          task.wait(0.1)
        else
          v19.SelectMelee = "Dragon Talon"
          functions.AutoBuyMelee.Call()
        end

        return
      end
    end, v26)

    f110("Tweenfruit", function()
      local huge20 = math.huge
      local v863

      for index106, value221 in ipairs(v4:GetChildren()) do
        if value221:IsA("Model") and value221.Name:find("Fruit") and value221.Name ~= "Fruit1" then
          local handle4 = value221:FindFirstChild("Handle")

          local basePart10 = handle4
          basePart10 = handle4 or value221:FindFirstChildWhichIsA("BasePart")

          if basePart10 then
            local magnitude22 = waitForChild2
                and (basePart10.Position - waitForChild2.Position).Magnitude
              or 0

            if magnitude22 < huge20 then
              huge20 = magnitude22
              v863 = basePart10
            end
          end
        end
      end

      if v863 then
        tweenManager:topos(v863.CFrame)
      elseif v19.HopIfNoFruit then
        utilities:ServerHop()
      end
    end, true)

    local v864 = nil

    f110("AutoBerrySafe", function()
      local huge21 = math.huge
      local v865, v866, v867

      for index107, value222 in ipairs(v6:GetTagged("BerryBush")) do
        local parent8 = value222.Parent

        if parent8 and parent8:IsDescendantOf(v4) then
          local cframe20 = parent8:GetAttribute("CFrame")
            or parent8:IsA("Model") and parent8:GetPivot()

          for key104, value223 in pairs(value222:GetAttributes()) do
            if type(value223) == "string" and #value223 > 0
              and key104:sub(1, 12) == "_BerryCFrame" then
              local toWorldSpace2 = cframe20
              local getAttribute2 = parent8:GetAttribute(key104)

              if cframe20 then
                toWorldSpace2 = getAttribute2 and cframe20:ToWorldSpace(getAttribute2)
              end

              if toWorldSpace2 then
                local magnitude23 = waitForChild2
                    and (toWorldSpace2.Position - waitForChild2.Position).Magnitude
                  or 0

                if magnitude23 < huge21 then
                  huge21 = magnitude23
                  v865 = toWorldSpace2
                  v866 = parent8
                  v867 = key104
                end
              end
            end
          end
        end
      end

      if v866 and v867 and v865 then
        v864 = nil
        tweenManager:topos(v865)

        if waitForChild2 and (v865.Position - waitForChild2.Position).Magnitude <= 60 then
          spawn(function()
            local rfClaimBerry = net:FindFirstChild("RF/ClaimBerry")

            if rfClaimBerry then
              rfClaimBerry:InvokeServer(v866.Name, v867)
            end
          end)
        end
      elseif v19.HopIfNoBerries then
        if not v864 then
          v864 = tick()
        elseif tick() - v864 >= 5 then
          local v868 = v19 and tonumber(v19.HopDelay) or 10

          if v33 and v33.SendNotify then
            v33:SendNotify("Berry Farm", "No Berries found in server. Hopping in "
              .. tostring(math.floor(v868)) .. "s...", math.min(math.floor(v868), 5))
          end

          utilities:ServerHop(v868)
          task.wait(v868 + 5)
        end
      else
        v864 = nil
      end
    end, true)

    f110("AutoSail", function()
      local character38 = localPlayer.Character
      local humanoid36 = character38 and character38:FindFirstChildOfClass("Humanoid")

      local humanoidRootPart58 = character38
        and (character38:FindFirstChild("HumanoidRootPart") or character38.PrimaryPart)

      local v869 = not character38 or not humanoid36 or humanoid36.Health <= 0
        or not humanoidRootPart58

      local cframe21

      if v869 then
        return
      else
        local v870 = GetSelectedBoat()

        if not v870 or not IsBoatAlive(v870) then
          local tikiOutpost2 = worldOrigin.Locations:FindFirstChild("Tiki Outpost")

          local position57 = tikiOutpost2 and tikiOutpost2.Position
            or Vector3.new(-16641.5, 213.3, 435.4)

          if (humanoidRootPart58.Position - position57).Magnitude > 3000 then
            tweenManager:StopBoatTween()

            if character38:FindFirstChild("Head") then
              character38.Head:Destroy()
            else
              humanoid36.Health = 0
            end

            return
          end
        end

        local getSeaEventTargets = gameData:GetSeaEventTargets()

        local v871 = getSeaEventTargets
        v871 = getSeaEventTargets or {}

        local v872 = nil
        local v873 = nil
        local v874 = v871

        if v19.AutoFarmSeaEvents and #v874 > 0 then
          if table.find(v874, "SeaBeast") ~= nil or table.find(v874, "Sea Beast") ~= nil then
            for index108, value224 in ipairs(seaBeasts:GetChildren()) do
              if v33:IsReady(value224) then
                local humanoidRootPart59 = value224:FindFirstChild("HumanoidRootPart")

                local basePart11 = humanoidRootPart59
                basePart11 = humanoidRootPart59 or value224:FindFirstChildWhichIsA("BasePart")

                if basePart11 and localPlayer:DistanceFromCharacter(basePart11.Position) <= 1500 then
                  v873 = "SeaBeast"
                  v872 = value224
                  break
                end
              end
            end
          end

          if not v872 then
            for index109, value225 in ipairs(enemies:GetChildren()) do
              if v33:IsReady(value225) then
                for index110, value226 in ipairs(v874) do
                  if value226 ~= "SeaBeast"
                    and (string.find(value225.Name, value226)
                      or value226 == "FishBoat" and value225.Name:find("FishBoat")) then
                    local humanoidRootPart60 = value225:FindFirstChild("HumanoidRootPart")
                      or value225:FindFirstChild("Engine")
                      or value225:FindFirstChildWhichIsA("BasePart")

                    if humanoidRootPart60
                      and localPlayer:DistanceFromCharacter(humanoidRootPart60.Position) <= 1500 then
                      v872 = value225
                      v873 = value226
                      break
                    end
                  end
                end

                if v872 then
                  break
                end
              end
            end
          end
        end

        if v872 then
          tweenManager:StopBoatTween()
          local v875 = GetSelectedBoat()

          if v19.ProtectBoat and v875 then
            f19(v875, 450)
          end

          if waitForChild and waitForChild.Sit then
            waitForChild.Sit = false
            task.wait(0.05)
          end

          utilities:AutoHaki()

          if v873 == "SeaBeast" then
            if v19.UseDragonSforSeabeasts then
              utilities:EquipWeapon("Gun")
            else
              utilities:EquipWeapon()
            end

            local humanoidRootPart61 = v872:FindFirstChild("HumanoidRootPart")

            local basePart12 = humanoidRootPart61
            basePart12 = humanoidRootPart61 or v872:FindFirstChildWhichIsA("BasePart")

            if basePart12 then
              local waterBasePlane2 = workspace.Map:FindFirstChild("WaterBase-Plane")
              local y = waterBasePlane2 and waterBasePlane2.Position.Y or 0
              local dodgeSeabeast = v19.DodgefSeabeast and gameData:DodgeSeabeast()
              local v876 = dodgeSeabeast and 400 or 250
              local v877 = dodgeSeabeast and 20 or 2

              if (Vector3.new(0, basePart12.Position.Y, 0) - Vector3.new(0, y, 0)).Magnitude
                <= 175 then
                tweenManager:topos(basePart12.CFrame * CFrame.new(0, v876, v877), true)
              else
                tweenManager:topos(CFrame.new(
                  basePart12.Position.X, y + v876, basePart12.Position.Z
                ), true)
              end

              if v19.UseDragonSforSeabeasts then
                if fastAttack and fastAttack.AttackManager then
                  fastAttack.AttackManager.CurrentTarget = v872
                end

                shootGun()
              else
                f3()
              end
            end
          elseif v873 == "PirateBrigade" or v873 == "Pirate Grand Brigade"
            or v873 == "Ghost Ship" or v873 == "FishBoat" or v872:FindFirstChild("Engine") then
            local health5 = v872:FindFirstChild("Health")
            local humanoid37 = v872:FindFirstChildOfClass("Humanoid")

            local humanoid38 = humanoid37
            humanoid38 = humanoid37 or v872:FindFirstChild("Humanoid")

            local valueBase = health5
                and (health5:IsA("ValueBase") and health5.Value <= 0
                  or type(health5.Value) == "number" and health5.Value <= 0)
              or humanoid38
                and (humanoid38:IsA("Humanoid") and humanoid38.Health <= 0
                  or humanoid38:IsA("ValueBase") and humanoid38.Value <= 0)
              or v872:GetAttribute("Dead") == true
              or v872:GetAttribute("Sunk") == true

            local engine2 = v872:FindFirstChild("Engine") or v872.PrimaryPart
              or v872:FindFirstChildWhichIsA("BasePart")

            if engine2 and engine2.Position.Y < -15 then
              valueBase = true
            end

            if not valueBase and engine2 then
              if v19.UseDragonSforSeabeasts then
                utilities:EquipWeapon("Gun")

                if fastAttack and fastAttack.AttackManager then
                  fastAttack.AttackManager.CurrentTarget = v872
                end

                shootGun()
              else
                utilities:EquipWeapon()
              end

              tweenManager:topos(engine2.CFrame * CFrame.new(0, 25, 0), true)
              Aimbot = engine2.Position
              f3()
              Aimbot = nil
            end
          else
            local humanoidRootPart62 = v872:FindFirstChild("HumanoidRootPart")
              or v872.PrimaryPart

            if humanoidRootPart62 then
              if v873 == "Terror Shark" or v873 == "Terrorshark" or v872.Name:find("Terror") then
                task.wait()

                utilities:AutoHaki()
                utilities:EquipWeapon()

                if humanoidRootPart62.CFrame.Y > -3 then
                  cframe21 = CFrame.new(0, 250, 0)
                elseif gameData:TerrorDodge() then
                  cframe21 = CFrame.new(0, 150, 30)
                else
                  cframe21 = CFrame.new(0, 40, 0)
                end

                tweenManager:topos(humanoidRootPart62.CFrame * cframe21, true)
                subFunction:Attack(v872)
              else
                utilities:EquipWeapon()
                tweenManager:topos(humanoidRootPart62.CFrame * CFrame.new(0, 20, 0), true)
                subFunction:Attack(v872)
              end
            end
          end
        else
          local v878 = GetSelectedBoat()

          if v878 then
            f8(v878)
          end

          subFunction:AutoBoatSail()
          task.wait(0.4)
        end

        return
      end
    end, v25 or v26)

    f110("AutoFindMirageIsland", function()
      if map:FindFirstChild("MysticIsland")
        or worldOrigin.Locations:FindFirstChild("Mirage Island") then
        tweenManager:StopBoatTween()
      else
        subFunction:AutoBoatSail(CFrame.new(-10000000, 31, 37016.25))
      end
    end, v26)

    f110("AutoFindKitsuneIsland", function()
      if map:FindFirstChild("KitsuneIsland")
        or worldOrigin.Locations:FindFirstChild("Kitsune Island") then
        tweenManager:StopBoatTween()

        if waitForChild.Sit then
          waitForChild.Sit = false
        end
      else
        subFunction:AutoBoatSail(CFrame.new(-10000000, 31, 37016.25))
      end
    end, v26)

    f110("AutoFindPrehistoricIsland", function()
      if map:FindFirstChild("PrehistoricIsland")
        or worldOrigin.Locations:FindFirstChild("Prehistoric Island") then
        tweenManager:StopBoatTween()

        if waitForChild.Sit then
          waitForChild.Sit = false
        end

        v33._FindPrehistoricIsland.Update(false)
      else
        subFunction:AutoBoatSail(CFrame.new(-10000000, 31, 37016.25))
      end
    end, v26)

    f110("CollectAzure", function()
      local emberTemplate2 = v4:FindFirstChild("EmberTemplate")

      if emberTemplate2 and emberTemplate2:FindFirstChild("Part") then
        tweenManager:topos(emberTemplate2.Part.CFrame)
      end
    end, v26)

    f110("AutoFinishTrial", function()
      if v19 and v19.AutoCompleteDracoTrial then
        return
      else
        local value227 = data.Race.Value

        if value227 == "Draco" or not v44[value227] then
          return
        end

        if localPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible then
          if value227 == "Mink" and map:FindFirstChild("MinkTrial") then
            local ceiling = map.MinkTrial.Ceiling

            if (ceiling.Position - localPlayer.Character.HumanoidRootPart.Position).Magnitude
              <= 500 then
              tweenManager:topos(ceiling.CFrame * CFrame.new(0, -5, 0))
            end
          elseif value227 == "Human" and map:FindFirstChild("HumanTrial") then
            if (localPlayer.Character.HumanoidRootPart.Position
                - map.HumanTrial.BossSpawn.Position).Magnitude
              <= 250 then
              for index111, value228 in ipairs(enemies:GetChildren()) do
                if value228:FindFirstChild("HumanoidRootPart") and value228.Humanoid.Health > 0 then
                  if (value228.HumanoidRootPart.Position - map.HumanTrial.BossSpawn.Position).Magnitude
                    <= 200 then
                    subFunction:Attack(value228)
                    break
                  end
                end
              end
            end
          elseif value227 == "Ghoul" and map:FindFirstChild("GhoulTrial") then
            if (localPlayer.Character.HumanoidRootPart.Position
                - map.GhoulTrial.BossSpawn.Position).Magnitude
              <= 250 then
              for index112, value229 in ipairs(enemies:GetChildren()) do
                if value229:FindFirstChild("HumanoidRootPart") and value229.Humanoid.Health > 0 then
                  if (value229.HumanoidRootPart.Position - map.GhoulTrial.BossSpawn.Position).Magnitude
                    <= 200 then
                    subFunction:Attack(value229, true)
                    break
                  end
                end
              end
            end
          elseif value227 == "Cyborg" and map:FindFirstChild("CyborgTrial") then
            if (localPlayer.Character.HumanoidRootPart.Position - map.CyborgTrial.Floor.Position).Magnitude
              <= 250 then
              tweenManager:topos(map.CyborgTrial.Floor.CFrame * CFrame.new(0, -70, 0), true)
            end
          elseif value227 == "Skypiea" and map:FindFirstChild("SkyTrial") then
            local finishPart = map.SkyTrial.Model.FinishPart

            if (finishPart.Position - localPlayer.Character.HumanoidRootPart.Position).Magnitude
              <= 1000 then
              tweenManager:topos(finishPart.CFrame, true)
            end
          elseif value227 == "Fishman" and map:FindFirstChild("FishmanTrial") then
            local fishmanTrial = map.FishmanTrial

            if (localPlayer.Character.HumanoidRootPart.Position
                - fishmanTrial:GetPivot().Position).Magnitude
              < 1000 then
              local trialOfWater = worldOrigin.Locations:FindFirstChild("Trial of Water")

              if trialOfWater then
                local v879, v880 = v4.SeaBeasts:GetChildren()

                for key105, value230 in next, v879, v880 do
                  if string.find(value230.Name, "SeaBeast")
                    and value230:FindFirstChild("HumanoidRootPart") then
                    if (value230.HumanoidRootPart.Position - trialOfWater.Position).Magnitude
                      <= 1500 then
                      if value230.Health.Value > 0 then
                        utilities:AutoHaki()
                        utilities:EquipWeapon()

                        local v881 = 5
                        local v882 = 150

                        if v19.DodgefSeabeast and gameData:DodgeSeabeast() then
                          v881 = math.random(-30, 30)
                          v882 = 400
                        end

                        tweenManager:topos(value230.HumanoidRootPart.CFrame
                          * CFrame.new(0, v882, v881), true)

                        Aimbot = value230.HumanoidRootPart.CFrame.Position
                        f3()
                        Aimbot = nil
                        break
                      end
                    end
                  end
                end
              end
            end
          end
        elseif v44[value227] then
          tweenManager:topos(v44[value227], true)
        end

        return
      end
    end, v26)

    f110("AutoKillPlayerinTrial", function()
      if localPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible then
        for key106, value231 in pairs(workspace.Characters:GetChildren()) do
          if value231.Name ~= localPlayer.Name and value231:FindFirstChild("HumanoidRootPart")
            and value231:FindFirstChild("Humanoid") and value231.Humanoid.Health > 0 then
            if (value231.HumanoidRootPart.Position
                - localPlayer.Character.HumanoidRootPart.Position).Magnitude
              < 300 then
              tweenManager:topos(value231.HumanoidRootPart.CFrame * CFrame.new(0, 20, 10), true)

              utilities:EquipWeapon()
              utilities:AutoHaki()

              break
            end
          end
        end
      end
    end, v26)

    f110("AutoChooseGear", function()
      local v883, v884 = pcall(function() return commF:InvokeServer("TempleClock", "Check") end)

      if v883 and v884 and v884.HadPoint == true or not v884 then
        for index113, value232 in ipairs({
          {}, { "Gear1" }, { "Gear2", "Omega" }, { "Gear2", "Alpha" }, { "Gear2", true },
          { "Gear2", false }, { "Gear3", "Alpha" }, { "Gear3", "Omega" }, { "Gear3", true },
          { "Gear3", false },
          {
            "Gear4",
            v884 and v884.RaceDetails and v884.RaceDetails.B == 2 and "Omega" or "Alpha",
          },
          { "Gear4", true }, { "Gear4", false }, { "Gear5", "Default" }, { "Gear5", true },
          { "Gear5", false },
        }) do
          local v885 = value232

          pcall(function()
            commF:InvokeServer("TempleClock", "SpendPoint", table.unpack(v885))
          end)
        end
      end
    end, v26)

    f110("AutoRepairBoat", function() subFunction:AutoRepairBoat() end, true)

    f110("AutoTrialDracoTP", function()
      local trialTeleport = map.PrehistoricIsland:FindFirstChild("TrialTeleport")

      if trialTeleport and trialTeleport:IsA("Part")
        and (waitForChild2.Position - trialTeleport.Position).Magnitude <= 10 then
        v33._AutoTrialDracoToggle.Update(false)
        return
      end

      if trialTeleport and trialTeleport:IsA("Part") then
        tweenManager:topos(
          CFrame.new(trialTeleport:GetPivot().Position + Vector3.new(0, 0, 0)), true
        )
      end
    end, v26)

    f110("AutoTTK", function()
      v16.ActiveSword = nil

      for index114, value233 in ipairs(v16.SwordList) do
        local checkInventory = utilities:CheckInventory("Moveset", value233)

        if checkInventory ~= nil and checkInventory > 0 and checkInventory < 300 then
          v16.ActiveSword = value233
          break
        end
      end

      if v16.ActiveSword then
        if not localPlayer.Character:FindFirstChild(v16.ActiveSword) then
          commF:InvokeServer("LoadItem", v16.ActiveSword)
        end

        utilities:EquipWeapon("Sword")
        local getEnemies26 = utilities:GetEnemies({ "Water Fighter", "Sea Soldier" })

        if getEnemies26 then
          return subFunction:Attack(getEnemies26, true)
        end

        return utilities:MobsNextSpawn("Water Fighter")
      else
        local checkInventory2 = utilities:CheckInventory("Moveset", "Shizu")
        local checkInventory3 = utilities:CheckInventory("Moveset", "Saishi")
        local checkInventory4 = utilities:CheckInventory("Moveset", "Oroshi")

        if checkInventory2 and checkInventory2 >= 300 and checkInventory3
          and checkInventory3 >= 300 and checkInventory4 and checkInventory4 >= 300 then
          commF:InvokeServer("MysteriousMan", "2")
        elseif commF:InvokeServer("LegendarySwordDealer", "1") then
          print("Buy")
          commF:InvokeServer("LegendarySwordDealer", "2")
        else
          print("Hop")
          f6("legendarysword", 2)
        end

        return
      end
    end, v25)

    f110("AutoCollectPumpkin", function()
      local humanoidRootPart63 = localPlayer.Character
        and localPlayer.Character:FindFirstChild("HumanoidRootPart")

      if not humanoidRootPart63 then
        return
      else
        utilities:AutoHaki()
        utilities:EquipWeapon()

        local getEnemies27 = utilities:GetEnemies({ "Pumpkin Snowman", "Jack o' Lantern" })

        local humanoidRootPart64 = getEnemies27
          and getEnemies27:FindFirstChild("HumanoidRootPart")

        if humanoidRootPart64
          and (humanoidRootPart63.Position - humanoidRootPart64.Position).Magnitude <= 500 then
          subFunction:Attack(getEnemies27)
          return task.wait(0.05)
        else
          local getPumpkins2 = v33:GetPumpkins()

          if #getPumpkins2 == 0 then
            return task.wait(0.5)
          end

          for index115, value234 in ipairs(getPumpkins2) do
            if not v19.AutoCollectPumpkin then
              break
            end

            if value234 and value234.Parent then
              local getEnemies28 = utilities:GetEnemies({ "Pumpkin Snowman", "Jack o' Lantern" })

              local humanoidRootPart65 = getEnemies28

              humanoidRootPart65 = getEnemies28
                and getEnemies28:FindFirstChild("HumanoidRootPart")

              if humanoidRootPart65
                and (humanoidRootPart63.Position - humanoidRootPart65.Position).Magnitude <= 500 then
                subFunction:Attack(getEnemies28)
                return task.wait(0.05)
              end

              tweenManager:topos(
                CFrame.new(value234:GetPivot().Position + Vector3.new(0, 3, 0)), true
              )

              while v19.AutoCollectPumpkin and value234 and value234.Parent
                and (humanoidRootPart63.Position - value234:GetPivot().Position).Magnitude > 25 do
                tweenManager:topos(
                  CFrame.new(value234:GetPivot().Position + Vector3.new(0, 3, 0)), true
                )

                task.wait()
              end

              if v19.AutoCollectPumpkin and value234 and value234.Parent then
                local v886 = tick() + 3

                while v19.AutoCollectPumpkin and value234 and value234.Parent and tick() < v886 do
                  local pumpkinState4 = value234:GetAttribute("PumpkinState")

                  if pumpkinState4 == "Burst" then
                    break
                  elseif pumpkinState4 == "Awakening" then
                    local v887 = tick() + 6

                    while tick() < v887 and v19.AutoCollectPumpkin do
                      local getEnemies29 = utilities:GetEnemies({
                        "Pumpkin Snowman", "Jack o' Lantern",
                      })

                      local humanoidRootPart66 = getEnemies29

                      humanoidRootPart66 = getEnemies29
                        and getEnemies29:FindFirstChild("HumanoidRootPart")

                      if humanoidRootPart66
                        and (humanoidRootPart63.Position - humanoidRootPart66.Position).Magnitude
                          <= 500 then
                        subFunction:Attack(getEnemies29)
                      end

                      if not getEnemies29 or not getEnemies29.Parent then
                        task.wait(0.05)
                      else
                        task.wait()
                      end
                    end

                    break
                  else
                    subFunction:AttackTarget(value234)
                    task.wait()
                  end
                end
              end
            end
          end

          return
        end
      end
    end, true)

    f110("AutoTrickOrTreat", function()
      v33.SkippedDoors = v33.SkippedDoors or {}

      local f117, f118, f119, f120, halloweenEvent2, enemies11, v888, v889, v890, v891, f121,
        f122, v892, v893, func

      if not v33:IsHalloweenEventRunning() then
        if tweenManager and tweenManager.StopTween then
          tweenManager:StopTween()
        end

        return task.wait(1)
      else
        halloweenEvent2 = remotes:FindFirstChild("HalloweenEvent")

        local halloweenFunction = remotes:FindFirstChild("HalloweenFunction")
          or remotes:FindFirstChild("Func")

        enemies11 = workspace:FindFirstChild("Enemies")

        v888 = {
          "play matching", "play", "trick or treat", "trick", "treat", "candy", "oni", "yes",
          "confirm", "accept", "enter", "okay", "just a candy", "next", "continue", "give me",
          "reward",
        }

        local v894
        v894, v889 = pcall(require, v5:FindFirstChild("DialogueController"))

        if not v894 then
          v889 = nil
        end

        local v895, v896 = pcall(function()
          local controllers = v5:FindFirstChild("Controllers")
          local ui = controllers and controllers:FindFirstChild("UI")
          return require(ui and ui:FindFirstChild("ConcentrationGame"))
        end)

        v890 = v896

        if not v895 or not v890 or not v890.IsInitialized then
          v890 = nil
        end

        v891 = nil

        pcall(function()
          local halloweenLocal = localPlayer and localPlayer:FindFirstChild("PlayerScripts")
            and localPlayer.PlayerScripts:FindFirstChild("HalloweenLocal")

          v891 = halloweenLocal and require(halloweenLocal:FindFirstChild("GhostChase"))
        end)

        function f117()
          if not f121() then
            return false
          else
            local v897, v898 = pcall(v889.getActiveDialogue)

            if not v897 or not v898 then
              return false
            else
              local pageStack = v898._pageStack
              local v899 = pageStack and pageStack[#pageStack]

              if not v899 then
                return false
              else
                local options = v899._options or {}

                if #options == 0 then
                  pcall(v889.advance)
                  return true
                else
                  local v900 = nil

                  for index116, value235 in ipairs(v888) do
                    for index117, value236 in ipairs(options) do
                      if string.lower(type(value236._text) == "table"
                          and table.concat(value236._text, " ")
                        or tostring(value236._text or "")):find(
                        value235, 1, true
                      ) then
                        v900 = value236
                        break
                      end
                    end

                    if v900 then
                      break
                    end
                  end

                  pcall(v889.select, v900 or options[1])
                  return true
                end
              end
            end
          end
        end

        function f121()
          return v889 and v889.Active
        end

        local function f123()
          local dapperJackGateway4 = workspace:FindFirstChild("DapperJackGateway")
            or workspace:FindFirstChild("Map")
              and workspace.Map:FindFirstChild("DapperJackGateway")

          local dapperJackGateway5, v901, v902

          if dapperJackGateway4 then
            local findFirstChildWhichIsA6 = dapperJackGateway4:FindFirstChildWhichIsA(
              "ProximityPrompt", true
            )

            local parent9 = findFirstChildWhichIsA6 and findFirstChildWhichIsA6.Parent
                and findFirstChildWhichIsA6.Parent:IsA("BasePart")
                and findFirstChildWhichIsA6.Parent
              or dapperJackGateway4:FindFirstChildWhichIsA("BasePart", true)
              or dapperJackGateway4

            if parent9 then
              return parent9, findFirstChildWhichIsA6
            end

            dapperJackGateway5 = workspace:GetAttribute("DapperJackGateway")
            v901 = typeof(dapperJackGateway5) == "Vector3"

            v902 = v901
            v902 = v901 and workspace:GetAttribute("DapperJackActive") == true

            if v902 then
              return dapperJackGateway5, nil
            end

            return nil, nil
          end

          dapperJackGateway5 = workspace:GetAttribute("DapperJackGateway")
          v901 = typeof(dapperJackGateway5) == "Vector3"

          v902 = v901
          v902 = v901 and workspace:GetAttribute("DapperJackActive") == true

          if v902 then
            return dapperJackGateway5, nil
          end

          return nil, nil
        end

        function f118()
          local playerGui6 = localPlayer and localPlayer:FindFirstChild("PlayerGui")

          if not playerGui6 then
            return false
          else
            local dialogue = playerGui6:FindFirstChild("Dialogue")
              or playerGui6:FindFirstChild("DialogueGui")
              or playerGui6:FindFirstChild("Conversation")

            if dialogue and dialogue.Enabled then
              for index118, value237 in ipairs(dialogue:GetDescendants()) do
                if value237:IsA("TextButton") and value237.Visible then
                  local lower13 = value237.Text:lower()

                  for index119, value238 in ipairs(v888) do
                    if lower13:find(value238, 1, true) then
                      utilities:ClickButton(value237)
                      return true
                    end
                  end

                  utilities:ClickButton(value237)
                  return true
                end
              end

              return false
            end

            return false
          end
        end

        function f119(p251, p252)
          if not enemies11 then
            return nil
          end

          for index120, value239 in ipairs(enemies11:GetChildren()) do
            local humanoidRootPart67 = value239:FindFirstChild("HumanoidRootPart")
              or value239.PrimaryPart

            local humanoid39 = value239:FindFirstChild("Humanoid")

            if humanoidRootPart67 and humanoid39 and humanoid39.Health > 0
              and (humanoidRootPart67.Position - p251).Magnitude <= p252 then
              return value239
            end
          end
        end

        function f120(p253)
          local v903

          if not v890 then
            return false
          else
            local v904 = tick()

            while not v890:IsOpen() and tick() - v904 < 3 do
              task.wait(0.1)
            end

            if not v890:IsOpen() then
              return false
            end

            if firesignal then
              pcall(firesignal, v890.OnComplete)
              task.wait(0.3)

              if not v890:IsOpen() then
                return true
              end
            end

            v903 = false
            local connect3 = v890.OnComplete:Connect(function() v903 = true end)
            local v905 = tick() + (p253 or 20)

            while not v903 and tick() < v905 do
              local playerGui7 = localPlayer and localPlayer:FindFirstChild("PlayerGui")

              if playerGui7 then
                local v906 = nil

                for index121, value240 in ipairs(playerGui7:GetChildren()) do
                  if value240:IsA("ScreenGui") and value240.Enabled then
                    local lower14 = value240.Name:lower()

                    if lower14:find("concentration") or lower14:find("card")
                      or lower14:find("match") then
                      v906 = value240
                      break
                    end
                  end
                end

                if v906 then
                  local v907 = {}

                  for index122, value241 in ipairs(v906:GetDescendants()) do
                    if (value241:IsA("ImageButton") or value241:IsA("TextButton"))
                      and value241.Visible then
                      local lower15 = value241.Name:lower()

                      if lower15:find("card") or lower15:find("slot") or lower15:find("tile") then
                        v907[#v907 + 1] = value241
                      end
                    end
                  end

                  for index123, value242 in ipairs(v907) do
                    utilities:ClickButton(value242)
                    task.wait(0.12)

                    if v903 then
                      break
                    end
                  end
                end
              end

              task.wait(0.25)
            end

            connect3:Disconnect()

            if v890:IsOpen() then
              pcall(function() v890:Close() end)
            end

            return v903
          end
        end

        local function f124(p254)
          local v908 = tick()
          local v909 = false
          task.wait(0.2)

          while tick() - v908 < (p254 or 6) do
            task.wait(0.2)

            if f121() then
              f117()
              v909 = true
            elseif f118() then
              v909 = true
            elseif v909 then
              break
            end
          end

          if f121() then
            pcall(v889.close)
          end

          return v909
        end

        function f122(p255)
          local character39 = localPlayer and localPlayer.Character

          local humanoidRootPart68 = character39
            and (character39:FindFirstChild("HumanoidRootPart") or character39.PrimaryPart)

          if not humanoidRootPart68 then
            return false
          else
            local v910 = f119(humanoidRootPart68.Position, p255 or 45)

            if not (v910 and v910.Parent) then
              return false
            else
              local humanoidRootPart69 = v910:FindFirstChild("HumanoidRootPart")
                or v910.PrimaryPart

              if not humanoidRootPart69 then
                return false
              end

              tweenManager:topos(CFrame.new(humanoidRootPart69.Position + Vector3.new(0, 3, 0)))

              utilities:AutoHaki()
              utilities:EquipWeapon()

              subFunction:Attack(v910)
              return true
            end
          end
        end

        local v911
        v911, v892 = f123()

        local function f125(p256, p257)
          local parent10 = p256 and p256.Parent
          local v912

          if not parent10 then
            return
          else
            local v913 = os.clock()

            repeat
              task.wait(0.25)

              if f122(45) then
                task.wait(0.1)
              end

              if f121() then
                f117()
              end

              if v890 and v890:IsOpen() then
                f120(20)
              end

              local v914 = not (p256 and p256.Parent and p256:GetAttribute("DoorOpen") == true)

              v912 = v914
              v912 = v914 or os.clock() - v913 > (p257 or 12)
            until v912

            return
          end
        end

        if v911 then
          local position58 = typeof(v911) == "Vector3" and v911 or v911.Position
          local getDistance = utilities:GetDistance(position58)

          if not getDistance or getDistance > 12 then
            tweenManager:topos(CFrame.new(position58 + Vector3.new(0, 3, 0)), true)
            return task.wait(0.2)
          end

          if v892 then
            pcall(function()
              v892.Enabled = true
              v892.HoldDuration = 0
            end)

            if fireproximityprompt then
              pcall(fireproximityprompt, v892, math.huge)
              pcall(fireproximityprompt, v892)
            end
          end

          if halloweenEvent2 then
            pcall(function() halloweenEvent2:FireServer("DapperJackArenaEnter") end)
          end

          return task.wait(0.5)
        else
          local v915 = nil

          if enemies11 then
            for index124, value243 in ipairs(enemies11:GetChildren()) do
              local humanoid40 = value243:FindFirstChild("Humanoid")

              if (value243.Name == "Hellfire Gas" or value243.Name == "Unbound Werewolf"
                  or value243.Name == "Jack o' Lantern" or value243.Name == "Dapper Jack")
                and humanoid40
                and humanoid40.Health > 0 then
                v915 = value243
                break
              end
            end
          end

          if v915 and v915.Parent then
            utilities:AutoHaki()
            utilities:EquipWeapon()

            subFunction:Attack(v915)
            return task.wait(0.1)
          else
            local ghostChase3 = workspace:FindFirstChild("GhostChase")

            local model2 = ghostChase3
            model2 = ghostChase3 and ghostChase3:FindFirstChildOfClass("Model")

            if model2 and model2.Parent then
              local character40 = localPlayer and localPlayer.Character

              local humanoidRootPart70 = character40

              humanoidRootPart70 = character40
                and character40:FindFirstChild("HumanoidRootPart")

              if v891 and humanoidRootPart70 and halloweenEvent2 then
                local pickup = v891.REACH and v891.REACH.Pickup
                local v916 = nil
                local v917 = pickup or 6
                local huge22 = math.huge
                local v918, v919 = v33:GetHalloweenDoors()

                for index125, value244 in ipairs(v919 or {}) do
                  if value244 and value244.Parent then
                    if (v891.readState and v891.readState(value244)) == "Fleeing" then
                      for key107, value245 in pairs(value244:GetAttributes()) do
                        if typeof(value245) == "Vector3" and v891.isCandyAttribute
                          and v891.isCandyAttribute(key107) then
                          local candyId = v891.candyId and v891.candyId(key107)

                          if candyId then
                            local magnitude24 = (humanoidRootPart70.Position - value245).Magnitude

                            if magnitude24 <= v917 then
                              pcall(function()
                                halloweenEvent2:FireServer(v891.COMMANDS.Candy, candyId)
                              end)
                            elseif magnitude24 < huge22 then
                              huge22 = magnitude24
                              v916 = value245
                            end
                          end
                        end
                      end
                    end
                  end
                end

                if v916 then
                  tweenManager:topos(CFrame.new(v916 + Vector3.new(0, 2, 0)), true)
                  return task.wait(0.3)
                end
              end

              local position59 = model2:GetPivot().Position
              local getDistance2 = utilities:GetDistance(position59)

              if not getDistance2 or getDistance2 > 10 then
                tweenManager:topos(CFrame.new(position59 + Vector3.new(0, 2, 0)), true)
                return task.wait(0.3)
              end

              utilities:AutoHaki()
              utilities:EquipWeapon()

              subFunction:AttackTarget(model2)
              return task.wait(0.1)
            else
              local v920, v921 = v33:GetHalloweenDoors()

              if #v920 > 0 then
                v893 = v920[1]

                if not (v893 and v893.Parent) then
                  return task.wait(0.1)
                else
                  local v922 = f15(v893)

                  if not v922 then
                    local v923 = workspace
                    v33.SkippedDoors[v893] = v923:GetServerTimeNow() + 8
                    return task.wait(0.1)
                  elseif v893:GetAttribute("DoorOpen") == true then
                    f125(v893, 15)
                    local v924 = workspace
                    v33.SkippedDoors[v893] = v924:GetServerTimeNow() + 10
                    return task.wait(0.3)
                  else
                    local proximity4 = v893:FindFirstChild("Proximity")

                    local proximityPrompt4 = proximity4 and proximity4:FindFirstChildWhichIsA("ProximityPrompt") or v893:FindFirstChildWhichIsA(
                      "ProximityPrompt", true
                    )

                    local getDistance3 = utilities:GetDistance(v922)

                    if not getDistance3 or getDistance3 > 12 then
                      tweenManager:topos(CFrame.new(v922 + Vector3.new(0, 1.5, 0)), true)
                      return task.wait(0.25)
                    else
                      local v925 = f119(v922, 45)

                      if v925 then
                        utilities:AutoHaki()
                        utilities:EquipWeapon()

                        subFunction:Attack(v925)
                        task.wait(0.15)
                      end

                      if proximityPrompt4 then
                        if fireproximityprompt then
                          pcall(fireproximityprompt, proximityPrompt4, math.huge)
                          pcall(fireproximityprompt, proximityPrompt4)
                        end
                      end

                      local v926 = false

                      if halloweenFunction then
                        local v927, v928 = pcall(function()
                          return halloweenFunction:InvokeServer(v893)
                        end)

                        if v927 and v928 ~= false then
                          v926 = true
                        end
                      end

                      func = remotes:FindFirstChild("Func")

                      if func and func ~= halloweenFunction then
                        local v929, v930 = pcall(function() return func:InvokeServer(v893) end)

                        if v929 and v930 ~= false then
                          v926 = true
                        end
                      end

                      pcall(function() commF:InvokeServer("HalloweenDoor", v893) end)
                      local v931 = f124(6)

                      if v890 and v890:IsOpen() then
                        f120(20)
                      end

                      if halloweenEvent2 then
                        pcall(function() halloweenEvent2:FireServer("AcceptReward") end)
                        task.wait(0.15)
                        pcall(function() halloweenEvent2:FireServer("TreatDialogueClosed") end)
                      end

                      if v19.AutoRecallDoorMobs ~= false and halloweenEvent2 then
                        task.wait(0.2)
                        pcall(function() halloweenEvent2:FireServer("RecallDoorMobs", v893) end)
                      end

                      if v893:GetAttribute("DoorOpen") == true then
                        f125(v893, 15)
                      end

                      local cooldownUntil2 = v893:GetAttribute("DoorOpen") == true
                        or v893:GetAttribute("CooldownUntil")

                      local skippedDoors = v33.SkippedDoors

                      skippedDoors[v893] = workspace:GetServerTimeNow()
                        + ((cooldownUntil2 or v931 or v926) and 10 or 8)

                      return task.wait(0.4)
                    end
                  end
                end
              else
                if tweenManager and tweenManager.StopTween then
                  tweenManager:StopTween()
                end

                task.wait(0.5)
                return
              end
            end
          end
        end
      end
    end, true)
  end

  function v33.CoreSetup(p258)
    if p258.SetupData then
      p258:SetupData()
    end
  end

  function v33.CombatHooks(p259)
    if p259.LoadFunctions then
      p259:LoadFunctions()
    end
  end

  function v33.RuntimeServices(p260)
    if p260.LoadLoops then
      p260:LoadLoops()
    end
  end

  local function f126(p261, ...)
    local v932 = tick()
    local v933 = v33[p261]

    if v933 then
      v933(v33, ...)
    end

    print(string.format("[CATHUB] %s initialized in %.4fs", p261, tick() - v932))
  end

  f126("CoreSetup")
  f126("CombatHooks")
  f126("RuntimeServices")

  spawn(f126, "LoadLibrary")

  spawn(function()
    task.wait(1.5)

    v33:SendNotify(
      "CATHUB Loaded", "All Functions, Modules, Dependencies, Successfully loaded.", 8
    )

    task.wait(1)
    v33:SendNotify("CATHUB (INFO)", "CATHUB Script is 100% Free and Keyless", 8)

    pcall(function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/flazhy/QuantumOnyx/refs/heads/main/Util/BloxFruitModule/Preload/Weebo.lua"))()
    end)
  end)

  return
end
