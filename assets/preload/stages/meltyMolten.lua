function onCreate()
	-- background shit
	makeLuaSprite('hellsky', 'stages/molten/hellsky', -700, -500);
	setScrollFactor('hellsky', 0.7, 0.9);
	
	makeLuaSprite('hellground', 'stages/molten/hellground', -500, 150);
	setScrollFactor('hellground', 1, 1);

                  makeAnimatedLuaSprite('lava', 'stages/molten/lava', 670, 125)addAnimationByPrefix('lava', 'dance', 'Symbol 15', 6, true)
                  objectPlayAnimation('lava','dance',false)
                  setScrollFactor('lava', 1, 1);
	scaleObject('lava', 1, 1);

	makeAnimatedLuaSprite('hellbop', 'stages/molten/hellbop', -290, 515)addAnimationByPrefix('hellbop', 'dance', 'Symbol 18', 24, true)
                  objectPlayAnimation('hellbop','dance',false)
                  setScrollFactor('hellbop', 1, 1);
	scaleObject('hellbop', 1, 1);

	makeAnimatedLuaSprite('lavafloor', 'stages/molten/lavafloor', 450, 700)addAnimationByPrefix('lavafloor', 'dance', 'Symbol 20', 6, true)
                  objectPlayAnimation('lavafloor','dance',false)
                  setScrollFactor('lavafloor', 1, 1);
	scaleObject('lavafloor', 1, 1);
	
	addLuaSprite('hellbop', true);
	addLuaSprite('lava', true);
	addLuaSprite('hellsky', false);
	addLuaSprite('lavafloor', false);
	addLuaSprite('hellground', false);

	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end