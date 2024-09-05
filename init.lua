-- Handles slash commands
SLASH_MWA1 = '/mwa'
--TODO: Not Create, ToggleMainWindow
SlashCmdList['MWA'] = function(msg)
    if msg == "" then
        ToggleMainWindow()
    else
        print("Unknown command, please try again")
    end
end