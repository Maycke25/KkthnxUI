local K, C, L, _ = unpack(KkthnxUI)

if C.chat.channelreplace then
	local gsub = gsub
	local time = _G.time
	local newAddMsg = {}
	
	local rplc = {
		"[GEN]", --General
		"[T]", --Trade
		"[WD]", --WorldDefense
		"[LD]", --LocalDefense
		"[LFG]", --LookingForGroup
		"[GR]", --GuildRecruitment
		"[I]", --Instance
		"[IL]", --Instance Leader
		"[G]", --Guild
		"[P]", --Party
		"[PL]", --Party Leader
		"[PL]", --Party Leader (Guide)
		"[O]", --Officer
		"[R]", --Raid
		"[RL]", --Raid Leader
		"[RW]", --Raid Warning
		"[%1]", --Custom Channels
	}
	
	local chn = {
		"%[%d0?%. General.-%]",
		"%[%d0?%. Trade.-%]",
		"%[%d0?%. WorldDefense%]",
		"%[%d0?%. LocalDefense.-%]",
		"%[%d0?%. LookingForGroup%]",
		"%[%d0?%. GuildRecruitment.-%]",
		gsub(CHAT_INSTANCE_CHAT_GET, ".*%[(.*)%].*", "%%[%1%%]"),
		gsub(CHAT_INSTANCE_CHAT_LEADER_GET, ".*%[(.*)%].*", "%%[%1%%]"),
		gsub(CHAT_GUILD_GET, ".*%[(.*)%].*", "%%[%1%%]"),
		gsub(CHAT_PARTY_GET, ".*%[(.*)%].*", "%%[%1%%]"),
		gsub(CHAT_PARTY_LEADER_GET, ".*%[(.*)%].*", "%%[%1%%]"),
		gsub(CHAT_PARTY_GUIDE_GET, ".*%[(.*)%].*", "%%[%1%%]"),
		gsub(CHAT_OFFICER_GET, ".*%[(.*)%].*", "%%[%1%%]"),
		gsub(CHAT_RAID_GET, ".*%[(.*)%].*", "%%[%1%%]"),
		gsub(CHAT_RAID_LEADER_GET, ".*%[(.*)%].*", "%%[%1%%]"),
		gsub(CHAT_RAID_WARNING_GET, ".*%[(.*)%].*", "%%[%1%%]"),
		"%[(%d0?)%. (.-)%]", --Custom Channels
	}
	
	local L = GetLocale()
	if L == "ruRU" then --Russian
		chn[1] = "%[%d0?%. ?????.-%]"
		chn[2] = "%[%d0?%. ????????.-%]"
		chn[3] = "%[%d0?%. ???????: ??????????%]" --Defense: Global
		chn[4] = "%[%d0?%. ???????.-%]" --Defense: Zone
		chn[5] = "%[%d0?%. ????? ?????????%]"
		chn[6] = "%[%d0?%. ???????.-%]"
	elseif L == "deDE" then --German
		chn[1] = "%[%d0?%. Allgemein.-%]"
		chn[2] = "%[%d0?%. Handel.-%]"
		chn[3] = "%[%d0?%. Weltverteidigung%]"
		chn[4] = "%[%d0?%. LokaleVerteidigung.-%]"
		chn[5] = "%[%d0?%. SucheNachGruppe%]"
		chn[6] = "%[%d0?%. Gildenrekrutierung.-%]"
	elseif L == "frFR" then --French
		chn[1] = "%[%d0?%. Général.-%]"
		chn[2] = "%[%d0?%. Commerce.-%]"
		chn[3] = "%[%d0?%. DéfenseUniverselle%]"
		chn[4] = "%[%d0?%. DéfenseLocale.-%]"
		chn[5] = "%[%d0?%. RechercheDeGroupe%]"
		chn[6] = "%[%d0?%. RecrutementDeGuilde.-%]"
	elseif L == "zhTW" then --Traditional Chinese
		chn[1] = "%[%d0?%. ??.-%]"
		chn[2] = "%[%d0?%. ??.-%]"
		chn[3] = "%[%d0?%. ????%]"
		chn[4] = "%[%d0?%. ????.-%]"
		chn[5] = "%[%d0?%. ????%]"
		chn[6] = "%[%d0?%. ????.-%]"
	elseif L == "koKR" then --Korean
		chn[1] = "%[%d0?%. ??.-%]"
		chn[2] = "%[%d0?%. ??.-%]"
		chn[3] = "%[%d0?%. ????%]"
		chn[4] = "%[%d0?%. ????.-%]"
		chn[5] = "%[%d0?%. ????%]"
		chn[6] = "%[%d0?%. ????.-%]"
	end
	
	local AddMessage = function(frame, text, ...)
		for i = 1, 17 do	
			text = gsub(text, chn[i], rplc[i])
		end
		
		--If Blizz timestamps is enabled, stamp anything it misses
		if CHAT_TIMESTAMP_FORMAT and not text:find("^|r") then
			text = BetterDate(CHAT_TIMESTAMP_FORMAT, time())..text
		end
		text = gsub(text, "%[(%d0?)%. .-%]", "[%1]") --custom channels
		return newAddMsg[frame:GetName()](frame, text, ...)
	end
	
	for i = 1, 10 do
		local fcl = _G[format("%s%d", "ChatFrame", i)]
		--skip combatlog and frames with no messages registered
		if i ~= 2 then -- skip combatlog
			newAddMsg[format("%s%d", "ChatFrame", i)] = fcl.AddMessage
			fcl.AddMessage = AddMessage
		end
	end
end