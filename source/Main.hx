package;

import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite {
	//public static var LOGGER:CapstoneLogger;

	public function new() {
		super();

		// var gameId:Int = 1704;
		// var gameKey:String = "d4e860f67de231c35cf54c2e3f27e466";
		// var gameName:String = "fullmecha";
		// var categoryId:Int = 1;
		// Main.LOGGER = new CapstoneLogger(gameId, gameName, gameKey, categoryId, 1, true);
		
		// // Retrieve the user (saved in local storage for later)
		// var userId:String = Main.LOGGER.getSavedUserId();
		// if (userId == null)
		// {
		// 	userId = Main.LOGGER.generateUuid();
		// 	Main.LOGGER.setSavedUserId(userId);
		// }
		// Main.LOGGER.startNewSession(userId, this.onSessionReady);

		addChild(new FlxGame(550, 400, MenuState));
	}
}
