function onCreate()
	-- background shit
	makeLuaSprite('Skybox', 'stages/gooper/sky', -350, -375);
	setScrollFactor('Skybox', 0.7, 0.7);

	makeAnimatedLuaSprite('Background', 'stages/gooper/bg', -350, 0)addAnimationByPrefix('Background', 'dance', 'bg', 24, true)
	objectPlayAnimation('Background', 'dance', false)
	setScrollFactor('Background', 0.8, 0.8);

	makeLuaSprite('Floor', 'stages/gooper/floor', -350, 500);
	setScrollFactor('Floor', 1, 1)

	if getPropertyFromClass('ClientPrefs', 'shaders') == true then

	makeLuaSprite('Overlay', 'stages/gooper/ovl', -900, -600);
	setScrollFactor('Overlay', 1, 1);
	setProperty('Overlay.visible', true)
	setBlendMode("Overlay", "add")
	setProperty('Overlay.alpha', 0.4)

	end

	addLuaSprite('Skybox', false);
	addLuaSprite('Background', false);
	addLuaSprite('Floor', false);
	addLuaSprite('Overlay', true);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end