function onCreate()
	makeLuaSprite('StargazingGround', 'stages/wish/StargazingGround', -175, -75);
	setScrollFactor('StargazingGround', 0.7, 0.7);
	scaleObject('StargazingGround', 1.2, 1.2);

	makeLuaSprite('StargazingSky', 'stages/wish/StargazingSky', -175, -75);
	setScrollFactor('StargazingSky', 0.5, 0.5);
	scaleObject('StargazingSky', 1.2, 1.2);

	setScrollFactor('dadGroup', 0.55, 0.55);

	setObjectOrder('gfGroup', 1)
	setObjectOrder('dadGroup', 1)
	setObjectOrder('StargazingGround', 2)

	addLuaSprite('StargazingSky', false);
	addLuaSprite('StargazingGround', false);

	close(true);
end