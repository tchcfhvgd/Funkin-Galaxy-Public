import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;
import flixel.text.FlxText;

using StringTools;

class Achievements {
	public static var achievementsStuff:Array<Dynamic> = [ //Name, Description, Achievement save tag, Hidden achievement
		["Stars Aligned",					"Full Combo Love Driven.",								'love-driven_nomiss',		false],
		["Welcome!",					"Full Combo Star Festival.",								'star-festival_nomiss',		false],
		["Starshroom",					"Full Combo Toad Brigade.",								'toad-brigade_nomiss',		false],
		["IT'S ALIVE!!!",					"Full Combo Hey There.",								'hey-there_nomiss',		false],
		["Unfamiliar Encounter",					"Full Combo Gusty Garden.",								'gusty-garden_nomiss',		false],
		["Luigi Time!",					"Full Combo Funky Factory.",								'funky-factory_nomiss',		false],
		["Shattered Reflection",					"Full Combo Cosmic Battle.",								'cosmic-battle_nomiss',		false],
		["Spicy Performance",					"Full Combo Hell Prominence.",								'hell-prominence_nomiss',		false],
		["Powered-Up",					"Full Combo Purple Comet.",								'purple-comet_nomiss',		false],
		["Jack-O-Combo!",					"Full Combo Luminous Swing.",								'luminous-swing_nomiss',		false],
		["Oki Doki!",					"Full Combo Panic Club.",								'panic-club_nomiss',		false],
		["128",							"Full Combo Revolution.",								'revolution_nomiss',			false],
		["Ballin'",						"Full Combo Sports Mix.",								'sports-mix_nomiss',		false],
		["Luigi on the Roof",						"Full Combo Rooftop Shame.",								'rooftop-shame_nomiss',		false],
		["Self-Insert",					"Full Combo Wii Modder.",								'wii-modder_nomiss',			false],
		["The Sexiest of them All..",		"Full Combo Sexy Luigi.",								'sexy-luigi_nomiss',			false],
		["Web of Lies",				"Full Combo Deluded Sensation.",								'deluded-sensation_nomiss',		false],
		["I'm a Chuckster!",				"Full Combo Chuckster.",								'chuckster_nomiss',		false],
		["Leaked Footage",				"Full Combo Starship Mario.",								'starship-mario_nomiss',		false],
		["Urban Legend",				"Full Combo Hell Valley.",								'hell-valley_nomiss',		false],
		["Calm Once Again",				"Full Combo Astronomical.",								'astronomical_nomiss',		false],
		["I did this.",				"Full Combo Purple Coin Lyrics.",								'purple-coin-lyrics_nomiss',		false],
		["Boing!",				"Full Combo Prankster Club.",								'prankster-club_nomiss',		false],
		["Toadsty Beats",			"Full Combo Toad Brigade Erect.",						'toad-brigade-erect_nomiss',		false],
		["Holy Moley!",			"Full Combo Gusty Garden Erect.",						'gusty-garden-erect_nomiss',		false],
		["Here With the Boys",			"Full Combo Cosmic Battle Erect.",						'cosmic-battle-erect_nomiss',		false],
		["Beyond the Valley",				"Full Combo Hell Valley Erect.",								'hell-valley-erect_nomiss',		false],
		["Boyfriend's Wish",				"Full Combo The Wish.",								'the-wish_nomiss',		false],
		["Familiar Encounter",				"Full Combo Gusty Garden Old.",								'gusty-garden-old_nomiss',		false],
		["Freaky on a Friday Night",	"Play on a Friday... Night.",							'friday_night_play',	 false],
		["You 'Don Fucked Up",		"He's not gonna sugarcoat it.",								'sugarcoat',				 false],
		["Give a Lil' Bit Back",		"Check out the Credits!",								'credits',				 false],
		["Oh shit.",						"Access the Debug Menu.",								'debug',				 false],
	//	["Tired Vocal Chords",			"Beat Every Song.",							'beat_finish',				false],
	//	["Funk Master",			"FC Every Song.",							'nomiss_finish',				false],
	//	["You-a Number One!",			"100% the Entire Demo!",							'finish',				false]
	];
	public static var achievementsMap:Map<String, Bool> = new Map<String, Bool>();

	public static var henchmenDeath:Int = 0;
	public static function unlockAchievement(name:String):Void {
		FlxG.log.add('Completed achievement "' + name +'"');
		achievementsMap.set(name, true);
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
	}

	public static function isAchievementUnlocked(name:String) {
		if(achievementsMap.exists(name) && achievementsMap.get(name)) {
			return true;
		}
		return false;
	}

	public static function getAchievementIndex(name:String) {
		for (i in 0...achievementsStuff.length) {
			if(achievementsStuff[i][2] == name) {
				return i;
			}
		}
		return -1;
	}

	public static function loadAchievements():Void {
		if(FlxG.save.data != null) {
			if(FlxG.save.data.achievementsMap != null) {
				achievementsMap = FlxG.save.data.achievementsMap;
			}
			if(henchmenDeath == 0 && FlxG.save.data.henchmenDeath != null) {
				henchmenDeath = FlxG.save.data.henchmenDeath;
			}
		}
	}
}

class AttachedAchievement extends FlxSprite {
	public var sprTracker:FlxSprite;
	private var tag:String;
	public function new(x:Float = 0, y:Float = 0, name:String) {
		super(x, y);

		changeAchievement(name);
		antialiasing = ClientPrefs.globalAntialiasing;
	}

	public function changeAchievement(tag:String) {
		this.tag = tag;
		reloadAchievementImage();
	}

	public function reloadAchievementImage() {
		if(Achievements.isAchievementUnlocked(tag)) {
			loadGraphic(Paths.image('achievements/' + tag));
		} else {
			loadGraphic(Paths.image('achievements/lockedachievement'));
		}
		scale.set(0.7, 0.7);
		updateHitbox();
	}

	override function update(elapsed:Float) {
		if (sprTracker != null)
			setPosition(sprTracker.x - 130, sprTracker.y + 25);

		super.update(elapsed);
	}
}

class AchievementObject extends FlxSpriteGroup {
	public var onFinish:Void->Void = null;
	var alphaTween:FlxTween;
	public function new(name:String, ?camera:FlxCamera = null)
	{
		super(x, y);
		ClientPrefs.saveSettings();

		var id:Int = Achievements.getAchievementIndex(name);
		var achievementBG:FlxSprite = new FlxSprite(60, 50).makeGraphic(420, 120, FlxColor.BLACK);
		achievementBG.scrollFactor.set();

		var achievementIcon:FlxSprite = new FlxSprite(achievementBG.x + 10, achievementBG.y + 10).loadGraphic(Paths.image('achievements/' + name));
		achievementIcon.scrollFactor.set();
		achievementIcon.setGraphicSize(Std.int(achievementIcon.width * (2 / 3)));
		achievementIcon.updateHitbox();
		achievementIcon.antialiasing = ClientPrefs.globalAntialiasing;

		var achievementName:FlxText = new FlxText(achievementIcon.x + achievementIcon.width + 20, achievementIcon.y + 16, 280, Achievements.achievementsStuff[id][0], 16);
		achievementName.setFormat(Paths.font("Delfino.ttf"), 16, FlxColor.WHITE, LEFT);
		achievementName.scrollFactor.set();

		var achievementText:FlxText = new FlxText(achievementName.x, achievementName.y + 32, 280, Achievements.achievementsStuff[id][1], 16);
		achievementText.setFormat(Paths.font("Delfino.ttf"), 16, FlxColor.WHITE, LEFT);
		achievementText.scrollFactor.set();

		add(achievementBG);
		add(achievementName);
		add(achievementText);
		add(achievementIcon);

		var cam:Array<FlxCamera> = FlxCamera.defaultCameras;
		if(camera != null) {
			cam = [camera];
		}
		alpha = 0;
		achievementBG.cameras = cam;
		achievementName.cameras = cam;
		achievementText.cameras = cam;
		achievementIcon.cameras = cam;
		alphaTween = FlxTween.tween(this, {alpha: 1}, 0.5, {onComplete: function (twn:FlxTween) {
			alphaTween = FlxTween.tween(this, {alpha: 0}, 0.5, {
				startDelay: 2.5,
				onComplete: function(twn:FlxTween) {
					alphaTween = null;
					remove(this);
					if(onFinish != null) onFinish();
				}
			});
		}});
	}

	override function destroy() {
		if(alphaTween != null) {
			alphaTween.cancel();
		}
		super.destroy();
	}
}