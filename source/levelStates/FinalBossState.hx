package levelStates;

import enemies.*;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.ui.FlxButton;
import weapons.*;
import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.addons.editors.tiled.TiledObjectLayer;
import flixel.tile.FlxBaseTilemap;

class FinalBossState extends PlayState {
	//private var _enemy:Boss1;
	//private var _boss_hud:Boss1HUD;
    private var timer:FlxText;
    private var explosion1:Explosion;
	private var explosion2:Explosion;
	private var explosion3:Explosion;
	private var explosion4:Explosion;
	
	private var sndExp1:FlxSound;
	private var sndExp2:FlxSound;
	private var sndExp0:FlxSound;
	
	private var exploded:Bool = false;
	
	override public function create():Void {
		LEVELID = 9;
		_is_boss = true;
        _is_boss3 = true;
		
		_map = new TiledMap(AssetPaths.finalBoss__tmx);
		_plat = new FlxTilemap();
		_plat.loadMapFromArray(cast(_map.getLayer("foreground"), TiledTileLayer).tileArray, _map.width, _map.height, 
			AssetPaths.finalTile__png, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 4372, 1, 1);

		_background = new FlxTilemap();
		_background.loadMapFromArray(cast(_map.getLayer("background"), TiledTileLayer).tileArray, _map.width, _map.height, 
			AssetPaths.finalBossBg__png, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 1, 1, 4373);

		_plat.follow();
		_background.follow();
		
		FlxG.camera.follow(_player, LOCKON, 1);
		// FlxG.debugger.visible = true;
		// FlxG.debugger.drawDebug = true;

		super.create();
        explosion1 = new Explosion();
		explosion2 = new Explosion();
		explosion3 = new Explosion();
		explosion4 = new Explosion();
		
		sndExp0 = FlxG.sound.load(AssetPaths.explosion_01__wav);
		sndExp1 = FlxG.sound.load(AssetPaths.explosion_02__wav);
		sndExp2 = FlxG.sound.load(AssetPaths.explosion_03__wav);
		
		
		add(_hud);
		Main.LOGGER.logLevelStart(LEVELID);
		addTopLayer();
        add(explosion1);
		add(explosion2);
		add(explosion3);
		add(explosion4);
		
        explosion1.kill();
		explosion2.kill();
		explosion3.kill();
		explosion4.kill();
	}

	override public function update(elapsed:Float):Void {
        if (enemiesGroup.countLiving() == 0 && !exploded) {
            explosion1.revive();
            explosion1.explode(boss3.x, boss3.y);
			explosion2.revive();
            explosion2.explode(boss3.x + 100, boss3.y + 100);
			explosion3.revive();
            explosion3.explode(boss3.x + 60, boss3.y + 150);
			explosion4.revive();
            explosion4.explode(boss3.x + 280, boss3.y + 130);
			sndExp0.play();
			sndExp1.play();
			sndExp2.play();
			exploded = true;
		}
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
			if (player.getMidpoint().x <= enemy.getMidpoint().x) {
				player.x -= 2;
			} else {
				player.x += 2;
			}
		}
	}
}