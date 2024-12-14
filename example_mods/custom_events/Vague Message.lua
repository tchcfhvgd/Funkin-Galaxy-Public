-- Event notes hooks
function onEvent(name, value1, value2)
    local var string = (value1)
    local var length = tonumber(0 + value2)
    if name == "Vague Message" then

        makeLuaText('yappin', 'Lyrics go here!', 900, 200, 315)
        setTextString('yappin',  '' .. string)
        setTextFont('yappin', 'vcr.ttf')
        setTextColor('yappin', '0xffffff')
        setTextSize('yappin', 60);
        setProperty('yappin.alpha', 0);
        addLuaText('yappin')
        setTextAlignment('yappin', 'center')
        setObjectCamera("yappin", 'camOther');
        runTimer('lyricalTho', length, 1)
        doTweenAlpha('yappinFadeTween', 'yappin', 0.75, 0.5, 'linear');
        --removeLuaText('yappin', true)
        
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'lyricalTho' then
        doTweenAlpha('yappinFadeTween', 'yappin', 0, 0.5, 'linear');
    end
end