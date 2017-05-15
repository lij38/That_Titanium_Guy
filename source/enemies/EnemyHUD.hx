package enemies;

 import flixel.FlxBasic;
 import flixel.FlxG;
 import flixel.FlxSprite;
 import flixel.group.FlxGroup.FlxTypedGroup;
 import flixel.text.FlxText;
 import flixel.util.FlxColor;
 import flixel.ui.FlxBar;
 import flixel.tweens.*;
 using flixel.util.FlxSpriteUtil;

class EnemyHUD extends FlxTypedGroup<FlxSprite>
{
    private var _enemy:Enemy;
    private var _healthbar:FlxBar;
    private var _damage1:FlxText;
    private var _damage2:FlxText;
    private var dmgCounter:Int;

    public function new(enemy:Enemy)
     {
         super();
         _enemy = enemy;

         //health bar
         var ewidth:Int = cast(_enemy.width, Int);
        _healthbar = new FlxBar(_enemy.x + 15, _enemy.y - 40, LEFT_TO_RIGHT, ewidth, 7, _enemy, "health", 0, _enemy.health);
        _healthbar.createFilledBar(FlxColor.TRANSPARENT, FlxColor.RED, true, FlxColor.BLACK);

        //damage
        _damage1 = new FlxText(_enemy.x + 30, _enemy.y - 50, 0, "1", 30);
        _damage1.setFormat(AssetPaths.FONT, _damage1.size, FlxColor.RED);
        _damage1.visible = false;
        _damage2 = new FlxText(_enemy.x + 30, _enemy.y - 50, 0, "2", 30);
        _damage2.setFormat(AssetPaths.FONT, _damage2.size, FlxColor.RED);
        _damage2.visible = false;
        dmgCounter = 0;
         
         add(_healthbar);
         add(_damage1);
         add(_damage2);
     }

     public function updateXY():Void {
         _damage1.x = _enemy.x;
         _damage1.y = _enemy.y - 65;
         _damage2.x = _enemy.x;
         _damage2.y = _enemy.y - 40;
         _healthbar.x = _enemy.x + 18;
         _healthbar.y = _enemy.y - 35;
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