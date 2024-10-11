-- This file handles windows rendering for the Addon
local MainWindow
DesiredBuffs = {}

function ToggleMainWindow()
    if not MainWindow then
        MainWindow = CreateMainWindow()
    end

    MainWindow:SetShown(not MainWindow:IsShown())
end

local function CreateCheckbox(parent, label, x, y)
    local checkbox = CreateFrame("CheckButton", nil, parent, "ChatConfigCheckButtonTemplate")
    checkbox:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)
    checkbox.Text = checkbox:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    checkbox.Text:SetPoint("LEFT", checkbox, "RIGHT", 4, 0)
    checkbox.Text:SetText(label)
    checkbox.Text:SetTextColor(255, 255, 255)

    checkbox:SetScript("OnClick", function()
        if checkbox.checked then
            table.insert(DesiredBuffs, label)
        else
            for i, v in ipairs(DesiredBuffs) do
                if v == label then
                    table.remove(DesiredBuffs, i)
                    break
                end
            end
        end
        UpdateTable(checkbox, label)
    end)

    return checkbox
end

function UpdateTable(checkbox, label)
    if checkbox:GetChecked() then
        -- Add label to the table if checkbox is checked
        table.insert(DesiredBuffs, label)
    else
        -- Remove label from the table if checkbox is unchecked
        for i, v in ipairs(DesiredBuffs) do
            if v == label then
                table.remove(DesiredBuffs, i)
                break
            end
        end
    end

    --Debuf
    -- for i = 1, #DesiredBuffs do
    --     print(DesiredBuffs[i])
    -- end
end

--TODO: Replace Dropdown Template, make the dropdown menu have the text of the selected class
function CreateClassDropdown()
    ClassDropdown = CreateFrame("DropdownButton", nil, MainFrame, "UIDropDownMenuTemplate")
    ClassDropdown:SetWidth(150)
    ClassDropdown:SetPoint("TOPLEFT", MainFrame, "TOPLEFT", 20, -20)
    ClassDropdown:SetupMenu(function (ClassDropdown, rootDescription)
        rootDescription:CreateTitle("Classes")
        local classList = {
            "Druid",
            "Death Knight",
            "Demon Hunter",
            "Evoker",
            "Monk",
            "Hunter",
            "Mage",
            "Paladin",
            "Priest",
            "Rogue",
            "Shaman",
            "Warlock",
            "Warrior",
        }
        for i = 1, #classList do
            local class = classList[i]
            rootDescription:CreateButton(class, function() print("Clicked button " .. i) end)
        end
    end)
end

--TODO: Split main window into smaller windows one for a dropdown list of classes and one for the spells that updates based on the class. Also add slider
function CreateMainWindow()
    MainFrame = CreateFrame('Frame', 'MainWindowFrame', UIParent, "BackdropTemplate")
    MainFrame:SetSize(400, 300)
    MainFrame:SetPoint("CENTER")
    MainFrame:SetBackdrop({
        bgFile = "BlizzardInterfaceArt\\Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "BlizzardInterfaceArt\\Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true,
        tileSize = 32,
        edgeSize = 32,
        insets = {left = 8, right = 8, top = 8, bottom = 8 }
    })
    MainFrame:SetBackdropBorderColor(0, 0, 0, 0.3)

    local MainHeader = CreateFrame("Frame", nil, MainFrame, "BackdropTemplate")
    MainHeader:SetHeight(20)
    MainHeader:SetPoint("TOPLEFT", MainFrame, "TOPLEFT", 0, 12)
    MainHeader:SetPoint("TOPRIGHT", MainFrame, "TOPRIGHT", 0, 12)
    MainHeader:SetBackdrop({
        -- Dont know which file to use for the header now
        -- bgFile = "BlizzardInterfaceArt\\Interface\\DialogFrame\\UI-DialogBox-Header",
        edgeFile= nil,
        tile = true,
        tileSize = 32,
        edgeSize = 32,
        insets = {left = 8, right = 8, top = 8, bottom = 8 }
    })

    local closeButton = CreateFrame("Button", nil, MainHeader, "UIPanelCloseButton")
    closeButton:SetPoint("TOPRIGHT", MainHeader, "TOPRIGHT")

    -- Set the OnClick function to hide the frame
    closeButton:SetScript("OnClick", function()
        MainFrame:Hide()
    end)

    local titleText = MainHeader:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    titleText:SetPoint("CENTER", MainHeader, "CENTER", 0, 0)
    titleText:SetText("My WeakAuras")

    MainHeader:SetScript("OnMouseDown", function()
        MainFrame:StartMoving()
    end)
    MainHeader:SetScript("OnMouseUp", function()
        MainFrame:StopMovingOrSizing()
    end)

    MainFrame:SetMovable(true)
    MainFrame:EnableMouse(true)
    MainFrame:RegisterForDrag("LeftButton")
    MainFrame:Hide()

    -- Create a list of labels for checkboxes that will be created by a function with the labels as an argument
    local checkbox1 = CreateCheckbox(MainFrame, "Renew", 20, -120)
    local checkbox2 = CreateCheckbox(MainFrame, "Desperate Prayer", 20, -100)
    local checkbox3 = CreateCheckbox(MainFrame, "Precognition", 20, -80)
    CreateClassDropdown()
    
    return MainFrame
end