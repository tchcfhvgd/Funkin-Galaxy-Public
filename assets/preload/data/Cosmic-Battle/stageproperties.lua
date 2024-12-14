function onCreate()

	setProperty('CosmicBG2.visible', false)
	setProperty('dadShadow2.visible', false)
	setProperty('Smoke2.visible', false)
	doTweenAlpha('ImageFadeOut1', 'CosmicBG', 0.5, 0.5, 'linear');
	doTweenAlpha('ImageFadeOut2', 'bluecometfilter', 0.0001, 0.0001, 'linear');

end