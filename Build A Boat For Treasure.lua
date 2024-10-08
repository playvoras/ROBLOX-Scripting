local relief = loadstring(game:HttpGet("https://raw.githubusercontent.com/PeaPattern/relief-lib/main/lib.lua"))()
relief.addCategory("Player", "rbxassetid://16149111731")

local Config = {
	earlyChest = true,
	instantClaim = false,--dont use with earlyChest
	tpDelay = 2.05,
	restartDelay = 4.85,
	stageToTouchChest = 3,
}

local function createPlatforms()
    if not workspace:FindFirstChild("Platforms") then
        local Storage = Instance.new("Folder", workspace)
        Storage.Name = "Platforms"
        for i = 1, 10 do
            local Platform = Instance.new("Part", Storage)
            Platform.Anchored = true
            Platform.Size = Vector3.new(5, 0.5, 5)
            Platform.CFrame = workspace.BoatStages.NormalStages["CaveStage" .. i].DarknessPart.CFrame * CFrame.new(0, -3, 0)
            Platform.Transparency = 1
        end
    end
end

local function touchChest(Root)
    firetouchinterest(workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger, Root, 0)
    firetouchinterest(workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger, Root, 1)
end

local function claimGold()
    workspace.ClaimRiverResultsGold:FireServer()
end

local function autoFarm()
    local LocalPlayer = game:GetService("Players").LocalPlayer
    local Character = LocalPlayer.Character
    local Root = Character.HumanoidRootPart
    local TargetPart = workspace.BoatStages.NormalStages["CaveStage1"].DarknessPart

    local Connection
    Connection = game:GetService("RunService").Heartbeat:Connect(function()
        Root.CFrame = TargetPart.CFrame
    end)

    task.spawn(function()
        for i = 1, 10 do
            task.spawn(function()
                if Config.earlyChest and i == Config.stageToTouchChest then
                    task.wait(0.5)
                    touchChest(Root)
                end
                if Config.instantClaim then
                    if Config.earlyChest and i >= Config.stageToTouchChest then
                        claimGold()
                    elseif not Config.earlyChest then
                        claimGold()
                    end
                end
            end)

            TargetPart = workspace.BoatStages.NormalStages["CaveStage" .. i].DarknessPart
            if i < 10 then
                task.wait(Config.tpDelay)
            end
        end

        if not Config.earlyChest then
            touchChest(Root)
            Character:BreakJoints()
        else
            TargetPart = workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger
        end
    end)
end

local Restart
relief.addModule("Player", "AutoFarm", function(Toggled)
    if Toggled then
        createPlatforms()
        autoFarm()
        Restart = game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function()
            task.wait(Config.restartDelay)
            autoFarm()
        end)
    else
        if Restart then
            Restart:Disconnect()
        end
    end
end)
