local K, C, L, _ = unpack(select(2, ...))
if C.actionbar.enable ~= true then return end

-- moveable bars (Pet, Stance, Possess)
local ExtraBarsAnchor = CreateFrame("Frame", "ExtraBarsAnchor", UIParent)
ExtraBarsAnchor:SetSize(36, 36)
ExtraBarsAnchor:SetPoint(unpack(C.position.extrabars))

for _, button in pairs({
    _G['PossessButton1'],
    _G['PetActionButton1'],
    _G['StanceButton1'],
}) do
	button:SetMovable(true)
	button.locked = nil
    button:ClearAllPoints()
	button:SetPoint("CENTER", ExtraBarsAnchor, "CENTER", 0, 0)
    button:SetUserPlaced(true)
	button:SetMovable(false)
	button.locked = 1
end

if( C.actionbar.showbarart == false)then
	MainMenuBarRightEndCap:Kill()
	MainMenuBarLeftEndCap:Kill()
	MainMenuBarTexture0:Kill()
	MainMenuBarTexture1:Kill()
	
	MainMenuXPBarTextureMid:Kill()
	MainMenuXPBarTextureLeftCap:Kill()
	MainMenuXPBarTextureRightCap:Kill()
	
	for i = 1, 19 do -- Remove EXP Dividers
		local texture = _G["MainMenuXPBarDiv"..i]
		if texture then
			texture:Kill()
		end
	end
	
end

MainMenuBar:SetScale(C.actionbar.scale)