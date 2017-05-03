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
	private var _health:Int;
	private var _hud:HUD;
	
	private var playerBullets:FlxTypedGroup<Bullet>;
	
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
		
		_player = new Player(playerBullets);
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

		_hud.updateHUD(_player.getAmmo(0), _player.getAmmo(1), _player.isReloading(0), _player.isReloading(1),
						_player.getWeaponName(0), _player.getWeaponName(1));
		FlxG.collide(_player, _mWalls);
		FlxG.collide(_mWalls, playerBullets, bulletsHitWalls);
		for (pb in playerBullets){
			//destroyed?
			if (pb.outOfRange(pb.x)){
				playerBullets.remove(pb);
				pb.destroy();
			}
		}
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
		}
	}
	
	private function clickMenu():Void {
		FlxG.switchState(new MenuState());
	}
}
