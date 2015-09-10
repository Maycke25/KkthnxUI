local K, C, L, _ = unpack(select(2, ...))

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Misdirection -> http://www.wowhead.com/spell=34477
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
if C.announcements.spells == true then
	K.AnnounceSpells = {
		34477,	-- Misdirection
		19801,	-- Tranquilizing Shot
		57934,	-- Tricks of the Trade
		633,	-- Lay on Hands
		20484,	-- Rebirth
		61999,	-- Raise Ally
		20707,	-- Soulstone
		2908,	-- Soothe
	}
end

if C.announcements.badgear == true then
	K.AnnounceBadGear = {
		-- Head
		[1] = {
			88710,	-- Nat's Hat
			33820,	-- Weather-Beaten Fishing Hat
			19972,	-- Lucky Fishing Hat
			46349,	-- Chef's Hat
		},
		-- Neck
		[2] = {
			32757,	-- Blessed Medallion of Karabor
		},
		-- Feet
		[8] = {
			50287,	-- Boots of the Bay
			19969,	-- Nat Pagle's Extreme Anglin' Boots
		},
		-- Back
		[15] = {
			65360,	-- Cloak of Coordination
			65274,	-- Cloak of Coordination
		},
		-- Main-Hand
		[16] = {
			44050,	-- Mastercraft Kalu'ak Fishing Pole
			19970,	-- Arcanite Fishing Pole
			84660,	-- Pandaren Fishing Pole
			84661,	-- Dragon Fishing Pole
			45992,	-- Jeweled Fishing Pole
			86559,	-- Frying Pan
			45991,	-- Bone Fishing Pole
		},
		-- Off-hand
		[17] = {
			86558,	-- Rolling Pin
		},
	}
end