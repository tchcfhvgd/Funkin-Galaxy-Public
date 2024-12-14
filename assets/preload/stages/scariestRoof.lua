function onCreate()
	setScrollFactor('dadGroup', 0.9, 0.9);

	makeLuaSprite('House', 'stages/roof/foreground', 0, 0);
	setScrollFactor('House', 0.9, 0.9);
	scaleObject('House', 1.3, 1.3);

	makeAnimatedLuaSprite('Star', 'stages/roof/star', 1120, -50)addAnimationByPrefix('Star', 'dance', 'star0', 24, true)
	objectPlayAnimation('Star', 'dance', false)
	setScrollFactor('Star', 0.85, 0.85);
	scaleObject('Star', 1.3, 1.3);

	makeLuaSprite('Skybox', 'stages/roof/bgEffects', -150, -100);
	setScrollFactor('Skybox', 0.1, 0.1);
	setProperty('Skybox.visible', true)
	scaleObject('Skybox', 0.8, 0.8);

	makeLuaSprite("darkoverlay", 'stages/roof/overlay')
	setObjectCamera("darkoverlay",'hud')
	setBlendMode('darkoverlay','multiply')

	
	makeLuaSprite("lightoverlay", 'stages/roof/shine',-300,-200)
	setScrollFactor('lightoverlay', 0.3, 0.1);
	setProperty("lightoverlay.angle", -20)
	scaleObject("lightoverlay", 1.5, 1.5)
	-- setObjectCamera("darkoverlay",'hud')
	setBlendMode('lightoverlay','add')
	setProperty("lightoverlay.alpha", 0.6)
	
	makeLuaSprite('circle','stages/roof/lightCircle',700,400)
	setScrollFactor('circle',1.5,0.5)
	setBlendMode('circle','add')
	scaleObject("circle", 0.4, 0.4)

	makeLuaSprite('circle2','stages/roof/lightCircle',700,380)
	setScrollFactor('circle2',1,0.5)
	setBlendMode('circle2','add')
	scaleObject("circle2", 0.1, 0.1)

	makeLuaSprite('Planets', 'stages/roof/Planets', -100, 0);
	setScrollFactor('Planets', 0.3, 0.3);
	scaleObject('Planets', 0.5, 0.5);

	makeAnimatedLuaSprite('Octoomba', 'stages/roof/Octoomba', 1200, 450)
	addAnimationByPrefix('Octoomba', 'dance', 'Octoomba Idle', 24, false)
	setScrollFactor('Octoomba', 0.9, 0.9);
	scaleObject('Octoomba', 0.5, 0.5);

	addLuaSprite('Skybox', false);
	addLuaSprite('Planets', false);
	addLuaSprite('darkoverlay', true)
	addLuaSprite('lightoverlay', true)
	addLuaSprite('circle', true);
	addLuaSprite('circle2', true);
	addLuaSprite('Star', true);
	addLuaSprite('House', false);
	addLuaSprite('Octoomba', false);

end

function onBeatHit()
	-- if curBeat % 1 == 0 then
		objectPlayAnimation('Octoomba', 'dance', false)
	-- end
end

function onMoveCamera(character)
	if character == 'dad' then
		doTweenAlpha("darkoverlay", "darkoverlay", 0.3, 0.5, "sineIn")
		doTweenAlpha("lightoverlay", "lightoverlay", 0.1, 0.5, "sineIn")
		doTweenAngle("lightoverlay2", "lightoverlay", -45, 2, "quadOut")
		doTweenAlpha("circleoverlay1", "circle", 0.1, 0.5, "sineIn")
		doTweenAlpha("circleoverlay2", "circle2", 0.1, 0.5, "sineIn")
	else
		doTweenAlpha("darkoverlay", "darkoverlay", 0.7, 0.5, "sineIn")
		doTweenAlpha("lightoverlay", "lightoverlay", 0.5, 0.5, "sineIn")
		doTweenAngle("lightoverlay2", "lightoverlay", -20, 2, "quadOut")
		doTweenAlpha("circleoverlay1", "circle", 1, 0.5, "sineIn")
		doTweenAlpha("circleoverlay2", "circle2", 1, 0.5, "sineIn")
	end
end