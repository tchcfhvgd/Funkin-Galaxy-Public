function onCreate()
	-- background shit
	makeLuaSprite('revSky', 'stages/128/revSky', -500, -135);
	setScrollFactor('revSky', 0.9, 0.9);
	scaleObject('revSky', 1, 1);
	setProperty('revSky.visible', true)

	makeLuaSprite('revSky-pixel', 'stages/128/revSky-pixel', -500, -135);
	setScrollFactor('revSky-pixel', 0.9, 0.9);
	scaleObject('revSky-pixel', 1, 1);
	setProperty('revSky-pixel.antialiasing', false)
	setProperty('revSky-pixel.visible', false)
	
	makeLuaSprite('revFloor', 'stages/128/revFloor', -450, 675);
	setScrollFactor('revFloor', 1, 1);
	setProperty('revFloor.visible', true)

	makeLuaSprite('revFloor-pixel', 'stages/128/revFloor-pixel', -450, 675);
	setScrollFactor('revFloor-pixel', 1, 1);
	scaleObject('revFloor-pixel', 9.2, 9.2);
	setProperty('revFloor-pixel.antialiasing', false)
	setProperty('revFloor-pixel.visible', false)

	makeAnimatedLuaSprite('revMarios', 'stages/128/revMarios', -225, 225)addAnimationByPrefix('revMarios', 'dance', 'marioBop', 24, true)
	objectPlayAnimation('revMarios','dance',false)
	setScrollFactor('revMarios', 1, 1);
	scaleObject('revMarios', 1, 1);
	setProperty('revMarios.visible', true)

	makeAnimatedLuaSprite('revMarios-pixel', 'stages/128/revMarios-pixel', -225, 225)
	objectPlayAnimation('revMarios-pixel','dance',false)
	setScrollFactor('revMarios-pixel', 1, 1);
	scaleObject('revMarios-pixel', 8, 8);
	setProperty('revMarios-pixel.antialiasing', false)
	setProperty('revMarios-pixel.visible', false)
	
	addLuaSprite('revSky-pixel', false);
	addLuaSprite('revFloor-pixel', false);
	addLuaSprite('revMarios-pixel', false);
	addLuaSprite('revSky', false);
	addLuaSprite('revFloor', false);
	addLuaSprite('revMarios', false);

end

function onBeatHit()
	addAnimationByPrefix('revMarios', 'dance', 'marioBop', 24, true)
	objectPlayAnimation('revMarios','dance',false)
	addAnimationByPrefix('revMarios-pixel', 'dance', 'marioBop', 24, true)
	objectPlayAnimation('revMarios-pixel','dance',false)
end