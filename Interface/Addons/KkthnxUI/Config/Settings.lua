local K, C, L, _ = unpack(select(2, ...))

--[[----------------------------
Media options
--------------------------------]]
C["media"] = {
	["normal_font"] = [[Interface\AddOns\KkthnxUI\Media\Fonts\Normal.ttf]],
	["combat_font"] = [[Interface\AddOns\KkthnxUI\Media\Fonts\Damage.ttf]],
	["unitframe_font"] = [[Interface\AddOns\KkthnxUI\Media\Fonts\Unitframe.ttf]],
	["blank_font"] = [[Interface\AddOns\KkthnxUI\Media\Fonts\Invisible.ttf]],
	["texture"] = [[Interface\AddOns\KkthnxUI\Media\Textures\KkthnxTex.tga]],
	["blank"] = [[Interface\AddOns\KkthnxUI\Media\Textures\Blank.tga]],
	
	["bordernormal"] = [[Interface\Addons\KkthnxUI\Media\Border\BorderNormal.tga]],
	["bordershadow"] = [[Interface\Addons\KkthnxUI\Media\Border\BorderShadow.tga]],
	["borderglow"] = [[Interface\Addons\KkthnxUI\Media\Border\BorderGlow.tga]],
	
	["buffnormal"] = [[Interface\Addons\KkthnxUI\Media\Buffs\TextureNormal.tga]],
	["buffshadow"] = [[Interface\Addons\KkthnxUI\Media\Buffs\TextureShadow.tga]],
	["buffoverlay"] = [[Interface\Addons\KkthnxUI\Media\Buffs\TextureDebuff.tga]],
	
	["whisp_sound"] = [[Interface\AddOns\KkthnxUI\Media\Sounds\Whisper.ogg]],
	["warning_sound"] = [[Interface\AddOns\KkthnxUI\Media\Sounds\Warning.ogg]],
	
	["border_color"] = {0.37, 0.3, 0.3, 1},
	["backdrop_color"] = {0, 0, 0, 1},
	["overlay_color"] = {0, 0, 0, 0.7},
}

--[[----------------------------
General options
--------------------------------]]
C["general"] = {
	["auto_scale"] = true,
	["customlagtolerance"] = false,
	["uiscale"] = 0.96,
	["welcome_message"] = true,
}

--[[----------------------------
Misc options
--------------------------------]]
C["misc"] = {
	["afkcam"] = true,
	["alreadyknown"] = true,
	["betterlootfilter"] = true,
	["bgspam"] = false,
	["bossbanner"] = false,
	["charscurrency"] = false,
	["clickcast"] = false,
	["clickcastfilter"] = false,
	["disenchanting"] = false,
	["enchantscroll"] = false,
	["fadegamemenu"] = true,
	["hattrick"] = true,
	["lfgqueuetimer"] = true,
	["paperdollstats"] = true,
	["professiontabs"] = false,
	["questautobutton"] = false,
	["questautobutton"] = false,
	["shortengold"] = true,
	["sumbuyouts"] = false,
}

--[[----------------------------
Blizzard options
--------------------------------]]
C["blizzard"] = {
	["altpowerbar"] = true,
	["capturebar"] = true,
	["moveachievements"] = true,
	["moveblizzard"] = false,
	["repreward"] = false,
}

--[[----------------------------
Minimap options
--------------------------------]]
C["minimap"] = {
	["collectbuttons"] = true,
	["enable"] = true,
	["size"] = 150,
}

--[[----------------------------
Map options
--------------------------------]]
C["map"] = {
	["mapbosscount"] = false,					-- Show boss count in World Map
	["exploremap"] = false,					-- Tracking Explorer and Lore Master achievements in World Map
	["fogofwar"] = false,						-- Remove fog of war on World Map
}

--[[----------------------------
Buffs / Debuffs options
--------------------------------]]
C["buffs"] = {
	["buffbordercolor"] = {1, 1, 1},
	["buffcountsize"] = 16,
	["bufffontsize"] = 14,
	["buffperrow"] = 12,
	["buffscale"] = 1,
	["buffsize"] = 36,
	["buffsource"] = true,
	["debuffcountsize"] = 16,
	["debufffontsize"] = 14,
	["debuffscale"] = 1,
	["debuffsize"] = 40,
	["enable"] = true,
	["paddingX"] = 4,
	["paddingY"] = 7,
}

--[[----------------------------
ActionBar options
--------------------------------]]
C["actionbar"] = {
	-- Main
	["enable"] = true,
	["buttonsize"] = 25,
}

--[[----------------------------
Nameplate options
--------------------------------]]
C["nameplate"] = {
	["ad_height"] = 0,
	["ad_width"] = 0,
	["auras_size"] = 22,
	["bad_color"] = {1, 0, 0},
	["class_icons"] = false,
	["combat"] = false,
	["enable"] = true,
	["enhance_threat"] = false,
	["good_color"] = {0.2, 0.8, 0.2},
	["healer_icon"] = false,
	["health_value"] = true,
	["height"] = 12,
	["name_abbrev"] = false,
	["near_color"] = {1, 1, 0},
	["show_castbar_name"] = true,
	["track_auras"] = true,
	["width"] = 120,
}

--[[----------------------------
Announcements options
--------------------------------]]
C["announcements"] = {
	["badgear"] = true,
	["drinking"] = false,
	["interrupts"] = true,
	["saysapped"] = true,
	["spells"] = false,
}

--[[----------------------------
Panel options
--------------------------------]]
C["toppanel"] = {
	["enable"] = false,
	["height"] = 90,
	["mouseover"] = false,
	["width"] = 250,
}

--[[----------------------------
Stats options
--------------------------------]]
C["stats"] = {
	["battleground"] = false,
	["clock"] = true,
	["coords"] = false,
	["currency_archaeology"] = false,
	["currency_cooking"] = true,
	["currency_misc"] = true,
	["currency_professions"] = true,
	["currency_pvp"] = true,
	["currency_raid"] = true,
	["durability"] = true,
	["experience"] = true,
	["fps"] = true,
	["friend"] = true,
	["guild"] = true,
	["latency"] = true,
	["location"] = true,
	["memory"] = true,
	
}

--[[----------------------------
Combat text options
--------------------------------]]
C["combattext"] = {
	["enable"] = true,							-- Global enable combat text
	["blizz_head_numbers"] = false,				-- Use blizzard damage/healing output(above mob/player head)
	["damage_style"] = true,					-- Change default damage/healing font above mobs/player heads(you need to restart WoW to see changes)
	["damage"] = true,							-- Show outgoing damage in it's own frame
	["healing"] = true,							-- Show outgoing healing in it's own frame
	["show_hots"] = true,						-- Show periodic healing effects in healing frame
	["show_overhealing"] = true,				-- Show outgoing overhealing
	["pet_damage"] = true,						-- Show your pet damage
	["dot_damage"] = true,						-- Show damage from your dots
	["damage_color"] = true,					-- Display damage numbers depending on school of magic
	["crit_prefix"] = "*",						-- Symbol that will be added before crit
	["crit_postfix"] = "*",						-- Symbol that will be added after crit
	["icons"] = true,							-- Show outgoing damage icons
	["icon_size"] = 16,							-- Icon size of spells in outgoing damage frame, also has effect on dmg font size
	["treshold"] = 1,							-- Minimum damage to show in damage frame
	["heal_treshold"] = 1,						-- Minimum healing to show in incoming/outgoing healing messages
	["scrollable"] = false,						-- Allows you to scroll frame lines with mousewheel
	["max_lines"] = 15,							-- Max lines to keep in scrollable mode(more lines = more memory)
	["time_visible"] = 3,						-- Time(seconds) a single message will be visible
	["dk_runes"] = true,						-- Show deathknight rune recharge
	["killingblow"] = false,					-- Tells you about your killingblows
	["merge_aoe_spam"] = true,					-- Merges multiple aoe damage spam into single message
	["merge_melee"] = true,						-- Merges multiple auto attack damage spam
	["dispel"] = true,							-- Tells you about your dispels(works only with ["damage"] = true)
	["interrupt"] = true,						-- Tells you about your interrupts(works only with ["damage"] = true)
	["direction"] = "bottom",					-- Scrolling Direction("top"(goes down) or "bottom"(goes up))
}

--[[----------------------------
Unitframe options
--------------------------------]]
C["unitframe"] = {
	-- Main
	["enable"] = true,							-- Enable unit frames
}


--[[----------------------------
Tooltip options
--------------------------------]]
C["tooltip"] = {
	["cursor"] = false,
	["enable"] = true,
	["health_value"] = false,
	["hide_combat"] = false,
	["hidebuttons"] = false,
	["item_icon"] = false,
	["shift_modifer"] = false,
	-- Plugins
	["achievements"] = true,
	["arena_experience"] = false,
	["average_lvl"] = false,
	["instance_lock"] = false,
	["item_count"] = false,
	["item_transmogrify"] = false,
	["raid_icon"] = false,
	["rank"] = true,
	["realm"] = true,
	["spell_id"] = false,
	["talents"] = false,
	["target"] = true,
	["title"] = false,
	["unit_role"] = false,
	["who_targetting"] = false,
}

--[[----------------------------
Loot options
--------------------------------]]
C["loot"] = {
	["auto_confirm_de"] = true,
	["auto_greed"] = true,
	["icon_size"] = 30,
	["lootframe"] = true,
	["rolllootframe"] = true,
	["width"] = 222,
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
	["tabbinder"] = false,
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
	["bubbles"] = true,
	["channelreplace"] = true,
	["chatfilter"] = true,
	["chatspam"] = true,
	["combatlog"] = true,
	["damagemeterspam"] = false,
	["enable"] = true,
	["height"] = 112,
	["sticky"] = true,
	["tabmouseover"] = true,
	["time_color"] = {1, 1, 0},
	["whisp_sound"] = true,
	["width"] = 350,
}