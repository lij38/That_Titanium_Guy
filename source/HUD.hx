package ;
 import flixel.FlxBasic;
 import flixel.FlxG;
 import flixel.FlxSprite;
 import flixel.group.FlxGroup.FlxTypedGroup;
 import flixel.text.FlxText;
 import flixel.util.FlxColor;
 import flixel.ui.FlxBar;
 import flixel.tweens.*;
 using flixel.util.FlxSpriteUtil;

class HUD extends FlxTypedGroup<FlxSprite>
{
    private var _player:Player;
    private var _sprHealth:FlxSprite;
    private var _txtjAmmo:FlxText;
    private var _txtkAmmo:FlxText;
    private var _healthbar:FlxBar;
    private var _jWeapon:FlxSprite;
    private var _kWeapon:FlxSprite;
    private var _damage1:FlxText;
    private var _damage2:FlxText;
    private var dmgCounter:Int;

    public function new(player:Player)
     {
         super();
         _player = player;
        //ammo
        _txtjAmmo = new FlxText(382, 55, 0, "", 24);
        _txtkAmmo = new FlxText(462, 55, 0, "", 24);
        _txtjAmmo.setFormat(AssetPaths.FONT, _txtjAmmo.size);
        _txtkAmmo.setFormat(AssetPaths.FONT, _txtkAmmo.size);

         //health icon
         _sprHealth = new FlxSprite(20, 4, AssetPaths.health__png);

         //health bar
        _healthbar = new FlxBar(40, 4, LEFT_TO_RIGHT, 250, 15, _player, "health", 0, _player.health);
        _healthbar.createFilledBar(FlxColor.TRANSPARENT, FlxColor.RED, true, FlxColor.BLACK);

        //weapons
        _jWeapon = new FlxSprite(375, 4);
        _kWeapon = new FlxSprite(455, 4);

        //damage
        _damage1 = new FlxText(_player.x + 30, _player.y - 50, 0, "1", 30);
        _damage1.setFormat(AssetPaths.FONT, _damage1.size, FlxColor.RED);
        _damage1.visible = false;
        _damage2 = new FlxText(_player.x + 30, _player.y - 50, 0, "2", 30);
        _damage2.setFormat(AssetPaths.FONT, _damage2.size, FlxColor.RED);
        _damage2.visible = false;
        dmgCounter = 0;
         
         add(_sprHealth);
         _sprHealth.scrollFactor.set(0.0);
         add(_txtjAmmo);
         _txtjAmmo.scrollFactor.set(0.0);
         add(_txtkAmmo);
         _txtkAmmo.scrollFactor.set(0.0);
         add(_healthbar);
         _healthbar.scrollFactor.set(0.0);
         add(_jWeapon);
         _jWeapon.scrollFactor.set(0.0);
         add(_kWeapon);
         _kWeapon.scrollFactor.set(0.0);
         add(_damage1);
         add(_damage2);
     }

     public function updateHUD(jAmmo:Int=0, kAmmo:Int=0, jReloading:Bool, kReloading:Bool, jName:String, kName:String):Void
     {  
        if(jName != "") {
            _jWeapon.loadGraphic(AssetPaths.IMAGE + jName + ".png");
        } else {
            _jWeapon.makeGraphic(1, 1, FlxColor.TRANSPARENT);
        }
        if(kName != "") {
            _kWeapon.loadGraphic(AssetPaths.IMAGE + kName + ".png");
        } else {
            _kWeapon.makeGraphic(1, 1, FlxColor.TRANSPARENT);
        }
        if(jReloading) {
            _txtjAmmo.text = "RELOADING";
            _txtjAmmo.size = 16;
        } else if(jAmmo < 0) {
            _txtjAmmo.text = "";
            _txtjAmmo.size = 24;
        } else {
            _txtjAmmo.text = Std.string(jAmmo);
            _txtjAmmo.size = 24;
        }
        if(kReloading) {
            _txtkAmmo.text = "RELOADING";
            _txtkAmmo.size = 16;
        } else if(kAmmo < 0) {
            _txtkAmmo.text = "";
            _txtkAmmo.size = 24;
        } else {
            _txtkAmmo.text = Std.string(kAmmo);
            _txtkAmmo.size = 24;
        }
     }

     public function updateXY():Void {
         _damage1.x = _player.x;
         _damage1.y = _player.y - 65;
         _damage2.x = _player.x;
         _damage2.y = _player.y - 40;
	 }

     public function updateDamage(damage:Float):Void {
        if(dmgCounter == 0) {
            _damage1.visible = true;
            _damage1.text = "- " + Std.string(damage);
            FlxTween.tween(_damage1, {alpha: 0}, .25, { ease: FlxEase.circOut, onComplete: finishFade });
            dmgCounter = 1;
        } else {
            _damage2.visible = true;
            _damage2.text = "- " + Std.string(damage);
            FlxTween.tween(_damage2, {alpha: 0}, .25, { ease: FlxEase.circOut, onComplete: finishFade });
            dmgCounter = 0;
        }
     }

     private function finishFade(_):Void {
         if(dmgCounter == 0) {
            _damage1.visible = false;
            FlxTween.tween(_damage1, {alpha: 1});
         } else {
            _damage2.visible = false;
            FlxTween.tween(_damage2, {alpha: 1});
         }
     }
}