function onEvent(name, value1)
    if name == 'wii-modder' then
        if value1 == 'awesome' then
            setProperty('gradient.visible', true)
            setProperty('BasketGradient.visible', false)
        elseif value1 == 'mid' then
            setProperty('BasketGradient.visible', true)
            setProperty('gradient.visible', false)
            runHaxeCode([[
            game.camHUD.setFilters([]);
            ]])
        elseif value1 == 'dark' then
            doTweenAlpha('FadeOutBG', 'BG', 0.5, 0.5, 'linear');
            doTweenAlpha('FadeOutWario', 'WarioRobbingGold', 0.5, 0.5, 'linear');
            doTweenAlpha('FadeOutPC', 'PC', 0.5, 0.5, 'linear');
            doTweenAlpha('FadeOutBed', 'Bed', 0.5, 0.5, 'linear');
            doTweenAlpha('FadeOutChair', 'Chair', 0.5, 0.5, 'linear');
            doTweenAlpha('FadeOutShadowGF', 'gfShadow', 0.1, 0.5, 'linear');
            doTweenAlpha('FadeOutGF', 'gf', 0.5, 0.5, 'linear');
            setProperty('BasketGradient.visible', false)
            setProperty('bfSpotlight.visible', true)
            setProperty('dadSpotlight.visible', true)
            runHaxeCode([[
            game.camHUD.setFilters([new ShaderFilter(game.getLuaObject("temporaryShader").shader)]);
            ]])
        elseif value1 == 'light' then
            doTweenAlpha('FadeInBG', 'BG', 1, 1, 'cubeInOut');
            doTweenAlpha('FadeInWario', 'WarioRobbingGold', 1, 1, 'cubeInOut');
            doTweenAlpha('FadeInPC', 'PC', 1, 1, 'cubeInOut');
            doTweenAlpha('FadeInBed', 'Bed', 1, 1, 'cubeInOut');
            doTweenAlpha('FadeInChair', 'Chair', 1, 1, 'cubeInOut');
            doTweenAlpha('FadeInShadowGF', 'gfShadow', 0.2, 1, 'cubeInOut');
            doTweenAlpha('FadeInGF', 'gf', 1, 1, 'cubeInOut');
            setProperty('BasketGradient.visible', true)
            setProperty('bfSpotlight.visible', false)
            setProperty('dadSpotlight.visible', false)
        end
    end
end