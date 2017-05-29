package levelStates;
import flixel.*;
import flixel.addons.editors.tiled.TiledMap;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tile.FlxTilemap;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.addons.editors.tiled.TiledObjectLayer;
import flixel.tile.FlxBaseTilemap;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;

class Level2State extends PlayState {
    private var _keys:FlxTilemap;
    private var texts:FlxTypedGroup<FlxText>; 
    private var _cloud:FlxTilemap;

    override public function create():Void {
		LEVELID = 5;
        ///////////////////////////////////////////////////
        ////    LOAD MAP
        ///////////////////////////////////////////////////
         _map = new TiledMap(AssetPaths.lvl2__tmx);
        _background = new FlxTilemap();
        _plat = new FlxTilemap();
        _keys = new FlxTilemap();
        _cloud = new FlxTilemap();

        //load background
        _background.loadMapFromArray(cast(_map.getLayer("background"), TiledTileLayer).tileArray, _map.width,
            _map.height, AssetPaths.sky1__jpg, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 1, 1, 2707);
        //load platform
        _plat.loadMapFromArray(cast(_map.getLayer("plat"), TiledTileLayer).tileArray, _map.width,
            _map.height, AssetPaths.city__jpg, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 2839, 2838, 2839);
        
		//load keys
        _keys.loadMapFromArray(cast(_map.getLayer("keys"), TiledTileLayer).tileArray, _map.width,
            _map.height, AssetPaths.keyboard__png, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 2875, 2874, 5682);

        //load clouds
        _cloud.loadMapFromArray(cast(_map.getLayer("cloud"), TiledTileLayer).tileArray, _map.width,
            _map.height, AssetPaths.ball__png, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 2707, 2706, 2875);
        
        _background.setTileProperties(1, FlxObject.NONE);
        _plat.setTileProperties(2839, FlxObject.ANY);
		_keys.setTileProperties(2875, FlxObject.NONE);
        _cloud.setTileProperties(2707, FlxObject.NONE);
        _background.follow();
		_plat.follow();
		_keys.follow();
        _cloud.follow();

        /////////////////////////////////////////////
        ///  LOAD INSTRUCTIONS
		/////////////////////////////////////////////
		texts = new FlxTypedGroup<FlxText>();
		var instructLayer:TiledObjectLayer = cast _map.getLayer("instruction");
		for (e in instructLayer.objects) {
			placeInstructions(e.name, e.xmlData.x);
		}
        
        super.create();

        /////////////////////////
		//ADD EVERY COMPONENT
		////////////////////////
        add(_cloud);
        add(_keys);
		add(texts);
        add(_hud);
		add(_player);
        add(_hud);
        addTopLayer();

        Main.LOGGER.logLevelStart(LEVELID);

    }
	
	override public function update(elapsed:Float):Void {
		super.update(elapsed);
	}
	


    private function placeInstructions(entityName:String, entityData:Xml):Void {
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		switch entityName {
           	case "JP":  var jp:FlxText = new FlxText(x, y, 650, "Hold Shift with One of                       to steer jet pack", 25); 
                       	jp.setFormat(AssetPaths.FONT, jp.size); 
                       	texts.add(jp);
       }
    }
}