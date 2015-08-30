----------------------------------------------------------------------------------------
--	KkthnxUI variables
----------------------------------------------------------------------------------------
Kdummy = function() return end
Kname = UnitName("player")
_, Kclass = UnitClass("player")
_, Krace = UnitRace("player")
Kclient = GetLocale()
Kfaction = UnitFactionGroup("player")
Klevel = UnitLevel("player")
Krealm = GetRealmName()
Kuiname = "KkthnxUI_"
Kresolution = GetCVar("gxResolution")
Kscreenheight = tonumber(string.match(Kresolution, "%d+x(%d+)"))
Kscreenhidth = tonumber(string.match(Kresolution, "(%d+)x+%d"))
Kversion = ('v1.0.Release-r3')
Kcolor = RAID_CLASS_COLORS[Kclass]