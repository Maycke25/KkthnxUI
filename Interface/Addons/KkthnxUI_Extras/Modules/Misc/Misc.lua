local _, KExts = ...
local cfg = KExts.Config

--[[-----------------------------------
Clean up Keys
---------------------------------------]]
local HKfont = CreateFont("HotKeyFont")
HKfont:SetFont(cfg.hkFont, cfg.hkFontSize, cfg.hkFontStyle)
HKfont:SetShadowOffset(0, 0)
NumberFontNormalSmallGray:SetFontObject(HKfont)

--[[-----------------------------------
Better loot filter
---------------------------------------]]
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
if cfg.Misc.ShortGoldDisplay == true then
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
Auto Screenshot
---------------------------------------]]
if cfg.Misc.AutoScreenshot then
	local function OnEvent(self, event, ...)
		C_Timer.After(1, function() Screenshot() end)
	end
	
	local EventFrame = CreateFrame("Frame")
	EventFrame:RegisterEvent("ACHIEVEMENT_EARNED")
	EventFrame:SetScript("OnEvent", OnEvent)
end

--[[-----------------------------------
Auto repair and sell grey items
---------------------------------------]]
local eventframe = CreateFrame('Frame')
eventframe:SetScript('OnEvent', function(self, event, ...)
	eventframe[event](self, ...)
end)

local IDs = {}
for _, slot in pairs({"Head", "Shoulder", "Chest", "Waist", "Legs", "Feet", "Wrist", "Hands", "MainHand", "SecondaryHand"}) do 	
	IDs[slot] = GetInventorySlotInfo(slot .. "Slot")
end
eventframe:RegisterEvent('MERCHANT_SHOW')
function eventframe:MERCHANT_SHOW()
	if CanMerchantRepair() and cfg.Misc.AutoRepair then
		local gearRepaired = true -- to work around bug when there's not enough money in guild bank
		local cost = GetRepairAllCost()
		if cost > 0 and CanGuildBankRepair() and cfg.Misc.GuildAutoRepair then
			if GetGuildBankWithdrawMoney() > cost then
				RepairAllItems(1)
				for slot, id in pairs(IDs) do
					local dur, maxdur = GetInventoryItemDurability(id)
					if dur and maxdur and dur < maxdur then
						gearRepaired = false
						break
					end
				end
				if gearRepaired then
					print(format(L_REPAIR_COST.." %.1fg ("..GUILD..")", cost * 0.0001))
				end
			end
		elseif cost > 0 and GetMoney() > cost then
			RepairAllItems()
			print(format(L_REPAIR_COST.." %.1fg", cost * 0.0001))
		end
	end
	if cfg.Misc.AutoSell then
		for bag = 0, 4 do
			for slot = 0, GetContainerNumSlots(bag) do
				local link = GetContainerItemLink(bag, slot)
				if link and (select(3, GetItemInfo(link))==0) then
					UseContainerItem(bag, slot)
				end
			end
		end
	end
end

--[[-----------------------------------
Custom Lag Tolerance(by Elv22)
---------------------------------------]]
if cfg.Misc.CustomLagTolerance == true then
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
Collect Garbage
---------------------------------------]]
if cfg.Misc.Collect then
	local eventcount = 0 
	local a = CreateFrame("Frame") 
	a:RegisterAllEvents() 
	a:SetScript("OnEvent", function(self, event) 
		eventcount = eventcount + 1 
		if InCombatLockdown() then return end 
		if eventcount > 6000 or event == "PLAYER_ENTERING_WORLD" then 
			collectgarbage("collect") 
			eventcount = 0
		end 
	end)
end

--[[-----------------------------------
Easy abandon quest / share a quest (by Suicidal Katt)
---------------------------------------]]
hooksecurefunc("QuestMapLogTitleButton_OnClick", function(self, button)
	if IsModifiedClick() then
		if IsControlKeyDown() then
			QuestMapQuestOptions_AbandonQuest(self.questID)
			AbandonQuest()
			if QuestLogPopupDetailFrame:IsShown() then
				HideUIPanel(QuestLogPopupDetailFrame)
			end
			for i = 1, STATICPOPUP_NUMDIALOGS do
				local frame = _G["StaticPopup"..i]
				if (frame.which == "ABANDON_QUEST" or frame.which == "ABANDON_QUEST_WITH_ITEMS") and frame:IsVisible() then StaticPopup_OnClick(frame, 1) end
			end
		elseif IsAltKeyDown() then
			if GetQuestLogPushable() then
				QuestMapQuestOptions_ShareQuest(self.questID)
			end
		end
	end
end)

hooksecurefunc(QUEST_TRACKER_MODULE, "OnBlockHeaderClick", function(_, block)
	if IsModifiedClick() then
		if IsControlKeyDown() then
			AbandonQuest()
		elseif IsAltKeyDown() then
			QuestObjectiveTracker_ShareQuest(_, block.questLogIndex)
		end
	end
end)

--[[-----------------------------------
Remove Boss Emote spam in BG (by Partha)
---------------------------------------]]
if cfg.Misc.BGSpam then
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
if cfg.Misc.BossBanner == true then
	BossBanner.PlayBanner = function()
	end
end