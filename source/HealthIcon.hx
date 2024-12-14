package;

import flixel.math.FlxPoint;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import hscript.Parser;
import hscript.Interp;

using StringTools;

class HealthIcon extends FlxFilteredSprite
{
	public var sprTracker:FlxSprite;

	private var isOldIcon:Bool = false;
	private var isPlayer:Bool = false;
	private var char:String = '';

	public var iconScale:Float = 1;
	public var timeScale:Float = 1; // playback rate but for icon lmfao
	public var toAdd:FlxPoint;

	private var haxeInterp:Interp = null; // lerping

	public function new(char:String = 'bf', isPlayer:Bool = false, iscale:Float = 1)
	{
		super();
		isOldIcon = (char == 'bf-old');
		this.isPlayer = isPlayer;
		iconScale = iscale;
		scale.set(iconScale, iconScale);
		updateHitbox();
		changeIcon(char);
		scrollFactor.set();

		toAdd = FlxPoint.get();

		haxeInterp = new Interp();
		haxeInterp.variables.set('daIcon', this);
		haxeInterp.variables.set('FlxMath', FlxMath);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		for (variable => lerpInfo in lerpVals)
		{
			var lerpValue = lerpInfo[0];
			var lerpSpeed = lerpInfo[1];
			var lerping = FlxMath.bound(1 - (elapsed * lerpSpeed * timeScale), 0, 1);
			haxeInterp.expr(new Parser().parseString('daIcon.$variable = FlxMath.lerp($lerpValue, daIcon.$variable, $lerping);'))();
		}

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 12, sprTracker.y - 30);
	}

	public function swapOldIcon()
	{
		if (isOldIcon = !isOldIcon)
			changeIcon('bf-old');
		else
			changeIcon('bf');
	}

	var lerpVals:Map<String, Array<Float>> = [];

	private var iconOffsets:Array<Float> = [0, 0];

	public function changeIcon(char:String)
	{
		if (this.char != char)
		{
			var name:String = 'icons/' + char;
			if (!Paths.fileExists('images/' + name + '.png', IMAGE))
				name = 'icons/icon-' + char; // Older versions of psych engine's support
			if (!Paths.fileExists('images/' + name + '.png', IMAGE))
				name = 'icons/icon-face'; // Prevents crash from missing icon
			var file:Dynamic = Paths.image(name);

			loadGraphic(file); // Load stupidly first for getting the file size
			loadGraphic(file, true, Math.floor(width / 2), Math.floor(height)); // Then load it fr
			iconOffsets[0] = (width - 150) / 2;
			iconOffsets[1] = (width - 150) / 2;
			updateHitbox();

			animation.add(char, [0, 1], 0, false, isPlayer);
			animation.play(char);
			this.char = char;

			antialiasing = ClientPrefs.globalAntialiasing;
			if (char.endsWith('-pixel'))
			{
				antialiasing = false;
			}
		}
	}

	public function bump()
	{
		@:privateAccess
		var curBeat = cast(flixel.FlxG.state, MusicBeatState).curBeat;
		var playerMult = isPlayer ? -1 : 1;
		if (flipX)
			playerMult *= -1;
		switch (animation.curAnim.name)
		{
			case 'bf' | 'bf-lyrics' | 'bf-mute':
				scale.set(iconScale + 0.2, iconScale + 0.2);
				if (curBeat % 2 == 0)
				{
					angle = 10 * playerMult;
					if (Type.getClass(flixel.FlxG.state) == PlayState)
						toAdd.x = 15 * playerMult * iconScale;
				}
				lerpVals.set("scale.x", [iconScale, 9]);
				lerpVals.set("scale.y", [iconScale, 9]);
				lerpVals.set("angle", [0, 9]);
				lerpVals.set("toAdd.x", [0, 9]);
			case 'gf':
				scale.set(iconScale + 0.2, iconScale + 0.2);
				if (curBeat % 2 == 0)
				{
					angle = 10 * playerMult;
					if (Type.getClass(flixel.FlxG.state) == PlayState)
						toAdd.x = 15 * playerMult * iconScale;
				}
				else
				{
					angle = -10 * playerMult;
					if (Type.getClass(flixel.FlxG.state) == PlayState)
						toAdd.x = -15 * playerMult * iconScale;
				}
				lerpVals.set("scale.x", [iconScale, 9]);
				lerpVals.set("scale.y", [iconScale, 9]);
				lerpVals.set("toAdd.x", [0, 9]);
				lerpVals.set("angle", [0, 9]);
			default:
				scale.set(iconScale + 0.2, iconScale + 0.2);
				lerpVals.set("scale.x", [iconScale, 9]);
				lerpVals.set("scale.y", [iconScale, 9]);
		}
	}

	override function updateHitbox()
	{
		super.updateHitbox();
		offset.set(iconOffsets[0], iconOffsets[1]);
	}

	public function getCharacter():String
	{
		return char;
	}
}
