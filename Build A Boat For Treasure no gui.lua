local Config = {
    earlyChest = true,
    instantClaim = false,
    tpDelay = 2.05,
    restartDelay = 4.85,
    stageToTouchChest = 3,
}

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

local LocalPlayer = game:GetService("Players").LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Root = Character:WaitForChild("HumanoidRootPart")

for i = 1, 10 do
    if Config.earlyChest and i == Config.stageToTouchChest then
        task.wait(0.5)
        firetouchinterest(workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger, Root, 0)
        firetouchinterest(workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger, Root, 1)
    end
    if Config.instantClaim and (not Config.earlyChest or i >= Config.stageToTouchChest) then
        workspace.ClaimRiverResultsGold:FireServer()
    end
    if i < 10 then
        Root.CFrame = workspace.BoatStages.NormalStages["CaveStage" .. i].DarknessPart.CFrame
        task.wait(Config.tpDelay)
    end
end

if not Config.earlyChest then
    firetouchinterest(workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger, Root, 0)
    firetouchinterest(workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger, Root, 1)
    Character:BreakJoints()
end

game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function(newCharacter)
    task.wait(Config.restartDelay)
    local newRoot = newCharacter:WaitForChild("HumanoidRootPart")
    for i = 1, 10 do
        if Config.earlyChest and i == Config.stageToTouchChest then
            task.wait(0.5)
            firetouchinterest(workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger, newRoot, 0)
            firetouchinterest(workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger, newRoot, 1)
        end
        if Config.instantClaim and (not Config.earlyChest or i >= Config.stageToTouchChest) then
            workspace.ClaimRiverResultsGold:FireServer()
        end
        if i < 10 then
            newRoot.CFrame = workspace.BoatStages.NormalStages["CaveStage" .. i].DarknessPart.CFrame
            task.wait(Config.tpDelay)
        end
    end
    if not Config.earlyChest then
        firetouchinterest(workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger, newRoot, 0)
        firetouchinterest(workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger, newRoot, 1)
        newCharacter:BreakJoints()
    end
end)
