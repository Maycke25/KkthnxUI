local _, KExts = ...
local cfg = KExts.Config

local BACKDROP = {
	bgFile = [[Interface\BUTTONS\WHITE8X8]], tile = true, tileSize = 8,
	--edgeFile = [[Interface\BUTTONS\WHITE8X8]], edgeSize = 1,
	insets = { left = 0, right = 0, top = 0, bottom = 0 },
}

local PowerTextures = {
	["INTERFACE\\UNITPOWERBARALT\\STONEGUARDJASPER_HORIZONTAL_FILL.BLP"] = {r = 1, g = 0.4, b = 0},
	["INTERFACE\\UNITPOWERBARALT\\MAP_HORIZONTAL_FILL.BLP"] = {r = .97, g = .81, b = 0},
	["INTERFACE\\UNITPOWERBARALT\\STONEGUARDCOBALT_HORIZONTAL_FILL.BLP"] = {r = .1, g = .4, b = .95},
	["INTERFACE\\UNITPOWERBARALT\\STONEGUARDJADE_HORIZONTAL_FILL.BLP"] = {r = .13, g = .55, b = .13},
	["INTERFACE\\UNITPOWERBARALT\\STONEGUARDAMETHYST_HORIZONTAL_FILL.BLP"] = {r = .67, g = 0, b = 1},
}

PlayerPowerBarAlt:UnregisterEvent("UNIT_POWER_BAR_SHOW")
PlayerPowerBarAlt:UnregisterEvent("UNIT_POWER_BAR_HIDE")
PlayerPowerBarAlt:UnregisterEvent("PLAYER_ENTERING_WORLD")

local AltPowerBar = CreateFrame("Frame", "KkthnxUIAltPowerBar", UIParent)
AltPowerBar:SetSize(221, 25)
AltPowerBar:SetPoint("TOP", UIParent, "TOP", 0, -21)
AltPowerBar:SetFrameStrata("MEDIUM")
AltPowerBar:SetFrameLevel(0)
CreateBorder(AltPowerBar, 10, 2)
AltPowerBar:SetBackdrop(BACKDROP)
AltPowerBar:SetBackdropColor(0.1, 0.1, 0.1, 0.8)
AltPowerBar:SetBackdropBorderColor(0, 0, 0, 1)

local AltPowerBarStatus = CreateFrame("StatusBar", "KkthnxUIAltPowerBarStatus", AltPowerBar)
AltPowerBarStatus:SetFrameLevel(AltPowerBar:GetFrameLevel() + 1)
AltPowerBarStatus:SetStatusBarTexture(cfg.uiTexture)
AltPowerBarStatus:SetMinMaxValues(0, 100)
AltPowerBarStatus:SetPoint("TOPLEFT", AltPowerBar, "TOPLEFT", 1, -1)
AltPowerBarStatus:SetPoint("BOTTOMRIGHT", AltPowerBar, "BOTTOMRIGHT", -1, 1)

local AltPowerText = AltPowerBarStatus:CreateFontString("KkthnxUIAltPowerBarText", "OVERLAY")
AltPowerText:SetFont(cfg.uiFont, cfg.uiFontSize, "OUTLINE")
AltPowerText:SetPoint("CENTER", AltPowerBar, "CENTER", 0, 0)
AltPowerText:SetShadowColor(0, 0, 0)
AltPowerText:SetShadowOffset(0, 0)

AltPowerBar:RegisterEvent("UNIT_POWER")
AltPowerBar:RegisterEvent("UNIT_POWER_BAR_SHOW")
AltPowerBar:RegisterEvent("UNIT_POWER_BAR_HIDE")
AltPowerBar:RegisterEvent("PLAYER_ENTERING_WORLD")

local function OnEvent(self)
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	if UnitAlternatePowerInfo("player") then self:Show() else self:Hide() end
end
AltPowerBar:SetScript("OnEvent", OnEvent)

local TimeSinceLastUpdate = 1
local function OnUpdate(self, elapsed)
	if not AltPowerBar:IsShown() then return end
	TimeSinceLastUpdate = TimeSinceLastUpdate + elapsed
	
	if (TimeSinceLastUpdate >= 1) then
		self:SetMinMaxValues(0, UnitPowerMax("player", ALTERNATE_POWER_INDEX))
		local power = UnitPower("player", ALTERNATE_POWER_INDEX)
		local mpower = UnitPowerMax("player", ALTERNATE_POWER_INDEX)
		self:SetValue(power)
		AltPowerText:SetText(power.." / "..mpower)
		local texture, r, g, b = UnitAlternatePowerTextureInfo("player", 2, 0) -- 2 = status bar index, 0 = displayed bar
		if texture and PowerTextures[texture] then r, g, b = PowerTextures[texture].r, PowerTextures[texture].g, PowerTextures[texture].b end --else r, g, b = oUFDuffedUI.ColorGradient(power,mpower, 0, .8, 0, .8, .8, 0, .8, 0, 0) end
		AltPowerBarStatus:SetStatusBarColor(r, g, b)
		self.TimeSinceLastUpdate = 0
	end
end
AltPowerBarStatus:SetScript("OnUpdate", OnUpdate)