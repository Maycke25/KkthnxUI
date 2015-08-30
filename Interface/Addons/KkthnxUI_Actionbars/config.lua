
local _, KkthnxUIActionbars = ...

local Font = "Interface\\Addons\\KkthnxUI_Media\\Media\\Fonts\\Unitframe.ttf"

KkthnxUIActionbars.Config = {
    showPicomenu = true,

    button = {
        showVehicleKeybinds = true,
        showKeybinds = true,
        showMacronames = true,

        countFontsize = 13,
        countFont = Font,

        macronameFontsize = 11,
        macronameFont = Font,

        hotkeyFontsize = 13,
        hotkeyFont = Font,
    },

    color = {   -- Red, Green, Blue
        Normal = { 1, 1, 1 },
        IsEquipped = { 0, 1, 0 },

        OutOfRange = { 0.9, 0, 0 },
        OutOfMana = { 0.3, 0.3, 1 },

        NotUsable = { 0.35, 0.35, 0.35 },

        HotKeyText = { 0.6, 0.6, 0.6 },
        MacroText = { 1, 1, 1 },
        CountText = { 1, 1, 1 },
    },

    expBar = {
        mouseover = true,
        fontsize = 12,
        font = Font,
    },

    repBar = {
        mouseover = true,
        fontsize = 12,
        font = Font,
    },

    MainMenuBar = {
        scale = 1,
        hideGryphons = false,

        shortBar = true,
        skinButton = true,

        moveableExtraBars = false,      -- Make the pet, possess, shapeshift and totembar moveable, even when the mainmenubar is not "short"
    },

    vehicleBar = {
        scale = 0.8,
    },

    petBar = {
        mouseover = false,
        scale = 0.90,
        hiddenAlpha = 0,
        alpha = 1,
        vertical = false,
    },

    possessBar = {
        scale = 1,
        alpha = 1,
    },

    stanceBar = {
        mouseover = false,
        hide = false,
        scale = 1,
        alpha = 1,
        hiddenAlpha = 0,
    },

    multiBarLeft = {
        mouseover = false,
        hiddenAlpha = 0,
        alpha = 1,
        orderHorizontal = false,
    },

    multiBarRight = {
        mouseover = false,
        hiddenAlpha = 0,
        alpha = 1,
        orderHorizontal = false,
    },

    multiBarBottomLeft = {
        mouseover = false,
        hiddenAlpha = 0,
        alpha = 1,
    },

    multiBarBottomRight = {
        mouseover = false,
        hiddenAlpha = 0,
        alpha = 1,
        orderVertical = false,
        verticalPosition = 'LEFT', -- 'LEFT' or 'RIGHT'
    },
}
