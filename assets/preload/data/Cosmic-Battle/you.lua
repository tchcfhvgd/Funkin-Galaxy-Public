function onCreatePost()
	if not middlescroll then
		if not downscroll then
			makeAnimatedLuaSprite('your notes', 'you', 60, 20)
			addAnimationByPrefix('your notes', 'idle', 'upscroll')
		else
			makeAnimatedLuaSprite('your notes', 'you', 55, 445)
			addAnimationByPrefix('your notes', 'idle', 'downscroll')
		end
		setObjectCamera('your notes', 'hud')
		scaleObject('your notes', 0.7, 0.7)
		setProperty('your notes.alpha', 0.00001)
		addLuaSprite('your notes', true)
	end
end

function onSongStart()
	if not middlescroll then
		doTweenAlpha('yourNotesIn', 'your notes', 1, (crochet / 1000) * 1, 'quadIn')
		doTweenAlpha('youIn', 'you', 1, (crochet / 1000) * 1, 'quadIn')
	end
end

function onSectionHit()
	if curSection == 4 and not middlescroll then
		doTweenAlpha('yourNotesOut', 'your notes', 0, (crochet / 1000) * 1, 'quadIn')
		doTweenAlpha('youOut', 'you', 0, (crochet / 1000) * 1, 'quadIn')
	end
end
