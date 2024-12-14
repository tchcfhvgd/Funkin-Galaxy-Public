local shadname = "dropShadow"
function onCreatePost()
	if getPropertyFromClass('ClientPrefs', 'shaders') == true then
		initLuaShader(shadname)
		initLuaShader("bloom")

		makeLuaSprite("shaderImage")
		makeGraphic("shaderImage", screenWidth, screenHeight)

		setSpriteShader("shaderImage", "bloom")

		setSpriteShader('boyfriend', shadname)
		makeLuaSprite("temporaryShader")
		makeGraphic("temporaryShader", screenWidth, screenHeight)

		setSpriteShader("temporaryShader", shadname)

		runHaxeCode([[
        game.boyfriendMap.set(game.boyfriend.curCharacter, game.boyfriend);
        //game.addTextToDebug("ShaderFilter",]] .. getColorFromHex('FF0000') .. [[);
        game.camHUD.setFilters([new ShaderFilter(game.getLuaObject("temporaryShader").shader)]);
        game.camOther.setFilters([new ShaderFilter(game.getLuaObject("temporaryShader").shader)]);
        game.camGame.setFilters([new ShaderFilter(game.getLuaObject("temporaryShader").shader)]);
        //game.camGame.setFilters([new ShaderFilter(game.getLuaObject("shaderImage").shader)]);
    ]])
		setShaderFloat("temporaryShader", "_alpha", 0.9)
		setShaderFloat("temporaryShader", "_disx", 12)
		setShaderFloat("temporaryShader", "_disy", 7)
		setShaderBool("temporaryShader", "inner", true)
		setShaderBool("temporaryShader", "inverted", true)
		setShaderBool("temporaryShader", "knockout", true)
	end
end
