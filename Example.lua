--== Example.lua ==--

-- load framework
local Celestial = loadstring(game:HttpGet("https://raw.githubusercontent.com/ChloeRewite/CelestialObisidian/main/Celestial.lua"))()

-- ambil Library
local Library = Celestial.Library

-- bikin window utama
local Window = Library:CreateWindow({
    Title = "Celestial v66",
    Footer = "<font color='rgb(0,191,255)'>Version 1.1.1 Beta</font>",
    Icon = 114485138345111,
    ShowCustomCursor = false,
})

-- bikin tabs
local Tabs = {
    Info     = Window:AddTab("Info", "info"),
    Main     = Window:AddTab("Main", "home"),
    Settings = Window:AddTab("Settings", "settings"),
}

-- init framework (apply ThemeManager, SaveManager, dsb.)
Celestial.Init(Window, Tabs)

--==============================
-- Example Features
--==============================

-- Groupbox di tab Main (kiri)
local MainBox = Tabs.Main:AddLeftGroupbox("Main Features")

MainBox:AddToggle("AutoFarm", {
    Text = "Enable Auto Farm",
    Default = false
}):OnChanged(function(state)
    if state then
        Chloe("AutoFarm Enabled!") -- pakai global Chloe
    else
        Chloe("AutoFarm Disabled!")
    end
end)

MainBox:AddButton("Test Notify", function()
    Chloe("Halo dari Celestial Example!", 5)
end)

-- Groupbox di tab Settings (kanan)
local SettingsBox = Tabs.Settings:AddRightGroupbox("Utilities")

SettingsBox:AddButton("Force Save Config", function()
    Chloe("Config saved!", 3)
end)

-- Info tab sudah otomatis diisi InfoManager & ButtonManager dari Init()
