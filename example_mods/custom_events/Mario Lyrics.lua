-- Event notes hooks
function onEvent(name, value1, value2)
    local var string = (value1)
    local var length = tonumber(0 + value2)
    if name == "Mario Lyrics" then

        makeLuaText('yappin', 'Lyrics go here!', 900, 190, 530)
        setTextString('yappin',  '' .. string)
        setTextFont('yappin', 'pixel.otf')
        setTextColor('yappin', '0xE83838')
        setTextSize('yappin', 25);
        addLuaText('yappin')
        setTextAlignment('yappin', 'center')
        setObjectCamera("yappin", 'camOther');
        runTimer('lyricalTho', length, 1)
        --removeLuaText('yappin', true)
        
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'lyricalTho' then
        removeLuaText('yappin', true)
    end
end