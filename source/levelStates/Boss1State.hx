package levelStates;

import enemies.*;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.ui.FlxButton;
import weapons.*;
import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.addons.editors.tiled.TiledObjectLayer;
import flixel.tile.FlxBaseTilemap;

class Boss1State extends PlayState {
	//private var _enemy:Boss1;
	//private var _boss_hud:Boss1HUD;
	
	override public function create():Void {
		LEVELID = 3;
		_is_boss = true;
		
		_map = new TiledMap(AssetPaths.boss1__tmx);
		_plat = new FlxTilemap();
		_plat.loadMapFromArray(cast(_map.getLayer("foreground"), TiledTileLayer).tileArray, _map.width, _map.height, 
			AssetPaths.boss1tile__png, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 2721, 1, 1);

		_background = new FlxTilemap();
		_background.loadMapFromArray(cast(_map.getLayer("background"), TiledTileLayer).tileArray, _map.width, _map.height, 
			AssetPaths.boss1background__png, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 1, 1, 2722);

		_plat.follow();
		_background.follow();
		
		FlxG.camera.follow(_player, LOCKON, 1);

		super.create();
		add(_hud);
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);
	}

	private function bulletsHitEnemy(bullet:Bullet, small_boss:Boss1):Void {
		if (small_boss.alive) {
			var damage:Float = bullet.getDamage();
			//trace(damage);
			small_boss.hurt(damage);
			playerBullets.remove(bullet);
			bullet.destroy();
		}
	}

/*
	public function stopPlayer(player:Player, enemy:Boss1):Void {
		if(!player.isTumbling()) {
			if (player.facing == FlxObject.LEFT) {
				player.x += 2;
			} else {
				player.x -= 2;	
			}
		}
	}
	*/

	override public function playerCollidesEnemies(player:Player, enemy:Enemy):Void {
		if(!player.isTumbling()) {
			if (player.facing == FlxObject.LEFT) {
				player.x += 2;
			} else {
				player.x -= 2;	
			}
		}
	}
}
