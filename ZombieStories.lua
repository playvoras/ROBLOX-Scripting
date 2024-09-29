local ESP = loadstring(game:HttpGet("https://kiriot22.com/releases/ESP.lua"))()
ESP:AddObjectListener(workspace.Zombies, {
    Recursive = true,
    Color =  Color3.new(1, 0.2, 0.2),
    Type = "Model",
    PrimaryPart = function(A_1)
        return A_1:WaitForChild("HumanoidRootPart")
    end,
    IsEnabled = function(A_1)
        local Health = A_1.PrimaryPart.Parent and A_1.PrimaryPart.Parent:FindFirstChild("HP")
        if Health and Health.Value > 0 then
            return true
        end
        return false
    end
})
ESP.TeamMates = false
ESP:Toggle(true)
game.Workspace.Zombies.DescendantAdded:Connect(function(z) 
    local h = z:FindFirstChild("Head")
    if z:IsA("Model") and h then
        h.Size, h.Transparency = Vector3.new(10, 10, 10), 0.8
    end
end)
