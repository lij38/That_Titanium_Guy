package otherStates;

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
import weapons.*;
import flixel.ui.FlxButton;
import items.*;

class HomeState extends FlxState
{
	private var _map:TiledMap;
	private var _bg:FlxTilemap;
	private var _fg:FlxTilemap;
	private var _player:Player;
	private var playerBullets:FlxTypedGroup<Bullet>;
	private var tutorial_map:Bool;
	private var _mapbutton:ImageButton;
	private var _arrow:Arrow;
	private var _text:FlxText;
	private var tutState:Bool;
	private var _workshop:FlxSprite;
	private var _maptext:FlxText;
	private var _workshoptext:FlxText;
	private var _stage1:Bool;
	private var _stage2:Bool;
	private var _stage3:Bool;

	override public function create():Void
	{

		// load map and set a platform that player can stand on (row 17th)
		_map = new TiledMap(AssetPaths.home__tmx);
		_bg = new FlxTilemap();
		_bg.loadMapFromArray(cast(_map.getLayer("map1"), TiledTileLayer).tileArray, _map.width, _map.height, 
			AssetPaths.home__png, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 1, 1, 391);
		add(_bg);
		_bg.follow();

		_fg = new FlxTilemap();
		_fg.loadMapFromArray(cast(_map.getLayer("foreground"), TiledTileLayer).tileArray, _map.width, _map.height, 
			AssetPaths.home__png, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 1, 1, 1);
		add(_fg);
		_fg.follow();

		playerBullets = new FlxTypedGroup<Bullet>();
		_player = new Player(playerBullets, 1000);

		_workshop = new FlxSprite();
		_workshop.loadGraphic(AssetPaths.workshop__png, false, 350, 290);
		add(_workshop);
		_workshop.color = 0xdddddd;

		_maptext = new FlxText(0, 0, 200, 20);
        _maptext.text = "CLICK or PRESS M to open map";
        _maptext.setFormat(AssetPaths.FONT, 20);
        _maptext.scrollFactor.set(0.0);
        _maptext.visible = false;
        add(_maptext);

        _workshoptext = new FlxText(0, 0, 500, 24);
        _workshoptext.text = "PRESS W to enter workshop";
        _workshoptext.setFormat(AssetPaths.FONT, 24);
        _workshoptext.visible = false;
        add(_workshoptext);

		var tmpMap:TiledObjectLayer = cast _map.getLayer("entities");
		 for (e in tmpMap.objects)
		 {
		     placeEntities(e.type, e.xmlData.x);
		 }
		 add(_player);

		 _mapbutton = new ImageButton(31, 26, switchMapState);
		 _mapbutton.scrollFactor.set(0.0);
		 _mapbutton.loadGraphic(AssetPaths.map_icon__png, false, 70, 70);
		 add(_mapbutton);

		 if(Main.SAVE.data.homeTut == null ||Main.SAVE.data.homeTut == false) {
			 tutorial_map = true;
			 tutState = true;
			 _stage1 = true;
			 _stage2 = false;
			 _stage3 = false;
			 _mapbutton.active = false;
			 Main.SAVE.data.homeTut = true;
			 Main.SAVE.flush();
		 } else {
			 tutorial_map = false;
			 tutState = false;
		 }

		 if (tutorial_map) {
		 	_fg.color = 0x777777;
		 	_bg.color = 0x777777;
		 	_player.color = 0x777777;
		 	_workshop.color = 0x777777;
		 	_arrow = new Arrow();
			 _arrow.x = 120;
			 _arrow.y = 50;
			 add(_arrow);
			 _arrow.visible = false;
			 _text = new FlxText(0, 0, 330, 20);
			 _text.x = 450;
			 _text.y = 36;
        	_text.text = "This is your home! You can move and try your weapons. (Click Anywhere to continue)";
        	_text.setFormat(AssetPaths.FONT, 20);
        	add(_text);
		 }

		 FlxG.camera.follow(_player, LOCKON, 1);
		 
		 //trace(FlxG.sound.music);
		 if(FlxG.sound.music.playing == false) {
		 	FlxG.sound.playMusic(AssetPaths.dramatic__mp3);
		 }

		 super.create();
		
	}

	override public function update(elapsed:Float):Void
	{
		if (!tutorial_map) {
			if (FlxG.keys.anyPressed([M])) {
				switchMapState();
			}
			checkEnter(_player, _workshop);
		}
		FlxG.collide(_player, _fg);
		if (tutorial_map) {
			var click:Bool = false;
	        if (FlxG.mouse.justPressed) {
	            click = true;
	        }
			
			if (_stage1) {
				if (click) {
					_stage1 = false;
					_stage2 = true;
					_arrow.visible = true;
					_text.x = 175;
		 			_text.y = 35;
    				_text.text = "This is the map, you can click here to go back to the map and challenge new levels. (Click Anywhere to continue)";
				}
			} else if (_stage2) {
				if (click) {
					_stage2 = false;
					_stage3 = true;
					_arrow.x = 295;
					_arrow.y = 350;
					_arrow.loadGraphic(AssetPaths.arrow2__png, false, 25, 40);
					_text.x = 177;
					_text.y = 415;
					_text.text = "This is the workshop, you can equip and change your weapon configurations here!";
				}
			} else if (_stage3) {
				if (click) {
					_stage3 = false;
					tutorial_map = false;
		        	_arrow.visible = false;
		        	_text.visible = false;
		        	_bg.color = 0xffffff;
		        	_player.color = 0xffffff;
		        	_fg.color = 0xffffff;
		        	_workshop.color = 0xdddddd;
		        	_mapbutton.active = true;
					_maptext.visible = true;
	        	}
			}
        	
		} else {
			_maptext.visible = true;
		}
		
		FlxG.collide(_player, _bg);
		super.update(elapsed);
	}

	private function checkEnter(player:Player, workshop:FlxSprite) {
		if (player.x + player.width >= workshop.x && player.x <= workshop.x + workshop.width) {
			_workshop.color = 0xffffff;
			_workshoptext.visible = true;
			if (FlxG.keys.anyJustPressed([W])) {
				switchWorkshopState();
			}
		} else {
			_workshop.color = 0xdddddd;
			_workshoptext.visible = false;
		}
	}

	private function placeEntities(entityName:String, entityData:Xml):Void
	{
	    var x:Int = Std.parseInt(entityData.get("x"));
	    var y:Int = Std.parseInt(entityData.get("y"));

	    if (entityName == "player")
	    {
	        _player.x = x;
	        _player.y = y;
		} else if (entityName == "workshop") {
			_workshop.x = x;
			_workshop.y = y;
		} else if (entityName == "maptxt") {
			_maptext.x = x;
			_maptext.y = y;
		} else if (entityName == "workshoptxt") {
			_workshoptext.x = x;
			_workshoptext.y = y;
		}
	}

	private function switchWorkshopState():Void {
		FlxG.camera.fade(FlxColor.BLACK,.25, false, function() {
			FlxG.switchState(new WorkshopState());
		});
    }

	private function switchMapState():Void {
		FlxG.camera.fade(FlxColor.BLACK,.25, false, function() {
			if(tutState) {
				FlxG.switchState(new MapTutorialState());
			} else {
        		FlxG.switchState(new MapState());	
			}
		});
    }
}