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
    private var rifleT:FlxText;
    private var shield:ImageButton;
    private var shieldT:FlxText;
    private var sword:ImageButton;
    private var swordT:FlxText;
    private var curSelect:String;

    //tutorial
    private var tWindow:FlxSprite;
    private var tText:FlxText;
    private var tButton:FlxButton;
    private var inTut:Bool;

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
        jWeapon.loadGraphic(AssetPaths.emptyslot__png);
        kWeapon.loadGraphic(AssetPaths.emptyslot__png);
        add(jWeapon);
        add(kWeapon);
        j1 = new FlxText(240, 260, 0, "J SLOT", 25);
        j1.setFormat(AssetPaths.FONT, j1.size);
        add(j1);
        k1 = new FlxText(540, 260, 0, "K SLOT", 25);
        k1.setFormat(AssetPaths.FONT, k1.size);
        add(k1);

        //load the config2 weapon sprites
        config2 = new FlxText(190, 300, 0, "Configuration 2", 20);
        config2.setFormat(AssetPaths.FONT, config2.size);
        add(config2);
        j2ndWeapon = new ImageButton(190, 340, j2ndClick);
        k2ndWeapon = new ImageButton(500, 340, k2ndClick);
        j2ndWeapon.loadGraphic(AssetPaths.emptyslot__png);
        k2ndWeapon.loadGraphic(AssetPaths.emptyslot__png);
        add(j2ndWeapon);
        add(k2ndWeapon);
        j2 = new FlxText(240, 500, 0, "J2 SLOT", 25);
        j2.setFormat(AssetPaths.FONT, j2.size);
        add(j2);
        k2 = new FlxText(540, 500, 0, "K2 SLOT", 25);
        k2.setFormat(AssetPaths.FONT, k2.size);
        add(k2);

        //load the confirm button
        confirm = new ImageButton(300, 550, "CONFIRM", clickPlay);
        confirm.loadGraphic(AssetPaths.confirm__png, false, 200, 40);
        add(confirm);

        //load the select panel
        loadSP();

        //music
        if(FlxG.sound.music.playing == false) {
		 	FlxG.sound.playMusic(AssetPaths.dramatic__mp3);
		}

        //tutorial
        if(Main.SAVE.data.wsTut == null || Main.SAVE.data.wsTut == false) {
            tutorial();
            confirm.kill();
        }
    }

    override public function update(elapsed:Float):Void {
        super.update(elapsed);
        if(FlxG.keys.anyJustPressed([ENTER])) {
            if(inTut) {
                killTut();
            } else {
                clickPlay();
            }
        }
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
        var curConfig:String = "";
        if(Main.SAVE.data.jWeapon == "sword" && Main.SAVE.data.kWeapon == "shield" ||
			Main.SAVE.data.kWeapon == "sword" && Main.SAVE.data.jWeapon == "shield") {
			curConfig = "swsh";
		} else if(Main.SAVE.data.jWeapon == "rifle" && Main.SAVE.data.kWeapon == "shield" ||
				Main.SAVE.data.kWeapon == "rifle" && Main.SAVE.data.jWeapon == "shield"){
			curConfig = "rsh";
		} else if(Main.SAVE.data.jWeapon == "sword" && Main.SAVE.data.kWeapon == "rifle" ||
				Main.SAVE.data.kWeapon == "sword" && Main.SAVE.data.jWeapon == "rifle") {
			curConfig = "swr";
		} else if(Main.SAVE.data.jWeapon == "sword" && Main.SAVE.data.kWeapon == "sword") {
			curConfig = "ds";
		} else if(Main.SAVE.data.jWeapon == "rifle" && Main.SAVE.data.kWeapon == "rifle") {
			curConfig = "dr";
		}
        Main.SAVE.data.curConfig = curConfig;
        Main.SAVE.flush();
        FlxG.camera.fade(FlxColor.BLACK,.25, false, function() {
			FlxG.switchState(new HomeState());
		});
    }

    private function loadSP() {
        sWindow = new FlxSprite(100, 10).makeGraphic(600, 590, FlxColor.BLACK);
        wMask = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
        add(wMask);
        wMask.alpha = 0;
        add(sWindow);
        curSelect = "";
        //rifle
        rifle = new ImageButton(100, 15, rifleClick);
        rifle.loadGraphic(AssetPaths.riflebm__png);
        add(rifle);
        rifleT = new FlxText(200, 15, 500);
        rifleT.text = "\t           The Standard Issue \n"
            + "The Old Federal Army's standard fully-automatic weapon \n"
            + "\"look at that G.I. with his S.I.\"";
        rifleT.setFormat(AssetPaths.FONT, 20);
        add(rifleT);
        //sword
        sword = new ImageButton(100, 140, swordClick);
        sword.loadGraphic(AssetPaths.swordbm__png);
        add(sword);
        swordT = new FlxText(200, 140, 500);
        swordT.text = "\t           The Glower \n"
            + "A fine piece of weaponry made with the matrimony of titanium and energy \n"
            + "\"They say the glowing Glower glowers at the enemy.\"";
        swordT.setFormat(AssetPaths.FONT, 20);
        add(swordT);
        //shield
        shield = new ImageButton(100, 265, shieldClick);
        shield.loadGraphic(AssetPaths.shieldbm__png);
        add(shield);
        shieldT = new FlxText(200, 265, 500);
        shieldT.text = "\t           The Cower \n"
            + "The shield that saved countless line infantrymen's lives back in the Great Wars \n"
            + "\"Not all who cower behind The Cower are cowards.\"";
        shieldT.setFormat(AssetPaths.FONT, 20);
        add(shieldT);
        noShowSelect();
    }

    private function tutorial() {
        wMask.alpha = 0.75;
        // tWindow = new FlxSprite(100, 50).makeGraphic(600, 500, FlxColor.BLACK);
        // add(tWindow);
        tText = new FlxText(110, 50, 580);
        tText.text = "Welcome to the workshop! Here you can customize your weapon configurations. \n"
            + "Your currrent configurations are displayed here right now. \n"
            + "Click on a slot to choose the weapon that you want to equip for that slot. \n"
            + "You can even DUAL WIELD, try double swords!";
        tText.setFormat(AssetPaths.FONT, 35);
        add(tText);
        inTut = true;
        tButton = new ImageButton(300, 550, killTut);
        tButton.loadGraphic(AssetPaths.next__png, false, 200, 40);
        add(tButton);
        Main.SAVE.data.wsTut = true;
    }

    private function killTut() {
        wMask.alpha = 0.0;
        //tWindow.destroy();
        tText.destroy();
        tButton.destroy();
        confirm.revive();
        inTut = false;
    }

    private function jClick() {
        showSelect();
        curSelect = "j";
    }

    private function kClick() {
        showSelect();
        curSelect = "k";
    }

    private function j2ndClick() {
        showSelect();
        curSelect = "j2";
    }

    private function k2ndClick() {
        showSelect();
        curSelect = "k2";
    }

    private function showSelect() {
        sWindow.revive();
        rifle.revive();
        sword.revive();
        shield.revive();
        rifleT.revive();
        swordT.revive();
        shieldT.revive();
        wMask.alpha = 0.75;
        confirm.kill();
        jWeapon.kill();
        kWeapon.kill();
        j2ndWeapon.kill();
        k2ndWeapon.kill();
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
            if(Main.SAVE.data.kWeapon != "shield") {
                Main.SAVE.data.jWeapon = "shield";
            }
        } else if(curSelect == "k") {
            if(Main.SAVE.data.jWeapon != "shield") {
                Main.SAVE.data.kWeapon = "shield";
            }
        } else if(curSelect == "j2") {
            if(Main.SAVE.data.k2ndWeapon != "shield") {
                Main.SAVE.data.j2ndWeapon = "shield";
            }
        } else if(curSelect == "k2"){
            if(Main.SAVE.data.j2ndWeapon != "shield") {
                Main.SAVE.data.k2ndWeapon = "shield";
            }
        }
        noShowSelect();
    }

    private function noShowSelect() {
        sWindow.kill();
        rifle.kill();
        sword.kill();
        shield.kill();
        rifleT.kill();
        swordT.kill();
        shieldT.kill();
        wMask.alpha = 0;
        confirm.revive();
        jWeapon.revive();
        kWeapon.revive();
        j2ndWeapon.revive();
        k2ndWeapon.revive();
    }
}