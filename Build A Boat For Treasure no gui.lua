local Config = {
    earlyChest = true,
    instantClaim = false, -- don't use with earlyChest
    tpDelay = 2.05,
    restartDelay = 4.85,
    stageToTouchChest = 3,
}

local function createPlatforms()
    local Storage = workspace:FindFirstChild("Platforms") or Instance.new("Folder", workspace)
    Storage.Name = "Platforms"
    for i = 1, 10 do
        local Platform = Instance.new("Part", Storage)
        Platform.Anchored = true
        Platform.Size = Vector3.new(5, 0.5, 5)
        Platform.CFrame = workspace.BoatStages.NormalStages["CaveStage" .. i].DarknessPart.CFrame * CFrame.new(0, -3, 0)
        Platform.Transparency = 1
    end
end

local function touchChest(Root)
    firetouchinterest(workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger, Root, 0)
    firetouchinterest(workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger, Root, 1)
end

local function claimGold()
    workspace.ClaimRiverResultsGold:FireServer()
end

local function teleportToStage(Root, stage)
    Root.CFrame = workspace.BoatStages.NormalStages["CaveStage" .. stage].DarknessPart.CFrame
end

local function autoFarm()
    local LocalPlayer = game:GetService("Players").LocalPlayer
    local Root = LocalPlayer.Character:WaitForChild("HumanoidRootPart")

    for i = 1, 10 do
        if Config.earlyChest and i == Config.stageToTouchChest then
            task.wait(0.5)
            touchChest(Root)
        end
        if Config.instantClaim and (not Config.earlyChest or i >= Config.stageToTouchChest) then
            claimGold()
        end

        if i < 10 then
            teleportToStage(Root, i)
            task.wait(Config.tpDelay)
        end
    end

    if not Config.earlyChest then
        touchChest(Root)
        LocalPlayer.Character:BreakJoints()
    end
end

local function startAutoFarm()
    createPlatforms()
    autoFarm()

    game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function()
        task.wait(Config.restartDelay)
        autoFarm()
    end)
end

startAutoFarm()
