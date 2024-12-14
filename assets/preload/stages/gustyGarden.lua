function onCreate()
	-- background shit
	makeLuaSprite('BurrowsSpace', 'stages/garden/BurrowsSpace', -800, -365);
	setScrollFactor('BurrowsSpace', 0.1, 0.1);
	scaleObject('BurrowsSpace', 1.75, 1.75);
	setProperty('BurrowsSpace.visible', true)

	makeLuaSprite('BurrowsSpace-pixel', 'stages/garden/BurrowsSpace-pixel', -800, -365);
	setScrollFactor('BurrowsSpace-pixel', 0.1, 0.1);
	scaleObject('BurrowsSpace-pixel', 5.5, 5.5);
	setProperty('BurrowsSpace-pixel.visible', false)
	setProperty('BurrowsSpace-pixel.antialiasing', false)

	makeLuaSprite('BurrowsPlanets', 'stages/garden/BurrowsPlanets', -900, -325);
	setScrollFactor('BurrowsPlanets', 0.4, 0.4);
	scaleObject('BurrowsPlanets', 1.75, 1.75);
	setProperty('BurrowsPlanets.visible', true)

	makeLuaSprite('BurrowsPlanets-pixel', 'stages/garden/BurrowsPlanets-pixel', -900, -325);
	setScrollFactor('BurrowsPlanets-pixel', 0.4, 0.4);
	scaleObject('BurrowsPlanets-pixel', 5.5, 5.5);
	setProperty('BurrowsPlanets-pixel.visible', false)
	setProperty('BurrowsPlanets-pixel.antialiasing', false)
	
	makeLuaSprite('BurrowGround', 'stages/garden/BurrowGround', -800, -365);
	setScrollFactor('BurrowGround', 1, 1);
	scaleObject('BurrowGround', 1.75, 1.75);
	setProperty('BurrowGround.visible', true)

	makeLuaSprite('BurrowGround-pixel', 'stages/garden/BurrowGround-pixel', -800, -325);
	setScrollFactor('BurrowGround-pixel', 1, 1);
	scaleObject('BurrowGround-pixel', 5.5, 5.5);
	setProperty('BurrowGround-pixel.visible', false)
	setProperty('BurrowGround-pixel.antialiasing', false)

	makeAnimatedLuaSprite('PurpleComet', 'stages/garden/PurpleComet', -1350, -650)addAnimationByPrefix('PurpleComet', 'dance', 'Fall', 24, true)
	scaleObject('PurpleComet', 0.8, 0.8);
	objectPlayAnimation('PurpleComet', 'dance', false)
	setScrollFactor('PurpleComet', 0.375, 0.375);
	setProperty('PurpleComet.visible', true)
	setProperty('PurpleComet.alpha', 0.75)

	-- sprites that only load if Low Quality is turned off
	if not lowQuality then

	makeAnimatedLuaSprite('FloatyFluff1', 'stages/garden/FloatyFluff', 800, -165)addAnimationByPrefix('FloatyFluff1', 'dance', 'Spinning', 8, true)
	scaleObject('FloatyFluff1', 2, 2);
	objectPlayAnimation('FloatyFluff1', 'dance', false)
	setScrollFactor('FloatyFluff1', 0.6, 0.6);
	setProperty('FloatyFluff1.visible', true)

	makeAnimatedLuaSprite('FloatyFluff2', 'stages/garden/FloatyFluff', -500, -335)addAnimationByPrefix('FloatyFluff2', 'dance', 'Spinning', 8, true)
	scaleObject('FloatyFluff2', 1.75, 1.75);
	objectPlayAnimation('FloatyFluff2', 'dance', false)
	setScrollFactor('FloatyFluff2', 0.6, 0.6);
	setProperty('FloatyFluff2.visible', true)
	setProperty('FloatyFluff2.flipX', true)

	makeLuaSprite('CosmosGardenFlowerThings-pixel', 'stages/garden/CosmosGardenFlowerThings-pixel', -900, -325);
	setScrollFactor('CosmosGardenFlowerThings-pixel', 0.6, 0.6);
	scaleObject('CosmosGardenFlowerThings-pixel', 5.5, 5.5);
	setProperty('CosmosGardenFlowerThings-pixel.visible', false)
	setProperty('CosmosGardenFlowerThings-pixel.antialiasing', false)

                  makeAnimatedLuaSprite('Rabbit', 'stages/garden/Rabbit', 510, -40)addAnimationByPrefix('Rabbit', 'dance', 'bitch', 24, true)
	scaleObject('Rabbit', 0.8, 0.8);
                  objectPlayAnimation('Rabbit', 'dance', false)
                  setScrollFactor('Rabbit', 1, 1);
	setProperty('Rabbit.visible', true)

                  makeAnimatedLuaSprite('Rabbit-pixel', 'stages/garden/Rabbit-pixel', 380, -140)addAnimationByPrefix('Rabbit-pixel', 'dance', 'bitch', 24, true)
	scaleObject('Rabbit-pixel', 5.8, 5.8);
                  objectPlayAnimation('Rabbit-pixel', 'dance', false)
                  setScrollFactor('Rabbit-pixel', 1, 1);
	setProperty('Rabbit-pixel.visible', true)
	setProperty('Rabbit-pixel.antialiasing', false)

	end

	if getPropertyFromClass('ClientPrefs', 'shaders') == true then

	makeLuaSprite('BasketGradient', 'stages/baller/BasketGradient', -750, -475);
	setScrollFactor('BasketGradient', 1, 1);
	setProperty('BasketGradient.visible', true)
	setBlendMode("BasketGradient", "add")

	end
	
	addLuaSprite('BurrowsSpace-pixel', false);
	addLuaSprite('BurrowsPlanets-pixel', false);
	addLuaSprite('CosmosGardenFlowerThings-pixel', false);
	addLuaSprite('BurrowGround-pixel', false);
	addLuaSprite('Rabbit-pixel', false);
	addLuaSprite('BurrowsSpace', false);
	addLuaSprite('PurpleComet', false);
	addLuaSprite('BurrowsPlanets', false);
	addLuaSprite('FloatyFluff2', false);
	addLuaSprite('FloatyFluff1', false);
	addLuaSprite('BurrowGround', false);
	addLuaSprite('Rabbit', false);
	addLuaSprite('BasketGradient', true);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end