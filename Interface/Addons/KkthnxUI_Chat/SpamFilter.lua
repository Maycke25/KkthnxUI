local _, Kchat = ...
local cfg = Kchat.Config

KChatSpamList = {
	-- real spam
	"%.c0m%f[%A]",
	"%S+#%d+", -- BattleTag
	"%d/%d cm gold",
	"%d%s?eur%f[%A]",
	"%d%s?usd%f[%A]",
	"account",
	"boost",
	"cs[:;]go%f[%A]", -- seems to be the new hype
	"delivery",
	"diablo",
	"elite gear",
	"game ?time",
	"g0ld",
	"name change",
	"paypal",
	"professional",
	"qq", -- Chinese IM network, also catches junk as a bonus!
	"ranking",
	"realm",
	"self ?play",
	"server",
	"share",
	"s%A*k%A*y%A*p%Ae", -- spammers love to obfuscate "skype"
	"transfer",
	"wow gold",
	-- pvp
	"[235]v[235]",
	"%f[%a]arena", -- arenacap, arenamate, arenapoints
	"%f[%a]cap%f[%A]",
	"%f[%a]carry%f[%A]",
	"%f[%a]cr%f[%A]",
	"%f[%d][235]s%f[%A]", -- 2s, 3s, 5s
	"conqu?e?s?t? cap",
	"conqu?e?s?t? points",
	"for %ds",
	"lf %ds",
	"low mmr",
	"partner",
	"points cap",
	"punktecap", -- DE
	"pvp ?mate",
	"rating",
	"rbg",
	"season",
	"weekly cap",
	-- junk
	"%[dirge%]",
	"%f[%a]ebay",
	"a?m[eu]rican?", -- america, american, murica
	"an[au][ls]e?r?%f[%L]", -- anal, anus, -e/er/es/en
	"argument",
	"aussie",
	"australi",
	"bacon",
	"bewbs",
	"bitch",
	"boobs",
	"christian",
	"chuck ?norris",
	"girl",
	"kiss",
	"mad ?bro",
	"mudda",
	"muslim",
	"nigg[ae]r?",
	"obama",
	"pussy",
	"sexy",
	"shut ?up",
	"tits",
	"twitch%.tv",
	"webcam",
	"wts.+guild",
	"xbox",
	"youtu%.?be",
	"y?o?ur? m[ao]mm?a",
	"y?o?ur? m[ou]th[ae]r",
	"youtube",
	-- TCG codes
	"hippogryph hatchling",
	"mottled drake",
	"rocket chicken",
}

--[[-----------------------------------------------------------------------------
Systems spam filter
-------------------------------------------------------------------------------]]
if cfg.ChatFilter == true then
	ChatFrame_AddMessageEventFilter("CHAT_MSG_MONSTER_SAY", function() if IsResting() then return true end end)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_MONSTER_YELL", function() if IsResting() then return true end end)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL_JOIN", function() return true end)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL_LEAVE", function() return true end)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL_NOTICE", function() return true end)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_AFK", function() return true end)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_DND", function() return true end)
	DUEL_WINNER_KNOCKOUT = ""
	DUEL_WINNER_RETREAT = ""
	DRUNK_MESSAGE_ITEM_OTHER1 = ""
	DRUNK_MESSAGE_ITEM_OTHER2 = ""
	DRUNK_MESSAGE_ITEM_OTHER3 = ""
	DRUNK_MESSAGE_ITEM_OTHER4 = ""
	DRUNK_MESSAGE_OTHER1 = ""
	DRUNK_MESSAGE_OTHER2 = ""
	DRUNK_MESSAGE_OTHER3 = ""
	DRUNK_MESSAGE_OTHER4 = ""
	DRUNK_MESSAGE_ITEM_SELF1 = ""
	DRUNK_MESSAGE_ITEM_SELF2 = ""
	DRUNK_MESSAGE_ITEM_SELF3 = ""
	DRUNK_MESSAGE_ITEM_SELF4 = ""
	DRUNK_MESSAGE_SELF1 = ""
	DRUNK_MESSAGE_SELF2 = ""
	DRUNK_MESSAGE_SELF3 = ""
	DRUNK_MESSAGE_SELF4 = ""
	ERR_PET_LEARN_ABILITY_S = ""
	ERR_PET_LEARN_SPELL_S = ""
	ERR_PET_SPELL_UNLEARNED_S = ""
	ERR_LEARN_ABILITY_S = ""
	ERR_LEARN_SPELL_S = ""
	ERR_LEARN_PASSIVE_S = ""
	ERR_SPELL_UNLEARNED_S = ""
	ERR_CHAT_THROTTLED = ""
end

local strmatch, strlower, type = string.match, string.lower, type
-- Hide ASCII art crap
if reqLatin and not strmatch(search, "[a-z]") then
	--print("No letters")
	return true
end

-- Don't filter custom channels
if channelID == 0 or type(channelID) ~= "number" then return end

--[[-----------------------------------------------------------------------------
Players spam filter(by Evl, Elv22 and Affli)
-------------------------------------------------------------------------------]]
if cfg.ChatSpam == true then
	-- Repeat spam filter
	local lastMessage
	local function repeatMessageFilter(self, event, text, sender)
		if sender == Kname or UnitIsInMyGuild(sender) then return end
		if not self.repeatMessages or self.repeatCount > 100 then
			self.repeatCount = 0
			self.repeatMessages = {}
		end
		lastMessage = self.repeatMessages[sender]
		if lastMessage == text then
			return true
		end
		self.repeatMessages[sender] = text
		self.repeatCount = self.repeatCount + 1
	end

	ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", repeatMessageFilter)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", repeatMessageFilter)

	-- Gold/portals spam filter
	local SpamList = KChatSpamList
	local function tradeFilter(self, event, text, sender)
		if sender == Kname or UnitIsInMyGuild(sender) then return end
		for _, value in pairs(SpamList) do
			if text:lower():match(value) then
				return true
			end
		end
	end

	ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", tradeFilter)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", tradeFilter)
end