package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.FlxObject;

class Player extends FlxSprite {
	public var speed:Float = 200;
	private var gravity:Float = 1000;
	private var jumped:Bool = false;
	private var jump:Float = 0.0;
	
	public function new(?X:Float=0, ?Y:Float=0) {
		super(X, Y);
		//makeGraphic(16, 16, FlxColor.BLUE);
		loadGraphic(AssetPaths.player__png, true, 16, 16);
		scale.set(4, 4);
		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);
		animation.add("lr", [3, 4, 3, 5], 6, false);
		animation.add("u", [6, 7, 6, 8], 6, false);
		animation.add("d", [0, 1, 0, 2], 6, false);
		animation.add("stop", [0], 1, false);
		//drag.x = drag.y = 1600;
		setSize(40, 50);
		offset.set( -10, -15);
		
		acceleration.y = gravity;
	}
	
	override public function update(elapsed:Float):Void {
		movement(elapsed);
		super.update(elapsed);
	}
	
	private function movement(elapsed:Float):Void {
		var _up:Bool = false;
		var _down:Bool = false;
		var _left:Bool = false;
		var _right:Bool = false;
		
		_up = FlxG.keys.anyPressed([UP, W]);
		_down = FlxG.keys.anyPressed([DOWN, S]);
		_left = FlxG.keys.anyPressed([LEFT, A]);
		_right = FlxG.keys.anyPressed([RIGHT, D]);
		
		if (_up && _down)
			_up = _down = false;
		if (_left && _right)
			_left = _right = false;
		
		if (_left) {
			facing = FlxObject.LEFT;
			velocity.x = -speed;
		} else if (_right) {
			facing = FlxObject.RIGHT;
			velocity.x = speed;
		}
		
		if (!_left && !_right) {
			velocity.x = 0;
			facing = FlxObject.NONE;
		}
		
		if (jumped && !_up) {
			jumped = false;
		}
		
		if (touching == FlxObject.DOWN && !jumped) {
			jump = 0;
		}
		
		if (jump >= 0 && _up) {
			jumped = true;
			jump += elapsed;
			if (jump > 0.33) {
				jump = -1;
			}
		} else {
			jump = -1;
		}
		
		if (jump > 0) {
			velocity.y = -speed * 2;
		}
		// if the player is moving (velocity is not 0), we need to change the
		// animation to match their facing
		switch (facing) {
			case FlxObject.LEFT, FlxObject.RIGHT:
				animation.play("lr");
			case FlxObject.UP:
				animation.play("u");
			case FlxObject.DOWN:
				animation.play("d");
			case FlxObject.NONE:
				animation.play("stop");
		}
	}
	
}