function onCreate()
	-- background shit	
	makeLuaSprite('Freezeflame', 'stages/floating/Freezeflame', -175, -175);
	setScrollFactor('Freezeflame', 1, 1);
	scaleObject('Freezeflame', 1.2, 1.2);

	addLuaSprite('Freezeflame', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end