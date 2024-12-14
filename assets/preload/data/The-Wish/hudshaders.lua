local shadname = "dropShadow"
function onCreatePost()
	if getPropertyFromClass('ClientPrefs', 'shaders') == true then
    initLuaShader(shadname)

    makeLuaSprite("temporaryShader")
    makeGraphic("temporaryShader", screenWidth, screenHeight)

    setSpriteShader("temporaryShader", shadname)

    runHaxeCode([[
        //game.addTextToDebug("ShaderFilter",]]..getColorFromHex('FF0000')..[[);
        game.camHUD.setFilters([new ShaderFilter(game.getLuaObject("temporaryShader").shader)]);
        game.camOther.setFilters([new ShaderFilter(game.getLuaObject("temporaryShader").shader)]);
    ]]) 
    setShaderFloat("temporaryShader", "_alpha", 0.7)
    setShaderFloat("temporaryShader", "_disx", 7)
    setShaderFloat("temporaryShader", "_disy",6)
    setShaderBool("temporaryShader", "inner", true) 
    setShaderBool("temporaryShader", "inverted", true)
    setShaderBool("temporaryShader", "knockout", true)
	end
end