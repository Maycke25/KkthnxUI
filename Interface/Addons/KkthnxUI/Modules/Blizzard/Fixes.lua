local K, C, L, _ = unpack(select(2, ...))

--[[-----------------------------------------------------------------------------
Fix SearchLFGLeave() taint
-------------------------------------------------------------------------------]]
local TaintFix = CreateFrame("Frame")
TaintFix:SetScript("OnUpdate", function(self, elapsed)
	if LFRBrowseFrame.timeToClear then
		LFRBrowseFrame.timeToClear = nil
	end
end)

--[[-----------------------------------------------------------------------------
Suppresses the "You are not in a raid group" spam
-------------------------------------------------------------------------------]]
ERR_NOT_IN_RAID = "";

--[[-----------------------------------------------------------------------------
Disable tooltip for player arrow on map
-------------------------------------------------------------------------------]]
WorldMapPlayerUpper:EnableMouse(false)
WorldMapPlayerLower:EnableMouse(false)

--[[-----------------------------------------------------------------------------
Clear Button on the TradeSkill search box(TradeSkillClearButton by Kunda)
-------------------------------------------------------------------------------]]
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