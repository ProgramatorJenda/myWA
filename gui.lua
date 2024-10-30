IU = IU or {}
ItsUp = nil

-- table of created checkboxes, for future references
local checkBoxList = {}

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

local function CreatePriestSpellCheckbox(parent)
    local priestSpells = ItsUp.data["Priest"]
    local startX, startY = 50, -50  -- Customize starting position for checkboxes

    for i, spell in ipairs(priestSpells) do
        -- Create a checkbox for each spell using the existing function
        CreateSpellCheckbox(spell.name, parent, spell.id)

        -- Position each checkbox with an offset for vertical stacking
        local offsetY = startY - (i * 30)  -- Adjust this value as needed
    end
end

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

    local MainHeader = CreateFrame("Frame", nil, MainWindow, "BackdropTemplate")
    MainHeader:SetHeight(20)
    MainHeader:SetPoint("TOPLEFT", MainWindow, "TOPLEFT", 0, 12)
    MainHeader:SetPoint("TOPRIGHT", MainWindow, "TOPRIGHT", 0, 12)
    MainHeader:SetBackdrop({
        -- Dont know which file to use for the header now
        -- bgFile = "BlizzardInterfaceArt\\Interface\\DialogFrame\\UI-DialogBox-Header",
        edgeFile= nil,
        tile = true,
        tileSize = 32,
        edgeSize = 32,
        insets = {left = 8, right = 8, top = 8, bottom = 8 }
    })

    local titleText = MainHeader:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    titleText:SetPoint("CENTER", MainHeader, "CENTER", 0, 0)
    titleText:SetText("Its Up!")

    local closeButton = CreateFrame("Button", nil, MainWindow, "UIPanelCloseButton")
    closeButton:SetPoint("TOPRIGHT", MainWindow, "TOPRIGHT")

    -- Set the OnClick function to hide the frame
    closeButton:SetScript("OnClick", function()
        MainWindow:Hide()
    end)

    -- Create checkboxes for priestSpells just for now
    CreatePriestSpellCheckbox(MainWindow)


    MainWindow:Hide()
end

function ToggleMainWindow()
    if not ItsUp then
        ItsUp = IU.InitializeMainWindow()
    end

    ItsUp:SetShown(not ItsUp:IsShown())
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