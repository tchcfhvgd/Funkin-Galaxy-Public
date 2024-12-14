function onCreatePost()
     luaDebugMode = true

	if getPropertyFromClass('ClientPrefs', 'shaders') == true then

    initLuaShader("vcrshader")

    makeLuaSprite("shaderImage")
    makeGraphic("shaderImage", screenWidth, screenHeight)

    setSpriteShader("shaderImage", "vcrshader")

    addHaxeLibrary("ShaderFilter", "openfl.filters")
    runHaxeCode([[
        trace(ShaderFilter);
        game.camGame.setFilters([new ShaderFilter(game.getLuaObject("shaderImage").shader)]);
    ]])
end
end

function onUpdate(elapsed)
    setShaderFloat("shaderImage", "iTime", os.clock())
end