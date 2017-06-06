package otherStates;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import levelStates.*;
import items.*;
import flixel.util.FlxColor;
import flixel.tile.FlxTilemap;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.tile.FlxBaseTilemap;
import flixel.addons.editors.tiled.TiledObjectLayer;
import flixel.FlxG;
import flixel.addons.editors.tiled.TiledMap;
import flixel.FlxSprite;

class MapState extends FlxState
{
    private var _map:TiledMap;
    private var _bg:FlxTilemap;
    private var _tutorial:ImageButton;
    private var _level1:ImageButton;
    private var _level1boss:ImageButton;
    private var _level2:ImageButton;
    private var _level2boss:ImageButton;
    private var _level3:ImageButton;
    private var _level4:ImageButton;
    private var _level5:ImageButton;
    private var _home:ImageButton;
    private var _levelarr:Array<ImageButton>;
    private var _level_index:Int;
    private var _stararr:Array<FlxSprite>;
    override public function create():Void
    {

        _map = new TiledMap(AssetPaths.levelmap__tmx);
        _bg = new FlxTilemap();
        _bg.loadMapFromArray(cast(_map.getLayer("background"), TiledTileLayer).tileArray, _map.width, _map.height, 
            AssetPaths.levelmap__png, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 1, 1, 1);
        add(_bg);
        _bg.follow();

        var level:Int = Main.SAVE.data.levelCompleted + 1;

        _levelarr = new Array<ImageButton>();
        _tutorial = new ImageButton(0, 0, tutorialOnClick);
        _level1 = new ImageButton(0, 0, level1OnClick);
        _level1boss = new ImageButton(0, 0, level1bossOnClick);
        _level2 = new ImageButton(0, 0, level2OnClick);
        _level2boss = new ImageButton(0, 0, level2bossOnClick);
        _level3 = new ImageButton(0, 0, level3OnClick);
        _level4 = new ImageButton(0, 0, level4OnClick);
        _level5 = new ImageButton(0, 0, level5OnClick);
        _home = new ImageButton(0, 0, switchHomeState);
        _levelarr.push(_tutorial);
        _levelarr.push(_level1);
        _levelarr.push(_level1boss);
        _levelarr.push(_level2);
        _levelarr.push(_level3);
        _levelarr.push(_level2boss);
        _levelarr.push(_level4);
        _levelarr.push(_level5);
        _level_index = 0;

        _home.loadGraphic(AssetPaths.shield_imageicon__png, false, 65, 65);

        _stararr = new Array<FlxSprite>();
        var tmpMap2:TiledObjectLayer = cast _map.getLayer("stars");
         for (e in tmpMap2.objects)
         {
             placeStars(e.type, e.xmlData.x);
         }

         for (i in 0...(level - 1)) {
			 if (Main.SAVE.data.stararr != null) {
				var rating:Int = Main.SAVE.data.stararr[i];
				if (rating == 3) {
					_stararr[i].loadGraphic(AssetPaths.threeStar2__png, false, 80, 30);
				} else if (rating == 2) {
					_stararr[i].loadGraphic(AssetPaths.twoStar2__png, false, 80, 30);
				} else {
					_stararr[i].loadGraphic(AssetPaths.oneStar2__png, false, 80, 30);
				}
				add(_stararr[i]);
			 }
         }

        // unlocked states
        for (i in 0...level) {
             _levelarr[i].active = true;
            // BOSS Level
            if (i == 2 || i == 5) {
                _levelarr[i].loadGraphic(AssetPaths.star_red__png, false, 50, 50);
            } else {
                _levelarr[i].loadGraphic(AssetPaths.star_yellow__png, false, 50, 50);
            }
        }

        // locked states
        for (i in level..._levelarr.length) {
            _levelarr[i].active = false;
            if (i == 2 || i == 5) {
                _levelarr[i].loadGraphic(AssetPaths.star_red_lock__png, false, 50, 50);
            } else {
                _levelarr[i].loadGraphic(AssetPaths.star_yellow_lock__png, false, 50, 50);
            }
        }

        for (level in _levelarr) {
            add(level);
        }
        add(_home);


        var tmpMap:TiledObjectLayer = cast _map.getLayer("entities");
         for (e in tmpMap.objects)
         {
             placeEntities(e.type, e.xmlData.x);
         }

        super.create();
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
    }

    private function placeEntities(entityName:String, entityData:Xml):Void
    {
        var x:Int = Std.parseInt(entityData.get("x"));
        var y:Int = Std.parseInt(entityData.get("y"));

        if (entityName == "home") {
            _home.x = x;
            _home.y = y;
        } else {
            var icon:ImageButton = _levelarr[_level_index];
            _level_index++;
            icon.x = x;
            icon.y = y;
        }
    }

    private function tutorialOnClick():Void {
        FlxG.camera.fade(FlxColor.BLACK,.25, false, function() {
            FlxG.switchState(new TutorialState());
        });
    }

    private function switchHomeState():Void {
        FlxG.camera.fade(FlxColor.BLACK,.25, false, function() {
            FlxG.switchState(new HomeState());
        });
    }

    private function level1OnClick():Void {
        FlxG.camera.fade(FlxColor.BLACK,.25, false, function() {
            FlxG.switchState(new Level1State());
        });
    }

    private function level1bossOnClick():Void {
        FlxG.camera.fade(FlxColor.BLACK,.25, false, function() {
            FlxG.switchState(new Boss1State());
        });
    }

    private function level2OnClick():Void {
        FlxG.camera.fade(FlxColor.BLACK,.25, false, function() {
            FlxG.switchState(new Level2State());
        });
    }

    private function level2bossOnClick():Void {
        FlxG.camera.fade(FlxColor.BLACK,.25, false, function() {
            FlxG.switchState(new Boss2State());
        });
    }

    private function level3OnClick():Void {
        FlxG.camera.fade(FlxColor.BLACK,.25, false, function() {
            FlxG.switchState(new Level3State());
        });
    }

    private function level4OnClick():Void {
        FlxG.camera.fade(FlxColor.BLACK,.25, false, function() {
            FlxG.switchState(new Level4State());
        });
    }

    private function level5OnClick():Void {
        FlxG.camera.fade(FlxColor.BLACK,.25, false, function() {
            FlxG.switchState(new Level5State());
        });
    }

    private function placeStars(entityName:String, entityData:Xml):Void
    {
        var x:Int = Std.parseInt(entityData.get("x"));
        var y:Int = Std.parseInt(entityData.get("y"));
        var star:FlxSprite = new FlxSprite(x, y);
        _stararr.push(star);
    }
}