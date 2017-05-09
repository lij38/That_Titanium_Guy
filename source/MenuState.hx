package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.ui.FlxButton;


class MenuState extends FlxState {
	private var _btnPlay:FlxButton;
	
	var spritesheet:FlxSprite;
		
	override public function create():Void {
		_btnPlay = new FlxButton(0, 0, "Play", clickPlay);
		_btnPlay.screenCenter();
		
		spritesheet = new FlxSprite(0, 0);

		spritesheet.loadGraphic(AssetPaths.player__png, true, cast(4745 / 5, Int), cast(11109 / 21, Int));
		spritesheet.animation.add("lr", [2, 3, 4, 5, 6, 7, 8, 9], 12, true);
		//spritesheet.animation.add("stop", [0], 1, false);
		add(spritesheet);
		spritesheet.scale.set(0.25, 0.25);
		spritesheet.setSize(102, 109);
		spritesheet.offset.set(450, 220);

		spritesheet.animation.play("lr");
		
		add(_btnPlay);
		super.create();
	}
	
	override public function update(elapsed:Float):Void {
		super.update(elapsed);
	}
	
	private function clickPlay():Void {
		FlxG.switchState(new TutorialFState());
	}
	
}