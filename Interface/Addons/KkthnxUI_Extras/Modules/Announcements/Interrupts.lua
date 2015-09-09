local K, C, L, _ = unpack(KkthnxUI)
if C.announcements.interrupts ~= true then return end
----------------------------------------------------------------------------------------
--	Announce your interrupts(by Elv22)
----------------------------------------------------------------------------------------
local Interrupt = CreateFrame("Frame")
Interrupt:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
Interrupt:SetScript("OnEvent", function(self, _, ...)
	local _, event, _, sourceGUID, _, _, _, _, destName, _, _, _, _, _, spellID = ...
	if not (event == "SPELL_INTERRUPT" and sourceGUID == UnitGUID("player")) then return end

	SendChatMessage(L_ANNOUNCE_INTERRUPTED.." "..destName..": "..GetSpellLink(spellID), K.Check())
end)