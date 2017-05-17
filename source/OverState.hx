package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import levelStates.*;
import flixel.util.FlxColor;

class OverState extends FlxState
{
    private var _btnPlay:FlxButton;
    private var _from:Int;
    private var text:FlxText;

    override public function create():Void
    {
        text = new FlxText(0, 0, 0, "GAME OVER", 64);
        text.setFormat(AssetPaths.FONT, text.size);
        text.screenCenter();
        add(text);
        _btnPlay = new FlxButton(390, 400, "Try Again", clickPlay);
        add(_btnPlay);
		
		FlxG.camera.fade(FlxColor.BLACK, .25, true);
        super.create();
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
    }

    private function clickPlay():Void {
		FlxG.camera.fade(FlxColor.BLACK,.25, false, function() {
            if(Main.SAVE.data.tutComplete == false) {
			    FlxG.switchState(new TutorialState());
            } else {
                FlxG.switchState(new HomeState());
            }
		});
	}
}