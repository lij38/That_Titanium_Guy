package otherStates;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import levelStates.*;
import flixel.util.FlxColor;
class FinishState extends FlxState
{
	private var _btnPlay:FlxButton;
    private var _btnHome:FlxButton;
    private var text:FlxText;
    private var rating:FlxText;
    private var ending:FlxText;
    private var _level:Int;

    override public function create():Void
    {   
        _level = Main.SAVE.data.curLevel;
        text = new FlxText(300, 100, 0, "Stage Cleared!", 35);
        text.setFormat(AssetPaths.FONT, text.size);
        add(text);
        rating = new FlxText(320, 200, 0, "Rating: Gold", 25);
        rating.setFormat(AssetPaths.FONT, rating.size);
        add(rating);
		 _btnPlay = new FlxButton(390, 300, "Next", clickPlay);
        add(_btnPlay);
        _btnHome = new FlxButton(390, 330, "Go Home", clickHome);
        add(_btnHome);
        ending = new FlxText(150, 400, 500, "Thanks for playing! This is only a beta so more levels are coming soon!", 20);
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
			switch _level {
                case 1: FlxG.switchState(new Level1State());
                case 2: FlxG.switchState(new Boss1State());
                case 3: FlxG.switchState(new HomeState());
            }
		});
	}

    private function clickHome():Void {
        FlxG.camera.fade(FlxColor.BLACK,.25, false, function() {
			FlxG.switchState(new HomeState());
		});
    }
}