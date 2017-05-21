package otherStates;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import levelStates.*;
import flixel.util.FlxColor;
import flixel.tile.FlxTilemap;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.tile.FlxBaseTilemap;
import flixel.addons.editors.tiled.TiledObjectLayer;
import flixel.FlxG;
import flixel.addons.editors.tiled.TiledMap;

class MapState extends FlxState
{
    private var _map:TiledMap;
    private var _bg:FlxTilemap;
    private var _tutorial:FlxButton;
    private var _level1:FlxButton;
    private var _level1boss:FlxButton;
    private var _level2:FlxButton;
    private var _level3:FlxButton;
    private var _level4:FlxButton;
    private var _level5:FlxButton;
    private var _home:FlxButton;
    private var _levelarr:Array<FlxButton>;
    private var _level_index:Int;
    override public function create():Void
    {

        _map = new TiledMap(AssetPaths.levelmap__tmx);
        _bg = new FlxTilemap();
        _bg.loadMapFromArray(cast(_map.getLayer("background"), TiledTileLayer).tileArray, _map.width, _map.height, 
            AssetPaths.levelmap__png, _map.tileWidth, _map.tileHeight, FlxTilemapAutoTiling.OFF, 1, 1, 1);
        add(_bg);
        _bg.follow();

        var level:Int = Main.SAVE.data.levelCompleted + 1;

        _levelarr = new Array<FlxButton>();
        _tutorial = new FlxButton(0, 0, tutorialOnClick);
        _level1 = new FlxButton(0, 0, level1OnClick);
        _level1boss = new FlxButton(0, 0, level1bossOnClick);
        _level2 = new FlxButton();
        _level3 = new FlxButton();
        _level4 = new FlxButton();
        _level5 = new FlxButton();
        _home = new FlxButton(0, 0, switchHomeState);
        _levelarr.push(_tutorial);
        _levelarr.push(_level1);
        _levelarr.push(_level1boss);
        _levelarr.push(_level2);
        _levelarr.push(_level3);
        _levelarr.push(_level4);
        _levelarr.push(_level5);
        _level_index = 0;

        _home.loadGraphic(AssetPaths.shield_imageicon__png, false, 65, 65);

        // unlocked states
        for (i in 0...level) {
             _levelarr[i].active = true;
            // BOSS Level
            if (i == 2) {
                _levelarr[i].loadGraphic(AssetPaths.star_red__png, false, 50, 50);
            } else {
                _levelarr[i].loadGraphic(AssetPaths.star_yellow__png, false, 50, 50);
            }
        }

        // locked states
        for (i in level..._levelarr.length) {
            _levelarr[i].active = false;
            if (i == 2) {
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
            var icon:FlxButton = _levelarr[_level_index];
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
}