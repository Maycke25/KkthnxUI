local K, C, L, _ = unpack(select(2, ...))
if C.misc.autocollapse ~= true then return end

----------------------------------------------------------------------------------------
--	Auto collapse ObjectiveTrackerFrame in instance
----------------------------------------------------------------------------------------
local aC = CreateFrame("Frame")
aC:RegisterEvent("PLAYER_ENTERING_WORLD")
aC:SetScript("OnEvent", function(self, event)
	if IsInInstance() then
		ObjectiveTracker_Collapse()
	elseif not IsInInstance() and ObjectiveTrackerFrame.collapsed and not InCombatLockdown() then
		ObjectiveTracker_Expand()
	end
end)