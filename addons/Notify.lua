-- Notify.lua
local DEFAULT_TITLE = "Celestial :3"

local function Chloe(desc, time, sound)
    local note = Library:Notify({
        Title = DEFAULT_TITLE,
        Description = desc,
        Time = time or 4,
        SoundId = sound,
    })

    return note
end

return Chloe
