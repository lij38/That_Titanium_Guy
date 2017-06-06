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

class Boss2State extends PlayState {
	//private var _enemy:Boss1;
	//private var _boss_hud:Boss1HUD;
    private var timer:FlxText;

	override public function create():Void {
		LEVELID = 9;
		_is_boss = true;
        _is_boss3 = true;
		
		_map = new TiledMap(AssetPaths.boss2__tmx);
		_plat = new FlxTilemap();
		_plat.loadMapFromArray(cast(_map.getLayer("foreground"), TiledTileLayer).tileArray, _map.width, _map.height, 
			AssetPaths.boss2tile__png, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 4626, 1, 1);

		_background = new FlxTilemap();
		_background.loadMapFromArray(cast(_map.getLayer("background"), TiledTileLayer).tileArray, _map.width, _map.height, 
			AssetPaths.boss2bg__png, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 1, 1, 4628);

		_plat.follow();
		_background.follow();
		
		FlxG.camera.follow(_player, LOCKON, 1);
		// FlxG.debugger.visible = true;
		// FlxG.debugger.drawDebug = true;

		super.create();
		add(_hud);
		Main.LOGGER.logLevelStart(LEVELID);
		addTopLayer();
	}

	override public function update(elapsed:Float):Void {
        _boss_hud.updateTimer();
		super.update(elapsed);
		//playerPos.copyFrom(_player.getMidpoint());
	}

	private function bulletsHitEnemy(bullet:Bullet, boss:FinalBoss):Void {
		if (boss.alive) {
			var damage:Float = bullet.getDamage();
			//trace(damage);
			boss.hurt(damage);
			playerBullets.remove(bullet);
			bullet.destroy();
		}
	}

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