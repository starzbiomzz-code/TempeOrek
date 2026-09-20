-- tempeOrek v3 - Universal + Game Detection
print("[tempeOrek] Starting...")

-- Wait for game to load
repeat task.wait() until game:IsLoaded()
print("[tempeOrek] Game loaded")

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Wait for character
repeat task.wait() until LocalPlayer.Character
print("[tempeOrek] Character loaded")

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- Game Detection
local gameId = game.PlaceId
local gameName = game:GetService("MarketplaceService"):GetProductInfo(gameId).Name
print("[tempeOrek] Game: " .. gameName .. " (ID: " .. gameId .. ")")

-- Safe GUI parent
local function getGuiParent()
    local success, coreGui = pcall(function()
        return game:GetService("CoreGui")
    end)
    if success then
        print("[tempeOrek] Using CoreGui")
        return coreGui
    end
    print("[tempeOrek] Using PlayerGui")
    return LocalPlayer:WaitForChild("PlayerGui")
end

local GuiParent = getGuiParent()

-- Remove old GUI if exists
if GuiParent:FindFirstChild("tempeOrek") then
    GuiParent:FindFirstChild("tempeOrek"):Destroy()
    print("[tempeOrek] Removed old GUI")
end

-- Create GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "tempeOrek"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = GuiParent
print("[tempeOrek] GUI created")

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 400, 0, 350)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = TitleBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -90, 1, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "tempeOrek"
TitleLabel.TextColor3 = Color3.new(1, 1, 1)
TitleLabel.TextSize = 18
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.Parent = TitleBar

-- Status Label
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(0, 150, 1, 0)
StatusLabel.Position = UDim2.new(1, -195, 0, 0)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "✓ Loaded"
StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
StatusLabel.TextSize = 12
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextXAlignment = Enum.TextXAlignment.Right
StatusLabel.Parent = TitleBar

-- Close Button
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 35, 0, 35)
CloseButton.Position = UDim2.new(1, -40, 0, 2.5)
CloseButton.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.TextSize = 16
CloseButton.Font = Enum.Font.GothamBold
CloseButton.BorderSizePixel = 0
CloseButton.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseButton

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    print("[tempeOrek] GUI closed")
end)

-- Game Info Label
local GameInfo = Instance.new("TextLabel")
GameInfo.Size = UDim2.new(1, -20, 0, 30)
GameInfo.Position = UDim2.new(0, 10, 0, 45)
GameInfo.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
GameInfo.Text = "Game: " .. gameName
GameInfo.TextColor3 = Color3.fromRGB(200, 200, 200)
GameInfo.TextSize = 11
GameInfo.Font = Enum.Font.Gotham
GameInfo.TextTruncate = Enum.TextTruncate.AtEnd
GameInfo.Parent = MainFrame

local InfoCorner = Instance.new("UICorner")
InfoCorner.CornerRadius = UDim.new(0, 6)
InfoCorner.Parent = GameInfo

-- Content Frame
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -20, 1, -100)
ContentFrame.Position = UDim2.new(0, 10, 0, 85)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- Button Creator
local function createButton(name, text, position, callback)
    local Button = Instance.new("TextButton")
    Button.Name = name
    Button.Size = UDim2.new(0, 180, 0, 50)
    Button.Position = position
    Button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Button.Text = text
    Button.TextColor3 = Color3.new(1, 1, 1)
    Button.TextSize = 14
    Button.Font = Enum.Font.GothamBold
    Button.BorderSizePixel = 0
    Button.Parent = ContentFrame
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 8)
    BtnCorner.Parent = Button
    
    Button.MouseButton1Click:Connect(function()
        Button.BackgroundColor3 = Color3.fromRGB(70, 130, 255)
        task.wait(0.1)
        Button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        task.spawn(callback)
    end)
    
    return Button
end

-- Features
createButton("SpeedBtn", "Speed Boost", UDim2.new(0, 10, 0, 10), function()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChild("Humanoid")
    if hum then
        hum.WalkSpeed = 100
        StatusLabel.Text = "Speed: ON"
        print("[tempeOrek] Speed activated")
    end
end)

createButton("JumpBtn", "Jump Boost", UDim2.new(0, 200, 0, 10), function()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChild("Humanoid")
    if hum then
        hum.JumpPower = 150
        StatusLabel.Text = "Jump: ON"
        print("[tempeOrek] Jump activated")
    end
end)

createButton("InfJumpBtn", "Inf Jump", UDim2.new(0, 10, 0, 70), function()
    UserInputService.JumpRequest:Connect(function()
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChild("Humanoid")
        if hum then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)
    StatusLabel.Text = "InfJump: ON"
    print("[tempeOrek] Infinite Jump activated")
end)

createButton("ESPBtn", "ESP Players", UDim2.new(0, 200, 0, 70), function()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            if not player.Character:FindFirstChild("Highlight") then
                local highlight = Instance.new("Highlight")
                highlight.FillColor = Color3.fromRGB(255, 100, 100)
                highlight.OutlineColor = Color3.new(1, 1, 1)
                highlight.FillTransparency = 0.5
                highlight.Parent = player.Character
            end
        end
    end
    StatusLabel.Text = "ESP: ON"
    print("[tempeOrek] ESP activated")
end)

createButton("NoclipBtn", "Noclip", UDim2.new(0, 10, 0, 130), function()
    RunService.Stepped:Connect(function()
        local char = LocalPlayer.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end)
    StatusLabel.Text = "Noclip: ON"
    print("[tempeOrek] Noclip activated")
end)

createButton("FlyBtn", "Fly (WASD)", UDim2.new(0, 200, 0, 130), function()
    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    local bodyVel = Instance.new("BodyVelocity")
    bodyVel.Velocity = Vector3.new(0, 0, 0)
    bodyVel.MaxForce = Vector3.new(4000, 4000, 4000)
    bodyVel.Parent = root
    
    task.spawn(function()
        while bodyVel and bodyVel.Parent do
            task.wait()
            local direction = Vector3.new(0, 0, 0)
            local camera = workspace.CurrentCamera
            
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                direction = direction + camera.CFrame.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                direction = direction - camera.CFrame.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                direction = direction - camera.CFrame.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                direction = direction + camera.CFrame.RightVector
            end
            
            bodyVel.Velocity = direction * 50
        end
    end)
    
    StatusLabel.Text = "Fly: ON"
    print("[tempeOrek] Fly activated")
end)

print("[tempeOrek] All features loaded!")
print("[tempeOrek] UI should be visible now")
