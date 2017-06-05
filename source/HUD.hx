package ;
 import flixel.FlxBasic;
 import flixel.FlxG;
 import flixel.FlxSprite;
 import flixel.group.FlxGroup.FlxTypedGroup;
 import flixel.text.FlxText;
 import flixel.util.FlxColor;
 import flixel.ui.FlxBar;
 import flixel.tweens.*;
 import flixel.util.FlxStringUtil;
 import items.Daze;
 using flixel.util.FlxSpriteUtil;

class HUD extends FlxTypedGroup<FlxSprite> {
    private var _player:Player;
    private var _sprHealth:FlxSprite;
	private var _moneySprite:FlxSprite;
	private var _money:FlxText;
    private var _potion:FlxSprite;
    private var _potionNum:FlxText;
    private var _txtjAmmo:FlxText;
    private var _txtkAmmo:FlxText;
    private var _healthbar:FlxBar;
	private var _jetpackBar:FlxBar;
    private var _jWeapon:FlxSprite;
    private var _kWeapon:FlxSprite;
    private var _damage1:FlxText;
    private var _damage2:FlxText;
    private var _damage3:FlxText;
    private var _damage4:FlxText;
	private var _xOffset1:Float = Math.random() * 10 - 5;
	private var _xOffset2:Float = Math.random() * 10 - 5;
	private var _xOffset3:Float = Math.random() * 10 - 5;
	private var _xOffset4:Float = Math.random() * 10 - 5;
    private var dmgCounter:Int;
	
	private var _daze:Daze;
	private var _dazeTime:Float = 0.5;
	private var _dazeTimer:Float = -1;

    public function new(player:Player) {
         super();
         _player = player;
        //ammo
        _txtjAmmo = new FlxText(FlxG.width - 230, 55, 0, "", 24);
        _txtkAmmo = new FlxText(FlxG.width - 115, 55, 0, "", 24);
        _txtjAmmo.setFormat(AssetPaths.FONT, _txtjAmmo.size);
        _txtkAmmo.setFormat(AssetPaths.FONT, _txtkAmmo.size);
		_txtjAmmo.setBorderStyle(SHADOW, FlxColor.GRAY);
		_txtkAmmo.setBorderStyle(SHADOW, FlxColor.GRAY);
		
		// daze
		_daze = new Daze();
		_daze.visible = false;

         //health icon
         _sprHealth = new FlxSprite(35, 4, AssetPaths.health__png);

         //health bar
        _healthbar = new FlxBar(60, 4, LEFT_TO_RIGHT, 370, 20, _player, "health", 0, _player.health);
        _healthbar.createFilledBar(FlxColor.TRANSPARENT, FlxColor.RED, true, FlxColor.BLACK);
		
		// money icon
		_moneySprite = new FlxSprite(430, 13);
		_moneySprite.loadGraphic(AssetPaths.coins__png, true, 45, 48);
		_moneySprite.animation.add("spin", [0, 1, 2, 3, 4, 5, 6, 7], 6, true);
		_moneySprite.animation.play("spin");
		_moneySprite.scale.set(0.3, 0.3);
		// money
		var moneyText:String = FlxStringUtil.formatMoney(_player.money, false, true);
		_money = new FlxText(462, 18, 0, moneyText, 20);
		_money.setFormat(AssetPaths.FONT, _money.size, FlxColor.YELLOW);
		_money.setBorderStyle(SHADOW, FlxColor.GRAY);

        //Potion icon
        _potion = new FlxSprite(427, -17);
        _potion.loadGraphic(AssetPaths.healthPotion__png, true, 50, 63);
        _potion.animation.add("aroma", [0, 1, 2, 3, 4, 5, 6], 6, true);
        _potion.animation.play("aroma");
        _potion.scale.set(0.27, 0.27);
        //potion number
        _potionNum = new FlxText(462, -6, 0, Std.string(_player.potionCount), 23);
        _potionNum.setFormat(AssetPaths.FONT, _potionNum.size, FlxColor.RED);
		
		//jetpack bar
		_jetpackBar = new FlxBar(60, 29, LEFT_TO_RIGHT, 370, 10, _player,
									"jetpackField", 0, _player.jetpackFieldMax);
		_jetpackBar.createFilledBar(FlxColor.TRANSPARENT, FlxColor.CYAN, true, FlxColor.BLACK);
		
        //weapons
        _jWeapon = new FlxSprite(_txtjAmmo.x + 20, 4);
        _kWeapon = new FlxSprite(_txtkAmmo.x + 20, 4);

        //damage
        _damage1 = new FlxText(_player.x + 30, _player.y - 50, 0, "1", 30);
        _damage1.setFormat(AssetPaths.FONT, _damage1.size, FlxColor.RED);
		_damage1.setBorderStyle(SHADOW, FlxColor.GRAY);
        _damage1.visible = false;
        _damage2 = new FlxText(_player.x + 30, _player.y - 50, 0, "2", 30);
        _damage2.setFormat(AssetPaths.FONT, _damage2.size, FlxColor.RED);
		_damage2.setBorderStyle(SHADOW, FlxColor.GRAY);
        _damage2.visible = false;
		_damage3 = new FlxText(_player.x + 30, _player.y - 50, 0, "3", 30);
        _damage3.setFormat(AssetPaths.FONT, _damage3.size, FlxColor.RED);
		_damage3.setBorderStyle(SHADOW, FlxColor.GRAY);
        _damage3.visible = false;
		_damage4 = new FlxText(_player.x + 30, _player.y - 50, 0, "4", 30);
        _damage4.setFormat(AssetPaths.FONT, _damage3.size, FlxColor.RED);
		_damage4.setBorderStyle(SHADOW, FlxColor.GRAY);
        _damage4.visible = false;
        dmgCounter = 0;
         
         add(_sprHealth);
         _sprHealth.scrollFactor.set(0.0);
		 add(_moneySprite);
		 _moneySprite.scrollFactor.set(0.0);
		 add(_money);
		 _money.scrollFactor.set(0.0);
         add(_potion);
         _potion.scrollFactor.set(0.0);
         add(_potionNum);
         _potionNum.scrollFactor.set(0.0);
         add(_txtjAmmo);
         _txtjAmmo.scrollFactor.set(0.0);
         add(_txtkAmmo);
         _txtkAmmo.scrollFactor.set(0.0);
         add(_healthbar);
         _healthbar.scrollFactor.set(0.0);
		 add(_jetpackBar);
		 _jetpackBar.scrollFactor.set(0.0);
         add(_jWeapon);
         _jWeapon.scrollFactor.set(0.0);
         add(_kWeapon);
         _kWeapon.scrollFactor.set(0.0);
         add(_damage1);
         add(_damage2);
         add(_damage3);
         add(_damage4);
		 add(_daze);
    }
	
	override public function update(elapsed:Float) {
		if (_dazeTimer >= 0.0) {
			_dazeTimer += elapsed;
			_daze.x = _player.getMidpoint().x - (_daze.width / 2);
			_daze.y = _player.y - 50;
		}
		if (_dazeTimer > _dazeTime) {
			_dazeTimer = -1;
			_daze.visible = false;
		}
		super.update(elapsed);
	}
	
	public function startDaze(t:Float = 0.5) {
		_daze.visible = true;
		_dazeTime = t;
		_dazeTimer = 0.0;
		_daze.x = _player.getMidpoint().x - (_daze.width / 2);
		_daze.y = _player.y - 50;
	}

    public function updateHUD(jAmmo:Int = 0, kAmmo:Int = 0, jReloading:Bool, 
								kReloading:Bool, jName:String, kName:String):Void {  
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
            _txtjAmmo.text = Std.string(jAmmo) + " / inf";
            _txtjAmmo.size = 24;
        }
        if(kReloading) {
            _txtkAmmo.text = "RELOADING";
            _txtkAmmo.size = 16;
        } else if(kAmmo < 0) {
            _txtkAmmo.text = "";
            _txtkAmmo.size = 24;
        } else {
            _txtkAmmo.text = Std.string(kAmmo) + " / " + "inf";
            _txtkAmmo.size = 24;
        }
		_money.text = FlxStringUtil.formatMoney(_player.money, false, true);
        _potionNum.text = Std.string(_player.potionCount);
     }

     public function updateXY():Void {
         _damage1.x = _player.x + _xOffset1;
         _damage2.x = _player.x + _xOffset2;
         _damage3.x = _player.x + _xOffset3;
         _damage4.x = _player.x + _xOffset4;
	 }

    public function updateDamage(damage:Float):Void {
        if (dmgCounter == 0) {
            _damage1.visible = true;
			_damage1.y = _player.y - 55;
            _damage1.text = "- " + Std.string(damage);
            FlxTween.tween(_damage1, {alpha: 0.5, y: _damage1.y - 25 }, 
				.5, { ease: FlxEase.circOut, onComplete: finishFade.bind(_, dmgCounter) });
        } else if (dmgCounter == 1) {
			_damage2.y = _player.y - 45;
            _damage2.visible = true;
            _damage2.text = "- " + Std.string(damage);
            FlxTween.tween(_damage2, {alpha: 0.5, y: _damage2.y - 25}, 
				.5, { ease: FlxEase.circOut, onComplete: finishFade.bind(_, dmgCounter) });
        } else if (dmgCounter == 2) {
			_damage3.y = _player.y - 40;
            _damage3.visible = true;
            _damage3.text = "- " + Std.string(damage);
            FlxTween.tween(_damage3, {alpha: 0.5, y: _damage3.y - 25}, 
				.5, { ease: FlxEase.circOut, onComplete: finishFade.bind(_, dmgCounter) });
        } else {
			_damage4.y = _player.y - 35;
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