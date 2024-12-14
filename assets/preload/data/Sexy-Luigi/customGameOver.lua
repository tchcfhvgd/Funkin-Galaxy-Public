function onCreate()
	setPropertyFromClass('GameOverSubstate', 'characterName', 'putcharacterjsonnamehere');
	setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'putdeathsoundhere');
end

function onGameOverStart()
	setProperty('camFollow.x', yourxposition)
	setProperty('camFollow.y', youryposition)
end