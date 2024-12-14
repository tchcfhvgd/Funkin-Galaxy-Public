-- DONT TOUCH ANYTHING BELOW ITS SHADER FIXES AND SHIT
local shadname = "dropShadow"
local LastDadname = ''
local LastBFname = ''
-- YOU CAN TOUCH NOW
local chance = 5 --rn it's a 1 in 5 chance, lower the number for more likely n vice versa

function onSongStart()
	--doTweenColor('TimerColor', 'timeBar', 'FF8000', '0.1', 'linear') keepin this just incase im stupid cuz i aint compilin now
	setProperty('timeBar.leftBar.color', getColorFromHex("FF0000"))
end

function onCreatePost()
	if getRandomInt(1, chance) == 1 then
		triggerEvent('Change Character', 'GF', 'jackonerd')
	end

	--NO TOUCHING ANYTHING NOW UNTIL THE END OF THE SCRIPT
	if getPropertyFromClass('ClientPrefs', 'shaders') then
		initLuaShader(shadname)

		setSpriteShader('boyfriend', shadname)
		setSpriteShader('dad', shadname)
		setSpriteShader('gf', shadname)
		LastBFname = boyfriendName
		LastDadname = dadName
		makeLuaSprite("temporaryShader")
		makeGraphic("temporaryShader", screenWidth, screenHeight)

		setSpriteShader("temporaryShader", shadname)

		runHaxeCode([[
        game.boyfriendMap.set(game.boyfriend.curCharacter, game.boyfriend);
        game.dadMap.set(game.dad.curCharacter, game.dad);
        //game.addTextToDebug("ShaderFilter",]] .. getColorFromHex('FF0000') .. [[);
        game.camGame.setFilters([new ShaderFilter(game.getLuaObject("temporaryShader").shader)]);
    ]])
		setShaderFloat("temporaryShader", "_alpha", 0.95)
		setShaderFloat("temporaryShader", "_disx", -12)
		setShaderFloat("temporaryShader", "_disy", 10)
		setShaderBool("temporaryShader", "inner", true)
		setShaderBool("temporaryShader", "inverted", true)
		setShaderBool("temporaryShader", "knockout", true)
	end
end

function onEvent(eventName, value1, value2)
	if eventName == 'Change Character' then
		if not lowQuality then
			local Character = stringTrim(string.lower(value1))
			local LastCharName = LastBFname
			if Character == 'dad' or Character == 'opponent' then
				Character = 'dad'
				LastCharName = LastDadname
			else
				Character = 'boyfriend'
			end
			runHaxeCode([[
            var Char=game.]] .. Character .. [[Map.get(']] .. LastCharName .. [[');
            Char.shader = null;
        ]])
			if Character == 'dad' then
				LastDadname = value2
			else
				LastBFname = value2
			end
			setSpriteShader(Character, shadname)
		end
	end
end
