local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local ProximityPromptService = game:GetService("ProximityPromptService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Tr1xCheatGui"
ScreenGui.ResetOnSpawn = false
pcall(function() ScreenGui.Parent = CoreGui end)
if not ScreenGui.Parent then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

-- Константы позиций и размеров
local TARGET_SIZE = UDim2.new(0, 520, 0, 420)
local TARGET_POS = UDim2.new(0.5, -260, 0.5, -210)
local HIDDEN_SIZE = UDim2.new(0, 0, 0, 0)
local HIDDEN_POS = UDim2.new(0.5, 0, 0.5, 0)

-- Изменённый размер хитбокса Килл Ауры (300x300x300)
local KILL_AURA_SIZE = Vector3.new(300, 300, 300)

-- Глобальный цвет для всех Chams
local currentChamsColor = Color3.fromRGB(0, 255, 120)

-- Экран загрузки (Loading Screen)
local LoadingFrame = Instance.new("Frame")
LoadingFrame.Name = "LoadingFrame"
LoadingFrame.Size = UDim2.new(0, 320, 0, 150)
LoadingFrame.Position = UDim2.new(0.5, -160, 0.5, -75)
LoadingFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
LoadingFrame.BorderSizePixel = 0
LoadingFrame.Active = true
LoadingFrame.ClipsDescendants = true
LoadingFrame.Visible = true
LoadingFrame.Parent = ScreenGui

local LoadingCorner = Instance.new("UICorner")
LoadingCorner.CornerRadius = UDim.new(0, 12)
LoadingCorner.Parent = LoadingFrame

local LoadingStroke = Instance.new("UIStroke")
LoadingStroke.Thickness = 2
LoadingStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
LoadingStroke.Parent = LoadingFrame

local LoadingTitle = Instance.new("TextLabel")
LoadingTitle.Size = UDim2.new(1, 0, 0, 35)
LoadingTitle.Position = UDim2.new(0, 0, 0, 10)
LoadingTitle.BackgroundTransparency = 1
LoadingTitle.Text = "Tr1x Cheat Loading..."
LoadingTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadingTitle.Font = Enum.Font.GothamBold
LoadingTitle.TextSize = 16
LoadingTitle.Parent = LoadingFrame

local LoadingStatus = Instance.new("TextLabel")
LoadingStatus.Size = UDim2.new(1, 0, 0, 20)
LoadingStatus.Position = UDim2.new(0, 0, 0, 45)
LoadingStatus.BackgroundTransparency = 1
LoadingStatus.Text = "Initializing script..."
LoadingStatus.TextColor3 = Color3.fromRGB(180, 180, 180)
LoadingStatus.Font = Enum.Font.Gotham
LoadingStatus.TextSize = 12
LoadingStatus.Parent = LoadingFrame

local BarBackground = Instance.new("Frame")
BarBackground.Size = UDim2.new(0.85, 0, 0, 12)
BarBackground.Position = UDim2.new(0.075, 0, 0, 75)
BarBackground.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
BarBackground.BorderSizePixel = 0
BarBackground.Parent = LoadingFrame

local BarCorner = Instance.new("UICorner")
BarCorner.CornerRadius = UDim.new(0, 6)
BarCorner.Parent = BarBackground

local BarFill = Instance.new("Frame")
BarFill.Size = UDim2.new(0, 0, 1, 0)
BarFill.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
BarFill.BorderSizePixel = 0
BarFill.Parent = BarBackground

local FillCorner = Instance.new("UICorner")
FillCorner.CornerRadius = UDim.new(0, 6)
FillCorner.Parent = BarFill

local PercentLabel = Instance.new("TextLabel")
PercentLabel.Size = UDim2.new(1, 0, 0, 20)
PercentLabel.Position = UDim2.new(0, 0, 0, 100)
PercentLabel.BackgroundTransparency = 1
PercentLabel.Text = "0%"
PercentLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
PercentLabel.Font = Enum.Font.GothamBold
PercentLabel.TextSize = 13
PercentLabel.Parent = LoadingFrame

-- Главное Меню
local MainMenu = Instance.new("Frame")
MainMenu.Name = "MainMenu"
MainMenu.Size = HIDDEN_SIZE
MainMenu.Position = HIDDEN_POS
MainMenu.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainMenu.BorderSizePixel = 0
MainMenu.Active = true
MainMenu.Draggable = true
MainMenu.Visible = false
MainMenu.ClipsDescendants = true
MainMenu.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainMenu

local UIStroke = Instance.new("UIStroke")
UIStroke.Thickness = 3
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke.Parent = MainMenu

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, -85, 0, 40)
Title.Position = UDim2.new(0, 15, 0, 5)
Title.BackgroundTransparency = 1
Title.Text = "Alien Ranch script. By: Tr1x"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = MainMenu

-- Кнопка настроек (Шестеренка)
local SettingsButton = Instance.new("TextButton")
SettingsButton.Name = "SettingsButton"
SettingsButton.Size = UDim2.new(0, 30, 0, 30)
SettingsButton.Position = UDim2.new(1, -70, 0, 5)
SettingsButton.BackgroundTransparency = 1
SettingsButton.Text = "⚙"
SettingsButton.TextColor3 = Color3.fromRGB(200, 200, 200)
SettingsButton.Font = Enum.Font.GothamBold
SettingsButton.TextSize = 18
SettingsButton.Parent = MainMenu

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.BackgroundTransparency = 1
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 18
CloseButton.Parent = MainMenu

-- Навигация
local Navigation = Instance.new("Frame")
Navigation.Name = "Navigation"
Navigation.Size = UDim2.new(0, 140, 1, -55)
Navigation.Position = UDim2.new(0, 10, 0, 45)
Navigation.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
Navigation.BorderSizePixel = 0
Navigation.Parent = MainMenu

local NavCorner = Instance.new("UICorner")
NavCorner.CornerRadius = UDim.new(0, 8)
NavCorner.Parent = Navigation

local NavLayout = Instance.new("UIListLayout")
NavLayout.SortOrder = Enum.SortOrder.LayoutOrder
NavLayout.Padding = UDim.new(0, 5)
NavLayout.Parent = Navigation

local NavPadding = Instance.new("UIPadding")
NavPadding.PaddingTop = UDim.new(0, 5)
NavPadding.PaddingLeft = UDim.new(0, 5)
NavPadding.PaddingRight = UDim.new(0, 5)
NavPadding.Parent = Navigation

-- Панель Настроек (Settings Modal)
local SettingsFrame = Instance.new("Frame")
SettingsFrame.Name = "SettingsFrame"
SettingsFrame.Size = UDim2.new(0, 320, 0, 320)
SettingsFrame.Position = UDim2.new(0.5, -160, 0.5, -160)
SettingsFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
SettingsFrame.BorderSizePixel = 0
SettingsFrame.ZIndex = 10
SettingsFrame.Visible = false
SettingsFrame.Parent = MainMenu

local SettingsCorner = Instance.new("UICorner")
SettingsCorner.CornerRadius = UDim.new(0, 10)
SettingsCorner.Parent = SettingsFrame

local SettingsStroke = Instance.new("UIStroke")
SettingsStroke.Thickness = 2
SettingsStroke.Color = Color3.fromRGB(70, 70, 70)
SettingsStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
SettingsStroke.Parent = SettingsFrame

local SettingsTitle = Instance.new("TextLabel")
SettingsTitle.Size = UDim2.new(1, -40, 0, 35)
SettingsTitle.Position = UDim2.new(0, 15, 0, 5)
SettingsTitle.BackgroundTransparency = 1
SettingsTitle.Text = "Menu Settings"
SettingsTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
SettingsTitle.Font = Enum.Font.GothamBold
SettingsTitle.TextSize = 15
SettingsTitle.TextXAlignment = Enum.TextXAlignment.Left
SettingsTitle.ZIndex = 11
SettingsTitle.Parent = SettingsFrame

local SettingsClose = Instance.new("TextButton")
SettingsClose.Size = UDim2.new(0, 30, 0, 30)
SettingsClose.Position = UDim2.new(1, -35, 0, 5)
SettingsClose.BackgroundTransparency = 1
SettingsClose.Text = "X"
SettingsClose.TextColor3 = Color3.fromRGB(200, 50, 50)
SettingsClose.Font = Enum.Font.GothamBold
SettingsClose.TextSize = 16
SettingsClose.ZIndex = 11
SettingsClose.Parent = SettingsFrame

local SettingsList = Instance.new("ScrollingFrame")
SettingsList.Size = UDim2.new(1, -20, 1, -45)
SettingsList.Position = UDim2.new(0, 10, 0, 40)
SettingsList.BackgroundTransparency = 1
SettingsList.ScrollBarThickness = 4
SettingsList.ZIndex = 11
SettingsList.Parent = SettingsFrame

local SettingsLayout = Instance.new("UIListLayout")
SettingsLayout.SortOrder = Enum.SortOrder.LayoutOrder
SettingsLayout.Padding = UDim.new(0, 8)
SettingsLayout.Parent = SettingsList

SettingsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    SettingsList.CanvasSize = UDim2.new(0, 0, 0, SettingsLayout.AbsoluteContentSize.Y + 15)
end)

local function createSectionHeader(text)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 18)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(180, 180, 180)
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 12
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.ZIndex = 11
    lbl.Parent = SettingsList
    return lbl
end

-- Настройки фона
createSectionHeader("Background Color")
local colorFrame = Instance.new("Frame")
colorFrame.Size = UDim2.new(1, 0, 0, 58)
colorFrame.BackgroundTransparency = 1
colorFrame.ZIndex = 11
colorFrame.Parent = SettingsList

local colorGrid = Instance.new("UIGridLayout")
colorGrid.CellSize = UDim2.new(0.25, -4, 0, 26)
colorGrid.CellPadding = UDim2.new(0, 5, 0, 5)
colorGrid.Parent = colorFrame

local colors = {
    {name = "Dark", col = Color3.fromRGB(15, 15, 15)},
    {name = "Navy", col = Color3.fromRGB(15, 20, 35)},
    {name = "Purple", col = Color3.fromRGB(25, 15, 35)},
    {name = "Red", col = Color3.fromRGB(35, 15, 15)},
    {name = "Emerald", col = Color3.fromRGB(15, 35, 25)},
    {name = "Sunset", col = Color3.fromRGB(40, 25, 15)},
    {name = "Indigo", col = Color3.fromRGB(20, 15, 40)},
    {name = "Obsidian", col = Color3.fromRGB(8, 8, 8)}
}

for _, cData in ipairs(colors) do
    local cBtn = Instance.new("TextButton")
    cBtn.BackgroundColor3 = cData.col
    cBtn.Text = cData.name
    cBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    cBtn.Font = Enum.Font.Gotham
    cBtn.TextSize = 10
    cBtn.ZIndex = 11
    cBtn.Parent = colorFrame

    local cCorner = Instance.new("UICorner")
    cCorner.CornerRadius = UDim.new(0, 4)
    cCorner.Parent = cBtn

    cBtn.MouseButton1Click:Connect(function()
        MainMenu.BackgroundColor3 = cData.col
    end)
end

-- Размер меню
createSectionHeader("Menu Size")
local sizeFrame = Instance.new("Frame")
sizeFrame.Size = UDim2.new(1, 0, 0, 28)
sizeFrame.BackgroundTransparency = 1
sizeFrame.ZIndex = 11
sizeFrame.Parent = SettingsList

local sizeLayout = Instance.new("UIListLayout")
sizeLayout.FillDirection = Enum.FillDirection.Horizontal
sizeLayout.Padding = UDim.new(0, 5)
sizeLayout.Parent = sizeFrame

local sizePresets = {
    {name = "Small", w = 450, h = 350},
    {name = "Default", w = 520, h = 420},
    {name = "Large", w = 600, h = 480}
}

for _, sData in ipairs(sizePresets) do
    local sBtn = Instance.new("TextButton")
    sBtn.Size = UDim2.new(0.33, -3, 1, 0)
    sBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    sBtn.Text = sData.name
    sBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    sBtn.Font = Enum.Font.Gotham
    sBtn.TextSize = 11
    sBtn.ZIndex = 11
    sBtn.Parent = sizeFrame

    local sCorner = Instance.new("UICorner")
    sCorner.CornerRadius = UDim.new(0, 4)
    sCorner.Parent = sBtn

    sBtn.MouseButton1Click:Connect(function()
        TARGET_SIZE = UDim2.new(0, sData.w, 0, sData.h)
        TARGET_POS = UDim2.new(0.5, -sData.w / 2, 0.5, -sData.h / 2)
        if MainMenu.Visible and MainMenu.Size ~= HIDDEN_SIZE then
            TweenService:Create(MainMenu, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = TARGET_SIZE,
                Position = TARGET_POS
            }):Play()
        end
    end)
end

-- Прозрачность
createSectionHeader("Menu Transparency")
local transFrame = Instance.new("Frame")
transFrame.Size = UDim2.new(1, 0, 0, 28)
transFrame.BackgroundTransparency = 1
transFrame.ZIndex = 11
transFrame.Parent = SettingsList

local transLayout = Instance.new("UIListLayout")
transLayout.FillDirection = Enum.FillDirection.Horizontal
transLayout.Padding = UDim.new(0, 5)
transLayout.Parent = transFrame

local transPresets = {
    {name = "0%", val = 0},
    {name = "20%", val = 0.2},
    {name = "40%", val = 0.4},
    {name = "60%", val = 0.6}
}

for _, tData in ipairs(transPresets) do
    local tBtn = Instance.new("TextButton")
    tBtn.Size = UDim2.new(0.25, -4, 1, 0)
    tBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    tBtn.Text = tData.name
    tBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    tBtn.Font = Enum.Font.Gotham
    tBtn.TextSize = 11
    tBtn.ZIndex = 11
    tBtn.Parent = transFrame

    local tCorner = Instance.new("UICorner")
    tCorner.CornerRadius = UDim.new(0, 4)
    tCorner.Parent = tBtn

    tBtn.MouseButton1Click:Connect(function()
        MainMenu.BackgroundTransparency = tData.val
        if Navigation then
            Navigation.BackgroundTransparency = math.clamp(tData.val + 0.1, 0, 1)
        end
    end)
end

-- Цвет всех Chams
createSectionHeader("Chams Color")
local chamsColorFrame = Instance.new("Frame")
chamsColorFrame.Size = UDim2.new(1, 0, 0, 28)
chamsColorFrame.BackgroundTransparency = 1
chamsColorFrame.ZIndex = 11
chamsColorFrame.Parent = SettingsList

local chamsColorLayout = Instance.new("UIListLayout")
chamsColorLayout.FillDirection = Enum.FillDirection.Horizontal
chamsColorLayout.Padding = UDim.new(0, 5)
chamsColorLayout.Parent = chamsColorFrame

local chamsColors = {
    {name = "Green", col = Color3.fromRGB(0, 255, 120)},
    {name = "Red", col = Color3.fromRGB(255, 50, 50)},
    {name = "Cyan", col = Color3.fromRGB(0, 220, 255)},
    {name = "Yellow", col = Color3.fromRGB(255, 220, 0)},
    {name = "Purple", col = Color3.fromRGB(180, 50, 255)}
}

for _, ccData in ipairs(chamsColors) do
    local ccBtn = Instance.new("TextButton")
    ccBtn.Size = UDim2.new(0.2, -4, 1, 0)
    ccBtn.BackgroundColor3 = ccData.col
    ccBtn.Text = ""
    ccBtn.ZIndex = 11
    ccBtn.Parent = chamsColorFrame

    local ccCorner = Instance.new("UICorner")
    ccCorner.CornerRadius = UDim.new(0, 4)
    ccCorner.Parent = ccBtn

    ccBtn.MouseButton1Click:Connect(function()
        currentChamsColor = ccData.col
        for _, v in ipairs(Workspace:GetDescendants()) do
            if v:IsA("Highlight") and (v.Name:find("Highlight")) then
                v.FillColor = currentChamsColor
            end
        end
    end)
end

SettingsClose.MouseButton1Click:Connect(function()
    SettingsFrame.Visible = false
end)

SettingsButton.MouseButton1Click:Connect(function()
    SettingsFrame.Visible = not SettingsFrame.Visible
end)

local ContentArea = Instance.new("Frame")
ContentArea.Name = "ContentArea"
ContentArea.Size = UDim2.new(1, -170, 1, -55)
ContentArea.Position = UDim2.new(0, 160, 0, 45)
ContentArea.BackgroundTransparency = 1
ContentArea.Parent = MainMenu

local OpenButton = Instance.new("ImageButton")
OpenButton.Name = "OpenButton"
OpenButton.Size = UDim2.new(0, 60, 0, 60)
OpenButton.Position = UDim2.new(0, 15, 0, 15)
OpenButton.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
OpenButton.Image = "rbxassetid://88911451083054"
OpenButton.Visible = false
OpenButton.Parent = ScreenGui

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(1, 0)
OpenCorner.Parent = OpenButton

local OpenStroke = Instance.new("UIStroke")
OpenStroke.Thickness = 2
OpenStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
OpenStroke.Parent = OpenButton

task.spawn(function()
    local hue = 0
    while true do
        hue = (hue + 1) % 360
        local color = Color3.fromHSV(hue / 360, 1, 1)
        UIStroke.Color = color
        OpenStroke.Color = color
        LoadingStroke.Color = color
        task.wait(0.05)
    end
end)

local isTweening = false

local function toggleMenu(show)
    if isTweening then return end
    isTweening = true
    
    if show then
        MainMenu.Size = HIDDEN_SIZE
        MainMenu.Position = HIDDEN_POS
        MainMenu.Visible = true
        OpenButton.Visible = false
        
        local tweenSize = TweenService:Create(MainMenu, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = TARGET_SIZE})
        local tweenPos = TweenService:Create(MainMenu, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = TARGET_POS})
        
        tweenSize:Play()
        tweenPos:Play()
        
        tweenSize.Completed:Connect(function()
            isTweening = false
        end)
    else
        SettingsFrame.Visible = false
        local tweenSize = TweenService:Create(MainMenu, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = HIDDEN_SIZE})
        local tweenPos = TweenService:Create(MainMenu, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Position = HIDDEN_POS})
        
        tweenSize:Play()
        tweenPos:Play()
        
        tweenSize.Completed:Connect(function()
            MainMenu.Visible = false
            OpenButton.Visible = true
            isTweening = false
        end)
    end
end

local function playIntroAnimation()
    isTweening = true
    MainMenu.Size = HIDDEN_SIZE
    MainMenu.Position = HIDDEN_POS
    MainMenu.Visible = true
    
    local tweenSize = TweenService:Create(MainMenu, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = TARGET_SIZE})
    local tweenPos = TweenService:Create(MainMenu, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = TARGET_POS})
    
    tweenSize:Play()
    tweenPos:Play()
    
    tweenSize.Completed:Connect(function()
        isTweening = false
    end)
end

local function startLoadingProcess()
    task.spawn(function()
        local steps = {
            {percent = 0.25, text = "Loading modules..."},
            {percent = 0.55, text = "Checking workspace..."},
            {percent = 0.85, text = "Injecting functions..."},
            {percent = 1.00, text = "Done!"}
        }
        
        for _, step in ipairs(steps) do
            local fillTween = TweenService:Create(BarFill, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(step.percent, 0, 1, 0)})
            fillTween:Play()
            LoadingStatus.Text = step.text
            
            local startP = math.floor((BarFill.Size.X.Scale) * 100)
            local targetP = math.floor(step.percent * 100)
            
            for p = startP, targetP do
                PercentLabel.Text = tostring(p) .. "%"
                task.wait(0.008)
            end
            task.wait(0.2)
        end
        
        task.wait(0.3)
        
        local fadeTween = TweenService:Create(LoadingFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        })
        fadeTween:Play()
        fadeTween.Completed:Connect(function()
            LoadingFrame:Destroy()
            playIntroAnimation()
        end)
    end)
end

-- Автоматический запуск загрузки
startLoadingProcess()

CloseButton.MouseButton1Click:Connect(function()
    toggleMenu(false)
end)

OpenButton.MouseButton1Click:Connect(function()
    toggleMenu(true)
end)

local tabs = {}
local tabButtons = {}

local function createTab(tabName)
    local tabFrame = Instance.new("ScrollingFrame")
    tabFrame.Name = tabName .. "Tab"
    tabFrame.Size = UDim2.new(1, 0, 1, 0)
    tabFrame.BackgroundTransparency = 1
    tabFrame.ScrollBarThickness = 4
    tabFrame.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
    tabFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    tabFrame.Visible = false
    tabFrame.Parent = ContentArea
    
    local listLayout = Instance.new("UIListLayout")
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Padding = UDim.new(0, 8)
    listLayout.Parent = tabFrame
    
    listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        local extraPadding = (tabName == "Other") and 60 or 10
        tabFrame.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + extraPadding)
    end)
    
    local tabBtn = Instance.new("TextButton")
    tabBtn.Name = tabName .. "Btn"
    tabBtn.Size = UDim2.new(1, 0, 0, 32)
    tabBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    tabBtn.Text = tabName
    tabBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
    tabBtn.Font = Enum.Font.GothamBold
    tabBtn.TextSize = 13
    tabBtn.BorderSizePixel = 0
    tabBtn.Parent = Navigation
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = tabBtn
    
    tabBtn.MouseButton1Click:Connect(function()
        for _, t in pairs(tabs) do t.Visible = false end
        for _, b in pairs(tabButtons) do 
            b.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            b.TextColor3 = Color3.fromRGB(180, 180, 180)
        end
        tabFrame.Visible = true
        tabBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        tabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)
    
    tabs[tabName] = tabFrame
    tabButtons[tabName] = tabBtn
    
    if #tabButtons == 1 or tabName == "chams" then
        tabFrame.Visible = true
        tabBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        tabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
    
    return tabFrame
end

local chamsTab = createTab("chams")
local teleportTab = createTab("Teleport")
local otherTab = createTab("Other")
local infoTab = createTab("Info")

-- Оформление вкладки Info
local infoContainer = Instance.new("Frame")
infoContainer.Size = UDim2.new(1, -10, 0, 160)
infoContainer.BackgroundTransparency = 1
infoContainer.Parent = infoTab

local infoImage = Instance.new("ImageLabel")
infoImage.Size = UDim2.new(0, 70, 0, 70)
infoImage.Position = UDim2.new(0, 5, 0, 5)
infoImage.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
infoImage.Image = "rbxassetid://88911451083054"
infoImage.Parent = infoContainer

local imgCorner = Instance.new("UICorner")
imgCorner.CornerRadius = UDim.new(1, 0)
imgCorner.Parent = infoImage

local imgStroke = Instance.new("UIStroke")
imgStroke.Thickness = 2
imgStroke.Color = Color3.fromRGB(0, 200, 255)
imgStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
imgStroke.Parent = infoImage

local infoText = Instance.new("TextLabel")
infoText.Size = UDim2.new(1, -90, 1, 0)
infoText.Position = UDim2.new(0, 85, 0, 5)
infoText.BackgroundTransparency = 1
infoText.RichText = true
infoText.Text = "TT: tr1xalonchik\nThe script was made by <b>Tr1x</b>\n\nFunction \"Auto collect money\" Made by Kapusta, thanks to him for lending the script for this function."
infoText.TextColor3 = Color3.fromRGB(230, 230, 230)
infoText.Font = Enum.Font.Gotham
infoText.TextSize = 13
infoText.TextXAlignment = Enum.TextXAlignment.Left
infoText.TextYAlignment = Enum.TextYAlignment.Top
infoText.TextWrapped = true
infoText.Parent = infoContainer

local toggles = {
    KillAura = false,
    Chams = false,
    ChamsCow = false,
    NpcChams = false,
    AlienHeadChams = false,
    AmmoChams = false,
    GunAim = false,
    InstantInteract = false,
    AutoMoney = false,
    Noclip = false,
    AutoGiveMilk = false,
    MoreMilkCow = false,
    AntiLag = false,
    PotatoMode = false,
    OptimizationActive = false
}

-- ПОИСК NPC И ТЕЛЕПОРТАЦИЯ МОЛОКА К НИМ
local function getNPCTargets()
    local targets = {}
    for _, v in ipairs(Workspace:GetDescendants()) do
        if v:IsA("TextLabel") and v.Text and v.Text:match("x%d+") then
            local amount = tonumber(v.Text:match("x(%d+)")) or 1
            local model = v:FindFirstAncestorOfClass("Model")
            if model then
                local targetCFrame = nil
                local tablePart = model:FindFirstChild("Table") or model:FindFirstChild("Counter") or model:FindFirstChild("Desk") or model:FindFirstChild("Wooden")
                if not tablePart then
                    for _, child in ipairs(model:GetChildren()) do
                        if child:IsA("BasePart") and (child.Name:lower():find("table") or child.Name:lower():find("counter") or child.Name:lower():find("desk") or child.Name:lower():find("wood")) then
                            tablePart = child
                            break
                        end
                    end
                end
                
                if tablePart and tablePart:IsA("BasePart") then
                    targetCFrame = tablePart.CFrame + Vector3.new(0, 1.5, 0)
                else
                    local hrp = model:FindFirstChild("HumanoidRootPart") or model:FindFirstChild("Torso") or model:FindFirstChildWhichIsA("BasePart")
                    if hrp then
                        targetCFrame = hrp.CFrame * CFrame.new(0, 0, -2.5)
                    end
                end

                if targetCFrame then
                    table.insert(targets, {cframe = targetCFrame, amount = amount, model = model})
                end
            end
        end
    end
    return targets
end

local function processAutoGiveMilk()
    if not toggles.AutoGiveMilk then return end

    local targets = getNPCTargets()
    if #targets == 0 then return end

    local milks = {}
    for _, v in ipairs(Workspace:GetDescendants()) do
        if v:IsA("BasePart") and v.Name == "Milk" then
            table.insert(milks, v)
        end
    end

    local milkIndex = 1
    for _, target in ipairs(targets) do
        local needed = target.amount
        while needed > 0 and milkIndex <= #milks do
            local milk = milks[milkIndex]
            if milk and milk.Parent then
                milk.CFrame = target.cframe
                milk.CanCollide = false
            end
            milkIndex = milkIndex + 1
            needed = needed - 1
        end
        if milkIndex > #milks then break end
    end
end

Workspace.DescendantAdded:Connect(function(v)
    if v:IsA("BasePart") and v.Name == "Milk" then
        if toggles.AutoGiveMilk then
            task.wait(0.05)
            processAutoGiveMilk()
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(0.5)
        if toggles.AutoGiveMilk then
            processAutoGiveMilk()
        end
    end
end)

local function createMenuButton(text, isToggle, toggleKey, container, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -6, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.BorderSizePixel = 0
    btn.Parent = container
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        if isToggle then
            toggles[toggleKey] = not toggles[toggleKey]
            if toggles[toggleKey] then
                btn.BackgroundColor3 = Color3.fromRGB(50, 120, 50)
            else
                btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            end
            if callback then callback(toggles[toggleKey]) end
        else
            if callback then callback() end
        end
    end)
    return btn
end

local function createSpeedInput(container)
    local baseFrame = Instance.new("Frame")
    baseFrame.Size = UDim2.new(1, -6, 0, 35)
    baseFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    baseFrame.BorderSizePixel = 0
    baseFrame.Parent = container
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = baseFrame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.6, 0, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = "Player speed"
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = baseFrame
    
    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(0.35, -10, 0, 25)
    textBox.Position = UDim2.new(0.65, 0, 0.5, -12)
    textBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    textBox.Text = "16"
    textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    textBox.Font = Enum.Font.Gotham
    textBox.TextSize = 14
    textBox.ClearTextOnFocus = false
    textBox.Parent = baseFrame
    
    local boxCorner = Instance.new("UICorner")
    boxCorner.CornerRadius = UDim.new(0, 4)
    boxCorner.Parent = textBox
    
    local targetSpeed = 16
    
    textBox.FocusLost:Connect(function()
        local num = tonumber(textBox.Text)
        if num then
            targetSpeed = num
        else
            textBox.Text = tostring(targetSpeed)
        end
    end)
    
    RunService.Heartbeat:Connect(function()
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.WalkSpeed = targetSpeed
        end
    end)
end

local function teleportTo(coords)
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        character.HumanoidRootPart.CFrame = CFrame.new(coords)
    end
end

-- Вкладка: CHAMS
createMenuButton("Alien chams", true, "Chams", chamsTab, function(state)
    if not state then
        for _, v in ipairs(Workspace:GetDescendants()) do
            local hl = v:FindFirstChild("Tr1xHighlight")
            if hl then hl:Destroy() end
        end
    end
end)

createMenuButton("Chams cow", true, "ChamsCow", chamsTab, function(state)
    if not state then
        for _, v in ipairs(Workspace:GetDescendants()) do
            local hl = v:FindFirstChild("CowHighlight")
            if hl then hl:Destroy() end
        end
    end
end)

createMenuButton("Npc chams", true, "NpcChams", chamsTab, function(state)
    if not state then
        for _, v in ipairs(Workspace:GetDescendants()) do
            local hl = v:FindFirstChild("NpcHighlight")
            if hl then hl:Destroy() end
        end
    end
end)

createMenuButton("Alien head chams", true, "AlienHeadChams", chamsTab, function(state)
    if not state then
        for _, v in ipairs(Workspace:GetDescendants()) do
            local hl = v:FindFirstChild("AlienHeadHighlight")
            if hl then hl:Destroy() end
        end
    end
end)

createMenuButton("Ammo chams", true, "AmmoChams", chamsTab, function(state)
    if not state then
        for _, v in ipairs(Workspace:GetDescendants()) do
            local hl = v:FindFirstChild("AmmoHighlight")
            if hl then hl:Destroy() end
        end
    end
end)

-- Вкладка: TELEPORT
createMenuButton("TP Milk Machine", false, nil, teleportTab, function()
    teleportTo(Vector3.new(-65.55909729003906, 10.084904670715332, 144.30551147460938))
end)

createMenuButton("TP Plot with cow", false, nil, teleportTab, function()
    teleportTo(Vector3.new(67.47659301757812, 5.250847816467285, 88.8986587524414))
end)

createMenuButton("TP to Cow NPC", false, nil, teleportTab, function()
    for _, v in ipairs(Workspace:GetDescendants()) do
        if v:IsA("Model") and v.Name == "Cow" then
            local hrp = v:FindFirstChild("HumanoidRootPart") or v:FindFirstChild("Torso") or v:FindFirstChildWhichIsA("BasePart")
            if hrp then
                teleportTo(hrp.Position + Vector3.new(0, 3, 0))
                break
            end
        end
    end
end)

createMenuButton("TP Safe zone", false, nil, teleportTab, function()
    teleportTo(Vector3.new(192.99176025390625, 48.58350372314453, 28.302072525024414))
end)

createMenuButton("TP Alien heads", false, nil, teleportTab, function()
    local targetPos = Vector3.new(-53.494415283203125, 5.187541484832764, 82.11861419677734)
    for _, v in ipairs(Workspace:GetDescendants()) do
        local name = string.lower(v.Name)
        if string.find(name, "alien head") or string.find(name, "alienhead") then
            if v:IsA("BasePart") then
                v.CFrame = CFrame.new(targetPos)
            elseif v:IsA("Model") then
                v:PivotTo(CFrame.new(targetPos))
            end
        end
    end
end)

local alienCache = {}
local originalAlienSettings = {}

local function updateAlienCache()
    table.clear(alienCache)
    for _, v in ipairs(Workspace:GetDescendants()) do
        if v:IsA("Model") and string.find(v.Name, "Alien") and v.Name ~= LocalPlayer.Name then
            local hrp = v:FindFirstChild("HumanoidRootPart")
            if hrp then
                table.insert(alienCache, hrp)
                if not originalAlienSettings[hrp] then
                    originalAlienSettings[hrp] = {
                        Size = hrp.Size,
                        Transparency = hrp.Transparency,
                        CanCollide = hrp.CanCollide
                    }
                end
            end
        end
    end
end

Workspace.DescendantAdded:Connect(function(v)
    if v:IsA("Model") and string.find(v.Name, "Alien") and v.Name ~= LocalPlayer.Name then
        task.wait(0.05)
        local hrp = v:FindFirstChild("HumanoidRootPart")
        if hrp then
            if not table.find(alienCache, hrp) then
                table.insert(alienCache, hrp)
            end
            if not originalAlienSettings[hrp] then
                originalAlienSettings[hrp] = {
                    Size = hrp.Size,
                    Transparency = hrp.Transparency,
                    CanCollide = hrp.CanCollide
                }
            end
            if toggles.KillAura then
                hrp.Size = KILL_AURA_SIZE
                hrp.Transparency = 1
                hrp.CanCollide = false
                hrp.Massless = true
            end
        end
    end
end)

-- Вкладка: OTHER
createMenuButton("Kill aura", true, "KillAura", otherTab, function(state)
    updateAlienCache()
    for _, hrp in ipairs(alienCache) do
        if hrp and hrp.Parent then
            if state then
                hrp.Size = KILL_AURA_SIZE
                hrp.Transparency = 1
                hrp.CanCollide = false
                hrp.Massless = true
            else
                local orig = originalAlienSettings[hrp]
                if orig then
                    hrp.Size = orig.Size
                    hrp.Transparency = orig.Transparency
                    hrp.CanCollide = orig.CanCollide
                    hrp.Massless = false
                end
            end
        end
    end
end)

createMenuButton("Gun aim", true, "GunAim", otherTab, nil)
createMenuButton("Instant interact", true, "InstantInteract", otherTab, nil)

local moneyPrompts = {}
local originalPromptSettings = {}

local function checkAndAddPrompt(object)
    if object:IsA("ProximityPrompt") then
        local parent = object.Parent
        if parent then
            local nameLower = parent.Name:lower()
            if nameLower:find("money") or nameLower:find("cash") or nameLower:find("coin") then
                if not originalPromptSettings[object] then
                    originalPromptSettings[object] = {
                        MaxActivationDistance = object.MaxActivationDistance,
                        RequiresLineOfSight = object.RequiresLineOfSight,
                        HoldDuration = object.HoldDuration
                    }
                end
                if toggles.AutoMoney then
                    object.MaxActivationDistance = 999999
                    object.RequiresLineOfSight = false
                    object.HoldDuration = 0
                end
                moneyPrompts[object] = true
            end
        end
    end
end

local startingDescendants = Workspace:GetDescendants()
for i = 1, #startingDescendants do
    checkAndAddPrompt(startingDescendants[i])
end

Workspace.DescendantAdded:Connect(checkAndAddPrompt)

Workspace.DescendantRemoving:Connect(function(object)
    if moneyPrompts[object] then 
        moneyPrompts[object] = nil 
    end
    if originalPromptSettings[object] then
        originalPromptSettings[object] = nil
    end
end)

RunService.Heartbeat:Connect(function()
    if toggles.AutoMoney then
        for prompt in pairs(moneyPrompts) do
            if prompt.Parent and prompt.Enabled then
                prompt:InputHoldBegin()
                prompt:InputHoldEnd()
            else
                moneyPrompts[prompt] = nil
            end
        end
    end
end)

createMenuButton("Auto collect money", true, "AutoMoney", otherTab, function(state)
    if state then
        for prompt in pairs(moneyPrompts) do
            if prompt.Parent then
                prompt.MaxActivationDistance = 999999
                prompt.RequiresLineOfSight = false
                prompt.HoldDuration = 0
            end
        end
    else
        for prompt, settings in pairs(originalPromptSettings) do
            if prompt.Parent then
                prompt.MaxActivationDistance = settings.MaxActivationDistance
                prompt.RequiresLineOfSight = settings.RequiresLineOfSight
                prompt.HoldDuration = settings.HoldDuration
            end
        end
    end
end)

createMenuButton("Auto give milk", true, "AutoGiveMilk", otherTab, function(state)
    if state then
        processAutoGiveMilk()
    end
end)
createMenuButton("More milk from a cow", true, "MoreMilkCow", otherTab, nil)

createSpeedInput(otherTab)

createMenuButton("Noclip", true, "Noclip", otherTab, nil)

-- ОПТИМИЗАЦИЯ И ВОЗВРАТ НАСТРОЕК
local optCache = {
    lighting = {},
    terrain = {},
    instances = {}
}

local function toggleOptimization(state)
    if state then
        optCache.lighting.GlobalShadows = Lighting.GlobalShadows
        optCache.lighting.FogEnd = Lighting.FogEnd
        optCache.lighting.OutdoorAmbient = Lighting.OutdoorAmbient
        
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 999999
        Lighting.OutdoorAmbient = Color3.fromRGB(150, 150, 150)
        
        local terrain = Workspace:FindFirstChildOfClass("Terrain")
        if terrain then
            optCache.terrain.WaterWaveSize = terrain.WaterWaveSize
            optCache.terrain.WaterWaveSpeed = terrain.WaterWaveSpeed
            optCache.terrain.WaterReflectance = terrain.WaterReflectance
            
            terrain.WaterWaveSize = 0
            terrain.WaterWaveSpeed = 0
            terrain.WaterReflectance = 0
        end

        for _, v in ipairs(Workspace:GetDescendants()) do
            if v:IsA("BasePart") then
                optCache.instances[v] = {
                    Material = v.Material,
                    CastShadow = v.CastShadow,
                    Reflectance = v.Reflectance
                }
                v.Material = Enum.Material.SmoothPlastic
                v.CastShadow = false
                v.Reflectance = 0
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") or v:IsA("PostEffect") or v:IsA("Light") then
                optCache.instances[v] = {
                    Enabled = v.Enabled
                }
                v.Enabled = false
            elseif v:IsA("Decal") or v:IsA("Texture") then
                optCache.instances[v] = {
                    Transparency = v.Transparency
                }
                v.Transparency = 1
            end
        end
    else
        if optCache.lighting.GlobalShadows ~= nil then
            Lighting.GlobalShadows = optCache.lighting.GlobalShadows
            Lighting.FogEnd = optCache.lighting.FogEnd
            Lighting.OutdoorAmbient = optCache.lighting.OutdoorAmbient
        end
        
        local terrain = Workspace:FindFirstChildOfClass("Terrain")
        if terrain and optCache.terrain.WaterWaveSize ~= nil then
            terrain.WaterWaveSize = optCache.terrain.WaterWaveSize
            terrain.WaterWaveSpeed = optCache.terrain.WaterWaveSpeed
            terrain.WaterReflectance = optCache.terrain.WaterReflectance
        end

        for inst, data in pairs(optCache.instances) do
            if inst and inst.Parent then
                if inst:IsA("BasePart") then
                    inst.Material = data.Material
                    inst.CastShadow = data.CastShadow
                    inst.Reflectance = data.Reflectance
                elseif inst:IsA("ParticleEmitter") or inst:IsA("Trail") or inst:IsA("Smoke") or inst:IsA("Fire") or inst:IsA("Sparkles") or inst:IsA("PostEffect") or inst:IsA("Light") then
                    inst.Enabled = data.Enabled
                elseif inst:IsA("Decal") or inst:IsA("Texture") then
                    inst.Transparency = data.Transparency
                end
            end
        end
        table.clear(optCache.instances)
    end
end

createMenuButton("Optimization functions", true, "OptimizationActive", otherTab, function(state)
    toggleOptimization(state)
end)

-- Кнопка Anti lag
local originalLightingSettings = {}
createMenuButton("Anti lag", true, "AntiLag", otherTab, function(state)
    if state then
        originalLightingSettings.GlobalShadows = Lighting.GlobalShadows
        originalLightingSettings.OutdoorAmbient = Lighting.OutdoorAmbient
        
        Lighting.GlobalShadows = false
        Lighting.OutdoorAmbient = Color3.fromRGB(135, 135, 135)
        
        for _, v in ipairs(Workspace:GetDescendants()) do
            if v:IsA("PostEffect") or v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") then
                v.Enabled = false
            elseif v:IsA("BasePart") then
                v.Material = Enum.Material.SmoothPlastic
                v.CastShadow = false
            end
        end
    else
        if originalLightingSettings.GlobalShadows ~= nil then
            Lighting.GlobalShadows = originalLightingSettings.GlobalShadows
            Lighting.OutdoorAmbient = originalLightingSettings.OutdoorAmbient
        end
        for _, v in ipairs(Workspace:GetDescendants()) do
            if v:IsA("PostEffect") or v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") then
                v.Enabled = true
            end
        end
    end
end)

-- Кнопка Potato Mode
local hiddenTrees = {}
createMenuButton("Potato mode", true, "PotatoMode", otherTab, function(state)
    if state then
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 999999
        
        for _, v in ipairs(Workspace:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Material = Enum.Material.SmoothPlastic
                v.CastShadow = false
            elseif v:IsA("PostEffect") or v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then
                v.Enabled = false
            elseif v:IsA("Light") then
                v.Enabled = false
            end
            
            if (v:IsA("Model") or v:IsA("BasePart")) and string.find(string.lower(v.Name), "tree") then
                if v.Parent and v.Parent ~= nil then
                    table.insert(hiddenTrees, {instance = v, parent = v.Parent})
                    v.Parent = nil
                end
            end
        end
    else
        for _, item in ipairs(hiddenTrees) do
            if item.instance then
                item.instance.Parent = item.parent
            end
        end
        table.clear(hiddenTrees)
    end
end)

local function getClosestAlien()
    local closest = nil
    local dist = math.huge
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end
    
    if #alienCache == 0 then updateAlienCache() end
    for _, targetHrp in ipairs(alienCache) do
        if targetHrp.Parent then
            local d = (targetHrp.Position - hrp.Position).Magnitude
            if d < dist then
                closest = targetHrp
                dist = d
            end
        end
    end
    return closest
end

RunService.Stepped:Connect(function()
    if toggles.Noclip then
        local char = LocalPlayer.Character
        if char then
            for _, v in ipairs(char:GetDescendants()) do
                if v:IsA("BasePart") and v.CanCollide then
                    v.CanCollide = false
                end
            end
        end
    end
end)

RunService.Heartbeat:Connect(function()
    if toggles.MoreMilkCow then
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if hrp then
            for _, prompt in ipairs(Workspace:GetDescendants()) do
                if prompt:IsA("ProximityPrompt") and (prompt.ObjectText == "Milk" or prompt.ActionText == "Milk") then
                    local pPart = prompt.Parent and (prompt.Parent:IsA("BasePart") and prompt.Parent or prompt.Parent:FindFirstChildWhichIsA("BasePart"))
                    if pPart then
                        if (pPart.Position - hrp.Position).Magnitude <= 25 then
                            fireproximityprompt(prompt)
                        end
                    end
                end
            end
        end
    end
end)

-- Фоновый цикл обработки Chams и Kill Aura
task.spawn(function()
    while true do
        task.wait(0.5)
        
        updateAlienCache()
        
        for i = #alienCache, 1, -1 do
            local hrp = alienCache[i]
            if not hrp or not hrp.Parent then
                table.remove(alienCache, i)
            else
                if toggles.KillAura then
                    if hrp.Size ~= KILL_AURA_SIZE then
                        hrp.Size = KILL_AURA_SIZE
                        hrp.Transparency = 1
                        hrp.CanCollide = false
                        hrp.Massless = true
                    end
                end
            end
        end
        
        -- Alien Chams
        if toggles.Chams then
            for _, hrp in ipairs(alienCache) do
                local v = hrp.Parent
                if v and not v:FindFirstChild("Tr1xHighlight") then
                    local highlight = Instance.new("Highlight")
                    highlight.Name = "Tr1xHighlight"
                    highlight.FillColor = currentChamsColor
                    highlight.FillTransparency = 0.5
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    highlight.OutlineTransparency = 0
                    highlight.Adornee = v
                    highlight.Parent = v
                end
            end
        end

        -- Chams Cow
        if toggles.ChamsCow then
            for _, v in ipairs(Workspace:GetDescendants()) do
                if string.lower(v.Name) == "cow" then
                    if not v:FindFirstChild("CowHighlight") then
                        local highlight = Instance.new("Highlight")
                        highlight.Name = "CowHighlight"
                        highlight.FillColor = currentChamsColor
                        highlight.FillTransparency = 0.5
                        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                        highlight.OutlineTransparency = 0
                        highlight.Adornee = v
                        highlight.Parent = v
                    end
                end
            end
        end

        -- NPC Chams
        if toggles.NpcChams then
            for _, v in ipairs(Workspace:GetDescendants()) do
                if v:IsA("Model") and v:FindFirstChildOfClass("Humanoid") then
                    local isPlayer = Players:GetPlayerFromCharacter(v)
                    if not isPlayer and v ~= LocalPlayer.Character then
                        if not v:FindFirstChild("NpcHighlight") then
                            local highlight = Instance.new("Highlight")
                            highlight.Name = "NpcHighlight"
                            highlight.FillColor = currentChamsColor
                            highlight.FillTransparency = 0.5
                            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                            highlight.OutlineTransparency = 0
                            highlight.Adornee = v
                            highlight.Parent = v
                        end
                    end
                end
            end
        end

        -- Alien Head Chams
        if toggles.AlienHeadChams then
            for _, v in ipairs(Workspace:GetDescendants()) do
                if string.lower(v.Name) == "alien head" or string.find(string.lower(v.Name), "alien head") then
                    if not v:FindFirstChild("AlienHeadHighlight") then
                        local highlight = Instance.new("Highlight")
                        highlight.Name = "AlienHeadHighlight"
                        highlight.FillColor = currentChamsColor
                        highlight.FillTransparency = 0.5
                        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                        highlight.OutlineTransparency = 0
                        highlight.Adornee = v
                        highlight.Parent = v
                    end
                end
            end
        end

        -- Ammo Chams
        if toggles.AmmoChams then
            for _, v in ipairs(Workspace:GetDescendants()) do
                if string.lower(v.Name) == "ammo" or string.find(string.lower(v.Name), "ammo") then
                    if not v:FindFirstChild("AmmoHighlight") then
                        local highlight = Instance.new("Highlight")
                        highlight.Name = "AmmoHighlight"
                        highlight.FillColor = currentChamsColor
                        highlight.FillTransparency = 0.5
                        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                        highlight.OutlineTransparency = 0
                        highlight.Adornee = v
                        highlight.Parent = v
                    end
                end
            end
        end

    end
end)

ProximityPromptService.PromptButtonHoldBegan:Connect(function(prompt)
    if toggles.InstantInteract then
        fireproximityprompt(prompt)
    end
end)

local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
local oldIndex = mt.__index
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    
    if toggles.GunAim and (method == "FindPartOnRayWithIgnoreList" or method == "FindPartOnRayWithWhitelist" or method == "Raycast") then
        local target = getClosestAlien()
        if target then
            if method == "Raycast" then
                local origin = args[1]
                local direction = (target.Position - origin).Unit * 5000
                args[2] = direction
                return oldNamecall(self, unpack(args))
            else
                local origin = args[1].Origin
                local direction = (target.Position - origin).Unit * 5000
                args[1] = Ray.new(origin, direction)
                return oldNamecall(self, unpack(args))
            end
        end
    end
    
    return oldNamecall(self, ...)
end)

mt.__index = newcclosure(function(self, key)
    if toggles.GunAim and key == "Hit" and self:IsA("Mouse") then
        local target = getClosestAlien()
        if target then
            return target.CFrame
        end
    end
    return oldIndex(self, key)
end)

setreadonly(mt, true)
