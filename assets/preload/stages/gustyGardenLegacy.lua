function onCreate()

	makeLuaSprite('Planet', 'stages/legacy/CosmosGardenPlanet', -540, 695);
	scaleObject('Planet', 1, 1)

	makeLuaSprite('Tree', 'stages/legacy/CosmosGardenTree', 370, -250);
	setLuaSpriteScrollFactor('Tree', 1, 1);

	makeLuaSprite('FloatyFluffs', 'stages/legacy/CosmosGardenFlowerThings',  -1100, -600);
	setLuaSpriteScrollFactor('FloatyFluffs', 0.3, 0.3);
	scaleObject('FloatyFluffs', 0.9, 0.9)

	makeLuaSprite('Skybox', 'stages/legacy/CosmosGardenSkybox', -1010, -502);
	setLuaSpriteScrollFactor('Skybox', 0.2, 0.2);
	scaleObject('Skybox', 0.80, 0.80)

	makeAnimatedLuaSprite('WorthlessRabbit', 'stages/legacy/WorthlessRabbitLol', -301, 140) 
	addAnimationByPrefix('WorthlessRabbit', 'idle', 'Star Bunny');
	setLuaSpriteScrollFactor('WorthlessRabbit', 0.9, 0.9);

	addLuaSprite('Skybox', false);
	addLuaSprite('FloatyFluffs', false);
	addLuaSprite('Tree', false);
	addLuaSprite('WorthlessRabbit', false);
	addLuaSprite('Planet', false);

end