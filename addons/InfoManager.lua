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
end

return InfoManager