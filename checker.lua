--Plan for this project:
--Create a window that shows checkboxes for each important aura that you should have active
--on each class
--Ticking a checkbox adds the buff/aura to the desiredBuffs table, that is being checked
--Starting with Priest - example of important auras, Inner light/Shadow, PW:Fortitude

--Create a Frame for Event listening
local frame = CreateFrame("Frame")
local buffFrame
local desiredBuffs = { "Renew", "Inner Light"}

local function CheckForBuff(desiredBuffs)
    local iconTexture = nil
    local buffFound = false
    local aura
    local missingAuras = {}

    for i = 1, #desiredBuffs do
        for j = 1, 40 do
            aura = C_UnitAuras.GetBuffDataByIndex("player", j)

            if aura and aura.name == desiredBuffs[i] then
                buffFound = true
                table.insert(missingAuras, aura.name)
                iconTexture = aura.icon
                break
            end
        end
    end

    -- Debug
    -- for x = 1, #missingAuras do
    --     print(missingAuras[x])
    -- end

    -- Now works the other way than whats intented, because its easier to work with
    --TODO: need to make a list or a row of frame icons (textures) that will be next to each other instead of on top of each other
    -- and wrap it around in a function that takes the returned table from CheckForBuff function
    if buffFound then
        if not buffFrame then
            buffFrame = CreateFrame("Frame", "BuffAlertFrame", UIParent)
            buffFrame:SetSize(30, 30)
            buffFrame:SetPoint("CENTER")

            buffFrame.icon = buffFrame:CreateTexture(nil, "OVERLAY")
            buffFrame.icon:SetAllPoints()
        end
        buffFrame.icon:SetTexture(iconTexture)
        ActionButton_ShowOverlayGlow(buffFrame)
        buffFrame:Show()
    else
        if buffFrame then
            ActionButton_HideOverlayGlow(buffFrame)
            buffFrame:Hide()
        end
    end
end

frame:SetScript("OnEvent", function (self, event, arg1)
    if (event == "UNIT_AURA" and arg1 == "player") then
        CheckForBuff(desiredBuffs)
    end
end)

frame:RegisterEvent("UNIT_AURA")