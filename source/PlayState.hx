package;

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

class PlayState extends FlxState {
	private var _player:Player;
	private var _map:FlxOgmoLoader;
	private var _mWalls:FlxTilemap;
	private var _btnMenu:FlxButton;
	private var _health:Int;
	private var _hud:HUD;
	
	private var enemiesGroup:FlxTypedGroup<Enemy>;
	private var playerBullets:FlxTypedGroup<Bullet>;
	private var enemiesBullets:FlxTypedGroup<Bullet>;
	
	private var GRAVITY:Float = 1000;
	
	override public function create():Void {
		//add(new FlxText(10, 10, 100, "Hello, World!"));
		//trace("Hello world!");
		//FlxG.debugger.drawDebug = true;
		
		_map = new FlxOgmoLoader("assets/data/first_level.oel");
		_mWalls = _map.loadTilemap(AssetPaths.tiles__png, 16, 16, "walls");
		_mWalls.follow();
		_mWalls.setTileProperties(1, FlxObject.NONE);
		_mWalls.setTileProperties(2, FlxObject.ANY);
		add(_mWalls);
		
		playerBullets = new FlxTypedGroup<Bullet>();
		add(playerBullets);
		enemiesBullets = new FlxTypedGroup<Bullet>();
		add(enemiesBullets);
		
		enemiesGroup = new FlxTypedGroup<Enemy>();
		add(enemiesGroup);
		
		_player = new Player(playerBullets, GRAVITY);
		_map.loadEntities(placeEntities, "entities");
		add(_player);
		
		// _btnMenu = new FlxButton(0, 0, "Menu", clickMenu);
		// add(_btnMenu);
		
		_health = 100;
		FlxG.camera.follow(_player, TOPDOWN, 1);

		_hud = new HUD(_player);
		add(_hud);
		_hud.updateHUD(_player.getAmmo(0), _player.getAmmo(1), _player.isReloading(0), _player.isReloading(1),
						_player.getWeaponName(0), _player.getWeaponName(1));
		super.create();
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		if (enemiesGroup.countLiving() == -1) {
			_map.loadEntities(placeEntities, "entities");
		}
		_hud.updateHUD(_player.getAmmo(0), _player.getAmmo(1), _player.isReloading(0), _player.isReloading(1),
						_player.getWeaponName(0), _player.getWeaponName(1));
						
		FlxG.overlap(playerBullets, enemiesGroup, bulletsHitEnemies);
		FlxG.collide(_mWalls, playerBullets, bulletsHitWalls);
		enemiesGroup.forEach(enemiesUpdate);
		FlxG.collide(_player, _mWalls);
		FlxG.collide(enemiesGroup, _mWalls);
		bulletsRangeUpdate();
	}
	
	private function bulletsRangeUpdate():Void {
		for (pb in playerBullets) {
			//destroyed?
			if (pb.outOfRange(pb.x)){
				playerBullets.remove(pb);
				pb.destroy();
			}
		}
		for (eb in enemiesBullets) {
			if (eb.outOfRange(eb.x)) {
				playerBullets.remove(eb);
				eb.destroy();
			}
		}
	}
	
	private function enemiesUpdate(e:Enemy):Void {
		if (!e.alive && e.animation.finished) {
			enemiesGroup.remove(e);
			e.destroy();
		} else if (e.alive) {
			e.playerPos.copyFrom(_player.getMidpoint());
			if (!_player.isTumbling()) {
				FlxG.collide(_player, e, playerCollidesEnemies);
			}
			
		}
	}
	
	public function bulletsHitEnemies(bullet:Bullet, enemy:Enemy):Void {
		if (enemy.alive) {
			enemy.hurt(bullet.getDamage());
			playerBullets.remove(bullet);
			bullet.destroy();
		}
	}
	
	public function playerCollidesEnemies(player:Player, enemy:Enemy):Void {
		enemy.velocity.set(0, 0);
	}
	
	public function bulletsHitWalls(wall:FlxObject, pb:Bullet):Void {
		playerBullets.remove(pb);
		pb.destroy();
	}

	private function placeEntities(entityName:String, entityData:Xml):Void {
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		if (entityName == "player") {
			_player.x = x;
			_player.y = y;
		} else if (entityName == "enemy") {
			enemiesGroup.add(new RifleEnemy(x, y, enemiesBullets, GRAVITY));
		}
	}
	
	private function clickMenu():Void {
		FlxG.switchState(new MenuState());
	}
}
