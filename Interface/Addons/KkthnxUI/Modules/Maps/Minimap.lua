local K, C, L, _ = unpack(select(2, ...))
if C.minimap.enable ~= true then return end

local frames = {
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
	_G[frames[i]].Show = K.Dummy
end

-- Set Default Map X/Y Position
Minimap:SetPoint(unpack(C.position.minimap))
Minimap:SetSize(C.minimap.size, C.minimap.size)

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
	if d > 0 then
		_G.MinimapZoomIn:Click()
	elseif d < 0 then
		_G.MinimapZoomOut:Click()
	end
end)

-- Hide Game Time
Minimap:RegisterEvent("PLAYER_LOGIN")
Minimap:RegisterEvent("ADDON_LOADED")
Minimap:SetScript("OnEvent", function(self, event, addon)
	if addon == "Blizzard_TimeManager" then
		TimeManagerClockButton:Kill()
	end
end)

----------------------------------------------------------------------------------------
--	Right click menu
----------------------------------------------------------------------------------------
local menuFrame = CreateFrame("Frame", "MinimapRightClickMenu", UIParent, "UIDropDownMenuTemplate")
local guildText = IsInGuild() and ACHIEVEMENTS_GUILD_TAB or LOOKINGFORGUILD
local micromenu = {
	{text = CHARACTER_BUTTON, notCheckable = 1, func = function()
			ToggleCharacter("PaperDollFrame")
	end},
	{text = SPELLBOOK_ABILITIES_BUTTON, notCheckable = 1, func = function()
			if InCombatLockdown() then
				print("|cffffff00"..ERR_NOT_IN_COMBAT.."|r") return
			end
			ToggleFrame(SpellBookFrame)
	end},
	{text = TALENTS_BUTTON, notCheckable = 1, func = function()
			if not PlayerTalentFrame then
				TalentFrame_LoadUI()
			end
			if K.Level >= SHOW_TALENT_LEVEL then
				ShowUIPanel(PlayerTalentFrame)
			else
				print("|cffffff00"..format(FEATURE_BECOMES_AVAILABLE_AT_LEVEL, SHOW_TALENT_LEVEL).."|r")
			end
	end},
	{text = ACHIEVEMENT_BUTTON, notCheckable = 1, func = function()
			ToggleAchievementFrame()
	end},
	{text = QUESTLOG_BUTTON, notCheckable = 1, func = function()
			ToggleQuestLog()
	end},
	{text = guildText, notCheckable = 1, func = function()
			ToggleGuildFrame()
			if IsInGuild() then
				GuildFrame_TabClicked(GuildFrameTab2)
			end
	end},
	{text = SOCIAL_BUTTON, notCheckable = 1, func = function()
			ToggleFriendsFrame()
	end},
	{text = PLAYER_V_PLAYER, notCheckable = 1, func = function()
			if K.Level >= SHOW_PVP_LEVEL then
				TogglePVPUI()
			else
				if C.error.white == false then
					UIErrorsFrame:AddMessage(format(FEATURE_BECOMES_AVAILABLE_AT_LEVEL, SHOW_PVP_LEVEL), 1, 0.1, 0.1)
				else
					print("|cffffff00"..format(FEATURE_BECOMES_AVAILABLE_AT_LEVEL, SHOW_PVP_LEVEL).."|r")
				end
			end
	end},
	{text = DUNGEONS_BUTTON, notCheckable = 1, func = function()
			if K.Level >= SHOW_LFD_LEVEL then
				PVEFrame_ToggleFrame("GroupFinderFrame", nil)
			else
				if C.error.white == false then
					UIErrorsFrame:AddMessage(format(FEATURE_BECOMES_AVAILABLE_AT_LEVEL, SHOW_LFD_LEVEL), 1, 0.1, 0.1)
				else
					print("|cffffff00"..format(FEATURE_BECOMES_AVAILABLE_AT_LEVEL, SHOW_LFD_LEVEL).."|r")
				end
			end
	end},
	{text = ADVENTURE_JOURNAL, notCheckable = 1, func = function()
			ToggleEncounterJournal()
	end},
	{text = COLLECTIONS, notCheckable = 1, func = function()
			if InCombatLockdown() then
				print("|cffffff00"..ERR_NOT_IN_COMBAT.."|r") return
			end
			ToggleCollectionsJournal()
	end},
	{text = HELP_BUTTON, notCheckable = 1, func = function()
			ToggleHelpFrame()
	end},
	{text = L_MINIMAP_CALENDAR, notCheckable = 1, func = function()
			ToggleCalendar()
	end},
	{text = BATTLEFIELD_MINIMAP, notCheckable = 1, func = function()
			ToggleBattlefieldMinimap()
	end},
	{text = LOOT_ROLLS, notCheckable = 1, func = function()
			ToggleFrame(LootHistoryFrame)
	end},
}

if not IsTrialAccount() and not C_StorePublic.IsDisabledByParentalControls() then
	tinsert(micromenu, {text = BLIZZARD_STORE, notCheckable = 1, func = function() StoreMicroButton:Click() end})
end

if K.Level > 89 then
	tinsert(micromenu, {text = GARRISON_LANDING_PAGE_TITLE, notCheckable = 1, func = function() GarrisonLandingPage_Toggle() end})
end

Minimap:SetScript("OnMouseUp", function(self, button)
	local position = Minimap:GetPoint()
	if button == "RightButton" then
		if position:match("LEFT") then
			EasyMenu(micromenu, menuFrame, "cursor", 0, 0, "MENU")
		else
			EasyMenu(micromenu, menuFrame, "cursor", -160, 0, "MENU")
		end
	elseif button == "MiddleButton" then
		if position:match("LEFT") then
			ToggleDropDownMenu(nil, nil, MiniMapTrackingDropDown, "cursor", 0, 0, "MENU", 2)
		else
			ToggleDropDownMenu(nil, nil, MiniMapTrackingDropDown, "cursor", -160, 0, "MENU", 2)
		end
	elseif button == "LeftButton" then
		Minimap_OnClick(self)
	end
end)

-- For others mods with a minimap button, set minimap buttons position in square mode
function GetMinimapShape() return "SQUARE" end

-- Set Square Map View
Minimap:SetMaskTexture(C.media.blank)
MinimapBorder:Hide()
Minimap:SetArchBlobRingScalar(0)
Minimap:SetQuestBlobRingScalar(0)

-- Set Boarder Texture
MinimapBackdrop:SetBackdrop(K.Backdrop)		
MinimapBackdrop:ClearAllPoints()		
MinimapBackdrop:SetBackdropBorderColor(1, 1, 1)		
MinimapBackdrop:SetBackdropColor(1, 1, 1, 0)		
MinimapBackdrop:SetAlpha(1.0)		
MinimapBackdrop:SetPoint("TOPLEFT", Minimap, "TOPLEFT", -4, 4)		
MinimapBackdrop:SetPoint("BOTTOMRIGHT", Minimap, "BOTTOMRIGHT", 4, -4)