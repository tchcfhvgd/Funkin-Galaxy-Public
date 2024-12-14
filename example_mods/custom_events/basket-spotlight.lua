function onEvent(name, value1, value2)
    if name == 'basket-spotlight' then
        if value1 == 'on' or value1 == 'On' then
            setProperty('BasketDark.visible', true); setProperty('BasketLights.visible', true)
            setProperty('crowdfront-L.visible', true); setProperty('crowdfront.visible', false)
            setProperty('BasketGradient.visible', false)
        elseif value1 == 'off' or value1 == 'Off' then
            setProperty('BasketDark.visible', false); setProperty('BasketLights.visible', false)
            setProperty('crowdfront-L.visible', false); setProperty('crowdfront.visible', true)
            setProperty('BasketGradient.visible', true)
        end
    end
end