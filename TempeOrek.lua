tempeOrek v2 - Fixed untuk Delta
repeat wait() until game:IsLoaded()
local P = game:GetService("Players").LocalPlayer
repeat wait() until P.Character

local function getGui()
    local success, result = pcall(function()
        return game:GetService("CoreGui")
    end)
    if success then return result end
    return P:WaitForChild("PlayerGui")
end

local C = getGui()
local R = game:GetService("RunService")
local U = game:GetService("UserInputService")

if C:FindFirstChild("tempeOrek") then
    C:FindFirstChild("tempeOrek"):Destroy()
end

local G = Instance.new("ScreenGui")
G.Name = "tempeOrek"
G.ResetOnSpawn = false
G.Parent = C

local M = Instance.new("Frame")
M.Size = UDim2.new(0, 400, 0, 300)
M.Position = UDim2.new(0.5, -200, 0.5, -150)
M.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
M.BorderSizePixel = 0
M.Active = true
M.Draggable = true
M.Parent = G

local MC = Instance.new("UICorner")
MC.CornerRadius = UDim.new(0, 10)
MC.Parent = M

local T = Instance.new("Frame")
T.Size = UDim2.new(1, 0, 0, 40)
T.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
T.BorderSizePixel = 0
T.Parent = M

local TC = Instance.new("UICorner")
TC.CornerRadius = UDim.new(0, 10)
TC.Parent = T

local L = Instance.new("TextLabel")
L.Size = UDim2.new(1, -50, 1, 0)
L.BackgroundTransparency = 1
L.Text = "tempeOrek"
L.TextColor3 = Color3.new(1, 1, 1)
L.TextSize = 18
L.Font = Enum.Font.GothamBold
L.TextXAlignment = Enum.TextXAlignment.Left
L.Position = UDim2.new(0, 15, 0, 0)
L.Parent = T

local X = Instance.new("TextButton")
X.Size = UDim2.new(0, 35, 0, 35)
X.Position = UDim2.new(1, -40, 0, 2.5)
X.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
X.Text = "X"
X.TextColor3 = Color3.new(1, 1, 1)
X.TextSize = 16
X.Font = Enum.Font.GothamBold
X.BorderSizePixel = 0
X.Parent = T

local XC = Instance.new("UICorner")
XC.CornerRadius = UDim.new(0, 8)
XC.Parent = X

X.MouseButton1Click:Connect(function()
    G:Destroy()
end)

local F = Instance.new("Frame")
F.Size = UDim2.new(1, -20, 1, -60)
F.Position = UDim2.new(0, 10, 0, 50)
F.BackgroundTransparency = 1
F.Parent = M

local function createButton(name, text, pos, callback)
    local b = Instance.new("TextButton")
    b.Name = name
    b.Size = UDim2.new(0, 180, 0, 45)
    b.Position = pos
    b.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    b.Text = text
    b.TextColor3 = Color3.new(1, 1, 1)
    b.TextSize = 14
    b.Font = Enum.Font.Gotham
    b.BorderSizePixel = 0
    b.Parent = F
    
    local bc = Instance.new("UICorner")
    bc.CornerRadius = UDim.new(0, 8)
    bc.Parent = b
    
    b.MouseButton1Click:Connect(function()
        spawn(callback)
    end)
    
    return b
end

createButton("Speed", "Speed", UDim2.new(0, 10, 0, 10), function()
    local char = P.Character
    local hum = char and char:FindFirstChild("Humanoid")
    if hum then
        hum.WalkSpeed = 100
        print("[tempeOrek] Speed: 100")
    end
end)

createButton("Jump", "Jump", UDim2.new(0, 200, 0, 10), function()
    local char = P.Character
    local hum = char and char:FindFirstChild("Humanoid")
    if hum then
        hum.JumpPower = 150
        print("[tempeOrek] Jump: 150")
    end
end)

createButton("InfJump", "Inf Jump", UDim2.new(0, 10, 0, 65), function()
    U.JumpRequest:Connect(function()
        local char = P.Character
        local hum = char and char:FindFirstChild("Humanoid")
        if hum then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)
    print("[tempeOrek] Infinite Jump ON")
end)

createButton("ESP", "ESP", UDim2.new(0, 200, 0, 65), function()
    for _, player in pairs(game:GetService("Players"):GetPlayers()) do
        if player ~= P and player.Character then
            local highlight = Instance.new("Highlight")
            highlight.FillColor = Color3.fromRGB(255, 100, 100)
            highlight.OutlineColor = Color3.new(1, 1, 1)
            highlight.FillTransparency = 0.5
            highlight.Parent = player.Character
        end
    end
    print("[tempeOrek] ESP ON")
end)

createButton("Noclip", "Noclip", UDim2.new(0, 10, 0, 120), function()
    R.Stepped:Connect(function()
        local char = P.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end)
    print("[tempeOrek] Noclip ON")
end)

createButton("Fly", "Fly", UDim2.new(0, 200, 0, 120), function()
    local char = P.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    local bv = Instance.new("BodyVelocity")
    bv.Velocity = Vector3.new(0, 0, 0)
    bv.MaxForce = Vector3.new(4000, 4000, 4000)
    bv.Parent = root
    
    spawn(function()
        while bv and bv.Parent do
            wait()
            local move = Vector3.new(0, 0, 0)
            local cam = workspace.CurrentCamera
            if U:IsKeyDown(Enum.KeyCode.W) then move = move + cam.CFrame.LookVector end
            if U:IsKeyDown(Enum.KeyCode.S) then move = move - cam.CFrame.LookVector end
            if U:IsKeyDown(Enum.KeyCode.A) then move = move - cam.CFrame.RightVector end
            if U:IsKeyDown(Enum.KeyCode.D) then move = move + cam.CFrame.RightVector end
            bv.Velocity = move * 50
        end
    end)
    print("[tempeOrek] Fly ON")
end)

print("[tempeOrek] Loaded successfully!")
