local K, C, L, _ = unpack(select(2, ...))

-- Backdrops
K.Backdrop = {
	bgFile = C.media.blank,
	edgeFile = C.media.blizz,
	edgeSize = 14, 
    insets = { left = 2.5, right = 2.5, top = 2.5, bottom = 2.5
	}
}

K.BasicBackdrop = {
	bgFile = C.media.blank,
	tile = true, tileSize = 16,
    insets = { left = 2.5, right = 2.5, top = 2.5, bottom = 2.5
	}
}

K.SimpleBackdrop = {
	bgFile = C.media.blank,
}

K.ModBackdrop = {
	bgFile = C.media.blank,
	tile = true, tileSize = 16,
    insets = { left = 8, right = 8, top = 8, bottom = 8
	}
}

-- Blizz Style
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
	BlizzBorder:SetBackdropColor(0.05, 0.05, 0.05, .9)
	BlizzBorder:SetBackdropBorderColor(.7, .7, .7, 1)
	f.BlizzBorder = BlizzBorder
	return BlizzBorder
end

-- Shadow Style
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
	shadow:SetBackdropColor(0.05, 0.05, 0.05, .9)
	shadow:SetBackdropBorderColor(0, 0, 0, 1)
	f.shadow = shadow
	return shadow
end

-- ShortValue
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

-- Chat Checking
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

-- Rounding
K.Round = function(number, decimals)
	if not decimals then decimals = 0 end
	return (("%%.%df"):format(decimals)):format(number)
end

-- RGBToHex Color
K.RGBToHex = function(r, g, b)
	r = tonumber(r) <= 1 and tonumber(r) >= 0 and tonumber(r) or 0
	g = tonumber(g) <= tonumber(g) and tonumber(g) >= 0 and tonumber(g) or 0
	b = tonumber(b) <= 1 and tonumber(b) >= 0 and tonumber(b) or 0
	return string.format("|cff%02x%02x%02x", r * 255, g * 255, b * 255)
end
