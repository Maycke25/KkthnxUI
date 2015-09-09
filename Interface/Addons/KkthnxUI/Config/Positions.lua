local K, C, L, _ = unpack(select(2, ...))

C["position"] = {
	["minimap_buttons"] = {"TOPRIGHT", Minimap, "TOPLEFT", -3, 2},
	["minimap"] = {"TOPRIGHT", UIParent, "TOPRIGHT", -7, -7},
	["infoline"] = {"TOP", Minimap, "BOTTOM", 0, -8},
	["achievements"] = {"TOP", UIParent, "TOP", 0, -21},
	["capturebar"] = {"TOP", UIParent, "TOP", 0, 3},
	["chat"] = {"BOTTOMLEFT", UIParent, "BOTTOMLEFT", 5, 5},
	["loot"] = {"TOPLEFT", UIParent, "TOPLEFT", 245, -220},
	["group_loot"] = {"BOTTOM", UIParent, "BOTTOM", -238, 700},
	["uierror"] = {"TOP", UIParent, "TOP", 0, -30},
	["tooltip"] = {"BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -41, 2},
	["tempenchant1"] = {"TOPRIGHT", Minimap, "TOPLEFT", -7, 2},
	["tempenchant2"] = {'TOPRIGHT', TempEnchant1, 'TOPLEFT', -C.buffs.paddingX, 0},

}