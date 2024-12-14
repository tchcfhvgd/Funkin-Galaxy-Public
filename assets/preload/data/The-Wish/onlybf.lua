function onUpdate()
if opponentMode == true then
	noteTweenX('Dad1', 0, defaultOpponentStrumX0, 0.00001, cubeInOut)
	noteTweenX('Dad2', 1, defaultOpponentStrumX0+112, 0.00001, cubeInOut)
	noteTweenX('Dad3', 2, defaultOpponentStrumX0+112+112, 0.00001, cubeInOut)
	noteTweenX('Dad4', 3, defaultOpponentStrumX0+112+112+112, 0.00001, cubeInOut)
	noteTweenX('BF1', 4, defaultPlayerStrumX0-2000, 0.00001, cubeInOut)
	noteTweenX('BF2', 5, defaultPlayerStrumX0-2000, 0.00001, cubeInOut)
	noteTweenX('BF3', 6, defaultPlayerStrumX0-2000, 0.00001, cubeInOut)
	noteTweenX('BF4', 7, defaultPlayerStrumX0-2000, 0.00001, cubeInOut)
else
	noteTweenX("DadMove1", 0, -1000, 0.00001, cubeInOut)
	noteTweenX("DadMove2", 1, -1000, 0.00001, cubeInOut)
	noteTweenX("DadMove3", 2, -1000, 0.00001, cubeInOut)
	noteTweenX("DadMove4", 3, -1000, 0.00001, cubeInOut)
end
end