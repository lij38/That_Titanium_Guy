package otherStates;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.ui.FlxButton;
import animation.*;
import levelStates.*;
import items.*;
import flixel.util.FlxColor;
import flixel.util.FlxSave;
import flixel.text.FlxText;

class MenuState extends FlxState {
	private var _btnPlay:ImageButton;
	private var _btnContinue:ImageButton;
	private var _title:FlxText;
	private var _subtitle:FlxText;
	
	var spritesheet:FlxSprite;
		
	override public function create():Void {
		_title = new FlxText(200, 100, 600, "That Titanium Guy", 50);
		_title.setFormat(AssetPaths.FONT, _title.size);
		_subtitle = new FlxText(220, 175, 500, "あのチタンな人", 40);
		_subtitle.setFormat(AssetPaths.FONT, _subtitle.size);
		_btnPlay = new ImageButton(300, 300, "New Game", clickPlay);
		_btnPlay.loadGraphic(AssetPaths.newgame__png, false, 200, 40);
		_btnContinue = new ImageButton(300, 380, "Continue", clickContinue);
		_btnContinue.loadGraphic(AssetPaths.continue__png, false, 200, 40);
		//_btnContinue.screenCenter();
		// spritesheet = new FlxSprite(0, 0);

		// spritesheet.loadGraphic(AssetPaths.abc__png, true, cast(5035 / 5, Int), cast(3510 / 5, Int));
		// spritesheet.animation.add("lr", [0, 0, 0, 0, 20, 20, 20, 20,
		// 								 0, 0, 0, 0, 20, 20, 20, 20,
		// 								 1, 2, 3, 4, 4, 5, 5, 6, 6, 7, 7, 7, 7, 7, 
		// 								 8, 9, 10, 11, 12, 13, 14,
		// 								 15, 16, 16, 17, 18, 18, 19, 19, 19, 19,
		// 								 18, 18, 19, 19, 19, 19, 19,
		// 								 20, 20, 21, 21, 22, 22, 22, 22, 22, 22], 12, true);
		// //spritesheet.animation.add("stop", [0], 1, false);
		// add(spritesheet);
		// spritesheet.scale.set(0.25, 0.25);
		// spritesheet.setSize(102, 109);
		// spritesheet.offset.set(250, 250);

		// spritesheet.animation.play("lr");
		
		add(_title);
		add(_subtitle);
		add(_btnPlay);
		add(_btnContinue);
		FlxG.camera.fade(FlxColor.BLACK, .33, true);
		super.create();
	}
	
	override public function update(elapsed:Float):Void {
		super.update(elapsed);
	}
	
	private function clickPlay():Void {
		FlxG.camera.fade(FlxColor.BLACK,.25, false, function() {
			Main.SAVE.erase();
			Main.SAVE.bind(Main.LOGGER.getSavedUserId());
			FlxG.switchState(new HomeState());
			//FlxG.switchState(new TutorialState());
			//FlxG.switchState(new Boss1State());
		});
	}
	
	private function clickContinue():Void {
		FlxG.camera.fade(FlxColor.BLACK,.25, false, function() {
			if(Main.SAVE.data.tutComplete == null || Main.SAVE.data.tutComplete == false) {
				FlxG.switchState(new OpeningState());
			} else {
				//TODO: switch to homeState
				FlxG.switchState(new HomeState());
			}
		});
	}
}