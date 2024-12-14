function onCreate()
	setPropertyFromClass('GameOverSubstate', 'characterName', 'bf-dies');
	setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'bffuckingdies');
end

function onGameOverStart()
	setProperty('camFollow.x', 750)
	setProperty('camFollow.y', 500)
end