package;

#if windows
@:cppInclude('windows.h')
class NativeWindow {
    @:functionCode("
        POINT lolz;
        GetCursorPos(&lolz);
    ")
    public static function getMousePos():flixel.math.FlxPoint
        return flixel.math.FlxPoint.get(untyped __cpp__("lolz.x"), untyped __cpp__("lolz.y"));
}
#end