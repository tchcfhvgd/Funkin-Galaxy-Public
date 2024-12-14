package;

import openfl.Lib;
#if desktop
import Discord.DiscordClient;
import sys.thread.Thread;
#end
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.input.keyboard.FlxKey;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import haxe.Json;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
#if MODS_ALLOWED
import sys.FileSystem;
import sys.io.File;
#end
import options.GraphicsSettingsSubState;
//import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.frames.FlxFrame;
import flixel.group.FlxGroup;
import flixel.input.gamepad.FlxGamepad;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxSound;
import flixel.system.ui.FlxSoundTray;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;
import openfl.Assets;

import openfl.display.Window;

using StringTools;
typedef TitleData =
{

	titlex:Float,
	titley:Float,
	startx:Float,
	starty:Float,
	gfx:Float,
	gfy:Float,
	backgroundSprite:String,
	bpm:Int
}
class TitleState extends MusicBeatState
{
	public static var muteKeys:Array<FlxKey> = [FlxKey.ZERO];
	public static var volumeDownKeys:Array<FlxKey> = [FlxKey.NUMPADMINUS, FlxKey.MINUS];
	public static var volumeUpKeys:Array<FlxKey> = [FlxKey.NUMPADPLUS, FlxKey.PLUS];

	public static var initialized:Bool = false;

	var blackScreen:FlxSprite;
	var credGroup:FlxGroup;
	var credTextShit:Alphabet;
	var textGroup:FlxGroup;
	var ngSpr:FlxSprite;
	
	var titleTextColors:Array<FlxColor> = [0xFF33FFFF, 0xFF3333CC];
	var titleTextAlphas:Array<Float> = [1, .64];

	var curWacky:Array<String> = [];

	var wackyImage:FlxSprite;

	var menuSong:FlxSound = null;
	var menuSong2:FlxSound = null;

	#if TITLE_SCREEN_EASTER_EGG
	var easterEggKeys:Array<String> = [
		'SHADOW', 'RIVER', 'SHUBS', 'BBPANZU'
	];
	var allowedKeys:String = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	var easterEggKeysBuffer:String = '';
	#end

	var mustUpdate:Bool = false;

	var titleJSON:TitleData;

	public static var updateVersion:String = '';

	var everEnter:Bool = false;
	var goingToMenu:Bool = false;

	var logoTween:FlxTween = null;
	var logoTweenFlash:FlxTween = null;
	var enterTween:FlxTween = null;
	var enterMove:FlxTween = null;
	var logoMove:FlxTween = null;

	var shootingStars:FlxTypedGroup<ShootingStarbit>;
	var shootingStar:ShootingStarbit;
	var shootTimer:FlxTimer;

	override public function create():Void
	{
		GameConfig.defaultWindowName = Lib.application.meta["name"];
		var currentBirthday = Birthdays.getBirthday();
		if (currentBirthday != "") {
			GameConfig.defaultWindowName += " | Happy Birthday " + currentBirthday + "!";
			Lib.application.window.title = GameConfig.defaultWindowName;
			trace("Happy Birthday " + currentBirthday + "!");
		} else {
			trace("No birthday today sadly :(");
		}

		MouseCursors.loadCursor('normal');
		Paths.clearStoredMemory();
		Paths.clearUnusedMemory();

		#if LUA_ALLOWED
		Paths.pushGlobalMods();
		#end
		// Just to load a mod on start up if ya got one. For mods that change the menu music and bg
		WeekData.loadTheFirstEnabledMod();

		//trace(path, FileSystem.exists(path));

		/*#if (polymod && !html5)
		if (sys.FileSystem.exists('mods/')) {
			var folders:Array<String> = [];
			for (file in sys.FileSystem.readDirectory('mods/')) {
				var path = haxe.io.Path.join(['mods/', file]);
				if (sys.FileSystem.isDirectory(path)) {
					folders.push(file);
				}
			}
			if(folders.length > 0) {
				polymod.Polymod.init({modRoot: "mods", dirs: folders});
			}
		}
		#end*/

		FlxG.game.focusLostFramerate = 60;
		FlxG.sound.muteKeys = muteKeys;
		FlxG.sound.volumeDownKeys = volumeDownKeys;
		FlxG.sound.volumeUpKeys = volumeUpKeys;
		FlxG.keys.preventDefaultKeys = [TAB];

		PlayerSettings.init();

		curWacky = FlxG.random.getObject(getIntroTextShit());

		// DEBUG BULLSHIT

		swagShader = new ColorSwap();
		super.create();
		FlxG.save.bind('funkin', 'ninjamuffin99');

		ClientPrefs.loadPrefs();

		#if CHECK_FOR_UPDATES
		if(ClientPrefs.checkForUpdates && !closedState) {
			var http = new haxe.Http("https://api.gamebanana.com/Core/Item/Data?itemtype=Mod&itemid=" + Std.string(GameConfig.gamebananaModID) + "&fields=Updates().aLatestUpdates()");

			http.onData = function (data:String)
			{
				var json = Json.parse(data)[0][0]; //why gb
				if (json != null) {
					updateVersion = json._sVersion;
					var curVersion:CoolUtil.Version = CoolUtil.parseVersion(MainMenuState.modVersion);
					var newVersion:CoolUtil.Version = CoolUtil.parseVersion(updateVersion);
					GameConfig.updateStatus = CoolUtil.versionCheck(curVersion, newVersion);
					if (GameConfig.updateStatus == OUTDATED)
						mustUpdate = true;
					else if(GameConfig.updateStatus == UPDATED)
						trace("bro is cooking a new version :O");
				}
			}

			http.onError = function (error) {
				trace('error: $error');
			}

			http.request();
		}
		#end

		// IGNORE THIS!!!
		titleJSON = Json.parse(Paths.getTextFromFile('images/title/data.json'));

		#if TITLE_SCREEN_EASTER_EGG
		if (FlxG.save.data.psychDevsEasterEgg == null) FlxG.save.data.psychDevsEasterEgg = ''; //Crash prevention
		switch(FlxG.save.data.psychDevsEasterEgg.toUpperCase())
		{
			case 'SHADOW':
				titleJSON.gfx += 210;
				titleJSON.gfy += 40;
			case 'RIVER':
				titleJSON.gfx += 100;
				titleJSON.gfy += 20;
			case 'SHUBS':
				titleJSON.gfx += 160;
				titleJSON.gfy -= 10;
			case 'BBPANZU':
				titleJSON.gfx += 45;
				titleJSON.gfy += 100;
		}
		#end

		if(!initialized)
		{
			if(FlxG.save.data != null && FlxG.save.data.fullscreen)
			{
				FlxG.fullscreen = FlxG.save.data.fullscreen;
				//trace('LOADED FULLSCREEN SETTING!!');
			}
			persistentUpdate = true;
			persistentDraw = true;
		}

		for (i in 0...ColorBlindShaders.list.length)
		{
			if (ColorBlindShaders.list[i] == ClientPrefs.colorblind) ColorBlindShaders.updateColors(ColorBlindShaders.list.indexOf(ColorBlindShaders.list[i]));
		}

		FlxG.mouse.visible = false;
		#if FREEPLAY
		MusicBeatState.switchState(new FreeplayState());
		#elseif CHARTING
		MusicBeatState.switchState(new ChartingState());
		#else
		if(FlxG.save.data.flashing == null && !FlashingState.leftState) {
			FlxTransitionableState.skipNextTransIn = true;
			FlxTransitionableState.skipNextTransOut = true;
			MusicBeatState.switchState(new FlashingState());
		} else {
			#if desktop
			if (!DiscordClient.isInitialized)
			{
				DiscordClient.prepare();
			}
			#end

			if (initialized)
				startIntro();
			else
			{
				new FlxTimer().start(1, function(tmr:FlxTimer)
				{
					startIntro();
				});
			}
		}
		#end
	}

	var logoBl:FlxSprite;
	var sfgLogo:FlxSprite;
	var sfgLogoFlash:FlxSprite;
	var danceLeft:Bool = false;
	var titleText:FlxSprite;
	var swagShader:ColorSwap = null;

	function startIntro()
	{
		if (!initialized)
		{
			/*var diamond:FlxGraphic = FlxGraphic.fromClass(GraphicTransTileDiamond);
			diamond.persist = true;
			diamond.destroyOnNoUse = false;

			FlxTransitionableState.defaultTransIn = new TransitionData(FADE, FlxColor.BLACK, 1, new FlxPoint(0, -1), {asset: diamond, width: 32, height: 32},
				new FlxRect(-300, -300, FlxG.width * 1.8, FlxG.height * 1.8));
			FlxTransitionableState.defaultTransOut = new TransitionData(FADE, FlxColor.BLACK, 0.7, new FlxPoint(0, 1),
				{asset: diamond, width: 32, height: 32}, new FlxRect(-300, -300, FlxG.width * 1.8, FlxG.height * 1.8));

			transIn = FlxTransitionableState.defaultTransIn;
			transOut = FlxTransitionableState.defaultTransOut;*/

			// HAD TO MODIFY SOME BACKEND SHIT
			// IF THIS PR IS HERE IF ITS ACCEPTED UR GOOD TO GO
			// https://github.com/HaxeFlixel/flixel-addons/pull/348

			// var music:FlxSound = new FlxSound();
			// music.loadStream(Paths.music('freakyMenu'));
			// FlxG.sound.list.add(music);
			// music.play();

			if(FlxG.sound.music == null) {
				FlxG.sound.playMusic(Paths.music('freakyMenu'), 0);
			}

			menuSong = FlxG.sound.play(Paths.music('overtureIntro'), 0.7);
			menuSong.pause();
			menuSong2 = FlxG.sound.play(Paths.music('overtureLoop'), 0.7, true);
			menuSong2.pause();
		}

		Conductor.changeBPM(titleJSON.bpm);
		persistentUpdate = true;

		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('title/bg1'));
		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);

		var bg2:FlxSprite = new FlxSprite().loadGraphic(Paths.image('title/bg2'));
		bg2.screenCenter();
		bg2.antialiasing = ClientPrefs.globalAntialiasing;

		logoBl = new FlxSprite(titleJSON.titlex, titleJSON.titley);
		logoBl.frames = Paths.getSparrowAtlas('title/logoBumpin');
		logoBl.antialiasing = ClientPrefs.globalAntialiasing;
		logoBl.animation.addByPrefix('bump', 'logo bumpin', 24, false);
		logoBl.animation.play('bump');
		logoBl.updateHitbox();

		sfgLogo = new FlxSprite().loadGraphic(Paths.image('title/new Logo'), true, 1000, 642);
		sfgLogo.animation.add('logo', [0, 1], 0, true);
		sfgLogo.animation.play('logo', true, 0);
		sfgLogo.antialiasing = ClientPrefs.globalAntialiasing;
		sfgLogo.updateHitbox();
		sfgLogo.screenCenter();
		sfgLogo.y -= 100;
		sfgLogo.scale.set(0,0);

		sfgLogoFlash = new FlxSprite().loadGraphic(Paths.image('title/new Logo Flash'));
		sfgLogoFlash.antialiasing = ClientPrefs.globalAntialiasing;
		sfgLogoFlash.updateHitbox();
		sfgLogoFlash.screenCenter();
		sfgLogoFlash.y -= 100;
		sfgLogoFlash.scale.set(0,0);
		shootingStars = new FlxTypedGroup<ShootingStarbit>();

		for (i in 0...41)
		{
			shootingStar = new ShootingStarbit((Math.floor(FlxG.random.int(-1350, 450)/15)) * 15, (Math.floor(FlxG.random.int(-200, -250)/15)) * 15);
			shootingStars.add(shootingStar);
		}
		add(shootingStars);
		add(bg2);

		//FlxG.camera.zoom = 0.5;

		// logoBl.screenCenter();
		// logoBl.color = FlxColor.BLACK;

		swagShader = new ColorSwap();

		var easterEgg:String = FlxG.save.data.psychDevsEasterEgg;
		if(easterEgg == null) easterEgg = ''; //html5 fix

		//add(logoBl);
		add(sfgLogo);
		add(sfgLogoFlash);
		//logoBl.shader = swagShader.shader;

		titleText = new FlxSprite(titleJSON.startx, titleJSON.starty).loadGraphic(Paths.image('title/enter'), true, 1019, 92);
		titleText.animation.add('idle', [1], 0, true);
		titleText.animation.add('press', [0, 2], 24, true);	
		titleText.antialiasing = ClientPrefs.globalAntialiasing;
		titleText.animation.play('idle');
		titleText.alpha = 0;
		titleText.scrollFactor.set(0, 0);
		titleText.screenCenter(X);
		titleText.x -= titleText.width/6.3;
		add(titleText);

		// FlxTween.tween(logoBl, {y: logoBl.y + 50}, 0.6, {ease: FlxEase.quadInOut, type: PINGPONG});
		// FlxTween.tween(logo, {y: logoBl.y + 50}, 0.6, {ease: FlxEase.quadInOut, type: PINGPONG, startDelay: 0.1});
		blackScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(blackScreen);

		credGroup = new FlxGroup();
		add(credGroup);
		textGroup = new FlxGroup();

		

		credTextShit = new Alphabet(0, 0, "", true);
		credTextShit.screenCenter();

		// credTextShit.alignment = CENTER;

		credTextShit.visible = false;

		ngSpr = new FlxSprite(0, FlxG.height * 0.52).loadGraphic(Paths.image('title/newgrounds_logo'));
		add(ngSpr);
		ngSpr.visible = false;
		ngSpr.setGraphicSize(Std.int(ngSpr.width * 0.8));
		ngSpr.updateHitbox();
		ngSpr.screenCenter(X);
		ngSpr.antialiasing = ClientPrefs.globalAntialiasing;

		FlxTween.tween(credTextShit, {y: credTextShit.y + 20}, 2.9, {ease: FlxEase.quadInOut, type: PINGPONG});

		if (initialized)
			skipIntro();
		else
			initialized = true;

		// credGroup.add(credTextShit);
	}

	function getIntroTextShit():Array<Array<String>>
	{
		var fullText:String = Assets.getText(Paths.txt('introText'));

		var firstArray:Array<String> = fullText.split('\n');
		var swagGoodArray:Array<Array<String>> = [];

		for (i in firstArray)
		{
			swagGoodArray.push(i.split('--'));
		}

		return swagGoodArray;
	}

	var transitioning:Bool = false;
	private static var playJingle:Bool = false;
	
	var newTitle:Bool = false;
	var titleTimer:Float = 0;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music != null)
			Conductor.songPosition = FlxG.sound.music.time;
		// FlxG.watch.addQuick('amp', FlxG.sound.music.amplitude);

		var pressedEnter:Bool = FlxG.keys.justPressed.ENTER || controls.ACCEPT;

		//I hate this code so much it feels like spaghetti
		if (everEnter && pressedEnter) {
				goingToMenu = true;
				sfgLogo.centerOrigin();
		}

		if (sfgLogoFlash != null)
			sfgLogoFlash.scale.set(sfgLogo.scale.x, sfgLogo.scale.y);

		#if mobile
		for (touch in FlxG.touches.list)
		{
			if (touch.justPressed)
			{
				pressedEnter = true;
			}
		}
		#end

		var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

		if (gamepad != null)
		{
			if (gamepad.justPressed.START)
				pressedEnter = true;

			#if switch
			if (gamepad.justPressed.B)
				pressedEnter = true;
			#end
		}
		
		if (newTitle) {
			titleTimer += CoolUtil.boundTo(elapsed, 0, 1);
			if (titleTimer > 2) titleTimer -= 2;
		}

		// EASTER EGG

		if (initialized && !transitioning && skippedIntro)
		{	
			if(pressedEnter)
			{
				menuSong.fadeOut(1.8, 0);
				menuSong2.fadeOut(1.8, 0);

				if(titleText != null) titleText.animation.play('press');

				if (logoTween != null)
				{
					logoTween.cancel();
					logoTween = null;
					sfgLogo.scale.set(1,1);
				}
				if (logoTweenFlash != null)
				{
					logoTweenFlash.cancel();
					logoTweenFlash = null;
					sfgLogoFlash.scale.set(1,1);
					sfgLogoFlash.alpha = 1;
				}
				if (enterTween != null)
				{
					enterTween.cancel();
					enterTween = null;
					titleText.alpha = 1;
				}
				if (enterMove != null)
				{
					enterMove.cancel();
					enterMove = null;
				}
				if (logoMove != null)
				{
					logoMove.cancel();
					logoMove = null;
				}
				titleText.x += titleText.width/2.23;
				sfgLogoFlash.alpha = 1;
				sfgLogo.animation.frameIndex = 1;
				logoTween = FlxTween.tween(sfgLogo, {'scale.x': 0.5, 'scale.y': 0.5, 'alpha': 0}, 3, {ease: FlxEase.sineIn, startDelay: 0.5});
				logoTweenFlash = FlxTween.tween(sfgLogoFlash, {alpha: 0}, 0.5, {ease: FlxEase.sineIn, startDelay: 0.5});
				enterTween = FlxTween.tween(titleText, {alpha: 0}, 1, {ease: FlxEase.sineIn, startDelay: 0.3});

				//FlxG.camera.flash(ClientPrefs.flashing ? FlxColor.WHITE : 0x4CFFFFFF, 1);
				FlxG.sound.play(Paths.sound('overtureInput'), 0.7);
				//FlxTween.tween(FlxG.camera, {zoom: 4}, 2, {ease: FlxEase.quartInOut, startDelay: 0.2});
 
				transitioning = true;
				// FlxG.sound.music.stop();

				new FlxTimer().start(2, function(tmr:FlxTimer)
				{
					if (mustUpdate) {
						MusicBeatState.switchState(new OutdatedState());
					} else {
						MusicBeatState.switchState(new SaveSelectState());
					}
					closedState = true;
				});
				// FlxG.sound.play(Paths.music('titleShoot'), 0.7);
			}
			#if TITLE_SCREEN_EASTER_EGG
			else if (FlxG.keys.firstJustPressed() != FlxKey.NONE)
			{
				var keyPressed:FlxKey = FlxG.keys.firstJustPressed();
				var keyName:String = Std.string(keyPressed);
				if(allowedKeys.contains(keyName)) {
					easterEggKeysBuffer += keyName;
					if(easterEggKeysBuffer.length >= 32) easterEggKeysBuffer = easterEggKeysBuffer.substring(1);
					//trace('Test! Allowed Key pressed!!! Buffer: ' + easterEggKeysBuffer);

					for (wordRaw in easterEggKeys)
					{
						var word:String = wordRaw.toUpperCase(); //just for being sure you're doing it right
						if (easterEggKeysBuffer.contains(word))
						{
							//trace('YOOO! ' + word);
							if (FlxG.save.data.psychDevsEasterEgg == word)
								FlxG.save.data.psychDevsEasterEgg = '';
							else
								FlxG.save.data.psychDevsEasterEgg = word;
							FlxG.save.flush();

							FlxG.sound.play(Paths.sound('ToggleJingle'));

							var black:FlxSprite = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
							black.alpha = 0;
							add(black);

							FlxTween.tween(black, {alpha: 1}, 1, {onComplete:
								function(twn:FlxTween) {
									FlxTransitionableState.skipNextTransIn = true;
									FlxTransitionableState.skipNextTransOut = true;
									MusicBeatState.switchState(new TitleState());
								}
							});
							FlxG.sound.music.fadeOut();
							closedState = true;
							transitioning = true;
							playJingle = true;
							easterEggKeysBuffer = '';
							break;
						}
					}
				}
			}
			#end
		}

		if (initialized && pressedEnter && !skippedIntro)
		{
			skipIntro();
		}

		if(swagShader != null)
		{
			if(controls.UI_LEFT) swagShader.hue -= elapsed * 0.1;
			if(controls.UI_RIGHT) swagShader.hue += elapsed * 0.1;
		}

		super.update(elapsed);
	}

	function createCoolText(textArray:Array<String>, ?offset:Float = 0)
	{
		for (i in 0...textArray.length)
		{
			var money:Alphabet = new Alphabet(0, 0, textArray[i], true);
			money.screenCenter(X);
			money.y += (i * 60) + 200 + offset;
			if(credGroup != null && textGroup != null) {
				credGroup.add(money);
				textGroup.add(money);
			}
		}
	}

	function addMoreText(text:String, ?offset:Float = 0)
	{
		if(textGroup != null && credGroup != null) {
			var coolText:Alphabet = new Alphabet(0, 0, text, true);
			coolText.screenCenter(X);
			coolText.y += (textGroup.length * 60) + 200 + offset;
			credGroup.add(coolText);
			textGroup.add(coolText);
		}
	}

	function deleteCoolText()
	{
		while (textGroup.members.length > 0)
		{
			credGroup.remove(textGroup.members[0], true);
			textGroup.remove(textGroup.members[0], true);
		}
	}

	private var sickBeats:Int = 0; //Basically curBeat but won't be skipped if you hold the tab or resize the screen
	public static var closedState:Bool = false;
	override function beatHit()
	{
		super.beatHit();

		if(logoBl != null)
			logoBl.animation.play('bump', true);

		if(!closedState) {
			sickBeats++;
			switch (sickBeats)
			{
				case 2:
					#if PSYCH_WATERMARKS
					createCoolText(['Psych Engine by'], 15);
					#else
					createCoolText(['ninjamuffin99', 'phantomArcade', 'kawaisprite', 'evilsk8er']);
					#end
					FlxG.sound.play(Paths.sound('introText'), 0.7);
				// credTextShit.visible = true;
				case 4:
					#if PSYCH_WATERMARKS
					addMoreText('Shadow Mario', 15);
					addMoreText('RiverOaken', 15);
					addMoreText('shubs', 15);
					#else
					addMoreText('present');
					#end
					FlxG.sound.play(Paths.sound('introText'), 0.7);
				// credTextShit.text += '\npresent...';
				// credTextShit.addText();
				case 5:
					deleteCoolText();
				// credTextShit.visible = false;
				// credTextShit.text = 'In association \nwith';
				// credTextShit.screenCenter();
				case 6:
					#if PSYCH_WATERMARKS
					createCoolText(['Not associated', 'with'], -40);
					#else
					createCoolText(['In association', 'with'], -40);
					#end
					FlxG.sound.play(Paths.sound('introText'), 0.7);
				case 8:
					addMoreText('newgrounds', -40);
					ngSpr.visible = true;
				// credTextShit.text += '\nNewgrounds';
				FlxG.sound.play(Paths.sound('introText'), 0.7);
				case 9:
					deleteCoolText();
					ngSpr.visible = false;
				// credTextShit.visible = false;

				// credTextShit.text = 'Shoutouts Tom Fulp';
				// credTextShit.screenCenter();
				case 10:
					createCoolText([curWacky[0]]);
				// credTextShit.visible = true;
				FlxG.sound.play(Paths.sound('introText'), 0.7);
				case 12:
					addMoreText(curWacky[1]);
				// credTextShit.text += '\nlmao';
				FlxG.sound.play(Paths.sound('introText'), 0.7);
				case 13:
					deleteCoolText();
				// credTextShit.visible = false;
				// credTextShit.text = "Friday";
				// credTextShit.screenCenter();
				case 14:
					skipIntro();
			}
		}
	}

	function shootStar()
	{
		while (true)
		{
			var randomStar:Int = FlxG.random.int(0, shootingStars.length - 1);
			if (!shootingStars.members[randomStar].hasBeenShot)
			{
				shootingStars.members[randomStar].hasBeenShot = true;
				shootingStars.members[randomStar].shootTween = FlxTween.tween(shootingStars.members[randomStar], 
					{x: shootingStars.members[randomStar].xPos + 2000, y: shootingStars.members[randomStar].yPos + 1000}, FlxG.random.int(6, 12), {onComplete: shoot -> {
					shootingStars.members[randomStar].hasBeenShot = false;
					shootingStars.members[randomStar].shootTween = null;
					shootingStars.members[randomStar].x = shootingStars.members[randomStar].xPos;
					shootingStars.members[randomStar].y = shootingStars.members[randomStar].yPos;
					shootingStars.members[randomStar].changeColor();
				}});
				FlxG.sound.play(Paths.sound('shootingStar'), 0.0008);
				return;
			}
			else
				continue;
		}
	}

	var skippedIntro:Bool = false;
	var increaseVolume:Bool = false;
	function skipIntro():Void
	{
		FlxG.sound.music.stop();
		menuSong.resume();
		menuSong.onComplete = function()
		{
			menuSong2.resume();
		}

		if (!skippedIntro)
		{
			if (!everEnter) {
				everEnter = true;
				shootTimer = new FlxTimer().start(1, function(tmr:FlxTimer)
				{
					shootStar();
				}, 0);
				FlxTween.tween(blackScreen, {alpha:0}, 0.15, {startDelay: 0.25});
				logoTween = FlxTween.tween(sfgLogo, {'scale.x': 1, 'scale.y': 1}, 0.15, {ease:FlxEase.quadOut, startDelay: 0.25, onComplete: fuck -> {
					if (!goingToMenu){FlxG.camera.flash(FlxColor.WHITE, 2.5); logoTween = null;}}});
				logoTweenFlash = FlxTween.tween(sfgLogoFlash, {alpha: 0}, 2, {startDelay: 0.4, onComplete: fuck -> {
						if (!goingToMenu){logoTweenFlash = null;}}});
				enterMove = FlxTween.tween(titleText, {y: titleText.y - 3}, 1.5, {ease: FlxEase.sineInOut, type: PINGPONG, startDelay: 0.25});
				logoMove = FlxTween.tween(sfgLogo, {y: sfgLogo.y - 3}, 3.5, {ease: FlxEase.sineInOut, type: PINGPONG, startDelay: 0.35});
				enterTween = FlxTween.tween(titleText, {alpha: 1}, 0.4, {startDelay: 3.65, onComplete: fuck -> {if (!goingToMenu){enterTween = null;}}});
			}
			if (playJingle) //Ignore deez
			{
				var easteregg:String = FlxG.save.data.psychDevsEasterEgg;
				if (easteregg == null) easteregg = '';
				easteregg = easteregg.toUpperCase();

				var sound:FlxSound = null;
				switch(easteregg)
				{
					case 'RIVER':
						sound = FlxG.sound.play(Paths.sound('JingleRiver'));
					case 'SHUBS':
						sound = FlxG.sound.play(Paths.sound('JingleShubs'));
					case 'SHADOW':
						FlxG.sound.play(Paths.sound('JingleShadow'));
					case 'BBPANZU':
						sound = FlxG.sound.play(Paths.sound('JingleBB'));

					default: //Go back to normal ugly ass boring GF
						remove(ngSpr);
						remove(credGroup);
						//FlxG.camera.flash(FlxColor.WHITE, 2);
						skippedIntro = true;
						playJingle = false;

						FlxG.sound.playMusic(Paths.music('freakyMenu'), 0);
						FlxG.sound.music.fadeIn(4, 0, 0.7);
						return;
				}

				transitioning = true;
				if(easteregg == 'SHADOW')
				{
					new FlxTimer().start(3.2, function(tmr:FlxTimer)
					{
						remove(ngSpr);
						remove(credGroup);
						//FlxG.camera.flash(FlxColor.WHITE, 0.6);
						transitioning = false;
					});
				}
				else
				{
					remove(ngSpr);
					remove(credGroup);
					//FlxG.camera.flash(FlxColor.WHITE, 3);
					sound.onComplete = function() {
						FlxG.sound.playMusic(Paths.music('freakyMenu'), 0);
						FlxG.sound.music.fadeIn(4, 0, 0.7);
						transitioning = false;
					};
				}
				playJingle = false;
			}
			else //Default! Edit this one!!
			{
				remove(ngSpr);
				remove(credGroup);
				//FlxG.camera.flash(FlxColor.WHITE, 4);

				var easteregg:String = FlxG.save.data.psychDevsEasterEgg;
				if (easteregg == null) easteregg = '';
				easteregg = easteregg.toUpperCase();
				#if TITLE_SCREEN_EASTER_EGG
				if(easteregg == 'SHADOW')
				{
					FlxG.sound.music.fadeOut();
				}
				#end
			}
			skippedIntro = true;
		}
		Paths.clearUnusedMemory();
	}
}
