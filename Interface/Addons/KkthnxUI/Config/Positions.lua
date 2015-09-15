local K, C, L, _ = unpack(select(2, ...))

C["position"] = {
	["achievements"] = {"TOP", UIParent, "TOP", 0, -21},
	["autobutton"] = {"TOPLEFT", Minimap, "BOTTOMLEFT", -2, -22},
	["capturebar"] = {"TOP", UIParent, "TOP", 0, 3},
	["chat"] = {"BOTTOMLEFT", UIParent, "BOTTOMLEFT", 5, 20},
	["group_loot"] = {"BOTTOM", UIParent, "BOTTOM", -238, 700},
	["loot"] = {"TOPLEFT", UIParent, "TOPLEFT", 245, -220},
	["minimap"] = {"TOPRIGHT", UIParent, "TOPRIGHT", -7, -7},
	["minimap_buttons"] = {"TOPRIGHT", Minimap, "TOPLEFT", -3, 2},
	["quest"] = {"RIGHT", UIParent, "RIGHT", -182.00, 193.00},
	["tooltip"] = {"BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -5, 5},
	["top_panel"] = {"TOP", UIParent, "TOP", 0, -20},
	["uierror"] = {"TOP", UIParent, "TOP", 0, -30},

}