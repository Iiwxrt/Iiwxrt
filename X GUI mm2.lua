--[[
    Credits to Kiriot22 for the Role getter <3
        - poorly coded by FeIix <3
]]

-- > Declarations < --

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LP = Players.LocalPlayer
local roles

-- > Functions <--

function CreateOutline() -- make any new highlights for new players
 for i, v in pairs(Players:GetChildren()) do
  if v ~= LP and v.Character and not v.Character:FindFirstChild("Outline") then
   Instance.new("Outline", v.Character)           
  end
 end
end

function UpdateOutlines() -- Get Current Role Colors (messy)
 for _, v in pairs(Players:GetChildren()) do
  if v ~= LP and v.Character and v.Character:FindFirstChild("Outline") then
   Outline = v.Character:FindFirstChild("Outline")
   if v.Name == Sheriff and IsAlive(v) then
    Outline.FillColor = Color3.fromRGB(0, 0, 225)
   elseif v.Name == Murder and IsAlive(v) then
    Outline.FillColor = Color3.fromRGB(225, 0, 0)
   elseif v.Name == Hero and IsAlive(v) and not IsAlive(game.Players[Sheriff]) then
    Outline.FillColor = Color3.fromRGB(255, 250, 0)
   else
    Outline.FillColor = Color3.fromRGB(0, 225, 0)
   end
  end
 end
end 

function IsAlive(Player) -- Simple sexy function
 for i, v in pairs(roles) do
  if Player.Name == i then
   if not v.Killed and not v.Dead then
    return true
   else
    return false
   end
  end
 end
end


-- > Loops < --

RunService.RenderStepped:connect(function()
 roles = ReplicatedStorage:FindFirstChild("GetPlayerData", true):InvokeServer()
 for i, v in pairs(roles) do
  if v.Role == "Murderer" then
   Murder = i
  elseif v.Role == 'Sheriff'then
   Sheriff = i
  elseif v.Role == 'Hero'then
   Hero = i
  end
 end
 CreateOutline()
 UpdateOutlines()
end)
