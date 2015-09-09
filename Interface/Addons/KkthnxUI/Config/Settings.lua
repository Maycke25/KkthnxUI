local K, C, L, _ = unpack(select(2, ...))

--[[----------------------------
Media options
--------------------------------]]
C["media"] = {
	["normal_font"] = [[Interface\AddOns\KkthnxUI_Media\Media\Fonts\Normal.ttf]],
	["combat_font"] = [[Interface\AddOns\KkthnxUI_Media\Media\Fonts\Damage.ttf]],
	["unitframe_font"] = [[Interface\AddOns\KkthnxUI_Media\Media\Fonts\Unitframe.ttf]],
	["blank_font"] = [[Interface\AddOns\KkthnxUI_Media\Media\Fonts\Invisible.ttf]],
	["blank"] = [[Interface\AddOns\KkthnxUI_Media\Media\Textures\Blank.tga]],
	["texture"] = [[Interface\Addons\KkthnxUI_Media\Media\Textures\KkthnxTex.tga]],
	["backdrop"] = [[Interface\Addons\KkthnxUI_Media\Media\Textures\Backdrop.blp]],
	["border"] = [[Interface\Addons\KkthnxUI_Media\Media\Textures\Border.tga]],
	["bordershadow"] = [[Interface\Addons\KkthnxUI_Media\Media\Textures\BorderShadow.tga]],
	["whisp_sound"] = [[Interface\AddOns\KkthnxUI_Media\Media\Sounds\Whisper.ogg]],
	["warning_sound"] = [[Interface\AddOns\KkthnxUI_Media\Media\Sounds\Warning.ogg]],
	["border_color"] = {0.37, 0.3, 0.3, 1},
	["backdrop_color"] = {0, 0, 0, 1},
	["overlay_color"] = {0, 0, 0, 0.7},
}

--[[----------------------------
General options
--------------------------------]]
C["general"] = {
	["auto_scale"] = true,
	["uiscale"] = 0.96,
	["welcome_message"] = true,
	["customlagtolerance"] = false,
}

--[[----------------------------
Misc options
--------------------------------]]
C["misc"] = {
	["afkcam"] = true,
	["alreadyknown"] = true,
	["hattrick"] = true,
	["lfgqueuetimer"] = true,
	["shortengold"] = true,
	["bgspam"] = false,
	["bossbanner"] = false,
	["disenchanting"] = false,
	["enchantscroll"] = false,
	["paperdollstats"] = true,
	["professiontabs"] = false,
	["moveobjectivetracker"] = true,
	["styleobjectivetracker"] = true,
}

--[[----------------------------
Blizzard options
--------------------------------]]
C["blizzard"] = {
	["moveachievements"] = true,
	["altpowerbar"] = true,
	["capturebar"] = true,
	["moveblizzard"] = false,
}

--[[----------------------------
Minimap options
--------------------------------]]
C["minimap"] = {
	["enable"] = true,
	["size"] = 130,
	["infoline"] = true,
	["collectbuttons"] = true,
}

--[[----------------------------
Buffs / Debuffs options
--------------------------------]]
C["buffs"] = {
	["enable"] = true,
	["buffbordercolor"] = {1, 1, 1},
	["buffcountsize"] = 16,
	["bufffontsize"] = 14,
	["buffperrow"] = 12,
	["buffscale"] = 1,
	["buffsize"] = 36,
	["debuffcountsize"] = 16,
	["debufffontsize"] = 14,
	["debuffscale"] = 1,
	["debuffsize"] = 40,
	["paddingX"] = 4,
	["paddingY"] = 7,
}

--[[----------------------------
Nameplate options
--------------------------------]]
C["nameplate"] = {
	["enable"] = true,
	["height"] = 9,
	["width"] = 120,
	["ad_height"] = 0,
	["ad_width"] = 0,
	["combat"] = false,
	["health_value"] = false,
	["show_castbar_name"] = false,
	["enhance_threat"] = true,
	["class_icons"] = false,
	["name_abbrev"] = false,
	["good_color"] = {0.2, 0.8, 0.2},
	["near_color"] = {1, 1, 0},
	["bad_color"] = {1, 0, 0},
	["track_auras"] = false,
	["auras_size"] = 22,
	["healer_icon"] = false,
}

--[[----------------------------
Announcements options
--------------------------------]]
C["announcements"] = {
	["saysapped"] = true,
	["interrupts"] = true,
	["bad_gear"] = true,
}

--[[----------------------------
Tooltip options
--------------------------------]]
C["tooltip"] = {
	["enable"] = true,
	["spellid"] = true,
	["tipicons"] = true,
	["fontoutline"] = false,
	["disablefade"] = false,
	["hideincombat"] = false,			
	["userplaced"] = false,
	["reactionbordercolor"] = false,
	["itemqualitybordercolor"] = true,
	["abbrevrealmnames"] = true,
	["hiderealmtext"] = false,
	["showplayertitles"] = false,
	["reactioncoloring"] = false,
	["showunitrole"] = false,
	["showpvpicons"] = false,
	["mouseovertarget"] = true,
	["showspecicon"] = false,
	["showhealthvalue"] = true,
	["customcolor"] = false,
	["healthoutline"] = true,
	["healthformat"] = "$cur / $max",
	["healthfullformat"] = "$cur",
	["textpos"] = "CENTER",
}

--[[----------------------------
Loot options
--------------------------------]]
C["loot"] = {
	["lootframe"] = true,
	["rolllootframe"] = true,
	["icon_size"] = 30,
	["width"] = 222,
	["auto_greed"] = true,
	["auto_confirm_de"] = true,
}

--[[----------------------------
Automation options
--------------------------------]]
C["automation"] = {
	["autocollapse"] = true,
	["autoinvite"] = true,
	["autoscreenshot"] = false,
	["collectgarbage"] = true,
	["declineduel"] = true,
	["resurrection"] = true,
}

--[[----------------------------
Error options
--------------------------------]]
C["error"] = {
	["black"] = true,
	["white"] = false,
	["combat"] = false,
}

--[[----------------------------
Chat options
--------------------------------]]
C["chat"] = {
	["enable"] = true,							-- Enable chat
	["chatfilter"] = true,							-- Removing some systems spam("Player1" won duel "Player2")
	["chatspam"] = true,							-- Removing some players spam(gold/portals/etc)
	["width"] = 350,							-- Chat width
	["height"] = 112,							-- Chat height
	["time_color"] = {1, 1, 0},					-- Timestamp coloring(http://www.december.com/html/spec/colorcodescompact.html)
	["whisp_sound"] = true,						-- Sound when whisper
	["bubbles"] = true,							-- Skin Blizzard chat bubbles
	["combatlog"] = true,						-- Show CombatLog tab
	["tabmouseover"] = true,					-- Chat tabs on mouseover
	["sticky"] = true,							-- Remember last channel
	["damage_meter_spam"] = true,				-- Merge damage meter spam in one line-link
	["channelreplace"] = true,
}