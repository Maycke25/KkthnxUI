--[[	Core / API functions and Globals

------------------]]

KkthnxUI_UIScale = 768 / 1080
KkthnxUI_FontPath = [[Interface\AddOns\KkthnxUI\Media\Fonts\Normal.ttf]]

KKTHNXUI_CLASS_COLORS = {
	["HUNTER"] 		= { r = 0.67, g = 0.83, b = 0.45 },
	["WARLOCK"] 	= { r = 0.58, g = 0.51, b = 1.0 },
	["PRIEST"] 		= { r = 1.0, g = 1.0, b = 1.0 },
	["PALADIN"] 	= { r = 0.96, g = 0.55, b = 0.73 },
	["MAGE"] 		= { r = 0.41, g = 0.80, b = 0.94 },
	["ROGUE"]		= { r = 1.00, g = 0.96, b = 0.41 },
	["DRUID"] 		= { r = 1.00, g = 0.49, b = 0.04 },
	["SHAMAN"] 		= { r = 0.00, g = 0.44, b = 0.87 },
	["WARRIOR"] 	= { r = 0.78, g = 0.61, b = 0.43 },
	["DEATHKNIGHT"] = { r = 0.77, g = 0.12, b = 0.23 },
	["MONK"] 		= { r = 0.00, g = 1.00, b = 0.59 },
}

KKTHNXUI_FONTLIST = {
	[ 1] = {"Normal.ttf",8,10,12,14,16,true},
}

function KKTHNXUI_UIParent_OnLoad(self)
	UIParent:HookScript("OnShow", function() self:SetAlpha(1) end)
	UIParent:HookScript("OnHide", function() self:SetAlpha(0) end)
end

function KkthnxUI_DisableFrame(ref)
	local frame
	
	if type(ref) == "string" then
		frame = _G[ref]
	else
		frame = ref
	end
	
	if frame then
		frame:SetParent(KKTHNXUI_DisableBlizzard)
		frame:UnregisterAllEvents()
	end
end

local EffectiveLevelColors = {
	["Impossible"]	= {1.0,0.0,0.0},
	["Hard"]		= {1.0,0.3,0.0},
	["Normal"]		= {1.0,1.0,1.0},
	["Easy"]		= {0.0,1.0,0.0},
	["Trivial"]		= {0.5,0.5,0.5},
}

function KkthnxUI_GetEffectiveLevelColor(unitLvl)
	local playerLvl = UnitLevel("player")
	local stage = unitLvl - playerLvl
	local color;
	
	if stage >= 5 then
		color = EffectiveLevelColors["Impossible"]
	elseif stage >= 3 then
		color = EffectiveLevelColors["Hard"]
	elseif stage >= -4 then
		color = EffectiveLevelColors["Normal"]
	elseif -stage <= GetQuestGreenRange() then
		color = EffectiveLevelColors["Easy"]
	else
		color = EffectiveLevelColors["Trivial"]
	end
	
	return unpack(color)
end