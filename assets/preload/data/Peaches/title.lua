function onCreate()
	setPropertyFromClass("openfl.Lib", "application.window.title", "The Super Funkin' Galaxy Movie")
end
function onDestroy()
	setPropertyFromClass("openfl.Lib", "application.window.title", "Super Funkin' Galaxy")
end