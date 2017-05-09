package;

import flixel.*;
import flixel.addons.editors.tiled.TiledMap;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tile.FlxTilemap;
import flixel.ui.FlxButton;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.addons.editors.tiled.TiledObjectLayer;
import flixel.tile.FlxBaseTilemap;
<<<<<<< HEAD
import flixel.group.FlxGroup.FlxTypedGroup;
=======
>>>>>>> 7e5b75ebebc42ea5c171fe28c5eb60df8f4d5736
import weapons.*;

class TutorialState extends FlxState {
    private var _player:Player;
    private var _map:TiledMap;

    private var _background:FlxTilemap;
    private var _plat:FlxTilemap;
    private var _bound:FlxTilemap;

    private var _btnMenu:FlxButton;
    private var _instruct:Instruction;

    private var _locations:Map<Int, String>;
    private var _sorted:Array<Int>;
    private var _next:Int;
	
	private var playerBullets:FlxTypedGroup<Bullet>;

    private var playerBullets:FlxTypedGroup<Bullet>;
	
	private var GRAVITY:Float = 1000;


    override public function create():Void {
        //LOAD MAP BASICS
        _map = new TiledMap(AssetPaths.tutorial__tmx);
        _background = new FlxTilemap();
        _plat = new FlxTilemap();
        _bound = new FlxTilemap();

        //load background
        _background.loadMapFromArray(cast(_map.getLayer("background"), TiledTileLayer).tileArray, _map.width,
            _map.height, AssetPaths.tutorialBG__png, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 1, 1, 1023);
        //load platform
        _plat.loadMapFromArray(cast(_map.getLayer("plat"), TiledTileLayer).tileArray, _map.width,
            _map.height, AssetPaths.green__jpg, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 2041, 1, 2040);
        //load bounds
        _bound.loadMapFromArray(cast(_map.getLayer("bound"), TiledTileLayer).tileArray, _map.width,
            _map.height, AssetPaths.green__jpg, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 2041, 1, 2040);

        _background.setTileProperties(2, FlxObject.NONE);
        _bound.setTileProperties(1, FlxObject.ANY);
        _plat.setTileProperties(1, FlxObject.ANY);

        //LOAD PLAYER
		playerBullets = new FlxTypedGroup<Bullet>();
        _player = new Player(playerBullets, GRAVITY);
        _btnMenu = new FlxButton(0, 0, "Menu", clickMenu);

        var tmpMap:TiledObjectLayer = cast _map.getLayer("player");
        for (e in tmpMap.objects) {
            placeEntities(e.name, e.xmlData.x);
        }

        //LOAD INSTRUCTIONS
        _locations = new Map<Int, String>();
        _sorted = new Array<Int>();
        var tmpLayer:TiledObjectLayer = cast _map.getLayer("instruction");
        for (e in tmpLayer.objects) {
            placeEntities(e.name, e.xmlData.x);
        }
        haxe.ds.ArraySort.sort(_sorted, function(a, b):Int {
            if (a < b) return -1;
            else if (a > b) return 1;
            return 0;
        });
        _instruct = new Instruction(0, 0, 300, 12);
        trace(_sorted.length);
        _next = _sorted.shift();
        trace(_next);



        //ADD EVERY COMPONENT
        add(_background);
        add(_bound);
        add(_plat); 
        add(_player);
        add(_btnMenu);
        add(_instruct);
        FlxG.camera.follow(_player, TOPDOWN, 1);
		super.create();


    }

	private function placeEntities(entityName:String, entityData:Xml):Void  {
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		if (entityName == "player") {
			_player.x = x;
			_player.y = y;
		} else {
            _locations.set(x, entityName);
            _sorted.push(x);
        }

	}

    private function instructInit(elapsed:Float):Void {   
        //trace(_player.x + "     " +_next);
        //trace(_player.x == cast(_next, Float));
        if (Std.int(_player.x) == _next) {
            trace("Reached!");
            _instruct.instruct(_locations.get(_next), _player.x + 100, _player.y - 20);
            
            _next = _sorted.shift();
        }        
    }

	override public function update(elapsed:Float):Void  {
        instructInit(elapsed);
        FlxG.collide(_player, _bound);
        FlxG.collide(_player, _plat);
		super.update(elapsed);

	}

    private function clickMenu():Void {
		FlxG.switchState(new MenuState());
	}

}