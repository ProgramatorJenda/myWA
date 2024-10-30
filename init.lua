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

local eventFrame = CreateFrame("Frame")
eventFrame:SetScript("OnEvent", function(self, event, addonName)
    if event == "ADDON_LOADED" and addonName == "It's Up!" then
        
        IU.UpdateAuraFrames()
        -- Unregister the event once it's handled to avoid further calls
        eventFrame:UnregisterEvent("ADDON_LOADED")
    end
end)

local auraFrame = CreateFrame("Frame")
auraFrame:SetScript("OnEvent", function(self, event, arg1)
    if (event == "UNIT_AURA" and arg1 == "player") then
        IU.showActiveFrames(IU.ActiveBuffs)
    end
end)