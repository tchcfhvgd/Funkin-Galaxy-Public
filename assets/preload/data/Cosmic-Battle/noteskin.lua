function onSongStart()
if opponentMode == true then
	local texture = '' .. 'cosmicnote'
	for i = 0, 3 do setPropertyFromGroup('playerStrums', i, 'texture', texture) end
else
	local texture = '' .. 'cosmicnote'
	for i = 0, 3 do setPropertyFromGroup('opponentStrums', i, 'texture', texture) end
	end
end

function onCreatePost()
	local texture = '' .. 'cosmicnote'

    for i = 0, getProperty('unspawnNotes.length') - 1 do
        if not getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
            setPropertyFromGroup('unspawnNotes', i, 'texture', texture)
        end
    end
end