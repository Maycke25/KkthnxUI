local cfg = {}
cfg.ErrorWhite = false
cfg.ErrorBlack = true
cfg.ErrorCombat = false

----------------------------------------------------------------------------------------
--	White list errors, that will not be hidden
if cfg.ErrorWhite ~= true and cfg.ErrorBlack ~= true then return end
----------------------------------------------------------------------------------------
White_List = {
	[ERR_INV_FULL] = true,
	[ERR_QUEST_LOG_FULL] = true,
	[ERR_ITEM_MAX_COUNT] = true,
	[ERR_NOT_ENOUGH_MONEY] = true,
	[SPELL_FAILED_IN_COMBAT_RES_LIMIT_REACHED] = true,
	[ERR_LOOT_MASTER_INV_FULL] = true,
	[ERR_LOOT_MASTER_OTHER] = true,
	[ERR_LOOT_MASTER_UNIQUE_ITEM] = true,
}

----------------------------------------------------------------------------------------
--	Black list errors, that will be hidden
----------------------------------------------------------------------------------------
Black_List = {
	[SPELL_FAILED_NO_COMBO_POINTS] = true,
	[SPELL_FAILED_TARGETS_DEAD] = true,
	[SPELL_FAILED_SPELL_IN_PROGRESS] = true,
	[SPELL_FAILED_TARGET_AURASTATE] = true,
	[SPELL_FAILED_CASTER_AURASTATE] = true,
	[SPELL_FAILED_NO_ENDURANCE] = true,
	[SPELL_FAILED_BAD_TARGETS] = true,
	[SPELL_FAILED_NOT_MOUNTED] = true,
	[SPELL_FAILED_NOT_ON_TAXI] = true,
	[SPELL_FAILED_NOT_INFRONT] = true,
	[SPELL_FAILED_NOT_IN_CONTROL] = true,
	[SPELL_FAILED_MOVING] = true,
	[SPELL_FAILED_AURA_BOUNCED] = true,
	[SPELL_FAILED_CANT_DO_THAT_RIGHT_NOW] = true,
	[SPELL_FAILED_AFFECTING_COMBAT] = true,
	[ERR_ATTACK_FLEEING] = true,
	[ERR_ITEM_COOLDOWN] = true,
	[ERR_GENERIC_NO_TARGET] = true,
	[ERR_ABILITY_COOLDOWN] = true,
	[ERR_NO_ATTACK_TARGET] = true,
	[ERR_SPELL_COOLDOWN] = true,
	[ERR_OUT_OF_ARCANE_CHARGES] = true,
	[ERR_OUT_OF_BALANCE_NEGATIVE] = true,
	[ERR_OUT_OF_BALANCE_POSITIVE] = true,
	[ERR_OUT_OF_BURNING_EMBERS] = true,
	[ERR_OUT_OF_CHI] = true,
	[ERR_OUT_OF_DARK_FORCE] = true,
	[ERR_OUT_OF_DEMONIC_FURY] = true,
	[ERR_OUT_OF_SOUL_SHARDS] = true,
	[ERR_OUT_OF_LIGHT_FORCE] = true,
	[ERR_OUT_OF_SHADOW_ORBS] = true,
	[ERR_OUT_OF_HOLY_POWER] = true,
	[ERR_OUT_OF_ENERGY] = true,
	[ERR_OUT_OF_RAGE] = true,
	[ERR_OUT_OF_FOCUS] = true,
	[ERR_OUT_OF_RUNES] = true,
	[ERR_OUT_OF_RUNIC_POWER] = true,
	[ERR_OUT_OF_MANA] = true,
	[ERR_OUT_OF_POWER_DISPLAY] = true,
	[ERR_OUT_OF_RANGE] = true,
	[ERR_BADATTACKPOS] = true,
	[ERR_INVALID_ATTACK_TARGET] = true,
	[ERR_NOEMOTEWHILERUNNING] = true,
	[ERR_NOT_EQUIPPABLE] = true,
	[ERR_NOT_IN_COMBAT] = true,
	[ERR_MAIL_DATABASE_ERROR] = true,
	[OUT_OF_POWER_DISPLAY] = true,
	[OUT_OF_ENERGY] = true,
	[OUT_OF_FOCUS] = true,
	[OUT_OF_MANA] = true,
	[OUT_OF_POWER_DISPLAY] = true,
	[OUT_OF_RAGE] = true,
	[ERR_SPELL_OUT_OF_RANGE] = true,
	[ERR_TOO_FAR_TO_INTERACT] = true,
}

----------------------------------------------------------------------------------------
--	Clear UIErrorsFrame(module from Kousei by Haste)
if cfg.ErrorWhite == true or cfg.ErrorBlack == true then
----------------------------------------------------------------------------------------
	local frame = CreateFrame("Frame")
	frame:SetScript("OnEvent", function(self, event, text)
		if cfg.ErrorWhite == true and cfg.ErrorBlack == false then
			if White_List[text] then
				UIErrorsFrame:AddMessage(text, 1, 0 ,0)
			else
				L_INFO_ERRORS = text
			end
		elseif cfg.ErrorBlack == true and cfg.ErrorWhite == false then
			if Black_List[text] then
				L_INFO_ERRORS = text
			else
				UIErrorsFrame:AddMessage(text, 1, 0 ,0)
			end
		end
	end)
	SlashCmdList.ERROR = function()
		UIErrorsFrame:AddMessage(L_INFO_ERRORS, 1, 0, 0)
	end
	SLASH_ERROR1 = "/error"
	UIErrorsFrame:UnregisterEvent("UI_ERROR_MESSAGE")
	frame:RegisterEvent("UI_ERROR_MESSAGE")
end

----------------------------------------------------------------------------------------
--	Clear all UIErrors frame in combat
----------------------------------------------------------------------------------------
if cfg.ErrorCombat == true then
	local frame = CreateFrame("Frame")
	local OnEvent = function(self, event, ...) self[event](self, event, ...) end
	frame:SetScript("OnEvent", OnEvent)
	local function PLAYER_REGEN_DISABLED()
		UIErrorsFrame:Hide()
	end
	local function PLAYER_REGEN_ENABLED()
		UIErrorsFrame:Show()
	end
	frame:RegisterEvent("PLAYER_REGEN_DISABLED")
	frame["PLAYER_REGEN_DISABLED"] = PLAYER_REGEN_DISABLED
	frame:RegisterEvent("PLAYER_REGEN_ENABLED")
	frame["PLAYER_REGEN_ENABLED"] = PLAYER_REGEN_ENABLED
end