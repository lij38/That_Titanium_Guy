package enemies;

import flixel.group.FlxGroup.FlxTypedGroup;
import weapons.*;
import items.*;

class EnemyFactory {
	public static function getEnemy(enType:String, X:Float = 0, Y:Float = 0, 
						bulletArray:FlxTypedGroup<EnemyBullet>,
						coinsGroup:FlxTypedGroup<Coin>,
						gravity:Float, level:Int = 0):Enemy {
		if (enType == "MELEE") {
			return new MeleeEnemy(X, Y, bulletArray, coinsGroup, gravity, level);
		} else if (enType == "RIFLE") {
			return new RifleEnemy(X, Y, bulletArray, coinsGroup,gravity, level);
		} else if (enType == "SHIELD") {
			return new ShieldEnemy(X, Y, bulletArray, coinsGroup,gravity, level);
		} else if (enType == "TRUCK") {
			return new TruckEnemy(X, Y, bulletArray, coinsGroup, gravity, level);
		}
		return null;
	}
	
}