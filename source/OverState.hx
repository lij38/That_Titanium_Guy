package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class OverState extends FlxState
{
    private var _btnPlay:FlxButton;
    override public function create():Void
    {
        var text = new flixel.text.FlxText(0, 0, 0, "GAME OVER", 64);
        text.screenCenter();
        add(text);
        _btnPlay = new FlxButton(0, 0, "Play", clickPlay);
		_btnPlay.screenCenter();
        add(_btnPlay);
        super.create();
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
    }

    private function clickPlay():Void {
		FlxG.switchState(new TutorialState());
	}
}