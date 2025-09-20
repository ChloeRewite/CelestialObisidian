--== Celestial Framework ==--

local repo = "https://raw.githubusercontent.com/ChloeRewite/CelestialObisidian/main/"

-- ambil library UI
local Library       = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager  = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager   = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()
local InfoManager   = loadstring(game:HttpGet(repo .. "addons/InfoManager.lua"))()
local ButtonManager = loadstring(game:HttpGet(repo .. "addons/ButtonManager.lua"))()
local MenuManager   = loadstring(game:HttpGet(repo .. "addons/MenuManager.lua"))()
local Chloe         = loadstring(game:HttpGet(repo .. "addons/Notify.lua"))()

-- simpan manager ke global
getgenv().CelestialManagers = {
    ThemeManager  = ThemeManager,
    SaveManager   = SaveManager,
    InfoManager   = InfoManager,
    ButtonManager = ButtonManager,
    MenuManager   = MenuManager,
    Chloe         = Chloe,
}

-- shortcut global biar bisa langsung Chloe("msg")
getgenv().Chloe = Chloe

-- fungsi init dipanggil dari main.lua
local function Init(Window, Tabs)
    --== THEME ==--
    ThemeManager:SetLibrary(Library)
    ThemeManager:SetDefaultTheme("Default")
    Library:SetFont(Enum.Font.Jura)

    --== SAVE ==--
    SaveManager:SetLibrary(Library)
    SaveManager:IgnoreThemeSettings()
    SaveManager:SetIgnoreIndexes({ "MenuKeybind" })

    --== INFO ==--
    InfoManager:SetLibrary(Library)
    InfoManager:ApplyToTab(Tabs.Info)

    --== BUTTON ==--
    ButtonManager:Init(Library)

    --== MENU ==--
    MenuManager:SetLibrary(Library)
    MenuManager:ApplyToTab(Tabs.Settings)

    --== FOLDERS ==--
    ThemeManager:SetFolder("CelestialObisidian")
    SaveManager:SetFolder("CelestialObisidian")
    SaveManager:SetSubFolder("Configs")

    --== CONFIG SYSTEM ==--
    SaveManager:BuildConfigSection(Tabs.Settings)

    -- panggil terakhir biar semua element sudah siap
    task.defer(function()
        local ok, err = pcall(function()
            SaveManager:LoadAutoloadConfig()
        end)

        if ok then
            local cfg = SaveManager.AutoloadConfig or "none"
            print("[Celestial] Autoload sync success → " .. tostring(cfg))
            warn("[Celestial] Loaded config:", cfg)
        else
            warn("[Celestial] Autoload failed:", err)
        end
    end)
end

-- return buat main.lua
return {
    Library = Library,
    Init = Init,
}
