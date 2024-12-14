function onCreate()
	-- background shit
	makeLuaSprite('BG', 'stages/bedroom/bedroombg', 0, 125);
	setScrollFactor('BG', 1, 1)
	scaleObject('BG', 1.5, 1.5);

	makeLuaSprite('PC', 'stages/bedroom/bedroompc', 0, 125);
	setScrollFactor('PC', 1, 1)
	scaleObject('PC', 1.5, 1.5);

	makeLuaSprite('Bed', 'stages/bedroom/bed', 50, 80);
	setScrollFactor('Bed', 1, 1)
	scaleObject('Bed', 1.5, 1.5);

	makeLuaSprite('Chair', 'stages/bedroom/chair', 670, 485);
	setScrollFactor('Chair', 1, 1)
	scaleObject('Chair', 1.2, 1.2);

	makeLuaSprite('bfSpotlight', 'spotlight', 835, -350);
	scaleObject('bfSpotlight', 0.8, 1);
	setScrollFactor('bfSpotlight', 1, 1);
	setProperty('bfSpotlight.visible', false)
	setProperty('bfSpotlight.alpha', 0.6)

	makeLuaSprite('dadSpotlight', 'spotlight', 130, -350);
	scaleObject('dadSpotlight', 0.8, 1);
	setScrollFactor('dadSpotlight', 1, 1);
	setProperty('dadSpotlight.visible', false)
	setProperty('dadSpotlight.alpha', 0.6)

	-- sprites that only load if Low Quality is turned off
	if not lowQuality then

	makeAnimatedLuaSprite('WarioRobbingGold', 'stages/bedroom/WarioRobbingGold', 1155, 270)addAnimationByPrefix('WarioRobbingGold', 'dance', 'Wario Smoking', 24, true)
	setScrollFactor('WarioRobbingGold', 0.95, 0.95);
	scaleObject('WarioRobbingGold', 0.85, 0.85);
	setProperty('WarioRobbingGold.visible', true)
	setProperty('WarioRobbingGold.flipX', true)

	makeAnimatedLuaSprite('SPG64What', 'stages/bedroom/SPG64Confused', 130, 620)addAnimationByPrefix('SPG64What', 'Idle', 'idle0', 24, true)
	setScrollFactor('SPG64What', 0.95, 0.95);
	scaleObject('SPG64What', 1, 1);
	setProperty('SPG64What.visible', false)
	setProperty('SPG64What.flipX', false)

	makeAnimatedLuaSprite('BFWhat', 'stages/bedroom/BFConfused', 1140, 640)addAnimationByPrefix('BFWhat', 'Idle', 'BF idle dance0', 24, true)
	setScrollFactor('BFWhat', 0.95, 0.95);
	scaleObject('BFWhat', 1, 1);
	setProperty('BFWhat.visible', false)
	setProperty('BFWhat.flipX', false)

	makeLuaSprite('bfShadow', 'DropShadow', 900, 910);
	setScrollFactor('bfShadow', 1, 1);
	setProperty('bfShadow.visible', true)
	setProperty('bfShadow.alpha', 0.2)

	makeLuaSprite('dadShadow', 'DropShadow', 200, 875);
	scaleObject('dadShadow', 1, 1.3);
	setScrollFactor('dadShadow', 1, 1);
	setProperty('dadShadow.visible', true)
	setProperty('dadShadow.alpha', 0.2)

	makeLuaSprite('gfShadow', 'DropShadow', 620, 870);
	scaleObject('gfShadow', 0.75, 0.75);
	setScrollFactor('gfShadow', 1, 1);
	setProperty('gfShadow.visible', true)
	setProperty('gfShadow.alpha', 0.2)

	end

	if getPropertyFromClass('ClientPrefs', 'shaders') == true then

	makeLuaSprite('BasketGradient', 'stages/baller/BasketGradient', -950, -575);
	setScrollFactor('BasketGradient', 1, 1);
	setProperty('BasketGradient.visible', true)
	setBlendMode("BasketGradient", "add")

	makeLuaSprite('gradient', 'stages/tutorial/gradient', -150, 175);
	setScrollFactor('gradient', 1, 1);
	setProperty('gradient.visible', false)
	setBlendMode("gradient", "add")
	setProperty('gradient.alpha', 0.2)

	end

	addLuaSprite('BG', false);
	addLuaSprite('dadShadow', false);
	addLuaSprite('gfShadow', false);
	addLuaSprite('bfShadow', false);
	addLuaSprite('WarioRobbingGold', false);
	addLuaSprite('PC', false);
	addLuaSprite('Bed', false);
	addLuaSprite('Chair', false);
	addLuaSprite('SPG64What', true);
	addLuaSprite('BFWhat', false);
	addLuaSprite('BasketGradient', true);
	addLuaSprite('gradient', true);
	addLuaSprite('bfSpotlight', true);
	addLuaSprite('dadSpotlight', true);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end