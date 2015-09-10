
local _, KkthnxUIActionbars = ...
local cfg = KkthnxUIActionbars.Config

if (cfg.MainMenuBar.hideGryphons) then
    MainMenuBarLeftEndCap:SetTexCoord(0, 0, 0, 0)
    MainMenuBarRightEndCap:SetTexCoord(0, 0, 0, 0)
end

MainMenuBar:SetScale(cfg.MainMenuBar.scale)
OverrideActionBar:SetScale(cfg.vehicleBar.scale)

-- Bottomleft bar
MultiBarBottomLeft:SetAlpha(cfg.multiBarBottomLeft.alpha)

-- Bottomright bar
MultiBarBottomRight:SetAlpha(cfg.multiBarBottomRight.alpha)

if (cfg.multiBarBottomRight.orderVertical) then
    for i = 2, 12 do
        button = _G['MultiBarBottomRightButton'..i]
        button:ClearAllPoints()
        button:SetPoint('TOP', _G['MultiBarBottomRightButton'..(i - 1)], 'BOTTOM', 0, -6)
    end

    MultiBarBottomRightButton1:HookScript('OnShow', function(self)
        self:ClearAllPoints()

        if (cfg.multiBarBottomRight.verticalPosition == 'RIGHT') then
            self:SetPoint('TOPRIGHT', MultiBarLeftButton1, 'TOPLEFT', -6, 0)
        else
            self:SetPoint('TOPLEFT', UIParent, 'LEFT', 6, (MultiBarBottomRight:GetWidth() / 2))
        end
    end)
end

-- experience bar mouseover text
MainMenuBarExpText:SetFont(cfg.expBar.font, cfg.expBar.fontsize, 'THINOUTLINE')
MainMenuBarExpText:SetShadowOffset(0, 0)

if (cfg.expBar.mouseover) then
    MainMenuBarExpText:SetAlpha(0)

    MainMenuExpBar:HookScript('OnEnter', function()
        securecall('UIFrameFadeIn', MainMenuBarExpText, 0.2, MainMenuBarExpText:GetAlpha(), 1)
    end)

    MainMenuExpBar:HookScript('OnLeave', function()
        securecall('UIFrameFadeOut', MainMenuBarExpText, 0.2, MainMenuBarExpText:GetAlpha(), 0)
    end)
else
    MainMenuBarExpText:Show()
    MainMenuBarExpText.Hide = function() end
end

-- left bar
MultiBarLeft:SetAlpha(cfg.multiBarLeft.alpha)
MultiBarLeft:SetScale(cfg.MainMenuBar.scale)

MultiBarLeft:SetParent(UIParent)

if (cfg.multiBarLeft.orderHorizontal) then
    for i = 2, 12 do
        button = _G['MultiBarLeftButton'..i]
        button:ClearAllPoints()
        button:SetPoint('LEFT', _G['MultiBarLeftButton'..(i - 1)], 'RIGHT', 6, 0)
    end

    MultiBarLeftButton1:HookScript('OnShow', function(self)
        self:ClearAllPoints()

        if (not cfg.MainMenuBar.shortBar) then
            self:SetPoint('BOTTOMLEFT', MultiBarBottomLeftButton1, 'TOPLEFT', 0, 6)
        else
            if (cfg.multiBarRight.orderHorizontal) then
                self:SetPoint('BOTTOMLEFT', MultiBarRightButton1, 'TOPLEFT', 0, 6)
            else
                self:SetPoint('BOTTOMLEFT', MultiBarBottomRightButton1, 'TOPLEFT', 0, 6)
            end

        end
    end)
else
    if (cfg.multiBarRight.orderHorizontal) then
        MultiBarLeftButton1:ClearAllPoints()
        MultiBarLeftButton1:SetPoint('TOPRIGHT', UIParent, 'RIGHT', -6, (MultiBarLeft:GetHeight() / 2))
    else
        MultiBarLeftButton1:ClearAllPoints()
        MultiBarLeftButton1:SetPoint('TOPRIGHT', MultiBarRightButton1, 'TOPLEFT', -6, 0)
    end
end

-- Petbar
PetActionBarFrame:SetFrameStrata('MEDIUM')

PetActionBarFrame:SetScale(cfg.petBar.scale)
PetActionBarFrame:SetAlpha(cfg.petBar.alpha)

   -- horizontal/vertical bars

if (cfg.petBar.vertical) then
    for i = 2, 10 do
        button = _G['PetActionButton'..i]
        button:ClearAllPoints()
        button:SetPoint('TOP', _G['PetActionButton'..(i - 1)], 'BOTTOM', 0, -8)
    end
end

--possessbar
PossessBarFrame:SetScale(cfg.possessBar.scale)
PossessBarFrame:SetAlpha(cfg.possessBar.alpha)

-- reputation bar mouseover text
ReputationWatchStatusBarText:SetFont(cfg.repBar.font, cfg.repBar.fontsize, 'THINOUTLINE')
ReputationWatchStatusBarText:SetShadowOffset(0, 0)

if (cfg.repBar.mouseover) then
    ReputationWatchStatusBarText:SetAlpha(0)

    ReputationWatchBar:HookScript('OnEnter', function()
        securecall('UIFrameFadeIn', ReputationWatchStatusBarText, 0.2, ReputationWatchStatusBarText:GetAlpha(), 1)
    end)

    ReputationWatchBar:HookScript('OnLeave', function()
        securecall('UIFrameFadeOut', ReputationWatchStatusBarText, 0.2, ReputationWatchStatusBarText:GetAlpha(), 0)
    end)
else
    ReputationWatchStatusBarText:Show()
    ReputationWatchStatusBarText.Hide = function() end
end

-- right bar
MultiBarRight:SetAlpha(cfg.multiBarRight.alpha)
MultiBarRight:SetScale(cfg.MainMenuBar.scale)

MultiBarRight:SetParent(UIParent)

if (cfg.multiBarRight.orderHorizontal) then
    for i = 2, 12 do
        button = _G['MultiBarRightButton'..i]
        button:ClearAllPoints()
        button:SetPoint('LEFT', _G['MultiBarRightButton'..(i - 1)], 'RIGHT', 6, 0)
    end

    MultiBarRightButton1:HookScript('OnShow', function(self)
        self:ClearAllPoints()
        self:SetPoint('BOTTOMLEFT', MultiBarBottomRightButton1, 'TOPLEFT', 0, 6)
    end)
else
    MultiBarRightButton1:ClearAllPoints()
    MultiBarRightButton1:SetPoint('TOPRIGHT', UIParent, 'BOTTOMRIGHT', -6, (MultiBarRight:GetHeight() / .99))
end

-- Stancebar
StanceBarFrame:SetFrameStrata('MEDIUM')

StanceBarFrame:SetScale(cfg.stanceBar.scale)
StanceBarFrame:SetAlpha(cfg.stanceBar.alpha)

if (cfg.stanceBar.hide) then
    for i = 1, NUM_STANCE_SLOTS do
        local button = _G['StanceButton'..i]
        button:SetAlpha(0)
        button.SetAlpha = function() end

        button:EnableMouse(false)
        button.EnableMouse = function() end
    end
end

