-- addons/Notify.lua
local DEFAULT_TITLE = "Celestial Script"

local function Chloe(desc, time, sound)
    local note = Library:Notify({
        Title = DEFAULT_TITLE,
        Description = desc,
        Time = time or 3,
        SoundId = sound,
    })

    task.spawn(function()
        local title = note and note.Frame and note.Frame.Title
        if title then
            -- MATIIN RichText biar ga auto split
            title.RichText = false

            -- font dibold manual
            title.Font = Enum.Font.GothamBold

            -- biar aman ga kebelah 2
            title.TextWrapped = false
            title.TextXAlignment = Enum.TextXAlignment.Left
            title.TextTruncate = Enum.TextTruncate.AtEnd

            -- kalau width terlalu kecil, paksa perbesar sedikit
            if title.TextBounds.X > title.AbsoluteSize.X then
                title.Size = UDim2.new(1, 50, title.Size.Y.Scale, title.Size.Y.Offset)
            end

            -- kasih gradient
            if not title:FindFirstChild("UIGradient") then
                local gradient = Instance.new("UIGradient")
                gradient.Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(140, 82, 255)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 191, 255))
                }
                gradient.Rotation = 90
                gradient.Parent = title
            end
        end
    end)

    return note
end

return Chloe
