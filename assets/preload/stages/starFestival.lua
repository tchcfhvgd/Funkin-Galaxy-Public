function onCreate()
	-- background shit
	makeLuaSprite('StarrySky', 'stages/festival/StarrySky', -570, -350);
	setScrollFactor('StarrySky', 1, 1);
	scaleObject('StarrySky', 1.075, 1.075);

	makeLuaSprite('CastleGrounds', 'stages/festival/CastleGrounds', -570, -350);
	setScrollFactor('CastleGrounds', 1, 1);
	scaleObject('CastleGrounds', 1.075, 1.075);

	makeLuaSprite('StarFestival', 'stages/festival/StarFestival', -590, -430);
	setScrollFactor('StarFestival', 1, 1);
	scaleObject('StarFestival', 1.075, 1.075);

	-- sprites that only load if Low Quality is turned off
	if not lowQuality then

	makeAnimatedLuaSprite('Fireworks', 'stages/festival/Fireworks', -570, -350)addAnimationByPrefix('Fireworks', 'dance', 'fireworks', 24, true)
	objectPlayAnimation('Fireworks', 'dance', false)
	setScrollFactor('Fireworks', 1, 1);
	scaleObject('Fireworks', 1.075, 1.075);

	end

	if getPropertyFromClass('ClientPrefs', 'shaders') == true then

	makeLuaSprite('Light', 'stages/festival/Light', -570, -350);
	setScrollFactor('Light', 1, 1);
	scaleObject('Light', 1.5, 1.5);
	setBlendMode("Light", "add")

	end

	addLuaSprite('StarrySky', false);
	addLuaSprite('Fireworks', false);
	addLuaSprite('CastleGrounds', false);
	addLuaSprite('StarFestival', false);
	addLuaSprite('Light', true);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end