package levelStates;

import flixel.*;
import flixel.addons.editors.tiled.TiledMap;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tile.FlxTilemap;
import flixel.ui.FlxButton;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.addons.editors.tiled.TiledObjectLayer;
import flixel.tile.FlxBaseTilemap;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import weapons.*;
import enemies.*;

class Level1State extends PlayState {
    private var _keys:FlxTilemap;
    private var texts:FlxTypedGroup<FlxText>; 
	private var rifle:FlxSprite;

    override public function create():Void {
        ////////////////////////
        //LOAD MAP
        ////////////////////////
         _map = new TiledMap(AssetPaths.lvl1__tmx);
        _background = new FlxTilemap();
        _plat = new FlxTilemap();
        _keys = new FlxTilemap();

        //load background
        _background.loadMapFromArray(cast(_map.getLayer("background"), TiledTileLayer).tileArray, _map.width,
            _map.height, AssetPaths.level1BG__png, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 1, 1, 7213);
        //load platform
        _plat.loadMapFromArray(cast(_map.getLayer("plat"), TiledTileLayer).tileArray, _map.width,
            _map.height, AssetPaths.green__jpg, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 7209, 7208, 7209);
        
		//load keys
        _keys.loadMapFromArray(cast(_map.getLayer("keys"), TiledTileLayer).tileArray, _map.width,
            _map.height, AssetPaths.keys__png, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 7210, 7209, 8085);
        
        _background.setTileProperties(1, FlxObject.NONE);
        _plat.setTileProperties(7209, FlxObject.ANY);
		_keys.setTileProperties(7210, FlxObject.ANY);
        _background.follow();
		_plat.follow();
		_keys.follow();


        /////////////////////////////////////////////
        //LOAD INSTRUCTIONS
		////////////////////////////////////////////
		texts = new FlxTypedGroup<FlxText>();
		var instructLayer:TiledObjectLayer = cast _map.getLayer("instruction");
		for (e in instructLayer.objects) {
			placeInstructions(e.name, e.xmlData.x);
		}
		
		
		/////////////////////////////////////////////
        //LOAD Rifle
		////////////////////////////////////////////
		rifle = new FlxSprite();
		rifle.loadGraphic(AssetPaths.rifle__png);
		var rifleLayer:TiledObjectLayer = cast _map.getLayer("rifle");
		for (e in rifleLayer.objects) {
			var x:Int = Std.parseInt(e.xmlData.x.get("x"));
			var y:Int = Std.parseInt(e.xmlData.x.get("y"));
			if (e.name == "RIFLE") {
				rifle.x = x;
				rifle.y = y;
			}
		}

        super.create();
        Main.LOGGER.logLevelStart(2);
        add(_keys);
		add(texts);
		add(rifle);
    }
	
	override public function update(elapsed:Float):Void {
		FlxG.overlap(rifle, _player, onPickup);
		super.update(elapsed);
	}
	
	private function onPickup(a:FlxSprite, b:FlxSprite):Void {
		rifle.kill();
		_player.pickUpRifle();
	}


    private function placeInstructions(entityName:String, entityData:Xml):Void {
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		switch entityName {
           case "WW":  var ww:FlxText = new FlxText(x, y, 120, "DoubleJump", 19); 
                       ww.setFormat(AssetPaths.FONT, ww.size); 
                       texts.add(ww);

           case "Q":   var q:FlxText = new FlxText(x, y, 250, "Switch Weapon Configuration", 19);
		               q.setFormat(AssetPaths.FONT, q.size);
                       texts.add(q);
       }
    }
}
