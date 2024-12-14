local path = 'stages/hell/'
local intensity = 50 --how much (how "strong") it flashes
local dur = 2        --duration of the flash, in beats. can be a decimal.
local part1stuff = {
	'Skybox',
	'Cliffside',
	'MainPlatform',
	'LavaOverlay'
}
local part2stuff = {
	'DistantSkybox',
	'DistantCliffside',
	'DistantLava',
	'DistantValley',
	'DistantDebris',
	'DistantPlatform',
	'Overlay'
}
local overlays = {
	'vidOverlay',
	'vidOverlayUp',
	'vidOverlayDown'
}

function onCreate()
	-- background shit
	makeLuaSprite('Skybox', path .. 'erectsky', -1200, -705)
	setScrollFactor('Skybox', 0.1, 0.1)

	makeLuaSprite('Cliffside', path .. 'erectcliffside', -1200, -305)
	setScrollFactor('Cliffside', 0.4, 0.4)

	makeLuaSprite('MainPlatform', path .. 'distantplatform', 400, 575)
	scaleObject('MainPlatform', 1.5, 1.5)

	setObjectOrder('Cliffside', 2)
	setObjectOrder('MainPlatform', 3)

	setObjectOrder('gfGroup', 1)
	setObjectOrder('dadGroup', 1)
	setScrollFactor('gfGroup', 0.375, 0.375)
	setScrollFactor('dadGroup', 0.375, 0.375)

	makeLuaSprite('DistantSkybox', path .. 'distantsky', -1000, -750)
	setScrollFactor('DistantSkybox', 0.1, 0.1)
	scaleObject('DistantSkybox', 1.7, 1.7)

	makeLuaSprite('DistantCliffside', path .. 'distantcliffside', -1000, -150)
	setScrollFactor('DistantCliffside', 0.2, 0.2)
	scaleObject('DistantCliffside', 1.7, 1.7)

	makeLuaSprite('DistantLava', path .. 'distantlava', -1000, -1075)
	setScrollFactor('DistantLava', 0.3, 0.3)
	scaleObject('DistantLava', 1.7, 1.7)

	makeLuaSprite('DistantValley', path .. 'distantvalley', -1000, -100)
	setScrollFactor('DistantValley', 0.5, 0.5)
	scaleObject('DistantValley', 1.7, 1.7)

	makeLuaSprite('DistantDebris', path .. 'distantdebris', -1000, -150)
	setScrollFactor('DistantDebris', 0.6, 0.6)
	scaleObject('DistantDebris', 1.7, 1.7)

	makeLuaSprite('DistantPlatform', path .. 'distantplatform', -625, 385)

	scaleObject('DistantPlatform', 1.7, 1.7)

	if shadersEnabled then
		makeLuaSprite('LavaOverlay', path .. 'erectovl', -1300, -305)
		setProperty('LavaOverlay.visible', true)
		setBlendMode('LavaOverlay', 'add')
		scaleObject('LavaOverlay', 1.2, 1.2)

		makeLuaSprite('Overlay', path .. 'ovl', -1000, -1200)
		setBlendMode('Overlay', 'add')
		scaleObject('Overlay', 1.7, 1.7)
	end

	for i = 1, #part2stuff do --from i==1 to i== number of stuff in part2stuff
		setProperty(part2stuff[i] .. '.visible', false)
	end

	makeLuaSprite('vidOverlay', path .. 'cutsceneOverlay')
	makeLuaSprite('vidOverlayUp', path .. 'cutsceneOverlayGreen')
	makeLuaSprite('vidOverlayDown', path .. 'cutsceneOverlayBlue')
	for i = 1, #overlays do
		setObjectCamera(overlays[i], 'camOverlay')
		screenCenter(overlays[i])
		setSpriteShader(overlays[i], 'adjustColor')
		setProperty(overlays[i] .. '.visible', false)
		setBlendMode(overlays[i], 'screen')
		addLuaSprite(overlays[i], true)
	end

	--makeLuaSprite('redgreenblue')
	--setSpriteShader("", "")

	makeLuaSprite('videoOVLbrightness')

	--[[
	code below is adding every sprite, and only making the last
	sprite of the list (the overlays) above everything.
	not done the best way but its better performance wise now
	]]
	for i = 1, #part1stuff do
		if i == #part1stuff then
			booled = true
		else
			booled = false
		end
		addLuaSprite(part1stuff[i], booled)
	end
	for i = 1, #part2stuff do
		if i == #part2stuff then
			booled = true
		else
			booled = false
		end
		addLuaSprite(part2stuff[i], booled)
	end
	preloadVideo('hell'); --thank you hero
end

function onEvent(n, v1, v2)
	if n == 'Sky Trees' then
		if v1 == 'dark' then
			for i = 1, #part1stuff do
				setProperty(part1stuff[i] .. '.visible', false)
			end
			for i = 1, #part2stuff do
				setProperty(part2stuff[i] .. '.visible', false)
			end
		end
		if v1 == 'default' then
			for i = 1, #part1stuff do
				setProperty(part1stuff[i] .. '.visible', true)
			end
			for i = 1, #part2stuff do
				setProperty(part2stuff[i] .. '.visible', false)
			end
			setScrollFactor('gfGroup', 0.375, 0.375);
			setScrollFactor('dadGroup', 0.375, 0.375);

			doTweenAlpha('BarFadeIn1', 'bar_upper', 1, 0.25, 'quadInOut'); --quadInOut is starting to become my watermark istg
			doTweenAlpha('BarFadeIn2', 'bar_lower', 1, 0.25, 'quadInOut');
		end
		if v1 == 'distant' then
			for i = 1, #part1stuff do
				setProperty(part1stuff[i] .. '.visible', false)
			end
			for i = 1, #part2stuff do
				setProperty(part2stuff[i] .. '.visible', true)
			end
			setScrollFactor('gfGroup', 1, 1);
			setScrollFactor('dadGroup', 1, 1);
		end
		if v1 == 'cutscene' then
			startVideo('hell', 0, 0, 'video')
			setObjectOrder('vidOverlay', 20)
			doTweenAlpha('BarFadeOut1', 'bar_upper', 0, 0.25, 'quadInOut');
			doTweenAlpha('BarFadeOut2', 'bar_lower', 0, 0.25, 'quadInOut');
		end
		if v1 == 'camToggle' then
			if curSection == 68 then
				setProperty('camGame.visible', true)
				setProperty('camHUD.visible', true)
				setProperty('vidOverlay.visible', true)
				cameraFlash('camExtra', '000000', 5)
			end
			if v2 == '1' then
				setProperty('camGame.visible', true)
			end
			if v2 == '0' then
				setProperty('camGame.visible', false)
			end
			if v2 == '2' then
				setProperty('camGame.visible', false)
				setProperty('camHUD.visible', false)
			end
		end
		if v1 == 'boom' then
			if getProperty('videoOVLbrightness.x') ~= 0 then
				cancelTween('whoosh')
			end
			if v2 == 'up' then
				setProperty('vidOverlay.visible', false)
				setProperty('vidOverlayUp.visible', true)
				setProperty('videoOVLbrightness.x', intensity)
				doTweenX('whoosh', 'videoOVLbrightness', -40, ((crochet / 1000) * dur), 'quadOut')
			elseif v2 == 'down' then
				setProperty('vidOverlayUp.visible', false)
				setProperty('vidOverlayDown.visible', true)
				setProperty('videoOVLbrightness.x', intensity)
				doTweenX('whoosh', 'videoOVLbrightness', -150, ((crochet / 1000) * dur), 'quadOut')
			else
				setProperty('vidOverlayDown.visible', false)
				setProperty('vidOverlay.visible', true)
				setProperty('videoOVLbrightness.x', intensity)
				doTweenX('whoosh', 'videoOVLbrightness', 0, (crochet / 1000) * dur, 'quadOut')
			end
		end
		if v1 == 'bigboom' then
			if getProperty('videoOVLbrightness.x') ~= 0 then
				cancelTween('whoosh')
			end
			setProperty('videoOVLbrightness.x', intensity * 1.5)
			doTweenX('whoosh', 'videoOVLbrightness', 0, (crochet / 1000) * dur, 'quadOut')
			doTweenAlpha('voosh', 'vidOverlay', 0, (crochet / 1000) * dur, 'quadOut')
		end
	end
end

function onCreatePost()
	initLuaShader('waves')

	setSpriteShader('DistantLava', 'waves')
end

function onUpdate()
	for i = 1, 3 do
		setShaderFloat(overlays[i], 'brightness', getProperty('videoOVLbrightness.x'))
	end
	setShaderFloat('DistantLava', 'uTime', getSongPosition() / 1000)
	setShaderFloat('DistantLava', 'uWaveAmplitude', 0.01)
	setShaderFloat('DistantLava', 'uSpeed', 1.25)
	setShaderFloat('DistantLava', 'uFrequency', 25)
end
