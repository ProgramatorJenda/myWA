IU = IU or {}
ItsUp = nil

-- table of created checkboxes, for future references
local checkBoxList = {}

function IU.InitializeMainWindow()

    -- Create Main Window frame
    MainWindow = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
    MainWindow:SetSize(600, 600)
    MainWindow:SetPoint("CENTER")
    MainWindow:SetBackdrop({
        bgFile = "BlizzardInterfaceArt\\Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "BlizzardInterfaceArt\\Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true,
        tileSize = 32,
        edgeSize = 32,
        insets = {left = 8, right = 8, top = 8, bottom = 8 }
    })

    -- Create checkboxes for each possible aura
    

    MainWindow:Hide()
end

function ToggleMainWindow()
    if not ItsUp then
        ItsUp = IU.InitializeMainWindow()
    end

    ItsUp:SetShown(not ItsUp:IsShown())
end

-- Create CheckBox function
local function CreateSpellCheckbox(label, parent, spell)
    local checkBox = CreateFrame("CheckButton", nil, parent, "InterfaceOptionsCheckButtonTemplate")
    checkBox.SetText(label)
    checkBox.spell = spell
    table.insert(checkBoxList, {checkbox = checkBox, label = label})

    checkBox:SetScript("OnClick", function(self)
        ItsUp.updateDesiredTable(checkBox, label)
    end)
end

-- Not sure how to approach this yet vvv

-- local function CreateSaveButton(relativeTo, parent)
--     local saveButton = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
--     saveButton:SetText("Save")
--     saveButton:SetWidth(60)
--     saveButton:SetPoint("LEFT", relativeTo, "RIGHT", 10, 0)
--     saveButton:SetScript("OnClick", function()
--         -- IU.updateDesiredTable()
--     end)
-- end
