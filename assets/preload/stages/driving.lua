heartPoundTime = 1

function onCreate()
	makeLuaSprite('limoSky', 'stages/tutorial/limoSky', -420, -175);
	setScrollFactor('limoSky', 0.00001, 0.00001);
	scaleObject('limoSky', 1.2, 1.2);

	makeLuaSprite('heart', 'stages/tutorial/heart', 80, -30);
	setProperty('heart.alpha', 0.00001, 0.00001);
	setBlendMode('heart', 'add')
	setScrollFactor('heart', 0.2, 0.2);
	scaleObject('heart', 1.2, 1.2);

	makeAnimatedLuaSprite('limoDrive', 'stages/tutorial/limoDrive', -120, 550);
	setScrollFactor('limoDrive', 1, 1);
	addAnimationByPrefix('limoDrive', 'idle', 'Limo stage', 24, true);

	makeAnimatedLuaSprite('bgLimo', 'stages/tutorial/bgLimo', 150, 470);
	setScrollFactor('bgLimo', 0.8, 0.8);
	addAnimationByPrefix('bgLimo', 'idle', 'BG limo', 20, true);

	if getPropertyFromClass('ClientPrefs', 'shaders') == true then
		makeLuaSprite('city', 'stages/tutorial/city', -115, 300);
		setScrollFactor('city', 0.6, 0.6);
		scaleObject('city', 0.5, 0.5);

		makeLuaSprite('gradient', 'stages/tutorial/gradient', -100, -400);
		setProperty('gradient.visible', true)
		scaleObject('gradient', 1.5, 1.5);
		setObjectCamera('gradient', 'camGame')
		setBlendMode("gradient", "add")
		setProperty('gradient.alpha', 0.25)
	end

	addLuaSprite('limoSky', false);

	addLuaSprite('city', false);
	addLuaSprite('bgLimo', false);
	addLuaSprite('limoDrive', false);
	addLuaSprite('gradient', true);

	setProperty('skipCountdown', true)

	makeLuaSprite('blackScreen', '', -5, -5)
	setObjectCamera('blackScreen', 'camOther')
	makeGraphic('blackScreen', screenWidth + 10, screenHeight + 10, '000000')
	addLuaSprite('blackScreen', true)
end

function onUpdate()
	setShaderFloat('city', 'iTime', (-os.clock() * 10))
end

function onCreatePost()
	doTweenX('heartScaleX', 'heart.scale', 1, heartPoundTime, 'quadOut')
	doTweenY('heartScaleY', 'heart.scale', 1, heartPoundTime, 'quadOut')
	setObjectOrder('dadGroup', 1)
	setObjectOrder('heart', 2)
	setScrollFactor('dadGroup', 0.2, 0.2);
	initLuaShader('theMOVINGinator')
	setSpriteShader('city', 'theMOVINGinator')
	--triggerEvent('Camera Follow Pos', '1110', '390')
	setProperty('cameraSpeed', 100)
	triggerEvent('Camera Follow Pos', '1110', '-500')
	setProperty('camHUD.alpha', 0.00001)

	for i = 0, 3 do
		setPropertyFromGroup('strumLineNotes', i, 'visible', false)
	end
	for i = 0, getProperty('unspawnNotes.length') - 1 do
		if not getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
			setPropertyFromGroup('unspawnNotes', i, 'visible', false)
		end
	end
end

function onSongStart()
	introDuration = ((crochet / 1000) * 4) * 5.75
	doTweenAlpha('fadeIn', 'blackScreen', 0.00001, introDuration, 'quadInOut')
	doTweenZoom('startZoom', 'camGame', 0.69, introDuration, 'quadInOut')
	doTweenY('upCameraY', 'camFollow', 320, introDuration / 5.75 * 6, 'quadOut')
end

function onEvent(n, v1, v2)
	if n == 'Heart Pound' then
		doTweenAlpha('heartAlpha', 'heart', 1, heartPoundTime / 4, 'quadOut')
		doTweenX('heartScaleX', 'heart.scale', 1.5, heartPoundTime, 'quadOut')
		doTweenY('heartScaleY', 'heart.scale', 1.5, heartPoundTime, 'quadOut')
		runTimer('heartPoundTimer', heartPoundTime / 3)
	end
end

function onBeatHit()
	if curBeat == 48 or curBeat == 98 or curBeat == 104 then
		triggerEvent('Heart Pound')
	end
end

function onTweenCompleted(tag)
	if tag == 'heartScaleY' then
		doTweenX('heartScaleBackX', 'heart.scale', 1, 0.00001, 'quadOut')
		doTweenY('heartScaleBackY', 'heart.scale', 1, 0.00001, 'quadOut')
	end
end

function onTimerCompleted(tag)
	if tag == 'heartPoundTimer' then
		doTweenAlpha('heartAlpha', 'heart', 0.00001, heartPoundTime / 4, 'quadOut')
	end
end
