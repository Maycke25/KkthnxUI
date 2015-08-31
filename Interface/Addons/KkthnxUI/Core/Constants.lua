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
Kresolution = GetCVar("gxResolution")
Kscreenheight = tonumber(string.match(Kresolution, "%d+x(%d+)"))
Kscreenwidth = tonumber(string.match(Kresolution, "(%d+)x+%d"))
Kcolor = RAID_CLASS_COLORS[Kclass]