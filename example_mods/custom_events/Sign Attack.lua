function onEvent(n)
	if n == 'Sign Attack' then
		setProperty('dad.x', getProperty('dad.x') - 50)
		setProperty('dad.angle', getProperty('dad.angle') - 25)

        doTweenX('hello', 'dad', getProperty('dad.x') + 50, 0.5, 'quadInOut')
		doTweenAngle('owthathurtsyk', 'dad', getProperty('dad.angle') + 25, 0.5, 'quadInOut')

		triggerEvent('Screen Shake', '0.2,0.04', '');
	end
end