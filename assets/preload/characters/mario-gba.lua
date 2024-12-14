function onCreate()
	setPropertyFromClass('GameOverSubstate', 'characterName', 'mario-gba-death');
	setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'smb2_death');
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'gameOver-pixel');
	setPropertyFromClass('GameOverSubstate', 'endSoundName', 'gameOverEnd-pixel');
end

function onGameOverStart()
    setProperty('camFollow.x', 745)
    setProperty('camFollow.y', 450)
end