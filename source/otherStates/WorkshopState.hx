package otherStates;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.group.FlxGroup.FlxTypedGroup;
import items.*;

class WorkshopState extends FlxState {
    private var jWeapon:ImageButton;
    private var kWeapon:ImageButton;
    private var j2ndWeapon:ImageButton;
    private var k2ndWeapon:ImageButton;
    private var j1:FlxText;
    private var k1:FlxText;
    private var j2:FlxText;
    private var k2:FlxText;
    private var jName:String;
    private var kName:String;
    private var j2Name:String;
    private var k2Name:String;
    private var config1:FlxText;
    private var config2:FlxText;
    private var title:FlxText;
    private var confirm:ImageButton;

    //weapon selection window
    private var sWindow:FlxSprite;
    private var wMask:FlxSprite;
    private var weapons:FlxTypedGroup<ImageButton>;
    private var rifle:ImageButton;
    private var shield:ImageButton;
    private var sword:ImageButton;
    private var curSelect:String;

    override public function create():Void {
        title = new FlxText(325, 15, 0, "Workshop", 35);
        title.setFormat(AssetPaths.FONT, title.size);
        add(title);
        // jName = Main.SAVE.data.jWeapon;
        // kName = Main.SAVE.data.kWeapon;
        // j2Name = Main.SAVE.data.j2ndWeapon;
        // kName = Main.SAVE.data.k2ndWeapon;
        //load the config1 weapon sprites
        config1 = new FlxText(190, 60, 0, "Configuration 1", 20);
        config1.setFormat(AssetPaths.FONT, config1.size);
        add(config1);
        jWeapon = new ImageButton(190, 100, jClick);
        kWeapon = new ImageButton(500, 100, kClick);
        add(jWeapon);
        add(kWeapon);
        j1 = new FlxText(265, 260, 0, "J", 25);
        j1.setFormat(AssetPaths.FONT, j1.size);
        add(j1);
        k1 = new FlxText(565, 260, 0, "K", 25);
        k1.setFormat(AssetPaths.FONT, k1.size);
        add(k1);

        //load the config2 weapon sprites
        config2 = new FlxText(190, 300, 0, "Configuration 2", 20);
        config2.setFormat(AssetPaths.FONT, config2.size);
        add(config2);
        j2ndWeapon = new ImageButton(190, 340, j2ndClick);
        k2ndWeapon = new ImageButton(500, 340, k2ndClick);
        add(j2ndWeapon);
        add(k2ndWeapon);
        j2 = new FlxText(265, 500, 0, "J", 25);
        j2.setFormat(AssetPaths.FONT, j2.size);
        add(j2);
        k2 = new FlxText(565, 500, 0, "K", 25);
        k2.setFormat(AssetPaths.FONT, k2.size);
        add(k2);

        //load the select panel
        sWindow = new FlxSprite(350, 100).makeGraphic(100, 400, FlxColor.BLACK);
        wMask = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
        add(wMask);
        wMask.alpha = 0;
        add(sWindow);
        sWindow.kill();
        curSelect = "";
        rifle = new ImageButton(375, 150, rifleClick);
        rifle.loadGraphic(AssetPaths.RIFLE);
        sword = new ImageButton(375, 225, swordClick);
        sword.loadGraphic(AssetPaths.SWORD);
        shield = new ImageButton(375, 300, shieldClick);
        shield.loadGraphic(AssetPaths.SHIELD);
        add(rifle);
        add(sword);
        add(shield);
        rifle.kill();
        sword.kill();
        shield.kill();

        //load the confirm button
        confirm = new ImageButton(390, 550, "CONFIRM", clickPlay);
        add(confirm);
    }

    override public function update(elapsed:Float):Void {
        super.update(elapsed);
        if(Main.SAVE.data.jWeapon == "") {
            jWeapon.makeGraphic(150, 150, FlxColor.BLUE);
        } else {
            jWeapon.loadGraphic(AssetPaths.IMAGE + Main.SAVE.data.jWeapon + "Button.png");
        }
        if(Main.SAVE.data.kWeapon == "") {
            kWeapon.makeGraphic(150, 150, FlxColor.BLUE);
        } else {
            kWeapon.loadGraphic(AssetPaths.IMAGE + Main.SAVE.data.kWeapon + "Button.png");
        }
        if(Main.SAVE.data.j2ndWeapon == "") {
            j2ndWeapon.makeGraphic(150, 150, FlxColor.BLUE);
        } else {
            j2ndWeapon.loadGraphic(AssetPaths.IMAGE + Main.SAVE.data.j2ndWeapon + "Button.png");
        }
        if(Main.SAVE.data.k2ndWeapon == "") {
            k2ndWeapon.makeGraphic(150, 150, FlxColor.BLUE);
        } else {
            k2ndWeapon.loadGraphic(AssetPaths.IMAGE + Main.SAVE.data.k2ndWeapon + "Button.png");
        }
    }

    private function clickPlay() {
        trace("clicked confirm button");
    }

    private function jClick() {
        trace("jClick");
        showSelect();
        curSelect = "j";
    }

    private function kClick() {
        trace("kClick");
        showSelect();
        curSelect = "k";
    }

    private function j2ndClick() {
        trace("j2ndClick");
        showSelect();
        curSelect = "j2";
    }

    private function k2ndClick() {
        trace("k2ndClick");
        showSelect();
        curSelect = "k2";
    }

    private function showSelect() {
        sWindow.revive();
        rifle.revive();
        sword.revive();
        shield.revive();
        wMask.alpha = 0.75;
    }

    private function rifleClick() {
        if(curSelect == "j") {
            Main.SAVE.data.jWeapon = "rifle";
        } else if(curSelect == "k") {
            Main.SAVE.data.kWeapon = "rifle";
        } else if(curSelect == "j2") {
            Main.SAVE.data.j2ndWeapon = "rifle";
        } else {
            Main.SAVE.data.k2ndWeapon = "rifle";
        }
        noShowSelect();
    }

    private function swordClick() {
        if(curSelect == "j") {
            Main.SAVE.data.jWeapon = "sword";
        } else if(curSelect == "k") {
            Main.SAVE.data.kWeapon = "sword";
        } else if(curSelect == "j2") {
            Main.SAVE.data.j2ndWeapon = "sword";
        } else {
            Main.SAVE.data.k2ndWeapon = "sword";
        }
        noShowSelect();
    }

    private function shieldClick() {
        if(curSelect == "j") {
            Main.SAVE.data.jWeapon = "shield";
        } else if(curSelect == "k") {
            Main.SAVE.data.kWeapon = "shield";
        } else if(curSelect == "j2") {
            Main.SAVE.data.j2ndWeapon = "shield";
        } else {
            Main.SAVE.data.k2ndWeapon = "shield";
        }
        noShowSelect();
    }

    private function noShowSelect() {
        sWindow.kill();
        rifle.kill();
        sword.kill();
        shield.kill();
        wMask.alpha = 0;
    }
}