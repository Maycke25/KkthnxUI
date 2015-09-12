local K, C, L, _ = unpack(select(2, ...))

--[[----------------------------
Fix SearchLFGLeave() taint
--------------------------------]]
local TaintFix = CreateFrame("Frame")
TaintFix:SetScript("OnUpdate", function(self, elapsed)
	if LFRBrowseFrame.timeToClear then
		LFRBrowseFrame.timeToClear = nil
	end
end)

--[[----------------------------
Suppresses the 
"You are not in a raid group" spam
--------------------------------]]
ERR_NOT_IN_RAID = "";

--[[----------------------------
Disable tooltip for player 
arrow on map
--------------------------------]]
WorldMapPlayerUpper:EnableMouse(false)
WorldMapPlayerLower:EnableMouse(false)

--[[----------------------------
Fix RemoveTalent() taint
--------------------------------]]
FCF_StartAlertFlash = K.Dummy

--[[----------------------------
Misclicks for some popups
--------------------------------]]
StaticPopupDialogs.RESURRECT.hideOnEscape = nil
StaticPopupDialogs.AREA_SPIRIT_HEAL.hideOnEscape = nil
StaticPopupDialogs.PARTY_INVITE.hideOnEscape = nil
StaticPopupDialogs.PARTY_INVITE_XREALM.hideOnEscape = nil
StaticPopupDialogs.CONFIRM_SUMMON.hideOnEscape = nil
StaticPopupDialogs.ADDON_ACTION_FORBIDDEN.button1 = nil
StaticPopupDialogs.TOO_MANY_LUA_ERRORS.button1 = nil
PetBattleQueueReadyFrame.hideOnEscape = nil
PVPReadyDialog.leaveButton:Hide()
PVPReadyDialog.enterButton:ClearAllPoints()
PVPReadyDialog.enterButton:SetPoint("BOTTOM", PVPReadyDialog, "BOTTOM", 0, 25)

--[[----------------------------
Clear Button on the TradeSkill 
search box (by Kunda)
--------------------------------]]
local TradeSkillClearButton = CreateFrame("Button", nil, UIParent)

local function CreateButton()
	TradeSkillClearButton:SetParent(TradeSkillFrameSearchBox)
	TradeSkillClearButton:EnableMouse(true)
	TradeSkillClearButton:SetWidth(18)
	TradeSkillClearButton:SetHeight(18)
	TradeSkillClearButton:SetPoint("RIGHT", TradeSkillFrameSearchBox, "RIGHT", 0, 0)
	TradeSkillClearButton:Hide()
	
	TradeSkillClearButton.Texture = TradeSkillClearButton:CreateTexture(nil, "ARTWORK")
	TradeSkillClearButton.Texture:SetWidth(18)
	TradeSkillClearButton.Texture:SetHeight(18)
	TradeSkillClearButton.Texture:SetPoint("CENTER", 0, 0)
	TradeSkillClearButton.Texture:SetVertexColor(0.6, 0.6, 0.6)
	TradeSkillClearButton.Texture:SetTexture("Interface\\FriendsFrame\\ClearBroadcastIcon")
	
	TradeSkillClearButton:SetScript("OnEnter", function()
		TradeSkillClearButton.Texture:SetVertexColor(1, 1, 1)
	end)
	TradeSkillClearButton:SetScript("OnLeave", function()
		TradeSkillClearButton.Texture:SetVertexColor(0.6, 0.6, 0.6)
	end)
	TradeSkillClearButton:SetScript("OnClick", function()
		TradeSkillFrameSearchBox:ClearFocus()
		TradeSkillFrameSearchBox:SetText(SEARCH)
		TradeSkillFrameSearchBox:SetFontObject("GameFontDisable")
		TradeSkillClearButton:Hide()
	end)
end

local function OnEvent(self, event, addon)
	if event == "ADDON_LOADED" then
		if addon == "Blizzard_TradeSkillUI" then
			CreateButton()
			TradeSkillFrame:HookScript("OnHide", function()
				TradeSkillClearButton:Hide()
			end)
			TradeSkillFrameSearchBox:HookScript("OnEditFocusGained", function()
				TradeSkillClearButton:Show()
			end)
			TradeSkillFrameSearchBox:HookScript("OnEditFocusLost", function()
				if TradeSkillFrameSearchBox:GetText() == "" then
					TradeSkillFrameSearchBox:ClearFocus()
					TradeSkillFrameSearchBox:SetText(SEARCH)
					TradeSkillFrameSearchBox:SetFontObject("GameFontDisable")
					TradeSkillClearButton:Hide()
				end
			end)
			TradeSkillClearButton:UnregisterEvent("ADDON_LOADED")
		end
	end
end

TradeSkillClearButton:RegisterEvent("ADDON_LOADED")
TradeSkillClearButton:SetScript("OnEvent", OnEvent)