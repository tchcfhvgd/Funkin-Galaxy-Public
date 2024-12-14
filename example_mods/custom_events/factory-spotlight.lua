function onEvent(name, value1, value2)
    if name == 'factory-spotlight' then
        if value1 == 'on' or value1 == 'On' then

	setProperty('bfSpotlight.visible', true);
	setProperty('dadSpotlight.visible', true);

	doTweenAlpha('ImageFadeOut1', 'ToyTimeBack', 0.05, 0.001, 'linear');
	doTweenAlpha('ImageFadeOut2', 'ToyTimeBackdrop', 0, 0.001, 'linear');
	doTweenAlpha('ImageFadeOut3', 'ToyTimeFloorBg', 0, 0.001, 'linear');
	doTweenAlpha('ImageFadeOut4', 'ToyFloor', 0.25, 0.001, 'linear');

        elseif value1 == 'off' or value1 == 'Off' then

	setProperty('bfSpotlight.visible', false);
	setProperty('dadSpotlight.visible', false);

	doTweenAlpha('ImageFadeIn1', 'ToyTimeBack', 1, 0.001, 'linear');
	doTweenAlpha('ImageFadeIn2', 'ToyTimeBackdrop', 1, 0.001, 'linear');
	doTweenAlpha('ImageFadeIn3', 'ToyTimeFloorBg', 1, 0.001, 'linear');
	doTweenAlpha('ImageFadeIn4', 'ToyFloor', 1, 0.001, 'linear');

        end
    end
end