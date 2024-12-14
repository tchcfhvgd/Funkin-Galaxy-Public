package;

import flixel.FlxSubState;
import flixel.FlxSprite;
import flixel.util.FlxTimer;
import flixel.group.FlxGroup.FlxTypedGroup;
import openfl.utils.Assets;
import flixel.FlxG;
import flixel.math.FlxMath;

using StringTools;

class StickerSubState extends FlxSubState
{
    public var switchingState:Bool;
    public var sounds:Array<String>;
    public var soundSelection:String;
    public var soundSelections:Array<String>;
    public var targetState:StickerSubState->Void = null;
    public var grpStickers:FlxTypedGroup<StickerSprite>;

    public function degenStickers()
    {
        cameras = grpStickers.cameras = FlxG.cameras.list;
        for (cam in FlxG.cameras.list)
        {
            cam.setFilters([]);
        }
       if (grpStickers.members == null || grpStickers.members.length == 0) {
         switchingState = false;
         close();
         return;
       }
       var _g_current = 0;
       var _g_array = grpStickers.members;
       while (_g_current < _g_array.length) {
         var sticker = _g_array[_g_current];
         var ind = _g_current++;
         new FlxTimer().start(sticker.timing, function (_) {
             sticker.visible = (false);
             FlxG.sound.play(Paths.soundRandom("stickersounds/", 1, 8, "shared"), 0.8);
             if (grpStickers == null || ind == grpStickers.members.length - 1) {
               switchingState = false;
               close();
             }
         });
       }
    }
    public function regenStickers() @:privateAccess
    {
       if (grpStickers.members.length > 0) {
         grpStickers.clear();
       }
       var stickerInfo = new StickerInfo("stickers-set-1");
       var xPos:Float = -100;
       var yPos:Float = -100;
       
        //fuck i had to remake this part because it wasnt working properly with psych --furo
       var numOfStickers = 0;
       while (xPos <= FlxG.width) {
        var packs:Array<String> = [for (pack in stickerInfo.stickerPacks.keys()) (pack)];
        var packIndex:Int = FlxG.random.int(0, packs.length - 1);
        var daStickerPack = packs[packIndex];
        var stickSetPack:Array<String> = stickerInfo.stickerPacks.get(daStickerPack);
        var allStickersToChoseFrom:Array<String> = [];
        for (char in stickSetPack)
        {
            for (sticke in stickerInfo.stickers.get(char))
            {
                allStickersToChoseFrom.push(sticke);
            }
        }
        var stickerIndex:Int = FlxG.random.int(0, allStickersToChoseFrom.length - 1);
        
            var sticker:String = allStickersToChoseFrom[stickerIndex];
             var sticky = new StickerSprite(0, 0, stickerInfo.name, sticker);
             sticky.visible = (false);
             sticky.x = (xPos);
             sticky.y = (yPos);
             xPos += sticky.frameWidth * 0.5;
             if (xPos >= FlxG.width) {
               if (yPos <= FlxG.height) {
                 xPos = -100;
                 yPos += FlxG.random.float(70, 120);
               }
             }
             sticky.angle = (FlxG.random.int(-60, 70));
             grpStickers.add(sticky);
             numOfStickers++;
            //okay i finished smh
       }
       FlxG.random.shuffle(grpStickers.members);
       var _g_current = 0;
       var _g_array = grpStickers.members;
       while (_g_current < _g_array.length) {
         var sticker = _g_array[_g_current];
         var ind = _g_current++;
         sticker.timing = FlxMath.remapToRange(ind, 0, grpStickers.members.length, 0, 0.9);
         new FlxTimer().start(sticker.timing, function (_) {
             if (grpStickers == null) {
               return;
             }
             sticker.visible = (true);
             FlxG.sound.play(Paths.soundRandom("stickersounds/", 1, 8, "shared"), 0.8);
             var frameTimer = FlxG.random.int(0, 2);
             if (ind == grpStickers.members.length - 1) {
               frameTimer = 2;
             }
             new FlxTimer().start(0.0415 * frameTimer, function (_) {
                 if (sticker == null) {
                   return;
                 }
                 sticker.scale.x = (sticker.scale.y = (FlxG.random.float(0.97, 1.02)));
                 if (ind == grpStickers.members.length - 1) {
                   switchingState = true;
                   for (cam in FlxG.cameras.list)
                   {
                       cam.setFilters([]);
                   }
                   targetState(this);
                 }
             });
         });
       }
       var _g = function (ord, a:StickerSprite, b:StickerSprite) {
         var Value1 = a.timing;
         var Value2 = b.timing;
         var result = 0;
         if (Value1 < Value2) {
           result = ord;
         } else if (Value1 > Value2) {
           result = -ord;
         }
         return result;
       };
       var a1 = -1;
       var tmp = function (a2:StickerSprite, a3:StickerSprite) {
         return _g(a1, a2, a3);
       };
       grpStickers.members.sort(tmp);
       var lastOne = grpStickers.members[grpStickers.members.length - 1];
       lastOne.updateHitbox();
       lastOne.angle = (0);
       lastOne.x = ((FlxG.width - lastOne.get_width()) / 2);
       lastOne.y = ((FlxG.height - lastOne.get_height()) / 2);
    }
    override public function close()
    {
       if (switchingState) {
         return;
       }
       super.close();
    }
    override public function destroy()
    {
       if (switchingState) {
         return;
       }
       super.destroy();
    }
    public function new(oldStickers, targetState)
    {
        this.targetState = targetState;
       switchingState = false;
       sounds = [];
       soundSelection = "";
       soundSelections = [];
       super();
       var assetsInList = Assets.list();
       var soundFilterFunc = function (a) {
         return StringTools.startsWith(a, "assets/shared/sounds/stickersounds/");
       };
       var _g:Array<String> = [];
       var _g1 = 0;
       var _g2 = assetsInList;
       while (_g1 < _g2.length) {
         var v = _g2[_g1];
         ++_g1;
         if (soundFilterFunc(v)) {
           _g.push(v);
         }
       }
       soundSelections = _g;
       var _this = soundSelections;
       var result = new Array();
       var _gh = 0;
       var _g1 = _g.length;
       while (_gh < _g1) {
         var i = _gh++;
         result[i] = StringTools.replace(_this[i], "assets/shared/sounds/stickersounds/", "").split("/")[0];
       }
       soundSelections = result;
       var _g = 0;
       var _g1 = soundSelections;
       while (_g < _g1.length) {
         var i = _g1[_g];
         ++_g;
         while (soundSelections.indexOf(i) != -1) soundSelections.remove(i);
         soundSelections.push(i);
       }
       soundSelection = FlxG.random.getObject(soundSelections);
       var filterFunc = function (a) {
         return StringTools.startsWith(a, "assets/shared/sounds/stickersounds/" + soundSelections + "/");
       };
       var assetsInList3 = Assets.list();
       var _g = [];
       var _g1 = 0;
       var _g2 = assetsInList3;
       while (_g1 < _g2.length) {
         var v = _g2[_g1];
         ++_g1;
         if (filterFunc(v)) {
           _g.push(v);
         }
       }
       sounds = _g;
       var _g = 0;
       var _g1 = sounds.length;
       while (_g < _g1) {
         var i = _g++;
         sounds[i] = sounds[i].replace("assets/shared/sounds/", "");
         sounds[i] = sounds[i].substring(0, sounds[i].lastIndexOf("."));
       }
       grpStickers = new FlxTypedGroup();
       add(grpStickers);
       grpStickers.cameras = (FlxG.cameras.list);
       if (oldStickers != null) {
         var _g = 0;
         while (_g < oldStickers.length) {
           var sticker = oldStickers[_g];
           ++_g;
           grpStickers.add(sticker);
         }
         degenStickers();
       } else {
         regenStickers();
       }
    }

}

class StickerSprite extends FlxSprite
{
    public var timing:Float;

    public function new(x, y, stickerSet, stickerName)
    {
       timing = 0;
       super(x, y);
       loadGraphic(Paths.image("transitionSwag/" + stickerSet + "/" + stickerName, "shared"));
       updateHitbox();
       scrollFactor.set(0, 0);
    }

}

class StickerInfo
{
    public var name:String;
    public var artist:String;
    public var stickerPacks:Map<String, Array<String>>;
    public var stickers:Map<String, Array<String>>;

    public function new(stickerSet) @:privateAccess
    {
       var path = Paths.file("images/transitionSwag/" + stickerSet + "/stickers.json");
       var json = haxe.Json.parse(Assets.getText(path));
       var jsonInfo = json;
       name = jsonInfo.name;
       artist = jsonInfo.artist;
       stickerPacks = [];
       var _g = 0;
       var _g1 = Reflect.fields(json.stickerPacks);
       while (_g < _g1.length) {
         var field = _g1[_g];
         ++_g;
         var stickerFunny = json.stickerPacks;
         var stickerStuff = Reflect.field(stickerFunny, field);
         stickerPacks[field] = stickerStuff;
       }
       stickers = [];
       var _g = 0;
       var _g1 = Reflect.fields(json.stickers);
       while (_g < _g1.length) {
         var field = _g1[_g];
         ++_g;
         var stickerFunny = json.stickers;
         var stickerStuff = Reflect.field(stickerFunny, field);
         stickers[field] = stickerStuff;
       }
    }

}