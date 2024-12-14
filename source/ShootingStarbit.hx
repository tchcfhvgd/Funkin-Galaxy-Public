package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.tweens.FlxTween;

using StringTools;

class ShootingStarbit extends FlxSprite
{
    public var hasBeenShot:Bool = false;
    public var shootTween:FlxTween;

    public var xPos:Float = 0;
    public var yPos:Float = 0;

    var colors:Array<String> = ['Red', 'Yellow', 'Purple', 'Green', 'White', 'Blue'];

    override public function new(x:Float, y:Float)
    {
        super(x, y);
        xPos = x;
        yPos = y;
        loadGraphic(Paths.image("title/" + colors[FlxG.random.int(0, colors.length - 1)] + 'Shoot'), true, 57, 90);
        animation.add('shoot', [0, 1], 12, true);
        animation.play('shoot', true);
        antialiasing = ClientPrefs.globalAntialiasing;
        angle = -25;
    }

    public function changeColor()
    {
        loadGraphic(Paths.image("title/" + colors[FlxG.random.int(0, colors.length - 1)] + 'Shoot'), true, 57, 90);
        animation.add('shoot', [0, 1], 12, true);
        animation.play('shoot', true);
    }
}