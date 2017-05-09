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

class OpeningState extends FlxState
{
	private var _map:TiledMap;
	private var _bg:FlxTilemap;
	private var _platform:FlxObject;
	private var _player:PlayerAnimation;
	private var count:Int;
	private var _dialog:Dialog;
	private var _text:FlxText;
	private var _enemy:RifleEnemyAnimation;
	private var _helptext:FlxText;
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

	override public function create():Void
	{
		// animation stage parameters
		_stage1 = true;
		_stage2 = false;
		_stage3 = false;
		_stage4 = false;

		FlxG.camera.x = 0;
		FlxG.camera.y = 0;

		// load map and set a platform that player can stand on (row 17th)
		_map = new TiledMap(Path.BGTMX);
		_bg = new FlxTilemap();
		_bg.loadMapFromArray(cast(_map.getLayer("map1"), TiledTileLayer).tileArray, _map.width, _map.height, 
			Path.BG, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 1, 1, 3);
		add(_bg);
		_bg.follow();
		for (j in 0...25){
			for (i in 0...44){
				_bg.setTileProperties(i + j*44 + 1, FlxObject.NONE);
			}
		}
		for (i in 0...44){
			_bg.setTileProperties(i + 17*44 + 1, FlxObject.ANY);
		}

		_bg.x = 0;
		_bg.y = 0;

		// initialize with all conversations
		_text_array = new Array<String>();
		_conv_index = 0;
		_text_array.push("Federal Union Army Soldiers: This land is now confiscated under the authority of the Federal Union " + 
			"Government to use as an outpost in our war against the Rebel Army.");
		_text_array.push("FUA Soldiers: You have 24 hours to vacate the premises. Failure to do so will result in the use of deadly forces.");
		_text_array.push("Hypin: WHAT?! You can’t just take my land from me and my family! We have rights to this land and I will defend my rights!");
		_text_array.push("FUA Soldiers: Resistance detected, deadly force is now authorized.");

		_player = new PlayerAnimation(0,0, 1000);
		_dialog = new Dialog();
		_dialog.width = 500;
		_dialog.height = 120;
		_text = new FlxText(0, 0, 300, 12);
		_helptext = new FlxText(0, 0, 300, "Press space bar to continue", 12);
		_helptext.visible = false;
		_text.width = 300;
		_text.height = 100;
		_enemy = new RifleEnemyAnimation(0, 0, 0);
		var tmpMap:TiledObjectLayer = cast _map.getLayer("entities");
		 for (e in tmpMap.objects)
		 {
		     placeEntities(e.type, e.xmlData.x);
		 }
		 add(_player);
		 add(_dialog);
		 add(_text);
		 add(_enemy);
		 add(_helptext);

		super.create();
		
	}

	override public function update(elapsed:Float):Void
	{
		FlxG.collide(_player, _bg);

		if (_stage1) {
			count++;
		    if(count > 10 && count < 100 && count % 3 == 0) {
		     	//_player.animation.play("lr");
		     	//_player.x += 4;
		     	// enemy enter from the right side of screen
		     	_enemy.animation.play("lr");
		     	_enemy.x -= 4;
		     } else if (count == 105) {
		     	_enemy.animation.play("stop");
		     } else if (count == 120) {
		     	// enemy begins to talk, stage1 ends, stage2 starts
		     	_dialog.dialog2();
		     	_text.text = _text_array[0];
		     	_text.visible = true;
		     	_helptext.visible = true;
		     	_stage1 = false;
		     	_stage2 = true;
		     	count = 0;
		     }
	 	} else if (_stage2) {
	 		var space:Bool = FlxG.keys.anyJustPressed([SPACE]);
	 		if (space) {
	 			if (_conv_index == 1) {
	 				// after enemy talk ends, end stage2, begin stage3
	 				_stage2 = false;
	 				_stage3 = true;
	 			} else {
		 			_conv_index += 1;
		 			_text.text = _text_array[_conv_index];
	 			}
	 		}
	 	} else if (_stage3) {
	 		count++;
	 		if (count == 10) {
	 			_dialog.visible = false;
	 			_text.visible = false;
	 			_helptext.visible = false;
	 		} else if (count > 10 && count < 100 && count % 3 ==0) {
	 			// hypin escore wife and children out of scene
	 			_player.animation.play("Run");
		     	_player.x += 4;
	 		} else if (count == 105) {
		     	_enemy.animation.play("Stop");
		    } else if (count == 120) {
		    	// hypin begins to talk
		    	_dialog.dialog1();
		    	_conv_index += 1;
		    	_text.text = _text_array[_conv_index];
		    	_dialog.visible = true;
		    	_text.visible = true;	    	
		    } else if (count > 120) {
		    	// enemy and hypin talks
		    	var space:Bool = FlxG.keys.anyJustPressed([SPACE]);
		 		if (space) {
		 			if (_conv_index == 3) {
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
	 	} else if (_stage4) {
	 		count++;
	 		if (count == 10) {
	 			_dialog.visible = false;
	 			_text.visible = false;
	 		} else if (count > 10 && count < 100 && count % 3 ==0) {
	 			// hypin escore wife and children out of scene
	 			_player.animation.play("Run");
		     	_player.x += 4;
		     	_enemy.animation.play("lr");
		     	_enemy.x -= 4;
		    } else if (count > 100) {
				FlxG.switchState(new TutorialState());
			}
	 	}

		super.update(elapsed);
	}

	private function placeEntities(entityName:String, entityData:Xml):Void
	{
	    var x:Int = Std.parseInt(entityData.get("x"));
	    var y:Int = Std.parseInt(entityData.get("y"));
	    //var width:Int = Std.parseInt(entityData.get("width"));
	    //var height:Int = Std.parseInt(entityData.get("height"));
	    if (entityName == "player")
	    {
	        _player.x = x;
	        _player.y = y;
		} else if (entityName == "dialog") {
		 	_dialog.x = x;
	        _dialog.y = y;
		} else if (entityName == "text") {
			_text.x = x;
			_text.y = y;
		} else if (entityName == "enemy") {
			_enemy.x = x;
			_enemy.y = y;
		} else if (entityName == "helptext") {
			_helptext.x = x;
			_helptext.y = y;
		}
	}
}