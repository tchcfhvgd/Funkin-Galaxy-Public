function onCreatePost()
	luaDebugMode = true

	if getPropertyFromClass('ClientPrefs', 'shaders') == true then
		initLuaShader("adjustColor")

		makeLuaSprite("shaderImage")
		makeGraphic("shaderImage", screenWidth, screenHeight)

		setSpriteShader("shaderImage", "adjustColor")
		setShaderFloat("shaderImage", 'hue', -5)
		setShaderFloat("shaderImage", 'saturation', 0)
		setShaderFloat("shaderImage", 'contrast', 7)
		setShaderFloat("shaderImage", 'brightness', -23)

		addHaxeLibrary("ShaderFilter", "openfl.filters")
		runHaxeCode([[
        trace(ShaderFilter);
        game.camGame.setFilters([new ShaderFilter(game.getLuaObject("shaderImage").shader)]);
    ]])
	end
end
