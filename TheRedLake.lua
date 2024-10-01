local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local window = library.CreateLib("Novaz#5792", "BloodTheme")
local main = window:NewTab("Main")
local section = main:NewSection("Main")
local section1 = main:NewSection("ESP")
local main1 = window:NewTab("Misc")
local section2 = main1:NewSection("Local Player")
local plr = game.Players.LocalPlayer

local function getclosestenemies(count)
    local enemies = {}
    for i,v in pairs(game.Workspace.NPCs:GetChildren()) do 
        if v.Name == "Tango" or v.Name == "Monsters" then 
            for o,k in pairs(v:GetChildren()) do 
                if k:IsA("Model") and k:FindFirstChild("HumanoidRootPart") then 
                    local magnitude = (k:FindFirstChild("HumanoidRootPart").Position - plr.Character.HumanoidRootPart.Position).Magnitude 
                    table.insert(enemies, {k, magnitude})
                end 
            end 
        end 
    end
    table.sort(enemies, function(a, b) return a[2] < b[2] end)
    local result = {}
    for i = 1, math.min(#enemies, count) do
        table.insert(result, enemies[i][1])
    end
    return result
end

local function getclosestenemiestm(count) 
    local enemies = {}
    for i,v in pairs(game.Workspace.NPCs:GetChildren()) do 
        if v.Name == "Tango" or v.Name == "Monsters" then 
            for o,k in pairs(v:GetChildren()) do 
                if k:IsA("Model") and k:FindFirstChild("HumanoidRootPart") then 
                    local screenpoint = game.Workspace.CurrentCamera:WorldToScreenPoint(k:FindFirstChild("HumanoidRootPart").Position)
                    local distance = (Vector2.new(game.Players.LocalPlayer:GetMouse().x, game.Players.LocalPlayer:GetMouse().y) - Vector2.new(screenpoint.x, screenpoint.y)).Magnitude
                    table.insert(enemies, {k, distance})
                end 
            end 
        end 
    end
    table.sort(enemies, function(a, b) return a[2] < b[2] end)
    local result = {}
    for i = 1, math.min(#enemies, count) do
        table.insert(result, enemies[i][1])
    end
    return result
end

section:NewToggle("Silent Aim", "", function(c)
    d = c 
    while d and task.wait() do
        pcall(function()
            for _, enemy in pairs(getclosestenemiestm(5)) do
                plr.Character:FindFirstChildOfClass("Tool").Main:FireServer("DAMAGE", {enemy:FindFirstChild("Head"), enemy:FindFirstChild("Head").Position, 0, false})
            end
        end)
    end 
end) 

section:NewToggle("Kill Closest", "", function(a)
    b = a 
    while b and task.wait() do 
        pcall(function()
            if tonumber(plr.PlayerGui.Crosshair.Counter.StoredAmmo.Text) >= 10 then 
                plr.Character:FindFirstChildOfClass("Tool").Main:FireServer("AMMO")
                plr.Character:FindFirstChildOfClass("Tool").Main:FireServer("MUZZLE", plr.Character:FindFirstChildOfClass("Tool").Handle.Barrel)
                for _, enemy in pairs(getclosestenemies(5)) do
                    plr.Character:FindFirstChildOfClass("Tool").Main:FireServer("DAMAGE", {enemy:FindFirstChild("Head"), enemy:FindFirstChild("Head").Position, 0, false})
                end
            elseif tonumber(plr.PlayerGui.Crosshair.Counter.StoredAmmo.Text) < 10 then  
                task.wait()
                local oldpos = plr.Character.HumanoidRootPart.Position 
                wait(.1)
                plr.Character.HumanoidRootPart.CFrame =  game:GetService("Workspace").Maps["Chaos Facility"].Misc.Ammo.Box.Main.CFrame 
                wait(.5)
                fireproximityprompt(game:GetService("Workspace").Maps["Chaos Facility"].Misc.Ammo.Box.Main:FindFirstChild("Template"))
                wait(.5)
                plr.Character.HumanoidRootPart.CFrame = CFrame.new(oldpos)
            end
        end)
    end 
end)

section:NewToggle("Instant Reload", "", function(q)
    r = q 
    while r and task.wait() do 
        pcall(function()
            plr.Character:FindFirstChildOfClass("Tool").Main:FireServer("AMMO")
        end) 
    end 
end)

section:NewButton("Fill Up Ammo", "", function()
    pcall(function()
        local oldpos = plr.Character.HumanoidRootPart.Position 
        wait(.1)
        plr.Character.HumanoidRootPart.CFrame =  game:GetService("Workspace").Maps["Chaos Facility"].Misc.Ammo.Box.Main.CFrame 
        wait(.5)
        fireproximityprompt(game:GetService("Workspace").Maps["Chaos Facility"].Misc.Ammo.Box.Main:FindFirstChild("Template"))
        wait(.5)
        plr.Character.HumanoidRootPart.CFrame = CFrame.new(oldpos)
    end)
end)

section1:NewToggle("Enemy ESP", "", function(o)
    oo = o 
    while oo and task.wait() do 
        pcall(function()
            for i,v in pairs(game.Workspace.NPCs:GetChildren()) do 
                if v.Name == "Tango" or v.Name == "Monsters" then 
                    for o,k in pairs(v:GetChildren()) do 
                        if (not k:FindFirstChildOfClass("Highlight")) and k.Parent.Name == "Tango" then 
                            local Highlight = Instance.new("Highlight")
                            Highlight.Parent = k
                            Highlight.Adornee = k
                            Highlight.OutlineColor = Color3.fromRGB(1, 1, 1)                             
                            Highlight.OutlineTransparency = 0 
                            Highlight.FillTransparency = 1
                        elseif (not k:FindFirstChildOfClass("Highlight")) and k.Parent.Name == "Monsters" then 
                            local Highlight = Instance.new("Highlight")
                            Highlight.Parent = k
                            Highlight.Adornee = k
                            Highlight.OutlineColor = Color3.fromRGB(255, 0, 0)                             
                            Highlight.OutlineTransparency = 0 
                            Highlight.FillTransparency = 1
                        end 
                    end 
                end 
            end 
        end) 
    end 
end)

for i, v in ipairs(workspace:GetDescendants()) do
    if v:IsA("ProximityPrompt") then
        task.wait()
        v.HoldDuration = 0
    end
end

workspace.DescendantAdded:Connect(function(v)
    if v:IsA("ProximityPrompt") then
        v.HoldDuration = 0
    end
end)
