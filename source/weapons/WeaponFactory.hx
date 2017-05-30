package weapons;
import flixel.group.FlxGroup.FlxTypedGroup;

class WeaponFactory {
        public static function getWeapon (n:String, playerBulletArray:FlxTypedGroup<Bullet>):Weapon {
            if(n == "") {
                return new Weapon(playerBulletArray);
            } else if(n == "sword") {
                return new Sword(playerBulletArray);
            } else if(n == "shield") {
                return new Shield(playerBulletArray);
            } else if(n == "rifle") {
                return new Rifle(playerBulletArray);
            } else if(n == "revolver") {
                return new Revolver(playerBulletArray);
            } else if(n == "shotgun") {
                return new Shotgun(playerBulletArray);
            }
            return null;
        }
}