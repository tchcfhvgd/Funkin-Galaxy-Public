function onCreate()
    setProperty('timeBar.x', 115)
    setProperty('timeBar.y', 585)

    setProperty('timeTxt.x', -50)
    setProperty('timeTxt.y', 540)

    setProperty('scoreTxt.x', -125)
    setProperty('scoreTxt.y', 550)

    scaleObject('timeBar', 1.75, 1);
    scaleObject('timeBarBG', 1.75, 1);

    if getPropertyFromClass('ClientPrefs', 'downScroll') == true then

    setProperty('timeBar.x', 115)
    setProperty('timeBar.y', 545)

    setProperty('timeTxt.x', -50)
    setProperty('timeTxt.y', 500)

    setProperty('scoreTxt.x', -125)
    setProperty('scoreTxt.y', 510)

    end
end