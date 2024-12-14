function onCreate()
	makeLuaSprite('pcpGround', 'stages/panic/pcpGround', -650, 0);
	setScrollFactor('pcpGround', 1, 1);
	scaleObject('pcpGround', 1.3, 1.1);

	makeLuaSprite('pcpBG', 'stages/panic/pcpBG', -600, -300);
	setScrollFactor('pcpBG', 0.5, 0.5);
	scaleObject('pcpBG', 1.2, 1.2);

	makeLuaSprite('pcpBG-2', 'stages/panic/pcpBG-2', -600, 0);
	setScrollFactor('pcpBG-2', 0.9, 0.9);
	scaleObject('pcpBG-2', 1.2, 1.2);

	makeLuaSprite('trees', 'stages/panic/pcpTrees', -400, -300);
	setScrollFactor('trees', 0.95, 0.95);
	scaleObject('trees', 1.2, 1.2);

	makeAnimatedLuaSprite('pcpWaterfall', 'stages/panic/pcpWaterfall', -500, -400)
	addAnimationByPrefix('pcpWaterfall', 'idle', 'pcpWaterfall idle', 6, true)
	objectPlayAnimation('pcpWaterfall', 'idle', false)
	setScrollFactor('pcpWaterfall', 0.7, 0.7);
	scaleObject('pcpWaterfall', 1.2, 1.2);
	precacheImage('pcpWaterfall');

	makeAnimatedLuaSprite('bushes', 'stages/panic/pcpBushes', -650, 0)
	addAnimationByPrefix('bushes', 'idle', 'pcpBushes idle', 6, true)
	objectPlayAnimation('bushes', 'idle', false)
	setScrollFactor('bushes', 1, 1);
	scaleObject('bushes', 1.3, 1.1);
	precacheImage('bushes');


	addLuaSprite('pcpBG', false);
	addLuaSprite('pcpWaterfall', false);
	addLuaSprite('pcpBG-2', false);
	addLuaSprite('trees', false);
	addLuaSprite('pcpGround', false);	
	addLuaSprite('bushes', false);
end