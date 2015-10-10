local K, C, L, _ = unpack(select(2, ...))

-- Popup to encourage an update
_G.StaticPopupDialogs["OUTDATED"] = {
	text = "Download & Update cFF4488FFKkthnx|r|cFFFEB200UI|r",
	button1 = OKAY,
	timeout = 0,
	whileDead = true,
	hasEditBox = true,
	editBoxWidth = 325,
	OnShow = function(self, ...) 
		self.editBox:SetFocus()
		self.editBox:SetText("http://www.wowinterface.com/downloads/info23677-KkthnxUI.html")
		self.editBox:HighlightText()
	end,
	EditBoxOnEnterPressed = function(self) self:GetParent():Hide() end,
	EditBoxOnEscapePressed = function(self) self:GetParent():Hide() end,
}

-- Check outdated UI version
local check = function(self, event, prefix, message, channel, sender)
	if event == "CHAT_MSG_ADDON" then
		if prefix ~= "KkthnxUIVersion" or sender == K.Name then return end
		if tonumber(message) ~= nil and tonumber(message) > tonumber(K.Version) then
			StaticPopup_Show("OUTDATED")
			print("|cffff0000"..L_MISC_UI_OUTDATED.."|r")
			self:UnregisterEvent("CHAT_MSG_ADDON")
		end
	else
		if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
			SendAddonMessage("KkthnxUIVersion", tonumber(K.Version), "INSTANCE_CHAT")
		elseif IsInRaid(LE_PARTY_CATEGORY_HOME) then
			SendAddonMessage("KkthnxUIVersion", tonumber(K.Version), "RAID")
		elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then
			SendAddonMessage("KkthnxUIVersion", tonumber(K.Version), "PARTY")
		elseif IsInGuild() then
			SendAddonMessage("KkthnxUIVersion", tonumber(K.Version), "GUILD")
		end
	end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("GROUP_ROSTER_UPDATE")
frame:RegisterEvent("CHAT_MSG_ADDON")
frame:SetScript("OnEvent", check)
RegisterAddonMessagePrefix("KkthnxUIVersion")

-- Whisper UI version
local whisp = CreateFrame("Frame")
whisp:RegisterEvent("CHAT_MSG_WHISPER")
whisp:RegisterEvent("CHAT_MSG_BN_WHISPER")
whisp:SetScript("OnEvent", function(self, event, text, name, ...)
	if text:lower():match("ui_version") then
		if event == "CHAT_MSG_WHISPER" then
			SendChatMessage("KkthnxUI "..K.Version, "WHISPER", nil, name)
		elseif event == "CHAT_MSG_BN_WHISPER" then
			BNSendWhisper(select(11, ...), "KkthnxUI "..K.Version)
		end
	end
end)