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

class OpeningState extends FlxState
{
	private var _player:PlayerAnimation;
	private var _wife:WifeAnimation;
	private var count:Int = 0;
	private var _dialog:Dialog;
	private var _bg:FlxSprite;
	private var _text:FlxText;
	private var _enemy:RifleEnemyAnimation;
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
		_text_array.push("Federal Army Soldiers: This land is now confiscated under the authority of the Federal Government for our Supreme Leader");
		_text_array.push("FA Soldiers: You have 24 hours to vacate the premises. Failure to do so will result in the use of deadly forces.");
		_text_array.push("J. Hypin: Grab our stuff and wait for me outside!");
		_text_array.push("Katy Hypin: Ok. Be safe!.");
		_text_array.push("J. Hypin: You can’t just take my land from me and my family! We have rights to this land and we will defend our rights!");
		_text_array.push("FA Soldiers: Resistance detected, deadly force is now authorized.");

		_player = new PlayerAnimation(200,300,0);
		_wife = new WifeAnimation(100, 260, 0);

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
		_enemy = new RifleEnemyAnimation(688, 280, 0);

		 add(_bg);
		 add(_player);
		 add(_wife);
		 add(_dialog);
		 add(_text);
		 add(_enemy);
		 add(_helptext);
		 add(_skiptext);

		FlxG.camera.fade(FlxColor.BLACK, .25, true);

		FlxG.sound.playMusic(AssetPaths.dramatic__mp3);

		super.create();
		
	}

	override public function update(elapsed:Float):Void {
		
		if(FlxG.keys.anyJustPressed([ESCAPE])) {
			FlxG.switchState(new TutorialState());
		}

		// stage1 is enemy enter from the right side of screen and begins to talk a bit
		if (_stage1) {
			count++;
		    if(count > 10 && count < 100 && count % 3 == 0) {
		     	// enemy enter from the right side of screen
		     	_enemy.animation.play("lr");
		     	_enemy.x -= 4;
		     } else if (count == 105) {
		     	_enemy.animation.play("stop");
		     } else if (count == 120) {
		     	// enemy begins to talk
		     	_dialog.dialog2();
		     	_text.text = _text_array[0];
		     	_text.visible = true;
		     	_helptext.visible = true;
		     } else if (count > 120) {
		     	// when enemy talk ends, switch to next scene
		     	// enemy has two sentences to talk
			    var space:Bool = FlxG.keys.anyJustPressed([ENTER]);
		 		if (space) {
		 			if (_conv_index == 1) {
		 				_dialog.visible = false;
	 					_text.visible = false;
	 					_helptext.visible = false;
		 				_stage1 = false;
		 				_stage2 = true;
		 				count = 0;
		 			} else {
			 			_conv_index += 1;
			 			_text.text = _text_array[_conv_index];
		 			}
		 		}
		     }

		 // stage2 is hypin escort wife out of the screen and then walks towards enemy
	 	} else if (_stage2) {
	 		// this is hypin and wife talks
	 		count++;
	 		// hypin and wife talks
	 		if (!begin_walk) {
		 		if (count == 15) {
		 			// hypin talks to wife
		 			_player.facing = FlxObject.LEFT;
		 			_conv_index += 1;
			 		_text.text = _text_array[_conv_index];
			 		_text.visible = true;
			 		_helptext.visible = true;
			 		_dialog.dialog1();
			 		_dialog.visible = true;
		 		} else if (count > 15) {
		 			// wife response
		 			var space:Bool = FlxG.keys.anyJustPressed([ENTER]);
			 		if (space) {
			 			if (_conv_index == 3) {
			 				// if talk ends, end stage3, begin stage4
			 				begin_walk = true;
				 			count = 0;
			 			} else {
			 				// wife talks, one sentence
				 			_conv_index += 1;
				 			_dialog.dialog3();
				    		_text.text = _text_array[_conv_index];
			    		}
			 		}
		 		} 

		 	// conversation ends, they begin to move to the left screen
		 	} else {
		 		if (count == 10) {
		 			_dialog.visible = false;
		 			_text.visible = false;
		 			_helptext.visible = false;
		 			_wife.facing = FlxObject.LEFT;
		 		// hypin and katy walks...
		 		} else if (count > 20 && count < 120 && count % 3 == 0) {
		 			_player.animation.play("Run");
		 			_wife.animation.play("lr");
		 			_player.x -= 4;
		 			_wife.x -= 4;
		 		// katy continue walks, hypin stops
		 		} else if (count == 120) {
		 			_player.animation.play("Stop");
		 			//_player.facing = FlxObject.RIGHT;
		 		} else if (count > 120 && count < 240 && count % 3 == 0) {
		 			_wife.animation.play("lr");
		 			_wife.x -= 4;
		 		} else if (count == 240) {
		 			_player.facing = FlxObject.RIGHT;
		 		} else if (count > 280 && count < 400 && count % 3 == 0) {
		 			_player.animation.play("Run");
		 			_player.x += 4; 	
		 		} else if (count > 400) {
		 			_player.animation.play("Stop");
		 			_stage2 = false;
		 			_stage3 = true;
		 			count = 0;
		 		}
	 		}

	 	// hypin begins to talk to enemy
		 }	else if (_stage3) {
		 	count ++;
		    if (count == 10) {
		    	// hypin begins to talk
		    	_dialog.dialog1();
		    	_conv_index += 1;
		    	_text.text = _text_array[_conv_index];
		    	_dialog.visible = true;
		    	_text.visible = true;	    	
		    } else if (count > 10) {
		    	// enemy and hypin talks
		    	var space:Bool = FlxG.keys.anyJustPressed([ENTER]);
		 		if (space) {
		 			if (_conv_index == 5) {
		 				// if talk ends, end stage3, begin stage4
		 				_stage3 = false;
			 			_stage4 = true;
			 			count = 0;
		 			} else {
			 			_conv_index += 1;
			 			_dialog.dialog2();
			    		_text.text = _text_array[_conv_index];
		    		}
		 		}
		    }

		// conversation ends, hypin and enmy walks towards each other
	 	} else if (_stage4) {
	 		count++;
	 		if (count == 10) {
	 			_dialog.visible = false;
	 			_text.visible = false;
	 		} else if (count > 10 && count < 100 && count % 3 ==0) {
	 			// hypin and enemy walks towards each other
	 			_player.animation.play("Run");
		     	_player.x += 4;
		     	_enemy.animation.play("lr");
		     	_enemy.x -= 4;
		    } else if (count > 100) {
				FlxG.camera.fade(FlxColor.BLACK,.25, false, function() {
					FlxG.switchState(new TutorialState());
				});
			}
	 	}

		super.update(elapsed);
	}
}