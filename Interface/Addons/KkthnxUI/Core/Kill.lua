local K, C, L, _ = unpack(select(2, ...))

-- Kill all stuff on default UI that we don't need
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addon)
	if addon == "Blizzard_AchievementUI" then
		if C.tooltip.enable then
			hooksecurefunc("AchievementFrameCategories_DisplayButton", function(button) button.showTooltipFunc = nil end)
		end
	end

	--if C.unitframe.enable or addon == "oUF_AbuRaid" then
	if addon == "oUF_AbuRaid" then
		InterfaceOptionsFrameCategoriesButton11:SetScale(0.00001)
		InterfaceOptionsFrameCategoriesButton11:SetAlpha(0)
		if not InCombatLockdown() then
			CompactRaidFrameManager:Kill()
			CompactRaidFrameContainer:Kill()
		end
		ShowPartyFrame = K.Dummy
		HidePartyFrame = K.Dummy
		CompactUnitFrame_UpdateAll = K.Dummy
		CompactUnitFrameProfiles_ApplyProfile = K.Dummy
		CompactRaidFrameManager_UpdateShown = K.Dummy
		CompactRaidFrameManager_UpdateOptionsFlowContainer = K.Dummy
	end

	Advanced_UseUIScale:Kill()
	Advanced_UIScaleSlider:Kill()
	TutorialFrameAlertButton:Kill()
	HelpOpenTicketButtonTutorial:Kill()
	TalentMicroButtonAlert:Kill()
	CollectionsMicroButtonAlert:Kill()
	ReagentBankHelpBox:Kill()
	BagHelpBox:Kill()
	EJMicroButtonAlert:Kill()
	PremadeGroupsPvETutorialAlert:Kill()
	SetCVarBitfield("closedInfoFrames", LE_FRAME_TUTORIAL_WORLD_MAP_FRAME, true)
	SetCVarBitfield("closedInfoFrames", LE_FRAME_TUTORIAL_PET_JOURNAL, true)
	SetCVarBitfield("closedInfoFrames", LE_FRAME_TUTORIAL_GARRISON_BUILDING, true)

	SetCVar("countdownForCooldowns", 0)
	InterfaceOptionsActionBarsPanelCountdownCooldowns:Kill()

	if C.chat.enable then
		SetCVar("chatStyle", "im")
		InterfaceOptionsSocialPanelChatStyle:Kill()
		InterfaceOptionsSocialPanelWholeChatWindowClickable:Kill()
	end

	--if C.unitframe.enable then
	if addon == "oUF_Abu" then
		InterfaceOptionsFrameCategoriesButton9:SetScale(0.00001)
		InterfaceOptionsFrameCategoriesButton9:SetAlpha(0)
		InterfaceOptionsFrameCategoriesButton10:SetScale(0.00001)
		InterfaceOptionsFrameCategoriesButton10:SetAlpha(0)
		InterfaceOptionsBuffsPanelCastableBuffs:Kill()
		InterfaceOptionsBuffsPanelDispellableDebuffs:Kill()
		InterfaceOptionsBuffsPanelShowAllEnemyDebuffs:Kill()
		InterfaceOptionsCombatPanelTargetOfTarget:Kill()
		InterfaceOptionsCombatPanelEnemyCastBars:Kill()
		InterfaceOptionsCombatPanelEnemyCastBarsOnPortrait:Kill()
		SetCVar("showPartyBackground", 0)
	end	

	--[[
	if C.actionbar.enable then
		InterfaceOptionsActionBarsPanelBottomLeft:Kill()
		InterfaceOptionsActionBarsPanelBottomRight:Kill()
		InterfaceOptionsActionBarsPanelRight:Kill()
		InterfaceOptionsActionBarsPanelRightTwo:Kill()
		InterfaceOptionsActionBarsPanelAlwaysShowActionBars:Kill()
	end
	]]
	
	if C.nameplate.enable then
		InterfaceOptionsCombatPanelEnemyCastBarsOnNameplates:Kill()
		InterfaceOptionsNamesPanelUnitNameplatesNameplateClassColors:Kill()
	end

	if C.minimap.enable then
		InterfaceOptionsDisplayPanelRotateMinimap:Kill()
	end

	if C.combattext.enable then
		InterfaceOptionsCombatTextPanelFCTDropDown:Kill()
		if C.combattext.blizz_head_numbers ~= true then
			SetCVar("CombatDamage", 0)
			SetCVar("PetMeleeDamage", 0)
			SetCVar("CombatHealing", 0)
			SetCVar("CombatLogPeriodicSpells", 0)
			SetCVar("CombatHealingAbsorbTarget", 0)
			InterfaceOptionsCombatTextPanelTargetDamage:Kill()
			InterfaceOptionsCombatTextPanelPeriodicDamage:Kill()
			InterfaceOptionsCombatTextPanelPetDamage:Kill()
			InterfaceOptionsCombatTextPanelHealing:Kill()
			InterfaceOptionsCombatTextPanelHealingAbsorbTarget:Kill()
		end
	end
end)