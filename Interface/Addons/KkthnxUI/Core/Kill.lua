----------------------------------------------------------------------------------------
--	Kill all stuff on default UI that we don't need
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addon)
	if addon == "Blizzard_AchievementUI" then
		if addon == "KkthnxUI_Tooltip" then
			hooksecurefunc("AchievementFrameCategories_DisplayButton", function(button) button.showTooltipFunc = nil end)
		end
	end

	if addon == "oUF_AbuRaid" then
		InterfaceOptionsFrameCategoriesButton11:SetScale(0.00001)
		InterfaceOptionsFrameCategoriesButton11:SetAlpha(0)
		if not InCombatLockdown() then
			CompactRaidFrameManager:Kill()
			CompactRaidFrameContainer:Kill()
		end
		ShowPartyFrame = Kdummy
		HidePartyFrame = Kdummy
		CompactUnitFrame_UpdateAll = Kdummy
		CompactUnitFrameProfiles_ApplyProfile = Kdummy
		CompactRaidFrameManager_UpdateShown = Kdummy
		CompactRaidFrameManager_UpdateOptionsFlowContainer = Kdummy
	end

	--Advanced_UseUIScale:Kill()
	--Advanced_UIScaleSlider:Kill()
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

	if addon == "KkthnxUI_Chat" then
		SetCVar("chatStyle", "im")
		InterfaceOptionsSocialPanelChatStyle:Kill()
		InterfaceOptionsSocialPanelWholeChatWindowClickable:Kill()
	end

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

	if addon == "KkthnxUI_Actionbars" then
		SetCVar("countdownForCooldowns", 0)
		InterfaceOptionsActionBarsPanelCountdownCooldowns:Kill()
	end

	if addon == "KkthnxUI_Nameplates" then
		InterfaceOptionsCombatPanelEnemyCastBarsOnNameplates:Kill()
		InterfaceOptionsNamesPanelUnitNameplatesNameplateClassColors:Kill()
	end

	if addon == "KkthnxUI_Minimap" then
		InterfaceOptionsDisplayPanelRotateMinimap:Kill()
	end

	if addon == "MikScrollingBattleText" then
		InterfaceOptionsCombatTextPanelFCTDropDown:Kill()
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
end)