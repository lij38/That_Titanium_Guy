package otherStates;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import levelStates.*;
import flixel.util.FlxColor;
import items.*;
import flixel.FlxSprite;
import flixel.addons.display.FlxBackdrop;

class CreditState extends FlxState
{
    private var _credit:FlxSprite;
    private var _txt:FlxText;
    private var _count:Int = 0;

    override public function create():Void
    {   
        super.create(); 
        _credit = new FlxSprite(0, 0);
        _credit.loadGraphic(AssetPaths.credits__png, false, 800, 10000);
        add(_credit);
        // _txt = new FlxText(230, 500, 500, "CLICK or PRESS ANY KEY to return to MENU", 20);
        // _txt.setFormat(AssetPaths.FONT, _txt.size);
        // add(_txt);
        // add(_credit = new FlxBackdrop(AssetPaths.credits__png, 0, 3, false, true));
		FlxG.sound.playMusic(AssetPaths.introspection__mp3);
    }

    override public function update(elapsed:Float):Void
    {   
        if(_count < 8800) {
            FlxG.camera.scroll.add(0, 2);
            _count += 2;
        }
        if (FlxG.keys.pressed.UP) FlxG.camera.scroll.add(0, -6);
        if (FlxG.keys.pressed.DOWN) FlxG.camera.scroll.add(0, 2);
        if (FlxG.keys.justPressed.ESCAPE) {
            switchMenuState();
        }
        super.update(elapsed);
    }

    private function switchMenuState():Void {
        FlxG.camera.fade(FlxColor.BLACK,.25, false, function() {
            FlxG.switchState(new MenuState());
        });
    }
}