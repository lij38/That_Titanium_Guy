package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.ui.FlxButton;
import animation.*;

class MenuState extends FlxState {
	private var _btnPlay:FlxButton;
	
	var spritesheet:FlxSprite;
		
	override public function create():Void {
		_btnPlay = new FlxButton(0, 0, "Play", clickPlay);
		_btnPlay.screenCenter();
		
		spritesheet = new FlxSprite(0, 0);

		spritesheet.loadGraphic(AssetPaths.abc__png, true, cast(5035 / 5, Int), cast(3510 / 5, Int));
		spritesheet.animation.add("lr", [0, 0, 0, 0, 20, 20, 20, 20,
										 0, 0, 0, 0, 20, 20, 20, 20,
										 1, 2, 3, 4, 4, 5, 5, 6, 6, 7, 7, 7, 7, 7, 
										 8, 9, 10, 11, 12, 13, 14,
										 15, 16, 16, 17, 18, 18, 19, 19, 19, 19,
										 18, 18, 19, 19, 19, 19, 19,
										 20, 20, 21, 21, 22, 22, 22, 22, 22, 22], 12, true);
		//spritesheet.animation.add("stop", [0], 1, false);
		add(spritesheet);
		spritesheet.scale.set(0.25, 0.25);
		spritesheet.setSize(102, 109);
		spritesheet.offset.set(250, 250);

		spritesheet.animation.play("lr");
		
		add(_btnPlay);
		super.create();
	}
	
	override public function update(elapsed:Float):Void {
		super.update(elapsed);
	}
	
	private function clickPlay():Void {
		FlxG.switchState(new OpeningState());
	}
	
}