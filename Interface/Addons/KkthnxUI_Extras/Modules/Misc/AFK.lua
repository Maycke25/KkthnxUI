local _, KExts = ...
local cfg = KExts.Config

--if cfg.Misc.SpinAFK ~= true then return end

local backdrop = {
	bgFile = "Interface\\Buttons\\WHITE8X8",
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	edgeSize = 14,
	insets = {
		left = 2.5, right = 2.5, top = 2.5, bottom = 2.5
	}
}

-- Source wowhead.com
local stats = {
	60,		-- Total deaths
	97,		-- Daily quests completed
	98,		-- Quests completed
	107,	-- Creatures killed
	112,	-- Deaths from drowning
	114,	-- Deaths from falling
	319,	-- Duels won
	320,	-- Duels lost
	321,	-- Total raid and dungeon deaths
	326,	-- Gold from quest rewards
	328,	-- Total gold acquired
	333,	-- Gold looted
	334,	-- Most gold ever owned
	338,	-- Vanity pets owned
	339,	-- Mounts owned
	342,	-- Epic items acquired
	349,	-- Flight paths taken
	377,	-- Most factions at Exalted
	588,	-- Total Honorable Kills
	837,	-- Arenas won
	838,	-- Arenas played
	839,	-- Battlegrounds played
	840,	-- Battlegrounds won
	919,	-- Gold earned from auctions
	931,	-- Total factions encountered
	932,	-- Total 5-player dungeons entered
	933,	-- Total 10-player raids entered
	934,	-- Total 25-player raids entered
	1042,	-- Number of hugs
	1045,	-- Total cheers
	1047,	-- Total facepalms
	1065,	-- Total waves
	1066,	-- Total times LOL'd
	1088,	-- Kael'thas Sunstrider kills (Tempest Keep)
	1149,	-- Talent tree respecs
	1197,	-- Total kills
	1098,	-- Onyxia kills (Onyxia's Lair)
	1198,	-- Total kills that grant experience or honor
	1487,	-- Killing Blows
	1491,	-- Battleground Killing Blows
	1518,	-- Fish caught
	1716,	-- Battleground with the most Killing Blows
	4687,	-- Victories over the Lich King (Icecrown 25 player)
	5692,	-- Rated battlegrounds played
	5694,	-- Rated battlegrounds won
	6167,	-- Deathwing kills (Dragon Soul)
	7399,	-- Challenge mode dungeons completed
	8278,	-- Pet Battles won at max level
	8632,	-- Garrosh Hellscream (LFR Siege of Orgrimmar)
	
	9430,	-- Draenor dungeons completed (final boss defeated)
	9561,	-- Draenor raid boss defeated the most
	9558,	-- Draenor raids completed (final boss defeated)
}

-- Create random stats
local function createStats()
	local id = stats[random( #stats )]
	local _, name = GetAchievementInfo(id)
	local result = GetStatistic(id)
	if result == "--" then result = NONE end
	return format("%s: |cfff0ff00%s|r", name, result)
end

-- simple timer
local showTime = 5
local total = 0
local function onUpdate(self, elapsed)
	total = total + elapsed
	if total >= showTime then
		local createdStat = createStats()
		self:AddMessage(createdStat)
		UIFrameFadeIn(self, 1, 0, 1)
		total = 0
	end
end

--[[Guild]]--
local function GuildText()
	if IsInGuild() then
		local guildName = GetGuildInfo("player")
		KkthnxUIAFKPanel.GuildText:SetText("|cFF4488FF" .. guildName .. "|r")
	else
		KkthnxUIAFKPanel.GuildText:SetText(" ")
	end
end

--[[AFK-Timer]]--
local function UpdateTimer()
	local time = GetTime() - startTime
	KkthnxUIAFKPanel.AFKTimer:SetText(format("%02d|cFF4488FF:|r%02d", floor(time/60), time % 60))
end

--[[Spin function]]--
function SpinStart()
	spinning = true
	MoveViewRightStart(.1)
end

function SpinStop()
	if(not spinning) then return end
	spinning = nil
	MoveViewRightStop()
end

--[[Frames]]--
local KkthnxUIAFKPanel = CreateFrame("Frame", "KkthnxUIAFKPanel", nil)
KkthnxUIAFKPanel:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 0)
KkthnxUIAFKPanel:SetSize((Kscreenwidth - 554), 80)
KkthnxUIAFKPanel:SetBackdrop(backdrop)
KkthnxUIAFKPanel:SetBackdropColor(0, 0, 0, 0.8)
KkthnxUIAFKPanel:SetFrameStrata("FULLSCREEN")
KkthnxUIAFKPanel:Hide()

local KkthnxUIAFKPanelIcon = CreateFrame("Frame", "KkthnxUIAFKPanelIcon", KkthnxUIAFKPanel)
KkthnxUIAFKPanelIcon:SetSize(150, 75)
KkthnxUIAFKPanelIcon:SetPoint("CENTER", KkthnxUIAFKPanel, "TOP", 0, 0)

KkthnxUIAFKPanelIcon.Texture = KkthnxUIAFKPanelIcon:CreateTexture(nil, "ARTWORK")
KkthnxUIAFKPanelIcon.Texture:SetPoint("TOPLEFT", 2, -2)
KkthnxUIAFKPanelIcon.Texture:SetPoint("BOTTOMRIGHT", -2, 2)
KkthnxUIAFKPanelIcon.Texture:SetTexture("Interface\\Glues\\Common\\GLUES-WOW-WODLOGO")

KkthnxUIAFKPanel.KkthnxUIText = KkthnxUIAFKPanel:CreateFontString(nil, "OVERLAY")
KkthnxUIAFKPanel.KkthnxUIText:SetPoint("CENTER", KkthnxUIAFKPanel, "CENTER", 0, -10)
KkthnxUIAFKPanel.KkthnxUIText:SetFont(cfg.uiFont, 40, "OUTLINE")
KkthnxUIAFKPanel.KkthnxUIText:SetText("|cFF4488FFKkthnx's|r |cFFFEB200UI|r " .. Kversion)

KkthnxUIAFKPanel.DateText = KkthnxUIAFKPanel:CreateFontString(nil, "OVERLAY")
KkthnxUIAFKPanel.DateText:SetPoint("BOTTOMLEFT", KkthnxUIAFKPanel, "BOTTOMRIGHT", -100, 54)
KkthnxUIAFKPanel.DateText:SetFont(cfg.uiFont, 15, "OUTLINE")

KkthnxUIAFKPanel.ClockText = KkthnxUIAFKPanel:CreateFontString(nil, "OVERLAY")
KkthnxUIAFKPanel.ClockText:SetPoint("BOTTOMLEFT", KkthnxUIAFKPanel, "BOTTOMRIGHT", -100, 30)
KkthnxUIAFKPanel.ClockText:SetFont(cfg.uiFont, 20, "OUTLINE")

KkthnxUIAFKPanel.AFKTimer = KkthnxUIAFKPanel:CreateFontString(nil, "OVERLAY")
KkthnxUIAFKPanel.AFKTimer:SetPoint("BOTTOMLEFT", KkthnxUIAFKPanel, "BOTTOMRIGHT", -100, 6)
KkthnxUIAFKPanel.AFKTimer:SetFont(cfg.uiFont, 20, "OUTLINE")

KkthnxUIAFKPanel.PlayerNameText = KkthnxUIAFKPanel:CreateFontString(nil, "OVERLAY")
KkthnxUIAFKPanel.PlayerNameText:SetPoint("LEFT", KkthnxUIAFKPanel, "LEFT", 25, 15)
KkthnxUIAFKPanel.PlayerNameText:SetFont(cfg.uiFont, 28, "OUTLINE")
KkthnxUIAFKPanel.PlayerNameText:SetText(Kname)
KkthnxUIAFKPanel.PlayerNameText:SetTextColor(Kcolor.r, Kcolor.g, Kcolor.b)

KkthnxUIAFKPanel.GuildText = KkthnxUIAFKPanel:CreateFontString(nil, "OVERLAY")
KkthnxUIAFKPanel.GuildText:SetPoint("LEFT", KkthnxUIAFKPanel, "LEFT", 25, -3)
KkthnxUIAFKPanel.GuildText:SetFont(cfg.uiFont, 15, "OUTLINE")

KkthnxUIAFKPanel.PlayerInfoText = KkthnxUIAFKPanel:CreateFontString(nil, "OVERLAY")
KkthnxUIAFKPanel.PlayerInfoText:SetPoint("LEFT", KkthnxUIAFKPanel, "LEFT", 25, -20)
KkthnxUIAFKPanel.PlayerInfoText:SetFont(cfg.uiFont, 15, "OUTLINE")
KkthnxUIAFKPanel.PlayerInfoText:SetText(LEVEL .. " " .. Klevel .. " " .. Kfaction .. " |cFF4488FF" .. Kclass .. "|r")

-- Random stats decor (taken from install routine)
statMsg = CreateFrame("Frame", nil, KkthnxUIAFKPanelIcon)
statMsg:SetSize(418, 72)
statMsg:SetPoint("TOP", 0, 80)

statMsg.bg = statMsg:CreateTexture(nil, 'BACKGROUND')
statMsg.bg:SetTexture([[Interface\LevelUp\LevelUpTex]])
statMsg.bg:SetPoint('BOTTOM')
statMsg.bg:SetSize(326, 103)
statMsg.bg:SetTexCoord(0.00195313, 0.63867188, 0.03710938, 0.23828125)
statMsg.bg:SetVertexColor(1, 1, 1, 0.7)

statMsg.lineTop = statMsg:CreateTexture(nil, 'BACKGROUND')
statMsg.lineTop:SetDrawLayer('BACKGROUND', 2)
statMsg.lineTop:SetTexture([[Interface\LevelUp\LevelUpTex]])
statMsg.lineTop:SetPoint("TOP")
statMsg.lineTop:SetSize(418, 7)
statMsg.lineTop:SetTexCoord(0.00195313, 0.81835938, 0.01953125, 0.03320313)

statMsg.lineBottom = statMsg:CreateTexture(nil, 'BACKGROUND')
statMsg.lineBottom:SetDrawLayer('BACKGROUND', 2)
statMsg.lineBottom:SetTexture([[Interface\LevelUp\LevelUpTex]])
statMsg.lineBottom:SetPoint("BOTTOM")
statMsg.lineBottom:SetSize(418, 7)
statMsg.lineBottom:SetTexCoord(0.00195313, 0.81835938, 0.01953125, 0.03320313)

statMsg.info = CreateFrame("ScrollingMessageFrame", nil, statMsg)
statMsg.info:SetFont(cfg.uiFont, 13, "OUTLINE")
statMsg.info:SetPoint("CENTER", statMsg, "CENTER", 0, 0)
statMsg.info:SetSize(800, 24)
statMsg.info:AddMessage("|cffb3b3b3|r", stats)
statMsg.info:SetFading(true)
statMsg.info:SetFadeDuration(1)
statMsg.info:SetTimeVisible(4)
statMsg.info:SetJustifyH("CENTER")
statMsg.info:SetTextColor(0.7, 0.7, 0.7)
statMsg.info:SetScript("OnUpdate", onUpdate)

--[[Dynamic time & date]]--
local interval = 0
KkthnxUIAFKPanel:SetScript("OnUpdate", function(self, elapsed)
	interval = interval - elapsed
	if interval <= 0 then
		KkthnxUIAFKPanel.ClockText:SetText(format("%s", date("%H|cFF4488FF:|r%M|cFF4488FF:|r%S")))
		KkthnxUIAFKPanel.DateText:SetText(format("%s", date("|cFF4488FF%a|r %b|cFF4488FF/|r%d")))
		UpdateTimer()
		interval = 0.5
	end
end)

--[[Register events, script to start]]--
KkthnxUIAFKPanel:RegisterEvent("PLAYER_LOGIN")
KkthnxUIAFKPanel:RegisterEvent("PLAYER_ENTERING_WORLD")
KkthnxUIAFKPanel:RegisterEvent("PLAYER_LEAVING_WORLD")
KkthnxUIAFKPanel:RegisterEvent("PLAYER_FLAGS_CHANGED")
KkthnxUIAFKPanel:RegisterEvent("PLAYER_REGEN_DISABLED")
KkthnxUIAFKPanel:RegisterEvent("PLAYER_DEAD")
KkthnxUIAFKPanel:SetScript("OnEvent", function(self, event, unit)
	if InCombatLockdown() then return end
	
	if event == "PLAYER_FLAGS_CHANGED" then
		startTime = GetTime()
		if unit == "player" then
			if UnitIsAFK(unit) and not UnitIsDead(unit) then
				SpinStart()
				KkthnxUIAFKPanel:Show()
				GuildText()
				UIParent:Hide()
			else
				SpinStop()
				KkthnxUIAFKPanel:Hide()
				Minimap:Show()
			end
		end
	elseif event == "PLAYER_DEAD" then
		if UnitIsAFK("player") then
			SpinStop()
			KkthnxUIAFKPanel:Hide()
			UIParent:Show()
		end
	elseif event == "PLAYER_REGEN_DISABLED" then
		if UnitIsAFK("player") then
			SpinStop()
			KkthnxUIAFKPanel:Hide()
			UIParent:Show()
		end
	elseif event == "PLAYER_LEAVING_WORLD" then
		SpinStop()
	end
end)

--[[Fade in & out]]--
KkthnxUIAFKPanel:SetScript("OnShow", function(self) UIFrameFadeIn(UIParent, .5, 1, 0) end)
KkthnxUIAFKPanel:SetScript("OnHide", function(self) UIFrameFadeOut(UIParent, .5, 0, 1) end)