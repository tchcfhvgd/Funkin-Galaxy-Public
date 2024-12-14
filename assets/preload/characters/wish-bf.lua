function onCreate()
	setPropertyFromClass('GameOverSubstate', 'characterName', 'toobad_death');
end

function onGameOverStart()
    setProperty('camFollow.x', 375)
    setProperty('camFollow.y', 500)
end