package otherStates;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import levelStates.*;
import flixel.util.FlxColor;
import items.*;
import flixel.FlxSprite;

class CreditState extends FlxState
{
    private var _credit:FlxSprite;
    private var _txt:FlxText;

    override public function create():Void
    {
        _credit = new FlxSprite(0, 0);
        _credit.loadGraphic(AssetPaths.credits__png, false, 800, 600);
        add(_credit);
        _txt = new FlxText(230, 500, 500, "CLICK or PRESS ANY KEY to return to MENU", 20);
        _txt.setFormat(AssetPaths.FONT, _txt.size);
        add(_txt);

		//FlxG.camera.fade(FlxColor.BLACK, .25, true);
        super.create(); 
    }

    override public function update(elapsed:Float):Void
    {
        var click:Bool = false;
        if (FlxG.mouse.justPressed) {
            click = true;
        }
        var press:Bool = false;
        //trace(FlxG.keys.justPressed);
        if (FlxG.keys.justPressed.ANY) {
            press = true;
        }
        if (press || click) {
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