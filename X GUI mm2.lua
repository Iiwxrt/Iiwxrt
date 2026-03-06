local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local espFolder = Instance.new("Folder", Camera)
espFolder.Name = "MurderMystery2ESP"

local roleColors = {
    ["Murderer"] = Color3.fromRGB(255, 0, 0),
    ["Sheriff"] = Color3.fromRGB(0, 0, 255),
    ["Innocent"] = Color3.fromRGB(0, 255, 0),
    ["None"] = Color3.fromRGB(128, 128, 128)
}

local function getRoleColor(role)
    return roleColors[role] or roleColors["None"]
end

local function createESP(player)
    local espBox = Instance.new("BoxHandleAdornment")
    espBox.Adornee = nil
    espBox.AlwaysOnTop = true
    espBox.ZIndex = 10
    espBox.Transparency = 0.5
    espBox.Size = Vector3.new(4, 6, 4)
    espBox.Color3 = getRoleColor("None")
    espBox.Parent = espFolder

    return espBox
end

local espBoxes = {}

local function updateESP()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = player.Character.HumanoidRootPart
            if not espBoxes[player] then
                espBoxes[player] = createESP(player)
            end
            local espBox = espBoxes[player]
            espBox.Adornee = hrp

            local role = "None"
            local leaderstats = player:FindFirstChild("leaderstats")
            if leaderstats then
                local roleStat = leaderstats:FindFirstChild("Role")
                if roleStat and roleStat:IsA("StringValue") then
                    role = roleStat.Value
                end
            end
            espBox.Color3 = getRoleColor(role)
            espBox.Transparency = 0.5
            espBox.Size = Vector3.new(4, 6, 4)
        else
            if espBoxes[player] then
                espBoxes[player]:Destroy()
                espBoxes[player] = nil
            end
        end
    end
end

Players.PlayerRemoving:Connect(function(player)
    if espBoxes[player] then
        espBoxes[player]:Destroy()
        espBoxes[player] = nil
    end
end)

RunService.RenderStepped:Connect(function()
    updateESP()
end)
