package animation;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.addons.editors.tiled.TiledMap;
import flixel.tile.FlxTilemap;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.tile.FlxBaseTilemap;
import flixel.addons.editors.tiled.TiledObjectLayer;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import levelStates.*;

class CatchKatyState extends FlxState
{
	private var _player:PlayerAnimation;
	private var _wife:WifeAnimation;
	private var count:Int = 0;
	private var _dialog:Dialog;
	private var _bg:FlxSprite;
	private var _text:FlxText;

	private var _enemy:RifleEnemyAnimation;
	private var _enemy2:MeleeEnemyAnimation;
	private var _enemy3:RifleEnemyAnimation;
	private var _enemy4:RifleEnemyAnimation;
	private var _enemy5:TruckEnemyAnimation;

	private var _helptext:FlxText;
	private var _skiptext:FlxText;
	// an array stores all conversations
	private var _text_array:Array<String>;
	// index of conversation (in text array)
	private var _conv_index:Int;
	// stage 1 is enemy entering the scene to the first sentence of enemy
	private var _stage1:Bool;
	// stage 2 is enemy talks
	private var _stage2:Bool;
	// stage 3 is hypin walks wife and children out of scene
	private var _stage3:Bool;
	// hypin and enemy run towards each others
	private var _stage4:Bool;

	private var begin_walk:Bool;

	override public function create():Void
	{
		// animation stage parameters
		_stage1 = true;
		_stage2 = false;
		_stage3 = false;
		_stage4 = false;
		begin_walk = false;

		_bg = new FlxSprite();
		_bg.loadGraphic(AssetPaths.home__png, false, 1060, 600);

		// initialize with all conversations
		_text_array = new Array<String>();
		_conv_index = 0;
		_text_array.push("J. Katy: !   !   !  ( I need to run. )");
		_text_array.push("J.Katy: >  <  ( Let me go! )");
		_text_array.push("J. Hypin: Where is my wife?");

		_player = new PlayerAnimation(200 - 250,300,0);
		_wife = new WifeAnimation(200, 260, 0);

		_dialog = new Dialog(39, 431);
		_dialog.width = 720;
		_dialog.height = 145;
		_skiptext = new FlxText(FlxG.width / 2 - 120, 20, 250, "Press ESC to skip", 30);
		_skiptext.setFormat(AssetPaths.FONT, _skiptext.size);

		_text = new FlxText(200, 450, 530, 23);
		_text.setFormat(AssetPaths.FONT, _text.size);
		_helptext = new FlxText(300, 540, 300, "Press ENTER to continue", 20);
		_helptext.setFormat(AssetPaths.FONT, _helptext.size);
		_helptext.visible = false;
		_text.width = 300;
		_text.height = 100;
		_enemy = new RifleEnemyAnimation(600 + 100, 280, 0);
		_enemy2 = new MeleeEnemyAnimation(688 + 100, 340, 0);
		_enemy3 = new RifleEnemyAnimation(748 + 100, 280, 0);
		_enemy4 = new RifleEnemyAnimation(688 + 100, 240, 0);
		_enemy5 = new TruckEnemyAnimation(688 + 100, 280, 0);

		 add(_bg);
		 add(_player);
		 
		 
		 
		 add(_enemy4);
		 add(_wife);

		 add(_enemy);
		 add(_enemy3);
		 add(_enemy2);

		 add(_dialog);
		 add(_text);
		 add(_helptext);
		 add(_skiptext);

		FlxG.camera.fade(FlxColor.BLACK, .25, true);

		FlxG.sound.playMusic(AssetPaths.dramatic__mp3);

		super.create();
		
	}

	override public function update(elapsed:Float):Void {
		
		if(FlxG.keys.anyJustPressed([ESCAPE])) {
			//FlxG.switchState(new TutorialState());
		}

		// stage1 is enemy enter from the right side of screen
		if (_stage1) {
			count++;
		    if(count > 10 && count < 100 && count % 3 == 0) {
		     	// enemy enter from the right side of screen
		     	_enemy.animation.play("lr");
		     	_enemy.x -= 8;
		     	_enemy2.animation.play("lr");
		     	_enemy2.x -= 8;
		     	_enemy3.animation.play("lr");
		     	_enemy3.x -= 8;
		     	_enemy4.animation.play("lr");
		     	_enemy4.x -= 8;
		     } else if (count == 105) {
		     	_enemy.animation.play("stop");
		     	_enemy2.animation.play("stop");
		     	_enemy3.animation.play("stop");
		     	_enemy4.animation.play("stop");
		     } else if (count == 120) {
		     	// katy appears shocked
		     	_dialog.dialog3();
		     	_text.text = _text_array[0];
		     	_text.visible = true;
		     	_helptext.visible = true;
		     } else if (count > 120) {
		     	// when enemy talk ends, switch to next scene
		     	// enemy has two sentences to talk
			    var space:Bool = FlxG.keys.anyJustPressed([ENTER]);
		 		if (space) {	
	 				_stage1 = false;
	 				_stage2 = true;
	 				count = 0;
	 				_dialog.visible = false;
	 				_helptext.visible = false;
	 				_text.visible = false;
		 		}
		     }

		 // stage2: katy begins to run and catched
	 	} else if (_stage2) {
	 		count++;
	 		if (count == 15) {
	 			_wife.facing = FlxObject.LEFT;
		 	} else if (count > 15 && count < 135 && count % 3 == 0) {
		 		_enemy.animation.play("lr");
		     	_enemy.x -= 8;
		     	_enemy2.animation.play("lr");
		     	_enemy2.x -= 8;
		     	_enemy3.animation.play("lr");
		     	_enemy3.x -= 8;
		     	_enemy4.animation.play("lr");
		     	_enemy4.x -= 8;

		     	_wife.animation.play("lr");
		     	_wife.x -= 3;
		 	} else if (count == 135) {
		 		_wife.animation.play("hurt");
		 		// captured
		 	} else if (count == 145) {
		 		_enemy.animation.play("stop");
		     	_enemy2.animation.play("stop");
		     	_enemy3.animation.play("stop");
		     	_enemy4.animation.play("stop");

		     	_wife.x += 4;
		 	} else if (count > 145 && count < 300 && count % 3 == 0) {
		 		_wife.x += 2;
		 	} else if (count > 315) {
		 		_stage2 = false;
		 		_stage3 = true;
		 		count = 0;
		 	}
	 	
	 	// katy brought away
	 	} else if (_stage3) {
	 		count++;
	 		if (!begin_walk) {
		 		if (count == 10) {
			     	// katy appears shocked
			     	_dialog.dialog3();
			     	_conv_index += 1;
			     	_text.text = _text_array[_conv_index];
			     	_dialog.visible = true;
			     	_text.visible = true;
			     	_helptext.visible = true;
			     } else if (count > 10) {
			     	var space:Bool = FlxG.keys.anyJustPressed([ENTER]);
			 		if (space) {	
		 				begin_walk = true;
		 				count = 0;
		 				_dialog.visible = false;
		 				_helptext.visible = false;
		 				_text.visible = false;
			 		}
			     }
			 } else {
			 	if (count == 10) {
			 		_wife.facing = FlxObject.RIGHT;
			 		_enemy.facing = FlxObject.RIGHT;
			 		_enemy2.facing = FlxObject.RIGHT;
			 		_enemy3.facing = FlxObject.RIGHT;
			 		_enemy4.facing = FlxObject.RIGHT;
				 } else if (count > 10 && count < 400 && count % 3 == 0) {
				 	_enemy.animation.play("lr");
		     		_enemy.x += 8;
		     		_enemy2.animation.play("lr");
		     		_enemy2.x += 8;
		     		_enemy3.animation.play("lr");
		     		_enemy3.x += 8;
		     		_enemy4.animation.play("lr");
		     		_enemy4.x += 8;
		     		_wife.x += 8;
				 } else if (count > 400) {
				 	_stage3 = false;
				 	_stage4 = true;
				 	count = 0;
				 }
			 }

		// hypin comes in
	 	} else if (_stage4) {
	 		count ++;
	 		if (count > 10 && count < 250 && count % 3 == 0) {
				 	_player.animation.play("Run");
		     		_player.x += 4;
			} else if (count == 250) {
				_player.animation.play("Stop");
			} else if (count == 260) {
				_conv_index += 1;
		     	_text.text = _text_array[_conv_index];
		     	_dialog.dialog1();
		     	_dialog.visible = true;
		     	_text.visible = true;
		     	_helptext.visible = true;
			} else if (count > 260) {
				var space:Bool = FlxG.keys.anyJustPressed([ENTER]);
		 		if (space) {	
	 				//switch state????
	 			}			 	
			}
	 	}

		super.update(elapsed);
	}
}