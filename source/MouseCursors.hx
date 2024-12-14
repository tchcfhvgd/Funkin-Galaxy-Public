import flixel.FlxG;
import flash.display.BitmapData;

@:bitmap("assets/images/ui/cursor.png")
class NormalCursor extends BitmapData {}
@:bitmap("assets/exclude/system/galaxy_cursor.png")
class GalaxyCursor extends BitmapData {}
@:bitmap("assets/exclude/system/normal.png")
class NintendoNormal extends BitmapData {}
@:bitmap("assets/exclude/system/prepare_grab.png")
class NintendoGrabPrepare extends BitmapData {}
@:bitmap("assets/exclude/system/grab.png")
class NintendoGrab extends BitmapData {}

class MouseCursors {
    static var currentCursor:String = "";
    static var offsets:Map<String, Array<Int>> = [
		"normal" => [0, 0],
        "galaxy" => [-19, -18],
        "nintendo_normal" => [-22, -7],
        "grab_prepare" => [/*-32, -37*/ -22, -7],
        "grab" => [-22, -7],
	];
    static var scales:Map<String, Float> = [
		"normal" => 1,
        "galaxy" => 1,
	];
    public static function getCursorBitmapData(cursorToLoad:String) {
        var cursor:BitmapData;
        switch (cursorToLoad.toLowerCase())
        {
            case 'galaxy':
                cursor = new GalaxyCursor(0, 0);
             case "nintendo_normal":
                cursor = new NintendoNormal(0, 0);
            case "grab_prepare":
                cursor = new NintendoGrabPrepare(0, 0);
            case "grab":
                cursor = new NintendoGrab(0, 0);
            default:
                cursor = new NormalCursor(0, 0);
        }
        return cursor;
    }
    public static function loadCursor(cursorToLoad:String) {
        if (currentCursor == cursorToLoad) return;
        currentCursor = cursorToLoad;
        FlxG.mouse.visible = true;
        FlxG.mouse.useSystemCursor = false;
        FlxG.mouse.load(getCursorBitmapData(cursorToLoad), scales.get(cursorToLoad), offsets.get(cursorToLoad)[0], offsets.get(cursorToLoad)[1]);
    }
}