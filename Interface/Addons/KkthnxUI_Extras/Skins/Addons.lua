local f = CreateFrame('Frame')
f:RegisterEvent('VARIABLES_LOADED')
f:RegisterEvent('ADDON_LOADED')
f:RegisterEvent('PLAYER_ENTERING_WORLD')

f:SetScript('OnEvent', function(self)
	if (IsAddOnLoaded('Omen')) then
		
	end
	
	if (IsAddOnLoaded('DBM-Core')) then
		hooksecurefunc(DBT, 'CreateBar', function(self)
			for bar in self:GetBarIterator() do
				local frame = bar.frame
				local tbar = _G[frame:GetName()..'Bar']
				local spark = _G[frame:GetName()..'BarSpark']
				local texture = _G[frame:GetName()..'BarTexture']
				local icon1 = _G[frame:GetName()..'BarIcon1']
				local icon2 = _G[frame:GetName()..'BarIcon2']
				local name = _G[frame:GetName()..'BarName']
				local timer = _G[frame:GetName()..'BarTimer']
				
				spark:SetTexture(nil)
				
				timer:ClearAllPoints()
				timer:SetPoint('RIGHT', tbar, 'RIGHT', -4, 0)
				timer:SetJustifyH('RIGHT')
				
				name:ClearAllPoints()
				name:SetPoint('LEFT', tbar, 4, 0)
				name:SetPoint('RIGHT', timer, 'LEFT', -4, 0)
				
				tbar:SetHeight(24)
				CreateBorder(tbar, 10, 3)
				
				icon1:SetTexCoord(0.07, 0.93, 0.07, 0.93)
				icon1:SetSize(tbar:GetHeight(), tbar:GetHeight() - 1)
				
				icon2:SetTexCoord(0.07, 0.93, 0.07, 0.93)
				icon2:SetSize(tbar:GetHeight(), tbar:GetHeight() - 1)
			end
		end)
	end
	
	if (IsAddOnLoaded('TinyDPS')) then
		if (not tdpsFrame.beautyBorder) then
			CreateBorder()
		end
	end
	
	if (IsAddOnLoaded('Recount')) then
		CreateBorder(Recount.MainWindow, 12)
	end
	
	if (IsAddOnLoaded('Skada')) then
		local OriginalSkadaFunc = Skada.PLAYER_ENTERING_WORLD
		function Skada:PLAYER_ENTERING_WORLD()
			OriginalSkadaFunc(self)
			
			if (SkadaBarWindowSkada) then
				CreateBorder(SkadaBarWindowSkada, 14, 5)
			end
		end
	end
end)