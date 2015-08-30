--[[	reskinning for nameplates

------------------]]

local _G = _G
local update = 0
local interval = 1.0
local maxPlateDebuffs = 4
local GUIDList = {}

local function SmoothBar(statusBar,value)
	local limit = 30/GetFramerate()
	local old = statusBar:GetValue()
	local new = old + math.min((value-old)/6, math.max(value-old, limit))
	if new ~= new then
		new = value
	end
	if old == value or abs(new - value) < 0 then
		statusBar:SetValue(value)
	else
		statusBar:SetValue(new)
	end
end

local function GetHealthBarColor(ref,healthBar)
	local r,g,b = healthBar:GetStatusBarColor()
	local class;
	
	if ref.GUID then
		class = select(2, GetPlayerInfoByGUID(ref.GUID))
	end
	
	if class then
		local classColor = KKTHNXUI_CLASS_COLORS[class]
		r,g,b = classColor.r, classColor.g, classColor.b
	else
		if r == 0 and g == 0 and b >= 0.8 then
			r,g,b = 0.2,0.5,1.0
		elseif r >= 0.8 and g == 0 and b == 0 then
			r,g,b = 1.0,0.1,0.1
		end
	end
	
	return r,g,b
end

local function RepositionNamePlates()
	KkthnxUI_PlateFrame:Hide()
	for ref, plate in pairs(KkthnxUI_PlateFrame.list) do
		plate:Hide()
		if ref:IsShown() then
			plate:SetPoint("CENTER", WorldFrame, "BOTTOMLEFT", ref:GetCenter())
			plate:SetAlpha(ref:GetAlpha())
			plate:Show()
		end
	end
	KkthnxUI_PlateFrame:Show()
end

local function SearchNamePlates(self,elapsed)
	RepositionNamePlates()
	
	update = update + elapsed
	
	if update > interval then
		for _, obj in pairs({self:GetChildren()}) do
			local name = obj:GetName()
			if name and name:find("NamePlate") and not obj.isInit then
				KkthnxUI_NamePlate_OnInit(obj)
			end
		end
		
		update = 0
	end
end

local function UpdateGUID(ref)
	local uTarget, uMouseover
	
	if UnitGUID("target") and UnitExists("target") and not UnitIsUnit("target","player") and not UnitIsDead("target") then
		uTarget = true
	end
	
	if UnitGUID("mouseover") and UnitExists("mouseover") and not UnitIsUnit("mouseover","player") and not UnitIsDead("mouseover") then
		uMouseover = true
	end
	
	if uTarget and ref:GetAlpha() == 1 then
		ref.GUID = UnitGUID("target")
		ref.unit = "target"
	elseif uMouseover and ref.highlight:IsShown() and UnitGUID("mouseover") and UnitExists("mouseover") then
		ref.GUID = UnitGUID("mouseover")
		ref.unit = "mouseover"
	else
		ref.unit = nil
	end
	
	if ref.GUID and not GUIDList[ref.GUID] then
		GUIDList[ref.GUID] = {}
		
		for index = 1, maxPlateDebuffs do
			GUIDList[ref.GUID]["Debuff"..index] = {}
		end
	end
end


function KkthnxUI_NamePlates_Load()
	local isDisabled;
	
	if IsAddOnLoaded("TidyPlates") then
		print("|cFF00FF99Sync|rPlates: Disabled while using |cFF00FF99TidyPlates")
		
		isDisabled = true
	end
	
	if IsAddOnLoaded("Kui_Nameplates") then
		print("|cFF00FF99Sync|rPlates: Disabled while using |cFF00FF99KuiNameplates")
		
		isDisabled = true
	end
	
	if isDisabled then return end
	
	WorldFrame:HookScript("OnUpdate", SearchNamePlates)
	SetCVar("bloatnameplates",0)
	SetCVar("bloatthreat",0)
	SetCVar("bloattest",0)
end

function KkthnxUI_NamePlate_OnInit(ref)
	if ref.isInit then return end
	
	-- get reference stuff
	ref.barFrame, ref.nameFrame = ref:GetChildren()
	ref.healthbar, ref.castbar = ref.barFrame:GetChildren()
	ref.threat, ref.border, ref.highlight, ref.level, ref.boss, ref.raid, ref.dragon = ref.barFrame:GetRegions()
	ref.name = ref.nameFrame:GetRegions()
	ref.healthbar.texture = ref.healthbar:GetRegions()
	ref.castbar.texture, ref.castbar.border, ref.castbar.shield, ref.castbar.icon, ref.castbar.name, ref.castbar.nameShadow = ref.castbar:GetRegions()
	ref.castbar.icon.layer, ref.castbar.icon.sublevel = ref.castbar.icon:GetDrawLayer()
	ref.isInit = true
	ref.unit = nil
	ref.GUID = nil
	
	-- hide textures
	ref.barFrame:SetAlpha(0)
	ref.nameFrame:SetAlpha(0)
	
	-- create new NamePlate
	KkthnxUI_PlateFrame.list[ref] = CreateFrame("Frame","New"..ref:GetName(),KkthnxUI_PlateFrame,"KkthnxUI_NamePlateTemplate")
	local plate = KkthnxUI_PlateFrame.list[ref]
	plate:SetFrameStrata("BACKGROUND")
	plate:SetFrameLevel(ref:GetFrameLevel())
	plate:SetScript("OnUpdate",function() KkthnxUI_NamePlate_OnUpdate(plate,ref) end)
	
	-- reanchor raidmark
	ref.raid:SetParent(plate.ArtFrame)
	ref.raid:SetSize(15,15)
	ref.raid:ClearAllPoints()
	ref.raid:SetPoint("TOPLEFT",plate)
	
	ref:HookScript("OnShow",function() KkthnxUI_NamePlate_OnShow(plate,ref) end)
	ref:HookScript("OnHide",function() KkthnxUI_NamePlate_OnHide(plate,ref) end)
	
	KkthnxUI_NamePlate_OnShow(plate,ref)
end

function KkthnxUI_NamePlate_OnShow(self,ref)
	local name = ref.name:GetText()
	local level = ref.level:GetText()
	local healthBar = ref.healthbar
	local r,g,b = GetHealthBarColor(ref,healthBar)
	
	self.Name:SetText(name)
	self.HealthBar:SetStatusBarColor(r,g,b)
	
	if ref.boss:IsShown() then 
		self.Level:SetText("")
		self.Boss:Show()
	else
		self.Level:SetText(level)
		self.Level:SetVertexColor(KkthnxUI_GetEffectiveLevelColor(level))
		self.Boss:Hide()
	end
end

function KkthnxUI_NamePlate_OnHide(self,ref)
	ref.GUID = nil
	
	--[[
	if GUIDList[ref.GUID] then
		GUIDList[ref.GUID] = nil
	end
	--]]
	
	for index = 1, maxPlateDebuffs do
		_G[self:GetName().."Debuff"..index]:Hide()
	end
end

function KkthnxUI_NamePlate_OnUpdate(self,ref)
	local healthBar = ref.healthbar
	local castBar = ref.castbar
	local maxHealth = select(2, healthBar:GetMinMaxValues())
	local health = healthBar:GetValue()
	local perc = math.ceil(health*100/maxHealth)
	
	-- healthBar
	self.HealthBar:SetStatusBarColor(GetHealthBarColor(ref,healthBar))
	self.HealthBar:SetMinMaxValues(0,maxHealth)
	self.Health:SetText(perc.."%")
	SmoothBar(self.HealthBar,health)
	
	-- alpha fix
	if ref:GetAlpha() < 1 then
		self.HealthBar:SetAlpha(0.35)
		self.CastingBar.StatusBar:SetAlpha(0.35)
	else
		self.HealthBar:SetAlpha(1)
		self.CastingBar.StatusBar:SetAlpha(1)
	end
	
	-- elite
	if ref.dragon:IsShown() then
	--	self.Elite:Show()
	--else
		self.Elite:Hide()
	end
	
	-- 	castingBar
	if castBar:IsShown() then
		self.CastingBar:Show()
		self.CastingBar.Icon:SetTexture(castBar.icon:GetTexture())
		self.CastingBar.Name:SetText(castBar.name:GetText())
		self.CastingBar.StatusBar:SetStatusBarColor(castBar:GetStatusBarColor())
		self.CastingBar.StatusBar:SetMinMaxValues(castBar:GetMinMaxValues())
		self.CastingBar.StatusBar:SetValue(castBar:GetValue())
	else
		self.CastingBar:Hide()
	end
	
	UpdateGUID(ref)
	KkthnxUI_NamePlateAura_OnInit(self,ref)
	KkthnxUI_NamePlateAura_OnUpdate(self,ref)
end

function KkthnxUI_NamePlateAura_OnInit(self,ref)
	if ref.unit then
		for index = 1, maxPlateDebuffs do
			local debuff = _G[self:GetName().."Debuff"..index]
			local name,_,icon,count,debuffType,duration,expirationTime,unitCaster = UnitDebuff(ref.unit,index,"PLAYER")
			
			if name and (unitCaster == "player" or unitCaster == "pet") then
				GUIDList[ref.GUID]["Debuff"..index]["Expiration"] = expirationTime
				GUIDList[ref.GUID]["Debuff"..index]["Icon"] = icon
			else
				GUIDList[ref.GUID]["Debuff"..index]["Expiration"] = 0
				GUIDList[ref.GUID]["Debuff"..index]["Icon"] = ""
			end
		end
	end
end

function KkthnxUI_NamePlateAura_OnUpdate(self,ref)
	local plate = self:GetName()
	for guid in pairs(GUIDList) do
		if ref.GUID == guid then
			for index = 1, maxPlateDebuffs do
				local debuff = _G[plate.."Debuff"..index]
				local expire = GUIDList[ref.GUID]["Debuff"..index]["Expiration"]
				local icon = GUIDList[ref.GUID]["Debuff"..index]["Icon"]
				local timeLeft = expire - GetTime()
				
				debuff.Icon:SetTexture(icon)
				
				if timeLeft and timeLeft > 0 then
					debuff:Show()
					
					if timeLeft >=60 then
						debuff.Timer:SetText(math.floor(timeLeft/60).."m")
					elseif timeLeft >=10 then
						debuff.Timer:SetText(math.floor(timeLeft))
					elseif timeLeft >= 0.05 then
						debuff.Timer:SetText(string.format("%.1f",timeLeft))
					else
						debuff.Timer:SetText()
					end
				else
					debuff:Hide()
				end
			end
		end
	end
end