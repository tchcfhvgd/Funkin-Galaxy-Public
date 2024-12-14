local allowCountdown = false

function onCreate()
	--makes bf be invisible, cuz it'd be dumb to see him before the cutscene plays
	setProperty('boyfriend.alpha', 0);
	runTimer('whoaPrecountdownanim', 0.4, 1)
	runTimer('animPlayed', 2.3, 1)
	runTimer('bfsayingYEAH', 1.65, 1)
	addCharacterToList('bf-galaxy', 'boyfriend');
end



function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'whoaPrecountdownanim' then --timer completed, play anim
		setProperty('boyfriend.alpha', 1);
		characterPlayAnim('boyfriend','entrance',true)--actual anim name
		playSound('pipe', 0.34) --pipe sound effect
	end
	if tag == 'animPlayed' then --timer completed, anim is finished
		triggerEvent('Change Character', 0, 'bf-galaxy'); --put back normal bf with working idle
	end
	if tag == 'bfsayingYEAH' then --timer completed, bf is doing hey pose
		playSound('yeah', 0.69) --bf saying yeah
	end
end