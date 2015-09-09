local K, C, L = unpack(KkthnxUI)
if C.chat.bubbles ~= true then return end

local ChatBubbleSkin = CreateFrame('Frame', nil, UIParent)
local tslu = 0
local numChildren = -1
local bubbles = {}

local backdrop = {
	bgFile = "Interface\\Addons\\KkthnxUI_Media\\Media\\Textures\\Background.blp",
	--edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
	tile = true, tileSize = 16, --edgeSize = 14, 
    insets = { left = 8, right = 8, top = 8, bottom = 8
	}
}

local function SkinBubble(frame)
	for i=1, frame:GetNumRegions() do
		local region = select(i, frame:GetRegions())
		if region:GetObjectType() == 'Texture' then
			region:SetTexture(nil)
		elseif region:GetObjectType() == 'FontString' then
			frame.text = region
		end
	end
	
	frame:SetBackdrop(backdrop)
	CreateBorder(frame, 10, -5)
	frame:SetBackdropColor(1, 1, 1, .9)
	
	tinsert(bubbles, frame)
end

function IsChatBubble(frame)
	for i = 1, frame:GetNumRegions() do
		local region = select(i, frame:GetRegions())
		if (region.GetTexture and region:GetTexture() and type(region:GetTexture() == "string") and
		strlower(region:GetTexture()) == [[interface\tooltips\chatbubble-background]]) then
			return true
		end
	end
	return false
end

ChatBubbleSkin:SetScript('OnUpdate', function(ChatBubbleSkin, elapsed)
	tslu = tslu + elapsed
	if tslu > 0.1 then
		tslu = 0
		local count = WorldFrame:GetNumChildren()
		if count ~= numChildren then
			numChildren = count
			for index = 1, select('#', WorldFrame:GetChildren()) do
				local frame = select(index, WorldFrame:GetChildren())
				if IsChatBubble(frame) then
					SkinBubble(frame)
				end
			end
			numChildren = count
		end
		
		for i, frame in next, bubbles do
			local r, g, b = frame.text:GetTextColor()
			frame:SetBorderColor(r, g, b)
		end
	end
end)