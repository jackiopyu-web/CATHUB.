local runService = game:GetService("RunService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local userInputService = game:GetService("UserInputService")
local collectionService = game:GetService("CollectionService")
local lighting = game:GetService("Lighting")
local tweenService = game:GetService("TweenService")
local players = game:GetService("Players")
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

local function f1(p1)
  local v2 = getthreadidentity and setthreadidentity
  local v3

  if v2 then
    pcall(function()
      v3 = getthreadidentity()
      setthreadidentity(8)
    end)
  end

  local v4, v5 = pcall(function() return game:GetObjects(p1) end)

  if v3 and setthreadidentity then
    pcall(function() setthreadidentity(v3) end)
  end

  if v4 and v5 and #v5 > 0 then
    return v5
  end

  return nil, v5
end

local v6 = {}
local v7 = require(replicatedStorage.Notification)
local localPlayer = players.LocalPlayer

function v6.GiveDarkBlade(p2)
  v7.new("<Color=Purple>Quantum Onyx: Gifted you Triple Darkblade<Color=/>"):Display()
  local v8 = require(replicatedStorage.Effect.Container.Yoru2.SphereSlicesV2)
  local v9 = require(replicatedStorage.Effect.Container.WeaponReworks.DarkBladeHeld)
  local v10 = require(replicatedStorage.Effect.Container.Yoru2.SlashV2)
  local v11 = require(replicatedStorage.Effect.Container.Yoru2.InitialSlash)

  if not replicatedStorage:FindFirstChild("TEST SWORD") then
    local rbxassetid18631972861 = f1("rbxassetid://18631972861")
    local testSWORD = rbxassetid18631972861 and rbxassetid18631972861[1]

    if testSWORD then
      testSWORD.Name = "TEST SWORD"
      testSWORD.Parent = replicatedStorage
    end
  end

  local v12 = { 9897433972, 9897434364, 9897435270, 9897435626 }
  local testSWORD2 = replicatedStorage:FindFirstChild("TEST SWORD")

  local v13 = {
    comboStep = 1,
    lastAttack = 0,
    resetTimer = nil,
    equipped = false,
    canM1 = true,
    m1CD = 0.5,
    holdZ = false,
    holdX = false,
    currentAnim = nil,
    idleTrack = nil,
    holdZFlag = Instance.new("BoolValue"),
    holdXFlag = Instance.new("BoolValue"),
  }

  local function f2()
    if v13.equipped then
      local humanoid = localPlayer.Character
        and localPlayer.Character:FindFirstChildOfClass("Humanoid")

      if humanoid then
        local animator = humanoid:FindFirstChild("Animator")
          or Instance.new("Animator", humanoid)

        if not (v13.idleTrack and v13.idleTrack.IsPlaying) then
          if v13.currentAnim and v13.currentAnim.IsPlaying then
            v13.currentAnim:Stop()
          end

          local animation = Instance.new("Animation")
          animation.AnimationId = "rbxassetid://10432912847"

          local loadAnimation = animator:LoadAnimation(animation)
          loadAnimation.Looped = true
          loadAnimation:Play()

          v13.idleTrack = loadAnimation
        end
      end
    end
  end

  local function f3()
    if v13.equipped and v13.canM1 and tick() - v13.lastAttack >= v13.m1CD then
      v13.canM1 = false
      v13.lastAttack = tick()

      if v13.idleTrack and v13.idleTrack.IsPlaying then
        v13.idleTrack:Stop()
        v13.idleTrack = nil
      end

      if v13.currentAnim and v13.currentAnim.IsPlaying then
        v13.currentAnim:Stop(0)
      end

      local humanoid2 = localPlayer.Character
        and localPlayer.Character:FindFirstChildOfClass("Humanoid")

      if humanoid2 then
        local animator2 = humanoid2:FindFirstChild("Animator")
          or Instance.new("Animator", humanoid2)

        local animation2 = Instance.new("Animation")
        animation2.AnimationId = "rbxassetid://" .. v12[v13.comboStep]

        local loadAnimation2 = animator2:LoadAnimation(animation2)
        loadAnimation2.Looped = false
        loadAnimation2:Play()

        v13.currentAnim = loadAnimation2
      end

      v13.comboStep = v13.comboStep % 4 + 1

      if v13.resetTimer then
        v13.resetTimer:Disconnect()
      end

      v13.resetTimer = runService.Stepped:Connect(function()
        if tick() - v13.lastAttack >= 1.5 then
          v13.comboStep = 1
          v13.resetTimer:Disconnect()
          v13.resetTimer = nil
        end
      end)

      task.delay(v13.m1CD, function()
        v13.canM1 = true

        if v13.equipped and (not v13.currentAnim or not v13.currentAnim.IsPlaying) then
          f2()
        end
      end)
    end
  end

  local function f4()
    if v13.equipped and not v13.holdZ then
      local humanoidRootPart = localPlayer.Character
        and localPlayer.Character:FindFirstChild("HumanoidRootPart")

      if humanoidRootPart then
        if v13.idleTrack and v13.idleTrack.IsPlaying then
          v13.idleTrack:Stop()
          v13.idleTrack = nil
        end

        if v13.currentAnim then
          v13.currentAnim:Stop()
        end

        v13.holdZ = true
        v13.holdZFlag.Value = true

        local humanoid3 = localPlayer.Character:FindFirstChildOfClass("Humanoid")

        if humanoid3 then
          local animator3 = humanoid3:FindFirstChild("Animator")
            or Instance.new("Animator", humanoid3)

          local animation3 = Instance.new("Animation")
          animation3.AnimationId = "rbxassetid://14413040313"

          local loadAnimation3 = animator3:LoadAnimation(animation3)
          loadAnimation3.Looped = false
          loadAnimation3:Play()

          v13.currentAnim = loadAnimation3

          loadAnimation3.Stopped:Connect(function()
            if v13.equipped and not v13.holdZ then
              f2()
            end
          end)
        end

        v8({
          player = localPlayer,
          hrp = humanoidRootPart,
          startSlicesPosition = humanoidRootPart.Position,
          endSlicesPosition = humanoidRootPart.Position
            + humanoidRootPart.CFrame.LookVector * 60,
          duration = 1,
        })
      end
    end
  end

  local function f5()
    if v13.equipped then
      v13.holdZ = false
      v13.holdZFlag.Value = false
      f2()
    end
  end

  local function f6()
    local equipped = v13.equipped and not v13.holdX
    local humanoidRootPart2

    if equipped then
      humanoidRootPart2 = localPlayer.Character
        and localPlayer.Character:FindFirstChild("HumanoidRootPart")

      if humanoidRootPart2 then
        if v13.idleTrack and v13.idleTrack.IsPlaying then
          v13.idleTrack:Stop()
          v13.idleTrack = nil
        end

        if v13.currentAnim then
          v13.currentAnim:Stop()
        end

        v13.holdX = true
        v13.holdXFlag.Value = true

        local humanoid4 = localPlayer.Character:FindFirstChildOfClass("Humanoid")

        if humanoid4 then
          local animator4 = humanoid4:FindFirstChild("Animator")
            or Instance.new("Animator", humanoid4)

          local animation4 = Instance.new("Animation")
          animation4.AnimationId = "rbxassetid://14468672805"

          local loadAnimation4 = animator4:LoadAnimation(animation4)
          loadAnimation4.Looped = false
          loadAnimation4:Play()

          v13.currentAnim = loadAnimation4

          loadAnimation4.Stopped:Connect(function()
            if v13.equipped and not v13.holdX then
              f2()
            end
          end)
        end

        task.spawn(function()
          v9({
            player = localPlayer,
            hrp = humanoidRootPart2,
            chargeTime = 1.5,
            special = false,
            skill1Held = v13.holdXFlag,
          })
        end)
      end
    end
  end

  local function f7()
    local holdX = v13.equipped and v13.holdX
    local humanoidRootPart3, position, getServerTimeNow

    if holdX then
      v13.holdX = false
      v13.holdXFlag.Value = false

      humanoidRootPart3 = localPlayer.Character
        and localPlayer.Character:FindFirstChild("HumanoidRootPart")

      if humanoidRootPart3 then
        position = humanoidRootPart3.Position
        local lookVector = humanoidRootPart3.CFrame.LookVector
        getServerTimeNow = workspace:GetServerTimeNow()

        for index, value in ipairs({
          lookVector,
          (CFrame.new(Vector3.zero, lookVector) * CFrame.Angles(0, math.rad(-35), 0)).LookVector,
          (CFrame.new(Vector3.zero, lookVector) * CFrame.Angles(0, math.rad(35), 0)).LookVector,
        }) do
          local v14 = value

          task.spawn(function()
            v11({
              player = localPlayer,
              hrp = humanoidRootPart3,
              origin = position,
              fireDir = v14,
              Stage = 2,
            })

            v10({
              player = localPlayer,
              hrp = humanoidRootPart3,
              origin = position,
              fireDir = v14,
              targetPos = position + v14 * 800,
              fliesFor = 2.5,
              ClockTime = getServerTimeNow,
              specialActivated = false,
            })
          end)
        end

        task.wait(0.2)

        if v13.equipped then
          f2()
        end
      end
    end
  end

  userInputService.InputBegan:Connect(function(input, p3)
    if userInputService:GetFocusedTextBox() then
      return
    end

    if v13.equipped then
      if input.KeyCode == Enum.KeyCode.Z then
        f4()
      elseif input.KeyCode == Enum.KeyCode.X then
        f6()
      elseif input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        f3()
      end
    end
  end)

  userInputService.InputEnded:Connect(function(input2, p4)
    if v13.equipped then
      if input2.KeyCode == Enum.KeyCode.Z then
        f5()
      elseif input2.KeyCode == Enum.KeyCode.X and v13.holdX then
        f7()
      end
    end
  end)

  local function f8(p5, p6)
    for key, value2 in pairs({ "TDB_WEAR", "TDB_EQUIP" }) do
      local findFirstChild = p5:FindFirstChild(value2)

      if findFirstChild then
        findFirstChild:Destroy()
      end
    end

    local testSWORD3 = replicatedStorage:FindFirstChild("TEST SWORD") or testSWORD2

    if not testSWORD3 then
      return
    else
      local v15 = p6 and "TDB_EQUIP" or "TDB_WEAR"
      local findFirstChild2 = testSWORD3:FindFirstChild(v15)

      if not findFirstChild2 then
        return
      else
        local clone = findFirstChild2:Clone()
        local findFirstChild3 = p5.FindFirstChild
        clone.Name = v15
        local v16 = findFirstChild3(p5, "UpperTorso")

        local torso = v16
        torso = v16 or p5:FindFirstChild("Torso")

        local rightHand = p5:FindFirstChild("RightHand")

        local rightArm = rightHand
        rightArm = rightHand or p5:FindFirstChild("Right Arm")

        local leftHand = p5:FindFirstChild("LeftHand")

        local leftArm = leftHand
        leftArm = leftHand or p5:FindFirstChild("Left Arm")

        local head = p5:FindFirstChild("Head")

        if p6 then
          for key2, value3 in pairs({
            DarkBladeR = {
              dummy = clone:FindFirstChild("RightHand"),
              target = rightArm or torso,
            },
            DarkBladeL = { dummy = clone:FindFirstChild("LeftHand"), target = leftArm or torso },
            DarkBladeH = { dummy = clone:FindFirstChild("Head"), target = head or torso },
          }) do
            local findFirstChild4 = clone:FindFirstChild(key2)

            local findFirstChild5 = findFirstChild4
              and findFirstChild4:FindFirstChild("Handle", true)

            if findFirstChild4 and findFirstChild5 and value3.dummy and value3.target then
              local cframe = value3.dummy.CFrame
              local cframe2 = findFirstChild5.CFrame
              local v17 = {}

              local v18 = value3.target.CFrame * cframe:ToObjectSpace(findFirstChild5.CFrame)
                * cframe2:Inverse()

              for key3, value4 in pairs(findFirstChild4:GetDescendants()) do
                if value4:IsA("WeldConstraint") then
                  value4.Enabled = false
                  table.insert(v17, value4)

                  if value4.Parent.Name == "Handle" then
                    value4.Part0 = value3.target
                  end
                end
              end

              for key4, value5 in pairs(findFirstChild4:GetDescendants()) do
                if value5:IsA("BasePart") then
                  value5.CFrame = v18 * value5.CFrame
                end
              end

              for index2, value6 in ipairs(v17) do
                value6.Enabled = true
              end

              pcall(function()
                if findFirstChild4:FindFirstChild("Right")
                  and findFirstChild4.Right:FindFirstChild("Hidden") then
                  findFirstChild4.Right.Hidden:Destroy()
                end
              end)
            end
          end

          for key5, value7 in pairs({ "RightHand", "LeftHand", "Head", "UpperTorso" }) do
            local findFirstChild6 = clone:FindFirstChild(value7)

            if findFirstChild6 then
              findFirstChild6:Destroy()
            end
          end
        else
          local upperTorso = clone:FindFirstChild("UpperTorso")

          if upperTorso and torso then
            for key6, value8 in pairs({ "DarkBlade1", "DarkBlade2", "DarkBlade3" }) do
              local findFirstChild7 = clone:FindFirstChild(value8)

              local findFirstChild8 = findFirstChild7

              findFirstChild8 = findFirstChild7
                and findFirstChild7:FindFirstChild("Handle", true)

              if findFirstChild7 and findFirstChild8 then
                local cframe3 = upperTorso.CFrame
                local cframe4 = findFirstChild8.CFrame
                local v19 = {}

                local v20 = torso.CFrame * cframe3:ToObjectSpace(findFirstChild8.CFrame)
                  * cframe4:Inverse()

                for key7, value9 in pairs(findFirstChild7:GetDescendants()) do
                  if value9:IsA("WeldConstraint") then
                    value9.Enabled = false
                    table.insert(v19, value9)

                    if value9.Parent.Name == "Handle" then
                      value9.Part0 = torso
                    end
                  end
                end

                for key8, value10 in pairs(findFirstChild7:GetDescendants()) do
                  if value10:IsA("BasePart") then
                    value10.CFrame = v20 * value10.CFrame
                  end
                end

                for index3, value11 in ipairs(v19) do
                  value11.Enabled = true
                end
              end
            end

            upperTorso:Destroy()
          end
        end

        clone.Parent = p5
        return clone
      end
    end
  end

  local backpack = localPlayer.Backpack

  local function f9(p7)
    if p7.Name == "Triple Dark Blade" then
      p7.Activated:Connect(function()
        if v13.equipped then
          f3()
        end
      end)

      p7.Equipped:Connect(function()
        v13.equipped = true
        f8(localPlayer.Character or localPlayer.CharacterAdded:Wait(), true)
        v13.comboStep = 1

        if v13.resetTimer then
          v13.resetTimer:Disconnect()
          v13.resetTimer = nil
        end

        task.wait(0.2)
        f2()
      end)

      p7.Unequipped:Connect(function()
        v13.equipped = false

        if v13.idleTrack and v13.idleTrack.IsPlaying then
          v13.idleTrack:Stop()
        end

        local animator5 = localPlayer.Character
          and localPlayer.Character:FindFirstChildOfClass("Humanoid")
          and localPlayer.Character:FindFirstChildOfClass("Humanoid"):FindFirstChild("Animator")

        if animator5 then
          for key9, value12 in pairs(animator5:GetPlayingAnimationTracks()) do
            value12:Stop()
          end
        end

        v13.currentAnim = nil
        v13.idleTrack = nil

        f8(localPlayer.Character or localPlayer.CharacterAdded:Wait(), false)

        v13.holdZ = false
        v13.holdZFlag.Value = false
        v13.holdX = false
        v13.holdXFlag.Value = false
      end)
    end
  end

  local tripleDarkBlade = backpack:FindFirstChild("Triple Dark Blade")
    or localPlayer.Character and localPlayer.Character:FindFirstChild("Triple Dark Blade")

  if tripleDarkBlade then
    tripleDarkBlade:Destroy()
  end

  local tripleDarkBlade2 = Instance.new("Tool")
  tripleDarkBlade2.Name = "Triple Dark Blade"
  tripleDarkBlade2.RequiresHandle = false
  tripleDarkBlade2:SetAttribute("ItemId", 1190)
  tripleDarkBlade2.ToolTip = "Sword"
  tripleDarkBlade2.Parent = localPlayer.Backpack

  f9(tripleDarkBlade2)
  f8(localPlayer.Character or localPlayer.CharacterAdded:Wait(), false)

  for key10, value13 in pairs(localPlayer.Backpack:GetChildren()) do
    f9(value13)
  end

  localPlayer.Backpack.ChildAdded:Connect(f9)
end

function v6.GiveDivineArt(p8)
  v7.new("<Color=Purple>Quantum Onyx: Gifted you Divine Art<Color=/>"):Display()
  local sound = require(replicatedStorage:WaitForChild("Util")).Sound

  local function f10(p9)
    local enemies = workspace:FindFirstChild("Enemies")

    if not enemies then
      return nil
    else
      local v21 = nil
      local huge = math.huge

      for key11, value14 in pairs(enemies:GetChildren()) do
        if value14:IsA("Model") and value14 ~= localPlayer.Character then
          local humanoidRootPart4 = value14:FindFirstChild("HumanoidRootPart")
          local humanoid5 = value14:FindFirstChildOfClass("Humanoid")

          if humanoidRootPart4 and humanoid5 and humanoid5.Health > 0 then
            local magnitude = (humanoidRootPart4.Position - p9.Position).Magnitude

            if magnitude < huge and magnitude < 80 then
              v21 = humanoidRootPart4
              huge = magnitude
            end
          end
        end
      end

      return v21
    end
  end

  local function f11(p10, p11)
    local v22 = {}
    local enemies2 = workspace:FindFirstChild("Enemies")

    if not enemies2 then
      return v22
    end

    for key12, value15 in pairs(enemies2:GetChildren()) do
      if value15:IsA("Model") and value15 ~= localPlayer.Character then
        local humanoid6 = value15:FindFirstChildOfClass("Humanoid")
        local humanoidRootPart5 = value15:FindFirstChild("HumanoidRootPart")

        if humanoid6 and humanoid6.Health > 0 and humanoidRootPart5 then
          if (humanoidRootPart5.Position - p10.Position).Magnitude < p11 then
            table.insert(v22, { value15, humanoidRootPart5.Position })
          end
        end
      end
    end

    return v22
  end

  local v23 = require(replicatedStorage.Effect.Container.Angel.M1)
  local v24 = require(replicatedStorage.Effect.Container.Angel.Z)
  local v25 = require(replicatedStorage.Effect.Container.Angel.XCharge)
  local v26 = require(replicatedStorage.Effect.Container.Angel.XCharChains)
  local v27 = require(replicatedStorage.Effect.Container.Angel.XCameraChains)
  local v28 = require(replicatedStorage.Effect.Container.Angel.C)
  local v29 = 0
  local v30 = true
  local v31 = false
  local v32 = { 18699539486, 18699541378, 18699542775, 18699545564 }

  local v33 = {
    Z = 18637207623,
    Charge = 18686496907,
    Execute = 18637209873,
    Grab = 18637217215,
  }

  local v34 = false
  local boolValue = Instance.new("BoolValue")
  local v35 = false
  local boolValue2 = Instance.new("BoolValue")
  local v36 = false
  local boolValue3 = Instance.new("BoolValue")
  local v37 = {}

  local animation5 = Instance.new("Animation")
  animation5.AnimationId = "rbxassetid://102742789963001"

  local divineArt = localPlayer.Backpack:FindFirstChild("Divine Art")
    or localPlayer.Character and localPlayer.Character:FindFirstChild("Divine Art")

  if divineArt then
    divineArt:Destroy()
  end

  local divineArt2 = Instance.new("Tool")
  divineArt2.Name = "Divine Art"
  divineArt2.RequiresHandle = false
  divineArt2:SetAttribute("ItemId", 1262)
  divineArt2.ToolTip = "Melee"
  divineArt2.TextureId = "rbxassetid://78665997727824"
  divineArt2.Parent = localPlayer.Backpack

  local function f12()
    for key13, value16 in pairs(v37) do
    end

    v37 = {}
  end

  local v38

  local function f13()
    v29 = 0

    if v38 then
      task.cancel(v38)
      v38 = nil
    end
  end

  local function f14()
    if v38 then
      task.cancel(v38)
    end

    v38 = task.delay(1.5, function()
      v29 = 0
      v38 = nil
    end)
  end

  local animator6

  local function f15()
    if not animator6 or not animator6.Parent then
      local character = localPlayer.Character
      local humanoid7 = character and character:FindFirstChildOfClass("Humanoid")

      if humanoid7 then
        animator6 = humanoid7:FindFirstChild("Animator") or Instance.new("Animator", humanoid7)
      end
    end

    return animator6
  end

  local loadAnimation5

  local function f16(p12, p13)
    local v39 = f15()

    if not v39 then
      return nil
    else
      if loadAnimation5 then
        loadAnimation5:Stop()
      end

      local animation6 = Instance.new("Animation")
      animation6.AnimationId = "rbxassetid://" .. p12

      loadAnimation5 = v39:LoadAnimation(animation6)
      loadAnimation5:Play()

      if p13 then
        loadAnimation5.Looped = true
      end

      return loadAnimation5
    end
  end

  local loadAnimation6

  local function f17()
    local v40 = f15()

    if not v40 then
      return
    end

    if loadAnimation6 then
      loadAnimation6:Stop()
    end

    loadAnimation6 = v40:LoadAnimation(animation5)
    loadAnimation6:Play()
    loadAnimation6.Looped = true
  end

  local function f18()
    if loadAnimation6 then
      loadAnimation6:Stop()
      loadAnimation6 = nil
    end
  end

  local v41

  local function f19()
    if not v31 or not v30 then
      return
    else
      local character2 = localPlayer.Character

      if not character2 then
        return
      else
        local humanoidRootPart6 = character2:FindFirstChild("HumanoidRootPart")

        if not humanoidRootPart6 then
          return
        end

        if v38 then
          task.cancel(v38)
          v38 = nil
        end

        v29 = v29 + 1

        if v29 > 4 then
          v29 = 1
        end

        f18()
        v30 = false

        if v41 then
          v41:Stop()
        end

        v41 = f16(v32[v29], false)
        v23({ hrp = humanoidRootPart6, index = v29 })

        if v41 then
          v41.Stopped:Connect(function()
            v41 = nil
            v30 = true

            if v31 and not v34 and not v35 and not v36 then
              f17()
            end

            f14()
          end)
        else
          v30 = true

          if v31 and not v34 and not v35 and not v36 then
            f17()
          end

          f14()
        end

        return
      end
    end
  end

  local function f20()
    local v42 = not v31 or v34
    local humanoidRootPart7

    if v42 then
      return
    else
      local character3 = localPlayer.Character

      if not character3 then
        return
      end

      humanoidRootPart7 = character3:FindFirstChild("HumanoidRootPart")

      if not humanoidRootPart7 then
        return
      end

      v34 = true
      boolValue.Value = true
      f18()

      if v41 then
        v41:Stop()
        v41 = nil
      end

      f16(v33.Z, false)
      sound:Play("Angel A- Angel Hold", humanoidRootPart7.Position, nil, 0.8, 1)

      task.spawn(function()
        while v34 and v31 do
          local character4 = localPlayer.Character

          if not character4 then
            break
          else
            local humanoidRootPart8 = character4:FindFirstChild("HumanoidRootPart")

            if not humanoidRootPart8 then
              break
            end

            v24({ Root = humanoidRootPart8, Holding = boolValue })
            task.wait()
          end
        end
      end)

      task.spawn(function()
        task.wait(0.5)

        if v34 and v31 then
          f16(v33.Charge, true)
          sound:Play("AngelZChains", humanoidRootPart7.Position, nil, 0.7, 0.5)
        end
      end)

      return
    end
  end

  local function f21()
    local v43 = not v31 or not v34
    local humanoidRootPart9, v44

    if v43 then
      return
    else
      v34 = false
      boolValue.Value = false
      local character5 = localPlayer.Character

      if not character5 then
        return
      end

      humanoidRootPart9 = character5:FindFirstChild("HumanoidRootPart")

      if not humanoidRootPart9 then
        return
      end

      v44 = f10(humanoidRootPart9)
      f18()
      f16(v33.Execute, false)

      sound:Play("Angel A- Angel Release", humanoidRootPart9.Position, nil, 0.75, 1)
      sound:Play("Angel A- Angel Release_2", humanoidRootPart9.Position, nil, 0.7, 1.2)

      task.delay(0.3, function()
        sound:Play(
          "Angel A- Explosion", v44 and v44.Position or humanoidRootPart9.Position, nil, 0.8, 1
        )

        sound:Play(
          "AngelZExplosion", v44 and v44.Position or humanoidRootPart9.Position, nil, 0.75, 1.1
        )
      end)

      task.delay(0.5, function()
        sound:Play("AngelZDisappear2", humanoidRootPart9.Position, nil, 0.6, 1)
        sound:Play("Angel A- Body Disappear", humanoidRootPart9.Position, nil, 0.65, 1)
        sound:Play("Angel A- Body Disappear_2", humanoidRootPart9.Position, nil, 0.6, 1.1)
      end)

      v24({
        Root = humanoidRootPart9,
        CFrame = humanoidRootPart9.CFrame * CFrame.new(0, 0, -5),
        EnemyRoot = v44,
        Holding = nil,
        Hakai = true,
        ExplosionPos = v44 and v44.Position
          or humanoidRootPart9.Position + humanoidRootPart9.CFrame.LookVector * 10,
      })

      task.delay(0.3, function()
        if v31 and not v34 and not v35 and not v36 then
          f16(v33.Grab, false)
        end
      end)

      task.delay(0.8, function()
        if v31 and not v34 and not v35 and not v36 then
          f17()
        end
      end)

      return
    end
  end

  local function f22()
    if not v31 or v35 then
      return
    end

    local character6 = localPlayer.Character

    if not character6 then
      return
    end

    if not character6:FindFirstChild("HumanoidRootPart") then
      return
    end

    v35 = true
    boolValue2.Value = true
    f18()

    if v41 then
      v41:Stop()
      v41 = nil
    end

    f16(18686500373, true)

    task.spawn(function()
      if v25 then
        v25({ Character = character6, Holding = boolValue2 })
      end
    end)
  end

  local function f23()
    local v45 = not v31 or not v35
    local humanoidRootPart10

    if v45 then
      return
    else
      v35 = false
      boolValue2.Value = false
      local character7 = localPlayer.Character

      if not character7 then
        return
      end

      humanoidRootPart10 = character7:FindFirstChild("HumanoidRootPart")

      if not humanoidRootPart10 then
        return
      else
        f18()
        f16(18686502223, false)
        sound:Play("Angel B- Attack", humanoidRootPart10.Position, nil, 0.8, 1)

        task.delay(0.2, function()
          sound:Play("Angel B- Explosion", humanoidRootPart10.Position, nil, 0.75, 1)
        end)

        task.delay(0.5, function()
          sound:Play("Angel B- Enemy Chains", humanoidRootPart10.Position, nil, 0.7, 0.5)
        end)

        local v46 = f11(humanoidRootPart10, 120)

        if #v46 > 0 then
          for key14, value17 in pairs(v46) do
            local humanoidRootPart11 = value17[1]:FindFirstChild("HumanoidRootPart")

            if humanoidRootPart11 then
              task.spawn(function()
                if v26 then
                  v26({ hrp = humanoidRootPart11, lastsFor = 3 })
                end
              end)
            end
          end
        end

        if v26 then
          v26({ hrp = humanoidRootPart10, lastsFor = 2 })
        end

        if v27 then
          v27({ hrp = humanoidRootPart10, lastsFor = 2 })
        end

        task.delay(0.5, function()
          if v31 and not v34 and not v35 and not v36 then
            f17()
          end
        end)

        return
      end
    end
  end

  local v47

  local function f24()
    local v48 = not v31 or v36
    local humanoidRootPart12

    if v48 then
      return
    else
      local character8 = localPlayer.Character

      if not character8 then
        return
      end

      humanoidRootPart12 = character8:FindFirstChild("HumanoidRootPart")

      if not humanoidRootPart12 then
        return
      end

      f12()
      v36 = true
      boolValue3.Value = true
      f18()

      if v41 then
        v41:Stop()
        v41 = nil
      end

      if v47 then
        v47:Stop()
        v47 = nil
      end

      v47 = f16(18637218777, false)

      table.insert(v37, sound:Play(
        "Angel C- Angel Flames", humanoidRootPart12.Position + Vector3.new(0, 160, 0), nil,
        0.65, 1.5
      ))

      table.insert(
        v37, sound:Play("Angel C- Circle Hold", humanoidRootPart12.Position, nil, 0.7, 1)
      )

      task.wait(0.5)

      if v36 and v31 then
        v47 = f16(18637214138, true)

        table.insert(
          v37, sound:Play("Angel C- Arrow Fire", humanoidRootPart12.Position, nil, 0.8, 1)
        )
      end

      task.spawn(function()
        v28({
          Root = humanoidRootPart12,
          Holding = boolValue3,
          Victims = nil,
          Scale = 1,
        })
      end)

      return
    end
  end

  local function f25()
    local v49 = not v31 or not v36
    local v50, atLeastOneVictim

    if v49 then
      return
    else
      v36 = false
      boolValue3.Value = false
      local character9 = localPlayer.Character

      if not character9 then
        return
      else
        local humanoidRootPart13 = character9:FindFirstChild("HumanoidRootPart")

        if not humanoidRootPart13 then
          return
        end

        f18()

        if v47 then
          v47:Stop()
          v47 = nil
        end

        f12()
        v50 = f11(humanoidRootPart13, 120)

        if #v50 > 0 then
          f16(v33.Execute, false)

          atLeastOneVictim = Instance.new("BoolValue")
          atLeastOneVictim.Name = "atLeastOneVictim"
          atLeastOneVictim.Value = true
          atLeastOneVictim.Parent = humanoidRootPart13

          task.delay(10, function()
            if atLeastOneVictim then
              atLeastOneVictim:Destroy()
            end
          end)

          sound:Play("Angel C-Release", humanoidRootPart13.Position, nil, 0.75, 1)
          sound:Play("Angel C- Time Stop", humanoidRootPart13.Position, nil, 0.7, 1.2)
          sound:Play("Angel C- Time Ball Break", humanoidRootPart13.Position, nil, 0.65, 1)

          task.delay(2.5, function()
            for key15, value18 in pairs(v50) do
              local humanoidRootPart14 = value18[1]:FindFirstChild("HumanoidRootPart")

              if humanoidRootPart14 then
                sound:Play("Angel B- Enemy Chains", humanoidRootPart14.Position, nil, 1.1, 1)
              end
            end
          end)

          v28({
            Root = humanoidRootPart13,
            Holding = nil,
            Victims = v50,
            Scale = 1.5,
            Character = character9,
            player = localPlayer,
            HoldDuration = 3,
          })

          task.delay(0.5, function()
            if v31 and not v34 and not v35 and not v36 then
              f17()
            end
          end)
        else
          v47 = f16(18637218777, false)

          if v47 then
            v47.Stopped:Connect(function()
              if v31 and not v34 and not v35 and not v36 then
                f17()
              end
            end)
          end

          v28({
            Root = humanoidRootPart13,
            Holding = nil,
            Victims = nil,
            Scale = 1,
            Character = character9,
            player = localPlayer,
            HoldDuration = 0,
          })
        end

        return
      end
    end
  end

  divineArt2.Activated:Connect(function()
    if v31 then
      f19()
    end
  end)

  local connect

  divineArt2.Equipped:Connect(function()
    v31 = true
    local character10 = localPlayer.Character

    if character10 then
      local humanoid8 = character10:FindFirstChild("Humanoid")

      if humanoid8 then
        animator6 = humanoid8:FindFirstChild("Animator") or Instance.new("Animator", humanoid8)
      end
    end

    f17()
    f13()
    local getMouse = localPlayer:GetMouse()

    if connect then
      connect:Disconnect()
    end

    connect = getMouse.Button1Down:Connect(function() f19() end)
  end)

  divineArt2.Unequipped:Connect(function()
    v31 = false
    f18()

    if loadAnimation5 then
      loadAnimation5:Stop()
      loadAnimation5 = nil
    end

    if v41 then
      v41:Stop()
      v41 = nil
    end

    if v47 then
      v47:Stop()
      v47 = nil
    end

    f12()
    f13()
    v30 = true

    if connect then
      connect:Disconnect()
      connect = nil
    end

    v34 = false
    boolValue.Value = false
    v35 = false
    boolValue2.Value = false
    v36 = false
    boolValue3.Value = false
  end)

  userInputService.InputBegan:Connect(function(input3, p14)
    if userInputService:GetFocusedTextBox() then
      return
    end

    if not v31 then
      return
    end

    if input3.KeyCode == Enum.KeyCode.Z then
      f20()
    end

    if input3.KeyCode == Enum.KeyCode.X then
      f22()
    end

    if input3.KeyCode == Enum.KeyCode.C then
      f24()
    end

    if input3.UserInputType == Enum.UserInputType.MouseButton1
      or input3.UserInputType == Enum.UserInputType.Touch then
      f19()
    end
  end)

  userInputService.InputEnded:Connect(function(input4, p15)
    if not v31 then
      return
    end

    if input4.KeyCode == Enum.KeyCode.Z then
      f21()
    end

    if input4.KeyCode == Enum.KeyCode.X then
      f23()
    end

    if input4.KeyCode == Enum.KeyCode.C then
      f25()
    end
  end)
end

function v6.GiveCelestialArt(p16)
  v7.new("<Color=Purple>Quantum Onyx: Gifted you Celestial Art<Color=/>"):Display()
  local sound2 = require(replicatedStorage:WaitForChild("Util")).Sound

  local function f26(p17)
    local enemies3 = workspace:FindFirstChild("Enemies")

    if not enemies3 then
      return nil
    else
      local v51 = nil
      local huge2 = math.huge

      for key16, value19 in pairs(enemies3:GetChildren()) do
        if value19:IsA("Model") and value19 ~= localPlayer.Character then
          local humanoidRootPart15 = value19:FindFirstChild("HumanoidRootPart")
          local humanoid9 = value19:FindFirstChildOfClass("Humanoid")

          if humanoidRootPart15 and humanoid9 and humanoid9.Health > 0 then
            local magnitude2 = (humanoidRootPart15.Position - p17.Position).Magnitude

            if magnitude2 < huge2 and magnitude2 < 80 then
              huge2 = magnitude2
              v51 = humanoidRootPart15
            end
          end
        end
      end

      return v51
    end
  end

  local function f27(p18, p19)
    local v52 = {}
    local enemies4 = workspace:FindFirstChild("Enemies")

    if not enemies4 then
      return v52
    end

    for key17, value20 in pairs(enemies4:GetChildren()) do
      if value20:IsA("Model") and value20 ~= localPlayer.Character then
        local humanoid10 = value20:FindFirstChildOfClass("Humanoid")
        local humanoidRootPart16 = value20:FindFirstChild("HumanoidRootPart")

        if humanoid10 and humanoid10.Health > 0 and humanoidRootPart16 then
          if (humanoidRootPart16.Position - p18.Position).Magnitude < p19 then
            table.insert(v52, { value20, humanoidRootPart16.Position })
          end
        end
      end
    end

    return v52
  end

  local v53 = require(replicatedStorage.Effect.Container.Angel2.M1)
  local v54 = require(replicatedStorage.Effect.Container.Angel2.Z)
  local v55 = require(replicatedStorage.Effect.Container.Angel2.XCharge)
  local v56 = require(replicatedStorage.Effect.Container.Angel2.XCharChains)
  local v57 = require(replicatedStorage.Effect.Container.Angel2.XCameraChains)
  local v58 = require(replicatedStorage.Effect.Container.Angel2.C)
  local v59 = 0
  local v60 = true
  local v61 = false
  local v62 = { 18699539486, 18699541378, 18699542775, 18699545564 }

  local v63 = {
    Z = 18637207623,
    Charge = 18686496907,
    Execute = 18637209873,
    Grab = 18637217215,
  }

  local v64 = false
  local boolValue4 = Instance.new("BoolValue")
  local v65 = false
  local boolValue5 = Instance.new("BoolValue")
  local v66 = false
  local boolValue6 = Instance.new("BoolValue")
  local v67 = {}

  local animation7 = Instance.new("Animation")
  animation7.AnimationId = "rbxassetid://102742789963001"

  local celestialArt = localPlayer.Backpack:FindFirstChild("Celestial Art")
    or localPlayer.Character and localPlayer.Character:FindFirstChild("Celestial Art")

  if celestialArt then
    celestialArt:Destroy()
  end

  local celestialArt2 = Instance.new("Tool")
  celestialArt2.Name = "Celestial Art"
  celestialArt2.RequiresHandle = false
  celestialArt2:SetAttribute("ItemId", 603)
  celestialArt2.ToolTip = "Melee"
  celestialArt2.TextureId = "rbxassetid://138845532669661"
  celestialArt2.Parent = localPlayer.Backpack

  local function f28()
    for key18, value21 in pairs(v67) do
    end

    v67 = {}
  end

  local v68

  local function f29()
    v59 = 0

    if v68 then
      task.cancel(v68)
      v68 = nil
    end
  end

  local function f30()
    if v68 then
      task.cancel(v68)
    end

    v68 = task.delay(1.5, function()
      v59 = 0
      v68 = nil
    end)
  end

  local animator7

  local function f31()
    if not animator7 or not animator7.Parent then
      local character11 = localPlayer.Character
      local humanoid11 = character11 and character11:FindFirstChildOfClass("Humanoid")

      if humanoid11 then
        animator7 = humanoid11:FindFirstChild("Animator")
          or Instance.new("Animator", humanoid11)
      end
    end

    return animator7
  end

  local loadAnimation7

  local function f32(p20, p21)
    local v69 = f31()

    if not v69 then
      return nil
    else
      if loadAnimation7 then
        loadAnimation7:Stop()
      end

      local animation8 = Instance.new("Animation")
      animation8.AnimationId = "rbxassetid://" .. p20

      loadAnimation7 = v69:LoadAnimation(animation8)
      loadAnimation7:Play()

      if p21 then
        loadAnimation7.Looped = true
      end

      return loadAnimation7
    end
  end

  local loadAnimation8

  local function f33()
    local v70 = f31()

    if not v70 then
      return
    end

    if loadAnimation8 then
      loadAnimation8:Stop()
    end

    loadAnimation8 = v70:LoadAnimation(animation7)
    loadAnimation8:Play()
    loadAnimation8.Looped = true
  end

  local function f34()
    if loadAnimation8 then
      loadAnimation8:Stop()
      loadAnimation8 = nil
    end
  end

  local v71

  local f35

  function f35()
    if not v61 or not v60 then
      return
    else
      local character12 = localPlayer.Character

      if not character12 then
        return
      else
        local humanoidRootPart17 = character12:FindFirstChild("HumanoidRootPart")

        if not humanoidRootPart17 then
          return
        end

        if v68 then
          task.cancel(v68)
          v68 = nil
        end

        v59 = v59 + 1

        if v59 > 4 then
          v59 = 1
        end

        f34()
        v60 = false

        if v71 then
          v71:Stop()
        end

        v71 = f32(v62[v59], false)
        v53({ hrp = humanoidRootPart17, index = v59 })

        if v71 then
          v71.Stopped:Connect(function()
            v71 = nil
            v60 = true

            if v61 and not v64 and not v65 and not v66 then
              f33()
            end

            f30()
          end)
        else
          v60 = true

          if v61 and not v64 and not v65 and not v66 then
            f33()
          end

          f30()
        end

        return
      end
    end
  end

  local function f36()
    local v72 = not v61 or v64
    local humanoidRootPart18

    if v72 then
      return
    else
      local character13 = localPlayer.Character

      if not character13 then
        return
      end

      humanoidRootPart18 = character13:FindFirstChild("HumanoidRootPart")

      if not humanoidRootPart18 then
        return
      end

      v64 = true
      boolValue4.Value = true
      f34()

      if v71 then
        v71:Stop()
        v71 = nil
      end

      f32(v63.Z, false)
      sound2:Play("Angel A- Angel Hold", humanoidRootPart18.Position, nil, 0.8, 1)

      task.spawn(function()
        while v64 and v61 do
          local character14 = localPlayer.Character

          if not character14 then
            break
          else
            local humanoidRootPart19 = character14:FindFirstChild("HumanoidRootPart")

            if not humanoidRootPart19 then
              break
            end

            v54({ Root = humanoidRootPart19, Holding = boolValue4 })
            task.wait()
          end
        end
      end)

      task.spawn(function()
        task.wait(0.5)

        if v64 and v61 then
          f32(v63.Charge, true)
          sound2:Play("AngelZChains", humanoidRootPart18.Position, nil, 0.7, 0.5)
        end
      end)

      return
    end
  end

  local function f37()
    local v73 = not v61 or not v64
    local humanoidRootPart20, v74

    if v73 then
      return
    else
      v64 = false
      boolValue4.Value = false
      local character15 = localPlayer.Character

      if not character15 then
        return
      end

      humanoidRootPart20 = character15:FindFirstChild("HumanoidRootPart")

      if not humanoidRootPart20 then
        return
      end

      v74 = f26(humanoidRootPart20)
      f34()
      f32(v63.Execute, false)

      sound2:Play("Angel A- Angel Release", humanoidRootPart20.Position, nil, 0.75, 1)
      sound2:Play("Angel A- Angel Release_2", humanoidRootPart20.Position, nil, 0.7, 1.2)

      task.delay(0.3, function()
        sound2:Play(
          "Angel A- Explosion", v74 and v74.Position or humanoidRootPart20.Position, nil, 0.8, 1
        )

        sound2:Play(
          "AngelZExplosion", v74 and v74.Position or humanoidRootPart20.Position, nil, 0.75, 1.1
        )
      end)

      task.delay(0.5, function()
        sound2:Play("AngelZDisappear2", humanoidRootPart20.Position, nil, 0.6, 1)
        sound2:Play("Angel A- Body Disappear", humanoidRootPart20.Position, nil, 0.65, 1)
        sound2:Play("Angel A- Body Disappear_2", humanoidRootPart20.Position, nil, 0.6, 1.1)
      end)

      v54({
        Root = humanoidRootPart20,
        CFrame = humanoidRootPart20.CFrame * CFrame.new(0, 0, -5),
        EnemyRoot = v74,
        Holding = nil,
        Hakai = true,
        ExplosionPos = v74 and v74.Position
          or humanoidRootPart20.Position + humanoidRootPart20.CFrame.LookVector * 10,
      })

      task.delay(0.3, function()
        if v61 and not v64 and not v65 and not v66 then
          f32(v63.Grab, false)
        end
      end)

      task.delay(0.8, function()
        if v61 and not v64 and not v65 and not v66 then
          f33()
        end
      end)

      return
    end
  end

  local function f38()
    if not v61 or v65 then
      return
    end

    local character16 = localPlayer.Character

    if not character16 then
      return
    end

    if not character16:FindFirstChild("HumanoidRootPart") then
      return
    end

    v65 = true
    boolValue5.Value = true
    f34()

    if v71 then
      v71:Stop()
      v71 = nil
    end

    f32(18686500373, true)

    task.spawn(function()
      if v55 then
        v55({ Character = character16, Holding = boolValue5 })
      end
    end)
  end

  local function f39()
    local v75 = not v61 or not v65
    local humanoidRootPart21

    if v75 then
      return
    else
      v65 = false
      boolValue5.Value = false
      local character17 = localPlayer.Character

      if not character17 then
        return
      end

      humanoidRootPart21 = character17:FindFirstChild("HumanoidRootPart")

      if not humanoidRootPart21 then
        return
      else
        f34()
        f32(18686502223, false)
        sound2:Play("Angel B- Attack", humanoidRootPart21.Position, nil, 0.8, 1)

        task.delay(0.2, function()
          sound2:Play("Angel B- Explosion", humanoidRootPart21.Position, nil, 0.75, 1)
        end)

        task.delay(0.5, function()
          sound2:Play("Angel B- Enemy Chains", humanoidRootPart21.Position, nil, 0.7, 0.5)
        end)

        local v76 = f27(humanoidRootPart21, 120)

        if #v76 > 0 then
          for key19, value22 in pairs(v76) do
            local humanoidRootPart22 = value22[1]:FindFirstChild("HumanoidRootPart")

            if humanoidRootPart22 then
              task.spawn(function()
                if v56 then
                  v56({ hrp = humanoidRootPart22, lastsFor = 3 })
                end
              end)
            end
          end
        end

        if v56 then
          v56({ hrp = humanoidRootPart21, lastsFor = 2 })
        end

        if v57 then
          v57({ hrp = humanoidRootPart21, lastsFor = 2 })
        end

        task.delay(0.5, function()
          if v61 and not v64 and not v65 and not v66 then
            f33()
          end
        end)

        return
      end
    end
  end

  local v77

  local function f40()
    local v78 = not v61 or v66
    local humanoidRootPart23

    if v78 then
      return
    else
      local character18 = localPlayer.Character

      if not character18 then
        return
      end

      humanoidRootPart23 = character18:FindFirstChild("HumanoidRootPart")

      if not humanoidRootPart23 then
        return
      end

      f28()
      v66 = true
      boolValue6.Value = true
      f34()

      if v71 then
        v71:Stop()
        v71 = nil
      end

      if v77 then
        v77:Stop()
        v77 = nil
      end

      v77 = f32(18637218777, false)

      table.insert(v67, sound2:Play(
        "Angel C- Angel Flames", humanoidRootPart23.Position + Vector3.new(0, 160, 0), nil,
        0.65, 1.5
      ))

      table.insert(
        v67, sound2:Play("Angel C- Circle Hold", humanoidRootPart23.Position, nil, 0.7, 1)
      )

      task.wait(0.5)

      if v66 and v61 then
        v77 = f32(18637214138, true)

        table.insert(
          v67, sound2:Play("Angel C- Arrow Fire", humanoidRootPart23.Position, nil, 0.8, 1)
        )
      end

      task.spawn(function()
        v58({
          Root = humanoidRootPart23,
          Holding = boolValue6,
          Victims = nil,
          Scale = 1,
        })
      end)

      return
    end
  end

  local function f41()
    local v79 = not v61 or not v66
    local v80, atLeastOneVictim2

    if v79 then
      return
    else
      v66 = false
      boolValue6.Value = false
      local character19 = localPlayer.Character

      if not character19 then
        return
      else
        local humanoidRootPart24 = character19:FindFirstChild("HumanoidRootPart")

        if not humanoidRootPart24 then
          return
        end

        f34()

        if v77 then
          v77:Stop()
          v77 = nil
        end

        f28()
        v80 = f27(humanoidRootPart24, 120)

        if #v80 > 0 then
          f32(v63.Execute, false)

          atLeastOneVictim2 = Instance.new("BoolValue")
          atLeastOneVictim2.Name = "atLeastOneVictim"
          atLeastOneVictim2.Value = true
          atLeastOneVictim2.Parent = humanoidRootPart24

          task.delay(10, function()
            if atLeastOneVictim2 then
              atLeastOneVictim2:Destroy()
            end
          end)

          sound2:Play("Angel C-Release", humanoidRootPart24.Position, nil, 0.75, 1)
          sound2:Play("Angel C- Time Stop", humanoidRootPart24.Position, nil, 0.7, 1.2)
          sound2:Play("Angel C- Time Ball Break", humanoidRootPart24.Position, nil, 0.65, 1)

          task.delay(2.5, function()
            for key20, value23 in pairs(v80) do
              local humanoidRootPart25 = value23[1]:FindFirstChild("HumanoidRootPart")

              if humanoidRootPart25 then
                sound2:Play("Angel B- Enemy Chains", humanoidRootPart25.Position, nil, 1.1, 1)
              end
            end
          end)

          v58({
            Root = humanoidRootPart24,
            Holding = nil,
            Victims = v80,
            Scale = 1.5,
            Character = character19,
            player = localPlayer,
            HoldDuration = 3,
          })

          task.delay(0.5, function()
            if v61 and not v64 and not v65 and not v66 then
              f33()
            end
          end)
        else
          v77 = f32(18637218777, false)

          if v77 then
            v77.Stopped:Connect(function()
              if v61 and not v64 and not v65 and not v66 then
                f33()
              end
            end)
          end

          v58({
            Root = humanoidRootPart24,
            Holding = nil,
            Victims = nil,
            Scale = 1,
            Character = character19,
            player = localPlayer,
            HoldDuration = 0,
          })
        end

        return
      end
    end
  end

  celestialArt2.Activated:Connect(function()
    if v61 then
      f35()
    end
  end)

  local connect2

  celestialArt2.Equipped:Connect(function()
    v61 = true
    local character20 = localPlayer.Character

    if character20 then
      local humanoid12 = character20:FindFirstChild("Humanoid")

      if humanoid12 then
        animator7 = humanoid12:FindFirstChild("Animator")
          or Instance.new("Animator", humanoid12)
      end
    end

    f33()
    f29()
    local getMouse2 = localPlayer:GetMouse()

    if connect2 then
      connect2:Disconnect()
    end

    connect2 = getMouse2.Button1Down:Connect(function() f35() end)
  end)

  celestialArt2.Unequipped:Connect(function()
    v61 = false
    f34()

    if loadAnimation7 then
      loadAnimation7:Stop()
      loadAnimation7 = nil
    end

    if v71 then
      v71:Stop()
      v71 = nil
    end

    if v77 then
      v77:Stop()
      v77 = nil
    end

    f28()
    f29()
    v60 = true

    if connect2 then
      connect2:Disconnect()
      connect2 = nil
    end

    v64 = false
    boolValue4.Value = false
    v65 = false
    boolValue5.Value = false
    v66 = false
    boolValue6.Value = false
  end)

  userInputService.InputBegan:Connect(function(input5, p22)
    if userInputService:GetFocusedTextBox() then
      return
    end

    if not v61 then
      return
    end

    if input5.KeyCode == Enum.KeyCode.Z then
      f36()
    end

    if input5.KeyCode == Enum.KeyCode.X then
      f38()
    end

    if input5.KeyCode == Enum.KeyCode.C then
      f40()
    end

    if input5.UserInputType == Enum.UserInputType.MouseButton1
      or input5.UserInputType == Enum.UserInputType.Touch then
      f35()
    end
  end)

  userInputService.InputEnded:Connect(function(input6, p23)
    if not v61 then
      return
    end

    if input6.KeyCode == Enum.KeyCode.Z then
      f37()
    end

    if input6.KeyCode == Enum.KeyCode.X then
      f39()
    end

    if input6.KeyCode == Enum.KeyCode.C then
      f41()
    end
  end)
end

function v6.GiveFruitRain(p24)
  v7.new("<Color=Purple>Quantum Onyx: Rain Fruits<Color=/>"):Display()

  task.spawn(function()
    local character21 = localPlayer.Character or localPlayer.CharacterAdded:Wait()
    local humanoidRootPart26 = character21:WaitForChild("HumanoidRootPart")
    local humanoid13 = character21:WaitForChild("Humanoid")
    local backpack2 = localPlayer:WaitForChild("Backpack")
    local getMouse3 = localPlayer:GetMouse()
    local rbxassetid96375671161494 = f1("rbxassetid://96375671161494")
    local v81, v82, v83, f42, f43, f44, f45, f46, f47, f48

    if not rbxassetid96375671161494 or not rbxassetid96375671161494[1] then
      return
    else
      local fruits = rbxassetid96375671161494[1]:FindFirstChild("Fruits")
        or rbxassetid96375671161494[1]:GetChildren()[1]

      if not fruits then
        return
      else
        v81 = {
          blade = "rbxassetid://108920269089389",
          blizzard = "rbxassetid://139287413349875",
          bomb = "rbxassetid://109936761585759",
          buddha = "rbxassetid://70468445918253",
          control = "rbxassetid://138452891864238",
          creation = "rbxassetid://90979963965915",
          dark = "rbxassetid://105850830226314",
          diamond = "rbxassetid://138621444139835",
          dough = "rbxassetid://137318286758185",
          east = "rbxassetid://82632092516701",
          west = "rbxassetid://90144652761537",
          flame = "rbxassetid://100529802309283",
          falcon = "rbxassetid://72037523265892",
          gas = "rbxassetid://116726287284658",
          ghost = "rbxassetid://103241343046901",
          gravity = "rbxassetid://82911190033272",
          ice = "rbxassetid://138150083610098",
          kitsune = "rbxassetid://123199021007709",
          light = "rbxassetid://98334300171176",
          Lighting = "rbxassetid://75076261351086",
          love = "rbxassetid://121800275906431",
          magma = "rbxassetid://110499104628953",
        }

        v82 = {
          dark = { id = "rbxassetid://108944808701688", offset = Vector2.new(1, 457) },
          eagle = { id = "rbxassetid://108944808701688", offset = Vector2.new(457, 1) },
          diamond = { id = "rbxassetid://108944808701688", offset = Vector2.new(1, 609) },
          light = { id = "rbxassetid://108944808701688", offset = Vector2.new(609, 153) },
          rubber = { id = "rbxassetid://114306691107939", offset = Vector2.new(609, 1) },
          ghost = { id = "rbxassetid://108944808701688", offset = Vector2.new(153, 305) },
          magma = { id = "rbxassetid://108944808701688", offset = Vector2.new(305, 457) },
          quake = { id = "rbxassetid://108944808701688", offset = Vector2.new(609, 305) },
          buddha = { id = "rbxassetid://108944808701688", offset = Vector2.new(1, 153) },
          love = { id = "rbxassetid://108944808701688", offset = Vector2.new(305, 305) },
          creation = { id = "rbxassetid://108944808701688", offset = Vector2.new(1, 305) },
          spider = { id = "rbxassetid://108944808701688", offset = Vector2.new(457, 457) },
          sound = { id = "rbxassetid://108944808701688", offset = Vector2.new(761, 305) },
          phoenix = { id = "rbxassetid://114306691107939", offset = Vector2.new(457, 457) },
          lightning = { id = "rbxassetid://108944808701688", offset = Vector2.new(761, 153) },
          pain = { id = "rbxassetid://108944808701688", offset = Vector2.new(305, 761) },
          mammoth = { id = "rbxassetid://108944808701688", offset = Vector2.new(305, 609) },
          blizzard = { id = "rbxassetid://114306691107939", offset = Vector2.new(1, 457) },
          gravity = { id = "rbxassetid://108944808701688", offset = Vector2.new(153, 457) },
          trex = { id = "rbxassetid://108944808701688", offset = Vector2.new(609, 609) },
          shadow = { id = "rbxassetid://114306691107939", offset = Vector2.new(609, 305) },
          dough = { id = "rbxassetid://108944808701688", offset = Vector2.new(1, 761) },
          venom = { id = "rbxassetid://108944808701688", offset = Vector2.new(609, 761) },
          gas = { id = "rbxassetid://108944808701688", offset = Vector2.new(153, 153) },
          spirit = { id = "rbxassetid://108944808701688", offset = Vector2.new(609, 457) },
          control = { id = "rbxassetid://114306691107939", offset = Vector2.new(1, 761) },
          east = { id = "rbxassetid://108944808701688", offset = Vector2.new(153, 1) },
          west = { id = "rbxassetid://108944808701688", offset = Vector2.new(305, 1) },
          yeti = { id = "rbxassetid://108944808701688", offset = Vector2.new(761, 609) },
          kitsune = { id = "rbxassetid://108944808701688", offset = Vector2.new(305, 153) },
        }

        v83 = {}

        function f42(p25, p26)
          for index4, value24 in ipairs(p25:GetDescendants()) do
            if value24:IsA("BasePart") then
              value24.CanCollide = not p26
            end
          end
        end

        function f43(p27)
          local handle = p27:FindFirstChild("Handle") or p27:FindFirstChildWhichIsA("BasePart")

          if not handle then
            return
          end

          if v83[p27] then
            v83[p27]:Disconnect()
            v83[p27] = nil
          end

          local v84 = false

          v83[p27] = handle.Touched:Connect(function(part)
            local toolIcon

            if v84 then
              return
            elseif not part:IsDescendantOf(character21) then
              return
            else
              v84 = true
              local lower = p27.Name:lower()

              for key21, value25 in pairs(v81) do
                local image = value25

                if string.find(lower, key21) then
                  toolIcon = p27:FindFirstChild("ToolIcon")

                  if toolIcon and toolIcon:IsA("ImageLabel") then
                    pcall(function() toolIcon.Image = image end)
                  end

                  break
                end
              end

              p27.Parent = backpack2
              f42(p27, true)
              task.wait()
              humanoid13:EquipTool(p27)
              task.wait(1)
              v84 = false
              return
            end
          end)
        end

        function f44(p28)
          return "<" .. p28:gsub("%s*[Ff]ruit%s*$", ""):match("^%s*(.-)%s*$") .. ">"
        end

        function f45()
          for index5, value26 in ipairs(backpack2:GetChildren()) do
            if value26:IsA("Tool") and value26.ToolTip == "Blox Fruit" then
              return value26
            end
          end

          for index6, value27 in ipairs(character21:GetChildren()) do
            if value27:IsA("Tool") and value27.ToolTip == "Blox Fruit" then
              return value27
            end
          end
        end

        function f46()
          local animation9 = Instance.new("Animation")
          animation9.AnimationId = "rbxassetid://10851812420"

          local loadAnimation9 = humanoid13:LoadAnimation(animation9)
          loadAnimation9:AdjustSpeed(2)
          loadAnimation9:Play()

          local v85 = false
          loadAnimation9.Stopped:Connect(function() v85 = true end)

          while not v85 do
            task.wait()
          end

          loadAnimation9:Destroy()
          animation9:Destroy()
        end

        local getChildren = fruits.GetChildren

        function f47(p29, p30)
          local lower2 = p30:lower()
          local toolIcon2

          for key22, value28 in pairs(v82) do
            local v86 = value28

            if string.find(lower2, key22, 1, true) then
              toolIcon2 = p29:FindFirstChild("ToolIcon")

              if toolIcon2 and toolIcon2:IsA("ImageLabel") then
                pcall(function()
                  toolIcon2.Image = v86.id
                  toolIcon2.ImageRectOffset = v86.offset
                  toolIcon2.ImageRectSize = Vector2.new(150, 150)
                end)
              end

              break
            end
          end
        end

        function f48(p31)
          local v87 = require(replicatedStorage.DialogueController)
          local character22 = localPlayer.Character
          local humanoid14 = character22 and character22:FindFirstChild("Humanoid")

          v87:Start({
            Title = "Blox Fruit",
            Get = function()
              return {
                Text = { "What do you wish to do with this Blox Fruit?" },
                Option1 = {
                  Label = "Eat",
                  JumpTo = function()
                    if v83[p31] then
                      v83[p31]:Disconnect()
                      v83[p31] = nil
                    end

                    local name = p31.Name
                    local v88 = f45()

                    task.spawn(function()
                      if v88 then
                        f46()
                        p31:Destroy()
                        v7.new("<Color=Green>Blox Fruit " .. f44(name) .. " activated.<Color=/>"):Display()
                        task.wait(0.5)
                        f47(v88, name)
                      else
                        f46()
                        task.wait(0.5)
                        p31:Destroy()
                        v7.new("<Color=Green>Blox Fruit " .. f44(name) .. " activated. <Color=/>"):Display()
                      end
                    end)

                    return { Text = { "[Eating Blox Fruit...]" } }
                  end,
                },
                Option2 = {
                  Label = "Drop",
                  JumpTo = function()
                    f42(p31, false)

                    if humanoid14 then
                      humanoid14:UnequipTools()
                    end

                    task.wait()

                    if character21 then
                      local humanoidRootPart27 = character21:FindFirstChild("HumanoidRootPart")

                      if humanoidRootPart27 then
                        p31.Parent = workspace
                        local v89 = humanoidRootPart27.Position + Vector3.new(0, 3, 0)

                        if p31:IsA("Model") then
                          if p31.PrimaryPart then
                            p31:SetPrimaryPartCFrame(CFrame.new(v89))
                          end
                        elseif p31:IsA("Tool") then
                          local handle2 = p31:FindFirstChild("Handle")

                          if handle2 then
                            handle2.CFrame = CFrame.new(v89)
                          end
                        end

                        f43(p31)
                      end
                    end

                    return { Text = { "[Blox Fruit dropped.]" } }
                  end,
                },
                Option3 = {
                  Label = "Store",
                  JumpTo = function()
                    f42(p31, false)

                    if humanoid14 then
                      humanoid14:UnequipTools()
                    end

                    task.wait()
                    local backpack3 = localPlayer:FindFirstChild("Backpack")

                    if backpack3 then
                      p31.Parent = backpack3
                      f42(p31, true)
                    end

                    return { Text = { "[Blox Fruit stored.]" } }
                  end,
                },
              }
            end,
          })
        end

        getMouse3.Button1Down:Connect(function()
          local target = getMouse3.Target

          if target and target:IsA("GuiObject") then
            return
          else
            local tool = character21:FindFirstChildOfClass("Tool")

            if tool and collectionService:HasTag(tool, "VisualFruit") then
              f48(tool)
            end

            return
          end
        end)

        for index7, value29 in ipairs(getChildren(fruits)) do
          for index8, value30 in ipairs(value29:GetDescendants()) do
            if value30:IsA("BasePart") then
              value30.CanCollide = true
              value30.CanTouch = true
            end
          end

          collectionService:AddTag(value29, "VisualFruit")

          value29:SetAttribute("ItemId", 20)
          value29.ToolTip = "Blox Fruit"
          value29.Parent = workspace

          value29:PivotTo(CFrame.new(humanoidRootPart26.Position
            + Vector3.new(math.random(-50, 50), 10, math.random(-50, 50))))

          f43(value29)
        end

        game.DescendantRemoving:Connect(function(descendant)
          if v83[descendant] then
            v83[descendant]:Disconnect()
            v83[descendant] = nil
          end
        end)

        character21.ChildAdded:Connect(function(child)
          if child:IsA("Tool") and collectionService:HasTag(child, "VisualFruit") then
            f42(child, true)
          end
        end)

        character21.ChildRemoved:Connect(function(child2)
          if child2:IsA("Tool") and collectionService:HasTag(child2, "VisualFruit") then
            if child2.Parent == backpack2 then
              f42(child2, true)
            else
              f42(child2, false)

              if child2.Parent == workspace then
                f43(child2)
              end
            end
          end
        end)

        backpack2.ChildAdded:Connect(function(child3)
          if child3:IsA("Tool") and collectionService:HasTag(child3, "VisualFruit") then
            f42(child3, true)
          end
        end)

        backpack2.ChildRemoved:Connect(function(child4)
          if child4:IsA("Tool") and collectionService:HasTag(child4, "VisualFruit") then
            if child4.Parent == workspace then
              f42(child4, false)
              f43(child4)
            elseif child4.Parent ~= character21 then
              f42(child4, false)

              if child4.Parent == workspace then
                f43(child4)
              end
            end
          end
        end)

        return
      end
    end
  end)
end

function v6.GiveAllKamuis(p32)
  v7.new("<Color=Purple>Quantum Onyx: Gifted you All Kamui<Color=/>"):Display()

  local function f49()
    for index9, value31 in ipairs({
      "RipFamilyHideout", "Dimension", "Arena", "Pakistan Dimension", "RedLegionHideout",
    }) do
      local findFirstChild9 = workspace:FindFirstChild(value31)

      if findFirstChild9 then
        findFirstChild9:Destroy()
      end
    end
  end

  local function f50()
    local vfxkamui = Instance.new("Part")
    vfxkamui.Name = "vfxkamui"
    vfxkamui.Transparency = 1
    vfxkamui.Size = Vector3.new(1, 1, 1)
    vfxkamui.Anchored = true
    vfxkamui.CanCollide = false
    vfxkamui.Parent = workspace

    local function f51(name2, p33)
      local particleEmitter = Instance.new("ParticleEmitter")
      particleEmitter.Name = name2

      for key23, value32 in pairs(p33) do
        particleEmitter[key23] = value32
      end

      particleEmitter.Parent = vfxkamui
    end

    f51("Hole", {
      Speed = NumberRange.new(0, 0),
      Rotation = NumberRange.new(-360, 360),
      Color = ColorSequence.new(Color3.new(0.509804, 0, 0.564706)),
      Texture = "rbxassetid://1244829143",
      Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0),
        NumberSequenceKeypoint.new(1, 1),
      }),
      ZOffset = 1,
      Size = NumberSequence.new(4.6875, 0),
      Lifetime = NumberRange.new(0.4, 0.4),
      Rate = 60,
      RotSpeed = NumberRange.new(30, 30),
    })

    f51("Particle1", {
      Speed = NumberRange.new(10, 10),
      Color = ColorSequence.new(Color3.new(0.388235, 0, 0.584314)),
      LightInfluence = 1,
      Texture = "rbxassetid://867619398",
      Size = NumberSequence.new(0, 0.1875),
      Lifetime = NumberRange.new(0.25, 1),
      Rate = 100,
      SpreadAngle = Vector2.new(180, -180),
      VelocitySpread = 180,
    })

    f51("Particle2", {
      Speed = NumberRange.new(10, 10),
      Color = ColorSequence.new(Color3.new(0.266667, 0, 0.407843)),
      LightInfluence = 1,
      Texture = "rbxassetid://867619398",
      Size = NumberSequence.new(0, 0.3),
      Lifetime = NumberRange.new(0.25, 1),
      Rate = 100,
      SpreadAngle = Vector2.new(170, -170),
      VelocitySpread = 170,
    })

    Instance.new("PointLight").Parent = vfxkamui
    return vfxkamui
  end

  local function f52(p34)
    if p34 then
      for index10, value33 in ipairs(p34:GetChildren()) do
        if value33:IsA("ParticleEmitter") then
          value33.Enabled = false
        end
      end

      task.delay(1.5, function()
        if p34 and p34.Parent then
          p34:Destroy()
        end
      end)
    end
  end

  local function f53()
    local sound3 = Instance.new("Sound")
    sound3.SoundId = "rbxassetid://95959796644775"
    sound3.Volume = 10
    sound3.Parent = workspace
    sound3:Play()
    sound3.Ended:Connect(function() sound3:Destroy() end)
  end

  local function f54(p35)
    for key24, value34 in pairs(lighting:GetChildren()) do
      if value34:IsA("ColorCorrectionEffect") or value34:IsA("BlurEffect")
        or value34:IsA("BloomEffect") then
        value34:Destroy()
      end
    end
  end

  local function f55(p36)
    f54(p36)

    local colorCorrectionEffect = Instance.new("ColorCorrectionEffect")
    colorCorrectionEffect.Parent = lighting
    colorCorrectionEffect.TintColor = Color3.fromRGB(255, 80, 80)
    colorCorrectionEffect.Brightness = 0.3
    colorCorrectionEffect.Contrast = 0.5
    colorCorrectionEffect.Saturation = 1

    table.insert(p36, colorCorrectionEffect)

    local blurEffect = Instance.new("BlurEffect")
    blurEffect.Parent = lighting
    blurEffect.Size = 10

    table.insert(p36, blurEffect)

    local bloomEffect = Instance.new("BloomEffect")
    bloomEffect.Parent = lighting
    bloomEffect.Intensity = 1
    bloomEffect.Size = 24
    bloomEffect.Threshold = 0

    table.insert(p36, bloomEffect)
  end

  local function f56(p37, p38, p39, p40, p41)
    local getExtentsSize = p37:GetExtentsSize()
    local getModelCFrame = p37:GetModelCFrame()
    local v90 = getExtentsSize / 2
    local v91 = false
    local v92 = false

    local function f57()
      local character23 = localPlayer.Character
      local humanoidRootPart28 = character23 and character23:FindFirstChild("HumanoidRootPart")

      if not humanoidRootPart28 then
        return false
      end

      for index11, value35 in ipairs(p37:GetDescendants()) do
        if value35.Name:find("Hitbox") and value35:IsA("BasePart") then
          local pointToObjectSpace = value35.CFrame:PointToObjectSpace(humanoidRootPart28.Position)
          local v93 = value35.Size / 2

          if math.abs(pointToObjectSpace.X) < v93.X and math.abs(pointToObjectSpace.Y) < v93.Y
            and math.abs(pointToObjectSpace.Z) < v93.Z then
            return true
          end
        end
      end

      return false
    end

    local function f58(name3, cframe5, size)
      local part2 = Instance.new("Part")
      part2.Name = name3
      part2.Size = size
      part2.CFrame = cframe5
      part2.Anchored = true
      part2.CanCollide = false
      part2.Transparency = 1
      part2.Parent = p37

      part2.Touched:Connect(function(part3)
        local character24 = localPlayer.Character

        if not character24 then
          return
        end

        if part3 ~= character24:FindFirstChild("HumanoidRootPart") then
          return
        end

        if v91 or v92 then
          return
        end

        v92 = true
        v91 = true

        if p40 then
          p40()
        end

        task.delay(0.5, function() v92 = false end)
      end)

      part2.TouchEnded:Connect(function(part4)
        local character25 = localPlayer.Character

        if not character25 then
          return
        end

        if part4 ~= character25:FindFirstChild("HumanoidRootPart") then
          return
        end

        if not v91 or v92 then
          return
        end

        task.wait(0.15)

        if not f57() and v91 then
          v92 = true
          v91 = false

          if p41 then
            p41()
          end

          task.delay(0.5, function() v92 = false end)
        end
      end)
    end

    f58("HitboxCenter", getModelCFrame, getExtentsSize)

    f58(
      "HitboxTop", getModelCFrame * CFrame.new(0, v90.Y, 0),
      Vector3.new(getExtentsSize.X, getExtentsSize.Y / 2, getExtentsSize.Z)
    )

    f58(
      "HitboxBottom", getModelCFrame * CFrame.new(0, -v90.Y, 0),
      Vector3.new(getExtentsSize.X, getExtentsSize.Y / 2, getExtentsSize.Z)
    )

    f58(
      "HitboxLeft", getModelCFrame * CFrame.new(-v90.X, 0, 0),
      Vector3.new(getExtentsSize.X / 2, getExtentsSize.Y, getExtentsSize.Z)
    )

    f58(
      "HitboxRight", getModelCFrame * CFrame.new(v90.X, 0, 0),
      Vector3.new(getExtentsSize.X / 2, getExtentsSize.Y, getExtentsSize.Z)
    )

    f58(
      "HitboxFront", getModelCFrame * CFrame.new(0, 0, -v90.Z),
      Vector3.new(getExtentsSize.X, getExtentsSize.Y, getExtentsSize.Z / 2)
    )

    f58(
      "HitboxBack", getModelCFrame * CFrame.new(0, 0, v90.Z),
      Vector3.new(getExtentsSize.X, getExtentsSize.Y, getExtentsSize.Z / 2)
    )
  end

  local function f59(p42, fn)
    local v94, v95 = f1("rbxassetid://" .. tostring(p42))

    if v94 and v94[1] then
      fn(v94[1])
    else
      warn("[Visuals] Failed to load Kamui model asset:", p42, v95)
    end
  end

  local v96 = {
    ["rip kamui"] = 1191,
    ["arena kamui"] = 1235,
    ["heaven kamui"] = 1236,
    ["pakistan kamui"] = 1173,
    kamui = 1173,
  }

  local function f60(p43, p44, fn2)
    local tool2 = Instance.new("Tool")
    tool2.Name = p43

    local lower3 = p43.lower

    tool2.RequiresHandle = false
    tool2:SetAttribute("ItemId", v96[lower3(p43)] or 1173)
    tool2.ToolTip = "Tool"
    tool2.Parent = localPlayer.Backpack

    local v97 = false

    tool2.Equipped:Connect(function() v97 = true end)
    tool2.Unequipped:Connect(function() v97 = false end)

    tool2.Activated:Connect(function()
      if v97 then
        fn2()
      end
    end)

    localPlayer.Chatted:Connect(function(message)
      if message:lower() == p44 then
        fn2()
      end
    end)

    return tool2
  end

  local function f61(p45)
    local character26, humanoidRootPart29, humanoid15, v98, v99, v100, v101, connect3, v102,
      v103, v104, connect4

    if p45.isActive then
      return
    else
      p45.isActive = true
      character26 = localPlayer.Character or localPlayer.CharacterAdded:Wait()
      humanoidRootPart29 = character26:WaitForChild("HumanoidRootPart")

      p45.character = character26
      p45.hrp = humanoidRootPart29

      humanoid15 = character26:FindFirstChild("Humanoid")

      if humanoid15 then
        humanoid15.WalkSpeed = 0
        humanoid15.JumpPower = 0
        humanoid15.PlatformStand = true
      end

      local v105 = humanoidRootPart29.Position + Vector3.new(0, 2, 0)
      humanoidRootPart29.CFrame = CFrame.new(v105)
      v98 = f50()
      p45.vfxPart = v98
      v99 = v105
      v100 = 0
      v101 = 200

      connect3 = nil

      connect3 = runService.Heartbeat:Connect(function()
        if humanoidRootPart29 and humanoidRootPart29.Parent and v99 then
          humanoidRootPart29.CFrame = CFrame.new(v99) * CFrame.Angles(0, 0, math.rad(v100))

          if v98 and v98.Parent then
            v98.CFrame = humanoidRootPart29.CFrame
          end
        end
      end)

      v102 = true

      task.spawn(function()
        while v102 and character26 and character26.Parent do
          for index12, value36 in ipairs(character26:GetDescendants()) do
            if value36:IsA("BasePart") then
              value36.CanCollide = false
            end
          end

          task.wait(0.1)
        end
      end)

      v103 = 0

      local connect5 = runService.Heartbeat:Connect(function(delta)
        v100 = v100 + v101 * delta
        v103 = v103 + v101 * delta

        if p45.guiImage then
          p45.guiImage.Rotation = v103
        end
      end)

      task.delay(0.5, function() v101 = 400 end)
      local v106 = {}
      f55(v106)
      f53()

      if p45.gui then
        p45.gui:Destroy()
      end

      local screenGui = Instance.new("ScreenGui")
      screenGui.Name = p45.guiName
      screenGui.ResetOnSpawn = false
      screenGui.Parent = localPlayer:WaitForChild("PlayerGui")

      local imageLabel = Instance.new("ImageLabel")
      imageLabel.BackgroundTransparency = 1
      imageLabel.Parent = screenGui
      imageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
      imageLabel.Position = UDim2.new(0.5, 0, 0.45, 0)
      imageLabel.Size = UDim2.new(0, 250, 0, 250)
      imageLabel.Image = p45.imageId

      local udim = UDim2.new(0, 350, 0, 350)

      tweenService:Create(
        imageLabel, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        { Size = udim }
      ):Play()

      p45.gui = screenGui
      p45.guiImage = imageLabel

      task.wait(1)

      p45.loadModelAndTeleport(humanoidRootPart29, character26, function(p46)
        v99 = p46
        v102 = false
        task.wait(0.15)

        if character26 and character26.Parent then
          for index13, value37 in ipairs(character26:GetDescendants()) do
            if value37:IsA("BasePart") then
              value37.CanCollide = true
            end
          end
        end
      end)

      task.wait(0.5)

      if p45.guiImage then
        local udim2 = UDim2.new(0, 250, 0, 250)
        local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

        local create = tweenService:Create(p45.guiImage, tweenInfo, {
          Size = udim2,
          ImageTransparency = 1,
        })

        create:Play()
        create.Completed:Wait()
      end

      f54(v106)
      task.wait(1)

      if connect5 then
        connect5:Disconnect()
      end

      v104 = math.round(v100 / 360) * 360

      connect4 = nil

      connect4 = runService.Heartbeat:Connect(function(delta2)
        local v107 = v104 - v100

        if math.abs(v107) < 1 then
          v100 = v104
          connect4:Disconnect()

          if connect3 then
            connect3:Disconnect()
            connect3 = nil
          end

          if humanoidRootPart29 and humanoidRootPart29.Parent then
            humanoidRootPart29.CFrame = CFrame.new(v99)
          end

          f52(v98)

          if humanoid15 then
            humanoid15.WalkSpeed = 16
            humanoid15.JumpPower = 50
            humanoid15.PlatformStand = false
          end

          p45.isActive = false
        else
          v100 = v100 + math.sign(v107) * math.min(v101 * delta2, math.abs(v107))

          if humanoidRootPart29 and humanoidRootPart29.Parent then
            humanoidRootPart29.CFrame = CFrame.new(v99) * CFrame.Angles(0, 0, math.rad(v100))

            if v98 and v98.Parent then
              v98.CFrame = humanoidRootPart29.CFrame
            end
          end
        end
      end)

      return
    end
  end

  local function f62()
    local v108 = {
      isActive = false,
      gui = nil,
      guiImage = nil,
      guiName = "RipKamui",
      imageId = "rbxassetid://123270704863428",
    }

    function v108.loadModelAndTeleport(p47, p48, fn3)
      f49()

      f59(125770498258420, function(p49)
        p49.Parent = workspace
        local findFirstChild10 = p49:FindFirstChild("Spawnpos", true)

        if findFirstChild10 then
          local getModelCFrame2 = p49:GetModelCFrame()

          p49:PivotTo(CFrame.new(Vector3.new(
            p47.Position.X, p47.Position.Y + 99999, p47.Position.Z
          ) + (getModelCFrame2.Position - findFirstChild10.Position)))

          for i = 1, 3 do
            p47.CFrame = CFrame.new(findFirstChild10.Position)
            task.wait(0.05)
          end

          fn3(findFirstChild10.Position)
          f56(p49, "<Rip_Family Hideout>", "<Sea>", nil, nil)
        end
      end)
    end

    f60("rip kamui", "kamui2", function() f61(v108) end)
  end

  local function f63()
    local v109 = {
      isActive = false,
      gui = nil,
      guiImage = nil,
      guiName = "ArenaKamui",
      imageId = "rbxassetid://123270704863428",
    }

    function v109.loadModelAndTeleport(p50, p51, fn4)
      f49()

      f59(95297968392131, function(p52)
        if not p52 then
          return
        else
          p52.Parent = workspace
          local findFirstChild11 = p52:FindFirstChild("Spawn", true)

          if not findFirstChild11 then
            return
          else
            local toObjectSpace = p52:GetModelCFrame():ToObjectSpace(findFirstChild11.CFrame)

            p52:PivotTo(CFrame.new(p50.Position.X, p50.Position.Y + 99999, p50.Position.Z)
              * toObjectSpace:Inverse())

            for j = 1, 3 do
              p50.CFrame = CFrame.new(findFirstChild11.Position)
              task.wait(0.05)
            end

            fn4(findFirstChild11.Position)
            f56(p52, "<Rip_Family x Red_Legion Arena>", "<Sea>", nil, nil)
            return
          end
        end
      end)
    end

    f60("arena kamui", "kamui4", function() f61(v109) end)
  end

  local function f64()
    local v110 = {
      isActive = false,
      gui = nil,
      guiImage = nil,
      guiName = "HeavenKamui",
      imageId = "rbxassetid://123270704863428",
    }

    function v110.loadModelAndTeleport(p53, p54, fn5)
      f49()

      f59(83204770964519, function(p55)
        p55.Parent = workspace
        local findFirstChild12 = p55:FindFirstChild("Spawn", true)

        if findFirstChild12 then
          local toObjectSpace2 = p55:GetModelCFrame():ToObjectSpace(findFirstChild12.CFrame)

          p55:PivotTo(CFrame.new(p53.Position.X, p53.Position.Y + 99999, p53.Position.Z)
            * toObjectSpace2:Inverse())

          for k = 1, 3 do
            p53.CFrame = CFrame.new(findFirstChild12.Position)
            task.wait(0.05)
          end

          fn5(findFirstChild12.Position)
          f56(p55, "<Red_Legion Hideout>", "<Sea>", nil, nil)
        end
      end)
    end

    f60("heaven kamui", "kamui3", function() f61(v110) end)
  end

  local function f65()
    local v111 = {
      isActive = false,
      gui = nil,
      guiImage = nil,
      guiName = "PakistanKamui",
      imageId = "rbxassetid://123270704863428",
    }

    function v111.loadModelAndTeleport(p56, p57, fn6)
      f49()

      f59(87737109817581, function(p58)
        p58.Parent = workspace
        local findFirstChild13 = p58:FindFirstChild("Spawn", true)

        if findFirstChild13 then
          local getModelCFrame3 = p58:GetModelCFrame()

          p58:PivotTo(CFrame.new(Vector3.new(
            p56.Position.X, p56.Position.Y + 99999, p56.Position.Z
          ) + (getModelCFrame3.Position - findFirstChild13.Position)))

          for m = 1, 3 do
            p56.CFrame = CFrame.new(findFirstChild13.Position)
            task.wait(0.05)
          end

          fn6(findFirstChild13.Position)
          f56(p58, "<Pakistan Dimension>", "<Sea>", nil, nil)
        end
      end)
    end

    f60("pakistan kamui", "kamui5", function() f61(v111) end)
  end

  local function f66()
    local v112 = {
      isActive = false,
      gui = nil,
      guiImage = nil,
      guiName = "PocketKamui",
      imageId = "rbxassetid://94044166423780",
    }

    function v112.loadModelAndTeleport(p59, p60, fn7)
      f49()

      f59(126471018068720, function(p61)
        p61.Parent = workspace
        local findFirstChild14 = p61:FindFirstChild("Spawnpos", true)

        if findFirstChild14 then
          local getModelCFrame4 = p61:GetModelCFrame()

          p61:PivotTo(CFrame.new(Vector3.new(
            p59.Position.X, p59.Position.Y + 99999, p59.Position.Z
          ) + (getModelCFrame4.Position - findFirstChild14.Position)))

          for n = 1, 3 do
            p59.CFrame = CFrame.new(findFirstChild14.Position)
            task.wait(0.05)
          end

          fn7(findFirstChild14.Position)
          f56(p61, "<Pocket Dimension>", "<Sea>", nil, nil)
        end
      end)
    end

    f60("kamui", "kamui", function() f61(v112) end)
  end

  local v113 = { "pakistan kamui", "arena kamui", "heaven kamui", "rip kamui", "kamui" }

  local function f67(p62)
    for index14, value38 in ipairs(p62:GetChildren()) do
      if value38:IsA("Tool") then
        for index15, value39 in ipairs(v113) do
          if value38.Name:lower() == value39 then
            value38:Destroy()
            break
          end
        end
      end
    end
  end

  f67(localPlayer.Backpack)

  local character27 = localPlayer.Character

  if character27 then
    f67(character27)
  end

  f62()
  f63()
  f64()
  f65()
  f66()
end

function v6.GiveTensei(p63)
  v7.new("<Color=Purple>Quantum Onyx: Gifted you Tensei<Color=/>"):Display()
  local part5 = replicatedStorage.Effect.Container.tensei.orb.Part

  if not part5:FindFirstChild("sfx") then
    local sfx = Instance.new("Sound")
    sfx.Name = "sfx"
    sfx.SoundId = "rbxassetid://3848081992"
    sfx.Parent = part5
  end

  local v114 = require(replicatedStorage.Effect.Container.tensei)

  local tensei = Instance.new("Tool")
  tensei.Name = "tensei"
  tensei.RequiresHandle = false
  tensei.CanBeDropped = false
  tensei:SetAttribute("ItemId", 1183)
  tensei.ToolTip = "Tool"
  tensei.Parent = localPlayer.Backpack

  local getMouse4 = localPlayer:GetMouse()
  local v115 = false

  tensei.Equipped:Connect(function() v115 = true end)
  tensei.Unequipped:Connect(function() v115 = false end)

  tensei.Activated:Connect(function()
    if not v115 then
      return
    else
      local character28 = localPlayer.Character or localPlayer.CharacterAdded:Wait()
      local humanoidRootPart30 = character28:WaitForChild("HumanoidRootPart")

      local position2 = getMouse4.Hit and getMouse4.Hit.Position
        or humanoidRootPart30.Position + humanoidRootPart30.CFrame.LookVector * 50

      if (position2 - humanoidRootPart30.Position).Magnitude > 450 then
        return
      else
        local targetCF = CFrame.new(position2 + Vector3.new(0, 115, 0))
          * CFrame.Angles(math.rad(-90), 0, 0)

        v114({
          char = character28,
          target = getMouse4.Target or workspace.Terrain,
          max = 20,
          targetCF = targetCF,
        })

        return
      end
    end
  end)
end

function v6.GiveBlackBlast(p64)
  v7.new("<Color=Purple>Quantum Onyx: Gifted you Black Blast<Color=/>"):Display()
  local v116 = require(replicatedStorage.Effect.Container.Yoru2.SlashV3)
  local v117 = require(replicatedStorage.Effect.Container.Yoru2.InitialSlash)
  local v118 = false
  local v119 = false
  local v120 = false

  local function f68()
    local character29 = localPlayer.Character
    return character29 and character29:FindFirstChild("HumanoidRootPart")
  end

  local function f69(p65, p66)
    return (CFrame.new(Vector3.zero, p65) * CFrame.Angles(0, math.rad(p66), 0)).LookVector
  end

  local function f70()
    if not v119 or v118 then
      return
    end

    if v120 then
      v120 = false
      return
    end

    local v121 = f68()
    local position3, getServerTimeNow2

    if not v121 then
      return
    else
      v118 = true
      position3 = v121.Position
      local lookVector2 = v121.CFrame.LookVector
      getServerTimeNow2 = workspace:GetServerTimeNow()
      local v122 = { lookVector2 }

      for i6 = 1, 5 do
        table.insert(v122, f69(lookVector2, 10 * i6))
        table.insert(v122, f69(lookVector2, -10 * i6))
      end

      for index16, value40 in ipairs(v122) do
        local v123 = value40

        task.spawn(function()
          v117({
            player = localPlayer,
            hrp = v121,
            origin = position3,
            fireDir = v123,
            Stage = 3,
          })

          v116({
            player = localPlayer,
            hrp = v121,
            origin = position3,
            fireDir = v123,
            targetPos = position3 + v123 * 800,
            fliesFor = 3.5,
            ClockTime = getServerTimeNow2,
            specialActivated = false,
          })
        end)
      end

      task.wait(0.5)
      v118 = false
      return
    end
  end

  userInputService.InputBegan:Connect(function(input7, p67)
    if userInputService:GetFocusedTextBox() then
      return
    end

    if not v119 then
      return
    end

    if input7.UserInputType == Enum.UserInputType.Touch
      or input7.UserInputType == Enum.UserInputType.MouseButton1 then
      f70()
    end
  end)

  userInputService.TouchTap:Connect(function(p68, p69)
    if userInputService:GetFocusedTextBox() then
      return
    end

    if not v119 then
      return
    end

    f70()
  end)

  local blackBlast = Instance.new("Tool")
  blackBlast.Name = "Black Blast"
  blackBlast.RequiresHandle = false
  blackBlast:SetAttribute("ItemId", 1166)
  blackBlast.ToolTip = "Tool"

  blackBlast.Activated:Connect(function()
    if v119 then
      f70()
    end
  end)

  blackBlast.Equipped:Connect(function()
    v119 = true
    v120 = true
  end)

  blackBlast.Unequipped:Connect(function()
    v119 = false
    v118 = false
    v120 = false
  end)

  blackBlast.Parent = localPlayer.Backpack
end

function v6.GiveBlackNuke(p70)
  v7.new("<Color=Purple>Quantum Onyx: Gifted you Black Nuke<Color=/>"):Display()
  local v124 = false
  local v125 = false
  local v126 = require(replicatedStorage:WaitForChild("Effect"):WaitForChild("Container"):WaitForChild("FastLightning2"))
  local v127 = require(replicatedStorage:WaitForChild("Effect"):WaitForChild("Container"):WaitForChild("Nuke"))

  local function f71()
    local character30 = localPlayer.Character
    return character30 and character30:FindFirstChild("HumanoidRootPart")
  end

  local function f72()
    local v128 = not v125 or v124
    local position4

    if v128 then
      return
    else
      local v129 = f71()

      if not v129 then
        return
      end

      v124 = true
      position4 = v129.Position

      for i7 = 1, 3 do
        task.spawn(function()
          v126({
            Position0 = position4,
            Position1 = position4,
            Length = 60,
            Offset = 80,
            Thickness = 16,
            Lifetime = 0.3,
            Color = Color3.fromRGB(255, 255, 255),
          })
        end)
      end

      for i8 = 1, 7 do
        task.spawn(function()
          task.wait(math.random() * 0.2)

          v127.new({
            CFrame = CFrame.new(position4),
            Duration = 3,
            POW = 2.5,
            Size = 650,
            InnerColor = Color3.fromRGB(0, 0, 0),
            OuterColor = ColorSequence.new(Color3.fromRGB(0, 0, 0), Color3.fromRGB(80, 80, 80)),
          }):Run()
        end)
      end

      task.delay(4, function() v124 = false end)
      return
    end
  end

  userInputService.InputBegan:Connect(function(input8, p71)
    if userInputService:GetFocusedTextBox() then
      return
    end

    if not v125 then
      return
    end

    if input8.UserInputType == Enum.UserInputType.Touch
      or input8.UserInputType == Enum.UserInputType.MouseButton1 then
      f72()
    end
  end)

  local blackNuke = localPlayer.Backpack:FindFirstChild("Black Nuke")
    or localPlayer.Character and localPlayer.Character:FindFirstChild("Black Nuke")

  if blackNuke then
    blackNuke:Destroy()
  end

  local blackNuke2 = Instance.new("Tool")
  blackNuke2.Name = "Black Nuke"
  blackNuke2.RequiresHandle = false
  blackNuke2:SetAttribute("ItemId", 1164)
  blackNuke2.ToolTip = "Tool"

  blackNuke2.Activated:Connect(function()
    if v125 then
      f72()
    end
  end)

  blackNuke2.Equipped:Connect(function() v125 = true end)

  blackNuke2.Unequipped:Connect(function()
    v125 = false
    v124 = false
  end)

  blackNuke2.Parent = localPlayer.Backpack
end

function v6.GiveRougeFruit(p72)
  v7.new("<Color=Purple>Quantum Onyx: Gifted you Rouge Fruit<Color=/>"):Display()
  local v130 = false
  local v131 = false
  local v132 = require(replicatedStorage:WaitForChild("Effect"):WaitForChild("Container"):WaitForChild("Buddy"):WaitForChild("X"))

  local function f73()
    local character31 = localPlayer.Character
    return character31 and character31:FindFirstChild("HumanoidRootPart")
  end

  local function f74()
    local v133 = not v131 or v130
    local position5, position6

    if v133 then
      return
    else
      local v134 = f73()

      if not v134 then
        return
      end

      v130 = true
      position5 = v134.Position
      position6 = position5 + v134.CFrame.LookVector * 600
      task.spawn(function() v132({ Origin = position5, Position = position6 }) end)
      v130 = false
      return
    end
  end

  userInputService.InputBegan:Connect(function(input9, p73)
    if userInputService:GetFocusedTextBox() then
      return
    end

    if not v131 then
      return
    end

    if input9.UserInputType == Enum.UserInputType.Touch
      or input9.UserInputType == Enum.UserInputType.MouseButton1 then
      f74()
    end
  end)

  local rogueRogue = localPlayer.Backpack:FindFirstChild("Rogue-Rogue")
    or localPlayer.Character and localPlayer.Character:FindFirstChild("Rogue-Rogue")

  if rogueRogue then
    rogueRogue:Destroy()
  end

  local rogueRogue2 = Instance.new("Tool")
  rogueRogue2.Name = "Rogue-Rogue"
  rogueRogue2.RequiresHandle = false
  rogueRogue2:SetAttribute("ItemId", 1165)
  rogueRogue2.ToolTip = "Blox Fruit"

  rogueRogue2.Activated:Connect(function()
    if v131 then
      f74()
    end
  end)

  rogueRogue2.Equipped:Connect(function() v131 = true end)

  rogueRogue2.Unequipped:Connect(function()
    v131 = false
    v130 = false
  end)

  rogueRogue2.Parent = localPlayer.Backpack
end

function v6.SummonIsland(p74, p75)
  if not p75 or type(p75) ~= "string" then
    warn("[Visuals] SummonIsland requires a valid island name string.")
    return
  else
    v7.new("<Color=Purple>Quantum Onyx: Summon Access<Color=/>"):Display()

    local v135 = {
      heavendimension = { id = "112019130454374", name = "Heaven Dimension" },
      pakistandimension = { id = "114643395007104", name = "Pakistan Dimension" },
      redlegionhideout = { id = "92464509449341", name = "Red Legion Hideout" },
      ripfamilyarena = { id = "126583730809783", name = "Rip Family Arena" },
      pocketdimension = { id = "140099625700765", name = "Pocket Dimension" },
      ripfamilyhideout = { id = "130904141033359", name = "Rip Family Hideout" },
    }

    if not p74.SpawnedIslands then
      p74.SpawnedIslands = {}
    end

    local v136 = v135[string.lower(p75):gsub("[%s_%-]", "")]

    if not v136 then
      warn("[Visuals] Island not found for: " .. tostring(p75))
      return
    else
      local name4 = v136.name

      if p74.SpawnedIslands[name4] and p74.SpawnedIslands[name4].Parent then
        return p74.SpawnedIslands[name4]
      else
        local v137, v138 = f1("rbxassetid://" .. v136.id)

        if not v137 or not v137[1] then
          warn("[Visuals] Failed to load island model for " .. name4 .. " (ID: " .. v136.id
            .. "):", v138)

          return
        else
          local v139 = v137[1]
          v139.Parent = workspace
          v139:PivotTo(CFrame.new(0, 1200, 0))

          p74.SpawnedIslands[name4] = v139
          return v139
        end
      end
    end
  end
end

if getgenv then
  getgenv().VisualsM = v6
end

_G.VisualsM = v6
return v6
