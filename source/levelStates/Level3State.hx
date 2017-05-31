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

class Level3State extends PlayState {
    private var _ice:FlxTilemap;
    private var _slide:Bool;
    override public function create():Void {
        LEVELID = 5;
        _slide = false;
        ///////////////////////////////////////////////////
        ////    LOAD MAP
        ///////////////////////////////////////////////////
        _map = new TiledMap(AssetPaths.lvl3__tmx);
        _background = new FlxTilemap();
        _plat = new FlxTilemap();
        _ice = new FlxTilemap();

        //load background
        _background.loadMapFromArray(cast(_map.getLayer("background"), TiledTileLayer).tileArray, _map.width,
            _map.height, AssetPaths.iceblock__jpg, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 1, 1, 3469);
        //load platform
        _plat.loadMapFromArray(cast(_map.getLayer("plat"), TiledTileLayer).tileArray, _map.width,
            _map.height, AssetPaths.city__jpg, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 3469, 3468, 3469);

        //load clouds
        _ice.loadMapFromArray(cast(_map.getLayer("ice"), TiledTileLayer).tileArray, _map.width,
            _map.height, AssetPaths.IceBox__png, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 3505, 3504, 3505);
        
        _background.setTileProperties(1, FlxObject.NONE);
        _plat.setTileProperties(3469, FlxObject.ANY);
        // for (i in 3505...3541) {
        //     _ice.setTileProperties(i, FlxObject.ANY);
        // }
        _ice.setTileProperties(3505, FlxObject.ANY);
        _background.follow();
		_plat.follow();
        _ice.follow();

        super.create();

        /////////////////////////
		//ADD EVERY COMPONENT
		////////////////////////
        add(_ice);
        add(_hud);
		add(_player);
        addTopLayer();
        Main.LOGGER.logLevelStart(LEVELID);

    }

    override public function update(elapsed:Float):Void {
        super.update(elapsed);
        //FlxG.overlap(_player, _ice, slide);
        FlxG.collide(_player, _ice);
        FlxG.collide(enemiesGroup, _ice);
		FlxG.collide(_ice, playerBullets, bulletsHitIce);
		FlxG.collide(_ice, enemiesBullets, enemiesBulletsHitIce);
        FlxG.collide(_ice, coinsGroup);
        

        if (_player.isTouching(FlxObject.DOWN)){
            if ((_player.x >= 38 * 15 && _player.x <= 153 * 15) 
            || (_player.x > 278 * 15 && _player.x < 442 * 15)
            || (_player.x > 606 * 15 && _player.x < 772 * 15)){
                _player.drag.x = 100;
            } else {
                _player.drag.x = 1600;
            } 
        }
    }

	public function bulletsHitIce(wall:FlxObject, pb:Bullet):Void {
		playerBullets.remove(pb);
		pb.destroy();
	}
	
	public function enemiesBulletsHitIce(wall:FlxObject, b:Bullet):Void {
		b.kill();
	}

    // private function slide(o1:FlxSprite, o2:FlxTilemap):Void {
    //     if (_player.isTouching(FlxObject.DOWN)) {
    //         _player.speed = 500;
    //     } else {
    //         _player.speed = 200;
    //     }
    // }
}