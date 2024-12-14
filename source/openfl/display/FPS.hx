package openfl.display;

import flash.text.TextField;
import flash.text.TextFormat;
import flixel.math.FlxMath;
import flixel.util.FlxStringUtil;
import flixel.FlxG;
import openfl.Assets;
#if (openfl >= "8.0.0")
import openfl.utils.AssetType;
#end
#if cpp
import cpp.vm.Gc;
#end

using StringTools;

class FPS extends TextField
{
    public static var instance:FPS;
	/**
		The current frame rate, expressed using frames-per-second
	**/
	public var currentFPS(default, null):Float;

	public var curMemory:Float;
	public var peakMemory:Float;
	public var realAlpha:Float = 1;
	public var lagging:Bool = false;
	public var forceUpdateText(default, set):Bool = false;

	@:noCompletion private var cacheCount:Int;
	@:noCompletion private var currentTime:Float;
	@:noCompletion private var times:Array<Float>;

	public function new(x:Float = 10, y:Float = 10, color:Int = 0x000000)
	{
        super();
		if (instance!=null)
            return;
        
		instance = this;

		this.x = x;
		this.y = y;

		currentFPS = 0;
		selectable = false;
		mouseEnabled = false;
		defaultTextFormat = new TextFormat(getFont(Paths.font("Delfino.ttf")), 14, color);
		autoSize = LEFT;
		multiline = true;
		text = "FPS: ";

		cacheCount = 0;
		currentTime = 0;
		times = [];

		#if flash
		addEventListener(Event.ENTER_FRAME, function(e)
		{
			var time = Lib.getTimer();
			__enterFrame(time - currentTime);
		});
		#end
	}

	public function getFont(Font:String):String
	{
		embedFonts = true;

		var newFontName:String = Font;

		if (Font != null)
		{
			if (Assets.exists(Font, AssetType.FONT))
			{
				newFontName = Assets.getFont(Font).fontName;
			}
		}
		return newFontName;
	}

	// Event Handlers
	@:noCompletion
	private #if !flash override #end function __enterFrame(deltaTime:Float):Void
	{
		currentTime += deltaTime;
		times.push(currentTime);

		while (times[0] < currentTime - 1000)
		{
			times.shift();
		}

		var minAlpha:Float = 1;
		var aggressor:Float = 1;

		var mousePos = FlxG.mouse.cursorContainer;

		var currentX = x - FlxG.game.x;
		var currentY = y - FlxG.game.y;

		if ((mousePos.x >= currentX && mousePos.x <= currentX + width)
			&& (mousePos.y >= currentY && mousePos.y <= currentY + height)
			&& FlxG.mouse.visible)
		{
			minAlpha = 0.1;
			aggressor = 2.5;
		}

		if (!lagging)
			realAlpha = CoolUtil.boundTo(realAlpha - (deltaTime / 1000) * aggressor, minAlpha, 1);
		else
			realAlpha = CoolUtil.boundTo(realAlpha + (deltaTime / 1000), 0.3, 1);

		var currentCount = times.length;
		currentFPS = (currentCount + cacheCount) / 2;

		// currentFPS = 1 / (deltaTime / 1000);

		if (currentFPS > ClientPrefs.framerate)
			currentFPS = ClientPrefs.framerate;

		if (currentCount != cacheCount /*&& visible*/)
		{
			updateText();
		}

		cacheCount = currentCount;

		alpha = realAlpha;
	}

	private function set_forceUpdateText(value:Bool):Bool
	{
		updateText();
		return value;
	}

	private function updateText():Void
	{
		text = Main.fpsText.replace("{FPS}", Std.string(Math.round(currentFPS)));
		
		lagging = false;

        alpha = realAlpha;
		textColor = 0xFFFFFF;
		if (currentFPS <= ClientPrefs.framerate / 2)
		{
			textColor = 0xFF0000;
			lagging = true;
		}

		text += '\n';

		curMemory = MemoryShit.obtainMemory();
		if (curMemory >= peakMemory)
			peakMemory = curMemory;
		text += Main.memoryText.replace("{MEM}", CoolUtil.formatMemory(Std.int(curMemory))).replace("{MEMPEAK}", CoolUtil.formatMemory(Std.int(peakMemory)));
		//text += 'Used VRAM: ${CoolUtil.formatMemory(Std.int(FlxG.stage.context3D.totalGPUMemory))}'; // honestly not super useful
		text += '\n';
	}

    

	public var textAfter:String = '';
}