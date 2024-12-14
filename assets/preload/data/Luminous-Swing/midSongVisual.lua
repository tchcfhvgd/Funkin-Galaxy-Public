function onStepHit()
    if curStep == 1280 then
        doTweenAlpha('bleh','darken',0.8,26.5)
        
        triggerEvent('Camera Follow Pos', 690, 455)
        doTweenZoom('zoomOut','camGame',0.5,13.25,'quadInOut')
        doTweenX('left','camFollow',450,13.25, 'quadInOut')
        doTweenY('down', 'camFollow', 500,13.25, 'quadInOut')    
        setProperty('defaultCamZoom', 0.5)
    end
    if curStep == 1408 then
        
        doTweenZoom('zoomOut','camGame',0.7,13.25,'quadInOut')
        doTweenX('left2','camFollow',230,13.25, 'quadInOut')
        doTweenY('up', 'camFollow', 455,13.25, 'quadInOut')
        setProperty('defaultCamZoom', 0.7)
    end
    if curStep == 1584 then
        doTweenAlpha('bleh2','darken',0.001,1.2, 'quadIn')
    end
end