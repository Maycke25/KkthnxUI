
local _, KkthnxTooltip = ...

KkthnxTooltip.Config = {
    fontSize = 12,
    fontOutline = false,
	
	position = {
        'BOTTOMRIGHT', UIParent, 'BOTTOMRIGHT', -41, 2
    },
	
	TipIcons = true,

    disableFade = false,                        -- Can cause errors or a buggy tooltip!
    showOnMouseover = false,
    hideInCombat = false,                       -- Hide unit frame tooltips during combat
	
	userplaced = false,							-- This is usually for when another bar addon is enabled.

    reactionBorderColor = false,
    itemqualityBorderColor = true,

    abbrevRealmNames = true,
    hideRealmText = false,                      -- Hide the coalesced/interactive realm text
    showPlayerTitles = false,
    showUnitRole = true,
    showPVPIcons = false,                       -- Show pvp icons instead of just a prefix
    showMouseoverTarget = true,
    showSpecializationIcon = true,

    healthbar = {
        showHealthValue = true,

        healthFormat = '$cur / $max',           -- Possible: $cur, $max, $deficit, $perc, $smartperc, $smartcolorperc, $colorperc
        healthFullFormat = '$cur',              -- if the tooltip unit has 100% hp

        fontSize = 12,
        font = 'Fonts\\ARIALN.ttf',
        showOutline = true,
        textPos = 'CENTER',                     -- Possible 'TOP' 'BOTTOM' 'CENTER'

        reactionColoring = false,               -- Overrides customColor
        customColor = {
            apply = false,
            r = 0,
            g = 1,
            b = 1
        }
    },
}
