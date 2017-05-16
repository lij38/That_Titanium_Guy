package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import levelStates.*;
import flixel.util.FlxColor;
class FinishState extends FlxState
{
	private var _btnPlay:FlxButton;
    private var text:FlxText;
    private var rating:FlxText;
    private var ending:FlxText;

    override public function create():Void
    {
        text = new FlxText(300, 100, 0, "Stage Cleared!", 35);
        text.setFormat(AssetPaths.FONT, text.size);
        add(text);
        rating = new FlxText(320, 200, 0, "Rating: Gold", 25);
        rating.setFormat(AssetPaths.FONT, rating.size);
        add(rating);
		 _btnPlay = new FlxButton(0, 0, "Next", clickPlay);
		_btnPlay.screenCenter();
        add(_btnPlay);
        ending = new FlxText(250, 400, 500, "Thanks for playing! This is only a beta so more levels are coming soon!");
        ending.setFormat(AssetPaths.FONT, ending.size);
        if(Main.SAVE.data.end != null) {
            add(ending);
        }
		
		FlxG.camera.fade(FlxColor.BLACK, .25, true);
        super.create();
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
    }
	
	private function clickPlay():Void {
		FlxG.camera.fade(FlxColor.BLACK,.25, false, function() {
			FlxG.switchState(new HomeState());
		});
	}
}