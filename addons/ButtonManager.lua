local ButtonManager = {}
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

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

    -- Gradient ke semua teks UI
    local function ApplyGradientToAllText(ui)
        local sharedGradient = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)),
            ColorSequenceKeypoint.new(0.33, Color3.fromRGB(174, 0, 255)),
            ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 191, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 85, 255)),
        })

        for _, lbl in ipairs(ui:GetDescendants()) do
            if lbl:IsA("TextLabel") or lbl:IsA("TextButton") or lbl:IsA("TextBox") then
                lbl.RichText = true
                lbl.TextColor3 = Color3.new(1, 1, 1)
                if not lbl:FindFirstChildWhichIsA("UIGradient") then
                    local grad = Instance.new("UIGradient")
                    grad.Color = sharedGradient
                    grad.Rotation = 28
                    grad.Parent = lbl
                end
            end
        end
    end

    task.defer(function()
        local ui = CoreGui:WaitForChild(Library.Window.Title, 10)
        if ui then
            ApplyGradientToAllText(ui)
        end
    end)
end

return ButtonManager
