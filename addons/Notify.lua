-- Notify.lua
local DEFAULT_TITLE = "Celestial Notification"

local function Chloe(desc, time, sound)
    local note = Library:Notify({
        Title = DEFAULT_TITLE,
        Description = desc,
        Time = time or 3,
        SoundId = sound,
    })

    -- kasih gradient ke Title
    task.spawn(function()
        local title = note and note.Frame and note.Frame.Title
        if title and not title:FindFirstChild("UIGradient") then
            local gradient = Instance.new("UIGradient")
            gradient.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 85, 255)),
                ColorSequenceKeypoint.new(0.33, Color3.fromRGB(174, 0, 255)),
                ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 191, 255)),
                ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 85, 255)),
            })
            gradient.Rotation = 90 -- kalau mau efek vertikal coba ganti 90
            gradient.Parent = title
        end
    end)

    return note
end

return Chloe
