function onCreate()
	-- background shit	
	makeLuaSprite('OldCosmicBG', 'stages/cosmic/OldCosmicBG', -175, -175);
	setScrollFactor('OldCosmicBG', 1, 1);
	scaleObject('OldCosmicBG', 1.2, 1.2);

	makeLuaSprite('bluecometfilter','stages/cosmic/bluecometfilter',0,0)
	setLuaSpriteScrollFactor('bluecometfilter',160,90)
	addLuaSprite('bluecometfilter',true)

	setObjectCamera('bluecometfilter','camOther')

	setProperty('bluecometfilter.antialiasing',false)
	scaleObject('bluecometfilter',4,4)

	-- sprites that only load if Low Quality is turned off
	if not lowQuality then

                  makeAnimatedLuaSprite('Smoke', 'stages/cosmic/CBF_Smoke', 1100, 340)addAnimationByPrefix('Smoke', 'dance', 'CBF Smoke Idle', 24, true)
                  objectPlayAnimation('Smoke', 'dance', false)
                  setScrollFactor('Smoke', 1, 1);
	setProperty('Smoke.visible', true)

	makeLuaSprite('dadShadow', 'DropShadow', 920, 590);
	scaleObject('dadShadow', 1.25, 1.2);
	setScrollFactor('dadShadow', 1, 1);
	setProperty('dadShadow.visible', true)
	setProperty('dadShadow.alpha', 0.4)

	end

	addLuaSprite('OldCosmicBG', false);
	addLuaSprite('dadShadow', false);
	addLuaSprite('Smoke', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end