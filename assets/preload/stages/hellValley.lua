path = 'stages/hell/'

function onCreate()
	-- background shit
	makeLuaSprite('Skybox', path .. 'sky', -200, -570)
	setScrollFactor('Skybox', 0.1, 0.1)

	makeLuaSprite('Cliffside', path .. 'cliffside', -100, 305)
	setScrollFactor('Cliffside', 0.6, 0.6)

	makeAnimatedLuaSprite('alientext', path .. 'wearethealiens', 300, 250)
	addAnimationByPrefix('alientext', 'ALIEN', 'we are the aliens', 24, false)
	setProperty("alientext.visible", false)
	setObjectCamera('alientext', 'other')

	makeAnimatedLuaSprite('alienz', path .. 'alienz', 200, 100)
	addAnimationByPrefix('alienz', 'alienz', 'alienz0', 24, true)
	setProperty("alienz.visible", false)
	setObjectCamera('alienz', 'extra')
	scaleObject('alienz', 1, 1)
	setProperty('alienz.alpha', 0);

	setObjectOrder('gfGroup', 1)
	setObjectOrder('dadGroup', 1)
	setScrollFactor('gfGroup', 0.55, 0.55)
	setScrollFactor('dadGroup', 0.55, 0.55)
	setObjectOrder('Cliffside', 2)

	if getPropertyFromClass('ClientPrefs', 'shaders') == true then
		makeLuaSprite('Overlay', path .. 'ovl', 0, 0)
		setScrollFactor('Overlay', 1, 1)
		setProperty('Overlay.visible', true)
		setBlendMode("Overlay", "add")
	end

	addLuaSprite('Skybox', false)
	addLuaSprite('Cliffside', false)
	addLuaSprite('Overlay', true)
	addLuaSprite('alientext', true)
	addLuaSprite('alienz', true)
end

function onEvent(n, v1)
	if n == 'Sky Trees' then
        if v1 == 'we are ze aliens' then
            playAnim('alientext', 'ALIEN', false)
            setProperty('alientext.visible', true)
        end
		if v1 == 'goodByeAliens' then
			setProperty('alientext.visible', false)
		end
		if v1 == 'toBeContinued' then
			setProperty('alienz.visible', true)
			setProperty('boyfriend.visible', false)
			setProperty('dad.visible', false)
			setProperty('gf.visible', false)
			setProperty('Cliffside.visible', false)
			setProperty('Skybox.visible', false)
			doTweenAlpha('alienztween', 'alienz', 0.25, 10, 'linear');
			doTweenX('ImageScaleX', 'alienz.scale', 0.8, 16, 'linear');
			doTweenY('ImageScaleY', 'alienz.scale', 0.8, 16, 'linear');
		end
	end
end
