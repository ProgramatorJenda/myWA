--Plan for this project:
--Create a window that shows checkboxes for each important aura that you want to track
--on each class
--Ticking a checkbox adds the buff/aura to the DesiredBuffs table, that is being checked
--Starting with Priest - example of important auras, Inner light/Shadow, PW:Fortitude


local buffFrame
-- local DesiredBuffs = { "Renew", "Inner Light",}


--TODO: Handle stacks on buffs? Maybe show string on top of the texture if the aura has stacks?
local function CheckForBuff(DesiredBuffs)
    local iconTexture = nil
    local buffFound = false
    local aura
    local missingAuras = {}

    for i = 1, #DesiredBuffs do
        for j = 1, 40 do
            aura = C_UnitAuras.GetBuffDataByIndex("player", j)

            if aura and aura.name == DesiredBuffs[i] then
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
    -- For now before I try to make then textures movable
    if buffFound then
        if not buffFrame then
            buffFrame = CreateFrame("Frame", "BuffAlertFrame", UIParent)
            buffFrame:SetSize(30, 30)
            buffFrame:SetPoint("CENTER")

            buffFrame.icon = buffFrame:CreateTexture(nil, "OVERLAY")
            buffFrame.icon:SetAllPoints()

            --Will use something like this later when each buff has its own frame
            -- buffFrame:SetScript("OnMouseDown", function()
            --     buffFrame:StartMoving()
            -- end)
            -- buffFrame:SetScript("OnMouseUp", function()
            --     buffFrame:StopMovingOrSizing()
            -- end)

            -- buffFrame:SetMovable(true)
            -- buffFrame:EnableMouse(true)
            -- buffFrame:RegisterForDrag("LeftButton")
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

-- Frame for event listening
local frame = CreateFrame("Frame")
frame:SetScript("OnEvent", function (self, event, arg1)
    if (event == "UNIT_AURA" and arg1 == "player") then
        CheckForBuff(DesiredBuffs)
    end
end)

frame:RegisterEvent("UNIT_AURA")