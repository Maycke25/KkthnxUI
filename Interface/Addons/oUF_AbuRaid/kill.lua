local frameHider = CreateFrame('Frame')
frameHider:Hide()

InterfaceOptionsFrameCategoriesButton11:SetScale(0.00001)
InterfaceOptionsFrameCategoriesButton11:SetAlpha(0)

CompactRaidFrameManager:SetParent(frameHider)
CompactUnitFrameProfiles:UnregisterAllEvents()