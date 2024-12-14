function onCreate()
	setPropertyFromClass('GameOverSubstate', 'characterName', 'behindbfgameover');
end

function onGameOverStart()
    setProperty('camFollow.x', 550)
    setProperty('camFollow.y', 450)
end