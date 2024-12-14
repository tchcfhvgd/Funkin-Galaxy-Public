function onCreatePost()
     luaDebugMode = true

	if getPropertyFromClass('ClientPrefs', 'shaders') == true then

    initLuaShader("adjustColor")

    makeLuaSprite("shaderImage")
    makeGraphic("shaderImage", screenWidth, screenHeight)

    setSpriteShader("shaderImage", "adjustColor")
    setShaderFloat("shaderImage", 'hue', 0)
    setShaderFloat("shaderImage", 'saturation', -20)
    setShaderFloat("shaderImage", 'contrast', 50)
    setShaderFloat("shaderImage", 'brightness', 0)

    addHaxeLibrary("ShaderFilter", "openfl.filters")
    runHaxeCode([[
        trace(ShaderFilter);
        game.camGame.setFilters([new ShaderFilter(game.getLuaObject("shaderImage").shader)]);
    ]])
end
end