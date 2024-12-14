local speed = 0.8        --duration of the spin hitbox
local speed2 = 1.3       --duration until you can spin again
local speed3 = 0.3       --how long u have to press for it to consider spamming
local spamEnabled = true --spam toggle
local key1 = 'SPACE'
local key2 = 'SHIFT'
local spinning = false --no touch
local lock = true      --no touch
local spamming = false --no touch
local suffix = ''      --no touch

function spin(spam)
	if not spam then
		runTimer('spinTimer', speed)
		runTimer('lockTimer', speed2)
		runTimer('spamTimer', speed3)
		spinning = true
		lock = true
		if spamEnabled then
			spamming = true
		end
		playAnim('boyfriend', 'spin' .. suffix, true)
		spinSound()
		setProperty('boyfriend.specialAnim', true)
	else
		runTimer('spinTimer', speed)
		runTimer('lockTimer', speed2)
		runTimer('spamTimer', speed3)
		playAnim('boyfriend', 'spin' .. suffix, true)
		spinSound()
		setProperty('boyfriend.specialAnim', true)
	end
end

function spinSound()
	if boyfriendName == 'mario-gba' then
		playSound('mariospin')
	else
		playSound('bfspin')
	end
end

function onEvent(n, v1, v2)
	if n == 'Alt Idle Animation' then
		if v1 == 'bf' then
			suffix = v2
		end
	end
	if n == 'Attack From Ennemy' then
		if v1 == 'Topman' then
			attack(v1)
		end
	end
end

function attack(who) -- for mechanics
	if spinning == true then
		reflect(who)
	else
		hit(who)
	end
end

function reflect(who)
	if who == 'Topman' then
		playAnim('AttackingTopman', 'death')
		doTweenX('dieLittleRobot', 'AttackingTopman', getProperty('boyfriend.x') + 600, 0.2, 'quadOut')
	end
end

function hit(who)
	if who == 'Topman' then
		playAnim('AttackingTopman', 'death')
		doTweenX('dieLittleRobot', 'AttackingTopman', getProperty('boyfriend.x') + 400, 0.2, 'quadOut')
		runTimer('kaboom', 1.3)
	end
end

function onUpdate()
	if keyboardJustPressed(key1) or keyboardJustPressed(key2) then
		if (runHaxeCode('return game.boyfriend != null && game.boyfriend.animOffsets.exists("spin");') and lock == false and spinning == false) or spamming then
			--if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
			spin(spamming)
			--end
		end
	end
end

function onTimerCompleted(t)
	if t == 'spinTimer' then
		spinning = false
	end
	if t == 'lockTimer' then
		lock = false
	end
	if t == 'spamTimer' then
		spamming = false
	end

	if t == 'kaboom' then
		playAnim('boyfriend', 'hit')
		setProperty('health', getProperty('health') - 1)
		spawnCoinNote()
	end
end

function onStartCountdown()
	lock = false
end
