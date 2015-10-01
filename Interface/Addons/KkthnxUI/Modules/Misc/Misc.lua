local K, C, L, _ = unpack(select(2, ...))

--[[-----------------------------------
Clean up Keys
---------------------------------------]]
local HKfont = CreateFont("HotKeyFont")
HKfont:SetFont(C.font.action_bars_font, C.font.action_bars_font_size, C.font.action_bars_font_style)
HKfont:SetShadowOffset(0, 0)
NumberFontNormalSmallGray:SetFontObject(HKfont)

--[[-----------------------------------
Fade in/out world when GameMenu 
is opened
---------------------------------------]]
if C.misc.fadegamemenu == true then
	local GMFade = UIParent:CreateTexture(nil, 'BACKGROUND')
	GMFade:SetAllPoints(UIParent)
	GMFade:SetTexture(0, 0, 0)
	GMFade:Hide()
	
	hooksecurefunc(GameMenuFrame, 'Show', function()
		GMFade:SetAlpha(0)
		securecall('UIFrameFadeIn', GMFade, 0.235, GMFade:GetAlpha(), 0.7)
	end)
	
	hooksecurefunc(GameMenuFrame, 'Hide', function()
		securecall('UIFrameFadeOut', GMFade, 0.235, GMFade:GetAlpha(), 0)
	end)
end

--[[-----------------------------------
Better loot filter
---------------------------------------]]
if C.misc.betterlootfilter == true then
	local minRarity = 3 --0 = Poor, 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Epic, 5 = Legendary, 6 = Artifact, 7 = Heirloom
	function lootfilter(self,event,msg)
		if not string.match(msg,'Hbattlepet') then
			local itemID = select(3, string.find(msg, "item:(%d+):"))
			local itemRarity = select(3, GetItemInfo(itemID))
			
			if (itemRarity < minRarity) and (string.find(msg, "receives") or string.find(msg, "gets") or string.find(msg, "creates")) then
				return true
			else
				return false
			end
		else
			return false
		end
		
	end
	ChatFrame_AddMessageEventFilter("CHAT_MSG_LOOT", lootfilter)
end

--Self
CURRENCY_GAINED = "Currency: %s";
CURRENCY_GAINED_MULTIPLE = "Currency: %s x%d";
CURRENCY_GAINED_MULTIPLE_BONUS = "Currency: %s x%d (Bonus)";
LOOT_ITEM_BONUS_ROLL_SELF = "Loot: %s (Bonus)";
LOOT_ITEM_BONUS_ROLL_SELF_MULTIPLE = "Loot: %sx%d (Bonus)";
LOOT_ITEM_CREATED_SELF = "Create: %s";
LOOT_ITEM_CREATED_SELF_MULTIPLE = "Create: %sx%d";
LOOT_ITEM_PUSHED_SELF = "Loot: %s";
LOOT_ITEM_PUSHED_SELF_MULTIPLE = "Loot: %sx%d";
LOOT_ITEM_REFUND = "Refund: %s";
LOOT_ITEM_REFUND_MULTIPLE = "Refund: %sx%d";
LOOT_ITEM_SELF = "Loot: %s";
LOOT_ITEM_SELF_MULTIPLE = "Loot: %sx%d";

--Other players
LOOT_ITEM = "%s gets: %s";
LOOT_ITEM_BONUS_ROLL = "%s gets: %s (Bonus)";
LOOT_ITEM_BONUS_ROLL_MULTIPLE = "%s gets: %sx%d";
LOOT_ITEM_MULTIPLE = "%s gets: %sx%d";
LOOT_ITEM_PUSHED = "%s gets: %s";
LOOT_ITEM_PUSHED_MULTIPLE = "%s gets: %sx%d";

--[[-----------------------------------
Code Taken from Tukui v16
---------------------------------------]]
local RemoveTexture = function(self, texture)
	if texture and (string.sub(texture, 1, 9) == "Interface" or string.sub(texture, 1, 9) == "INTERFACE") then
		self:SetTexture("")
	end
end

hooksecurefunc(DraenorZoneAbilityFrame.SpellButton.Style, 'SetTexture', RemoveTexture)
hooksecurefunc(ExtraActionButton1.style, 'SetTexture', RemoveTexture)

--[[-----------------------------------
Shorten gold display
---------------------------------------]]
if C.misc.shortengold == true then
	local frame = CreateFrame("FRAME", "DuffedGold")
	frame:RegisterEvent("PLAYER_ENTERING_WORLD")
	frame:RegisterEvent("MAIL_SHOW")
	frame:RegisterEvent("MAIL_CLOSED")
	
	local function eventHandler(self, event, ...)
		if event == "MAIL_SHOW" then
			COPPER_AMOUNT = "%d Copper"
			SILVER_AMOUNT = "%d Silver"
			GOLD_AMOUNT = "%d Gold"
		else
			COPPER_AMOUNT = "%d|cFF954F28"..COPPER_AMOUNT_SYMBOL.."|r"
			SILVER_AMOUNT = "%d|cFFC0C0C0"..SILVER_AMOUNT_SYMBOL.."|r"
			GOLD_AMOUNT = "%d|cFFF0D440"..GOLD_AMOUNT_SYMBOL.."|r"
		end
		YOU_LOOT_MONEY = "+%s"
		LOOT_MONEY_SPLIT = "+%s"
	end
	frame:SetScript("OnEvent", eventHandler)
end

--[[-----------------------------------
Farmmode
---------------------------------------]]
local farm = false
local minisize = 144
local farmsize = 300
function SlashCmdList.FARMMODE(msg, editbox)
	if farm == false then
		Minimap:SetSize(farmsize, farmsize)
		Minimap:SetSize(farmsize, farmsize)
		farm = true
		print("Farm Mode : On")
	else
		Minimap:SetSize(minisize, minisize)
		Minimap:SetSize(minisize, minisize)
		farm = false
		print("Farm Mode : Off")
	end
	
	local defaultBlip = "Interface\\Minimap\\ObjectIcons"
	Minimap:SetBlipTexture(defaultBlip)
end
SLASH_FARMMODE1 = "/farmmode"

--[[-----------------------------------
Custom Lag Tolerance(by Elv22)
---------------------------------------]]
if C.misc.customlagtolerance == true then
	InterfaceOptionsCombatPanelMaxSpellStartRecoveryOffset:Hide()
	InterfaceOptionsCombatPanelReducedLagTolerance:Hide()
	
	local customlag = CreateFrame("Frame")
	local int = 5
	local _, _, _, lag = GetNetStats()
	local LatencyUpdate = function(self, elapsed)
		int = int - elapsed
		if int < 0 then
			if GetCVar("reducedLagTolerance") ~= tostring(1) then SetCVar("reducedLagTolerance", tostring(1)) end
			if lag ~= 0 and lag <= 400 then
				SetCVar("maxSpellStartRecoveryOffset", tostring(lag))
			end
			int = 5
		end
	end
	customlag:SetScript("OnUpdate", LatencyUpdate)
	LatencyUpdate(customlag, 10)
end

--[[-----------------------------------
Rare Alert
---------------------------------------]]
if C.misc.rarealert == true then
	local blacklist = {
		[971] = true, -- Alliance garrison
		[976] = true, -- Horde garrison
		[947] = true, -- Lunarfall Excavation
		[941] = true, -- Frostwall Shipyard
	}
	
	local f = CreateFrame("Frame")
	f:RegisterEvent("VIGNETTE_ADDED")
	f:SetScript("OnEvent", function()
		if blacklist[GetCurrentMapAreaID()] then return end
		
		PlaySoundFile("Sound\\Interface\\RaidWarning.ogg")
		RaidNotice_AddMessage(RaidWarningFrame, "Rare spotted!", ChatTypeInfo["RAID_WARNING"])
	end)
end

--[[-----------------------------------
Collect Garbage
---------------------------------------]]
if C.misc.collectgarbage then
	local Garbage = CreateFrame("Frame")
	Garbage:RegisterAllEvents()
	Garbage:SetScript("OnEvent", function(self, event)
		eventcount = eventcount + 1
		
		if (InCombatLockdown() and eventcount > 25000) or (not InCombatLockdown() and eventcount > 10000) or event == "PLAYER_ENTERING_WORLD" then
			collectgarbage("collect")
			eventcount = 0
		end
	end)
end

--[[-----------------------------------
Auto select current event boss from LFD 
tool(EventBossAutoSelect by Nathanyel)
---------------------------------------]]
local firstLFD
LFDParentFrame:HookScript("OnShow", function()
	if not firstLFD then
		firstLFD = 1
		for i = 1, GetNumRandomDungeons() do
			local id = GetLFGRandomDungeonInfo(i)
			local isHoliday = select(15, GetLFGDungeonInfo(id))
			if isHoliday and not GetLFGDungeonRewards(id) then
				LFDQueueFrame_SetType(id)
			end
		end
	end
end)

--[[-----------------------------------
GuildTab in FriendsFrame
---------------------------------------]]
local n = FriendsFrame.numTabs + 1
local gtframe = CreateFrame("Button", "FriendsFrameTab"..n, FriendsFrame, "FriendsFrameTabTemplate")
gtframe:SetText(GUILD)
gtframe:SetPoint("LEFT", _G["FriendsFrameTab"..n - 1], "RIGHT", -15, 0)
PanelTemplates_DeselectTab(gtframe)
gtframe:SetScript("OnClick", function() ToggleGuildFrame() end)

--[[-----------------------------------
Remove Boss Emote spam in BG 
(by Partha)
---------------------------------------]]
if C.misc.bgspam then
	local BGSpam = CreateFrame("Frame")
	local RaidBossEmoteFrame, spamDisabled = RaidBossEmoteFrame
	
	local function DisableSpam()
		if GetZoneText() == L_ZONE_ARATHIBASIN or GetZoneText() == L_ZONE_GILNEAS then
			RaidBossEmoteFrame:UnregisterEvent("RAID_BOSS_EMOTE")
			spamDisabled = true
		elseif spamDisabled then
			RaidBossEmoteFrame:RegisterEvent("RAID_BOSS_EMOTE")
			spamDisabled = false
		end
	end
	
	BGSpam:RegisterEvent("PLAYER_ENTERING_WORLD")
	BGSpam:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	BGSpam:SetScript("OnEvent", DisableSpam)
end

--[[-----------------------------------
Boss Banner Hider
---------------------------------------]]
if C.misc.bossbanner == true then
	BossBanner.PlayBanner = function()
	end
end

--[[-----------------------------------
Old achievements filter
---------------------------------------]]
function AchievementFrame_GetCategoryNumAchievements_OldIncomplete(categoryID)
	local numAchievements, numCompleted = GetCategoryNumAchievements(categoryID)
	return numAchievements - numCompleted, 0, numCompleted
end

function old_nocomplete_filter_init()
	AchievementFrameFilters = {
		{text = ACHIEVEMENTFRAME_FILTER_ALL, func = AchievementFrame_GetCategoryNumAchievements_All},
		{text = ACHIEVEMENTFRAME_FILTER_COMPLETED, func = AchievementFrame_GetCategoryNumAchievements_Complete},
		{text = ACHIEVEMENTFRAME_FILTER_INCOMPLETE, func = AchievementFrame_GetCategoryNumAchievements_Incomplete},
		{text = ACHIEVEMENTFRAME_FILTER_INCOMPLETE.." ("..ALL.." )", func = AchievementFrame_GetCategoryNumAchievements_OldIncomplete}
	}
end

local filter = CreateFrame("Frame")
filter:RegisterEvent("ADDON_LOADED")
filter:SetScript("OnEvent", function(self, event, addon, ...)
	if addon == "Blizzard_AchievementUI" then
		if AchievementFrame then
			old_nocomplete_filter_init()
			if C.skins.blizzard_frames == true then
				AchievementFrameFilterDropDown:SetWidth(AchievementFrameFilterDropDown:GetWidth() + 20)
			end
			filter:UnregisterEvent("ADDON_LOADED")
		end
	end
end)

--[[-----------------------------------
Force quit
---------------------------------------]]
local CloseWoW = CreateFrame("Frame")
CloseWoW:RegisterEvent("CHAT_MSG_SYSTEM")
CloseWoW:SetScript("OnEvent", function(self, event, msg)
	if event == "CHAT_MSG_SYSTEM" then
		if msg and msg == IDLE_MESSAGE then
			ForceQuit()
		end
	end
end)