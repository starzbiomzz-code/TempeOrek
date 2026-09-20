-- TempeOrek Simple Version
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleLabel = Instance.new("TextLabel")
local SpeedBtn = Instance.new("TextButton")
local JumpBtn = Instance.new("TextButton")
local ESPBtn = Instance.new("TextButton")
local FlyBtn = Instance.new("TextButton")
local CloseBtn = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
MainFrame.Size = UDim2.new(0, 300, 0, 250)
MainFrame.Active = true
MainFrame.Draggable = true

local corner = Instance.new("UICorner", MainFrame)
corner.CornerRadius = UDim.new(0, 10)

TitleLabel.Parent = MainFrame
TitleLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TitleLabel.Size = UDim2.new(1, 0, 0, 40)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "TempeOrek"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 18
Instance.new("UICorner", TitleLabel).CornerRadius = UDim.new(0, 10)

CloseBtn.Parent = MainFrame
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 16
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 8)
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

SpeedBtn.Parent = MainFrame
SpeedBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SpeedBtn.Position = UDim2.new(0, 10, 0, 50)
SpeedBtn.Size = UDim2.new(0, 135, 0, 40)
SpeedBtn.Font = Enum.Font.Gotham
SpeedBtn.Text = "Speed"
SpeedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedBtn.TextSize = 14
Instance.new("UICorner", SpeedBtn).CornerRadius = UDim.new(0, 8)
SpeedBtn.MouseButton1Click:Connect(function()
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 100
end)

JumpBtn.Parent = MainFrame
JumpBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
JumpBtn.Position = UDim2.new(0, 155, 0, 50)
JumpBtn.Size = UDim2.new(0, 135, 0, 40)
JumpBtn.Font = Enum.Font.Gotham
JumpBtn.Text = "Jump"
JumpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
JumpBtn.TextSize = 14
Instance.new("UICorner", JumpBtn).CornerRadius = UDim.new(0, 8)
JumpBtn.MouseButton1Click:Connect(function()
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = 150
end)

ESPBtn.Parent = MainFrame
ESPBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ESPBtn.Position = UDim2.new(0, 10, 0, 100)
ESPBtn.Size = UDim2.new(0, 135, 0, 40)
ESPBtn.Font = Enum.Font.Gotham
ESPBtn.Text = "ESP"
ESPBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ESPBtn.TextSize = 14
Instance.new("UICorner", ESPBtn).CornerRadius = UDim.new(0, 8)
ESPBtn.MouseButton1Click:Connect(function()
    for _, v in pairs(game.Players:GetPlayers()) do
        if v.Character and v ~= game.Players.LocalPlayer then
            local h = Instance.new("Highlight", v.Character)
            h.FillColor = Color3.fromRGB(255, 100, 100)
        end
    end
end)

FlyBtn.Parent = MainFrame
FlyBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
FlyBtn.Position = UDim2.new(0, 155, 0, 100)
FlyBtn.Size = UDim2.new(0, 135, 0, 40)
FlyBtn.Font = Enum.Font.Gotham
FlyBtn.Text = "Fly"
FlyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyBtn.TextSize = 14
Instance.new("UICorner", FlyBtn).CornerRadius = UDim.new(0, 8)
FlyBtn.MouseButton1Click:Connect(function()
    local BV = Instance.new("BodyVelocity", game.Players.LocalPlayer.Character.HumanoidRootPart)
    BV.MaxForce = Vector3.new(4000, 4000, 4000)
    game:GetService("RunService").RenderStepped:Connect(function()
        local c = workspace.CurrentCamera
        local m = Vector3.new(0,0,0)
        if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) then m = m + c.CFrame.LookVector end
        if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) then m = m - c.CFrame.LookVector end
        if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.A) then m = m - c.CFrame.RightVector end
        if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.D) then m = m + c.CFrame.RightVector end
        BV.Velocity = m * 50
    end)
end)
