package;

import flixel.util.typeLimit.OneOfThree;
import flixel.util.FlxColor;
import animateatlas.AtlasFrameMaker;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.effects.FlxTrail;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.tweens.FlxTween;
import flixel.util.FlxSort;
import Section.SwagSection;
#if MODS_ALLOWED
import sys.io.File;
import sys.FileSystem;
#end
import openfl.utils.AssetType;
import openfl.utils.Assets;
import haxe.Json;
import haxe.format.JsonParser;

using StringTools;

typedef CharacterFile = {
	var animations:Array<AnimArray>;
	var image:String;
	var scale:Float;
	var sing_duration:Float;
	var healthicon:String;

	var position:Array<Float>;
	var camera_position:Array<Float>;

	var flip_x:Bool;
	var no_antialiasing:Bool;
	var healthbar_colors:Array<Int>;
}

typedef AnimArray = {
	var anim:String;
	var name:String;
	var fps:Int;
	var loop:Bool;
	var indices:Array<Int>;
	var offsets:Array<Int>;
}

class Character extends FlxSprite
{
	public var animOffsets:Map<String, Array<Dynamic>>;
	public var debugMode:Bool = false;

	public var isPlayer:Bool = false;
	public var curCharacter:String = DEFAULT_CHARACTER;

	public var colorTween:FlxTween;
	public var holdTimer:Float = 0;
	public var heyTimer:Float = 0;
	public var specialAnim:Bool = false;
	public var animationNotes:Array<Dynamic> = [];
	public var stunned:Bool = false;
	public var singDuration:Float = 4; //Multiplier of how long a character holds the sing pose
	public var idleSuffix:String = '';
	public var danceIdle:Bool = false; //Character use "danceLeft" and "danceRight" instead of "idle"
	public var skipDance:Bool = false;

	public var healthIcon:String = 'face';
	public var animationsArray:Array<AnimArray> = [];

	public var positionArray:Array<Float> = [0, 0];
	public var cameraPosition:Array<Float> = [0, 0];

	public var hasMissAnimations:Bool = false;

	//Used on Character Editor
	public var imageFile:String = '';
	public var jsonScale:Float = 1;
	public var noAntialiasing:Bool = false;
	public var originalFlipX:Bool = false;
	public var healthColorArray:Array<Int> = [255, 0, 0];

	public var arrowRGB:Array<Array<FlxColor>> = [
		[0xFFC24B99, 0xFFFFFFFF, 0xFF3C1F56],
		[0xFF00FFFF, 0xFFFFFFFF, 0xFF1542B7],
		[0xFF12FA05, 0xFFFFFFFF, 0xFF0A4447],
		[0xFFF9393F, 0xFFFFFFFF, 0xFF651038]
	];

	public static var DEFAULT_CHARACTER:String = 'bf'; //In case a character is missing, it will use BF on its place
	public function new(x:Float, y:Float, ?character:String = 'bf', ?isPlayer:Bool = false)
	{
		super(x, y);

		#if (haxe >= "4.0.0")
		animOffsets = new Map();
		#else
		animOffsets = new Map<String, Array<Dynamic>>();
		#end
		curCharacter = character;
		fixArrowRGB();
		this.isPlayer = isPlayer;
		antialiasing = ClientPrefs.globalAntialiasing;
		var library:String = null;
		switch (curCharacter)
		{
			//case 'your character name in case you want to hardcode them instead':

			default:
				var characterPath:String = 'characters/' + curCharacter + '.json';

				#if MODS_ALLOWED
				var path:String = Paths.modFolders(characterPath);
				if (!FileSystem.exists(path)) {
					path = Paths.getPreloadPath(characterPath);
				}

				if (!FileSystem.exists(path))
				#else
				var path:String = Paths.getPreloadPath(characterPath);
				if (!Assets.exists(path))
				#end
				{
					path = Paths.getPreloadPath('characters/' + DEFAULT_CHARACTER + '.json'); //If a character couldn't be found, change him to BF just to prevent a crash
				}

				#if MODS_ALLOWED
				var rawJson = File.getContent(path);
				#else
				var rawJson = Assets.getText(path);
				#end

				var json:CharacterFile = cast Json.parse(rawJson);
				var spriteType = "sparrow";
				//sparrow
				//packer
				//texture
				#if MODS_ALLOWED
				var modTxtToFind:String = Paths.modsTxt(json.image);
				var txtToFind:String = Paths.getPath('images/' + json.image + '.txt', TEXT);
				
				//var modTextureToFind:String = Paths.modFolders("images/"+json.image);
				//var textureToFind:String = Paths.getPath('images/' + json.image, new AssetType();
				
				if (FileSystem.exists(modTxtToFind) || FileSystem.exists(txtToFind) || Assets.exists(txtToFind))
				#else
				if (Assets.exists(Paths.getPath('images/' + json.image + '.txt', TEXT)))
				#end
				{
					spriteType = "packer";
				}
				
				#if MODS_ALLOWED
				var modAnimToFind:String = Paths.modFolders('images/' + json.image + '/Animation.json');
				var animToFind:String = Paths.getPath('images/' + json.image + '/Animation.json', TEXT);
				
				//var modTextureToFind:String = Paths.modFolders("images/"+json.image);
				//var textureToFind:String = Paths.getPath('images/' + json.image, new AssetType();
				
				if (FileSystem.exists(modAnimToFind) || FileSystem.exists(animToFind) || Assets.exists(animToFind))
				#else
				if (Assets.exists(Paths.getPath('images/' + json.image + '/Animation.json', TEXT)))
				#end
				{
					spriteType = "texture";
				}

				switch (spriteType){
					
					case "packer":
						frames = Paths.getPackerAtlas(json.image);
					
					case "sparrow":
						frames = Paths.getSparrowAtlas(json.image);
					
					case "texture":
						frames = AtlasFrameMaker.construct(json.image);
				}
				imageFile = json.image;

				if(json.scale != 1) {
					jsonScale = json.scale;
					setGraphicSize(Std.int(width * jsonScale));
					updateHitbox();
				}

				positionArray = json.position;
				cameraPosition = json.camera_position;

				healthIcon = json.healthicon;
				singDuration = json.sing_duration;
				flipX = !!json.flip_x;
				if(json.no_antialiasing) {
					antialiasing = false;
					noAntialiasing = true;
				}

				if(json.healthbar_colors != null && json.healthbar_colors.length > 2)
					healthColorArray = json.healthbar_colors;

				antialiasing = !noAntialiasing;
				if(!ClientPrefs.globalAntialiasing) antialiasing = false;

				animationsArray = json.animations;
				if(animationsArray != null && animationsArray.length > 0) {
					for (anim in animationsArray) {
						var animAnim:String = '' + anim.anim;
						var animName:String = '' + anim.name;
						var animFps:Int = anim.fps;
						var animLoop:Bool = !!anim.loop; //Bruh
						var animIndices:Array<Int> = anim.indices;
						if(animIndices != null && animIndices.length > 0) {
							animation.addByIndices(animAnim, animName, animIndices, "", animFps, animLoop);
						} else {
							animation.addByPrefix(animAnim, animName, animFps, animLoop);
						}

						if(anim.offsets != null && anim.offsets.length > 1) {
							addOffset(anim.anim, anim.offsets[0], anim.offsets[1]);
						}
					}
				} else {
					quickAnimAdd('idle', 'BF idle dance');
				}
				//trace('Loaded file to character ' + curCharacter);
		}
		originalFlipX = flipX;

		if(animOffsets.exists('singLEFTmiss') || animOffsets.exists('singDOWNmiss') || animOffsets.exists('singUPmiss') || animOffsets.exists('singRIGHTmiss')) hasMissAnimations = true;
		recalculateDanceIdle();
		dance();

		if (isPlayer)
		{
			flipX = !flipX;

			/*// Doesn't flip for BF, since his are already in the right place???
			if (!curCharacter.startsWith('bf'))
			{
				// var animArray
				if(animation.getByName('singLEFT') != null && animation.getByName('singRIGHT') != null)
				{
					var oldRight = animation.getByName('singRIGHT').frames;
					animation.getByName('singRIGHT').frames = animation.getByName('singLEFT').frames;
					animation.getByName('singLEFT').frames = oldRight;
				}

				// IF THEY HAVE MISS ANIMATIONS??
				if (animation.getByName('singLEFTmiss') != null && animation.getByName('singRIGHTmiss') != null)
				{
					var oldMiss = animation.getByName('singRIGHTmiss').frames;
					animation.getByName('singRIGHTmiss').frames = animation.getByName('singLEFTmiss').frames;
					animation.getByName('singLEFTmiss').frames = oldMiss;
				}
			}*/
		}
	}

	/**
	 * HOW TO NOTE COLOR v1.2 101
	 * 
	 * multiple note color chars are done like this
	 * "charname" => [
	 * 	[left note main color, left note highlight color, left note outline color],
	 * 	[down note main color, down note highlight color, down note outline color],
	 * 	[up note main color, up note highlight color, up note outline color],
	 * 	[right note main color, right note highlight color, right note outline color]
	 * ],
	 * 
	 * singular note color chars are done like this
	 * "charname" => [note main color, note highlight color, note outline color],
	 * 
	 * now for example "char-pixel" has the same note color as "char" you can just do
	 * "char-pixel" => "char"
	 * it just does a redirection to the og chars color
	 */
	static var arrowColors:Map<String, OneOfThree<String, Array<Array<FlxColor>>, Array<FlxColor>>> = [
		"mario" => [
			[0xFFC22854, 0xFFFFFFFF, 0xFF56123D],
			[0xFF4941EF, 0xFFFFFFFF, 0xFF151661],
			[0xFFFA3E3E, 0xFFFFFFFF, 0xFF651126],
			[0xFFF9E93B, 0xFFFFFFFF, 0xFFD05512]
		],
		"marioUpset" => "mario",
		"mario-panic" => "mario",
		"mario-gba" => "mario",
		"baller-mario" => "mario",
		"baller-mario-L" => "mario",
		"128-mario" => "mario",
		"128-mario-pixel" => "mario",
		"floatmario" => "mario",

		"luigi" => [
			[0xFF1C8866, 0xFFFFFFFF, 0xFF12564D],
			[0xFF4941EF, 0xFFFFFFFF, 0xFF151661],
			[0xFF3EFA47, 0xFFFFFFFF, 0xFF226511],
			[0xFFF9E93B, 0xFFFFFFFF, 0xFFD05512]
		],
		"luigiUpset" => "luigi",
		"sexy-luigi" => "luigi",

		"captain-toad" => [
			[0xFFC22854, 0xFFFFFFFF, 0xFF56123D],
			[0xFFE1DAEA, 0xFFFFFFFF, 0xFF5B5C94],
			[0xFFFA3E3E, 0xFFFFFFFF, 0xFF651126],
			[0xFFEAF95F, 0xFFFFFFFF, 0xFFD07904]
		],
		"captain-cutscene" => "captain-toad",

		"FillBoard" => [0xFF844723, 0xFFFFFFFF, 0xFF2D180C],

		"burrows" => [
			[0xFFBE2E5A, 0xFFFFFFFF, 0xFF551B3D],
			[0xFF6EFFFF, 0xFFFFFFFF, 0xFF1B95C1],
			[0xFFE5A679, 0xFFFFFFFF, 0xFFE15B6A],
			[0xFF2694FF, 0xFFFFFFFF, 0xFF1122B8]
		],
		"burrows-pixel" => "burrows",

		"cinder" => [
			[0xFF8B3245, 0xFFFFFFFF, 0xFF440131],
			[0xFFFF7201, 0xFFFFFFFF, 0xFFA12024],
			[0xFFF11F1F, 0xFFFFFFFF, 0xFF7C0A35],
			[0xFFF7C413, 0xFFFFFFFF, 0xFF9B3A01]
		],

		"Rosalina" => [
			[0xFF48CB9B, 0xFFFFFFFF, 0xFF1B7A8D],
			[0xFFF3798D, 0xFFFFFFFF, 0xFF953367],
			[0xFF7AF2EC, 0xFFFFFFFF, 0xFF4C7CB7],
			[0xFFFBF185, 0xFFFFFFFF, 0xFFDF625E]
		],
		"RosalinaSG" => "Rosalina",

		"monik-gba" => [
			[0xFFB997F9, 0xFFFFFFFF, 0xFF7E04AC],
			[0xFF8EEFFF, 0xFFFFFFFF, 0xFF5A90D1],
			[0xFFC1FF7F, 0xFFFFFFFF, 0xFF4A864A],
			[0xFFFFA8EF, 0xFFFFFFFF, 0xFFC23280]
		],
		"monika-panic" => "monik-gba",

		"spg64" => [
			[0xFF3A42EA, 0xFFFFFFFF, 0xFF1C2072],
			[0xFFCA4599, 0xFFFFFFFF, 0xFF57265D],
			[0xFF8494F9, 0xFFFFFFFF, 0xFF333D77],
			[0xFFF8AA13, 0xFFFFFFFF, 0xFF702E08]
		],
		"spgfnf" => "spg64",

		"pbg" => [
			[0xFFC2455E, 0xFFFFFFFF, 0xFF561A51],
			[0xFFCCEFFF, 0xFFFFFFFF, 0xFF5353B7],
			[0xFF4750C4, 0xFFFFFFFF, 0xFF32226F],
			[0xFF9F454C, 0xFFFFFFFF, 0xFF652E4B]
		],

		"jackogoomba" => [
			[0xFFC2384F, 0xFFFFFFFF, 0xFF560C56],
			[0xFF2AC36F, 0xFFFFFFFF, 0xFF324885],
			[0xFFFAD292, 0xFFFFFFFF, 0xFFB1433A],
			[0xFFF97C24, 0xFFFFFFFF, 0xFF650C1B]
		],

		"pianta" => [
			[0xFF84C723, 0xFFFFFFFF, 0xFF114F2D],
			[0xFFB85E3D, 0xFFFFFFFF, 0xFF511F25],
			[0xFFBCBCDC, 0xFFFFFFFF, 0xFF383C90],
			[0xFF23C75B, 0xFFFFFFFF, 0xFF11404F]
		],

		"lubba" => [
			[0xFFD698FF, 0xFFFFFFFF, 0xFF8860D8],
			[0xFF0E94FF, 0xFFFFFFFF, 0xFF2B40A7],
			[0xFF9F4BDF, 0xFFFFFFFF, 0xFF393779],
			[0xFF49F2FA, 0xFFFFFFFF, 0xFF006CC3]
		],

		"hell" => [0xFF000000, 0xFFFFFFFF, 0xFFFFFFFF],
		"jimmy" => "hell",
		"aliens" => "hell",
		"skytrees" => "hell",
		"jimmytree" => "hell",
		"bfpovDark" => "hell",
	] ;

	public function fixArrowRGB()
		arrowRGB = getArrowRGB();

	public function getArrowRGB(?char:String):Array<Array<FlxColor>> {
		if (char == null) char = curCharacter;
		var toReturn:OneOfThree<String, Array<Array<FlxColor>>, Array<FlxColor>> = arrowColors.exists(char) ? arrowColors.get(char) : ClientPrefs.arrowRGB;
		if (toReturn is String)
			toReturn = arrowColors.exists(toReturn) ? arrowColors.get(toReturn) : ClientPrefs.arrowRGB;
		
		var getLengthFromAny:Array<Any>->Int = (shit:Array<Any>) -> {return shit.length;}; //fixes
		if (getLengthFromAny(toReturn) == 3)
			toReturn = [toReturn, toReturn, toReturn, toReturn];

		return toReturn;
	}

	override function update(elapsed:Float)
	{
		if(!debugMode && animation.curAnim != null)
		{
			if(heyTimer > 0)
			{
				heyTimer -= elapsed * PlayState.instance.playbackRate;
				if(heyTimer <= 0)
				{
					if(specialAnim && animation.curAnim.name == 'hey' || animation.curAnim.name == 'cheer')
					{
						specialAnim = false;
						dance();
					}
					heyTimer = 0;
				}
			} else if(specialAnim && animation.curAnim.finished)
			{
				specialAnim = false;
				dance();
			}
			
			switch(curCharacter)
			{
				case 'pico-speaker':
					if(animationNotes.length > 0 && Conductor.songPosition > animationNotes[0][0])
					{
						var noteData:Int = 1;
						if(animationNotes[0][1] > 2) noteData = 3;

						noteData += FlxG.random.int(0, 1);
						playAnim('shoot' + noteData, true);
						animationNotes.shift();
					}
					if(animation.curAnim.finished) playAnim(animation.curAnim.name, false, false, animation.curAnim.frames.length - 3);
			}

			if (!isPlayer)
				{
					if (!PlayState.opponentMode || curCharacter.startsWith('gf')) {
						if (animation.curAnim.name.startsWith('sing'))
						{
							holdTimer += elapsed;
						}
	
						if (holdTimer >= Conductor.stepCrochet * 0.001 * singDuration)
						{
							dance();
							holdTimer = 0;
						}
					} else {
						if (animation.curAnim.name.startsWith('sing'))
						{
							holdTimer += elapsed;
						}
						else
							holdTimer = 0;
	
						if (animation.curAnim.name.endsWith('miss') && animation.curAnim.finished && !debugMode)
							dance();
					}
				}

			if(animation.curAnim.finished && animation.getByName(animation.curAnim.name + '-loop') != null)
			{
				playAnim(animation.curAnim.name + '-loop');
			}
		}
		super.update(elapsed);
	}

	public var danced:Bool = false;

	inline public function isCharacterHasAnim(anim:String)
		return animOffsets.exists(anim);

	/**
	 * FOR GF DANCING SHIT
	 */
	public function dance()
	{
		if (!debugMode && !skipDance && !specialAnim)
		{
			if(danceIdle)
			{
				danced = !danced;

				if (danced)
					playAnim('danceRight' + idleSuffix);
				else
					playAnim('danceLeft' + idleSuffix);
			}
			else if(animation.getByName('idle' + idleSuffix) != null) {
					playAnim('idle' + idleSuffix);
			}
		}
	}

	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{
		specialAnim = false;
		animation.play(AnimName, Force, Reversed, Frame);

		var daOffset = animOffsets.get(AnimName);
		if (animOffsets.exists(AnimName))
		{
			offset.set(daOffset[0], daOffset[1]);
		}
		else
			offset.set(0, 0);

		if (curCharacter.startsWith('gf'))
		{
			if (AnimName == 'singLEFT')
			{
				danced = true;
			}
			else if (AnimName == 'singRIGHT')
			{
				danced = false;
			}

			if (AnimName == 'singUP' || AnimName == 'singDOWN')
			{
				danced = !danced;
			}
		}
	}

	function sortAnims(Obj1:Array<Dynamic>, Obj2:Array<Dynamic>):Int
	{
		return FlxSort.byValues(FlxSort.ASCENDING, Obj1[0], Obj2[0]);
	}

	public var danceEveryNumBeats:Int = 2;
	private var settingCharacterUp:Bool = true;
	public function recalculateDanceIdle() {
		var lastDanceIdle:Bool = danceIdle;
		danceIdle = (animation.getByName('danceLeft' + idleSuffix) != null && animation.getByName('danceRight' + idleSuffix) != null);

		if(settingCharacterUp)
		{
			danceEveryNumBeats = (danceIdle ? 1 : 2);
		}
		else if(lastDanceIdle != danceIdle)
		{
			var calc:Float = danceEveryNumBeats;
			if(danceIdle)
				calc /= 2;
			else
				calc *= 2;

			danceEveryNumBeats = Math.round(Math.max(calc, 1));
		}
		settingCharacterUp = false;
	}

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}

	public function quickAnimAdd(name:String, anim:String)
	{
		animation.addByPrefix(name, anim, 24, false);
	}
}
