local ButtonManager = {}
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

getgenv().globalcolour = {
    "Celestial v66",
    "Celestial Script",
    "Celestial Information",
    "Menu",
    "Configuration",
    "Server Info",
    "Reminder for you :3",
    "Dangerous Area",
    "Alert! Not safe",
    "How to use it?",
    "Information Script",
    "Webhook Celestial",
    "Notification Celestial!",
}

function ButtonManager:Init(Library)
    local Chloe = Instance.new("ScreenGui")
    local Button = Instance.new("ImageButton")
    local Corner = Instance.new("UICorner")
    local Scale = Instance.new("UIScale")
    local Stroke = Instance.new("UIStroke")
    local Gradient = Instance.new("UIGradient")

    Chloe.Name = "ChloeImup"
    Chloe.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    Chloe.ResetOnSpawn = false
    Chloe.Parent = CoreGui

    Button.Name = "ChloeGemoy"
    Button.Parent = Chloe
    Button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Button.Size = UDim2.new(0, 40, 0, 40)
    Button.Position = UDim2.new(0, 10, 0, 50)
    Button.Image = "rbxassetid://116234420466805"
    Button.Draggable = true

    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Button
    Scale.Scale = 1
    Scale.Parent = Button

    Stroke.Thickness = 4
    Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    Stroke.LineJoinMode = Enum.LineJoinMode.Round
    Stroke.Color = Color3.fromRGB(145, 110, 255)
    Stroke.Parent = Button

    Gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 42, 255)),
        ColorSequenceKeypoint.new(0.15, Color3.fromRGB(208, 0, 255)),
        ColorSequenceKeypoint.new(0.30, Color3.fromRGB(120, 190, 255)),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 42, 255)),
        ColorSequenceKeypoint.new(0.70, Color3.fromRGB(120, 190, 255)),
        ColorSequenceKeypoint.new(0.85, Color3.fromRGB(50, 15, 153)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 42, 255))
    })
    Gradient.Rotation = 0
    Gradient.Parent = Stroke

    -- Hover effect
    Button.MouseEnter:Connect(function()
        TweenService:Create(Scale, TweenInfo.new(0.1), { Scale = 1.2 }):Play()
    end)
    Button.MouseLeave:Connect(function()
        TweenService:Create(Scale, TweenInfo.new(0.1), { Scale = 1 }):Play()
    end)

    -- Toggle UI
    Button.MouseButton1Click:Connect(function()
        Library:Toggle()
    end)

    -- Hapus kalau UI unload
    Library:OnUnload(function()
        Chloe:Destroy()
    end)

    ----------------------------------------------------------------
    -- GRADIENT SYSTEM
    ----------------------------------------------------------------
    local function getKeywords()
        local merged = {}
        for _, v in ipairs(getgenv().globalcolour or {}) do
            table.insert(merged, v)
        end
        for _, v in ipairs(Colour or {}) do
            table.insert(merged, v)
        end
        return merged
    end

    local function ApplyGradient(root)
        local sharedGradient = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)),
            ColorSequenceKeypoint.new(0.33, Color3.fromRGB(174, 0, 255)),
            ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 191, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 85, 255)),
        })

        local keywords = getKeywords()

        for _, lbl in ipairs(root:GetDescendants()) do
            if lbl:IsA("TextLabel") or lbl:IsA("TextButton") then
                local textLower = string.lower(lbl.Text)
                local shouldColor = false

                -- cek keywords
                for _, key in ipairs(keywords) do
                    if string.find(lbl.Text, key) then
                        shouldColor = true
                        break
                    end
                end

                -- auto detect "feature"
                if string.find(textLower, "feature") then
                    shouldColor = true
                end

                if shouldColor then
                    lbl.RichText = false
                    lbl.TextWrapped = false
                    lbl.TextTruncate = Enum.TextTruncate.AtEnd

                    -- Gunakan Jura Bold (FontFace)
                    pcall(function()
                        lbl.FontFace = Font.new(
                            "rbxasset://fonts/families/Jura.json",
                            Enum.FontWeight.Bold,
                            Enum.FontStyle.Normal
                        )
                    end)

                    lbl.TextColor3 = Color3.fromRGB(255, 255, 255)

                    if not lbl:FindFirstChildWhichIsA("UIGradient") then
                        local grad = Instance.new("UIGradient")
                        grad.Color = sharedGradient
                        grad.Rotation = 28
                        grad.Parent = lbl
                    end
                end
            end
        end
    end

    task.defer(function()
        local ui = Library.UI or Library.ScreenGui
        if ui then
            ApplyGradient(ui)
            ui.DescendantAdded:Connect(function(obj)
                if obj:IsA("TextLabel") or obj:IsA("TextButton") then
                    ApplyGradient(ui)
                end
            end)
        end
    end)

    ----------------------------------------------------------------
    -- ANTI AFK SYSTEM
    ----------------------------------------------------------------
    local player = game:GetService("Players").LocalPlayer
    local GC = getconnections or get_signal_cons
    if GC then
        for _, v in pairs(GC(player.Idled)) do
            if v.Disable then
                v:Disable()
            elseif v.Disconnect then
                v:Disconnect()
            end
        end
    else
        local VirtualUser = cloneref(game:GetService("VirtualUser"))
        player.Idled:Connect(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end)
    end
end

return ButtonManager
