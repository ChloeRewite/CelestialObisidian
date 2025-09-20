-- addons/Notify.lua
local DEFAULT_TITLE = "Celestial Script"

local function Chloe(desc, time, sound)
    local note = Library:Notify({
        Title = DEFAULT_TITLE,
        Description = desc,
        Time = time or 3,
        SoundId = sound,
    })
    return note
end

return Chloe
