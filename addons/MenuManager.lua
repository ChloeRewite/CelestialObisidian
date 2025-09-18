local MenuManager = {}

function MenuManager:SetLibrary(library)
    self.Library = library
end

function MenuManager:ApplyToTab(tab)
    assert(self.Library, "Must set MenuManager.Library first!")

    local Toggles = self.Library.Toggles
    local Options = self.Library.Options

    local MenuGroup = tab:AddLeftGroupbox("Menu", "text-search")

    -- Unload UI
    MenuGroup:AddButton({
        Text = "Destroy UI",
        Func = function()
            self.Library:Unload()
        end,
        Tooltip = "Click to unload the entire UI",
    })

    -- WalkSpeed Slider
    MenuGroup:AddSlider("WalkSpeedValue", {
        Text = "WalkSpeed",
        Default = 16,
        Min = 16,
        Max = 100,
        Rounding = 0,
        Callback = function(Value)
            local plr = game.Players.LocalPlayer
            if plr.Character and plr.Character:FindFirstChild("Humanoid") then
                plr.Character.Humanoid.WalkSpeed = Value
            end
        end,
    })

    -- Toggle loop WS (fix)
    MenuGroup:AddToggle("WalkSpeedLoop", {
        Text = "WalkSpeed Locked",
        Default = false,
        Callback = function(Value)
            if Value then
                task.spawn(function()
                    while Toggles.WalkSpeedLoop and Toggles.WalkSpeedLoop.Value and task.wait(0.1) do
                        local plr = game.Players.LocalPlayer
                        if plr.Character and plr.Character:FindFirstChild("Humanoid") then
                            plr.Character.Humanoid.WalkSpeed = Options.WalkSpeedValue.Value
                        end
                    end
                end)
            end
        end,
    })

    -- Respawn handler
    local plr = game.Players.LocalPlayer
    plr.CharacterAdded:Connect(function(char)
        char:WaitForChild("Humanoid")
        if Toggles.WalkSpeedLoop and Toggles.WalkSpeedLoop.Value then
            char.Humanoid.WalkSpeed = Options.WalkSpeedValue.Value
        end
    end)

    -- Noclip
    MenuGroup:AddToggle("Noclip", {
        Text = "Noclip",
        Default = false,
        Callback = function(Value)
            if Value then
                task.spawn(function()
                    while Toggles.Noclip and Toggles.Noclip.Value and task.wait() do
                        local plr = game.Players.LocalPlayer
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

    -- Reduce Lag
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
end

return MenuManager
