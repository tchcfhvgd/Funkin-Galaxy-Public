function onCreate()
	makeLuaSprite('flash', '', 0, 0);
	makeGraphic('flash', 1280, 720, '000000')
	addLuaSprite('flash', true);
	setLuaSpriteScrollFactor('flash', 0, 0)
	setProperty('flash.scale.x', 2)
	setProperty('flash.scale.y', 2)
	setProperty('flash.alpha', 0)
	setProperty('flash.alpha', 1)
	setObjectCamera('flash', 'camGame')
	doTweenAlpha('GUItween', 'camHUD', 0, 0.000001, 'linear');
end

function onCreatePost()
	triggerEvent('Camera Follow Pos', '450', '-1000')
	
end

function onSongStart()
	doTweenAlpha('flTw', 'flash', 0, 26.5, 'linear')
	doTweenY('upCameraY', 'camFollow', 450, 26.5, 'quadInOut')
end