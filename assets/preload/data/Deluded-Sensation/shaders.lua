function onCreatePost()
     luaDebugMode = true

	if getPropertyFromClass('ClientPrefs', 'shaders') == true then

    initLuaShader("chrom")

    makeLuaSprite("shaderImage")
    makeGraphic("shaderImage", screenWidth, screenHeight)

    setSpriteShader("shaderImage", "chrom")

    addHaxeLibrary("ShaderFilter", "openfl.filters")
    runHaxeCode([[
        trace(ShaderFilter);
        game.camGame.setFilters([new ShaderFilter(game.getLuaObject("shaderImage").shader)]);
        game.camHUD.setFilters([new ShaderFilter(game.getLuaObject("shaderImage").shader)]);
    ]])
end
end

function onUpdate(elapsed)
    setShaderFloat("shaderImage", "iTime", os.clock())
end