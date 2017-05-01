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
		spritesheet.loadGraphic(AssetPaths.v__png, true, 552, 381);
		spritesheet.animation.add("lr", [0, 1, 2, 3, 4, 5, 
										 0, 1, 2, 3, 4, 5, 
										 6, 6, 8, 8, 6, 6, 8, 8, 9, 
										 10, 10, 10, 10, 10], 9, true);
		//spritesheet.animation.add("stop", [0], 1, false);
		add(spritesheet);
		spritesheet.scale.set(0.3, 0.3);
		spritesheet.setSize(102, 109);
		spritesheet.offset.set(50, 50);
		spritesheet.animation.play("lr");
		add(_btnPlay);
		super.create();
	}
	
	override public function update(elapsed:Float):Void {
		super.update(elapsed);
	}
	
	private function clickPlay():Void {
		FlxG.switchState(new PlayState());
	}
	
}