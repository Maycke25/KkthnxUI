local K, C, L, _ = unpack(select(2, ...))
if C.skins.skada ~= true then return end

if not IsAddOnLoaded("Skada") then return end
local Skada = Skada
local barSpacing = 1, 1
local borderWidth = 2, 2

local barmod = Skada.displays["bar"]

local titleBG = {
	bgFile = C.media.texture,
	tile = false,
	tileSize = 0
}

barmod.ApplySettings_ = barmod.ApplySettings
barmod.ApplySettings = function(self, win)
	barmod.ApplySettings_(self, win)
	
	local skada = win.bargroup

	if win.db.enabletitle then
		skada.button:SetBackdrop(titleBG)
		skada.button:SetBackdropColor(.3,.3,.3, .9)
	end

	skada:SetTexture(C.media.texture)
	skada:SetSpacing(barSpacing)
	skada:SetFont(C.font.basic_font, C.font.basic_font_size)
	skada:SetFrameLevel(5)
	
	skada:SetBackdrop(nil)
	if not skada.backdrop then
		CreateBackdrop(skada)
		skada.backdrop:ClearAllPoints()
		skada.backdrop:SetPoint('TOPLEFT', win.bargroup.button or win.bargroup, 'TOPLEFT', -2, 2)
		skada.backdrop:SetPoint('BOTTOMRIGHT', win.bargroup, 'BOTTOMRIGHT', 2, -2)
	end
	
	hooksecurefunc(Skada, "OpenReportWindow", function(self)
		if not self.ReportWindow.frame.reskinned then
			self.ReportWindow.frame:StripTextures()
			CreateStyle(self.ReportWindow.frame, 2)
			self.ReportWindow.frame.reskinned = true
		end
	end)
end

for _, window in ipairs(Skada:GetWindows()) do
	window:UpdateDisplay()
end