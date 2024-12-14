function onCreate()
    setProperty('camHUD.alpha', 0)
end

function onStepHit()
    if curStep == 63 then
        doTweenAlpha("hud", "camHUD", 1, 0.5, "expoOut")
    end
end