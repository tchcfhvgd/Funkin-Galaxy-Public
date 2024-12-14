function onCreate()
	-- background shit
	makeLuaSprite('BG', 'stages/peebs/PeebsRoom', -300, 100);
	setScrollFactor('BG', 1, 1)
	scaleObject('BG', 0.5, 0.5);

	makeLuaSprite('Chair', 'stages/bedroom/chair', 515, 530);
	setScrollFactor('Chair', 1, 1)
	scaleObject('Chair', 1.2, 1.2);

	makeLuaSprite('BuffLuigi', 'stages/peebs/God', -2050, 50);
	setScrollFactor('BuffLuigi', 1, 1)
	setProperty('BuffLuigi.alpha', 0.4)
	scaleObject('BuffLuigi', 1.15, 1.15);

	makeLuaSprite('cometfilter','stages/purples/cometfilter',0,0)
	setLuaSpriteScrollFactor('cometfilter',160,90)
	addLuaSprite('cometfilter',true)

	setObjectCamera('cometfilter','camOther')

	setProperty('cometfilter.visible', false)
	setProperty('cometfilter.antialiasing',false)
	scaleObject('cometfilter',4,4)

	if getPropertyFromClass('ClientPrefs', 'shaders') == true then

	makeLuaSprite('BasketGradient', 'stages/baller/BasketGradient', -350, -300);
	setScrollFactor('BasketGradient', 1, 1);
	setProperty('BasketGradient.visible', true)
	setBlendMode("BasketGradient", "add")

	end

	addLuaSprite('BG', false);
	addLuaSprite('Chair', false);
	addLuaSprite('BuffLuigi', true);
	addLuaSprite('dadShadow', false);
	addLuaSprite('gfShadow', false);
	addLuaSprite('bfShadow', false);
	addLuaSprite('BasketGradient', true);

	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end