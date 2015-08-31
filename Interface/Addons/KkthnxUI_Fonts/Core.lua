
local NORMAL = [=[Interface\AddOns\KkthnxUI_Media\Media\Fonts\Normal.ttf]=]
local COMBAT = [=[Interface\AddOns\KkthnxUI_Media\Media\Fonts\Damage.ttf]=]

UIDROPDOWNMENU_DEFAULT_TEXT_HEIGHT = 12
CHAT_FONT_HEIGHTS = {11, 12, 13, 14, 15, 16, 17, 18, 19, 20}

UNIT_NAME_FONT     = NORMAL
STANDARD_TEXT_FONT = NORMAL
DAMAGE_TEXT_FONT   = COMBAT

for _, font in pairs({
    GameFontHighlight,

    GameFontDisable,

    GameFontHighlightExtraSmall,
    GameFontHighlightMedium,

    GameFontNormal,
    GameFontNormalSmall,

    TextStatusBarText,

    GameFontDisableSmall,
    GameFontHighlightSmall,
}) do
    font:SetFont(NORMAL, 11)
    font:SetShadowOffset(1, -1)
end

for _, font in pairs({
    AchievementPointsFont,
    AchievementPointsFontSmall,
    AchievementDescriptionFont,
    AchievementCriteriaFont,
    AchievementDateFont,
}) do
    font:SetFont(NORMAL, 11)
end

GameFontNormalHuge:SetFont(NORMAL, 20, 'OUTLINE')
GameFontNormalHuge:SetShadowOffset(0, 0)