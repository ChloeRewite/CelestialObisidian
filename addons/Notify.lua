-- Notify.lua
local DEFAULT_TITLE = "Celestial Script"

local function Chloe(desc, time, sound)
    local note = Library:Notify({
        Title = DEFAULT_TITLE,
        Description = desc,
        Time = time or 4,
        SoundId = sound,
    })

    -- opsional: kasih gradient ke Title
    task.spawn(function()
        local title = note and note.Frame and note.Frame.Title
        if title and not title:FindFirstChild("UIGradient") then
            local gradient = Instance.new("UIGradient")
            gradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.fromRGB(140, 82, 255)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 191, 255))
            }
            gradient.Rotation = 90
            gradient.Parent = title
        end
    end)

    return note
end

return Chloe
