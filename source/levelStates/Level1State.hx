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
import flixel.util.FlxColor;
import weapons.*;
import enemies.*;

class Level1State extends PlayState {
    private var _keys:FlxTilemap;
    private var texts:FlxTypedGroup<FlxText>; 

    override public function create():Void {
		LEVELID = 2;
        ////////////////////////
        //LOAD MAP
        ////////////////////////
         _map = new TiledMap(AssetPaths.lvl1__tmx);
        _background = new FlxTilemap();
        _plat = new FlxTilemap();
        _keys = new FlxTilemap();

        //load background
        _background.loadMapFromArray(cast(_map.getLayer("background"), TiledTileLayer).tileArray, _map.width,
            _map.height, AssetPaths.level1BG__png, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 1, 1, 7209);
        //load platform
        _plat.loadMapFromArray(cast(_map.getLayer("plat"), TiledTileLayer).tileArray, _map.width,
            _map.height, AssetPaths.city__jpg, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 7209, 7208, 7209);
        
		//load keys
        _keys.loadMapFromArray(cast(_map.getLayer("keys"), TiledTileLayer).tileArray, _map.width,
            _map.height, AssetPaths.keyboard__png, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 7245, 7244, 10052);
        
        _background.setTileProperties(1, FlxObject.NONE);
        _plat.setTileProperties(7208, FlxObject.ANY);
		_keys.setTileProperties(7245, FlxObject.NONE);
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

        super.create();
        Main.LOGGER.logLevelStart(LEVELID);
        add(_keys);
		add(texts);
		add(_player);
        add(_hud);
        
        addTopLayer();
    }
	
	override public function update(elapsed:Float):Void {
		super.update(elapsed);
	}
	


    private function placeInstructions(entityName:String, entityData:Xml):Void {
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		switch entityName {
           	case "DJ":  var dj:FlxText = new FlxText(x, y, 150, "Press Twice", 19); 
                       	dj.setFormat(AssetPaths.FONT, dj.size); 
                       	texts.add(dj);

           	case "Q":   var q:FlxText = new FlxText(x, y, 250, "Switch Weapon Configuration", 19);
		               	q.setFormat(AssetPaths.FONT, q.size);
                       	texts.add(q);					   

            case "R": var r:FlxText = new FlxText(x, y, 250, "R to reload for rifles", 19);
                        r.setFormat(AssetPaths.FONT, r.size);
                        texts.add(r);
       }
    }
}
