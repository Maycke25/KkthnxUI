local K, C, L, _ = unpack(select(2, ...))
if C.blizzard.capturebar ~= true then return end

----------------------------------------------------------------------------------------
--	Reposition Capture Bar
----------------------------------------------------------------------------------------
local function CaptureUpdate()
	if not NUM_EXTENDED_UI_FRAMES then return end
	for i = 1, NUM_EXTENDED_UI_FRAMES do
		local barname = "WorldStateCaptureBar"..i
		local bar = _G[barname]
		
		if bar and bar:IsVisible() then
			bar:ClearAllPoints()
			if i == 1 then
				bar:SetPoint(unpack(C.position.capturebar))
			else
				bar:SetPoint("TOPLEFT", _G["WorldStateCaptureBar"..i-1], "BOTTOMLEFT", 0, -7)
			end
			if not bar.skinned then
				local left = _G[barname.."LeftBar"]
				local right = _G[barname.."RightBar"]
				local middle = _G[barname.."MiddleBar"]
				select(4, bar:GetRegions()):Hide()
				_G[barname.."LeftLine"]:SetAlpha(0)
				_G[barname.."RightLine"]:SetAlpha(0)
				_G[barname.."LeftIconHighlight"]:SetAlpha(0)
				_G[barname.."RightIconHighlight"]:SetAlpha(0)
				
				left:SetTexture(C.media.texture)
				right:SetTexture(C.media.texture)
				middle:SetTexture(C.media.texture)
				
				left:SetVertexColor(0.2, 0.6, 1)
				right:SetVertexColor(0.9, 0.2, 0.2)
				middle:SetVertexColor(0.8, 0.8, 0.8)
				
				bar:SetBackdrop(nil)
				
				bar.skinned = true
			end
		end
	end
end
hooksecurefunc("UIParent_ManageFramePositions", CaptureUpdate)