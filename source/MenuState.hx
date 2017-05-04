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

		//spritesheet = new FlxSprite(0, 0);
		//spritesheet.loadGraphic(AssetPaths.x__png, true, 806, 458);
		//spritesheet.animation.add("lr", [0, 1, 2, 3, 6, 7, 7, 4, 5, 5, 6, 
										 //7, 7, 7, 8, 8], 12, true);
		//add(spritesheet);
		//spritesheet.scale.set(0.3, 0.3);
		//spritesheet.setSize(102, 109);
		//spritesheet.offset.set(50, 50);
		//spritesheet.animation.play("lr");
		
		spritesheet = new FlxSprite(0, 0);
		spritesheet.loadGraphic(AssetPaths.b__png, true, 273, 148);
		spritesheet.animation.add("lr", [2, 3, 4, 5, 6, 7, 8, 9], 12 , true);
		add(spritesheet);
		spritesheet.offset.set(110, 30);
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