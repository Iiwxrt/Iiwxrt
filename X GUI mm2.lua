local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local function createOutline(part, color)
    local outline = Instance.new("SelectionBox")
    outline.Adornee = part
    outline.Color3 = color
    outline.LineThickness = 0.05
    outline.SurfaceTransparency = 1
    outline.Parent = part
    return outline
end

local function outlinePlayerCharacter(player, color)
    if player.Character then
        for _, part in pairs(player.Character:GetChildren()) do
            if part:IsA("BasePart") then
                createOutline(part, color)
            end
        end
    end
end

local function clearOutlines(player)
    if player.Character then
        for _, part in pairs(player.Character:GetChildren()) do
            if part:IsA("BasePart") then
                for _, child in pairs(part:GetChildren()) do
                    if child:IsA("SelectionBox") then
                        child:Destroy()
                    end
                end
            end
        end
    end
end

local function updateESP()
    local localPlayer = Players.LocalPlayer
    if not localPlayer then return end

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Character and player.Character:FindFirstChild("Humanoid") then
            local humanoid = player.Character.Humanoid
            if humanoid.Health > 0 then
                local role = player:FindFirstChild("Role") -- Assuming a StringValue named Role exists
                if role and role.Value == "Murderer" then
                    outlinePlayerCharacter(player, Color3.new(1, 0, 0)) -- Red for Murderer
                elseif role and role.Value == "Sheriff" then
                    outlinePlayerCharacter(player, Color3.new(0, 0, 1)) -- Blue for Sheriff
                else
                    outlinePlayerCharacter(player, Color3.new(0, 1, 0)) -- Green for Innocents
                end
            else
                clearOutlines(player)
            end
        end
    end
end

RunService.Heartbeat:Connect(updateESP)
