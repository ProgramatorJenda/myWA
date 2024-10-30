-- Started this project on 31.08.2024
-- Have no idea what most of lua is, but here we go :)

IU = IU or {}

-- Handles slash commands
SLASH_MWA1 = '/IU'

SlashCmdList['IU'] = function(msg)
    if msg == "" then
        IU.ToggleMainWindow()
    else
        print("Unknown command, please try again")
    end
end