local backdrop = {
	bgFile = "Interface\\Buttons\\WHITE8X8",
	insets = {
	left = 2.5, right = 2.5, top = 2.5, bottom = 2.5
	}
}

local AddBorderToItemButton
do
	local function IconBorder_Hide(self)
		self:GetParent():SetBorderColor()
	end
	local function IconBorder_SetVertexColor(self, r, g, b)
		self:GetParent():SetBorderColor(r, g, b)
	end
	local function Button_OnLeave(self)
		if self.IconBorder:IsShown() then
			self:SetBorderColor(self.IconBorder:GetVertexColor())
		else
			self:SetBorderColor()
		end
	end
	function AddBorderToItemButton(button)
		if not button.icon then return print(button:GetName(), "is not an item button!") end
		CreateBorder(button) -- , nil, 1)
		button:GetNormalTexture():SetTexture("") -- useless extra icon border
		button.icon:SetTexCoord(0.04, 0.96, 0.04, 0.96)
		button.IconBorder:SetTexture("")
		hooksecurefunc(button.IconBorder, "Hide", IconBorder_Hide)
		hooksecurefunc(button.IconBorder, "SetVertexColor", IconBorder_SetVertexColor)
		--button:HookScript("OnEnter", ColorByClass)
		button:HookScript("OnLeave", Button_OnLeave)
	end
end

for _, slot in pairs({
	"CharacterHeadSlot",
	"CharacterNeckSlot",
	"CharacterShoulderSlot",
	"CharacterBackSlot",
	"CharacterChestSlot",
	"CharacterShirtSlot",
	"CharacterTabardSlot",
	"CharacterWristSlot",
	"CharacterHandsSlot",
	"CharacterWaistSlot",
	"CharacterLegsSlot",
	"CharacterFeetSlot",
	"CharacterFinger0Slot",
	"CharacterFinger1Slot",
	"CharacterTrinket0Slot",
	"CharacterTrinket1Slot",
	"CharacterMainHandSlot",
	"CharacterSecondaryHandSlot",
}) do
	local f = _G[slot]
	AddBorderToItemButton(f)
	_G[slot.."Frame"]:SetTexture("")
end

select(11, CharacterMainHandSlot:GetRegions()):SetTexture("")
select(11, CharacterSecondaryHandSlot:GetRegions()):SetTexture("")

hooksecurefunc("PaperDollItemSlotButton_Update", function(self)
	-- Despite these buttons having an IconBorder the default UI does not use it;
	-- fix that oversight so PhanxBorder colors will also work.
	-- This function doesn't depend on PhanxBorder and will work in any addon.
	local item = GetInventoryItemLink("player", self:GetID())
	if not item then return end
	local _, _, quality = GetItemInfo(item)
	if quality and quality > 1 then
		local color = ITEM_QUALITY_COLORS[quality]
		self.IconBorder:SetVertexColor(color.r, color.g, color.b)
		self.IconBorder:Show()
	else
		self.IconBorder:Hide()
	end
end)

-- Equipment flyouts
hooksecurefunc("EquipmentFlyout_Show", function(parent)
	local f = EquipmentFlyoutFrame.buttonFrame
	for i = 1, f.numBGs do
		f["bg"..i]:SetTexture("")
	end
end)

hooksecurefunc("EquipmentFlyout_DisplayButton", AddBorderToItemButton)

-- Equipment manager
hooksecurefunc("PaperDollEquipmentManagerPane_Update", function()
	local buttons = PaperDollEquipmentManagerPane.buttons
	for i = 1, #buttons do
		local button = buttons[i]
		if not button.__PhanxBorder then
			CreateBorder(button)
			button.icon:SetDrawLayer("BORDER")
			button.BgTop:SetTexture("")
			button.BgMiddle:SetTexture("")
			button.BgBottom:SetTexture("")
		end
		if button.Check:IsShown() then
			button:SetBorderColor(1, 0.82, 0)
		else
			button:SetBorderColor()
		end
	end
end)

---------------------------------------------------------------------
-- Spellbook
---------------------------------------------------------------------
local function SkinTab(tab)
	CreateBorder(tab)
	
	tab:GetNormalTexture():SetTexCoord(0.06, 0.94, 0.06, 0.94)
	tab:GetNormalTexture():SetDrawLayer("BORDER", 0)
	
	tab:GetCheckedTexture():SetDrawLayer("BORDER", 1)
	tab:GetCheckedTexture():SetPoint("TOPLEFT", -2, 2)
	tab:GetCheckedTexture():SetPoint("BOTTOMRIGHT", 2, -2)
	
	tab:GetHighlightTexture():SetPoint("TOPLEFT", -3, 3)
	tab:GetHighlightTexture():SetPoint("BOTTOMRIGHT", 3, -3)
end

local function Button_OnDisable(self)
	self:SetAlpha(0)
end
local function Button_OnEnable(self)
	self:SetAlpha(1)
end
local function Button_OnEnter(self)
	self:SetBorderColor(Kcolor.r, Kcolor.g, Kcolor.b)
end
local function Button_OnLeave(self)
	self:SetBorderColor()
end

for i = 1, SPELLS_PER_PAGE do
	local button = _G["SpellButton" .. i]
	CreateBorder(button, nil, nil, false)
	button.EmptySlot:SetTexture("")
	button.UnlearnedFrame:SetTexture("")
	_G["SpellButton" .. i .. "SlotFrame"]:SetTexture("") -- swirly thing
	_G["SpellButton" .. i .. "IconTexture"]:SetTexCoord(0.06, 0.94, 0.06, 0.94)
	button:HookScript("OnDisable", Button_OnDisable)
	button:HookScript("OnEnable", Button_OnEnable)
	button:HookScript("OnEnter", Button_OnEnter)
	button:HookScript("OnLeave", Button_OnLeave)
	if isPhanx then
		button.SpellName:SetFont(FONT, 16)
	end
end

for i = 1, 5 do
	SkinTab(_G["SpellBookSkillLineTab"..i])
end

hooksecurefunc("SpellBook_UpdateCoreAbilitiesTab", function()
	for i = 1, #SpellBookCoreAbilitiesFrame.Abilities do
		local button = SpellBookCoreAbilitiesFrame.Abilities[i]
		if not button.__PhanxBorder then
			CreateBorder(button, nil, 1)
			button.iconTexture:SetTexCoord(0.05, 0.95, 0.05, 0.95)
			button.FutureTexture:SetTexture("")
			select(3, button:GetRegions()):SetTexture("") -- swirly thing
			local a, b, c, x, y = button.Name:GetPoint(1)
			button.Name:SetPoint(a, b, c, x, 3)
			if isPhanx then
				button.Name:SetFont(FONT, 16)
			end
		end
	end
	for i = 1, #SpellBookCoreAbilitiesFrame.SpecTabs do
		SkinTab(SpellBookCoreAbilitiesFrame.SpecTabs[i])
	end
end)

---------------------------------------------------------------------
-- Static popups
---------------------------------------------------------------------
CreateBorder(StaticPopup1ItemFrame)

---------------------------------------------------------------------
-- Trade window
---------------------------------------------------------------------
for i = 1, 7 do
	AddBorderToItemButton(_G["TradePlayerItem"..i.."ItemButton"])
	AddBorderToItemButton(_G["TradeRecipientItem"..i.."ItemButton"])
end