local K, C, L, _ = unpack(select(2, ...))
if C.unitframe.enable ~= true or (IsAddOnLoaded("oUF")) then return end

local KUnitFrames = CreateFrame("Frame")
KUnitFrames:RegisterEvent("ADDON_LOADED")
KUnitFrames:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" and arg1 == "KkthnxUI" then
        
        --[[----------------------------
        Powerbar Colors
        --------------------------------]]
        PowerBarColor["MANA"] = {r = 0.31, g = 0.45, b = 0.63}
        PowerBarColor["RAGE"] = {r = 0.69, g = 0.31, b = 0.31}
        PowerBarColor["FOCUS"] = {r = 0.71, g = 0.43, b = 0.27}
        PowerBarColor["ENERGY"] = {r = 0.65, g = 0.63, b = 0.35}
        PowerBarColor["POWER_TYPE_FEL_ENERGY"] = {r = 0.65, g = 0.63, b = 0.35}
        PowerBarColor["RUNES"] = {r = 0.55, g = 0.57, b = 0.61}
        PowerBarColor["RUNIC_POWER"] = {r = 0, g = 0.82, b = 1}
        
        --[[----------------------------
        Unit Font Style
        --------------------------------]]
        local shorts = {
            { 1e10, 1e9, "%.0fB" }, -- 10b+ as 12B
            { 1e9, 1e9, "%.1fB" }, -- 1b+ as 8.3B
            { 1e7, 1e6, "%.0fM" }, -- 10m+ as 14M
            { 1e6, 1e6, "%.1fM" }, -- 1m+ as 7.4M
            { 1e5, 1e3, "%.0fK" }, -- 100k+ as 840K
            { 1e3, 1e3, "%.1fK" }, -- 1k+ as 2.5K
            { 0, 1, "%d" }, -- < 1k as 974
        }
        for i = 1, #shorts do
            shorts[i][4] = shorts[i][3] .. " (%.0f%%)"
        end
        
        hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", function(statusBar, textString, value, valueMin, valueMax)
            if value == 0 then
                return textString:SetText("")
            end
            
            local style = GetCVar("statusTextDisplay")
            if style == "PERCENT" then
                return textString:SetFormattedText("%.0f%%", value / valueMax * 100)
            end
            for i = 1, #shorts do
                local t = shorts[i]
                if value >= t[1] then
                    if style == "BOTH" then
                        return textString:SetFormattedText(t[4], value / t[2], value / valueMax * 100)
                    else
                        if value < valueMax then
                            for j = 1, #shorts do
                                local v = shorts[j]
                                if valueMax >= v[1] then
                                    return textString:SetFormattedText(t[3] .. " / " .. v[3], value / t[2], valueMax / v[2])
                                end
                            end
                        end
                        return textString:SetFormattedText(t[3], value / t[2])
                    end
                end
            end
        end)
        
        --[[----------------------------
        Unit Font Color
        --------------------------------]]
        CUSTOM_FACTION_BAR_COLORS = {
            [1] = {r = 1, g = 0, b = 0},
            [2] = {r = 1, g = 0, b = 0},
            [3] = {r = 1, g = 1, b = 0},
            [4] = {r = 1, g = 1, b = 0},
            [5] = {r = 0, g = 1, b = 0},
            [6] = {r = 0, g = 1, b = 0},
            [7] = {r = 0, g = 1, b = 0},
            [8] = {r = 0, g = 1, b = 0},
        }
        
        hooksecurefunc("UnitFrame_Update", function(self, isParty)
            if not self.name --[[or not self:IsShown()--]] then return end
            
            -- local PET_COLOR = { r = 157/255, g = 197/255, b = 255/255 }
            local unit, color = self.unit
            if UnitPlayerControlled(unit) then
                if UnitIsPlayer(unit) then
                    color = RAID_CLASS_COLORS[select(2, UnitClass(unit))]
                else
                    color = PET_COLOR
                end
            elseif UnitIsDeadOrGhost(unit) or UnitIsTapped(unit) and not UnitIsTappedByPlayer(unit) then
                color = GRAY_FONT_COLOR
            else
                color = CUSTOM_FACTION_BAR_COLORS[UnitIsEnemy(unit, "player") and 1 or UnitReaction(unit, "player") or 5]
            end
            
            if not color then
                color = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)["PRIEST"]
            end
            
            self.name:SetTextColor(color.r, color.g, color.b)
            if isParty then
                self.name:SetText(GetUnitName(self.overrideName or unit))
            end
        end)
        
        --[[----------------------------
        Unit Name Background Color
        --------------------------------]]
        for _, region in pairs({
            TargetFrameNameBackground,
            FocusFrameNameBackground,
            Boss1TargetFrameNameBackground, 
            Boss2TargetFrameNameBackground, 
            Boss3TargetFrameNameBackground, 
            Boss4TargetFrameNameBackground,
            Boss5TargetFrameNameBackground, 
            
        }) do
            region:SetTexture(0, 0, 0, 0.5)
        end
        
        --[[----------------------------
        Class color HP Bars
        --------------------------------]]
        local function colour(statusbar, unit)
            if C.unitframe.classcolorhealth then
                local _, class, c
                if UnitIsPlayer(unit) and UnitIsConnected(unit) and unit == statusbar.unit and UnitClass(unit) then
                    _, class = UnitClass(unit)
                    c = CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[class] or RAID_CLASS_COLORS[class]
                    statusbar:SetStatusBarColor(c.r, c.g, c.b)
                end
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
        
        -- Class Portraits
        if C.unitframe.portraits then
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
        end
        
        --[[----------------------------
        Unit Name Font Siz
        --------------------------------]]
        for _, names in pairs({
            PlayerName,
            TargetFrameTextureFrameName,
            FocusFrameTextureFrameName,
        }) do
            names:SetFont(C.font.unitframes_font, C.font.unitframes_font_size)
        end
        
        --[[----------------------------
        Health / Mana Font - Size
        --------------------------------]]
        for _, names in pairs({
            PlayerFrameHealthBarText,
            PlayerFrameManaBarText,
            TargetFrameTextureFrameHealthBarText,
            TargetFrameTextureFrameManaBarText,
        }) do
            names:SetFont(C.font.unitframes_font, C.font.unitframes_font_size - 1, C.font.unitframes_font_style)
        end
        
        for _, names in pairs({
            PlayerLevelText,
            TargetFrameTextureFrameLevelText,
        }) do
            names:SetFont(C.font.unitframes_font, C.font.unitframes_font_size + 1, C.font.unitframes_font_style)
        end
        
        --[[----------------------------
        Unit Level Text Centering
        --------------------------------]]
        -- PlayerFrame
        hooksecurefunc("PlayerFrame_UpdateLevelTextAnchor", function(level)
            if ( level >= 100 ) then
                PlayerLevelText:SetPoint("CENTER", PlayerFrameTexture, "CENTER", -60.5, -15);
            else
                PlayerLevelText:SetPoint("CENTER", PlayerFrameTexture, "CENTER", -61, -15);
            end
        end)
        
        -- TargetFrame
        hooksecurefunc("TargetFrame_UpdateLevelTextAnchor", function(self, targetLevel)
            if ( targetLevel >= 100 ) then
                self.levelText:SetPoint("CENTER", 62, -15);
            else
                self.levelText:SetPoint("CENTER", 62, -15);
            end
        end)
        
        --[[----------------------------
        Move Unitframes
        --------------------------------]]
        PlayerFrame:ClearAllPoints()
        PlayerFrame:SetPoint("CENTER", -220, -150)
        PlayerFrame.SetPoint = function() end
        
        TargetFrame:ClearAllPoints()
        TargetFrame:SetPoint("CENTER", 220, -150)
        TargetFrame.SetPoint = function() end
        
        
        --[[----------------------------
        Castbar Tweaks
        --------------------------------]]
        -- Player Castbar
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
        
        --[[----------------------------
        Move and Scale Castbars
        --------------------------------]]
        CastingBarFrame:ClearAllPoints()
        CastingBarFrame:SetPoint("CENTER",UIParent,"CENTER", 0, -160)
        CastingBarFrame.SetPoint = function() end
        CastingBarFrame:SetScale(C.unitframe.cbscale)
        -- Player Castbar Icon
        CastingBarFrameIcon:Show()
        CastingBarFrameIcon:SetSize(30, 30)
        CastingBarFrameIcon:ClearAllPoints()
        CastingBarFrameIcon:SetPoint("CENTER", CastingBarFrame, "TOP", 0, 24)
        
        -- Target Castbar
        TargetFrameSpellBar:ClearAllPoints()
        TargetFrameSpellBar:SetPoint("CENTER", UIParent, "CENTER", 10, 150)
        TargetFrameSpellBar.SetPoint = function() end
        TargetFrameSpellBar:SetScale(C.unitframe.cbscale)
        
        --[[----------------------------
        Main Unit Frames Scaling
        --------------------------------]]
        for _, frames in pairs({
            PlayerFrame,
            TargetFrame,
            FocusFrame,
        }) do
            frames:SetScale(C.unitframe.scale)
        end
        
        --[[----------------------------
        Party Member Frame Scaling
        --------------------------------]]
        for i = 1, MAX_PARTY_MEMBERS do
            _G["PartyMemberFrame"..i]:SetScale(C.unitframe.partyscale)
        end
        
        --[[----------------------------
        Arena Frame Scaling
        --------------------------------]]
        local function ScaleArenaFrames()
            for i = 1, MAX_ARENA_ENEMIES do
                _G["ArenaPrepFrame"..i]:SetScale(C.unitframe.arenascale)
                _G["ArenaEnemyFrame"..i]:SetScale(C.unitframe.arenascale)
            end
        end
        
        if IsAddOnLoaded("Blizzard_ArenaUI") then
            ScaleArenaFrames()
        else
            local f = CreateFrame("Frame")
            f:RegisterEvent("ADDON_LOADED")
            f:SetScript("OnEvent", function(self, event, addon)
                if addon == "Blizzard_ArenaUI" then
                    self:UnregisterEvent(event)
                    ScaleArenaFrames()
                end
            end)
        end
        
        --[[----------------------------
        Boss Frames Scaling
        --------------------------------]]
        for i = 1, MAX_BOSS_FRAMES do
            _G["Boss"..i.."TargetFrame"]:SetScale(C.unitframe.bossscale)
        end
    end
end)

function SetFunctionsForward()
    hooksecurefunc("PlayerFrame_Update", RewriteUnitFrames)
    hooksecurefunc("TargetFrame_Update", RewriteUnitFrames)
end