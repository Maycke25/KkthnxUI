local K, C, L, _ = unpack(KkthnxUI)

if C.misc.afkcam ~= true then return end

local SpinStart = function()
	spinning = true
	MoveViewRightStart(.1)
	UIParent:Hide()
end

local SpinStop = function()
	if not spinning then return end
	spinning = nil
	MoveViewRightStop()
	UIParent:Show()
end

local CameraSpin = CreateFrame('Frame')

CameraSpin:RegisterEvent('PLAYER_ENTERING_WORLD')
CameraSpin:RegisterEvent('PLAYER_LEAVING_WORLD')
CameraSpin:RegisterEvent('PLAYER_FLAGS_CHANGED')

CameraSpin:SetScript('OnEvent', function(self, event, unit)
	if event == 'PLAYER_FLAGS_CHANGED' then
		if unit == 'player' then
			if UnitIsAFK(unit) then
				SpinStart()
			else
				SpinStop()
			end
		end
	elseif event == 'PLAYER_LEAVING_WORLD' then
		SpinStop()
	end
end)