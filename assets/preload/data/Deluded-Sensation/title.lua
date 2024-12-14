function onCreate()
	setPropertyFromClass("openfl.Lib", "application.window.title", "Super Funkin' Galaxy DS")
end
function onDestroy()
	setPropertyFromClass("openfl.Lib", "application.window.title", "Super Funkin' Galaxy")
end