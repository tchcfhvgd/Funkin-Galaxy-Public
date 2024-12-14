function onCreate()
	-- background shit
	makeLuaSprite('ToyTimeBack', 'stages/factory/ToyTime BG', -600, -300);
	setScrollFactor('ToyTimeBack', 0.9, 0.9)
	scaleObject('ToyTimeBack',1.1, 1.1)

	makeLuaSprite('ToyTimeBackdrop', 'stages/factory/ToyTimeWall', -600, -300);
	setScrollFactor('ToyTimeBackdrop', 0.9, 0.9)
	scaleObject('ToyTimeBackdrop',1.1, 1.1)

	makeLuaSprite('ToyTimeFloorBg', 'stages/factory/ToyTime Behind', -600, -300);
	setScrollFactor('ToyTimeFloorBg', 0.9, 0.9)
	scaleObject('ToyTimeFloorBg',1.1, 1.1)

	makeLuaSprite('ToyFloor', 'stages/factory/ToyTime FG', -600, -300);
	setScrollFactor('ToyFloor', 0.9, 0.9)
	scaleObject('ToyFloor',1.1, 1.1)

	makeLuaSprite('bfSpotlight', 'spotlight', 370, -800);
	scaleObject('bfSpotlight', 0.8, 1);
	setScrollFactor('bfSpotlight', 1, 1);
	setProperty('bfSpotlight.visible', false)
	setProperty('bfSpotlight.alpha', 0.6)

	makeLuaSprite('dadSpotlight', 'spotlight', -390, -800);
	scaleObject('dadSpotlight', 0.8, 1);
	setScrollFactor('dadSpotlight', 1, 1);
	setProperty('dadSpotlight.visible', false)
	setProperty('dadSpotlight.alpha', 0.6)

	-- sprites that only load if Low Quality is turned off
	if not lowQuality then

	makeLuaSprite('gfShadow', 'DropShadow', -15, 420);
	scaleObject('gfShadow', 1.75, 1);
	setScrollFactor('gfShadow', 1, 1);
	setProperty('gfShadow.visible', true)
	setProperty('gfShadow.alpha', 0.2)

	makeLuaSprite('bfShadow', 'DropShadow', 425, 500);
	setScrollFactor('bfShadow', 1, 1);
	setProperty('bfShadow.visible', true)
	setProperty('bfShadow.alpha', 0.2)

	end

	if getPropertyFromClass('ClientPrefs', 'shaders') == true then

	makeLuaSprite('gradient', 'stages/tutorial/gradient', -800, -400);
	setScrollFactor('gradient', 1, 1);
	setProperty('gradient.visible', true)
	setBlendMode("gradient", "add")
	setProperty('gradient.alpha', 0.15)
	scaleObject('gradient', 1.5, 1.5);

	end

	addLuaSprite('ToyTimeBack', false);
	addLuaSprite('ToyTimeBackdrop', false);
	addLuaSprite('ToyTimeFloorBg', false);
	addLuaSprite('ToyFloor', false);
	addLuaSprite('gfShadow', false);
	addLuaSprite('bfShadow', false);
	addLuaSprite('bfSpotlight', true);
	addLuaSprite('dadSpotlight', true);
	addLuaSprite('gradient', true);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end