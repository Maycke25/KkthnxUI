local K, C, L, _ = unpack(select(2, ...))

--[[-----------------------------------
Backdrops
---------------------------------------]]
K.Backdrop = {
	bgFile = "Interface\\Addons\\KkthnxUI\\Media\\Backgrounds\\Background.blp",
	edgeFile = "Interface\\Addons\\KkthnxUI\\Media\\Tooltips\\KkthnxBorder.blp",
	tile = true, tileSize = 16, edgeSize = 14, 
    insets = { left = 2.5, right = 2.5, top = 2.5, bottom = 2.5
	}
}

K.BasicBackdrop = {
	bgFile = "Interface\\Addons\\KkthnxUI\\Media\\Backgrounds\\Background.blp",
	tile = true, tileSize = 16,
    insets = { left = 2.5, right = 2.5, top = 2.5, bottom = 2.5
	}
}

K.SimpleBackdrop = {
	bgFile = "Interface\\Addons\\KkthnxUI\\Media\\Backgrounds\\Background.blp",
}

K.ModBackdrop = {
	bgFile = "Interface\\Addons\\KkthnxUI\\Media\\Backgrounds\\Background.blp",
	tile = true, tileSize = 16,
    insets = { left = 8, right = 8, top = 8, bottom = 8
	}
}

--[[-----------------------------------
Blizz Style
---------------------------------------]]
local style = {
	bgFile =  C.media.blank,
	edgeFile = C.media.blizz, 
	edgeSize = 14,
	insets = { left = 2.5, right = 2.5, top = 2.5, bottom = 2.5 }
}
function CreateStyle(f, size, level, alpha, alphaborder) 
	if f.BlizzBorder then return end
	local BlizzBorder = CreateFrame("Frame", nil, f)
	BlizzBorder:SetFrameLevel(level or 0)
	BlizzBorder:SetFrameStrata(f:GetFrameStrata())
	BlizzBorder:SetPoint("TOPLEFT", -size, size)
	BlizzBorder:SetPoint("BOTTOMRIGHT", size, -size)
	BlizzBorder:SetBackdrop(style)
	BlizzBorder:SetBackdropColor(0, 0, 0, .9)
	BlizzBorder:SetBackdropBorderColor(.7, .7, .7, 1)
	f.BlizzBorder = BlizzBorder
	return BlizzBorder
end

--[[-----------------------------------
Shadow Style
---------------------------------------]]
local style2 = {
	bgFile =  C.media.blank,
	edgeFile = C.media.glow, 
	edgeSize = 4,
	insets = { left = 3, right = 3, top = 3, bottom = 3 }
}
function CreateStyle2(f, size, level, alpha, alphaborder) 
	if f.shadow then return end
	local shadow = CreateFrame("Frame", nil, f)
	shadow:SetFrameLevel(level or 0)
	shadow:SetFrameStrata(f:GetFrameStrata())
	shadow:SetPoint("TOPLEFT", -size, size)
	shadow:SetPoint("BOTTOMRIGHT", size, -size)
	shadow:SetBackdrop(style2)
	shadow:SetBackdropColor(0, 0, 0, .9)
	shadow:SetBackdropBorderColor(0, 0, 0, 1)
	f.shadow = shadow
	return shadow
end

--[[-----------------------------------
ShortValue
---------------------------------------]]
K.ShortValue = function(value)
	if value >= 1e8 then
		return ("%.0fm"):format(value / 1e6)
	elseif value >= 1e7 then
		return ("%.1fm"):format(value / 1e6):gsub("%.?0+([km])$", "%1")
	elseif value >= 1e6 then
		return ("%.2fm"):format(value / 1e6):gsub("%.?0+([km])$", "%1")
	elseif value >= 1e5 then
		return ("%.0fk"):format(value / 1e3)
	elseif value >= 1e3 then
		return ("%.1fk"):format(value / 1e3):gsub("%.?0+([km])$", "%1")
	else
		return value
	end
end

--[[-----------------------------------
Chat Checking
---------------------------------------]]
K.Check = function(warning)
	if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
		return "INSTANCE_CHAT"
	elseif IsInRaid(LE_PARTY_CATEGORY_HOME) then
		if warning and (UnitIsGroupLeader("player") or UnitIsGroupAssistant("player") or IsEveryoneAssistant()) then
			return "RAID_WARNING"
		else
			return "RAID"
		end
	elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then
		return "PARTY"
	end
	return "SAY"
end

--[[-----------------------------------
Rounding
---------------------------------------]]
K.Round = function(number, decimals)
	if not decimals then decimals = 0 end
	return (("%%.%df"):format(decimals)):format(number)
end

--[[-----------------------------------
RGBToHex Color
---------------------------------------]]
K.RGBToHex = function(r, g, b)
	r = tonumber(r) <= 1 and tonumber(r) >= 0 and tonumber(r) or 0
	g = tonumber(g) <= tonumber(g) and tonumber(g) >= 0 and tonumber(g) or 0
	b = tonumber(b) <= 1 and tonumber(b) >= 0 and tonumber(b) or 0
	return string.format("|cff%02x%02x%02x", r * 255, g * 255, b * 255)
end

--[[-----------------------------------
Spec Checking / Role
---------------------------------------]]
K.CheckSpec = function(spec)
	local activeGroup = GetActiveSpecGroup()
	if activeGroup and GetSpecialization(false, false, activeGroup) then
		return spec == GetSpecialization(false, false, activeGroup)
	end
end

local isCaster = {
	DEATHKNIGHT = {nil, nil, nil},
	DRUID = {true},					-- Balance
	HUNTER = {nil, nil, nil},
	MAGE = {true, true, true},
	MONK = {nil, nil, nil},
	PALADIN = {nil, nil, nil},
	PRIEST = {nil, nil, true},		-- Shadow
	ROGUE = {nil, nil, nil},
	SHAMAN = {true},				-- Elemental
	WARLOCK = {true, true, true},
	WARRIOR = {nil, nil, nil}
}

local function CheckRole(self, event, unit)
	local spec = GetSpecialization()
	local role = spec and GetSpecializationRole(spec)

	if role == "TANK" then
		K.Role = "Tank"
	elseif role == "HEALER" then
		K.Role = "Healer"
	elseif role == "DAMAGER" then
		if isCaster[K.Class][spec] then
			K.Role = "Caster"
		else
			K.Role = "Melee"
		end
	end
end
local RoleUpdater = CreateFrame("Frame")
RoleUpdater:RegisterEvent("PLAYER_ENTERING_WORLD")
RoleUpdater:RegisterEvent("PLAYER_TALENT_UPDATE")
RoleUpdater:SetScript("OnEvent", CheckRole)

--[[-----------------------------------
UTF functions
---------------------------------------]]
K.UTF = function(string, i, dots)
	if not string then return end
	local bytes = string:len()
	if bytes <= i then
		return string
	else
		local len, pos = 0, 1
		while (pos <= bytes) do
			len = len + 1
			local c = string:byte(pos)
			if c > 0 and c <= 127 then
				pos = pos + 1
			elseif c >= 192 and c <= 223 then
				pos = pos + 2
			elseif c >= 224 and c <= 239 then
				pos = pos + 3
			elseif c >= 240 and c <= 247 then
				pos = pos + 4
			end
			if len == i then break end
		end
		if len == i and pos <= bytes then
			return string:sub(1, pos - 1)..(dots and "..." or "")
		else
			return string
		end
	end
end