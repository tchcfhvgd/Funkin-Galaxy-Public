function onCreate()
	-- background shit	
	makeLuaSprite('Purple Coin Lyrics', 'stages/lyrics/Purple Coin Lyrics', -1100, -300);
	setScrollFactor('Purple Coin Lyrics', 1, 1);
	scaleObject('Purple Coin Lyrics', 1.4, 1.4);

	makeLuaSprite('I did this', 'stages/lyrics/I did this', -1100, -300);
	setScrollFactor('I did this', 1, 1);
	scaleObject('I did this', 1.4, 1.4);

	addLuaSprite('Purple Coin Lyrics', false);
	addLuaSprite('I did this', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end