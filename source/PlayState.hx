package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.ui.FlxButton;

class PlayState extends FlxState {
	private var _player:Player;
	private var _map:FlxOgmoLoader;
	private var _mWalls:FlxTilemap;
	private var _btnMenu:FlxButton;
	
	private var playerBullets:FlxTypedGroup<Bullet>;
	
	override public function create():Void {
		//add(new FlxText(10, 10, 100, "Hello, World!"));
		trace("Hello world!");
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
		
		_btnMenu = new FlxButton(0, 0, "Menu", clickMenu);
		add(_btnMenu);
		
		FlxG.camera.follow(_player, TOPDOWN, 1);
		super.create();
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		FlxG.collide(_player, _mWalls);
		FlxG.collide(_mWalls, playerBullets, bulletsHitWalls);
	}
	
	public function bulletsHitWalls(Object1:FlxObject, Object2:FlxObject):Void {
		//
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
