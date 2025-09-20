local function Chloe(desc, time, sound)
    local notif = Library:Notify({
        Title = "Celestial Notification",
        Description = desc,
        Time = time or 4,
        SoundId = sound,
    })

    -- kasih gradient ke Title
    task.spawn(function()
        if notif and notif.TitleLabel then
            local grad = Instance.new("UIGradient")
            grad.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 42, 255)),
                ColorSequenceKeypoint.new(0.15, Color3.fromRGB(208, 0, 255)),
                ColorSequenceKeypoint.new(0.30, Color3.fromRGB(120, 190, 255)),
                ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 42, 255)),
                ColorSequenceKeypoint.new(0.70, Color3.fromRGB(120, 190, 255)),
                ColorSequenceKeypoint.new(0.85, Color3.fromRGB(50, 15, 153)),
                ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 42, 255)),
            })
            grad.Rotation = 0
            grad.Parent = notif.TitleLabel
        end
    end)

    return notif
end

return Chloe