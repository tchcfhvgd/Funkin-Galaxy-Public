-- Lua stuff
local PurpleCoins = 0
local off = 60
local yPos = 485

function onCreate()

	makeNumbers('centaines')	--100, the hundreds digit
	makeNumbers('dizaines')		--010, the tenth digit
	makeNumbers('unites')		--001, the last digit

	setProperty('centaines.x', 225)
	setProperty('dizaines.x', 225 + off)
	setProperty('unites.x', 225 + (2*off))

	makeLuaSprite('coinUI', 'purplecoinui', 60, yPos - 7.5)
	setObjectCamera('coinUI', 'hud');
	scaleObject('coinUI', 0.6, 0.6)
	addLuaSprite('coinUI', true)

	makeLuaSprite('crossTalehahaimsofuckingfunny', 'x', 160, yPos + 25)
	setObjectCamera('crossTalehahaimsofuckingfunny', 'hud');
	addLuaSprite('crossTalehahaimsofuckingfunny', true)

	if not lowQuality then
		setProperty('centaines.antialiasing', getPropertyFromClass("ClientPrefs", "globalAntialiasing"))
		setProperty('dizaines.antialiasing', getPropertyFromClass("ClientPrefs", "globalAntialiasing"))
		setProperty('unites.antialiasing', getPropertyFromClass("ClientPrefs", "globalAntialiasing"))
		setProperty('crossTalehahaimsofuckingfunny.antialiasing', getPropertyFromClass("ClientPrefs", "globalAntialiasing"))
		setProperty('coinUI.antialiasing', getPropertyFromClass("ClientPrefs", "globalAntialiasing"))
	end

	if not downscroll then
		setProperty("thehealth.y", 50)
		setProperty("thehealth.x", getProperty("coinUI.x"))
	end
end

function plusOne()
	if PurpleCoins < 10 then
		playAnim('unites', tonumber(tostring(PurpleCoins):sub(1, 1)))
	elseif PurpleCoins < 100 then
		playAnim('dizaines', tonumber(tostring(PurpleCoins):sub(1, 1)))
		playAnim('unites', tonumber(tostring(PurpleCoins):sub(2, 2)))
	else
		playAnim('centaines', tonumber(tostring(PurpleCoins):sub(1, 1)))
		playAnim('dizaines', tonumber(tostring(PurpleCoins):sub(2, 2)))
		playAnim('unites', tonumber(tostring(PurpleCoins):sub(3, 3)))
end
end

function makeNumbers(which)
	makeAnimatedLuaSprite(which, 'Numbers', 0.0, 0.0)
    setObjectCamera(which, 'hud')
	setProperty(which..'.y', yPos)
	for i = 0,9 do
		addAnimationByPrefix(which, i, 'Number '..i)
	end
	playAnim(which, '0')
	addLuaSprite(which)
end

function goodNoteHit(id, dir, type)
    if type == 'Blammed Note' then
        PurpleCoins = PurpleCoins + 1
		plusOne()
    end
end