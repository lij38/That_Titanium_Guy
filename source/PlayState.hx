package;

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
	
	private var enemies:FlxTypedGroup<Enemy>;
	private var playerBullets:FlxTypedGroup<Bullet>;
	
	private var GRAVITY:Float = 1000;
	
	override public function create():Void {
		//add(new FlxText(10, 10, 100, "Hello, World!"));
		//trace("Hello world!");
		_map = new FlxOgmoLoader("assets/data/first_level.oel");
		_mWalls = _map.loadTilemap(AssetPaths.tiles__png, 16, 16, "walls");
		_mWalls.follow();
		_mWalls.setTileProperties(1, FlxObject.NONE);
		_mWalls.setTileProperties(2, FlxObject.ANY);
		add(_mWalls);
		
		playerBullets = new FlxTypedGroup<Bullet>();
		add(playerBullets);
		
		enemies = new FlxTypedGroup<Enemy>();
		add(enemies);
		
		_player = new Player(playerBullets, GRAVITY);
		_map.loadEntities(placeEntities, "entities");
		add(_player);
		
		_btnMenu = new FlxButton(0, 0, "Menu", clickMenu);
		add(_btnMenu);
		
		FlxG.camera.follow(_player, TOPDOWN, 1);
		super.create();
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		
		if (!_player.isTumbling()) {
			FlxG.collide(_player, enemies, playerCollidesEnemies);
		}
		
		FlxG.overlap(playerBullets, enemies, bulletsHitEnemies);
		FlxG.collide(_mWalls, playerBullets, bulletsHitWalls);
		FlxG.collide(_player, _mWalls);
		FlxG.collide(enemies, _mWalls);
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
	
	public function bulletsHitWalls(Object1:FlxObject, Object2:FlxObject):Void {
		//
		FlxG.collide(playerBullets, _mWalls, bulletHitWall);
		for (pb in playerBullets){
			//destroyed?
			if (pb.outOfRange(pb.x)){
				playerBullets.remove(pb);
				pb.destroy();
			}
		}
	}
	
	public function bulletHitWall(pb:Bullet, wall:FlxObject):Void {
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
			enemies.add(new Enemy(x, y, GRAVITY));
		}
	}
	
	private function clickMenu():Void {
		FlxG.switchState(new MenuState());
	}


}
