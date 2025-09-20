-- modified for CelestialObisidian by ChloeRewrite

local repo = "https://raw.githubusercontent.com/ChloeRewite/CelestialObisidian/main/"
local Library       = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager  = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager   = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()
local InfoManager   = loadstring(game:HttpGet(repo .. "addons/InfoManager.lua"))()
local ButtonManager = loadstring(game:HttpGet(repo .. "addons/ButtonManager.lua"))()
local MenuManager   = loadstring(game:HttpGet(repo .. "addons/MenuManager.lua"))()


getgenv().ColourTitle = {
    "Celestial",
    "Celestial v66",
    "Celestial Script",
    "Menu",
    "Configuration",
}

local Options           = Library.Options
local Toggles           = Library.Toggles
Library.IsMobile = false
Library.ToggleKeybind   = nil

local Window = Library:CreateWindow({
    Title = "Celestial v66",
    Footer = "<font color='rgb(0,191,255)'>Version 1.1.1 Beta</font>",
    Icon = 114485138345111,
    ShowCustomCursor = false,
})

local Tabs = {
    Info        = Window:AddTab("Info", "info"),
    Main        = Window:AddTab("Main", "user"),
    Key         = Window:AddKeyTab("Key System"),
    Settings    = Window:AddTab("Miscellaneous", "settings"),
}

----------------------------------------------------
-- === Contoh Isi Main Tab
----------------------------------------------------
local LeftGroupBox = Tabs.Main:AddLeftGroupbox("Main Features", "boxes")

LeftGroupBox:AddToggle("ExampleToggle", {
    Text = "Auto Fish",
    Default = false,
    Callback = function(Value)
        print("Auto Fish state:", Value)
    end,
})

----------------------------------------------------
-- === Key System Example
----------------------------------------------------
Tabs.Key:AddLabel({
    Text = "Key: Banana",
    DoesWrap = true,
    Size = 16,
})

Tabs.Key:AddKeyBox("Banana", function(Success, ReceivedKey)
    print("Expected: Banana | Got:", ReceivedKey, "| Success:", Success)
    Library:Notify({
        Title = "Key System",
        Description = "Expected: Banana\nReceived: " .. ReceivedKey .. "\nSuccess: " .. tostring(Success),
        Time = 4,
    })
end)



Library:SetFont(Enum.Font.Jura)
ThemeManager:SetLibrary(Library)
ThemeManager:SetDefaultTheme({
    BackgroundColor = Color3.fromRGB(0, 0, 0),
    MainColor       = Color3.fromRGB(0, 0, 0),
    AccentColor     = Color3.fromRGB(0, 81, 255),
    OutlineColor    = Color3.fromRGB(15, 25, 55),
    FontColor       = Color3.fromRGB(255, 255, 255),
    FontFace        = Enum.Font.Jura,
})

SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ "MenuKeybind" })
InfoManager:SetLibrary(Library)
InfoManager:ApplyToTab(Tabs.Info)
ButtonManager:Init(Library)
MenuManager:SetLibrary(Library)
MenuManager:ApplyToTab(Tabs.Settings)
ThemeManager:SetFolder("CelestialHub")
SaveManager:SetFolder("CelestialHub/Configs")
SaveManager:BuildConfigSection(Tabs.Settings)
SaveManager:LoadAutoloadConfig()

local ActiveConfig = nil

local oldLoad = SaveManager.Load
function SaveManager:Load(name)
    ActiveConfig = name
    return oldLoad(self, name)
end

local oldSave = SaveManager.Save
function SaveManager:Save(name, ...)
    ActiveConfig = name
    return oldSave(self, name, ...)
end

local function AutoSave()
    if ActiveConfig then
        pcall(function()
            SaveManager:Save(ActiveConfig)
        end)
    end
end

for _, toggle in pairs(Library.Toggles) do
    toggle:OnChanged(AutoSave)
end

for _, option in pairs(Library.Options) do
    option:OnChanged(AutoSave)
end