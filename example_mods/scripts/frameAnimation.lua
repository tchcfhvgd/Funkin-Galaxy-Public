local EnabledCharacters = {
	'floatmario',
	'floatbf' }
local anims = { 'singLEFT', 'singDOWN', 'singUP', 'singRIGHT' }
function goodNoteHit(id, direction, noteType, isSustainNote)
	if isSustainNote then
		for Characters = 0, #EnabledCharacters do
			if getProperty('boyfriend.curCharacter') == EnabledCharacters[Characters] then
				if string.find(getProperty('boyfriend.animation.curAnim.name'), anims[direction + 1], 0, true) ~= nil then
					setProperty('boyfriend.animation.curAnim.curFrame', 2)
				end
			end
		end
	end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
	if isSustainNote then
		for Characters = 0, #EnabledCharacters do
			if getProperty('dad.curCharacter') == EnabledCharacters[Characters] then
				if string.find(getProperty('dad.animation.curAnim.name'), anims[direction + 1], 0, true) ~= nil then
					setProperty('dad.animation.curAnim.curFrame', 2)
				end
			end
		end
	end
end

