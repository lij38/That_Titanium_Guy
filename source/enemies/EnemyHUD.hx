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
    private var _damage3:FlxText;
    private var _damage4:FlxText;
	private var _xOffset1:Float = Math.random() * 10 - 5;
	private var _xOffset2:Float = Math.random() * 10 - 5;
	private var _xOffset3:Float = Math.random() * 10 - 5;
	private var _xOffset4:Float = Math.random() * 10 - 5;
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
		_damage3 = new FlxText(_enemy.x + 30, _enemy.y - 50, 0, "3", 30);
        _damage3.setFormat(AssetPaths.FONT, _damage3.size, FlxColor.RED);
        _damage3.visible = false;
		_damage4 = new FlxText(_enemy.x + 30, _enemy.y - 50, 0, "4", 30);
        _damage4.setFormat(AssetPaths.FONT, _damage3.size, FlxColor.RED);
        _damage4.visible = false;
        dmgCounter = 0;
         
         add(_healthbar);
         add(_damage1);
         add(_damage2);
         add(_damage3);
         add(_damage4);
     }

     public function updateXY():Void {
        _damage1.x = _enemy.x + _xOffset1;
         _damage2.x = _enemy.x + _xOffset2;
         _damage3.x = _enemy.x + _xOffset3;
         _damage4.x = _enemy.x + _xOffset4;
         _healthbar.x = _enemy.x + 18;
         _healthbar.y = _enemy.y - 35;
	 }

     public function updateDamage(damage:Float):Void {
        var dstr:String = Std.string(damage);
        if(damage < 1) {
            dstr = dstr.substring(0, 3);
        }
        if (dmgCounter == 0) {
            _damage1.visible = true;
			_damage1.y = _enemy.y - 55;
            _damage1.text = "- " + Std.string(damage);
            FlxTween.tween(_damage1, {alpha: 0.5, y: _damage1.y - 25 }, 
				.5, { ease: FlxEase.circOut, onComplete: finishFade.bind(_, dmgCounter) });
        } else if (dmgCounter == 1) {
			_damage2.y = _enemy.y - 45;
            _damage2.visible = true;
            _damage2.text = "- " + Std.string(damage);
            FlxTween.tween(_damage2, {alpha: 0.5, y: _damage2.y - 25}, 
				.5, { ease: FlxEase.circOut, onComplete: finishFade.bind(_, dmgCounter) });
        } else if (dmgCounter == 2) {
			_damage3.y = _enemy.y - 40;
            _damage3.visible = true;
            _damage3.text = "- " + Std.string(damage);
            FlxTween.tween(_damage3, {alpha: 0.5, y: _damage3.y - 25}, 
				.5, { ease: FlxEase.circOut, onComplete: finishFade.bind(_, dmgCounter) });
        } else {
			_damage4.y = _enemy.y - 35;
            _damage4.visible = true;
            _damage4.text = "- " + Std.string(damage);
            FlxTween.tween(_damage4, {alpha: 0.5, y: _damage4.y - 25}, 
				.5, { ease: FlxEase.circOut, onComplete: finishFade.bind(_, dmgCounter) });
        }
		dmgCounter = (dmgCounter + 1) % 4;
     }

    private function finishFade(_, dc:Int):Void {
         if (dc == 0) {
            _damage1.visible = false;
            _damage1.alpha = 1;
			_xOffset1 = getRandomOffset();
         } else if (dc == 1) {
            _damage2.visible = false;
            _damage2.alpha = 1;
			_xOffset2 = getRandomOffset();
         } else if (dc == 2) {
            _damage3.visible = false;
            _damage3.alpha = 1;
			_xOffset3 = getRandomOffset();
         } else {
            _damage4.visible = false;
            _damage4.alpha = 1;
			_xOffset4 = getRandomOffset();
         }
     }
	 
	 private function getRandomOffset():Float {
		return Math.random() * 10 - 5;
	 }
}