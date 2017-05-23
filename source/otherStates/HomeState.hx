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
		 	_arrow = new Arrow();
			 _arrow.x = 120;
			 _arrow.y = 50;
			 add(_arrow);
			 _text = new FlxText(0, 0, 330, 20);
			 _text.x = 175;
			 _text.y = 35;
        	_text.text = "This is your home! You can move and try your weapons. " + 
            	"This is the map, you can click here to go back to the map and challenge new levels. (Click Anywhere to continue)";
        	_text.setFormat(AssetPaths.FONT, 20);
        	add(_text);
		 }

		 FlxG.camera.follow(_player, LOCKON, 1);

		super.create();
		
	}

	override public function update(elapsed:Float):Void
	{
		FlxG.collide(_player, _fg);
		if (tutorial_map) {
			if (FlxG.mouse.justPressed) {
            	tutorial_map = false;
            	_arrow.visible = false;
            	_text.visible = false;
            	_bg.color = 0xffffff;
            	_player.color = 0xffffff;
            	_fg.color = 0xffffff;
            	_mapbutton.active = true;
        	}	
		}
		FlxG.collide(_player, _bg);
		super.update(elapsed);
	}

	private function placeEntities(entityName:String, entityData:Xml):Void
	{
	    var x:Int = Std.parseInt(entityData.get("x"));
	    var y:Int = Std.parseInt(entityData.get("y"));

	    if (entityName == "player")
	    {
	        _player.x = x;
	        _player.y = y;
		} 
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