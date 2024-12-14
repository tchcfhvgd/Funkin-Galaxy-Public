function onCreate()
	makeLuaSprite('BasketLights', 'stages/baller/BasketLights', -1130, -575)
	setScrollFactor('BasketLights', 1, 1)
	setProperty('BasketLights.visible', false)
	setBlendMode('BasketLights', 'add')

	makeLuaSprite('BasketDark', 'stages/baller/BasketDark', -1130, -575)
	setScrollFactor('BasketDark', 1, 1)
	setProperty('BasketDark.visible', false)

	makeLuaSprite('BasketGround', 'stages/baller/BasketGround', -1130, -575)
	setScrollFactor('BasketGround', 1, 1)
	setProperty('BasketGround.visible', true)

	makeLuaSprite('BasketSeats', 'stages/baller/BasketSeats', -1130, -575)
	setScrollFactor('BasketSeats', 0.9, 0.9)
	setProperty('BasketSeats.visible', true)

	makeLuaSprite('BasketBG', 'stages/baller/BasketBG', -1130, -575)
	setScrollFactor('BasketBG', 1, 1)
	setProperty('BasketBG.visible', true)

	makeAnimatedLuaSprite('crowd', 'stages/baller/crowd', -1130, -350)
	addAnimationByPrefix('crowd', 'dance', 'CrowdBG Idle0', 24, true)
	objectPlayAnimation('crowd', 'dance', false)
	setScrollFactor('crowd', 0.9, 0.9)
	scaleObject('crowd', 2, 2)
	setProperty('crowd.visible', true)

	-- sprites that only load if Low Quality is turned off
	if not lowQuality then
		makeAnimatedLuaSprite('crowdfront', 'stages/baller/crowdfront', -1215, 700)
		addAnimationByPrefix('crowdfront', 'dance', 'front crowd bob', 24, true)
		objectPlayAnimation('crowdfront', 'dance', false)
		setScrollFactor('crowdfront', 1.1, 1.1)
		scaleObject('crowdfront', 2, 2)
		setProperty('crowdfront.visible', true)

		makeAnimatedLuaSprite('crowdfront-L', 'stages/baller/crowdfront-L', -1215, 700)
		addAnimationByPrefix('crowdfront-L', 'dance', 'front crowd bob', 24, true)
		objectPlayAnimation('crowdfront-L', 'dance', false)
		setScrollFactor('crowdfront-L', 1.1, 1.1)
		scaleObject('crowdfront-L', 2, 2)
		setProperty('crowdfront-L.visible', false)
	end

	if getPropertyFromClass('ClientPrefs', 'shaders') == true then
		makeLuaSprite('BasketGradient', 'stages/baller/BasketGradient', -1200, -575)
		setScrollFactor('BasketGradient', 1, 1)
		setProperty('BasketGradient.visible', true)
		setBlendMode('BasketGradient', 'add')
	end

	addLuaSprite('BasketBG', false)
	addLuaSprite('BasketSeats', false)
	addLuaSprite('crowd', false)
	addLuaSprite('BasketGround', false)
	addLuaSprite('crowdfront', true)
	addLuaSprite('BasketGradient', true)
	addLuaSprite('BasketDark', false)
	addLuaSprite('BasketLights', true)
	addLuaSprite('crowdfront-L', true)
end
