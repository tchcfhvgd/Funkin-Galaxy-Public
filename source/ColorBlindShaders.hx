import flixel.FlxG;
import openfl.filters.BitmapFilter;
import openfl.filters.ColorMatrixFilter;

class ColorBlindShaders
{
    public static var matrix:Array<Float>; //the actual matrix used by the shader
    public static var list = ["None", "Protanopia", "Protanomaly", "Deuteranopia", "Tritanopia", "Tritanomaly", "Achromatopsia", "Achromatomaly"];

    public static function updateColors(theInt:Int):Void
    {
        var a1:Float = 1;
        var a2:Float = 0;
        var a3:Float = 0;

        var b1:Float = 0;
        var b2:Float = 1;
        var b3:Float = 0;

        var c1:Float = 0;
        var c2:Float = 0;
        var c3:Float = 1;

        switch (theInt)
        {
            case 0:
                a1 = 1; b1 = 0; c1 = 0;
                a2 = 0; b2 = 1; c2 = 0;
                a3 = 0; b3 = 0; c3 = 1;
            case 1:
                a1 = 0.567; b1 = 0.433; c1 = 0;
                a2 = 0.558; b2 = 0.442; c2 = 0;
                a3 = 0; b3 = 0.242; c3 = 0.758;
            case 2:
                a1 = 0.817; b1 = 0.183; c1 = 0;
                a2 = 0.333; b2 = 0.667; c2 = 0;
                a3 = 0; b3 = 0.125; c3 = 0.875;
            case 3:
                a1 = 0.625; b1 = 0.375; c1 = 0;
                a2 = 0.7; b2 = 0.3; c2 = 0;
                a3 = 0; b3 = 0; c3 = 1.0;
            case 4:
                a1 = 0.8; b1 = 0.2; c1 = 0;
                a2 = 0.258; b2 = 0.742; c2 = 0;
                a3 = 0; b3 = 0.142; c3 = 0.858;
            case 5:
                a1 = 0.95; b1 = 0.05; c1 = 0;
                a2 = 0; b2 = 0.433; c2 = 0.567;
                a3 = 0; b3 = 0.475; c3 = 0.525;
            case 6:
                a1 = 0.967; b1 = 0.033; c1 = 0;
                a2 = 0; b2 = 0.733; c2 = 0.267;
                a3 = 0; b3 = 0.183; c3 = 0.817;
            case 7:
                a1 = 0.299; b1 = 0.587; c1 = 0.114;
                a2 = 0.299; b2 = 0.587; c2 = 0.114;
                a3 = 0.299; b3 = 0.587; c3 = 0.114;
            case 8:
                a1 = 0.618; b1 = 0.320; c1 = 0.062;
                a2 = 0.163; b2 = 0.775; c2 = 0.062;
                a3 = 0.163; b3 = 0.320; c3 = 0.516;
        }

        matrix = [
            a1, b1, c1, 0, 1,
            a2, b2, c2, 0, 1,
            a3, b3, c3, 0, 1,
            0, 0, 0, 1, 0,
        ];

        var filters:Array<BitmapFilter> = [];
        filters.push(new ColorMatrixFilter(matrix));
        FlxG.game.filtersEnabled = true;
        FlxG.game.setFilters(filters);
    }
}