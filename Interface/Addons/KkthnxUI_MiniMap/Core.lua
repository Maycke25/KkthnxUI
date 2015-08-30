local _, Kmap = ...
local cfg = Kmap.Config

local backdrop = {
	bgFile = "Interface\\Buttons\\WHITE8X8",
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	edgeSize = 14,
	insets = {
	left = 2.5, right = 2.5, top = 2.5, bottom = 2.5
	}
}

local frames = {
	'MiniMapInstanceDifficulty',
	'MiniMapVoiceChatFrame',
	'MiniMapWorldMapButton',
	'MiniMapMailBorder',
	'MinimapBorderTop',
	'MinimapNorthTag',
	'MinimapZoomOut',
	'MinimapZoomIn',
	'MinimapBorder',
	'MinimapZoneText',
	'MinimapZoneTextButton',
	'VoiceChatTalkers',
	'GameTimeFrame',
	'ChannelFrameAutoJoin',
	'GarrisonLandingPageMinimapButton',
	'MiniMapTracking',
	'QueueStatusMinimapButtonBorder'
}

for i in pairs(frames) do
    _G[frames[i]]:Hide()
    _G[frames[i]].Show = Kdummy
end

-- Set Default Map X/Y Position
Minimap:SetPoint('TOPRIGHT', UIParent, -7, -7)
Minimap:SetSize(140, 140)

-- Hide Mail Button
MiniMapMailFrame:SetParent(Minimap)
MiniMapMailFrame:ClearAllPoints()
MiniMapMailFrame:SetSize(16, 16)
MiniMapMailFrame:SetPoint("BOTTOMLEFT", Minimap, "BOTTOMRIGHT", -18, 2)
MiniMapMailFrame:HookScript('OnEnter', function(self)
	GameTooltip:ClearAllPoints()
	GameTooltip:SetPoint("BOTTOM", MiniMapMailFrame, "TOP", 0, 5)
end)
MiniMapMailIcon:SetTexture('Interface\\Minimap\\TRACKING\\Mailbox')
MiniMapMailIcon:SetAllPoints(MiniMapMailFrame)
MiniMapMailBorder:Hide()

-- Move QueueStatus icon
QueueStatusFrame:SetClampedToScreen(true)
QueueStatusFrame:SetFrameStrata("TOOLTIP")
QueueStatusMinimapButton:ClearAllPoints()
QueueStatusMinimapButton:SetPoint("TOP", Minimap, "TOP", 1, 6)
QueueStatusMinimapButton:SetHighlightTexture(nil)

-- Instance Difficulty icon
MiniMapInstanceDifficulty:SetParent(Minimap)
MiniMapInstanceDifficulty:ClearAllPoints()
MiniMapInstanceDifficulty:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 3, 2)
MiniMapInstanceDifficulty:SetScale(0.75)

-- Guild Instance Difficulty icon
GuildInstanceDifficulty:SetParent(Minimap)
GuildInstanceDifficulty:ClearAllPoints()
GuildInstanceDifficulty:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", -2, 2)
GuildInstanceDifficulty:SetScale(0.75)

-- Challenge Mode icon
MiniMapChallengeMode:SetParent(Minimap)
MiniMapChallengeMode:ClearAllPoints()
MiniMapChallengeMode:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", -2, -2)
MiniMapChallengeMode:SetScale(0.75)

-- Invites icon
GameTimeCalendarInvitesTexture:ClearAllPoints()
GameTimeCalendarInvitesTexture:SetParent(Minimap)
GameTimeCalendarInvitesTexture:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 0, 0)

-- Feedback icon
if FeedbackUIButton then
	FeedbackUIButton:ClearAllPoints()
	FeedbackUIButton:SetPoint("BOTTOM", Minimap, "BOTTOM", 0, 0)
	FeedbackUIButton:SetScale(0.8)
end

-- Streaming icon
if StreamingIcon then
	StreamingIcon:ClearAllPoints()
	StreamingIcon:SetPoint("BOTTOM", Minimap, "BOTTOM", 0, -10)
	StreamingIcon:SetScale(0.8)
end

-- Ticket icon
HelpOpenTicketButton:SetParent(Minimap)
HelpOpenTicketButton:SetBackdrop(nil)
HelpOpenTicketButton:SetFrameLevel(4)
HelpOpenTicketButton:ClearAllPoints()
HelpOpenTicketButton:SetPoint("TOP", Minimap, "CENTER", 6, -9)
HelpOpenTicketButton:SetHighlightTexture(nil)
HelpOpenTicketButton:SetPushedTexture("Interface\\Icons\\inv_misc_note_03")
HelpOpenTicketButton:SetNormalTexture("Interface\\Icons\\inv_misc_note_03")
HelpOpenTicketButton:GetNormalTexture():SetTexCoord(0.1, 0.9, 0.1, 0.9)
HelpOpenTicketButton:GetPushedTexture():SetTexCoord(0.1, 0.9, 0.1, 0.9)
HelpOpenTicketButton:SetSize(24, 24)

-- Enable mouse scrolling
Minimap:EnableMouseWheel(true)
Minimap:SetScript("OnMouseWheel", function(self, d)
	if d > 0 then _G.MinimapZoomIn:Click() elseif d < 0 then _G.MinimapZoomOut:Click() end
end)

-- displays time/clock 
if not IsAddOnLoaded("Blizzard_TimeManager") then
  LoadAddOn("Blizzard_TimeManager")
end

local clockFrame, clockTime = TimeManagerClockButton:GetRegions()
clockFrame:Hide()
clockTime:SetFont(GameFontNormal:GetFont(), 12, "OUTLINE")
clockTime:SetShadowOffset(0, 0)
clockTime:SetTextColor(1,1,1)
TimeManagerClockButton:SetPoint("BOTTOM", Minimap, "BOTTOM", 0, -8)
TimeManagerClockButton:SetScript("OnClick", function(_,btn)
 	if btn == "LeftButton" then
		TimeManager_Toggle()
	end 
	if btn == "RightButton" then
		if not CalendarFrame then
			LoadAddOn("Blizzard_Calendar")
		end
		Calendar_Toggle()
	end
end)

----------------------------------------------------------------------------------------
--	Right click menu
----------------------------------------------------------------------------------------
Minimap:SetScript("OnMouseUp", function(self, btn)
	local xoff = 0
	local position = Minimap:GetPoint()

	if btn == "MiddleButton" or (IsShiftKeyDown() and btn == "RightButton") then
		if not KkthnxUIMicroButtonsDropDown then return end
		if position:match("RIGHT") then xoff = KScale(-160) end
		EasyMenu(KMicroMenu, KkthnxUIMicroButtonsDropDown, "cursor", xoff, 0, "MENU", 2)
	elseif btn == "RightButton" then
		if position:match("RIGHT") then xoff = KScale(-8) end
		ToggleDropDownMenu(nil, nil, MiniMapTrackingDropDown, Minimap, xoff, KScale(-2))
	else
		Minimap_OnClick(self)
	end
end)

Minimap:EnableMouseWheel(true)
Minimap:SetScript("OnMouseWheel", function(self, delta)
	if delta > 0 then MinimapZoomIn:Click() elseif delta < 0 then MinimapZoomOut:Click() end
end)

-- For others mods with a minimap button, set minimap buttons position in square mode
function GetMinimapShape() return "SQUARE" end

-- Set Square Map View
Minimap:SetMaskTexture("Interface\\AddOns\\KkthnxUI_Media\\Media\\Textures\\Blank")
MinimapBorder:Hide()
Minimap:SetArchBlobRingScalar(0)
Minimap:SetQuestBlobRingScalar(0)

-- Set Boarder Texture
MinimapBackdrop:SetBackdrop(backdrop)		
MinimapBackdrop:ClearAllPoints()		
--MinimapBackdrop:SetBackdropBorderColor(0.75, 0.75, 0.75)		
MinimapBackdrop:SetBackdropColor(0.15, 0.15, 0.15, 0.0)		
MinimapBackdrop:SetAlpha(1.0)		
MinimapBackdrop:SetPoint("TOPLEFT", Minimap, "TOPLEFT", -4, 4)		
MinimapBackdrop:SetPoint("BOTTOMRIGHT", Minimap, "BOTTOMRIGHT", 4, -4)

-- Who Pinged?
local wPing = CreateFrame('ScrollingMessageFrame', nil, Minimap)
wPing:SetHeight(10)
wPing:SetWidth(100)
wPing:SetPoint('BOTTOM', Minimap, 0, 20)

wPing:SetFont(STANDARD_TEXT_FONT, 12, 'OUTLINE')
wPing:SetJustifyH'CENTER'
wPing:SetJustifyV'CENTER'
wPing:SetMaxLines(1)
wPing:SetFading(true)
wPing:SetFadeDuration(3)
wPing:SetTimeVisible(5)

wPing:RegisterEvent'MINIMAP_PING'
wPing:SetScript('OnEvent', function(self, event, u)
	local c = RAID_CLASS_COLORS[select(2,UnitClass(u))]
	local name = UnitName(u)
    if(name ~= Kname) then
		wPing:AddMessage(name, c.r, c.g, c.b)
	end
end)