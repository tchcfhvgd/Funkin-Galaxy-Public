-- Cam on Beat :P

function onBeatHit()
    if songName == 'Sports Mix' then
        if curBeat >= 1 and curBeat <= 29 or curBeat >= 32 and curBeat <= 61 or curBeat >= 64 and curBeat <= 125 or curBeat >= 160 and curBeat <= 176 or curBeat >= 196 and curBeat <= 230 or curBeat >= 232 and curBeat <= 263 or curBeat >= 296 and curBeat <= 312 then
            triggerEvent('Add Camera Zoom', '', '') --why the fuck is this not in the sports mix data folder/flez
        end
    end
end

-- TEMPLATE --
--[[if songName == 'name' then
    if curBeat >= (start) and curBeat <= (end) then
        triggerEvent('Add Camera Zoom', '', '')
    end
end]]--
-- TEMPLATE --