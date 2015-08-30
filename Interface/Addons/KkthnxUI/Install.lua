
local function InstallUI()
	
	FCF_ResetChatWindows()
	FCF_SetLocked(ChatFrame1, 1)
	FCF_DockFrame(ChatFrame2)
	FCF_SetLocked(ChatFrame2, 1)
	FCF_OpenNewWindow(GENERAL)
	FCF_SetLocked(ChatFrame3, 1)
	FCF_DockFrame(ChatFrame3)

	ChatFrame3:Show()

	for i = 1, NUM_CHAT_WINDOWS do
		local frame = _G[format("ChatFrame%s", i)]
		local id = frame:GetID()
		FCF_SetChatWindowFontSize(nil, frame, 12)
		frame:SetSize(370, 130)
		SetChatWindowSavedDimensions(id, 370, 130)
		FCF_SavePositionAndDimensions(frame)
		if i == 1 then FCF_SetWindowName(frame, "G, S & W") end
		if i == 2 then FCF_SetWindowName(frame, "Log") end
		if i == 3 then FCF_SetWindowName(frame, LOOT.." / "..TRADE) end
	end

	ChatFrame_RemoveAllMessageGroups(ChatFrame1)
	ChatFrame_RemoveChannel(ChatFrame1, TRADE)
	ChatFrame_RemoveChannel(ChatFrame1, L_CHAT_DEFENSE)
	ChatFrame_RemoveChannel(ChatFrame1, L_CHAT_RECRUITMENT)
	ChatFrame_RemoveChannel(ChatFrame1, L_CHAT_LFG)
	ChatFrame_AddMessageGroup(ChatFrame1, "SAY")
	ChatFrame_AddMessageGroup(ChatFrame1, "GUILD")
	ChatFrame_AddMessageGroup(ChatFrame1, "OFFICER")
	ChatFrame_AddMessageGroup(ChatFrame1, "WHISPER")
	ChatFrame_AddMessageGroup(ChatFrame1, "BN_WHISPER")
	ChatFrame_AddMessageGroup(ChatFrame1, "BN_CONVERSATION")
	ChatFrame_AddMessageGroup(ChatFrame1, "GUILD_ACHIEVEMENT")
	ChatFrame_AddMessageGroup(ChatFrame1, "PARTY")
	ChatFrame_AddMessageGroup(ChatFrame1, "PARTY_LEADER")
	ChatFrame_AddMessageGroup(ChatFrame1, "RAID")
	ChatFrame_AddMessageGroup(ChatFrame1, "RAID_LEADER")
	ChatFrame_AddMessageGroup(ChatFrame1, "RAID_WARNING")
	ChatFrame_AddMessageGroup(ChatFrame1, "INSTANCE_CHAT")
	ChatFrame_AddMessageGroup(ChatFrame1, "INSTANCE_CHAT_LEADER")
	ChatFrame_AddMessageGroup(ChatFrame1, "BG_HORDE")
	ChatFrame_AddMessageGroup(ChatFrame1, "BG_ALLIANCE")
	ChatFrame_AddMessageGroup(ChatFrame1, "BG_NEUTRAL")
	ChatFrame_AddMessageGroup(ChatFrame1, "AFK")
	ChatFrame_AddMessageGroup(ChatFrame1, "DND")
	ChatFrame_AddMessageGroup(ChatFrame1, "ACHIEVEMENT")
	ChatFrame_AddMessageGroup(ChatFrame1, "SYSTEM")

	ChatFrame_RemoveAllMessageGroups(ChatFrame3)
	ChatFrame_RemoveChannel(ChatFrame3, GENERAL)
	ChatFrame_AddChannel(ChatFrame3, TRADE)
	ChatFrame_AddChannel(ChatFrame3, L_CHAT_DEFENSE)
	ChatFrame_AddChannel(ChatFrame3, L_CHAT_RECRUITMENT)
	ChatFrame_AddChannel(ChatFrame3, L_CHAT_LFG)
	ChatFrame_AddMessageGroup(ChatFrame3, "COMBAT_XP_GAIN")
	ChatFrame_AddMessageGroup(ChatFrame3, "COMBAT_HONOR_GAIN")
	ChatFrame_AddMessageGroup(ChatFrame3, "COMBAT_FACTION_CHANGE")
	ChatFrame_AddMessageGroup(ChatFrame3, "LOOT")
	ChatFrame_AddMessageGroup(ChatFrame3, "MONEY")
	ChatFrame_AddMessageGroup(ChatFrame3, "EMOTE")
	ChatFrame_AddMessageGroup(ChatFrame3, "YELL")
	ChatFrame_AddMessageGroup(ChatFrame3, "MONSTER_SAY")
	ChatFrame_AddMessageGroup(ChatFrame3, "MONSTER_EMOTE")
	ChatFrame_AddMessageGroup(ChatFrame3, "MONSTER_YELL")
	ChatFrame_AddMessageGroup(ChatFrame3, "MONSTER_WHISPER")
	ChatFrame_AddMessageGroup(ChatFrame3, "MONSTER_BOSS_EMOTE")
	ChatFrame_AddMessageGroup(ChatFrame3, "MONSTER_BOSS_WHISPER")
	ChatFrame_AddMessageGroup(ChatFrame3, "SYSTEM")
	ChatFrame_AddMessageGroup(ChatFrame3, "ERRORS")
	ChatFrame_AddMessageGroup(ChatFrame3, "IGNORED")

	ToggleChatColorNamesByClassGroup(true, "SAY")
	ToggleChatColorNamesByClassGroup(true, "EMOTE")
	ToggleChatColorNamesByClassGroup(true, "YELL")
	ToggleChatColorNamesByClassGroup(true, "GUILD")
	ToggleChatColorNamesByClassGroup(true, "OFFICER")
	ToggleChatColorNamesByClassGroup(true, "GUILD_ACHIEVEMENT")
	ToggleChatColorNamesByClassGroup(true, "ACHIEVEMENT")
	ToggleChatColorNamesByClassGroup(true, "WHISPER")
	ToggleChatColorNamesByClassGroup(true, "PARTY")
	ToggleChatColorNamesByClassGroup(true, "PARTY_LEADER")
	ToggleChatColorNamesByClassGroup(true, "RAID")
	ToggleChatColorNamesByClassGroup(true, "RAID_LEADER")
	ToggleChatColorNamesByClassGroup(true, "RAID_WARNING")
	ToggleChatColorNamesByClassGroup(true, "BATTLEGROUND")
	ToggleChatColorNamesByClassGroup(true, "BATTLEGROUND_LEADER")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL1")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL2")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL3")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL4")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL5")
	ToggleChatColorNamesByClassGroup(true, "INSTANCE_CHAT")
	ToggleChatColorNamesByClassGroup(true, "INSTANCE_CHAT_LEADER")
	
	--General
	ChangeChatColor("CHANNEL1", 195/255, 230/255, 232/255)
	--Trade
	ChangeChatColor("CHANNEL2", 232/255, 158/255, 121/255)
	--Local Defense
	ChangeChatColor("CHANNEL3", 232/255, 228/255, 121/255)
	
	SetCVar("chatStyle", "im")
	SetCVar('chatMouseScroll', 1)
	SetCVar('useUiScale', 1)
	SetCVar('uiScale', 768/string.match(({GetScreenResolutions()})[GetCurrentResolution()], '%d+x(%d+)'))
	SetCVar('countdownForCooldowns', 0)
	SetCVar('UnitNameFriendlyPlayerName', 0)
	SetCVar('UnitNameFriendlyPetName', 0)
	SetCVar('UnitNameFriendlyGuardianName', 0)
	SetCVar('autoOpenLootHistory', 0)
	SetCVar('UnitNameFriendlyTotemName', 0)
	SetCVar('nameplateShowEnemies', 1)
	SetCVar('taintLog', 0)
	SetCVar('UnitNameEnemyPlayerName', 1)
	SetCVar('UnitNameEnemyPetName', 1)
	SetCVar('UnitNameEnemyGuardianName', 0)
	SetCVar('UnitNameEnemyTotemName', 0)
	SetCVar('cameraDistanceMax', 25)
	SetCVar('cameraDistanceMaxFactor', 2)
	SetCVar('cameraSmoothTrackingStyle', 0)
	SetCVar("ffxGlow", 0)
	SetCVar('lootUnderMouse', 1)
	SetCVar("consolidateBuffs", 0)
	SetCVar("buffDurations", 1)
	SetCVar('bloattest', 0)
	SetCVar("showVKeyCastbar", 1)
	SetCVar("removeChatDelay", 1)
	SetCVar('bloatnameplates', 0) 
	SetCVar('bloatthreat', 0)
	SetCVar("alternateResourceText", 1)
	SetCVar("statusTextDisplay", "NUMERIC")
	SetCVar("ShowClassColorInNameplate", 1)
	SetCVar("scriptErrors", 1)
	SetCVar("screenshotQuality", 10)
	SetCVar("WholeChatWindowClickable", 0)
	SetCVar("ConversationMode", "inline")
	SetCVar("BnWhisperMode", "inline")
	SetCVar("WhisperMode", "inline")
	SetCVar("showTutorials", 0)
	SetCVar("UberTooltips", 1)
	SetCVar("autoQuestProgress", 1)
	SetCVar("autoQuestWatch", 1)
	SetCVar("threatWarning", 3)
	SetCVar('alwaysShowActionBars', 1)
	SetCVar('profanityFilter', 0)
	SetCVar('lockActionBars', 1)
	SetCVar('SpamFilter', 0)
	SetCVar('autoLootDefault', 0)
	
	ReloadUI()	
end

SLASH_INSTALLUI1 = '/installui'
SlashCmdList.INSTALLUI = function() StaticPopup_Show("INSTALL_UI") end

------------------
-- Installing...
---------

StaticPopupDialogs.INSTALL_UI = {
	text = L_POPUP_INSTALLUI,
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = InstallUI,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = false,
	preferredIndex = 5,
}