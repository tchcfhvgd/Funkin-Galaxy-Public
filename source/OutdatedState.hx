package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;

using StringTools;

class OutdatedState extends MusicBeatState
{
	public static var leftState:Bool = false;

	var warnText:FlxText;
	override function create()
	{
		super.create();

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(bg);

		var updateFrom = CoolUtil.parseVersion(MainMenuState.modVersion.trim());
		var updateTo = CoolUtil.parseVersion(TitleState.updateVersion.trim());

		var fromFormat = "$MAJOR.$MINOR.$PATCH";
		var toFormat = "$MAJOR.$MINOR.$PATCH";

		if (CoolUtil.isVersionDemo(updateFrom))
			fromFormat = "(Demo) $MAJOR.$MINOR.$PATCH";
		if (CoolUtil.isVersionDemo(updateTo))
			toFormat = "(Demo) $MAJOR.$MINOR.$PATCH";

		warnText = new FlxText(0, 0, FlxG.width,
			"Hey man, looks like you're still on that   \n
			old version of Super Funkin' Galaxy (" + CoolUtil.getDisplayVersion(updateFrom, fromFormat) + "),\n
			update to the " + CoolUtil.getDisplayVersion(updateTo, toFormat) + " to have a
			better experience!\n
			Press ENTER or SPACE to update.\n
			Press ESCAPE to proceed anyway.\n
			\n
			Thank you for playing the mod!",
			32);
		warnText.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, CENTER);
		warnText.screenCenter(Y);
		warnText.screenCenter(X);
		add(warnText);
	}

	override function update(elapsed:Float)
	{
		if(!leftState) {
			if (controls.ACCEPT) {
				leftState = true;
				CoolUtil.browserLoad("https://gamebanana.com/wips/69916"); //JUST SAW IT HAS 69 IN IT LMAOOOO
			}
			else if(controls.BACK) {
				leftState = true;
			}

			if(leftState)
			{
				FlxG.sound.play(Paths.sound('cancelMenu'));
				FlxTween.tween(warnText, {alpha: 0}, 1, {
					onComplete: function (twn:FlxTween) {
						MusicBeatState.switchState(new SaveSelectState());
					}
				});
			}
		}
		super.update(elapsed);
	}
}
