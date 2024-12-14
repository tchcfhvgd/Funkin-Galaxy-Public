function onEvent(name, value1)
    if name == 'garden-pixel' then
        if value1 == 'pixel' then
            setProperty('BurrowsSpace.visible', false)
            setProperty('BurrowsPlanets.visible', false)
            setProperty('BurrowGround.visible', false)
            if not lowQuality then
            setProperty('FloatyFluff1.visible', false)
            setProperty('FloatyFluff2.visible', false)
            setProperty('Rabbit.visible', false)
            end
            setProperty('BurrowsSpace-pixel.visible', true)
            setProperty('BurrowsPlanets-pixel.visible', true)
            setProperty('CosmosGardenFlowerThings-pixel.visible', true)
            setProperty('Rabbit-pixel.visible', true)
            setProperty('BurrowGround-pixel.visible', true)
            setTextFont('scoreTxt', 'smb1.ttf')
            setTextSize('scoreTxt', '17')
            setTextFont('timeTxt', 'smb1.ttf')
            setTextSize('timeTxt', '25')
            setPropertyFromClass("PlayState", "isPixelStage", true)
        elseif value1 == 'normal' then
            setObjectOrder('gfGroup', getObjectOrder('dadGroup')+1)
            setObjectOrder('dadGroup', getObjectOrder('dadGroup')+2)
            setProperty('BurrowsSpace.visible', true)
            setProperty('BurrowsPlanets.visible', true)
            setProperty('BurrowGround.visible', true)
            if not lowQuality then
            setProperty('FloatyFluff1.visible', true)
            setProperty('FloatyFluff2.visible', true)
            setProperty('Rabbit.visible', true)
            end
            setProperty('BurrowsSpace-pixel.visible', false)
            setProperty('BurrowsPlanets-pixel.visible', false)
            setProperty('CosmosGardenFlowerThings-pixel.visible', false)
            setProperty('Rabbit-pixel.visible', false)
            setProperty('BurrowGround-pixel.visible', false)
            setTextFont('scoreTxt', 'vcr.ttf')
            setTextSize('scoreTxt', '20')
            setTextFont('timeTxt', 'vcr.ttf')
            setTextSize('timeTxt', '33')
            setPropertyFromClass("PlayState", "isPixelStage", false)
        elseif value1 == 'shadow' then
            setObjectOrder('gfGroup', getObjectOrder('dadGroup')-5)
            setProperty('bfShadow.visible', true)
        end
    end
end