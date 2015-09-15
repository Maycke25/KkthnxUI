local K, C, L, _ = unpack(select(2, ...))
if C.unitframe.customscript ~= true or (IsAddOnLoaded("oUF_Abu")) or (IsAddOnLoaded("oUF")) then return end

-- Class Portraits
hooksecurefunc("UnitFramePortrait_Update",function(self)
    if self.portrait then
        if UnitIsPlayer(self.unit) then 
            local t = CLASS_ICON_TCOORDS[select(2, UnitClass(self.unit))]
            if t then
                self.portrait:SetTexture("Interface\\TargetingFrame\\UI-Classes-Circles")
                self.portrait:SetTexCoord(unpack(t))
            end
        else
            self.portrait:SetTexCoord(0,1,0,1)
        end
    end
end)

-- Class color HP Bars
local function colour(statusbar, unit)
    local _, class, c
    if UnitIsPlayer(unit) and UnitIsConnected(unit) and unit == statusbar.unit and UnitClass(unit) then
        _, class = UnitClass(unit)
        c = CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[class] or RAID_CLASS_COLORS[class]
        statusbar:SetStatusBarColor(c.r, c.g, c.b)
    end
end

hooksecurefunc("UnitFrameHealthBar_Update", colour)
hooksecurefunc("HealthBar_OnValueChanged", function(self)
    colour(self, self.unit)
end)

hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", function()
    PlayerFrameHealthBar.TextString:SetText(AbbreviateLargeNumbers(UnitHealth("player")))
    PlayerFrameManaBar.TextString:SetText(AbbreviateLargeNumbers(UnitMana("player")))
    
    TargetFrameHealthBar.TextString:SetText(AbbreviateLargeNumbers(UnitHealth("target")))
    TargetFrameManaBar.TextString:SetText(AbbreviateLargeNumbers(UnitMana("target")))
    
    FocusFrameHealthBar.TextString:SetText(AbbreviateLargeNumbers(UnitHealth("focus")))
    FocusFrameManaBar.TextString:SetText(AbbreviateLargeNumbers(UnitMana("focus")))
end)

-- Move
PlayerFrame:ClearAllPoints()
PlayerFrame:SetPoint("CENTER", -240, -150)
PlayerFrame.SetPoint = function() end
PlayerFrame:SetScale(1.1)

TargetFrame:ClearAllPoints()
TargetFrame:SetPoint("CENTER", 240, -150)
TargetFrame.SetPoint = function() end
TargetFrame:SetScale(1.1)

-- Castbar is my bitch
CastingBarFrame.timer = CastingBarFrame:CreateFontString(nil);
CastingBarFrame.timer:SetFont(STANDARD_TEXT_FONT,12,"OUTLINE");
CastingBarFrame.timer:SetPoint("TOP", CastingBarFrame, "BOTTOM", 0, 0);
CastingBarFrame.update = .1;

hooksecurefunc("CastingBarFrame_OnUpdate", function(self, elapsed)
    if not self.timer then return end
    if self.update and self.update < elapsed then
        self:SetStatusBarColor(K.Color.r, K.Color.g, K.Color.b)
        if self.casting then
            self.timer:SetText(format("%2.1f/%1.1f", max(self.maxValue - self.value, 0), self.maxValue))
        elseif self.channeling then
            self.timer:SetText(format("%.1f", max(self.value, 0)))
        else
            self.timer:SetText("")
        end
        self.update = .1
    else
        self.update = self.update - elapsed
    end
end)

-- Move it CB
CastingBarFrame:ClearAllPoints()
CastingBarFrame:SetPoint("CENTER",UIParent,"CENTER", 0, -160)
CastingBarFrame.SetPoint = function() end
CastingBarFrame:SetScale(1.1)

TargetFrameSpellBar:ClearAllPoints()
TargetFrameSpellBar:SetPoint("CENTER", UIParent, "CENTER", 10, -110)
TargetFrameSpellBar.SetPoint = function() end
TargetFrameSpellBar:SetScale(1.1)