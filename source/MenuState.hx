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
		
		//
		/*spritesheet = new FlxSprite(0, 0);
		spritesheet.loadGraphic(AssetPaths.mainCharacter__png, true, 518, 854);
		spritesheet.animation.add("lr", [1, 2, 3, 4, 5, 6], 6, true);
		spritesheet.animation.add("stop", [0], 1, false);
		add(spritesheet);
		
		spritesheet.scale.set(0.2, 0.2);
		spritesheet.animation.play("lr");
		spritesheet.offset.set(230, 360);
		spritesheet.setSize(60, 100);*/
		
		spritesheet = new FlxSprite(0, 0);
		spritesheet.loadGraphic(AssetPaths.p__png, true, 472, 418);
		spritesheet.animation.add("lr", [0, 1, 2, 3, 4, 5, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 9, true);
		//spritesheet.animation.add("stop", [0], 1, false);
		add(spritesheet);
		spritesheet.scale.set(0.25, 0.25);
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