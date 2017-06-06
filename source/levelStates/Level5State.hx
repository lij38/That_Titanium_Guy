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

class Level5State extends PlayState {
    private var _slide:Bool;
    override public function create():Void {
        LEVELID = 8;
        _slide = false;
        ///////////////////////////////////////////////////
        ////    LOAD MAP
        ///////////////////////////////////////////////////
        _map = new TiledMap(AssetPaths.lvl5__tmx);
        _background = new FlxTilemap();
        _plat = new FlxTilemap();

        //load background
        _background.loadMapFromArray(cast(_map.getLayer("background"), TiledTileLayer).tileArray, _map.width,
            _map.height, AssetPaths.cityBurn__jpg, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 1, 1, 7209);
        //load platform
        _plat.loadMapFromArray(cast(_map.getLayer("plat"), TiledTileLayer).tileArray, _map.width,
            _map.height, AssetPaths.tile__jpg, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 7209, 7208, 7209);

        
        _background.setTileProperties(1, FlxObject.NONE);
        _plat.setTileProperties(7209, FlxObject.ANY);

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
