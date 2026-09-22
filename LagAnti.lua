Skip to content

Gofile

Add account
Home
File Manager
Premium
API
FAQ
Contact
@gofile_io

tqVumvtP
tqVumvtP
Sep 22, 2026, 04:08 PM
1 item

public

Import









Report abuse
Home
Terms of Service
Privacy Policy
Abuse Policy
Contact
WOJTEK SAS © 2026
·
Made withby Gofile Team


LagAnti_v3_ModelRemover.lua


-- LagAnti v3 - Model Remover Edition
-- Hapus model gede-gede buat performa maksimal
-- Upload via paste.rs, load: loadstring(game:HttpGet("URL"))()

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer

-- Fungsi hapus model berdasarkan size threshold
local function removelargeModels(threshold)
    local removed = 0
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("Model") or obj:IsA("Part") or obj:IsA("MeshPart") or obj:IsA("UnionOperation") then
            local success = pcall(function()
                if obj:IsA("BasePart") then
                    local size = obj.Size
                    local volume = size.X * size.Y * size.Z
                    if volume > threshold then
                        obj:Destroy()
                        removed = removed + 1
                    end
                elseif obj:IsA("Model") then
                    local parts = obj:GetDescendants()
                    if #parts > 50 then -- Model dengan banyak part
                        obj:Destroy()
                        removed = removed + 1
                    end
                end
            end)
        end
    end
    return removed
end

-- Fungsi optimasi grafis extreme
local function optimizeGraphics()
    -- Matiin semua efek lighting
    for _, effect in pairs(Lighting:GetChildren()) do
        if effect:IsA("PostEffect") then
            effect.Enabled = false
        end
    end
    
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 100
    Lighting.Brightness = 1
    
    -- Render distance pendek
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
end

-- Fungsi hapus texture dan decal
local function removeTextures()
    local removed = 0
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("Texture") or obj:IsA("Decal") or obj:IsA("SurfaceAppearance") then
            obj:Destroy()
            removed = removed + 1
        end
    end
    return removed
end

-- Fungsi hapus particle dan trail
local function removeEffects()
    local removed = 0
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") or obj:IsA("Fire") or obj:IsA("Smoke") or obj:IsA("Sparkles") then
            obj:Destroy()
            removed = removed + 1
        end
    end
    return removed
end

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LagAntiV3"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 320, 0, 280)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -140)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title.BorderSizePixel = 0
Title.Text = "LagAnti v3 - Model Remover"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 8)
TitleCorner.Parent = Title

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.BorderSizePixel = 0
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 14
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = Title

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 4)
CloseCorner.Parent = CloseButton

-- Status Label
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Name = "StatusLabel"
StatusLabel.Size = UDim2.new(1, -20, 0, 30)
StatusLabel.Position = UDim2.new(0, 10, 0, 50)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Status: Ready"
StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
StatusLabel.TextSize = 14
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.Parent = MainFrame

-- Buttons
local buttonY = 90
local buttonHeight = 35
local buttonSpacing = 10

local function createButton(name, text, yPos)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Size = UDim2.new(1, -20, 0, buttonHeight)
    button.Position = UDim2.new(0, 10, 0, yPos)
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.BorderSizePixel = 0
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 13
    button.Font = Enum.Font.Gotham
    button.Parent = MainFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = button
    
    return button
end

local RemoveModelsBtn = createButton("RemoveModels", "🗑️ Remove Large Models (>100 studs³)", buttonY)
local RemoveTexturesBtn = createButton("RemoveTextures", "🎨 Remove All Textures", buttonY + buttonHeight + buttonSpacing)
local RemoveEffectsBtn = createButton("RemoveEffects", "✨ Remove Particles & Effects", buttonY + (buttonHeight + buttonSpacing) * 2)
local OptimizeBtn = createButton("Optimize", "⚡ Full Optimization", buttonY + (buttonHeight + buttonSpacing) * 3)

-- Button Functions
RemoveModelsBtn.MouseButton1Click:Connect(function()
    StatusLabel.Text = "Status: Removing large models..."
    wait(0.1)
    local removed = removelargeModels(100) -- Hapus model >100 studs³
    StatusLabel.Text = "Status: Removed " .. removed .. " large objects"
    StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
end)

RemoveTexturesBtn.MouseButton1Click:Connect(function()
    StatusLabel.Text = "Status: Removing textures..."
    wait(0.1)
    local removed = removeTextures()
    StatusLabel.Text = "Status: Removed " .. removed .. " textures"
    StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
end)

RemoveEffectsBtn.MouseButton1Click:Connect(function()
    StatusLabel.Text = "Status: Removing effects..."
    wait(0.1)
    local removed = removeEffects()
    StatusLabel.Text = "Status: Removed " .. removed .. " effects"
    StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
end)

OptimizeBtn.MouseButton1Click:Connect(function()
    StatusLabel.Text = "Status: Full optimization..."
    StatusLabel.TextColor3 = Color3.fromRGB(255, 200, 50)
    wait(0.1)
    
    optimizeGraphics()
    local models = removelargeModels(100)
    local textures = removeTextures()
    local effects = removeEffects()
    
    local total = models + textures + effects
    StatusLabel.Text = "Status: Optimized! Removed " .. total .. " objects"
    StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
end)

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- FPS Counter
local FPSLabel = Instance.new("TextLabel")
FPSLabel.Name = "FPSLabel"
FPSLabel.Size = UDim2.new(1, -20, 0, 20)
FPSLabel.Position = UDim2.new(0, 10, 1, -25)
FPSLabel.BackgroundTransparency = 1
FPSLabel.Text = "FPS: 0"
FPSLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
FPSLabel.TextSize = 12
FPSLabel.Font = Enum.Font.GothamMedium
FPSLabel.TextXAlignment = Enum.TextXAlignment.Right
FPSLabel.Parent = MainFrame

local lastUpdate = tick()
local frames = 0

RunService.RenderStepped:Connect(function()
    frames = frames + 1
    if tick() - lastUpdate >= 1 then
        local fps = frames
        FPSLabel.Text = "FPS: " .. fps
        frames = 0
        lastUpdate = tick()
        
        -- Color berdasarkan FPS
        if fps >= 50 then
            FPSLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        elseif fps >= 30 then
            FPSLabel.TextColor3 = Color3.fromRGB(255, 200, 50)
        else
            FPSLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
        end
    end
end)

print("LagAnti v3 loaded successfully!")
