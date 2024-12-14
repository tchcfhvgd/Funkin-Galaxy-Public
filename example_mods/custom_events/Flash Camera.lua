function onEvent(n,v1,v2)


	if n == 'Flash Camera' then

	makeLuaSprite('flash', '', 0, 0);
	makeGraphic('flash', 1280, 720, '000000')
	addLuaSprite('flash', true);
	setLuaSpriteScrollFactor('flash', 0, 0)
	setProperty('flash.scale.x', 10)
	setProperty('flash.scale.y', 10)
	setProperty('flash.alpha',0)
	setProperty('flash.alpha',1)
	setObjectCamera('flash', 'camGame')
	doTweenAlpha('flTw','flash',0,v1,'linear')
	end



end