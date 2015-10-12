local K, C, L, _ = unpack(select(2, ...))
if C.unitframe.enable ~= true then return end

local Unitframes = CreateFrame( "Frame", "KkthnxUF", UIParent );
local classFrame;
local classIcon;
local classIconBorder;

local PlayerAnchor = CreateFrame("Frame", "PlayerFrameAnchor", UIParent)
PlayerAnchor:SetSize(146, 28)
PlayerAnchor:SetPoint(unpack(C.position.playerframe))

local TargetAnchor = CreateFrame("Frame", "TargetFrameAnchor", UIParent)
TargetAnchor:SetSize(146, 28)
TargetAnchor:SetPoint(unpack(C.position.targetframe))

local PlayerCastbarAnchor = CreateFrame("Frame", "PlayerCastbarAnchor", UIParent)
PlayerCastbarAnchor:SetSize(CastingBarFrame:GetWidth() * C.unitframe.cbscale, CastingBarFrame:GetHeight() * 2)
PlayerCastbarAnchor:SetPoint(unpack(C.position.playercastbar))

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
	end
	
	for _, FrameBarText in pairs({
		PlayerFrameHealthBarText,
		PlayerFrameManaBarText,
		TargetFrameTextureFrameHealthBarText,
		TargetFrameTextureFrameManaBarText,
	}) do
		FrameBarText:SetFont(C.font.unitframes_font, C.font.unitframes_font_size - 1, C.font.unitframes_font_style)
	end
	
	for _, LevelText in pairs({
		PlayerLevelText,
		TargetFrameTextureFrameLevelText,
	}) do
		LevelText:SetFont(C.font.unitframes_font, C.font.unitframes_font_size + 1, C.font.unitframes_font_style)
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
	
	-- Tweak Party Frame
	--PartyMemberFrame1:ClearAllPoints();
	PartyMemberFrame1:SetScale( C.unitframe.partyscale );
	PartyMemberFrame2:SetScale( C.unitframe.partyscale );
	PartyMemberFrame3:SetScale( C.unitframe.partyscale );
	PartyMemberFrame4:SetScale( C.unitframe.partyscale );
	
	-- Tweak Player Frame
	PlayerFrame:SetMovable( true );
	PlayerFrame:ClearAllPoints();
	PlayerFrame:SetScale( C.unitframe.scale );
	PlayerFrame:SetPoint("CENTER", PlayerFrameAnchor, "CENTER", -51, 3);
	PlayerFrame:SetUserPlaced( true );
	PlayerFrame:SetMovable( false );
	
	-- Tweak Target Frame
	TargetFrame:SetMovable( true );
	TargetFrame:ClearAllPoints();
	TargetFrame:SetScale( C.unitframe.scale );
	TargetFrame:SetPoint("CENTER", TargetFrameAnchor, "CENTER", 51, 3);
	TargetFrame:SetUserPlaced( true );
	TargetFrame:SetMovable( false );
	TargetFrame.buffsOnTop = true;
	
	-- Tweak Focus Frame
	FocusFrame:SetMovable( true );
	FocusFrame:ClearAllPoints();
	FocusFrame:SetScale( C.unitframe.scale );
	FocusFrame:SetPoint( "TOPLEFT", 300, -200 );
	FocusFrame:SetUserPlaced( true );
	FocusFrame:SetMovable( false );
	
	-- Tweak Boss Frames
	for i = 1, 5 do -- Position
		local bossFrame = _G["Boss"..i.."TargetFrame"]
		bossFrame:SetParent( UIParent );
		bossFrame:SetScale( C.unitframe.bossscale );
		bossFrame:SetFrameStrata("BACKGROUND");
	end
	
	for i = 2, 5 do -- Spacing
		_G["Boss"..i.."TargetFrame"]:SetPoint("TOPLEFT", _G["Boss"..(i-1).."TargetFrame"], "BOTTOMLEFT", 0, --[[bossFrameSpacing]] 15)
	end	
	
	for i=1, 5 do
		_G["ArenaPrepFrame"..i]:SetScale( C.unitframe.arenascale ); 
	end
	ArenaEnemyFrames:SetScale( C.unitframe.arenascale );
end

local function MoveCastBar()
	-- Move Cast Bar
	CastingBarFrame:SetMovable(true);
	CastingBarFrame:ClearAllPoints();
	CastingBarFrame:SetScale( C.unitframe.cbscale );
	CastingBarFrame:SetPoint("CENTER", PlayerCastbarAnchor, "CENTER", 0, -3);
	CastingBarFrame:SetUserPlaced( true );
	CastingBarFrame:SetMovable( false );
	
	-- Player Castbar Icon
	CastingBarFrameIcon:Show();
	CastingBarFrameIcon:SetSize(30, 30);
	CastingBarFrameIcon:ClearAllPoints();
	CastingBarFrameIcon:SetPoint("CENTER", CastingBarFrame, "TOP", 0, 24);
	
	-- Target Castbar
	TargetFrameSpellBar:ClearAllPoints();
	TargetFrameSpellBar:SetPoint("CENTER", UIParent, "CENTER", 10, 150);
	TargetFrameSpellBar.SetPoint = K.Dummy;
	TargetFrameSpellBar:SetScale( C.unitframe.cbscale );
	
	-- Casting Timer
	CastingBarFrame.timer = CastingBarFrame:CreateFontString(nil);
	CastingBarFrame.timer:SetFont(C.font.basic_font, C.font.basic_font_size + 1, C.font.basic_font_style);
	CastingBarFrame.timer:SetPoint("TOP", CastingBarFrame, "BOTTOM", 0, 4);
	CastingBarFrame.updateDelay = 0.1;
end

local function UpdateClassIcon(class)
	if class == "WARRIOR" then
		classIcon:SetTexCoord( 0, .25, 0, .25 );
	elseif class == "MAGE" then
		classIcon:SetTexCoord( .25, .5,0, .25 );
	elseif class == "ROGUE" then
		classIcon:SetTexCoord( .5, .74,0, .25 );
	elseif class == "DRUID" then
		classIcon:SetTexCoord( .75, .98, 0, .25 );
	elseif class == "PALADIN" then
		classIcon:SetTexCoord( 0, .25, .5, .75 );
	elseif class == "DEATHKNIGHT" then
		classIcon:SetTexCoord( .25, .5, .5, .75);
	elseif class == "MONK" then
		classIcon:SetTexCoord( .5, .74, .5,.75);
	elseif class == "HUNTER" then
		classIcon:SetTexCoord( 0, .25, .25, .5 );
	elseif class == "SHAMAN" then
		classIcon:SetTexCoord( .25, .5, .25, .5 );
	elseif class == "PRIEST" then
		classIcon:SetTexCoord( .5, .74, .25, .5 );
	elseif class == "WARLOCK" then
		classIcon:SetTexCoord( .75, .98, .25, .5 );
	end
end

local function UF_HandleEvents( self, event, ... )
	
	if( event == "PLAYER_ENTERING_WORLD" ) then
		if( InCombatLockdown() == false ) then
			SetUnitFrames();
			MoveCastBar();
		end
	end
	
	if( event == "ADDON_LOADED" and ... == "KkthnxUI" )then
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
		
		if( event == "UNIT_FACTION" or event == "GROUP_ROSTER_UPDATE" or event == "PLAYER_FOCUS_CHANGED" or event == "UNIT_FACTION")then
			if( C.unitframe.classhealth == true ) then
				function colour(statusbar, unit)
					if UnitIsPlayer(unit) and UnitIsConnected(unit) and unit == statusbar.unit and UnitClass(unit) then
						local _, class = UnitClass(unit)
						local c = CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[class] or RAID_CLASS_COLORS[class]
						statusbar:SetStatusBarColor(c.r, c.g, c.b )
					end
				end
				
				hooksecurefunc("UnitFrameHealthBar_Update", colour)
				hooksecurefunc("HealthBar_OnValueChanged", function(self)
					colour(self, self.unit)
				end)
			end
		end
		
		-- Create Frames
		if( C.unitframe.classicon == true ) then
			classFrame = CreateFrame("Frame", "ClassFrame", TargetFrame );
			classFrame:SetPoint( "CENTER", C.unitframe.classiconx, C.unitframe.classicony);
			classFrame:SetSize( C.unitframe.classiconsize, C.unitframe.classiconsize );
			classIcon = classFrame:CreateTexture( "ClassIcon" );
			classIcon:SetPoint( "CENTER" );
			classIcon:SetSize( C.unitframe.classiconsize, C.unitframe.classiconsize );
			classIcon:SetTexture( "Interface\\TARGETINGFRAME\\UI-CLASSES-CIRCLES.BLP" );
			classIconBorder = classFrame:CreateTexture( "ClassIconBorder", "ARTWORK", nil, 1 );
			classIconBorder:SetPoint( "CENTER" , classIcon );
			classIconBorder:SetSize( C.unitframe.classiconsize * 2, C.unitframe.classiconsize * 2 );
			classIconBorder:SetTexture( "Interface\\UNITPOWERBARALT\\WowUI_Circular_Frame.blp" );
		end
	end
	
	if( event == "UNIT_EXITED_VEHICLE" or event == "UNIT_ENTERED_VEHICLE" ) then
		if( InCombatLockdown() == false )then
			if( UnitControllingVehicle("player") or UnitHasVehiclePlayerFrameUI("player") ) then
				SetUnitFrames();
			end
		end
	end
	
	if ( event == "PLAYER_TARGET_CHANGED" ) then
		if( C.unitframe.classicon == true ) then
			local target = select( 2, UnitClass("target") );
			UpdateClassIcon( target );
		end
	end
end

local function UF_Init()
	Unitframes:SetScript( "OnEvent", UF_HandleEvents );
	LoadAddOn("Blizzard_ArenaUI");
	
	Unitframes:RegisterEvent( "PLAYER_ENTERING_WORLD" );
	Unitframes:RegisterEvent( "ADDON_LOADED" );
	Unitframes:RegisterEvent( "PLAYER_TARGET_CHANGED" );
	Unitframes:RegisterEvent( "GROUP_ROSTER_UPDATE" );
	Unitframes:RegisterEvent( "UNIT_FACTION" );
	Unitframes:RegisterEvent( "PLAYER_FOCUS_CHANGED" );
	Unitframes:RegisterEvent( "UNIT_EXITED_VEHICLE" );
end

-- Remove Portrait Damage Spam
-- Reimplimentation of CombatFeedback_OnCombatEvent from CombatFeedback.lua
if( C.unitframe.combatfeedback == true ) then
	function CFeedback_OnCombatEvent(self, event, flags, amount, type)
		self.feedbackText:SetText(" ");
	end
end

-- Casting Bar Update
function CastingUpdate(self, elapsed)
	if( not self.timer ) then
		return;
	end
	if( self.updateDelay ) and (self.updateDelay < elapsed ) then
		if( self.casting ) then
			self.timer:SetText( format( "%2.1f / %1.1f", max( self.maxValue - self.value, 0), self.maxValue ));
		elseif( self.channeling ) then
			self.timer:SetText( format( "%.1f", max( self.value, 0 )));
		else
			self.timer:SetText("");
		end
		self.updateDelay = 0.1;
	else
		self.updateDelay = self.updateDelay - elapsed;
	end
end

do
	hooksecurefunc("CombatFeedback_OnCombatEvent", CFeedback_OnCombatEvent );
	hooksecurefunc("CastingBarFrame_OnUpdate", CastingUpdate);
end

-- Run Initialisation
UF_Init();