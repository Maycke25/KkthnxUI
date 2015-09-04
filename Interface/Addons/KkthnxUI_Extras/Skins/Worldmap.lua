----------------------------------------------------------------------------------------
--	WorldMap skin
----------------------------------------------------------------------------------------
if IsAddOnLoaded("Mapster") then return end

local SmallerMap = GetCVarBool("miniWorldMap")
if not SmallerMap then
	ToggleWorldMap()
	WorldMapFrameSizeUpButton:Click()
	ToggleWorldMap()
end

WorldMapFrame:StripTextures()
WorldMapFrame:SetBackdrop(backdrop)
WorldMapFrame:SetBackdropColor(0,0,0,.8)
local WMFAnchor = CreateFrame("Frame", "WorldMapFrameAnchor", WorldMapFrame)
CreateBorder(WorldMapFrame, 10,1)
WMFAnchor:ClearAllPoints()
WMFAnchor:SetSize(700, 468)
WMFAnchor:SetPoint("TOPLEFT", 1, -66)
WorldMapFrame.Header = CreateFrame("Frame", nil, WorldMapFrame)
WorldMapFrame.Header:SetSize(WMFAnchor:GetWidth(), 23)
WorldMapFrame.Header:SetPoint("BOTTOMLEFT", WMFAnchor, "TOPLEFT", 0, 2)


WorldMapFrame.BorderFrame:StripTextures()
WorldMapFrame.BorderFrame.Inset:StripTextures()
QuestMapFrame.DetailsFrame:StripTextures()
QuestMapFrame.DetailsFrame.RewardsFrame:StripTextures()
QuestScrollFrame.Contents.StoryHeader:StripTextures()
QuestMapFrame:StripTextures()

WorldMapFrameTutorialButton:Kill()

local TrackingOptions = WorldMapFrame.UIElementsFrame.TrackingOptionsButton
TrackingOptions.Button:SetAlpha(0)
TrackingOptions.Background:SetAlpha(0)
TrackingOptions.IconOverlay:SetTexture("")

local QSFAnchor = CreateFrame("Frame", "QuestScrollFrameAnchor", WMFAnchor)
QSFAnchor:ClearAllPoints()
QSFAnchor:SetSize(284, 468)
QSFAnchor:SetPoint("LEFT", WMFAnchor, "RIGHT", 2, 0)

local QMDSAnchor = CreateFrame("Frame", "QuestMapDetailsScrollFrameAnchor", WMFAnchor)
QMDSAnchor:SetAllPoints(QSFAnchor)
QMDSAnchor:ClearAllPoints()
QMDSAnchor:SetSize(284, 468)
QMDSAnchor:SetPoint("LEFT", WMFAnchor, "RIGHT", 2, 0)

QuestScrollFrame.ViewAll:ClearAllPoints()
QuestScrollFrame.ViewAll:SetPoint("LEFT", WorldMapFrame.Header, "RIGHT", 2, 0)
QuestScrollFrame.ViewAll:SetSize(284, 23)

QuestMapFrame.DetailsFrame.BackButton:ClearAllPoints()
QuestMapFrame.DetailsFrame.BackButton:SetPoint("LEFT", WorldMapFrame.Header, "RIGHT", 2, 0)
QuestMapFrame.DetailsFrame.BackButton:SetSize(284, 23)

QuestMapFrame.DetailsFrame.AbandonButton:ClearAllPoints()
QuestMapFrame.DetailsFrame.AbandonButton:SetPoint("BOTTOMLEFT", QSFAnchor, "BOTTOMLEFT", 4, 4)

QuestMapFrame.DetailsFrame.TrackButton:SetSize(90, 22)
QuestMapFrame.DetailsFrame.TrackButton:ClearAllPoints()
QuestMapFrame.DetailsFrame.TrackButton:SetPoint("BOTTOMRIGHT", QSFAnchor, "BOTTOMRIGHT", -4, 4)

QuestMapFrame.DetailsFrame.ShareButton:ClearAllPoints()
QuestMapFrame.DetailsFrame.ShareButton:SetPoint("LEFT", QuestMapFrame.DetailsFrame.AbandonButton, "RIGHT", 3, 0)
QuestMapFrame.DetailsFrame.ShareButton:SetPoint("RIGHT", QuestMapFrame.DetailsFrame.TrackButton, "LEFT", -3, 0)

WorldMapFrameNavBar:Hide()
WorldMapTitleButton:ClearAllPoints()
WorldMapTitleButton:SetAllPoints(WorldMapFrame.Header)
WorldMapFrame.BorderFrame.TitleText:ClearAllPoints()
WorldMapFrame.BorderFrame.TitleText:SetPoint("CENTER", WorldMapFrame.Header)

WorldMapFrameCloseButton:ClearAllPoints()
WorldMapFrameCloseButton:SetPoint("RIGHT", WorldMapFrame.Header, "RIGHT", 1, 0)
WorldMapFrameCloseButton:SetSize(30, 30)

WorldMapFrameSizeUpButton:Kill()

WorldMapLevelDropDown:ClearAllPoints()
WorldMapLevelDropDown:SetPoint("TOPLEFT", -16, -2)