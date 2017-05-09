package;

import flixel.*;
import flixel.addons.editors.tiled.TiledMap;
import flixel.tile.FlxTilemap;
import flixel.ui.FlxButton;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.addons.editors.tiled.TiledObjectLayer;
import flixel.tile.FlxBaseTilemap;
import flixel.group.FlxGroup.FlxTypedGroup;
import weapons.*;
import enemies.*;

class TutorialFState extends FlxState
{
    private var _player:Player;
    private var _map:TiledMap;

    private var _background:FlxTilemap;
    private var _plat:FlxTilemap;
    private var _bound:FlxTilemap;

    private var _btnMenu:FlxButton;
    private var _instruct:Instruction;

    private var locations:Map<Int, String>;
    private var sorted:Array<Int>;
    private var next:Int;

    private var playerBullets:FlxTypedGroup<Bullet>;
	private var GRAVITY:Float = 1000;

    private var _end:Int;
    private var _enemies:FlxTypedGroup<Enemy>;


    override public function create():Void
    {
        //LOAD MAP BASICS
        _map = new TiledMap(AssetPaths.tutorialFormal__tmx);
        _background = new FlxTilemap();
        _plat = new FlxTilemap();
        _bound = new FlxTilemap();

        //load background
        _background.loadMapFromArray(cast(_map.getLayer("background"), TiledTileLayer).tileArray, _map.width,
            _map.height, AssetPaths.tutorialBG__png, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 1, 1, 1023);
        //load platform
        _plat.loadMapFromArray(cast(_map.getLayer("plat"), TiledTileLayer).tileArray, _map.width,
            _map.height, AssetPaths.green__jpg, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 1021, 1, 1020);
        //load bounds
        _bound.loadMapFromArray(cast(_map.getLayer("bound"), TiledTileLayer).tileArray, _map.width,
            _map.height, AssetPaths.green__jpg, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 1021, 1, 1020);

        _background.setTileProperties(2, FlxObject.NONE);
        _bound.setTileProperties(1, FlxObject.ANY);
        _plat.setTileProperties(1, FlxObject.ANY);


        //LOAD PLAYER
        playerBullets = new FlxTypedGroup<Bullet>();
        _player = new Player(playerBullets, GRAVITY);
        _btnMenu = new FlxButton(0, 0, "Menu", clickMenu);

        var tmpMap:TiledObjectLayer = cast _map.getLayer("player");
        for (e in tmpMap.objects)
        {
            placeEntities(e.name, e.xmlData.x);
        }

        //LOAD ENEMIES
        //
        //
        _enemies = new FlxTypedGroup<Enemy>();


        //LOAD INSTRUCTIONS
        locations = new Map<Int, String>();
        sorted = new Array<Int>();
        var tmpLayer:TiledObjectLayer = cast _map.getLayer("instructions");
        for (e in tmpLayer.objects)
        {
            placeInstructions(e.name, e.xmlData.x);
        }
        haxe.ds.ArraySort.sort(sorted, function(a, b):Int {
            if (a < b) return -1;
            else if (a > b) return 1;
            return 0;
        });
        _instruct = new Instruction(0, 0, 300, 12);
        trace(sorted.length);
        next = sorted.shift();
        trace(next);



        //ADD EVERY COMPONENT
        add(_background);
        add(_bound);
        add(_plat); 
        add(_player);
        add(_btnMenu);
        add(_instruct);
        add(playerBullets);
        add(_enemies);
        add(locations);
        add(sorted);
        add(next);
        FlxG.camera.follow(_player, TOPDOWN, 1);
		super.create();
    }

    //Place enemies and player starting/ending point
    private function placeEntities(entityName:String, entityData:Xml):Void 
    {
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
        switch entityName {
            case "START": _player.x = x; _player.y = y;
            case "END": _end = x;
            //ENEMIES CASES NEEDED
            //
            //
        }
    }

    //Place all the instructions
    private function placeInstructions(entityName:String, entityData:Xml):Void 
    {
		var x:Int = Std.parseInt(entityData.get("x"));
		//var y:Int = Std.parseInt(entityData.get("y"));
        locations.set(x, entityName); 
        sorted.push(x);
    }

    //Intialize instructions 
    private function instructInit(elapsed:Float):Void
    {   
        //trace(_player.x + "     " +_next);
        //trace(cast(_player.x, Int) + "      " +  _next);
        //trace(_sorted.length + "        " + _next);
        if (Std.int(_player.x) == next) {
            trace("Reached!");
            _instruct.instruct(locations.get(next), _player.x + 100, _player.y - 30);
            next = sorted.shift();
        }        
    }

	override public function update(elapsed:Float):Void 
    {
        trace(_player.x);
        instructInit(elapsed);
        FlxG.collide(_player, _bound);
        FlxG.collide(_player, _plat);
		super.update(elapsed);

	}

    private function clickMenu():Void {
		FlxG.switchState(new MenuState());
	}


}