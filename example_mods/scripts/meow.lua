local speed = 0.1 -- CHANGE THE SPEED HERE

function onCreate()
	makeLuaSprite('furryMario', 'meow', 0, 0);
	setObjectCamera('furryMario', 'other');
	setProperty('furryMario.alpha', 0.00001)
	addLuaSprite('furryMario', true);
end

function onUpdate()
	if keyboardJustPressed('THREE') then
		setProperty('furryMario.alpha', 1)
		playSound('meow');
		runTimer('wait', 0.3);
	end
end

function onTimerCompleted(tag)
	if tag == 'wait' then
		doTweenAlpha('gdbye', 'furryMario', 0.00001, speed)
	end
end