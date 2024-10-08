--Plan for this project:
--Create a window that shows checkboxes for each important aura that you want to track
--on each class
--Ticking a checkbox adds the buff/aura to the DesiredBuffs table, that is being checked
--Starting with Priest - example of important auras, Inner light/Shadow, PW:Fortitude

--TODO: Saved variables of the frame positions and sizes,
-- save the state of the checkboxes for desired buffs,

local buffFrame

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
    -- or just make a frame for each buff and put them side by side, or make them movable and remember their state and position
    if buffFound then
        if not buffFrame then
            -- This has to be completely remade for each buff so we can track multiple buffs at the same time
            -- a lot of work, dont know why it didnt come to my mind before i started... maybe should brainstorm more :)
            buffFrame = CreateFrame("Frame", "BuffAlertFrame", UIParent)
            buffFrame:SetSize(60, 60)
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
            if aura.charges > 2 then
                -- Add string of charges to the buff icon
                buffFrame.text = buffFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
                buffFrame.text:SetPoint("CENTER", buffFrame, "RIGHT", 0, 0)
                buffFrame.text:SetText(aura.charges)
                buffFrame.text:SetTextColor(255, 255, 255)
                buffFrame.text:SetSize(20, 20)
            end
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