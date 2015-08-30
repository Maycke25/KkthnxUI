--[[-----------------------------------
KkthnxUI Functions
---------------------------------------]]

--[[-----------------------------------
Mult / Scale - gxResolution
---------------------------------------]]
local mult = 768 / string.match(GetCVar("gxResolution"), "%d+x(%d+)") / 0.71
local Scale = function(x) return mult * math.floor(x / mult + 0.5) end
KScale = function(x) return Scale(x) end

--[[-----------------------------------
Chat Checking
---------------------------------------]]
KCheck = function(warning)
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
KRound = function(number, decimals)
	if not decimals then decimals = 0 end
	return (("%%.%df"):format(decimals)):format(number)
end

--[[-----------------------------------
RGBToHex Color
---------------------------------------]]
KRGBToHex = function(r, g, b)
	r = r <= 1 and r >= 0 and r or 0
	g = g <= 1 and g >= 0 and g or 0
	b = b <= 1 and b >= 0 and b or 0
	return string.format("|cff%02x%02x%02x", r*255, g*255, b*255)
end

--[[-----------------------------------
Fade in/out functions
---------------------------------------]]
function FadeIn(f)
	UIFrameFadeIn(f, 0.4, f:GetAlpha(), 1)
end

function FadeOut(f)
	UIFrameFadeOut(f, 0.8, f:GetAlpha(), 0)
end

local function StripTextures(object, kill)
	for i = 1, object:GetNumRegions() do
		local region = select(i, object:GetRegions())
		if region:GetObjectType() == "Texture" then
			if kill then
				region:Kill()
			else
				region:SetTexture(nil)
			end
		end
	end
end

--[[-----------------------------------
Kill object function
---------------------------------------]]
local HiddenFrame = CreateFrame("Frame")
HiddenFrame:Hide()
local function Kill(object)
	if object.UnregisterAllEvents then
		object:UnregisterAllEvents()
		object:SetParent(HiddenFrame)
	else
		object.Show = Kdummy
	end
	object:Hide()
end

local function addapi(object)
	local mt = getmetatable(object).__index
	if not object.StripTextures then mt.StripTextures = StripTextures end
	if not object.Kill then mt.Kill = Kill end
	if not object.FadeIn then mt.FadeIn = FadeIn end
	if not object.FadeOut then mt.FadeOut = FadeOut end
end

local handled = {["Frame"] = true}
local object = CreateFrame("Frame")
addapi(object)
addapi(object:CreateTexture())

object = EnumerateFrames()
while object do
	if not handled[object:GetObjectType()] then
		addapi(object)
		handled[object:GetObjectType()] = true
	end
	object = EnumerateFrames(object)
end