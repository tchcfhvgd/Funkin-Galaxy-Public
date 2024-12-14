package;

import flixel.math.FlxMath;
import flixel.math.FlxMath;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;

typedef NoteSplashConfig = {
	anim:String,
	minFps:Int,
	maxFps:Int,
	offsets:Array<Array<Float>>
}

class NoteSplash extends FlxSprite
{
	public var rgbShader:PixelSplashShaderRef;
	private var idleAnim:String;
	private var textureLoaded:String = null;

	public static var defaultNoteSplash(default, never):String = 'noteSplashes';

	public function new(x:Float = 0, y:Float = 0, ?note:Int = 0) {
		super(x, y);

		var skin:String = 'noteSplashes';
		if(PlayState.SONG.splashSkin != null && PlayState.SONG.splashSkin.length > 0) skin = PlayState.SONG.splashSkin;

		rgbShader = new PixelSplashShaderRef();
		shader = rgbShader.shader;
		loadAnims(skin);

		precacheConfig(skin);
		//setupNoteSplash(x, y, note);
		antialiasing = ClientPrefs.globalAntialiasing;
	}

	public function setupNoteSplashOld(x:Float, y:Float, direction:Int = 0, ?note:Note = null) {
		setPosition(x - Note.swagWidth * 0.95, y - Note.swagWidth);
		alpha = 0.6;

		var texture:String = null;
		if(texture == null) {
			texture = 'noteSplashes';
			if(PlayState.SONG.splashSkin != null && PlayState.SONG.splashSkin.length > 0) texture = PlayState.SONG.splashSkin;
		}

		if(textureLoaded != texture) {
			loadAnims(texture);
		}
		var tempShader:RGBPalette = null;
		if(note == null)
		{
			// If Note RGB is enabled:
			if(note != null)
			{
				note.rgbShader.r = note.noteSplashData.r;
				note.rgbShader.g = note.noteSplashData.g;
				note.rgbShader.b = note.noteSplashData.b;
				tempShader = note.rgbShader.parent;
			}
		}
		rgbShader.copyValues(tempShader);
		offset.set(10, 10);

		var animNum:Int = FlxG.random.int(1, 2);
		animation.play('note' + note + '-' + animNum, true);
		if(animation.curAnim != null)animation.curAnim.frameRate = 24 + FlxG.random.int(-2, 2);
	}

	public static function precacheConfig(skin:String)
	{
		var file = "note splash\n22 26\n-58 -55\n-58 -55\n-58 -55\n-58 -55\n-52 -48\n-52 -48\n-52 -48\n-52 -48";
		if (skin == "HURTnoteSplashes") file = "splash electro\n22 26\n-44 -54";
		var configFile:Array<String> = CoolUtil.readTextFile(file);
		if(configFile.length < 1) return null;
		
		var framerates:Array<String> = configFile[1].split(' ');
		var offs:Array<Array<Float>> = [];
		for (i in 2...configFile.length)
		{
			var animOffs:Array<String> = configFile[i].split(' ');
			offs.push([Std.parseFloat(animOffs[0]), Std.parseFloat(animOffs[1])]);
		}

		var config:NoteSplashConfig = {
			anim: configFile[0],
			minFps: Std.parseInt(framerates[0]),
			maxFps: Std.parseInt(framerates[1]),
			offsets: offs
		};
		return config;
	}

	var maxAnims:Int = 2;
	public function setupNoteSplash(x:Float, y:Float, direction:Int = 0, ?note:Note = null) {
		setPosition(x - Note.swagWidth * 0.95, y - Note.swagWidth);

		var texture:String = null;
		if(texture == null) {
			texture = 'noteSplashes';
			if(PlayState.SONG.splashSkin != null && PlayState.SONG.splashSkin.length > 0) texture = PlayState.SONG.splashSkin;
		}

		var tempShader:RGBPalette = null;
		// If Note RGB is enabled:
		if(note != null)
		{
			
			if(note.noteSplashData.r != -1) note.rgbShader.r = note.noteSplashData.r;
			if(note.noteSplashData.g != -1) note.rgbShader.g = note.noteSplashData.g;
			if(note.noteSplashData.b != -1) note.rgbShader.b = note.noteSplashData.b;
			if(note.noteSplashData.texture != "") texture = note.noteSplashData.texture;
			tempShader = note.rgbShader.parent;
		}
		else tempShader = Note.globalRgbShaders[direction];
		rgbShader.copyValues(tempShader);

		offset.set(10, 10);

		if(textureLoaded != texture) {
			loadAnims(texture);
		}

		rgbShader.reloadPixelMode();

		if(note != null) antialiasing = ClientPrefs.globalAntialiasing;

		var animNum:Int = FlxG.random.int(1, maxAnims);
		animation.play('note' + direction + '-' + animNum, true);
		
		var minFps:Int = 22;
		var maxFps:Int = 26;

		if(animation.curAnim != null)
			animation.curAnim.frameRate = FlxG.random.int(minFps, maxFps);
	}

	function loadAnimsOld(skin:String) {
		frames = Paths.getSparrowAtlas(skin);
		for (i in 1...3) {
			animation.addByPrefix("note1-" + i, "note splash blue " + i, 24, false);
			animation.addByPrefix("note2-" + i, "note splash green " + i, 24, false);
			animation.addByPrefix("note0-" + i, "note splash purple " + i, 24, false);
			animation.addByPrefix("note3-" + i, "note splash red " + i, 24, false);
		}
	}

	function loadAnims(skin:String, ?animName:String = null):NoteSplashConfig {
		maxAnims = 0;
		frames = Paths.getSparrowAtlas(skin);
		var config:NoteSplashConfig = null;
		if(frames == null)
		{
			skin = defaultNoteSplash;
			frames = Paths.getSparrowAtlas(skin);
			if(frames == null) //if you really need this, you really fucked something up
			{
				skin = defaultNoteSplash;
				frames = Paths.getSparrowAtlas(skin);
			}
		}
		config = precacheConfig(skin);

		offset.x += config.offsets[0][0];
		offset.y += config.offsets[0][1];

		if(animName == null)
			animName = config != null ? config.anim : 'note splash';

		while(true) {
			var animID:Int = maxAnims + 1;
			for (i in 0...Note.colArray.length) {
				if (!addAnimAndCheck('note$i-$animID', '$animName ${Note.colArray[i]} $animID', 24, false)) {
					//trace('maxAnims: $maxAnims');
					return config;
				}
			}
			maxAnims++;
			//trace('currently: $maxAnims');
		}
	}

	override function update(elapsed:Float) {
		if(animation.curAnim != null)if(animation.curAnim.finished) kill();

		super.update(elapsed);
	}

	function addAnimAndCheck(name:String, anim:String, ?framerate:Int = 24, ?loop:Bool = false)
	{
		animation.addByPrefix(name, anim, framerate, loop);
		return animation.getByName(name) != null;
	}
}

class PixelSplashShaderRef {
	public var shader:PixelSplashShader = new PixelSplashShader();

	public function copyValues(tempShader:RGBPalette)
	{
		var enabled:Bool = false;
		if(tempShader != null)
			enabled = true;

		if(enabled)
		{
			for (i in 0...3)
			{
				shader.r.value[i] = tempShader.shader.r.value[i];
				shader.g.value[i] = tempShader.shader.g.value[i];
				shader.b.value[i] = tempShader.shader.b.value[i];
			}
			shader.mult.value[0] = tempShader.shader.mult.value[0];
		}
		else shader.mult.value[0] = 0.0;
	}

	public function reloadPixelMode()
	{
		var pixel:Float = 1;
		if(PlayState.isPixelStage) pixel = PlayState.daPixelZoom;
		shader.uBlocksize.value = [pixel, pixel];
	}

	public function new()
	{
		shader.r.value = [0, 0, 0];
		shader.g.value = [0, 0, 0];
		shader.b.value = [0, 0, 0];
		shader.mult.value = [1];

		reloadPixelMode();
		//trace('Created shader ' + Conductor.songPosition);
	}
}

class PixelSplashShader extends flixel.system.FlxAssets.FlxShader
{
	@:glFragmentHeader('
		#pragma header
		
		uniform vec3 r;
		uniform vec3 g;
		uniform vec3 b;
		uniform float mult;
		uniform vec2 uBlocksize;

		vec4 flixel_texture2DCustom(sampler2D bitmap, vec2 coord) {
			vec2 blocks = openfl_TextureSize / uBlocksize;
			vec4 color = flixel_texture2D(bitmap, floor(coord * blocks) / blocks);
			if (!hasTransform) {
				return color;
			}

			if(color.a == 0.0 || mult == 0.0) {
				return color * openfl_Alphav;
			}

			vec4 newColor = color;
			newColor.rgb = min(color.r * r + color.g * g + color.b * b, vec3(1.0));
			newColor.a = color.a;
			
			color = mix(color, newColor, mult);
			
			if(color.a > 0.0) {
				return vec4(color.rgb, color.a);
			}
			return vec4(0.0, 0.0, 0.0, 0.0);
		}')

	@:glFragmentSource('
		#pragma header

		void main() {
			gl_FragColor = flixel_texture2DCustom(bitmap, openfl_TextureCoordv);
		}')

	public function new()
	{
		super();
	}
}