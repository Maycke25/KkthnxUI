local K, C, L, _ = unpack(select(2, ...))

-- Main Media options
C["media"] = {
	["normal_font"] = [[Interface\AddOns\KkthnxUI\Media\Fonts\Normal.ttf]],
	["combat_font"] = [[Interface\AddOns\KkthnxUI\Media\Fonts\Damage.ttf]],
	["unitframe_font"] = [[Interface\AddOns\KkthnxUI\Media\Fonts\Unitframe.ttf]],
	["blank_font"] = [[Interface\AddOns\KkthnxUI\Media\Fonts\Invisible.ttf]],
	["texture"] = [[Interface\AddOns\KkthnxUI\Media\Textures\KkthnxTex.tga]],
	["glow"] = [[Interface\AddOns\KkthnxUI\Media\Textures\GlowTex.tga]],
	["blizz"] = [[Interface\AddOns\KkthnxUI\Media\Tooltips\KkthnxBorder.blp]],
	["blank"] = [[Interface\AddOns\KkthnxUI\Media\Textures\Blank.tga]],
	
	["abtextures"] = [[Interface\Addons\KkthnxUI\Media\Actionbars\]],
	["auratextures"] = [[Interface\Addons\KkthnxUI\Media\Buffs\]],
	["bordertextures"] = [[Interface\Addons\KkthnxUI\Media\Border\]],
	
	["whisp_sound"] = [[Interface\AddOns\KkthnxUI\Media\Sounds\Whisper.ogg]],
	["warning_sound"] = [[Interface\AddOns\KkthnxUI\Media\Sounds\Warning.ogg]],
	
	["border_color"] = {0.37, 0.3, 0.3, 1},
	["backdrop_color"] = {0.05, 0.05, 0.05, 1},
	["overlay_color"] = {0, 0, 0, 0.7},
}

-- General options
C["general"] = {
	["auto_scale"] = true,
	["customlagtolerance"] = false,
	["uiscale"] = 0.96,
	["welcome_message"] = true,
}

-- Misc options
C["misc"] = {
	["afkcam"] = true,
	["alreadyknown"] = true,
	["betterlootfilter"] = false,
	["bgspam"] = true,
	["bossbanner"] = true,
	["clickcast"] = false,
	["clickcastfilter"] = false,
	["disenchanting"] = true,
	["enchantscroll"] = true,
	["fadegamemenu"] = true,
	["hattrick"] = true,
	["lfgqueuetimer"] = true,
	["paperdollstats"] = true,
	["professiontabs"] = false,
	["questautobutton"] = false,
	["rarealert"] = false,
	["shortengold"] = true,
	["sumbuyouts"] = false,
}

-- Blizzard options
C["blizzard"] = {
	["altpowerbar"] = true,
	["capturebar"] = true,
	["moveachievements"] = true,
	["moveblizzard"] = true,
	["questbuttonsize"] = 26,
	["repreward"] = true,
}

-- Minimap options
C["minimap"] = {
	["collectbuttons"] = true,
	["enable"] = true,
	["size"] = 150,
}

-- Map options
C["map"] = {
	["exploremap"] = false,
	["fogofwar"] = false,
	["mapbosscount"] = true,
}

-- Buffs / Debuffs options
C["buffs"] = {
	["aurasperrow"] = 12,
	["buffsize"] = 34,
	["debuffsize"] = 44,
	["enable"] = true,
	["paddingx"] = 6,
	["paddingy"] = 6,
}

-- ActionBar options
C["actionbar"] = {
	["enable"] = true,
	["scale"] = 1,
	["showbarart"] = true,
	["showhotkeys"] = true,
	["showmacroname"] = true,
	["skinbuttons"] = true,
}

-- Announcements options
C["announcements"] = {
	["badgear"] = true,
	["drinking"] = false,
	["interrupts"] = true,
	["saysapped"] = true,
	["spells"] = false,
}

-- Panel options
C["toppanel"] = {
	["enable"] = true,
	["height"] = 90,
	["mouseover"] = true,
	["width"] = 250,
}

-- Stats options
C["stats"] = {
	["battleground"] = true,
	["clock"] = true,
	["coords"] = true,
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

-- Combat text options
C["combattext"] = {
	["blizz_head_numbers"] = false,
	["crit_postfix"] = "*",
	["crit_prefix"] = "*",
	["damage"] = true,
	["damage_color"] = true,
	["damage_style"] = true,
	["direction"] = "bottom",
	["dispel"] = true,
	["dk_runes"] = true,
	["dot_damage"] = true,
	["enable"] = true,
	["heal_treshold"] = 1,
	["healing"] = true,
	["icon_size"] = 16,
	["icons"] = true,
	["interrupt"] = true,
	["killingblow"] = false,
	["max_lines"] = 15,
	["merge_aoe_spam"] = true,
	["merge_melee"] = true,
	["pet_damage"] = true,
	["scrollable"] = false,
	["show_hots"] = true,
	["show_overhealing"] = true,
	["time_visible"] = 3,
	["treshold"] = 1,
}

-- Unitframe options
C["unitframe"] = {
	["enable"] = true,
	["classhealth"] = true,
	["classicon"] = true,
	["combatfeedback"] = true,
	["scale"] = 1.2,
	["cbscale"] = 1.2,
	["partyscale"] = 1.2,
	["bossscale"] = 1.2,
	["arenascale"] = 1.2,
}

-- Addonskin options
C["skins"] = {
	["bigwigs"] = false,
	["dbm"] = false,
	["skada"] = false,
	["weakauras"] = false,
}

-- Tooltip options
C["tooltip"] = {
	["enable"] = true,
	["fontoutline"] = false,
	["itemicon"] = true,
	["shortrealm"] = true,
	["hideincombat"] = false,
	["hiderealm"] = false,
	["reactionbordercolor"] = true,
	["qualitybordercolor"] = true,
	["showtitles"] = false,
	["showpvpicons"] = false,
	["mouseovertarget"] = true,
	["cursor"] = false,
	["specicon"] = true,
	
	["healthvalue"] = false,
}

-- Loot options
C["loot"] = {
	["auto_confirm_de"] = true,
	["auto_greed"] = true,
	["icon_size"] = 30,
	["lootframe"] = true,
	["rolllootframe"] = true,
	["width"] = 222,
}

-- Automation options
C["automation"] = {
	["autocollapse"] = true,
	["autoinvite"] = true,
	["autoscreenshot"] = false,
	["collectgarbage"] = true,
	["declineduel"] = true,
	["resurrection"] = true,
	["tabbinder"] = false,
	["openitems"] = false
}

-- Error options
C["error"] = {
	["black"] = true,
	["combat"] = false,
	["white"] = false,
}

-- Chat options
C["chat"] = {
	["bubbles"] = true,
	["channelreplace"] = true,
	["background"] = false,
	["background_alpha"] = 0.7,
	["chatfilter"] = false,
	["chatspam"] = false,
	["combatlog"] = true,
	["damagemeterspam"] = false,
	["enable"] = true,
	["height"] = 112,
	["outline"] = false,
	["sticky"] = true,
	["tabmouseover"] = true,
	["time_color"] = {1, 1, 0},
	["whisp_sound"] = true,
	["width"] = 350,
}