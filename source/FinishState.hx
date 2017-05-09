package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class FinishState extends FlxState
{
	private var _btnPlay:FlxButton;
    override public function create():Void
    {
        var text = new flixel.text.FlxText(140, 50, 0, "Stage Cleared!", 35);
        add(text);
        var rating = new flixel.text.FlxText(140, 150, 0, "Rating: Gold", 25);
        add(rating);
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