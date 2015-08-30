----------------------------------------------------------------------------------------
--	Based on tekticles(by Tekkub)
----------------------------------------------------------------------------------------
local SetFont = function(obj, font, size, style, r, g, b, sr, sg, sb, sox, soy)
	obj:SetFont(font, size, style)
	if sr and sg and sb then obj:SetShadowColor(sr, sg, sb) end
	if sox and soy then obj:SetShadowOffset(sox, soy) end
	if r and g and b then obj:SetTextColor(r, g, b) end
end

local frame = CreateFrame("Frame", nil, UIParent)
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addon)
	if addon ~= "KkthnxUI_Fonts" or addon == "tekticles" then return end

	local NORMAL = [=[Interface\AddOns\KkthnxUI_Media\Media\Fonts\Normal.ttf]=]
	local COMBAT = [=[Interface\AddOns\KkthnxUI_Media\Media\Fonts\Damage.ttf]=]
	
	if (Kscreenwidth > 3840) then
		InterfaceOptionsCombatTextPanelTargetDamage:Hide()
		InterfaceOptionsCombatTextPanelPeriodicDamage:Hide()
		InterfaceOptionsCombatTextPanelPetDamage:Hide()
		InterfaceOptionsCombatTextPanelHealing:Hide()
		SetCVar("CombatLogPeriodicSpells", 0)
		SetCVar("PetMeleeDamage", 0)
		SetCVar("CombatDamage", 0)
		SetCVar("CombatHealing", 0)

		local INVISIBLE = [=[Interface\AddOns\KkthnxUI_Media\Media\Fonts\Invisible.ttf]=]
		COMBAT = INVISIBLE
		DAMAGE_TEXT_FONT = INVISIBLE
	end

	UIDROPDOWNMENU_DEFAULT_TEXT_HEIGHT = 12
	CHAT_FONT_HEIGHTS = {11, 12, 13, 14, 15, 16, 17, 18, 19, 20}

	UNIT_NAME_FONT     = NORMAL
	STANDARD_TEXT_FONT = NORMAL
	DAMAGE_TEXT_FONT   = COMBAT
	LARGE_NUMBER_SEPERATOR = ""

	-- Base fonts
	SetFont(AchievementFont_Small, NORMAL, 11, nil, nil, nil, nil, 0, 0, 0, 1, -1)
	SetFont(InvoiceFont_Med, NORMAL, 13, nil, 0.15, 0.09, 0.04)
	SetFont(InvoiceFont_Small, NORMAL, 11, nil, 0.15, 0.09, 0.04)
	SetFont(MailFont_Large, NORMAL, 15, nil, 0, 0, 0, 0, 0, 0, 1, -1)
	SetFont(NumberFont_Outline_Huge, NORMAL, 30, "THINOUTLINE", 30)
	SetFont(NumberFont_Outline_Large, NORMAL, 17, "OUTLINE")
	SetFont(NumberFont_Outline_Med, NORMAL, 15, "OUTLINE")
	SetFont(NumberFont_Shadow_Med, NORMAL, 14)
	SetFont(NumberFont_Shadow_Small, NORMAL, 13, nil, nil, nil, nil, 0, 0, 0, 1, -1)
	SetFont(QuestFont_Large, NORMAL, 16)
	SetFont(QuestFont_Shadow_Huge, NORMAL, 19, nil, nil, nil, nil, 0.54, 0.4, 0.1)
	SetFont(QuestFont_Shadow_Small, NORMAL, 15)
	SetFont(QuestFont_Super_Huge, NORMAL, 20, nil, nil, nil, nil, 0, 0, 0, 1, -1)
	SetFont(QuestFont_Huge, NORMAL, 17, nil, nil, nil, nil, 0, 0, 0, 1, -1)
	SetFont(QuestMapRewardsFont, NORMAL, 12, nil, nil, nil, nil, 0, 0, 0, 1, -1)
	SetFont(ReputationDetailFont, NORMAL, 11, nil, nil, nil, nil, 0, 0, 0, 1, -1)
	SetFont(SpellFont_Small, NORMAL, 11)
	SetFont(SystemFont_InverseShadow_Small, NORMAL, 11)
	SetFont(SystemFont_Large, NORMAL, 17)
	SetFont(SystemFont_Med1, NORMAL, 13)
	SetFont(SystemFont_Med2, NORMAL, 14, nil, 0.15, 0.09, 0.04)
	SetFont(SystemFont_Med3, NORMAL, 15)
	SetFont(SystemFont_OutlineThick_Huge2, NORMAL, 22, "THINOUTLINE")
	SetFont(SystemFont_OutlineThick_Huge4, NORMAL, 27, "THINOUTLINE")
	SetFont(SystemFont_OutlineThick_WTF, NORMAL, 31, "THINOUTLINE", nil, nil, nil, 0, 0, 0, 1, -1)
	SetFont(SystemFont_Outline_Small, NORMAL, 12, "OUTLINE")
	SetFont(SystemFont_Shadow_Huge1, NORMAL, 20)
	SetFont(SystemFont_Shadow_Huge3, NORMAL, 25)
	SetFont(SystemFont_Shadow_Large, NORMAL, 17)
	SetFont(SystemFont_Shadow_Med1, NORMAL, 13)
	SetFont(SystemFont_Shadow_Med2, NORMAL, 13)
	SetFont(SystemFont_Shadow_Med3, NORMAL, 15)
	SetFont(SystemFont_Shadow_Outline_Huge2, NORMAL, 22, "OUTLINE")
	SetFont(SystemFont_Shadow_Small, NORMAL, 11)
	SetFont(SystemFont_Small, NORMAL, 12)
	SetFont(SystemFont_Tiny, NORMAL, 11)
	SetFont(GameTooltipHeader, NORMAL, GetLocale() == "zhTW" and 14 or 13, nil, nil, nil, nil, 0, 0, 0, 1, -1)
	SetFont(Tooltip_Med, NORMAL, GetLocale() == "zhTW" and 12 or 11, nil, nil, nil, nil, 0, 0, 0, 1, -1)
	SetFont(Tooltip_Small, NORMAL, GetLocale() == "zhTW" and 11 or 10, nil, nil, nil, nil, 0, 0, 0, 1, -1)
	SetFont(GameTooltipTextSmall, NORMAL, GetLocale() == "zhTW" and 12 or 11, nil, nil, nil, nil, 0, 0, 0, 1, -1)
	SetFont(FriendsFont_Small, NORMAL, 11)
	SetFont(FriendsFont_Normal, NORMAL, 12)
	SetFont(FriendsFont_Large, NORMAL, 15)
	SetFont(FriendsFont_UserText, NORMAL, 11)
	SetFont(ZoneTextString, NORMAL, 32, "OUTLINE")
	SetFont(SubZoneTextString, NORMAL, 25, "OUTLINE")
	SetFont(PVPInfoTextString, NORMAL, 22, "THINOUTLINE")
	SetFont(PVPArenaTextString, NORMAL, 22, "THINOUTLINE")
	SetFont(CoreAbilityFont, NORMAL, 32, nil, 1, 0.82, 0, 0, 0, 0, 1, -1)
	SetFont(ChatBubbleFont, NORMAL, 14)
	SetFont(WhiteNormalNumberFont, NORMAL, 11)

	-- Derived fonts
	SetFont(BossEmoteNormalHuge, NORMAL, 27, "THINOUTLINE")
	SetFont(ErrorFont, NORMAL, 16)
	SetFont(QuestFontNormalSmall, NORMAL, 13, nil, nil, nil, nil, 0.54, 0.4, 0.1)
	SetFont(WorldMapTextFont, NORMAL, 31, "THINOUTLINE", nil, nil, nil, 0, 0, 0, 1, -1)
	SetFont(HelpFrameKnowledgebaseNavBarHomeButtonText, NORMAL, 13, nil, nil, nil, nil, 0, 0, 0, 1, -1)

	-- Channel list
	for i = 1, MAX_CHANNEL_BUTTONS do
		local f = _G["ChannelButton"..i.."Text"]
		f:SetFontObject(GameFontNormalSmallLeft)
	end

	-- Player title
	for _, butt in pairs(PaperDollTitlesPane.buttons) do butt.text:SetFontObject(GameFontHighlightSmallLeft) end
end)