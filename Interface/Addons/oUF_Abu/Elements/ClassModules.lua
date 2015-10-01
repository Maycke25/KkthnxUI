local _, ns = ...
ns.classModule = {}

function ns.classModule.DEATHKNIGHT(self, config, uconfig)
	if self.cUnit ~= "player" or not config.DEATHKNIGHT then return; end
	RuneFrame:SetParent(self)
	RuneFrame_OnLoad(RuneFrame)
	RuneFrame:ClearAllPoints()
	RuneFrame:SetPoint('TOP', self, 'BOTTOM', 32, -2)
	for i = 1, 6 do
		local b = _G['RuneButtonIndividual'..i.. 'Border']
		ns.PaintFrames(b:GetRegions())
	end
end

function ns.classModule.DRUID(self, config, uconfig)
	if self.cUnit ~= "player" or not config.DRUID then return; end
	-- Druid Manabar
	self.DruidMana = ns.CreateOutsideBar(self, false, 0, 0, 1)
	self.DruidMana.colorPower = true

	self.DruidMana.Value = ns.CreateFontString(self.DruidMana, 13, 'CENTER')
	self.DruidMana.Value:SetPoint('CENTER', self.DruidMana, 0, 0.5)
	self.DruidMana.Value:Hide()
	self:Tag(self.DruidMana.Value, '[druidmana]')

	-- Eclipsebar
	EclipseBarFrame:SetParent(self)
	EclipseBarFrame:SetScale(uconfig.scale * 0.82)
	EclipseBar_OnLoad(EclipseBarFrame)
	EclipseBarFrame:ClearAllPoints()
	EclipseBarFrame:SetPoint('TOP', self, 'BOTTOM', 30, 3)
	EclipseBarFrame:Show()
	EclipseBarFrame:GetRegions():SetVertexColor(0.8, 1, 1)

	local fs = EclipseBarFrame.PowerText
	fs.basesize = 10
	fs:SetFont(ns.config.fontNormal, (10 * config.fontNormalSize), config.fontNormalOutline)
	fs:SetShadowOffset(1, -1)
	table.insert(ns.fontstrings, fs)

	-- Druid mushrooms
	TotemFrame:ClearAllPoints()
	TotemFrame:SetParent(self)
	TotemFrame:SetScale(uconfig.scale * 0.75)

	for i = 1, 3 do
		local name = 'TotemFrameTotem'..i
		local totem = _G[name]
		local text = _G[name..'Duration']
		local cooldown = _G[name..'IconCooldown']

		text:ClearAllPoints()
		text:SetFont(config.fontNormal, 12, 'OUTLINE')
		text:SetDrawLayer('ARTWORK')
		text.basesize = 12
		text.ignoreOutline = true
		table.insert(ns.fontstrings, text)

		if ns.config.showShrooms then
			local _, someframe = totem:GetChildren()
			ns.PaintFrames(someframe:GetRegions())
			text:SetParent(cooldown)
			text:ClearAllPoints()
			text:SetPoint('CENTER', 1, 0)
		else
			totem:SetAlpha(0)
			cooldown.Show = function(self) self:Hide() end
			text:SetParent(TotemFrame)
			text:SetPoint('CENTER', -40 + (i-1) * 29 , 13)
		end
	end

	hooksecurefunc("TotemFrame_Update", function()
		local form  = GetShapeshiftFormID();
		TotemFrame:ClearAllPoints()
		if ( form == MOONKIN_FORM or not form ) then
			if ( GetSpecialization() == 1 ) then
				TotemFrame:SetPoint("TOPLEFT", self, "TOPLEFT", 79, -74);
			else
				TotemFrame:SetPoint("TOPLEFT", self, "BOTTOMLEFT", 50, 0);
			end
		elseif ( form == BEAR_FORM or form == CAT_FORM ) then
			TotemFrame:SetPoint("TOPLEFT", self, "TOPLEFT", 80, -58);
		else
			TotemFrame:SetPoint("TOPLEFT", self, "BOTTOMLEFT", 50, 0);
		end
	end)
end

function ns.classModule.MAGE(self, config, uconfig)
	if self.cUnit == "player" and config.showArcStacks then
		local AuraOrbs = {
			spellID = 36032, --114664
			filter = "HARMFUL",
			maxStacks = 4,
		}

		for i = 1, AuraOrbs.maxStacks do
			local orb = CreateFrame("Frame", nil, self, "oUF_AbuArcaneOrbsTemplate")
			orb:SetPoint("TOPLEFT", self, "BOTTOMLEFT", i*35, 3)
			orb.fill:SetVertexColor(1, .8, .8)

			orb.ShowOrb = function(self)
				if (self.AnimOut:IsPlaying()) then self.AnimOut:Stop(); end
				if (not self.AnimIn:IsPlaying()) then
					self.AnimIn:Play()
				end
			end
			orb.HideOrb = function(self)
				if (self.AnimIn:IsPlaying()) then self.AnimIn:Stop(); end
				if (not self.AnimOut:IsPlaying()) then
					self.AnimOut:Play()
				end
			end

			AuraOrbs[i] = orb;
		end

		AuraOrbs.Visibility = function(...)
			local spec = GetSpecialization()
			return (spec) and (spec == 1)
		end

		self.AuraOrbs = AuraOrbs
	end
end

function ns.classModule.MONK(self, config, uconfig)
	if self.cUnit ~= "player" or not config.MONK then return; end
	-- Orbs
	MonkHarmonyBar:SetParent(self)
	MonkHarmonyBar:SetScale(uconfig.scale * 0.81)
	MonkHarmonyBar_OnLoad(MonkHarmonyBar)
	MonkHarmonyBar:ClearAllPoints()
	MonkHarmonyBar:SetPoint('TOP', self, 'BOTTOM', 31, 18)
	ns.PaintFrames(select(2, MonkHarmonyBar:GetRegions()), 0.1)
	-- Stagger Bar
	MonkStaggerBar:SetParent(self)
	MonkStaggerBar:SetScale(uconfig.scale * .81)
	MonkStaggerBar_OnLoad(MonkStaggerBar)
	MonkStaggerBar:ClearAllPoints()
	MonkStaggerBar:SetPoint('TOP', self, 'BOTTOM', 31, -22)
	ns.PaintFrames(MonkStaggerBar.MonkBorder, 0.3)
	-- Mistweaver manabar
	PlayerFrameAlternateManaBar:SetParent(self)
	PlayerFrameAlternateManaBar:SetScale(uconfig.scale * .81)
	AlternatePowerBar_OnLoad(PlayerFrameAlternateManaBar)
	PlayerFrameAlternateManaBar:ClearAllPoints()
	PlayerFrameAlternateManaBar:SetPoint('TOP', self, 'BOTTOM', 31, -22)
	ns.PaintFrames(PlayerFrameAlternateManaBar.MonkBorder, 0.3)

	-- Stagger/Manabar movement
	hooksecurefunc("AlternatePowerBar_SetLook", function(self)
		local _, class = UnitClass("player")
		if ( class == "MONK" and (GetSpecialization() == SPEC_MONK_MISTWEAVER or GetSpecialization() == SPEC_MONK_BREWMASTER)) then
			self:ClearAllPoints()
			self:SetPoint('TOP', oUF_AbuPlayer, 'BOTTOM', 31, -22)
		end
	end)
end

function ns.classModule.PALADIN(self, config, uconfig)
	if self.cUnit == "player" and config.PALADIN then
		PaladinPowerBar:SetParent(self)
		PaladinPowerBar:SetScale(uconfig.scale * 0.81)
		PaladinPowerBar_OnLoad(PaladinPowerBar)
		PaladinPowerBar:ClearAllPoints()
		PaladinPowerBar:SetPoint('TOP', self, 'BOTTOM', 25, 2)
		ns.PaintFrames(PaladinPowerBarBG, 0.1)
	end
end

function ns.classModule.PRIEST(self, config, uconfig)
	if (self.IsMainFrame) then
		if self.cUnit == "player" and config.PRIEST  then
			PriestBarFrame:SetParent(self)
			PriestBarFrame_OnLoad(PriestBarFrame)
			PriestBarFrame:ClearAllPoints()
			PriestBarFrame:SetPoint('TOP', self, 'BOTTOM', 33, 1)
			ns.PaintFrames(PriestBarFrame:GetRegions())
		end
		-- Weakened Soul Bar
		if (config.showWeakenedSoul) then
			local Aurabar = ns.CreateOutsideBar(self, true, 1, 0, 0)
			Aurabar.spellID = 6788
			Aurabar.filter = "HARMFUL"
			self.Aurabar = Aurabar
		end
	end
end

function ns.classModule.ROGUE(self, config, uconfig)
	if self.cUnit == "player" and config.showSlicenDice then
		local Aurabar = ns.CreateOutsideBar(self, true, 1, .6, 0)
		Aurabar.spellID = 5171
		self.Aurabar = Aurabar
	end
end

function ns.classModule.SHAMAN(self, config, uconfig)
	if self.cUnit ~= "player" or not config.SHAMAN then return; end
	TotemFrame:ClearAllPoints()
	TotemFrame:SetPoint('TOP', self.Power, 'BOTTOM', -6, -0)
	TotemFrame:SetParent(self)
	TotemFrame:SetScale(uconfig.scale * 0.65)
	TotemFrame:Show()

	for i = 1, MAX_TOTEMS do
		local _, totemBorder = _G['TotemFrameTotem'..i]:GetChildren()
		ns.PaintFrames(totemBorder:GetRegions())

		_G['TotemFrameTotem'..i]:SetFrameStrata('LOW')
		_G['TotemFrameTotem'..i.. 'IconCooldown']:SetAlpha(0)
		_G['TotemFrameTotem'..i.. 'IconCooldown'].noCooldownCount = true -- No OmniCC

		_G['TotemFrameTotem'..i.. 'Duration']:SetParent(totemBorder)
		_G['TotemFrameTotem'..i.. 'Duration']:SetDrawLayer('OVERLAY')
		_G['TotemFrameTotem'..i.. 'Duration']:ClearAllPoints()
		_G['TotemFrameTotem'..i.. 'Duration']:SetPoint('BOTTOM', _G['TotemFrameTotem'..i], 0, 3)
		_G['TotemFrameTotem'..i.. 'Duration']:SetFont(config.fontNormal, 10, 'OUTLINE')
		_G['TotemFrameTotem'..i.. 'Duration']:SetShadowOffset(0, 0)
	end
end

function ns.classModule.WARLOCK(self, config, uconfig)
	if self.cUnit ~= "player" or not config.WARLOCK then return; end
	WarlockPowerFrame_OnLoad(WarlockPowerFrame)
	WarlockPowerFrame:SetParent(self)
	WarlockPowerFrame:ClearAllPoints()
	WarlockPowerFrame:SetPoint('TOP', self, 'BOTTOM', 30, -2)

	-- Affliction
	for i = 1, 4 do
		local shard = _G["ShardBarFrameShard"..i];
		ns.PaintFrames(select(5,shard:GetRegions()), .2)
	end

	-- Destruction
	ns.PaintFrames(BurningEmbersBarFrame.background, .3)
	for i = 1, 4 do
		local ember = BurningEmbersBarFrame["ember"..i];
		ns.PaintFrames(ember.border)
	end
end

function ns.classModule.WARRIOR(self, config, uconfig)
	if self.cUnit == "player" and config.showEnraged then
		local Aurabar = ns.CreateOutsideBar(self, true, 1, 0, 0)
		Aurabar.spellID = 12880

		Aurabar.Visibility = function(self, event, unit)
			local bar = self.Aurabar
			local index = GetSpecialization() or 0

			if (index == 2) then -- Enrage(fury)
				bar:SetStatusBarColor(1, 0, 0)
				bar.spellName, bar.rank = GetSpellInfo(12880)
			elseif (index == 1) then --Sweeping(arms)
				bar:SetStatusBarColor(1, .6, 0)
				bar.spellName, bar.rank = GetSpellInfo(12328)
			end
			return (index == 2 or index == 1)
		end

		self.Aurabar = Aurabar
	end
end

function ns.CreateComboPoints(self)
	local _, class = UnitClass('player')
	if self.cUnit == "target" then

		local points = CreateFrame("Frame", nil, self)
		points:SetPoint("BOTTOMLEFT", self.Portrait, "CENTER")
		points:SetSize(60, 60)

		local function getp(de)
		   local r = self.Portrait:GetSize()/1.67
		   return cos(de)*r, sin(de)*r
		end

		local anticipation = class == "ROGUE" and oUF_AbuPlayer.AuraOrbs

		for i = 1, MAX_COMBO_POINTS do
			local p = points:CreateTexture(nil, 'ARTWORK')
			p:SetTexture[[Interface\AddOns\oUF_Abu\Media\Frames\Combo]]
			p:SetTexCoord(0, .5, 0, 1)
			p:SetSize(20, 20)
			p:SetVertexColor(1, .35, .35)
			local x,y = getp(76 - (i*18))
			p:SetPoint("CENTER", points, "BOTTOMLEFT", x, y)

			local bg = points:CreateTexture(nil, 'BACKGROUND')
			bg:SetTexture[[Interface\AddOns\oUF_Abu\Media\Frames\Combo]]
			bg:SetTexCoord(.5, 1, 0, 1)
			bg:SetSize(22, 22)
			bg:SetPoint('CENTER', p, 0, -1)
			ns.PaintFrames(bg)
			p.bg = bg

			local f = points:CreateTexture(nil, 'OVERLAY')
			f:SetTexture[[Interface\ComboFrame\ComboPoint]]
			f:SetTexCoord(.5625, 1, 0, 1)
			f:SetSize(10, 12)
			f:SetPoint('CENTER', p, 1, 1)
			f:SetBlendMode("ADD")
			f:SetAlpha(0)
			p.flash = f

			p.anim = p.flash:CreateAnimationGroup()
			p.anim:SetToFinalAlpha(true)
			for i = 1, 2 do
				local a = p.anim:CreateAnimation('ALPHA')
				a:SetOrder(i)
				a:SetDuration(0.2)
				a:SetFromAlpha(i == 1 and 0 or 1)
				a:SetToAlpha(i == 1 and 1 or 0)
			end

			if (anticipation) then
				anticipation.maxStacks = MAX_COMBO_POINTS
				local ant =  points:CreateTexture(nil, 'OVERLAY', 1)
				ant:SetTexture[[Interface\AddOns\oUF_Abu\Media\Frames\Combo]]
				ant:SetTexCoord(0, .5, 0, 1)
				ant:SetBlendMode'ADD'
				ant:SetVertexColor(120/255, 100/255, 54/255)
				ant:SetPoint("CENTER", p, 0, 0)
				ant:SetSize(20,20)
				ant:Hide()

				ant._Show = ant.Show
				ant.Show = function(self)
					self:GetParent()[i].anim:Play()
					self:_Show()
				end
				anticipation[i] = ant
			end

			points[i] = p
		end

		local owl = self.Health:CreateTexture(nil, 'ARTWORK')
		owl:SetSize(55,55)
		owl:SetPoint('CENTER', self.Portrait)
		owl:SetTexture('Interface\\AddOns\\oUF_Abu\\Media\\Frames\\owlRotater')
		owl:SetBlendMode('BLEND')
		owl:SetAlpha(0)

		local rotate = owl:CreateAnimationGroup()
		rotate:SetLooping('REPEAT')
		local rotation = rotate:CreateAnimation('Rotation')
		rotation:SetDegrees(-49)
		rotation:SetDuration(1)
		local flashIn = rotate:CreateAnimation("ALPHA")
		flashIn:SetChange(.75)
		flashIn:SetDuration(.5)
		flashIn:SetEndDelay(.5)
		local flashOut = rotate:CreateAnimation("ALPHA")
		flashOut:SetChange(-.75)
		flashOut:SetDuration(.5)
		flashOut:SetStartDelay(.5)

		points.Override = function(self, event, unit)
			if unit == "pet" then return; end
			local points = self.CPoints
			local cp
			if(UnitHasVehicleUI'player') then
				cp = GetComboPoints('vehicle', 'target')
			else
				cp = GetComboPoints('player', 'target')
			end

			if (cp == MAX_COMBO_POINTS) then
				if (not rotate:IsPlaying()) then
					owl:SetAlpha(.25)
					rotate:Play()
				end
			elseif (rotate:IsPlaying()) then
				rotate:Stop()
				owl:SetAlpha(0)
			end	

			if (cp > 0) then
				if (not points:IsShown()) then
					points:Show()
					UIFrameFadeIn(points, .2)
				end

				for i = 1, MAX_COMBO_POINTS do
					local p = points[i]
					if (i <= cp) then
						if (p.isHidden) then
							p.anim:Play()
							p.isHidden = false
						end
						p:Show()
					elseif (not p.isHidden) then
						p.isHidden = true
						p:Hide()
					end
				end
			elseif (points:IsShown()) then
				points:Hide()
				points:SetAlpha(0)
			end
		end

		self.CPoints = points

	elseif (self.cUnit == "player" and class == "ROGUE") then
		-- Load it for player, its where the buff is, and player frame is created first
		local AuraOrbs = {
			spellID = 115189,
			filter = "HELPFUL",
			maxStacks = 0,
		}
		self.AuraOrbs = AuraOrbs
	end
end