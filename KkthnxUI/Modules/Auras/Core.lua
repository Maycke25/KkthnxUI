local K, C, L, _ = unpack(select(2, ...))

local function CreateSkin(button, type)

    if (not button) or (button and button.Shadow) then return; end
    local isBuff = type == "HELPFUL"
    local isDebuff = type == "HARMFUL"
    local isTemp = type == "TEMPENCH"
    local isConsol = type == "CONSOLIDATED"

    -- All
    local name = button:GetName()
    local icon = _G[name..'Icon']
    local count = button.count
    local duration = button.duration
    --Debuff & TempEnch
    local border = _G[name..'Border']
    --Debuff
    --local symbol = button.symbol --colorblind

    if (isDebuff) then
        button:SetSize(C.buffs.debuffsize, C.buffs.debuffsize)
    else
        button:SetSize(C.buffs.buffsize, C.buffs.buffsize)
    end

    if isConsol then
        icon:ClearAllPoints()
        icon:SetAllPoints(button)
        icon:SetTexCoord(.15, .35, .3, .7)
    else
        icon:SetTexCoord(.05, .95, .05, .95)
    end

    duration:ClearAllPoints()
    duration:SetPoint('BOTTOM', button, 'BOTTOM', 0, -2)
    duration:SetFont(C.font.basic_font, C.font.basic_font_size, C.font.basic_font_style)
    duration:SetShadowOffset(0, 0)
    duration:SetDrawLayer('OVERLAY')

    count:ClearAllPoints()
    count:SetPoint('TOPRIGHT', button)
    count:SetFont(C.font.basic_font, C.font.basic_font_size + 2, C.font.basic_font_style)
    count:SetShadowOffset(0, 0)
    count:SetDrawLayer('OVERLAY')

    if border then -- Debuffs/temps
        border:SetTexture(C.media.auratextures..'TextureDebuff')
        border:SetPoint('TOPRIGHT', button, 1, 1)
        border:SetPoint('BOTTOMLEFT', button, -1, -1)
        border:SetTexCoord(0, 1, 0, 1)
    else            -- buffs
        button.texture = button:CreateTexture(nil, 'ARTWORK')
        button.texture:SetParent(button)
        button.texture:SetTexture(C.media.auratextures..'TextureNormal')
        button.texture:SetPoint('TOPRIGHT', button, 1, 1)
        button.texture:SetPoint('BOTTOMLEFT', button, -1, -1)
        button.texture:SetVertexColor(1, 1, 1, 1)
    end

    button.Shadow = button:CreateTexture(nil, 'BACKGROUND')
    button.Shadow:SetTexture(C.media.auratextures..'TextureShadow')
    button.Shadow:SetPoint('TOPRIGHT', button.texture or border, 3.35, 3.35)
    button.Shadow:SetPoint('BOTTOMLEFT', button.texture or border, -3.35, -3.35)
    button.Shadow:SetVertexColor(0, 0, 0, 1)
end

local function SkinAuraButton(name, index, type)
    local button = _G[name..index]
    CreateSkin(button, type)
end

local function SkinTempEnchant()
    for i = 1, NUM_TEMP_ENCHANT_FRAMES do
        local button = _G['TempEnchant'..i]
        SkinAuraButton('TempEnchant', i, "TEMPENCH")
    end
end

local function UpdateAllBuffAnchors()
    local aboveBuff, previousBuff, index;
    local numBuffs = 0;
    local numRows = 0;
    local slack = BuffFrame.numEnchants;
    local showingConsolidate = ShouldShowConsolidatedBuffFrame()

    TempEnchant1:ClearAllPoints()
    if showingConsolidate then
        TempEnchant1:SetPoint("TOPRIGHT", ConsolidatedBuffs, "TOPLEFT", -C.buffs.paddingx, 0)
        slack = slack + 1
        aboveBuff = ConsolidatedBuffs
    else
        if slack > 0 then
            aboveBuff = TempEnchant1
        end
        TempEnchant1:SetPoint('TOPRIGHT', Minimap, 'TOPLEFT', -15, 0)
    end

    if (BuffFrame.numEnchants > 0) and (not UnitHasVehicleUI("player")) then
        previousBuff = _G['TempEnchant'..BuffFrame.numEnchants]
    elseif showingConsolidate then
        previousBuff = ConsolidatedBuffs
    end

    for i = 1, BUFF_ACTUAL_DISPLAY do
        local buff = _G['BuffButton'..i]

        if (not buff.consolidated) then
            numBuffs = numBuffs + 1;
            index = numBuffs + slack;

            buff:ClearAllPoints()

            -- First buff, not temp enchants or consolidated
            if index == 1 then
                buff:SetPoint("TOPRIGHT", TempEnchant1)
                aboveBuff = buff
            -- First buff on new row
            elseif (index % C.buffs.aurasperrow == 1) then
                buff:SetPoint("TOPRIGHT", aboveBuff, "BOTTOMRIGHT", 0, -C.buffs.paddingy)
                aboveBuff = buff
            else
                buff:SetPoint('TOPRIGHT', previousBuff, 'TOPLEFT', -C.buffs.paddingx, 0)
            end
            previousBuff = buff
        end
    end
end

local function UpdateAllDebuffAnchors(buttonName, index)
    local numBuffs = BUFF_ACTUAL_DISPLAY + BuffFrame.numEnchants;
    if (ShouldShowConsolidatedBuffFrame()) then
        numBuffs = numBuffs + 1; -- consolidated buffs
    end
    
    local rows = ceil(numBuffs/C.buffs.aurasperrow);

    local buff = _G[buttonName..index];
    buff:ClearAllPoints()

    -- Position debuffs
    if (index == 1) then
        -- First button
        local offsetY
        if ( rows < 2 ) then
            offsetY = (C.buffs.paddingy + C.buffs.debuffsize);
        else
            offsetY = rows * (C.buffs.paddingy + C.buffs.buffsize);
        end
        buff:SetPoint("TOPRIGHT", TempEnchant1, "BOTTOMRIGHT", 0, -offsetY);
    elseif ( (index > 1) and ((index % C.buffs.aurasperrow) == 1) ) then
        -- New row
        buff:SetPoint("TOP", _G[buttonName..(index-C.buffs.aurasperrow)], "BOTTOM", 0, -C.buffs.paddingy);
    else
        -- Else anchor to the one on the right
        buff:SetPoint("TOPRIGHT", _G[buttonName..(index-1)], "TOPLEFT", -C.buffs.paddingx, 0);
    end
end

-- Temp Enchant frame
TempEnchant1:ClearAllPoints()
TempEnchant1:SetPoint('TOPRIGHT', Minimap, 'TOPLEFT', -15, 0)
TempEnchant2:ClearAllPoints()
TempEnchant2:SetPoint('TOPRIGHT', TempEnchant1, 'TOPLEFT', -C.buffs.paddingx, 0) 
TempEnchant3:ClearAllPoints()
TempEnchant3:SetPoint("TOPRIGHT", TempEnchant2, "TOPLEFT", -C.buffs.paddingx, 0)

-- Sizing and acnhors
hooksecurefunc('BuffFrame_UpdateAllBuffAnchors', UpdateAllBuffAnchors)
hooksecurefunc("DebuffButton_UpdateAnchors", UpdateAllDebuffAnchors)

BuffFrame:SetScript("OnUpdate", nil)

-- Skinning
SkinTempEnchant()
hooksecurefunc('AuraButton_Update', SkinAuraButton)

-- Consolidate stuff

CreateSkin(ConsolidatedBuffs, "CONSOLIDATED")
ConsolidatedBuffs:ClearAllPoints()
ConsolidatedBuffs:SetPoint('TOPRIGHT', Minimap, 'TOPLEFT', -15, 0)
ConsolidatedBuffsTooltip:SetScale(1.1)