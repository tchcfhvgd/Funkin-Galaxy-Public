function onCreate()
	setPropertyFromClass("openfl.Lib", "application.window.title", "Super Funkin' Galaxy 2")
end
function onDestroy()
	setPropertyFromClass("openfl.Lib", "application.window.title", "Super Funkin' Galaxy")
end