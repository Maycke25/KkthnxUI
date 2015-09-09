local K, C, L, _ = unpack(KkthnxUI)

local otf = ObjectiveTrackerFrame
local mb = ObjectiveTrackerBlocksFrame.QuestHeader

--[[-----------------------------------------------------------------------------
Hide header art & restyle text
-------------------------------------------------------------------------------]]
if C.misc.styleobjectivetracker then
	if IsAddOnLoaded("Blizzard_ObjectiveTracker") then
		hooksecurefunc("ObjectiveTracker_Update", function(reason, id)
			local otf = ObjectiveTrackerFrame
			if otf.MODULES then
				for i = 1, #otf.MODULES do
					otf.MODULES[i].Header.Background:SetAtlas(nil)
					otf.MODULES[i].Header.Text:SetFont(STANDARD_TEXT_FONT, 15)
					otf.MODULES[i].Header.Text:ClearAllPoints()
					otf.MODULES[i].Header.Text:SetPoint("RIGHT", otf.MODULES[i].Header, -62, 0)
					otf.MODULES[i].Header.Text:SetJustifyH("LEFT")
				end
			end
		end)
	end
	
	--[[-----------------------------------------------------------------------------
	Dashes to dots
	-------------------------------------------------------------------------------]]
	hooksecurefunc(DEFAULT_OBJECTIVE_TRACKER_MODULE, "AddObjective", function(self, block, objectiveKey, _, lineType)
		local line = self:GetLine(block, objectiveKey, lineType)
		if line.Dash and line.Dash:IsShown() then line.Dash:SetText(":: ") end
	end)
	
	--[[-----------------------------------------------------------------------------
	Timer bars skinning
	-------------------------------------------------------------------------------]]
	hooksecurefunc(DEFAULT_OBJECTIVE_TRACKER_MODULE, "AddTimerBar", function(self, block, line, duration, startTime)
		local tb = self.usedTimerBars[block] and self.usedTimerBars[block][line]
		if tb and tb:IsShown() and not tb.skinned then
			tb.Bar:SetStatusBarTexture(C.media.texture)
			tb.Bar:SetStatusBarColor(255/255, 108/255, 0/255)
			tb.skinned = true
		end
	end)
	
	--[[-----------------------------------------------------------------------------
	Skinning scenario buttons
	-------------------------------------------------------------------------------]]
	local function SkinScenarioButtons()
		local block = ScenarioStageBlock
		local _, currentStage, numStages, flags = C_Scenario.GetInfo()
		local inChallengeMode = C_Scenario.IsChallengeMode()
		
		block:StripTextures()
		block.NormalBG:SetSize(otf:GetWidth(), 50)
		block.FinalBG:ClearAllPoints()
		block.FinalBG:SetPoint("TOPLEFT", block.NormalBG, 6, -6)
		block.FinalBG:SetPoint("BOTTOMRIGHT", block.NormalBG, -6, 6)
		block.GlowTexture:SetSize(otf:GetWidth(), 50)
	end
	
	--[[-----------------------------------------------------------------------------
	Skinning proving grounds
	-------------------------------------------------------------------------------]]
	local function SkinProvingGroundButtons()
		local block = ScenarioProvingGroundsBlock
		local sb = block.StatusBar
		local anim = ScenarioProvingGroundsBlockAnim
		
		block:StripTextures()
		block.MedalIcon:SetSize(32, 32)
		block.MedalIcon:ClearAllPoints()
		block.MedalIcon:SetPoint("TOPLEFT", block, 20, -10)
		
		block.WaveLabel:ClearAllPoints()
		block.WaveLabel:SetPoint("LEFT", block.MedalIcon, "RIGHT", 3, 0)
		
		block.BG:SetSize(otf:GetWidth(), 50)
		
		block.GoldCurlies:ClearAllPoints()
		block.GoldCurlies:SetPoint("TOPLEFT", block.BG, 6, -6)
		block.GoldCurlies:SetPoint("BOTTOMRIGHT", block.BG, -6, 6)
		
		anim.BGAnim:SetSize(otf:GetWidth(), 50)
		anim.BorderAnim:SetSize(otf:GetWidth(), 50)
		anim.BorderAnim:ClearAllPoints()
		anim.BorderAnim:SetPoint("TOPLEFT", block.BG, 8, -8)
		anim.BorderAnim:SetPoint("BOTTOMRIGHT", block.BG, -8, 8)
		
		sb:SetStatusBarTexture(C.media.texture)
		sb:SetStatusBarColor(0/255, 155/255, 90/255)
		sb:ClearAllPoints()
		sb:SetPoint("TOPLEFT", block.MedalIcon, "BOTTOMLEFT", -4, -5)
	end
end

--[[-----------------------------------------------------------------------------
Move the oTF with Shift + left-click
-------------------------------------------------------------------------------]]
if C.misc.moveobjectivetracker then
	fs = function(parent, layer, font, fontsiz, outline, r, g, b, justify)
		local string = parent:CreateFontString(nil, layer)
		string:SetFont(font, fontsiz, outline)
		string:SetShadowOffset(cfg.shadowoffsetX, cfg.shadowoffsetY)
		string:SetTextColor(r, g, b)
		if justify then
			string:SetJustifyH(justify)
		end
		return string
	end

	otf:SetHeight(tonumber(string.match(({GetScreenResolutions()})[GetCurrentResolution()], "%d+x(%d+)")) / 1.6)
	otf.ClearAllPoints = function() end
	otf:SetClampedToScreen(true)
	otf:SetMovable(true)
	otf:SetUserPlaced(true)
	otf.SetPoint = function() end
	
	mb:EnableMouse(true)
	mb:RegisterForDrag('LeftButton')
	mb:SetHitRectInsets(-15, 0, -5, -5)
	mb:SetScript('OnDragStart', function(self)
		if (IsShiftKeyDown()) then
			otf:StartMoving()
		end
	end)
	
	mb:SetScript('OnDragStop', function(self)
		otf:StopMovingOrSizing()
	end)
	
	mb:SetScript('OnEnter', function()
		if (not InCombatLockdown()) then
			GameTooltip:SetOwner(mb, 'ANCHOR_TOPLEFT', 0, 10)
			GameTooltip:ClearLines()
			GameTooltip:AddLine('Shift + left-click to Drag')
			GameTooltip:Show()
		end
	end)
	
	mb:SetScript('OnLeave', function()
		GameTooltip:Hide()
	end)
end