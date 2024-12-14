function onCreate()
	makeLuaSprite('TreesFG', 'stages/ghostly/ForegroundTrees', -1880, -275);
	setScrollFactor('TreesFG', 1.6, 1.6);
	scaleObject('TreesFG', 1.7, 1.7);

	makeLuaSprite('RocksFG', 'stages/ghostly/ForegroundRocks', -1380, 875);
	setScrollFactor('RocksFG', 1.2, 1.2);
	scaleObject('RocksFG', 1.5, 1.5);

	makeLuaSprite('Ground', 'stages/ghostly/TeresaMansionGatePlanet', -1480, -285);
	setScrollFactor('Ground', 1, 1);
	scaleObject('Ground', 1.5, 1.5);

	makeLuaSprite('TreesBG', 'stages/ghostly/BackgroundTrees', -525, -585);
	setScrollFactor('TreesBG', 0.975, 0.975);
	scaleObject('TreesBG', 1.5, 1.5);

	makeLuaSprite('Bone', 'stages/ghostly/Bone', -325, -85);
	setScrollFactor('Bone', 0.6, 0.6);
	scaleObject('Bone', 1.5, 1.5);

	makeLuaSprite('Mansion', 'stages/ghostly/TeresaMansion', 200, -85);
	setScrollFactor('Mansion', 0.3, 0.3);
	scaleObject('Mansion', 1.5, 1.5);

	makeLuaSprite('Swirls', 'stages/ghostly/SkySwirls', -1380, -385);
	setScrollFactor('Swirls', 0.1, 0.1);
	scaleObject('Swirls', 1.5, 1.5);

	makeLuaSprite('Skybox', 'stages/ghostly/PhantomSky', -1380, -385);
	setScrollFactor('Skybox', 0.1, 0.1);
	scaleObject('Skybox', 1.5, 1.5);

	if getPropertyFromClass('ClientPrefs', 'shaders') == true then

	makeLuaSprite('Overlay', 'stages/ghostly/PhantomOverlay', -1380, -485);
	setScrollFactor('Overlay', .1, .1);
	setBlendMode("Overlay", "add")
	setProperty('Overlay.alpha', 0.5)

	end

	makeLuaSprite('darken','',-1380,-385)
	makeGraphic('darken',3711,2553,'060270')
	setBlendMode('darken','multiply')
	setProperty('darken.alpha',0.0001)

	makeAnimatedLuaSprite('fire', 'stages/ghostly/fire', 170, 170)
	addAnimationByPrefix('fire', 'fire', 'fire', 24, true)
	scaleObject('fire',0.5,0.5)
	

	makeAnimatedLuaSprite('fire2', 'stages/ghostly/fire', 650, 150)
	addAnimationByPrefix('fire2', 'fire', 'fire', 24, true)
	scaleObject('fire2',0.5,0.5)
	

	addLuaSprite('Skybox', false);
	addLuaSprite('Swirls', false);
	addLuaSprite('Mansion', false);
	addLuaSprite('Bone', false);
	addLuaSprite('TreesBG', false);
	addLuaSprite('Ground', false);
	addLuaSprite('RocksFG', true);
	addLuaSprite('TreesFG', true);
	addLuaSprite('Overlay', true);
	addLuaSprite('darken', true)
	addLuaSprite('fire',true);
	addLuaSprite('fire2',true);

end

function onCreatePost()
    initLuaShader("waves")
 
    setSpriteShader("Swirls", "waves")
end

function onUpdate()
    setShaderFloat("Swirls", "uTime", getSongPosition()/1000)
    setShaderFloat("Swirls", "uWaveAmplitude", 0.01)
    setShaderFloat("Swirls", "uSpeed", 1)
    setShaderFloat("Swirls", "uFrequency", 25)
end