local K, C, L, _ = unpack(select(2, ...))
if C.unitframe.enable ~= true then return end

local PlayerAnchor = CreateFrame("Frame", "PlayerFrameAnchor", UIParent)
PlayerAnchor:SetSize(146, 28)
PlayerAnchor:SetPoint(unpack(C.position.playerframe))

local TargetAnchor = CreateFrame("Frame", "TargetFrameAnchor", UIParent)
TargetAnchor:SetSize(146, 28)
TargetAnchor:SetPoint(unpack(C.position.targetframe))

local PlayerCastbarAnchor = CreateFrame("Frame", "PlayerCastbarAnchor", UIParent)
PlayerCastbarAnchor:SetSize(CastingBarFrame:GetWidth() * C.unitframe.cbscale, CastingBarFrame:GetHeight() * 2)
PlayerCastbarAnchor:SetPoint(unpack(C.position.playercastbar))

local Unitframes = CreateFrame("Frame")
Unitframes:RegisterEvent("ADDON_LOADED")
Unitframes:SetScript("OnEvent", function(self, event, arg1)
	if event == "ADDON_LOADED" and arg1 == "KkthnxUI" then
		
		-- Unit Font Style
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
		
		-- Unit Font Color
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
			if not self.name or not self:IsShown() then return end
			
			local PET_COLOR = { r = 157/255, g = 197/255, b = 255/255 }
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
		
		-- Unit Name Background
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
		
		for _, names in pairs({
			PlayerName,
			TargetFrameTextureFrameName,
			FocusFrameTextureFrameName,
			PetName,
		}) do
			names:SetFont(C.font.unitframes_font, C.font.unitframes_font_size - 1)
		end
		
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
		
		-- Unit Text
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
		
		-- Move Frames
		-- Player Frame
		PlayerFrame:SetUserPlaced(true)
		PlayerFrame:SetDontSavePosition(true)
		PlayerFrame:ClearAllPoints()
		PlayerFrame:SetPoint("CENTER", PlayerFrameAnchor, "CENTER", -51, 3)
		PlayerFrame.SetPoint = K.Dummy
		PlayerFrame:SetScale(C.unitframe.scale)
		-- Target Frame
		TargetFrame:SetUserPlaced(true)
		TargetFrame:SetDontSavePosition(true)
		TargetFrame:ClearAllPoints()
		TargetFrame:SetPoint("CENTER", TargetFrameAnchor, "CENTER", 51, 3)
		TargetFrame.SetPoint = K.Dummy
		TargetFrame:SetScale(C.unitframe.scale)
		
		-- Castbars
		-- Player Castbar
		CastingBarFrame:ClearAllPoints()
		CastingBarFrame:SetPoint("CENTER", PlayerCastbarAnchor, "CENTER", 0, -3)
		CastingBarFrame.SetPoint = K.Dummy
		CastingBarFrame:SetScale(C.unitframe.cbscale)
		-- Player Castbar Icon
		CastingBarFrameIcon:Show()
		CastingBarFrameIcon:SetSize(30, 30)
		CastingBarFrameIcon:ClearAllPoints()
		CastingBarFrameIcon:SetPoint("CENTER", CastingBarFrame, "TOP", 0, 24)
		
		-- Target Castbar
		TargetFrameSpellBar:ClearAllPoints()
		TargetFrameSpellBar:SetPoint("CENTER", UIParent, "CENTER", 10, 150)
		TargetFrameSpellBar.SetPoint = K.Dummy
		TargetFrameSpellBar:SetScale(C.unitframe.cbscale)
		
		-- Main Unitframes
		for _, frames in pairs({
			PlayerFrame,
			TargetFrame,
			FocusFrame,
		}) do
			frames:SetScale(C.unitframe.scale)
		end
		
		-- Party Frame
		for i = 1, MAX_PARTY_MEMBERS do
			_G["PartyMemberFrame"..i]:SetScale(C.unitframe.partyscale)
		end		
		
		-- Arena Frame
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
		
		-- Boss Frame
		for i = 1, MAX_BOSS_FRAMES do
			_G["Boss"..i.."TargetFrame"]:SetScale(C.unitframe.bossscale)
		end
	end
end)