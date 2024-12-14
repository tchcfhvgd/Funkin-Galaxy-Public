function onCreate()
	doTweenAlpha('bfShadow', 'bfShadow', 0.2, 3, 'cubeInOut');
	makeLuaSprite('sequel', 'sequel', -600, -400);
	addLuaSprite('sequel', false);
	scaleObject('sequel', 0.3, 0.3);

	setObjectCamera('sequel', 'other') --make image not be on UI, but on "other" (since a hide UI event is used right before image shows up)
	setProperty('sequel.alpha', 0); --make the image be invisible
	screenCenter('sequel', 'X') --center the image on the X axis
	screenCenter('sequel', 'Y') --center the image on the Y axis
end

function onStepHit() --there are 16 steps in 1 section I think so using steps is more precise that using beats (there are 4 beats per section)
	if curStep == 64 then
		doTweenY('toddY', 'todd', 195, 0.75, 'cubeInOut');
		doTweenY('maroY', 'maro', 135, 0.75, 'cubeInOut');
	end
	if curStep == 35 then
		doTweenAlpha('ImageFade', 'sequel', 1, 2.75, 'cubeInOut'); --make the text fade in in 1 second
		doTweenAlpha('GUItween', 'camHUD', 0, 2.5, 'cubeInOut');
		doTweenX('ImageScaleX', 'sequel.scale', 0.4, 6, 'linear');
		doTweenY('ImageScaleY', 'sequel.scale', 0.4, 6, 'linear');
	end
	if curStep == 60 then
		doTweenAlpha('ImageFadeOut', 'sequel', 0, 1, 'cubeInOut'); --make the text fade out in 1 second
		doTweenAlpha('GUItween', 'camHUD', 1, 1, 'linear');
	end
end