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

class Level1State extends PlayState
{
    override public function create():Void 
    {
        ////////////////////////
        //LOAD MAP
        ////////////////////////
         _map = new TiledMap(AssetPaths.lvl1__tmx);
        _background = new FlxTilemap();
        _plat = new FlxTilemap();

        //load background
        _background.loadMapFromArray(cast(_map.getLayer("background"), TiledTileLayer).tileArray, _map.width,
            _map.height, AssetPaths.level1BG__png, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 1, 1, 7213);
        //load platform
        _plat.loadMapFromArray(cast(_map.getLayer("plat"), TiledTileLayer).tileArray, _map.width,
            _map.height, AssetPaths.green__jpg, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 7209, 7208, 7209);
        
        _background.setTileProperties(1, FlxObject.NONE);
        //_plat.setTileProperties(1, FlxObject.ANY);
        _background.follow();
		_plat.follow();

        super.create();
        Main.LOGGER.logLevelStart(2);
    }
}
