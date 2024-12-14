function onUpdate()
if opponentMode == true then
	noteTweenX('Dad1', 0, defaultPlayerStrumX0, 0.00001, cubeInOut)
	noteTweenX('Dad2', 1, defaultPlayerStrumX0+112, 0.00001, cubeInOut)
	noteTweenX('Dad3', 2, defaultPlayerStrumX0+112+112, 0.00001, cubeInOut)
	noteTweenX('Dad4', 3, defaultPlayerStrumX0+112+112+112, 0.00001, cubeInOut)
	noteTweenX('BF1', 4, defaultOpponentStrumX0+2000, 0.00001, cubeInOut)
	noteTweenX('BF2', 5, defaultOpponentStrumX0+2000, 0.00001, cubeInOut)
	noteTweenX('BF3', 6, defaultOpponentStrumX0+2000, 0.00001, cubeInOut)
	noteTweenX('BF4', 7, defaultOpponentStrumX0+2000, 0.00001, cubeInOut)
else
	noteTweenX("DadMove1", 0, -1000, 0.00001, cubeInOut)
	noteTweenX("DadMove2", 1, -1000, 0.00001, cubeInOut)
	noteTweenX("DadMove3", 2, -1000, 0.00001, cubeInOut)
	noteTweenX("DadMove4", 3, -1000, 0.00001, cubeInOut)
end
end