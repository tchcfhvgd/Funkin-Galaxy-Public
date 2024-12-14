function onCreate()
	-- background shit
	makeLuaSprite('RollingSky', 'stages/board/RollingGreenSpace', -600, -400);
	setScrollFactor('RollingSky', 0.7, 0.9)
	scaleObject('RollingSky', 1.2, 1.2);

	makeLuaSprite('RollingClouds', 'stages/board/RollingGreenClod', -600, -300);
	setScrollFactor('RollingClouds', 0.7, 0.9)

	makeLuaSprite('StarshipMario', 'stages/starship/StarshipMario', -300, 100);
	setScrollFactor('StarshipMario', 1, 1)

                  makeAnimatedLuaSprite('wheel', 'stages/starship/wheel', 680, 105);addAnimationByPrefix('wheel', 'dance', 'wheel spin', 24, true)
                  objectPlayAnimation('wheel', 'dance', false)
                  setScrollFactor('wheel', 1, 1);
	setProperty('wheel.visible', true)

	-- sprites that only load if Low Quality is turned off
	if not lowQuality then

                  makeAnimatedLuaSprite('maro', 'stages/starship/maro', -365, 735);addAnimationByPrefix('maro', 'dance', 'mar', 24, true)
                  objectPlayAnimation('maro', 'dance', false)
                  setScrollFactor('maro', 0.9, 0.9);
	setProperty('maro.flipX', true)
	setProperty('maro.visible', true)

                  makeAnimatedLuaSprite('todd', 'stages/starship/todd', 1330, 795);addAnimationByPrefix('todd', 'dance', 'toad', 24, true)
                  objectPlayAnimation('todd', 'dance', false)
                  setScrollFactor('todd', 0.9, 0.9);
	scaleObject('todd', 1.2, 1.2);
	setProperty('todd.visible', true)

	makeLuaSprite('dadShadow', 'DropShadow', 125, 465);
	setScrollFactor('dadShadow', 1, 1);
	setProperty('dadShadow.visible', true)
	setProperty('dadShadow.alpha', 0.2)

	makeLuaSprite('bfShadow', 'DropShadow', 875, 465);
	setScrollFactor('bfShadow', 1, 1);
	setProperty('bfShadow.visible', true)
	setProperty('bfShadow.alpha', 0.2)

	end

	if getPropertyFromClass('ClientPrefs', 'shaders') == true then

	makeLuaSprite('BasketGradient', 'stages/baller/BasketGradient', -350, -900);
	setScrollFactor('BasketGradient', 1, 1);
	setProperty('BasketGradient.visible', true)
	setBlendMode("BasketGradient", "add")

	end

	addLuaSprite('RollingSky', false);
	addLuaSprite('RollingClouds', false);
	addLuaSprite('StarshipMario', false);
	addLuaSprite('wheel', false);
	addLuaSprite('dadShadow', false);
	addLuaSprite('bfShadow', false);
	addLuaSprite('maro', true);
	addLuaSprite('todd', true);
	addLuaSprite('BasketGradient', true);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end