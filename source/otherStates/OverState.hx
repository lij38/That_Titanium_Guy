package otherStates;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import levelStates.*;
import flixel.util.FlxColor;
import items.*;

class OverState extends FlxState
{
    private var _btnPlay:ImageButton;
    private var _btnHome:ImageButton;
    private var _from:Int;
    private var text:FlxText;
    private var _level:Int;

    override public function create():Void
    {
        text = new FlxText(180, 150, 0, "GAME OVER", 64);
        text.setFormat(AssetPaths.FONT, text.size);
        add(text);
        _btnPlay = new ImageButton(300, 300, "Try Again", clickPlay);
        _btnPlay.loadGraphic(AssetPaths.tryagain__png, false, 200, 40);
        add(_btnPlay);
        _btnHome = new ImageButton(300, 380, "Go Home", clickHome);
        _btnHome.loadGraphic(AssetPaths.gohome__png, false, 200, 40);
        if(Main.SAVE.data.levelCompleted > 1) {
            add(_btnHome);
        }
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
                case 4: FlxG.switchState(new Level2State());
                case 5: FlxG.switchState(new Level3State());
                case 6: FlxG.switchState(new Boss2State());
            }
		});
	}

    private function clickHome() {
        FlxG.camera.fade(FlxColor.BLACK,.25, false, function() {
            FlxG.switchState(new HomeState());
        });
    }
}