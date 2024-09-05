-- This file handles windows rendering for the Addon

local MainWindow

function ToggleMainWindow()
    if not MainWindow then
        MainWindow = CreateMainWindow()
    end

    MainWindow:SetShown(not MainWindow:IsShown())
end


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

    return MainFrame
end