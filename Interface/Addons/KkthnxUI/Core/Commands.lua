---------------------------------------------------------------------------------------
--	Slash commands
----------------------------------------------------------------------------------------
SlashCmdList.RELOADUI = function() ReloadUI() end
SLASH_RELOADUI1 = "/rl"

SlashCmdList.RCSLASH = function() DoReadyCheck() end
SLASH_RCSLASH1 = "/rc"

SlashCmdList.TICKET = function() ToggleHelpFrame() end
SLASH_TICKET1 = "/gm"

SlashCmdList.JOURNAL = function() ToggleEncounterJournal() end
SLASH_JOURNAL1 = "/ej"

SlashCmdList.ROLECHECK = function() InitiateRolePoll() end
SLASH_ROLECHECK1 = "/role"

SlashCmdList.SHOWCLOAK = function() if ShowingCloak() then ShowCloak(false) else ShowCloak() end end
SLASH_SHOWCLOAK1 = "/showcloak"
SLASH_SHOWCLOAK2 = "/sc"

SlashCmdList.SHOWHELM = function() if ShowingHelm() then ShowHelm(false) else ShowHelm() end end
SLASH_SHOWHELM1 = "/showhelm"
SLASH_SHOWHELM2 = "/sh"

SlashCmdList.CLEARCOMBAT = function() CombatLogClearEntries() end
SLASH_CLEARCOMBAT1 = "/clc"

----------------------------------------------------------------------------------------
--	Instance teleport
----------------------------------------------------------------------------------------
SlashCmdList.INSTTELEPORT = function()
	local inInstance = IsInInstance()
	if inInstance then
		LFGTeleport(true)
	else
		LFGTeleport()
	end
end
SLASH_INSTTELEPORT1 = "/teleport"

-- Where it's due...
SLASH_CREDITS1 = '/credits'
SlashCmdList['CREDITS'] = function()
    ChatFrame1:AddMessage('|cFF4488FFSpecial thanks to|r |cFFc248d8Magicnachos,|r |cFFFEB200syncrow, liquidbase, Nibelheim, Shestak, Munglunch, Neav, Goldpaw, Phanx, Tekkub, p3lim, Haste, Haleth, and Roth|r. Without them I would not have had the inspiration or insight to be able to make this UI')
end

----------------------------------------------------------------------------------------
--	Spec switching(by Monolit)
----------------------------------------------------------------------------------------
SlashCmdList.SPEC = function()
	if KkthnxLevel >= SHOW_TALENT_LEVEL then
		local spec = GetActiveSpecGroup()
		if spec == 1 then SetActiveSpecGroup(2) elseif spec == 2 then SetActiveSpecGroup(1) end
	else
		print("|cffffff00"..format(FEATURE_BECOMES_AVAILABLE_AT_LEVEL, SHOW_TALENT_LEVEL).."|r")
	end
end
SLASH_SPEC1 = "/ss"
SLASH_SPEC2 = "/spec"

----------------------------------------------------------------------------------------
--	Demo mode for DBM
----------------------------------------------------------------------------------------
SlashCmdList.DBMTEST = function() if IsAddOnLoaded("DBM-Core") then DBM:DemoMode() end end
SLASH_DBMTEST1 = "/dbmtest"

----------------------------------------------------------------------------------------
--	Command to show frame you currently have mouseovered
----------------------------------------------------------------------------------------
-- Get frame info of mouse focus
SLASH_FRAME1 = '/frame'
SlashCmdList['FRAME'] = function(arg)
	if arg ~= '' then
		arg = _G[arg]
	else
		arg = GetMouseFocus()
	end
	if arg ~= nil and arg:GetName() ~= nil then
		local point, relativeTo, relativePoint, xOfs, yOfs = arg:GetPoint()
		ChatFrame1:AddMessage('|cffCC0000----------------------------')
		ChatFrame1:AddMessage('Name: |cffFFD100'..arg:GetName())
		if arg:GetParent() and arg:GetParent():GetName() then
			ChatFrame1:AddMessage('Parent: |cffFFD100'..arg:GetParent():GetName())
		end
 
		ChatFrame1:AddMessage('Width: |cffFFD100'..format('%.2f',arg:GetWidth()))
		ChatFrame1:AddMessage('Height: |cffFFD100'..format('%.2f',arg:GetHeight()))
		ChatFrame1:AddMessage('Strata: |cffFFD100'..arg:GetFrameStrata())
		ChatFrame1:AddMessage('Level: |cffFFD100'..arg:GetFrameLevel())
 
		if xOfs then
			ChatFrame1:AddMessage('X: |cffFFD100'..format('%.2f',xOfs))
		end
		if yOfs then
			ChatFrame1:AddMessage('Y: |cffFFD100'..format('%.2f',yOfs))
		end
		if relativeTo and relativeTo:GetName() then
			ChatFrame1:AddMessage('Point: |cffFFD100'..point..'|r anchored to '..relativeTo:GetName().."'s |cffFFD100"..relativePoint)
		end
		ChatFrame1:AddMessage('|cffCC0000----------------------------')
	elseif arg == nil then
		ChatFrame1:AddMessage('Invalid frame name')
	else
		ChatFrame1:AddMessage('Could not find frame info')
	end
end

-- List child frames of mouse focus
SlashCmdList['CHILDFRAMES'] = function() 
	for k,v in pairs({GetMouseFocus():GetChildren()}) do
		print(v:GetName(),'-',v:GetObjectType())
	end
end
SLASH_CHILDFRAMES1 = '/child'

----------------------------------------------------------------------------------------
--	Clear chat
----------------------------------------------------------------------------------------
SlashCmdList.CLEAR_CHAT = function()
	for i = 1, NUM_CHAT_WINDOWS do
		_G[format("ChatFrame%d", i)]:Clear()
	end
end
SLASH_CLEAR_CHAT1 = "/clear"

----------------------------------------------------------------------------------------
--	Test Blizzard Alerts
----------------------------------------------------------------------------------------
SlashCmdList.TEST_ACHIEVEMENT = function()
	PlaySound("LFG_Rewards")
	if not AchievementFrame then
		AchievementFrame_LoadUI()
	end
	AchievementAlertFrame_ShowAlert(4912)
	AchievementAlertFrame_ShowAlert(6193)
	GuildChallengeAlertFrame_ShowAlert(3, 2, 5)
	CriteriaAlertFrame_ShowAlert(6301, 29918)
	MoneyWonAlertFrame_ShowAlert(9999999)
	LootWonAlertFrame_ShowAlert(select(2, GetItemInfo(6948)) or GetInventoryItemLink("player", 5), -1, 1, 100)
	ChallengeModeAlertFrame_ShowAlert()
	AlertFrame_AnimateIn(ScenarioAlertFrame1)
	StorePurchaseAlertFrame_ShowAlert(select(3, GetSpellInfo(2060)), GetSpellInfo(2060), 2060)
	LootUpgradeFrame_ShowAlert(select(2, GetItemInfo(6948)) or GetInventoryItemLink("player", 5), 1, 1, 1)
	GarrisonBuildingAlertFrame_ShowAlert(player)
	AlertFrame_FixAnchors()
end
SLASH_TEST_ACHIEVEMENT1 = "/testa"

----------------------------------------------------------------------------------------
--	Test and move Blizzard Extra Action Button
----------------------------------------------------------------------------------------
SlashCmdList.TEST_EXTRABUTTON = function()
	if ExtraActionBarFrame:IsShown() then
		ExtraActionBarFrame:Hide()
	else
		ExtraActionBarFrame:Show()
		ExtraActionBarFrame:SetAlpha(1)
		ExtraActionButton1:Show()
		ExtraActionButton1:SetAlpha(1)
		ExtraActionButton1.icon:SetTexture("Interface\\Icons\\INV_Pet_DiseasedSquirrel")
		ExtraActionButton1.icon:Show()
		ExtraActionButton1.icon:SetAlpha(1)
	end
end
SLASH_TEST_EXTRABUTTON1 = "/teb"

----------------------------------------------------------------------------------------
--	Grid on screen
----------------------------------------------------------------------------------------
local grid
SlashCmdList.GRIDONSCREEN = function()
	if grid then
		grid:Hide()
		grid = nil
	else
		grid = CreateFrame("Frame", nil, UIParent)
		grid:SetAllPoints(UIParent)
		local width = GetScreenWidth() / 128
		local height = GetScreenHeight() / 72
		for i = 0, 128 do
			local texture = grid:CreateTexture(nil, "BACKGROUND")
			if i == 64 then
				texture:SetTexture(1, 0, 0, 0.8)
			else
				texture:SetTexture(0, 0, 0, 0.8)
			end
			texture:SetPoint("TOPLEFT", grid, "TOPLEFT", i * width - 1, 0)
			texture:SetPoint("BOTTOMRIGHT", grid, "BOTTOMLEFT", i * width, 0)
		end
		for i = 0, 72 do
			local texture = grid:CreateTexture(nil, "BACKGROUND")
			if i == 36 then
				texture:SetTexture(1, 0, 0, 0.8)
			else
				texture:SetTexture(0, 0, 0, 0.8)
			end
			texture:SetPoint("TOPLEFT", grid, "TOPLEFT", 0, -i * height)
			texture:SetPoint("BOTTOMRIGHT", grid, "TOPRIGHT", 0, -i * height - 1)
		end
	end
end
SLASH_GRIDONSCREEN1 = "/align"