function onCreate()
	-- background shit
	makeAnimatedLuaSprite('Space', 'stages/board/RollingGreenGalaxy', -750, -675)addAnimationByPrefix('Space', 'dance', 'TamakoroSpace', 24, true)
	objectPlayAnimation('Space', 'dance', false)
	setScrollFactor('Space', 0.4, 0.4);

	makeAnimatedLuaSprite('Clouds', 'stages/board/RollingGreenGalaxy', -750, -575)addAnimationByPrefix('Clouds', 'dance', 'TamakoroClouds', 24, true)
	objectPlayAnimation('Clouds', 'dance', false)
	setScrollFactor('Clouds', 0.5, 0.5);

	makeAnimatedLuaSprite('Ground', 'stages/board/RollingGreenGalaxy', -750, 75)addAnimationByPrefix('Ground', 'dance', 'TamakoroGround', 24, true)
	objectPlayAnimation('Ground', 'dance', false)
	setScrollFactor('Ground', 1, 1);

	makeAnimatedLuaSprite('Ball', 'stages/board/RollingGreenGalaxy', -755, -720)addAnimationByPrefix('Ball', 'dance', 'Tamakoro0', 24, true)
	objectPlayAnimation('Ball', 'dance', false)
	setScrollFactor('Ball', 1, 1);

	if getPropertyFromClass('ClientPrefs', 'shaders') == true then

	makeLuaSprite('RollingOverlay', 'stages/board/RollingOverlay', -800, -1225);
	setScrollFactor('RollingOverlay', 1, 1);
	setProperty('RollingOverlay.visible', true)
	setBlendMode("RollingOverlay", "add")

	end

	addLuaSprite('Space', false);
	addLuaSprite('Clouds', false);
	addLuaSprite('Ground', false);
	addLuaSprite('Ball', false);
	addLuaSprite('RollingOverlay', true);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end