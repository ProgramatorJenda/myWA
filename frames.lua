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

-- Clear all possible frame scripts
local function ClearScripts(frame)
    local scripts = {
        "OnEvent", "OnClick", "OnUpdate", "OnEnter", "OnLeave", 
        "OnShow", "OnHide", "OnMouseDown", "OnMouseUp", 
        "OnKeyDown", "OnKeyUp", "OnMouseWheel"
    }
    
    for _, script in pairs(scripts) do
        frame:SetScript(script, nil)
    end
end

--[[
Clean up frame after a buff has been deselected from being tracked
Uses ClearScripts function
]]
local function cleanUpRemovedFrames(RemovedFrames)
    for _,frame in pairs(RemovedFrames) do
        frame:UnregisterAllEvents()
        ClearScripts(frame)
        frame:Hide()
    end
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