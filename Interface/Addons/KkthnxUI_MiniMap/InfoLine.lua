local _, Kmap = ...
local cfg = Kmap.Config

--[[----------------------------------
FUNCTIONS
--------------------------------------]]
local memformat = function(number)
	if number > 1024 then
		return string.format("%.2fmb", (number / 1024))
	else
		return string.format("%.1fkb", floor(number))
	end
end

--[[----------------------------------
Number format func
--------------------------------------]]
local numformat = function(v)
	if v > 1E10 then
		return (floor(v/1E9)).."b"
	elseif v > 1E9 then
		return (floor((v/1E9)*10)/10).."b"
	elseif v > 1E7 then
		return (floor(v/1E6)).."m"
	elseif v > 1E6 then
		return (floor((v/1E6)*10)/10).."m"
	elseif v > 1E4 then
		return (floor(v/1E3)).."k"
	elseif v > 1E3 then
		return (floor((v/1E3)*10)/10).."k"
	else
		return v
	end
end

--[[----------------------------------
Petbattle handler
--------------------------------------]]
local PBHandler = CreateFrame("Frame",nil,UIParent)
PBHandler:RegisterEvent("PET_BATTLE_OPENING_START")
PBHandler:RegisterEvent("PET_BATTLE_CLOSE")
--event
PBHandler:SetScript("OnEvent", function(...)
	local self, event, arg1 = ...
	if event == "PET_BATTLE_OPENING_START" then
		self:Hide()
	elseif event == "PET_BATTLE_CLOSE" then
		self:Show()
	end
end)

local frame = CreateFrame("Frame", "rIS_DragFrame", PBHandler)
frame:SetSize(5, 5)
frame:SetScale(cfg.InfoLine.Scale)
frame:SetPoint(cfg.InfoLine.PoS.a1,cfg.InfoLine.PoS.af,cfg.InfoLine.PoS.a2,cfg.InfoLine.PoS.x,cfg.InfoLine.PoS.y) -- Needs to be checked.

local f1 = CreateFrame("Frame", "rInfoStringsContainer1", frame)
local f2 = CreateFrame("Frame", "rInfoStringsContainer2", frame)

f1:SetPoint("TOP", frame, 0, 0)
f2:SetPoint("TOP", f1, "BOTTOM", 0, -3)

local function rsiCreateFontString(f,size)
	local t = f:CreateFontString(nil, "BACKGROUND")
	t:SetFont(cfg.mapFont, cfg.mapFontSize, cfg.mapFontStyle)
	t:SetShadowOffset(0, 0)
	t:SetPoint("CENTER", f)
	return t
end

f1.text = rsiCreateFontString(f1,12)
f2.text = rsiCreateFontString(f2,12)

--[[----------------------------------
Garbage function from Lyn
--------------------------------------]]
local function rsiClearGarbage()
	UpdateAddOnMemoryUsage()
	local before = gcinfo()
	collectgarbage()
	UpdateAddOnMemoryUsage()
	local after = gcinfo()
	print("Cleaned: "..memformat(before-after))
end

f2:EnableMouse(true)
f2:SetScript("OnMouseDown", function()
	rsiClearGarbage()
end)

local addoncompare = function(a, b)
	return a.memory > b.memory
end
local addonlist = 20

--[[----------------------------------
Tooltip function from Lyn
--------------------------------------]]
local function rsiShowMemTooltip(self)
	local color = { r=156/255, g=144/255, b=125/255 }
	GameTooltip:SetOwner(self, "ANCHOR_NONE")
	GameTooltip:SetPoint("TOPRIGHT", Minimap, "BOTTOMLEFT", 0, 0)
	local blizz = collectgarbage("count")
	local addons = {}
	local enry, memory
	local total = 0
	local nr = 0
	UpdateAddOnMemoryUsage()
	GameTooltip:AddLine("Top "..addonlist.." AddOns", color.r, color.g, color.b)
	GameTooltip:AddLine(" ")
	for i=1, GetNumAddOns(), 1 do
		if (GetAddOnMemoryUsage(i) > 0 ) then
			memory = GetAddOnMemoryUsage(i)
			entry = {name = GetAddOnInfo(i), memory = memory}
			table.insert(addons, entry)
			total = total + memory
		end
	end
	table.sort(addons, addoncompare)
	for _, entry in pairs(addons) do
		if nr < addonlist then
			GameTooltip:AddDoubleLine(entry.name, memformat(entry.memory), 1, 1, 1, 1, 1, 1)
			nr = nr+1
		end
	end
	GameTooltip:AddLine(" ")
	GameTooltip:AddDoubleLine("Total", memformat(total), color.r, color.g, color.b, color.r, color.g, color.b)
	GameTooltip:AddDoubleLine("Total incl. Blizzard", memformat(blizz), color.r, color.g, color.b, color.r, color.g, color.b)
	GameTooltip:Show()
end

f2:SetScript("OnEnter", function() rsiShowMemTooltip(f2) end)
f2:SetScript("OnLeave", function() GameTooltip:Hide() end)

local function rsiFPS()
	return floor(GetFramerate()).."fps"
end

local function rsiLatency()
	return select(3, GetNetStats()).."ms"
end

local function rsiMemory()
	local t = 0
	UpdateAddOnMemoryUsage()
	for i=1, GetNumAddOns(), 1 do
		t = t + GetAddOnMemoryUsage(i)
	end
	return memformat(t)
end

local function rsiZone()
	local zone = ""
	zone = GetMinimapZoneText() -- Need to match this with blizz default color or class color ?
	return zone
end

local function rsiUpdateStrings()
	
	f1.text:SetText(rsiZone())
	f1.text:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	f1:SetHeight(f1.text:GetStringHeight())
	f1:SetWidth(f1.text:GetStringWidth())
	f1.text:SetWidth(Minimap:GetWidth())
	
	f2.text:SetText(rsiLatency().." - "..rsiFPS())
	f2.text:SetTextColor(0.84,0.84,0.84);
	f2:SetHeight(f2.text:GetStringHeight())
	f2:SetWidth(f2.text:GetStringWidth())
	
end

local startSearch = function(self)
	--timer
	local ag = self:CreateAnimationGroup()
	ag.anim = ag:CreateAnimation()
	ag.anim:SetDuration(1)
	ag:SetLooping("REPEAT")
	ag:SetScript("OnLoop", function(self, event, ...)
		rsiUpdateStrings()
	end)
	ag:Play()
end

--[[----------------------------------
Init
--------------------------------------]]
local a = CreateFrame("Frame")
a:RegisterEvent("PLAYER_LOGIN")
a:SetScript("OnEvent", function(self,event,...)
	if event == "PLAYER_LOGIN" then
		startSearch(self)
	end
end)