function onCreate()
	-- background shit
	makeLuaSprite('bg', 'stages/ds/bg', -1900, -800);
	scaleObject('bg', 1.3, 1.3);
	setScrollFactor('bg', 0.6, 0,6)

	makeLuaSprite('planetbg', 'stages/ds/planetbg', 1300, -300);
	scaleObject('planetbg', 1, 1);
	setScrollFactor('planetbg', 0.6, 0,6)

	makeLuaSprite('frontrocks', 'stages/ds/frontrocks', 660, 280);
	scaleObject('frontrocks', 1, 1);
	setScrollFactor('frontrocks', 1, 1)

	makeLuaSprite('ground', 'stages/ds/ground', 0, 0);
	scaleObject('ground', 1, 1);
	setScrollFactor('ground', 1, 1)

	makeLuaSprite('star', 'stages/ds/starthing', 890, -330);
	scaleObject('star', 1.4, 1.4);
	setScrollFactor('star', 0.95, 0.95)

	if getPropertyFromClass('ClientPrefs', 'shaders') == true then

	makeLuaSprite('dsovl', 'stages/ds/dsovl', -300, -1300);
	scaleObject('dsovl', 1, 1);
	setProperty('dsovl.alpha', 0.28)
	setBlendMode("dsovl", "overlay")

	end

	addLuaSprite('bg', false);
	addLuaSprite('planetbg', false);
	addLuaSprite('star', false);
	addLuaSprite('ground', false);
	addLuaSprite('frontrocks', true);
	addLuaSprite('dsovl', true);

	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end