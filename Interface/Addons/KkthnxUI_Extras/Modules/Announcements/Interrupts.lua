local _, KExts = ...
local cfg = KExts.Config

if not cfg.Announcements.Interrupts then return end
----------------------------------------------------------------------------------------
--	Announce your interrupts(by Elv22)
----------------------------------------------------------------------------------------
local Interrupt = CreateFrame("Frame")
Interrupt:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
Interrupt:SetScript("OnEvent", function(self, _, ...)
	local _, event, _, sourceGUID, _, _, _, _, destName, _, _, _, _, _, spellID = ...
	if not (event == "SPELL_INTERRUPT" and sourceGUID == UnitGUID("player")) then return end

	SendChatMessage(L_ANNOUNCE_INTERRUPTED.." "..destName..": "..GetSpellLink(spellID), KCheck())
end)