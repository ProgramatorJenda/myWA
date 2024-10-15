ItsUp = ItsUp or {}
ItsUp.BuffFrames = ItsUp.BuffFrames or {}
ItsUp.SavedPositions = ItsUp.SavedPositions or {}

function ItsUp.enableEditMode()
    
end

--Create a frame for each checked buff
local function createDesiredAuraFrames(DesiredBuffs)
    local iconTexture = nil

    for i,buffName in pairs(DesiredBuffs) do
        local buffName = DesiredBuffs[i]
        iconTexture = select(3, C_Spell.GetSpellInfo(buffName))

        local buffFrame = CreateFrame("Frame", "buffFrame"..i, UIParent)
        buffFrame:SetSize(30,30)


        local icon = buffFrame:CreateTexture(nil, "BACKGROUND")
        icon:SetAllPoints(buffFrame)
        icon:SetTexture(iconTexture)

        buffFrame:SetPoint("CENTER", UIParent, "CENTER", (i - 1) * 50, 0)

        buffFrame:Hide()
        ItsUp.BuffFrames[buffName] = buffFrame
    end
end


local function cleanUpRemovedFrames()


end


--Enables movement of frames in edit mode
local function enableFrameMovement(BuffFrames)
    for _, frame in pairs(BuffFrames) do
        frame:SetMovable(true)
        frame:EnableMouse(true)
        frame:RegisterForDrag("LeftButton")

        frame:SetScript("OnDragStart", function (self)
            self:StartMoving()
        end)

        frame:SetScript("OnDragStop", function (self)
            self:StopMovingOrSizing()

        end)
    end
end

--Disables movement of frames in edit mode, saves positions
local function disableFrameMovement(BuffFrames)
    for _, frame in pairs(BuffFrames) do
        frame:SetMovable(false)
        frame:EnableMouse(false)
        frame:SetScript("OnDragStart", nil)
        frame:SetScript("OnDragStop", nil)

        local point, _, _, x, y = frame:GetPoint()
        ItsUp.FramePositions[frame:GetName()] = {point, x, y}
    end
end

function ItsUp.UpdateAuraFrames()


end