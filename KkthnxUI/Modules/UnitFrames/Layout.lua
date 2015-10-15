local K, C, L, _ = unpack(select(2, ...))
if C.unitframe.enable ~= true then return end

local Unitframes = CreateFrame( "Frame", "KkthnxUF", UIParent )

local PlayerAnchor = CreateFrame("Frame", "PlayerFrameAnchor", UIParent)
PlayerAnchor:SetSize(146, 28)
PlayerAnchor:SetPoint(unpack(C.position.playerframe))

local TargetAnchor = CreateFrame("Frame", "TargetFrameAnchor", UIParent)
TargetAnchor:SetSize(146, 28)
TargetAnchor:SetPoint(unpack(C.position.targetframe))

local PlayerCastbarAnchor = CreateFrame("Frame", "PlayerCastbarAnchor", UIParent)
PlayerCastbarAnchor:SetSize(CastingBarFrame:GetWidth() * C.unitframe.cbscale, CastingBarFrame:GetHeight() * 2)
PlayerCastbarAnchor:SetPoint(unpack(C.position.playercastbar))

-- Delete some lines from unit dropdown menu (prevent errors)
for _, menu in pairs(UnitPopupMenus) do
	for index = #menu, 1, -1 do
		if menu[index] == "SET_FOCUS" or menu[index] == "CLEAR_FOCUS" or menu[index] == "MOVE_PLAYER_FRAME" or menu[index] == "MOVE_TARGET_FRAME" or menu[index] == "LARGE_FOCUS" or menu[index] == "MOVE_FOCUS_FRAME" or (menu[index] == "PET_DISMISS" and K.Class == "HUNTER") then
			table.remove(menu, index)
		end
	end
end

local function SetUnitFrames()
	
	-- Unit Name Background
	for _, NameBG in pairs({
		TargetFrameNameBackground,
		FocusFrameNameBackground,
		Boss1TargetFrameNameBackground, 
		Boss2TargetFrameNameBackground, 
		Boss3TargetFrameNameBackground, 
		Boss4TargetFrameNameBackground,
		Boss5TargetFrameNameBackground, 
		
	}) do
		NameBG:SetTexture(0, 0, 0, 0.5)
	end
	
	for _, Names in pairs({
		PlayerName,
		TargetFrameTextureFrameName,
		FocusFrameTextureFrameName,
		PetName,
	}) do
		Names:SetFont(C.font.unitframes_font, C.font.unitframes_font_size - 1)
		Names:SetShadowOffset(0.75, -0.75)
	end
	
	for _, FrameBarText in pairs({
		PlayerFrameHealthBarText,
		PlayerFrameManaBarText,
		TargetFrameTextureFrameHealthBarText,
		TargetFrameTextureFrameManaBarText,
		PetFrameHealthBarText,
		PetFrameManaBarText,
	}) do
		FrameBarText:SetFont(C.font.unitframes_font, C.font.unitframes_font_size - 2)
		FrameBarText:SetShadowOffset(0.75, -0.75)
	end
	
	for _, LevelText in pairs({
		PlayerLevelText,
		TargetFrameTextureFrameLevelText,
	}) do
		LevelText:SetFont(C.font.unitframes_font, C.font.unitframes_font_size + 1)
		LevelText:SetShadowOffset(1.25, -1.25)
	end
	
	-- Tweak Party Frame
	--PartyMemberFrame1:ClearAllPoints()
	PartyMemberFrame1:SetScale( C.unitframe.partyscale )
	PartyMemberFrame2:SetScale( C.unitframe.partyscale )
	PartyMemberFrame3:SetScale( C.unitframe.partyscale )
	PartyMemberFrame4:SetScale( C.unitframe.partyscale )
	
	-- Tweak Player Frame
	PlayerFrame:SetMovable( true )
	PlayerFrame:ClearAllPoints()
	PlayerFrame:SetScale( C.unitframe.scale )
	PlayerFrame:SetPoint("CENTER", PlayerFrameAnchor, "CENTER", -51, 3)
	PlayerFrame:SetUserPlaced( true )
	PlayerFrame:SetMovable( false )
	
	-- Tweak Target Frame
	TargetFrame:SetMovable( true )
	TargetFrame:ClearAllPoints()
	TargetFrame:SetScale( C.unitframe.scale )
	TargetFrame:SetPoint("CENTER", TargetFrameAnchor, "CENTER", 51, 3)
	TargetFrame:SetUserPlaced( true )
	TargetFrame:SetMovable( false )
	--TargetFrame.buffsOnTop = true;
	
	-- Tweak Focus Frame
	FocusFrame:SetMovable( true )
	FocusFrame:ClearAllPoints()
	FocusFrame:SetScale( C.unitframe.scale )
	FocusFrame:SetPoint( "TOPLEFT", 300, -200 )
	FocusFrame:SetUserPlaced( true )
	FocusFrame:SetMovable( false )
	
	-- Tweak Boss Frames
	for i = 1, 5 do -- Position
		local bossFrame = _G["Boss"..i.."TargetFrame"]
		bossFrame:SetParent( UIParent )
		bossFrame:SetScale( C.unitframe.bossscale )
		bossFrame:SetFrameStrata("BACKGROUND")
	end
	
	for i = 2, 5 do -- Spacing
		_G["Boss"..i.."TargetFrame"]:SetPoint("TOPLEFT", _G["Boss"..(i-1).."TargetFrame"], "BOTTOMLEFT", 0, --[[bossFrameSpacing]] 15)
	end	
	
	for i=1, 5 do
		_G["ArenaPrepFrame"..i]:SetScale( C.unitframe.arenascale ) 
	end
	ArenaEnemyFrames:SetScale( C.unitframe.arenascale )
end

local function MoveCastBar()
	-- Move Cast Bar
	CastingBarFrame:SetMovable(true)
	CastingBarFrame:ClearAllPoints()
	CastingBarFrame:SetScale( C.unitframe.cbscale )
	CastingBarFrame:SetPoint("CENTER", PlayerCastbarAnchor, "CENTER", 0, -3)
	CastingBarFrame:SetUserPlaced( true )
	CastingBarFrame:SetMovable( false )
	
	-- Player Castbar Icon
	CastingBarFrameIcon:Show()
	CastingBarFrameIcon:SetSize(30, 30)
	CastingBarFrameIcon:ClearAllPoints()
	CastingBarFrameIcon:SetPoint("CENTER", CastingBarFrame, "TOP", 0, 24)
	
	-- Target Castbar
	TargetFrameSpellBar:ClearAllPoints()
	TargetFrameSpellBar:SetPoint("CENTER", UIParent, "CENTER", 10, 150)
	TargetFrameSpellBar.SetPoint = K.Dummy;
	TargetFrameSpellBar:SetScale( C.unitframe.cbscale )
	
	-- Casting Timer
	CastingBarFrame.timer = CastingBarFrame:CreateFontString(nil)
	CastingBarFrame.timer:SetFont(C.font.basic_font, C.font.basic_font_size + 1)
	CastingBarFrame.timer:SetShadowOffset(1, -1)
	CastingBarFrame.timer:SetPoint("TOP", CastingBarFrame, "BOTTOM", 0, -3)
	CastingBarFrame.updateDelay = 0.1;
end

local function UF_HandleEvents( self, event, ... )
	
	if( event == "PLAYER_ENTERING_WORLD" ) then
		if( InCombatLockdown() == false ) then
			SetUnitFrames()
			MoveCastBar()
		end
	end
	
	if( event == "ADDON_LOADED" and ... == "KkthnxUI" )then
		-- Unit Font Style
	if( C.unitframe.formattext == true ) then
		hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", function()
			PlayerFrameHealthBar.TextString:SetText(AbbreviateLargeNumbers(UnitHealth("player")))
			PlayerFrameManaBar.TextString:SetText(AbbreviateLargeNumbers(UnitMana("player")))
			
			TargetFrameHealthBar.TextString:SetText(AbbreviateLargeNumbers(UnitHealth("target")))
			TargetFrameManaBar.TextString:SetText(AbbreviateLargeNumbers(UnitMana("target")))
			
			FocusFrameHealthBar.TextString:SetText(AbbreviateLargeNumbers(UnitHealth("focus")))
			FocusFrameManaBar.TextString:SetText(AbbreviateLargeNumbers(UnitMana("focus")))
		end)
	end
		
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
		
		if ( C.unitframe.classhealth == true ) then
			local UnitIsPlayer, UnitIsConnected, UnitClass, RAID_CLASS_COLORS =
			UnitIsPlayer, UnitIsConnected, UnitClass, RAID_CLASS_COLORS
			local _, class, c
			
			local function colour(statusbar, unit)
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
		end
		
		hooksecurefunc("UnitFramePortrait_Update", function(self)
			if( C.unitframe.classicon == true ) then
				if self.portrait then
					if UnitIsPlayer(self.unit) then 
						local t = CLASS_ICON_TCOORDS[select(2, UnitClass(self.unit))]
						if t then
							self.portrait:SetTexture("Interface\\TargetingFrame\\UI-Classes-Circles")
							self.portrait:SetTexCoord(unpack(t))
						end
					else
						self.portrait:SetTexCoord(0, 1, 0, 1)
					end
				end
			end
		end)
	end
	
	if( event == "UNIT_EXITED_VEHICLE" or event == "UNIT_ENTERED_VEHICLE" ) then
		if( InCombatLockdown() == false )then
			if( UnitControllingVehicle("player") or UnitHasVehiclePlayerFrameUI("player") ) then
				SetUnitFrames()
			end
		end
	end
end

local function UF_Init()
	Unitframes:SetScript( "OnEvent", UF_HandleEvents )
	LoadAddOn("Blizzard_ArenaUI")
	
	Unitframes:RegisterEvent( "PLAYER_ENTERING_WORLD" )
	Unitframes:RegisterEvent( "ADDON_LOADED" )
	Unitframes:RegisterEvent( "UNIT_EXITED_VEHICLE" )
end

-- Remove Portrait Damage Spam
if( C.unitframe.combatfeedback == true ) then
	PlayerHitIndicator:SetText(nil)
	PlayerHitIndicator.SetText = K.Dummy
end

-- Remove Group Number Frame
if( C.unitframe.groupnumber == true ) then
PlayerFrameGroupIndicator.Show = K.Dummy
end

-- Casting Bar Update
function CastingUpdate(self, elapsed)
	if( not self.timer ) then
		return;
	end
	if( self.updateDelay ) and (self.updateDelay < elapsed ) then
		if( self.casting ) then
			self.timer:SetText( format( "%2.1f / %1.1f", max( self.maxValue - self.value, 0), self.maxValue ))
		elseif( self.channeling ) then
			self.timer:SetText( format( "%.1f", max( self.value, 0 )))
		else
			self.timer:SetText("")
		end
		self.updateDelay = 0.1;
	else
		self.updateDelay = self.updateDelay - elapsed;
	end
end

do
	hooksecurefunc("CastingBarFrame_OnUpdate", CastingUpdate)
end

-- Run Initialisation
UF_Init()