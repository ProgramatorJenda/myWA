IU = IU or {}
ItsUp = nil

-- table of created checkboxes, for future references
local checkBoxList = {}

function IU.InitializeMainWindow()

end

local function ToggleMainWindow()
    if not ItsUp then
        ItsUp = IU.InitializeMainWindow()
    end
end

-- Create CheckBox for each spell that can be tracked
local function CreateSpellCheckbox(label, parent, spell)
    local checkBox = CreateFrame("CheckButton", nil, parent, "InterfaceOptionsCheckButtonTemplate")
    checkBox.SetText(label)
    checkBox.spell = spell
    table.insert(checkBoxList, {checkbox = checkBox, label = label})

    checkBox:SetScript("OnClick", function(self)
        ItsUp.updateDesiredTable(checkBox, label)
    end)
end