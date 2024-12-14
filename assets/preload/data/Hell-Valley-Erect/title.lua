function onCreate()
	setPropertyFromClass("openfl.Lib", "application.window.title", "Super Funkin' Galaxy 2")
end

function onSongStart()
	doTweenColor('TimerColor', 'timeBar', '0C0552', '0.1', 'linear')
end

function onSectionHit()
	if mustHitSection then
		setProperty('defaultCamZoom', 0.55)
	else
		setProperty('defaultCamZoom', 0.4)
	end
end

function onDestroy()
	setPropertyFromClass("openfl.Lib", "application.window.title", "Super Funkin' Galaxy")
end
