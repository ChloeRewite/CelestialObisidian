local InfoManager = {}

function InfoManager:SetLibrary(library)
    self.Library = library
end

function InfoManager:ApplyToTab(tab)
    assert(self.Library, "Must set InfoManager.Library first!")

    ----------------------------------------------------------------
    -- Groupbox kiri: Logo + Info
    ----------------------------------------------------------------
    local LogoGroup = tab:AddLeftGroupbox("Celestial Script")
    LogoGroup:AddImage("CelestialLogo", {
        Image = "rbxassetid://100991150375211",
        Height = 200,
    })

    local InfoGroup = tab:AddLeftGroupbox("Celestial Information")
    InfoGroup:AddDivider()

    InfoGroup:AddLabel(
        "Welcome To <font color='rgb(0,170,255)'>CELESTIAL!</font>\n\n" ..
        "<font color='rgb(0,255,0)'>Read this:</font>\n" ..
        "This game is still in <font color='rgb(0,170,255)'>development</font>.\n" ..
        "If you encounter any <font color='rgb(255,165,0)'>bug</font> or <font color='rgb(255,0,0)'>errors</font>,\n" ..
        "please report them via <font color='rgb(0,170,255)'>Discord</font>.\n\n" ..
        "Thank you for using <font color='rgb(0,170,255)'>CELESTIAL</font>.",
        true
    )

    InfoGroup:AddDivider()
    InfoGroup:AddLabel("Join our Discord:")

    InfoGroup:AddButton({
        Text = "Copy Discord Link",
        Func = function()
            setclipboard("https://discord.gg/PaPvGUE8UC")
            self.Library:Notify({
                Title = "Copied!",
                Description = "Discord link copied to clipboard",
                Time = 2
            })
        end,
    })

    InfoGroup:AddButton({
        Text = "Rejoin Game",
        Func = function()
            local TeleportService = game:GetService("TeleportService")
            local Players = game:GetService("Players")
            local LocalPlayer = Players.LocalPlayer
            TeleportService:Teleport(game.PlaceId, LocalPlayer)
        end,
    })

    ----------------------------------------------------------------
    -- Groupbox kanan: Server Info
    ----------------------------------------------------------------
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local MarketplaceService = game:GetService("MarketplaceService")

    local RightGroup = tab:AddRightGroupbox("Server Info")

    RightGroup:AddLabel("<font color='rgb(255,255,0)'>Game Name:</font> " .. MarketplaceService:GetProductInfo(game.PlaceId).Name, true)
    RightGroup:AddLabel("<font color='rgb(0,170,255)'>Player:</font> " .. LocalPlayer.Name, true)

    local currentPlayers = #Players:GetPlayers()
    local maxPlayers = Players.MaxPlayers
    local activeColor = (currentPlayers >= maxPlayers) and "rgb(255,0,0)" or "rgb(0,255,0)"
    RightGroup:AddLabel(string.format("Active Players: <font color='%s'>%d/%d</font>", activeColor, currentPlayers, maxPlayers), true)

    RightGroup:AddLabel("<font color='rgb(255,165,0)'>JobId:</font> " .. game.JobId, true)

    local joinTime = os.time()
    RightGroup:AddLabel("<font color='rgb(173,216,230)'>Joined At:</font> " .. os.date("%H:%M:%S", joinTime), true)

    local playtimeLabel = RightGroup:AddLabel("<font color='rgb(144,238,144)'>Current Playtime:</font> 00:00:00", true)
    task.spawn(function()
        while task.wait(1) do
            local elapsed = os.time() - joinTime
            local h = math.floor(elapsed / 3600)
            local m = math.floor((elapsed % 3600) / 60)
            local s = elapsed % 60
            playtimeLabel:SetText(string.format("<font color='rgb(144,238,144)'>Current Playtime:</font> %02d:%02d:%02d", h, m, s))
        end
    end)

    RightGroup:AddDivider()

    RightGroup:AddButton({
        Text = "Copy JobId",
        Func = function()
            setclipboard(game.JobId)
            self.Library:Notify("JobId copied!", 2)
        end,
    })

    RightGroup:AddButton({
        Text = "Server Hop",
        Func = function()
            local TeleportService = game:GetService("TeleportService")
            TeleportService:Teleport(game.PlaceId, LocalPlayer)
        end,
    })

    RightGroup:AddDivider()

    local targetJobId = ""
    RightGroup:AddInput("JobIdInput", {
        Text = "Target JobId",
        Placeholder = "Enter JobId here",
        Callback = function(value)
            targetJobId = value
        end
    })

    RightGroup:AddButton({
        Text = "Join JobId",
        Func = function()
            if targetJobId ~= "" then
                local TeleportService = game:GetService("TeleportService")
                TeleportService:TeleportToPlaceInstance(game.PlaceId, targetJobId, LocalPlayer)
            else
                self.Library:Notify("Please input a JobId first", 2)
            end
        end,
    })
end

return InfoManager