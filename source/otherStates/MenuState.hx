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
	private var _btnCredits:ImageButton;
	
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
		_btnCredits = new ImageButton(300, 460, clickCredits);
		_btnCredits.loadGraphic(AssetPaths.creditsbtn__png, false, 200, 40);
		add(_btnCredits);
		//_btnContinue.screenCenter();
		// spritesheet = new FlxSprite(0, 0);

		// spritesheet.loadGraphic(AssetPaths.player__png, true, 334, 182);
		// spritesheet.animation.add("lr", [2, 3, 4, 5, 6, 7,8,9], 12, true);
		// //spritesheet.animation.add("stop", [0], 1, false);
		// add(spritesheet);
		// //spritesheet.scale.set(0.25, 0.25);
		// spritesheet.setSize(48, 115);
		// spritesheet.offset.set(120, 30);

		// spritesheet.animation.play("lr");
		
		add(_title);
		add(_subtitle);
		add(_btnPlay);
		add(_btnContinue);
		FlxG.camera.fade(FlxColor.BLACK, .33, true);
		FlxG.sound.playMusic(AssetPaths.theme__mp3);
		super.create();
	}
	
	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		if(FlxG.keys.anyPressed([ENTER])) {
			clickContinue();
		}
	}
	
	private function clickPlay():Void {
		FlxG.camera.fade(FlxColor.BLACK,.25, false, function() {
			Main.SAVE.erase();
			Main.SAVE.bind(Main.LOGGER.getSavedUserId());

			//FlxG.switchState(nullew HomeState());
			//FlxG.switchState(new TutorialState());
			//FlxG.switchState(new Boss1State());
			FlxG.switchState(new OpeningState());
		});
	}
	
	private function clickContinue():Void {
		FlxG.camera.fade(FlxColor.BLACK,.25, false, function() {
			if(Main.SAVE.data.levelCompleted == null || Main.SAVE.data.levelCompleted < 1) {
				FlxG.switchState(new OpeningState());
			} else if(Main.SAVE.data.levelCompleted == 1) {
				FlxG.switchState(new Level1State());
			} else {
				//FlxG.switchState(new WorkshopState());
				FlxG.sound.music.destroy();
				FlxG.switchState(new HomeState());
			}
		});
	}

	private function clickCredits():Void {
		FlxG.camera.fade(FlxColor.BLACK,.25, false, function() {
			FlxG.switchState(new CreditState());
		});
	}
}