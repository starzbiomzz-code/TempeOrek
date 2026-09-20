-- TempeOrek Advanced - Toggle + Value Input + Minimize
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- State tracking
local States = {
    Speed = {active = false, value = 100, connection = nil},
    Jump = {active = false, value = 150, connection = nil},
    InfJump = {active = false, connection = nil},
    ESP = {active = false, highlights = {}},
    Noclip = {active = false, connection = nil},
    Fly = {active = false, bodyVel = nil, connection = nil}
}

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TempeOrek"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -200)
MainFrame.Size = UDim2.new(0, 400, 0, 400)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

-- Minimized Button (Logo)
local MinimizedBtn = Instance.new("TextButton")
MinimizedBtn.Name = "MinimizedBtn"
MinimizedBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MinimizedBtn.Position = UDim2.new(0, 10, 0, 10)
MinimizedBtn.Size = UDim2.new(0, 60, 0, 60)
MinimizedBtn.Font = Enum.Font.GothamBold
MinimizedBtn.Text = "TO"
MinimizedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizedBtn.TextSize = 20
MinimizedBtn.Visible = false
MinimizedBtn.Active = true
MinimizedBtn.Draggable = true
MinimizedBtn.Parent = ScreenGui
Instance.new("UICorner", MinimizedBtn).CornerRadius = UDim.new(1, 0)

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.Parent = MainFrame
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 10)

local TitleLabel = Instance.new("TextLabel")
TitleLabel.BackgroundTransparency = 1
TitleLabel.Size = UDim2.new(1, -80, 1, 0)
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "TempeOrek"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 18
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TitleBar

-- Minimize Button
local MinBtn = Instance.new("TextButton")
MinBtn.BackgroundColor3 = Color3.fromRGB(70, 130, 200)
MinBtn.Position = UDim2.new(1, -75, 0, 5)
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.Text = "-"
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.TextSize = 20
MinBtn.Parent = TitleBar
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 8)

-- Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
CloseBtn.Position = UDim2.new(1, -40, 0, 5)
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 16
CloseBtn.Parent = TitleBar
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 8)

-- Content Frame
local Content = Instance.new("Frame")
Content.BackgroundTransparency = 1
Content.Position = UDim2.new(0, 10, 0, 50)
Content.Size = UDim2.new(1, -20, 1, -60)
Content.Parent = MainFrame

-- Create Feature Row
local function createFeature(name, yPos, hasValue)
    local row = Instance.new("Frame")
    row.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    row.Position = UDim2.new(0, 0, 0, yPos)
    row.Size = UDim2.new(1, 0, 0, 50)
    row.Parent = Content
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 8)
    
    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(0, 100, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.Font = Enum.Font.GothamBold
    label.Text = name
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = row
    
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    toggleBtn.Position = UDim2.new(1, -60, 0.5, -15)
    toggleBtn.Size = UDim2.new(0, 50, 0, 30)
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.Text = "OFF"
    toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleBtn.TextSize = 12
    toggleBtn.Parent = row
    Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(0, 6)
    
    local valueBox
    if hasValue then
        valueBox = Instance.new("TextBox")
        valueBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        valueBox.Position = UDim2.new(0, 120, 0.5, -15)
        valueBox.Size = UDim2.new(0, 80, 0, 30)
        valueBox.Font = Enum.Font.Gotham
        valueBox.Text = tostring(States[name].value)
        valueBox.TextColor3 = Color3.fromRGB(255, 255, 255)
        valueBox.TextSize = 14
        valueBox.PlaceholderText = "Value"
        valueBox.Parent = row
        Instance.new("UICorner", valueBox).CornerRadius = UDim.new(0, 6)
    end
    
    return row, toggleBtn, valueBox
end

-- Speed Feature
local speedRow, speedToggle, speedInput = createFeature("Speed", 0, true)
speedToggle.MouseButton1Click:Connect(function()
    States.Speed.active = not States.Speed.active
    States.Speed.value = tonumber(speedInput.Text) or 100
    
    if States.Speed.active then
        speedToggle.Text = "ON"
        speedToggle.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        States.Speed.connection = RunService.Heartbeat:Connect(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.WalkSpeed = States.Speed.value
            end
        end)
    else
        speedToggle.Text = "OFF"
        speedToggle.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        if States.Speed.connection then States.Speed.connection:Disconnect() end
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = 16
        end
    end
end)

-- Jump Feature
local jumpRow, jumpToggle, jumpInput = createFeature("Jump", 60, true)
jumpToggle.MouseButton1Click:Connect(function()
    States.Jump.active = not States.Jump.active
    States.Jump.value = tonumber(jumpInput.Text) or 150
    
    if States.Jump.active then
        jumpToggle.Text = "ON"
        jumpToggle.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        States.Jump.connection = RunService.Heartbeat:Connect(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.JumpPower = States.Jump.value
            end
        end)
    else
        jumpToggle.Text = "OFF"
        jumpToggle.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        if States.Jump.connection then States.Jump.connection:Disconnect() end
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.JumpPower = 50
        end
    end
end)

-- InfJump Feature
local infJumpRow, infJumpToggle = createFeature("InfJump", 120, false)
infJumpToggle.MouseButton1Click:Connect(function()
    States.InfJump.active = not States.InfJump.active
    
    if States.InfJump.active then
        infJumpToggle.Text = "ON"
        infJumpToggle.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        States.InfJump.connection = UserInputService.JumpRequest:Connect(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    else
        infJumpToggle.Text = "OFF"
        infJumpToggle.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        if States.InfJump.connection then States.InfJump.connection:Disconnect() end
    end
end)

-- ESP Feature
local espRow, espToggle = createFeature("ESP", 180, false)
espToggle.MouseButton1Click:Connect(function()
    States.ESP.active = not States.ESP.active
    
    if States.ESP.active then
        espToggle.Text = "ON"
        espToggle.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local highlight = Instance.new("Highlight")
                highlight.FillColor = Color3.fromRGB(255, 100, 100)
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                highlight.FillTransparency = 0.5
                highlight.Parent = player.Character
                table.insert(States.ESP.highlights, highlight)
            end
        end
    else
        espToggle.Text = "OFF"
        espToggle.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        for _, highlight in pairs(States.ESP.highlights) do
            highlight:Destroy()
        end
        States.ESP.highlights = {}
    end
end)

-- Noclip Feature
local noclipRow, noclipToggle = createFeature("Noclip", 240, false)
noclipToggle.MouseButton1Click:Connect(function()
    States.Noclip.active = not States.Noclip.active
    
    if States.Noclip.active then
        noclipToggle.Text = "ON"
        noclipToggle.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        States.Noclip.connection = RunService.Stepped:Connect(function()
            if LocalPlayer.Character then
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        noclipToggle.Text = "OFF"
        noclipToggle.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        if States.Noclip.connection then States.Noclip.connection:Disconnect() end
    end
end)

-- Fly Feature
local flyRow, flyToggle, flySpeed = createFeature("Fly", 300, true)
flySpeed.Text = "50"
flyToggle.MouseButton1Click:Connect(function()
    States.Fly.active = not States.Fly.active
    local speed = tonumber(flySpeed.Text) or 50
    
    if States.Fly.active then
        flyToggle.Text = "ON"
        flyToggle.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            States.Fly.bodyVel = Instance.new("BodyVelocity")
            States.Fly.bodyVel.Velocity = Vector3.new(0, 0, 0)
            States.Fly.bodyVel.MaxForce = Vector3.new(4000, 4000, 4000)
            States.Fly.bodyVel.Parent = LocalPlayer.Character.HumanoidRootPart
            
            States.Fly.connection = RunService.RenderStepped:Connect(function()
                local camera = workspace.CurrentCamera
                local direction = Vector3.new(0, 0, 0)
                
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
                
                if States.Fly.bodyVel then
                    States.Fly.bodyVel.Velocity = direction * speed
                end
            end)
        end
    else
        flyToggle.Text = "OFF"
        flyToggle.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        if States.Fly.connection then States.Fly.connection:Disconnect() end
        if States.Fly.bodyVel then States.Fly.bodyVel:Destroy() end
    end
end)

-- Minimize/Maximize
MinBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    MinimizedBtn.Visible = true
end)

MinimizedBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    MinimizedBtn.Visible = false
end)

-- Close
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)
