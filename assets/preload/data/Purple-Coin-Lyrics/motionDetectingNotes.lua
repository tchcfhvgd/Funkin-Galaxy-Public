--this script will dim the player's and opponent's strumlines when there's no notes on their lane (made by kornelbut)
--maybe we could use this on other songs too cuz here its only used to make the notes slide in lol
--customizable variables here!!!!!!!!!!!!!!!!!!!!!!!!!!!!
local MainOptions = {
	dontDoTheScript = false, --set to true if you don't want this script to work
	plOnly = false, --set to true if you only want player's strum to dim
	opOnly = false, --set to true if you only want opponent's strum to dim
	dimMode = false, --set to true to have strums dim
	hideMode = true, --set to true to have strums hide
	appearSpeed = 1, --speed of strums appearing
	disappearSpeed = 0.3, --speed of strums disappearing
}

--for dim mode
local DimOptions = {
	undimOpacity = 0.8, --opacity of strums when notes are on-screen
	dimOpacity = 0.1, --opacity of strums when notes aren't on-screen
	undimDuration = 1.25, --duration time for strums undimming --originally 0.25
	dimDuration = 1.25, --duration time for strums dimming --originally 0.25
	undimEase = 'sineOut',
	dimEase = 'sineOut',
}

--for hide mode
local HideOptions = {
	showDuration = 1, --duration time for strums showing --originally 0.7
	hideDuration = 0.7,  --duration time for strums hiding
	showEase = 'smootherStepOut',
	hideEase = 'smootherStepIn',
}

local plNotes, opNotes = 0, 0
local nuhuh, nuhuh1 = false, false

function onCreate()
	--[[ if you put this file in the scripts folder but want it to behave differently in specific songs, remove the comment and change your songPath to your song's name and the variables accordingly
	if songPath == "insert your song data folder name" then
		insert variables
	end
	]]
	if not MainOptions.dontDoTheScript then
		setProperty('skipArrowStartTween', true) 
	end
end

function onCreatePost()
	if not MainOptions.dontDoTheScript then
		if MainOptions.hideMode and not MainOptions.dimMode then
			for i = 0,3 do
				setPropertyFromGroup('playerStrums', i, 'alpha', 0.8)
				setPropertyFromGroup('opponentStrums', i, 'alpha', 0.8)
			end
		end
		for i = 0,3 do
			if not MainOptions.opOnly then
				if MainOptions.dimMode then
					setPropertyFromGroup('playerStrums', i, 'alpha', DimOptions.dimOpacity)
				end
				if MainOptions.hideMode then
					if not downscroll then
						setPropertyFromGroup('playerStrums', i, 'y', _G['defaultPlayerStrumY'..i] - 200)
					else
						setPropertyFromGroup('playerStrums', i, 'y', _G['defaultPlayerStrumY'..i] + 200)
					end
				end
			else
				if MainOptions.dimMode then
					setPropertyFromGroup('playerStrums', i, 'alpha', DimOptions.undimOpacity)
				end
				if MainOptions.hideMode then
					setPropertyFromGroup('playerStrums', i, 'y', _G['defaultPlayerStrumY'..i])
				end
			end
			if not MainOptions.plOnly then
				if MainOptions.dimMode then
					setPropertyFromGroup('opponentStrums', i, 'alpha', DimOptions.dimOpacity)
				end
				if MainOptions.hideMode then
					if not downscroll then
						setPropertyFromGroup('opponentStrums', i, 'y', _G['defaultOpponentStrumY'..i] - 200)
					else
						setPropertyFromGroup('opponentStrums', i, 'y', _G['defaultOpponentStrumY'..i] + 200)			
					end
				end
			else
				if MainOptions.dimMode then
					setPropertyFromGroup('opponentStrums', i, 'alpha', DimOptions.undimOpacity)
				end
				if MainOptions.hideMode then
					setPropertyFromGroup('opponentStrums', i, 'y', _G['defaultOpponentStrumY'..i])
				end
			end
		end
	end
end

function onSpawnNote(id, direction, type, holdNote)
	if not MainOptions.dontDoTheScript and not getPropertyFromGroup('unspawnNotes', i, 'ignoreNote') then
		if not getPropertyFromGroup('unspawnNotes', i, 'mustPress') and not MainOptions.plOnly then
			opNotes = opNotes + 1
			if nuhuh == false then
				runTimer('opWait', MainOptions.appearSpeed, 1)
			end
			nuhuh = true
		elseif getPropertyFromGroup('unspawnNotes', i, 'mustPress') and not MainOptions.opOnly then
			plNotes = plNotes + 1
			if nuhuh1 == false then
				runTimer('plWait', MainOptions.appearSpeed, 1)
			end
			nuhuh1 = true
		end
	end
end

function goodNoteHit()
	if not MainOptions.dontDoTheScript and not MainOptions.opOnly then
		plNotes = plNotes - 1
		runTimer('plStrum', MainOptions.disappearSpeed, 1)
	end
end

function noteMiss()
	if not MainOptions.dontDoTheScript and not MainOptions.opOnly then
		plNotes = plNotes - 1
		runTimer('plStrum', MainOptions.disappearSpeed, 1)
	end
end

function opponentNoteHit()
	if not MainOptions.dontDoTheScript and not MainOptions.plOnly then
		opNotes = opNotes - 1
		runTimer('opStrum', MainOptions.disappearSpeed, 1)
	end
end

function onTimerCompleted(tag)
	if tag == 'opStrum' and opNotes == 0 then
		detection('op', 'hide')
	elseif tag == 'plStrum' and plNotes == 0 then
		detection('pl', 'hide')
	elseif tag == 'opWait' then
		detection('op', 'show')
	elseif tag == 'plWait' then
		detection('pl', 'show')
	end
end

function detection(who, what)
	if who == 'pl' then
		if what == 'hide' then
			for i = 4,7 do
				if MainOptions.dimMode then
					noteTweenAlpha('playerStrums'..i, i, DimOptions.dimOpacity, DimOptions.dimDuration, DimOptions.dimEase)
				end
				if MainOptions.hideMode then
					if not downscroll then
						noteTweenY('playerStrumes'..i, i, _G['defaultPlayerStrumY'..(i-4)] - 200, DimOptions.hideDuration, DimOptions.hideEase)
					else
						noteTweenY('playerStrumse'..i, i, _G['defaultPlayerStrumY'..(i-4)] + 200, DimOptions.hideDuration, DimOptions.hideEase)
					end
				end
			end
		else
			for i = 4,7 do
				if MainOptions.dimMode then
					noteTweenAlpha('playerStrums'..i, i, DimOptions.undimOpacity, DimOptions.undimDuration, DimOptions.undimEase)
				end
				if MainOptions.hideMode then
					noteTweenY('playerStrumse'..i, i, _G['defaultPlayerStrumY'..(i-4)], HideOptions.showDuration, HideOptions.showEase)
				end
			end
			nuhuh1 = false
		end
	else
		if what == 'hide' then
			for i = 0,3 do
				if MainOptions.dimMode then
					noteTweenAlpha('opponentStrums'..i, i, DimOptions.dimOpacity, DimOptions.dimDuration, DimOptions.dimEase)
				end
				if MainOptions.hideMode then
					if not downscroll then
						noteTweenY('opponentStrumse'..i, i, _G['defaultOpponentStrumY'..i] - 200, DimOptions.hideDuration, DimOptions.hideEase)
					else
						noteTweenY('opponentStrumse'..i, i, _G['defaultOpponentStrumY'..i] + 200, DimOptions.hideDuration, DimOptions.hideEase)
					end
				end
			end
		else
			for i = 0,3 do
				if MainOptions.dimMode then
					noteTweenAlpha('opponentStrums'..i, i, DimOptions.undimOpacity, DimOptions.undimDuration, DimOptions.undimEase)
				end
				if MainOptions.hideMode then
					noteTweenY('opponentStrumse'..i, i, _G['defaultOpponentStrumY'..i], HideOptions.showDuration, HideOptions.showEase)
				end
			end
			nuhuh = false
		end
	end
end