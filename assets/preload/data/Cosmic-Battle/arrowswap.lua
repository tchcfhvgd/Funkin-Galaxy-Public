function onSongStart()

noteTweenX('bfTween1', 4, 90, 0.01, 'linear');
noteTweenX('bfTween2', 5, 205, 0.01, 'linear');
noteTweenX('bfTween3', 6, 315, 0.01, 'linear');
noteTweenX('bfTween4', 7, 425, 0.01, 'linear');

end

function onCreate()

     if getPropertyFromClass('ClientPrefs', 'middleScroll') == true then

        setPropertyFromClass('ClientPrefs', 'middleScroll', false)

     end
end