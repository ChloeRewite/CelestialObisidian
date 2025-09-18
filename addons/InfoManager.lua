local InfoManager = {}

function InfoManager:SetLibrary(library)
    self.Library = library
end

function InfoManager:ApplyToTab(tab)
    assert(self.Library, "Must set InfoManager.Library first!")

    -- Groupbox kiri
    local InfoGroup = tab:AddLeftGroupbox("CELESTIAL SCRIPT")
    InfoGroup:AddDivider()

    InfoGroup:AddLabel(
        "Welcome To <font color='rgb(0,170,255)'>CELESTIAL SCRIPT</font>\n\n" ..
        "<font color='rgb(0,255,0)'>Read this:</font>\n" ..
        "This game is still in <font color='rgb(0,170,255)'>development</font>.\n" ..
        "If you encounter any <font color='rgb(255,165,0)'>bug</font> or <font color='rgb(255,0,0)'>errors</font>,\n" ..
        "please report them via <font color='rgb(0,170,255)'>Discord</font>.\n\n" ..
        "Thank you for using <font color='rgb(0,170,255)'>CELESTIAL</font>.",
        true -- biar text wrap otomatis
    )

    InfoGroup:AddDivider()

    -- Discord link
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
        Tooltip = "Click to copy our Discord invite",
    })

    InfoGroup:AddDivider()

    -- Rejoin button
    InfoGroup:AddButton({
        Text = "Rejoin Game",
        Func = function()
            local TeleportService = game:GetService("TeleportService")
            local Players = game:GetService("Players")
            local LocalPlayer = Players.LocalPlayer
            TeleportService:Teleport(game.PlaceId, LocalPlayer)
        end,
        Tooltip = "Click to rejoin this server",
    })
end

return InfoManager
