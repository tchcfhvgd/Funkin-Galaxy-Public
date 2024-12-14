function onCreate()
	-- background shit
	makeLuaSprite('GustyGardenBG', 'stages/purples/GustySpace', -1500, -700);
	setScrollFactor('GustyGardenBG', 0.4, 0.4)

	makeLuaSprite('GustyGardenFG', 'stages/purples/GustyGround', -850, -160);
	setScrollFactor('GustyGardenFG', 1, 1)

	makeLuaSprite('GustyHedgesFG', 'stages/purples/GustyFGHedge', -930, -450);
	setScrollFactor('GustyHedgesFG', 1.1, 1.1)
	scaleObject('GustyHedgesFG', 0.95, 0.95)

	makeLuaSprite('cometfilter','stages/purples/cometfilter',0,0)
	setLuaSpriteScrollFactor('cometfilter',160,90)
	addLuaSprite('cometfilter',true)

	setObjectCamera('cometfilter','camOther')

	setProperty('cometfilter.antialiasing',false)
	scaleObject('cometfilter',4,4)

	-- sprites that only load if Low Quality is turned off
	if not lowQuality then

	makeAnimatedLuaSprite('Rabbit', 'stages/garden/Rabbit', 985, -120)addAnimationByPrefix('Rabbit', 'dance', 'bitch', 24, true)
	objectPlayAnimation('Rabbit', 'dance', false)
	setScrollFactor('Rabbit', 1, 1);

	makeAnimatedLuaSprite('Goombas', 'stages/purples/Goombas', -775, 325)addAnimationByPrefix('Goombas', 'dance', 'Goombas', 24, true)
	objectPlayAnimation('Goombas', 'dance', false)
	setScrollFactor('Goombas', 1.2, 1.2);

	end

	if getPropertyFromClass('ClientPrefs', 'shaders') == true then

	makeLuaSprite('GustyOverlay', 'stages/purples/GustyOverlay', -850, -860);
	setScrollFactor('GustyOverlay', 1, 1);
	setProperty('GustyOverlay.visible', true)
	setBlendMode("GustyOverlay", "add")

	end

	addLuaSprite('GustyGardenBG', false);
	addLuaSprite('GustyGardenFG', false);
	addLuaSprite('Rabbit', false);
	addLuaSprite('GustyHedgesFG', true);
	addLuaSprite('Goombas', true);
	addLuaSprite('GustyOverlay', true);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end