package;

import flixel.FlxGame;
import openfl.display.Sprite;
import flixel.util.FlxSave;
import levelStates.*;
import otherStates.*;

class Main extends Sprite {
	public static var LOGGER:CapstoneLogger;
	public static var SAVE:FlxSave;

	public function new() {
		super();

		var gameId:Int = 1704;
		var gameKey:String = "d4e860f67de231c35cf54c2e3f27e466";
		var gameName:String = "fullmecha";
		var categoryId:Int = 4;
		Main.LOGGER = new CapstoneLogger(gameId, gameName, gameKey, categoryId, 1, false);
		
		//Retrieve the user (saved in local storage for later)
		var userId:String = Main.LOGGER.getSavedUserId();
		if (userId == null)
		{
			userId = Main.LOGGER.generateUuid();
			Main.LOGGER.setSavedUserId(userId);
		}
		Main.SAVE = new FlxSave();
		Main.SAVE.bind(userId);	
		Main.LOGGER.startNewSession(userId, this.onSessionReady);	
	}
	
	public function onSessionReady(b:Bool):Void {
		addChild(new FlxGame(800, 600, MenuState));
	}
}