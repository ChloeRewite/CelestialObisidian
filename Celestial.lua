--== Celestial Framework ==--

local repo = "https://raw.githubusercontent.com/<username>/<repo>/main/"

-- ambil library UI
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()

-- addons
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager  = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()
local InfoManager  = loadstring(game:HttpGet(repo .. "addons/InfoManager.lua"))()
local ButtonManager= loadstring(game:HttpGet(repo .. "addons/ButtonManager.lua"))()
local MenuManager  = loadstring(game:HttpGet(repo .. "addons/MenuManager.lua"))()
local Chloe        = loadstring(game:HttpGet(repo .. "addons/Notify.lua"))()

-- simpan manager ke global
getgenv().CelestialManagers = {
    ThemeManager = ThemeManager,
    SaveManager  = SaveManager,
    InfoManager  = InfoManager,
    ButtonManager= ButtonManager,
    MenuManager  = MenuManager,
    Chloe        = Chloe,
}

-- shortcut global biar bisa langsung Chloe("msg")
getgenv().Chloe = Chloe

-- fungsi init dipanggil dari main.lua
local function Init(Window, Tabs)
    -- theme & save
    ThemeManager:SetLibrary(Library)
    SaveManager:SetLibrary(Library)
    SaveManager:IgnoreThemeSettings()
    SaveManager:SetIgnoreIndexes({ "MenuKeybind" })

    ThemeManager:SetFolder("CelestialObisidian")
    SaveManager:SetFolder("CelestialObisidian/configs")

    ThemeManager:ApplyToTab(Tabs.Settings)
    SaveManager:BuildConfigSection(Tabs.Settings)

    -- info & button
    InfoManager:SetLibrary(Library)
    InfoManager:ApplyToTab(Tabs.Info)

    ButtonManager:SetLibrary(Library)
    ButtonManager:ApplyToTab(Tabs.Info)

    -- menu utama
    MenuManager:SetLibrary(Library)
    MenuManager:ApplyToTab(Tabs.Main)

    -- autoload config
    SaveManager:LoadAutoloadConfig()
end

-- return buat main.lua
return {
    Library = Library,
    Init = Init,
}
