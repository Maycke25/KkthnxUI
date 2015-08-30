if IsAddOnLoaded('KkthnxUI_Loot') then
	
	local _, KLoot = ...
	local cfg = KLoot.Config
	
	local LootFrame = LootFrame
	local _G = _G
	
	local backdrop = {
		bgFile = "Interface\\Buttons\\WHITE8X8",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		edgeSize = 14,
		insets = {
			left = 2.5, right = 2.5, top = 2.5, bottom = 2.5
		}
	}
	
	local LootTargetPortrait = CreateFrame("PlayerModel", nil, LootFrame)
	LootTargetPortrait:SetPoint("TOP", LootFrame, "TOP", 0, -28)
	LootTargetPortrait:SetSize(25*6, 18*2)
	
	for i = 1, LootFrame:GetNumRegions() do
		local Region = select(i, LootFrame:GetRegions())
		if Region:GetObjectType() == 'Texture' then
			Region:Hide()
		end
	end
	
	LootFrameInset:Hide()
	
	LootFrame:SetBackdrop(backdrop);
	LootFrame:SetBackdropColor(0, 0, 0, 0.8);
	
	CreateBorder(LootTargetPortrait, 12, 4)
	LootTargetPortrait:SetBorderColor(1.0, 0.82, 0)
	
	LootFrameUpButton:ClearAllPoints()
	LootFrameUpButton:SetPoint("BOTTOMLEFT", 12, 12)
	LootFrameDownButton:ClearAllPoints()
	LootFrameDownButton:SetPoint("BOTTOMRIGHT", -12, 12)
	LootFramePrev:ClearAllPoints()
	LootFramePrev:SetPoint("LEFT", LootFrameUpButton, "RIGHT", 3, 0)
	LootFrameNext:ClearAllPoints()
	LootFrameNext:SetPoint("RIGHT", LootFrameDownButton, "LEFT", -3, 0)
	LootFrameCloseButton:ClearAllPoints()
	LootFrameCloseButton:SetPoint("TOPRIGHT", 0, 0)
	LootFrameTitleText:ClearAllPoints()
	LootFrameTitleText:SetPoint("TOP", 0, -10)
	
	hooksecurefunc("LootFrame_UpdateButton", function(index)
		local texture, item, quantity, quality, locked, isQuestItem, questId, isActive = GetLootSlotInfo(index)
		CreateBorder(_G["LootButton"..index], 12, 2)
		
		_G["LootButton"..index.."IconQuestTexture"]:SetAlpha(0)
		_G["LootButton"..index.."NameFrame"]:SetAlpha(0)
		if isQuestItem then
			_G["LootButton"..index]:SetBorderColor(1.0, 0.82, 0)
		elseif quality and quality > 1 then
			local r, g, b = GetItemQualityColor(quality)
			_G["LootButton"..index]:SetBorderColor(r, g, b)
		else
			_G["LootButton"..index]:SetBorderColor(1, 1, 1, 1)
		end
	end)
	
	LootPortraitFrame = CreateFrame("Frame")
	LootPortraitFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
	LootPortraitFrame:RegisterEvent("LOOT_OPENED")
	LootPortraitFrame:SetScript("OnEvent", function(self, event, id)
		if event == "LOOT_OPENED" then
			if UnitExists("target") then
				LootTargetPortrait:SetUnit("target")
				LootTargetPortrait:SetCamera(0)
			else
				LootTargetPortrait:ClearModel()
				LootTargetPortrait:SetModel("PARTICLES\\Lootfx.m2")
			end
		elseif event == "LOOT_CLOSED" then
			BobLootBackround:Hide()
		end
	end)
	
	LootFrame:EnableMouse(true)
	LootFrame:SetUserPlaced(true)
	LootFrame:RegisterForDrag("LeftButton")
	LootFrame:SetScript("OnDragStart", function(self) self:StartMoving() end)
	LootFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
end