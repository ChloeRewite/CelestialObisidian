-- addons/Notify.lua
local DEFAULT_TITLE = "Celestial Notifier"

local function Chloe(desc, time, sound)
    local note = Library:Notify({
        Title = DEFAULT_TITLE,
        Description = desc,
        Time = time or 4,
        SoundId = sound,
    })

    task.defer(function()
        if note and note.Frame then
            -- Cari Title di semua descendant
            local title
            for _, obj in ipairs(note.Frame:GetDescendants()) do
                if obj:IsA("TextLabel") and string.find(obj.Text, DEFAULT_TITLE) then
                    title = obj
                    break
                end
            end

            if title then
                title.RichText = false
                title.TextWrapped = false
                title.TextTruncate = Enum.TextTruncate.None
                title.TextColor3 = Color3.fromRGB(255, 255, 255)

                -- FontFace Jura Bold
                pcall(function()
                    title.FontFace = Font.new(
                        "rbxasset://fonts/families/Jura.json",
                        Enum.FontWeight.Bold,
                        Enum.FontStyle.Normal
                    )
                end)

                -- Gradient Title
                if not title:FindFirstChildWhichIsA("UIGradient") then
                    local grad = Instance.new("UIGradient")
                    grad.Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)),
                        ColorSequenceKeypoint.new(0.33, Color3.fromRGB(174, 0, 255)),
                        ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 191, 255)),
                        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 85, 255)),
                    })
                    grad.Rotation = 28
                    grad.Parent = title
                end
            end

            -- Description
            local descLabel
            for _, obj in ipairs(note.Frame:GetDescendants()) do
                if obj:IsA("TextLabel") and string.find(obj.Text, desc) then
                    descLabel = obj
                    break
                end
            end

            if descLabel then
                descLabel.RichText = false
                descLabel.TextWrapped = true
                descLabel.TextTruncate = Enum.TextTruncate.None
                descLabel.TextColor3 = Color3.fromRGB(220, 220, 220)

                pcall(function()
                    descLabel.FontFace = Font.new(
                        "rbxasset://fonts/families/Jura.json",
                        Enum.FontWeight.Regular,
                        Enum.FontStyle.Normal
                    )
                end)
            end
        end
    end)

    return note
end

return Chloe