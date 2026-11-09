local addonName = ...
local currentStep = 1

local steps = {
    {
        title = "Prototype step 1",
        body = "Welcome to ForeverXP. This is a proof of concept running inside the WoW Forever client."
    },
    {
        title = "Prototype step 2",
        body = "A real guide will show quest instructions, objectives, NPC locations and route progress here."
    },
    {
        title = "Prototype step 3",
        body = "Next, we will connect this interface to validated quest data and track route progress."
    },
}

local frame = CreateFrame("Frame", "ForeverXPMainFrame", UIParent)
frame:SetSize(380, 230)
frame:SetPoint("CENTER")
frame:SetFrameStrata("DIALOG")
frame:SetMovable(true)
frame:EnableMouse(true)
frame:RegisterForDrag("LeftButton")
frame:SetScript("OnDragStart", frame.StartMoving)
frame:SetScript("OnDragStop", frame.StopMovingOrSizing)

local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
title:SetPoint("TOPLEFT", frame, "TOPLEFT", 18, -16)
title:SetText("ForeverXP")

local subtitle = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
subtitle:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -7)
subtitle:SetText("Leveling guide prototype")

local close = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
close:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -3, -3)
close:SetScript("OnClick", function()
    frame:Hide()
end)

local stepTitle = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
stepTitle:SetPoint("TOPLEFT", frame, "TOPLEFT", 20, -75)
stepTitle:SetWidth(340)
stepTitle:SetJustifyH("LEFT")

local stepBody = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
stepBody:SetPoint("TOPLEFT", stepTitle, "BOTTOMLEFT", 0, -12)
stepBody:SetWidth(340)
stepBody:SetJustifyH("LEFT")
stepBody:SetJustifyV("TOP")

local progress = frame:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
progress:SetPoint("BOTTOM", frame, "BOTTOM", 0, 48)

local function updateStep()
    local step = steps[currentStep]
    stepTitle:SetText(step.title)
    stepBody:SetText(step.body)
    progress:SetText("Step " .. currentStep .. " of " .. #steps)
end

local previous = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
previous:SetSize(100, 26)
previous:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 18, 12)
previous:SetText("Previous")
previous:SetScript("OnClick", function()
    if currentStep > 1 then
        currentStep = currentStep - 1
        updateStep()
    end
end)

local nextButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
nextButton:SetSize(100, 26)
nextButton:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -18, 12)
nextButton:SetText("Next")
nextButton:SetScript("OnClick", function()
    if currentStep < #steps then
        currentStep = currentStep + 1
    else
        currentStep = 1
    end
    updateStep()
end)

SLASH_FOREVERXP1 = "/fxp"
SlashCmdList["FOREVERXP"] = function()
    if frame:IsShown() then
        frame:Hide()
    else
        frame:Show()
    end
end

local events = CreateFrame("Frame")
events:RegisterEvent("PLAYER_LOGIN")
events:SetScript("OnEvent", function()
    print("|cff66ccffForeverXP|r prototype loaded. Type |cffffff00/fxp|r to show or hide the guide.")
    frame:Show()
end)

updateStep()
