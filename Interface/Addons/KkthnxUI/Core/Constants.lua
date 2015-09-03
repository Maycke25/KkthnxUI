
----------------------------------------------------------------------------------------
--	KkthnxUI variables
----------------------------------------------------------------------------------------
Kdummy = function() return end
Kname = UnitName("player")
_, Kclass = UnitClass("player")
_, Krace = UnitRace("player")
Klevel = UnitLevel("player")
Kclient = GetLocale()
Krealm = GetRealmName()
Kcolor = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[Kclass]