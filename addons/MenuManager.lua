local MenuManager = {}

function MenuManager:SetLibrary(library)
    self.Library = library
end

function MenuManager:ApplyToTab(tab)
    assert(self.Library, "Must set MenuManager.Library first!")

    local Toggles = self.Library.Toggles
    local Options = self.Library.Options
    local plr = game.Players.LocalPlayer

    local MenuGroup = tab:AddLeftGroupbox("Menu", "text-search")

    ----------------------------------------------------------------
    -- Destroy UI
    ----------------------------------------------------------------
    MenuGroup:AddButton({
        Text = "Destroy UI",
        Func = function()
            self.Library:Unload()
        end,
        Tooltip = "Click to unload the entire UI",
    })

    ----------------------------------------------------------------
    -- WalkSpeed
    ----------------------------------------------------------------
    MenuGroup:AddSlider("WalkSpeedValue", {
        Text = "WalkSpeed",
        Default = 16,
        Min = 16,
        Max = 100,
        Rounding = 0,
        Callback = function(Value)
            if plr.Character and plr.Character:FindFirstChild("Humanoid") then
                plr.Character.Humanoid.WalkSpeed = Value
            end
        end,
    })

    MenuGroup:AddToggle("WalkSpeedLoop", {
        Text = "WalkSpeed Locked",
        Default = false,
        Callback = function(Value)
            if Value then
                task.spawn(function()
                    while Toggles.WalkSpeedLoop and Toggles.WalkSpeedLoop.Value and task.wait(0.1) do
                        if plr.Character and plr.Character:FindFirstChild("Humanoid") then
                            plr.Character.Humanoid.WalkSpeed = Options.WalkSpeedValue.Value
                        end
                    end
                end)
            end
        end,
    })

    plr.CharacterAdded:Connect(function(char)
        char:WaitForChild("Humanoid")
        if Toggles.WalkSpeedLoop and Toggles.WalkSpeedLoop.Value then
            char.Humanoid.WalkSpeed = Options.WalkSpeedValue.Value
        end
    end)

    ----------------------------------------------------------------
    -- Noclip
    ----------------------------------------------------------------
    MenuGroup:AddToggle("Noclip", {
        Text = "Noclip",
        Default = false,
        Callback = function(Value)
            if Value then
                task.spawn(function()
                    while Toggles.Noclip and Toggles.Noclip.Value and task.wait() do
                        if plr.Character then
                            for _, part in pairs(plr.Character:GetDescendants()) do
                                if part:IsA("BasePart") then
                                    part.CanCollide = false
                                end
                            end
                        end
                    end
                end)
            end
        end,
    })

    ----------------------------------------------------------------
    -- Infinite Jump
    ----------------------------------------------------------------
    MenuGroup:AddToggle("InfJump", {
        Text = "Infinite Jump",
        Default = false,
        Callback = function(Value)
            if Value then
                local UIS = game:GetService("UserInputService")
                local conn
                conn = UIS.JumpRequest:Connect(function()
                    if Toggles.InfJump and Toggles.InfJump.Value and plr.Character and plr.Character:FindFirstChildOfClass("Humanoid") then
                        plr.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                end)

                Toggles.InfJumpConnection = conn
            else
                if Toggles.InfJumpConnection then
                    Toggles.InfJumpConnection:Disconnect()
                    Toggles.InfJumpConnection = nil
                end
            end
        end,
    })

    ----------------------------------------------------------------
    -- Black Screen
    ----------------------------------------------------------------
    local blackGui
    MenuGroup:AddToggle("BlackScreen", {
        Text = "Black Screen",
        Default = false,
        Callback = function(Value)
            if Value then
                if not blackGui then
                    blackGui = Instance.new("ScreenGui")
                    blackGui.IgnoreGuiInset = true
                    blackGui.DisplayOrder = 999999
                    blackGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
                    blackGui.Parent = plr:WaitForChild("PlayerGui")

                    local frame = Instance.new("Frame")
                    frame.Size = UDim2.new(1, 0, 1, 0)
                    frame.BackgroundColor3 = Color3.new(0, 0, 0)
                    frame.BorderSizePixel = 0
                    frame.ZIndex = 999999
                    frame.Parent = blackGui
                end
                blackGui.Enabled = true
            else
                if blackGui then
                    blackGui.Enabled = false
                end
            end
        end
    })

    ----------------------------------------------------------------
    -- Reduce Lag
    ----------------------------------------------------------------
    MenuGroup:AddButton({
        Text = "Reduce Lag",
        Func = function()
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.Material = Enum.Material.SmoothPlastic
                    v.Reflectance = 0
                elseif v:IsA("Texture") or v:IsA("Decal") then
                    v:Destroy()
                elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                    v:Destroy()
                elseif v:IsA("Explosion") then
                    v:Destroy()
                end
            end
            self.Library:Notify("Reduce Lag applied!", 3)
        end,
        Tooltip = "Optimize workspace (remove textures/particles)",
    })

    ----------------------------------------------------------------
    -- UI Scale
    ----------------------------------------------------------------
    MenuGroup:AddInput("DPIScaleInput", {
        Text = "UI Scale",
        Default = "100",
        Numeric = true,
        Finished = true,
        Callback = function(value)
            local num = tonumber(value)
            if num and num >= 90 and num <= 150 then
                self.Library:SetDPIScale(num)
                self.Library:Notify("UI Scale set to " .. num .. "%", 3)
            else
                self.Library:Notify("Value must be between 90 and 150", 3)
            end
        end
    })
end

return MenuManager