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
import weapons.*;

class Level4State extends PlayState {
    private var _slide:Bool;
    override public function create():Void {
        LEVELID = 7;
        _slide = false;
        ///////////////////////////////////////////////////
        ////    LOAD MAP
        ///////////////////////////////////////////////////
        _map = new TiledMap(AssetPaths.lvl4__tmx);
        _background = new FlxTilemap();
        _plat = new FlxTilemap();

        //load background
        _background.loadMapFromArray(cast(_map.getLayer("background"), TiledTileLayer).tileArray, _map.width,
            _map.height, AssetPaths.lab__jpg, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 7, 6, 11528);
        //load platform
        _plat.loadMapFromArray(cast(_map.getLayer("plat"), TiledTileLayer).tileArray, _map.width,
            _map.height, AssetPaths.metal__jpg, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 1, 1, 1);

        
        _background.setTileProperties(7, FlxObject.NONE);
        _plat.setTileProperties(1, FlxObject.ANY);

        _background.follow();
		_plat.follow();

        super.create();

        /////////////////////////
		//ADD EVERY COMPONENT
		////////////////////////
        add(_hud);
		add(_player);
        addTopLayer();
        Main.LOGGER.logLevelStart(LEVELID);

    }
}

