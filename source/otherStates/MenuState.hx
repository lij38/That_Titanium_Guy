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
	private var _bg:FlxSprite;
	private var _btnPlay:ImageButton;
	private var _btnContinue:ImageButton;
	private var _title:FlxText;
	private var _subtitle:FlxText;
	private var _btnCredits:ImageButton;
	
	//confirm screen
	private var _cWindow:FlxSprite;
	private var _mask:FlxSprite;
	private var _cButton:ImageButton;
	private var _cancel:ImageButton;
	private var _cText:FlxText;
	
	var spritesheet:FlxSprite;
		
	override public function create():Void {
		// _title = new FlxText(200, 100, 600, "That Titanium Guy", 50);
		// _title.setFormat(AssetPaths.FONT, _title.size);
		// _subtitle = new FlxText(220, 175, 500, "あのチタンな人", 40);
		// _subtitle.setFormat(AssetPaths.FONT, _subtitle.size);

		_bg = new FlxSprite(0, 0).loadGraphic(AssetPaths.menuBG__png);
		_btnPlay = new ImageButton(0, 230, "New Game", clickPlay);
		_btnPlay.loadGraphic(AssetPaths.newgame__png, false, 200, 40);
		_btnContinue = new ImageButton(0, 325, "Continue", clickContinue);
		_btnContinue.loadGraphic(AssetPaths.continue__png, false, 200, 40);
		_btnCredits = new ImageButton(0, 420, clickCredits);
		_btnCredits.loadGraphic(AssetPaths.creditsbtn__png, false, 200, 40);
		
		//_btnContinue.screenCenter();
		 spritesheet = new FlxSprite(0, 0);

		/* spritesheet.loadGraphic(AssetPaths.boss2__png, true, 420, 272);
		 spritesheet.animation.add("lr", [4, 5, 6, 7, 8, 9], 4, true);
		// //spritesheet.animation.add("stop", [0], 1, false);
		 add(spritesheet);
		spritesheet.scale.set(0.8, 0.8);
		 spritesheet.setSize(120, 186);
		//spritesheet.offset.set(60, 20);

		spritesheet.animation.play("lr");*/
		
		//confirm screen
		_cWindow = new FlxSprite(200, 100).makeGraphic(400, 400, FlxColor.BLACK);
		_mask = new FlxSprite(0, 0).makeGraphic(800, 600, FlxColor.BLACK);
		_mask.alpha = 0;
		_cButton = new ImageButton(300, 400, newGame);
		_cButton.loadGraphic(AssetPaths.confirm__png);
		_cancel = new ImageButton(300, 450, killConfirm);
		_cancel.loadGraphic(AssetPaths.cancel__png);
		_cText = new FlxText(200, 100, 400);
		_cText.text = "Starting a New Game will erase your previous progress. \n"
			+ "Are you sure you want to proceed?";
		_cText.setFormat(AssetPaths.FONT, 30);
		_cWindow.kill();
		_cButton.kill();
		_cancel.kill();
		_cText.kill();

		// add(_title);
		// add(_subtitle);
		add(_bg);
		add(_btnPlay);
		add(_btnContinue);
		add(_btnCredits);
		add(_mask);
		add(_cWindow);
		add(_cButton);
		add(_cancel);
		add(_cText);
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
		if(Main.SAVE.data.levelCompleted == null) {
			newGame();
		} else {
			showConfirm();
		}
	}
	
	private function newGame():Void {
		FlxG.camera.fade(FlxColor.BLACK,.25, false, function() {
			Main.SAVE.erase();
			Main.SAVE.bind(Main.LOGGER.getSavedUserId());
			FlxG.switchState(new OpeningState());
		});
	}

	private function showConfirm():Void {
		_mask.alpha = 0.75;
		_btnContinue.kill();
		_btnCredits.kill();
		_btnPlay.kill();
		_cWindow.revive();
		_cButton.revive();
		_cancel.revive();
		_cText.revive();
	}

	private function killConfirm():Void {
		_mask.alpha = 0;
		_btnContinue.revive();
		_btnCredits.revive();
		_btnPlay.revive();
		_cWindow.kill();
		_cButton.kill();
		_cancel.kill();
		_cText.kill();
	}

	private function clickContinue():Void {
		FlxG.camera.fade(FlxColor.BLACK,.25, false, function() {
			if(Main.SAVE.data.levelCompleted == null || Main.SAVE.data.levelCompleted < 1) {
				FlxG.switchState(new OpeningState());
			} else if(Main.SAVE.data.levelCompleted == 1) {
				FlxG.switchState(new Level1State());
			} else {
				//FlxG.switchState(new WorkshopState());
				//FlxG.switchState(new MarketState());
				//FlxG.sound.music.destroy();
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