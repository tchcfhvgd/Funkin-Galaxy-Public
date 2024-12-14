function onEvent(name, value1)
    if name == 'revolution-pixel' then
        if value1 == 'pixel' then
            setProperty('revSky.visible', false)
            setProperty('revFloor.visible', false)
            setProperty('revMarios.visible', false)
            setProperty('revSky-pixel.visible', true)
            setProperty('revFloor-pixel.visible', true)
            setProperty('revMarios-pixel.visible', true)
            setTextFont('scoreTxt', 'smb1.ttf')
            setTextSize('scoreTxt', '17')
            setTextFont('timeTxt', 'smb1.ttf')
            setTextSize('timeTxt', '25')
            setPropertyFromClass("PlayState", "isPixelStage", true)
        elseif value1 == 'normal' then
            setProperty('revSky.visible', true)
            setProperty('revFloor.visible', true)
            setProperty('revMarios.visible', true)
            setProperty('revSky-pixel.visible', false)
            setProperty('revFloor-pixel.visible', false)
            setProperty('revMarios-pixel.visible', false)
            setTextFont('scoreTxt', 'vcr.ttf')
            setTextSize('scoreTxt', '20')
            setTextFont('timeTxt', 'vcr.ttf')
            setTextSize('timeTxt', '33')
            setPropertyFromClass("PlayState", "isPixelStage", false)
        end
    end
end