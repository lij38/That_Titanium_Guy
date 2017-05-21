package otherStates;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import levelStates.*;
import flixel.util.FlxColor;

class OverState extends FlxState
{
    private var _btnPlay:FlxButton;
    private var _btnHome:FlxButton;
    private var _from:Int;
    private var text:FlxText;
    private var _level:Int;

    override public function create():Void
    {
        text = new FlxText(270, 150, 0, "GAME OVER", 64);
        text.setFormat(AssetPaths.FONT, text.size);
        add(text);
        _btnPlay = new FlxButton(370, 250, "Try Again", clickPlay);
        add(_btnPlay);
        _btnHome = new FlxButton(370, 300, "Go Home", clickHome);
        add(_btnHome);
		_level = Main.SAVE.data.curLevel;

		FlxG.camera.fade(FlxColor.BLACK, .25, true);
        super.create(); 
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
    }

    private function clickPlay():Void {
		FlxG.camera.fade(FlxColor.BLACK,.25, false, function() {
            switch _level {
                case 1: FlxG.switchState(new TutorialState());
                case 2: FlxG.switchState(new Level1State());
                case 3: FlxG.switchState(new Boss1State());
            }
		});
	}

    private function clickHome() {
        FlxG.camera.fade(FlxColor.BLACK,.25, false, function() {
            FlxG.switchState(new HomeState());
        });
    }
}