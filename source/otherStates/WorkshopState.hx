package otherStates;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.group.FlxGroup.FlxTypedGroup;
import animation.*;
import items.*;
import levelStates.*;

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
    private var cancel:ImageButton;
    private var next:ImageButton;
    private var _level:Int;

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
    private var shotgun:ImageButton;
    private var shotgunT:FlxText;
    private var revolver:ImageButton;
    private var revolverT:FlxText;
    private var sgshow:Bool;
    private var rvshow:Bool;
    private var curSelect:String;

    //tutorial
    private var tWindow:FlxSprite;
    private var tText:FlxText;
    private var tButton:FlxButton;
    private var inTut:Bool;

    override public function create():Void {
        _level = Main.SAVE.data.curLevel;
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
        j1 = new FlxText(220, 260, 0, "J SLOT", 25);
        j1.setFormat(AssetPaths.FONT, j1.size);
        add(j1);
        k1 = new FlxText(520, 260, 0, "K SLOT", 25);
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
        j2 = new FlxText(220, 500, 0, "J2 SLOT", 25);
        j2.setFormat(AssetPaths.FONT, j2.size);
        add(j2);
        k2 = new FlxText(520, 500, 0, "K2 SLOT", 25);
        k2.setFormat(AssetPaths.FONT, k2.size);
        add(k2);

        //load the confirm button
        confirm = new ImageButton(200, 550, "CONFIRM", clickPlay);
        confirm.loadGraphic(AssetPaths.confirm__png, false, 200, 40);
        add(confirm);

        //load the next level button
        next = new ImageButton(400, 550, "next", clickNext);
        next.loadGraphic(AssetPaths.nextlevel__png);
        add(next);

        //show shotgun or not
        if(Main.SAVE.data.levelCompleted >= 6) {
            sgshow = true;
        } else {
            sgshow = false;
        }
        //show revolver or not
        if( Main.SAVE.data.levelCompleted >= 4) {
            rvshow = true;
        } else {
            rvshow = false;
        }

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
        Main.LOGGER.logLevelStart(0);
        super.create();
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
            jWeapon.loadGraphic(AssetPaths.emptyslot__png);
        } else {
            jWeapon.loadGraphic(AssetPaths.IMAGE + Main.SAVE.data.jWeapon + "Button.png");
        }
        if(Main.SAVE.data.kWeapon == "") {
            kWeapon.loadGraphic(AssetPaths.emptyslot__png);
        } else {
            kWeapon.loadGraphic(AssetPaths.IMAGE + Main.SAVE.data.kWeapon + "Button.png");
        }
        if(Main.SAVE.data.j2ndWeapon == "") {
            j2ndWeapon.loadGraphic(AssetPaths.emptyslot__png);
        } else {
            j2ndWeapon.loadGraphic(AssetPaths.IMAGE + Main.SAVE.data.j2ndWeapon + "Button.png");
        }
        if(Main.SAVE.data.k2ndWeapon == "") {
            k2ndWeapon.loadGraphic(AssetPaths.emptyslot__png);
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
		} else if(Main.SAVE.data.jWeapon == "shotgun" && Main.SAVE.data.kWeapon == "shotgun") {
			curConfig = "dsg";
		} else if(Main.SAVE.data.jWeapon == "revolver" && Main.SAVE.data.kWeapon == "revolver") {
			curConfig = "drv";
		} else if(Main.SAVE.data.jWeapon == "rifle" && Main.SAVE.data.kWeapon == "shotgun" ||
				Main.SAVE.data.kWeapon == "rifle" && Main.SAVE.data.jWeapon == "shotgun") {
			curConfig = "rsg";
		} else if(Main.SAVE.data.jWeapon == "rifle" && Main.SAVE.data.kWeapon == "revolver" ||
				Main.SAVE.data.kWeapon == "rifle" && Main.SAVE.data.jWeapon == "revolver") {
			curConfig = "rrv";
		} else if(Main.SAVE.data.jWeapon == "shotgun" && Main.SAVE.data.kWeapon == "revolver" ||
				Main.SAVE.data.kWeapon == "shotgun" && Main.SAVE.data.jWeapon == "revolver") {
			curConfig = "sgrv";
		} else if(Main.SAVE.data.jWeapon == "shotgun" && Main.SAVE.data.kWeapon == "shield" ||
				Main.SAVE.data.kWeapon == "shotgun" && Main.SAVE.data.jWeapon == "shield"){
			curConfig = "sgsh";
		} else if(Main.SAVE.data.jWeapon == "revolver" && Main.SAVE.data.kWeapon == "shield" ||
				Main.SAVE.data.kWeapon == "revolver" && Main.SAVE.data.jWeapon == "shield"){
			curConfig = "rvsh";
		} else if(Main.SAVE.data.jWeapon == "sword" && Main.SAVE.data.kWeapon == "shotgun" ||
				Main.SAVE.data.kWeapon == "sword" && Main.SAVE.data.jWeapon == "shotgun") {
			curConfig = "swsg";
		} else if(Main.SAVE.data.jWeapon == "sword" && Main.SAVE.data.kWeapon == "revolver" ||
				Main.SAVE.data.kWeapon == "sword" && Main.SAVE.data.jWeapon == "revolver") {
			curConfig = "swrv";
		}
        Main.SAVE.data.curConfig = curConfig;
        Main.SAVE.flush();
        Main.LOGGER.logLevelEnd({won: true, curConfig:curConfig});
        FlxG.camera.fade(FlxColor.BLACK,.25, false, function() {
			FlxG.switchState(new HomeState());
		});
    }

    private function loadSP() {
        sWindow = new FlxSprite(25, 10).makeGraphic(725, 590, FlxColor.BLACK);
        wMask = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
        add(wMask);
        wMask.alpha = 0;
        add(sWindow);
        curSelect = "";
        //rifle
        rifle = new ImageButton(25, 15, rifleClick);
        rifle.loadGraphic(AssetPaths.riflebm__png);
        add(rifle);
        rifleT = new FlxText(125, 15, 650);
        rifleT.text = "\t                   The Standard Issue \n"
            + "The Old Federal Army's standard fully-automatic weapon \n"
            + "\"look at that G.I. with his S.I.\"";
        rifleT.setFormat(AssetPaths.FONT, 20);
        add(rifleT);
        //sword
        sword = new ImageButton(25, 120, swordClick);
        sword.loadGraphic(AssetPaths.swordbm__png);
        add(sword);
        swordT = new FlxText(125, 100, 650);
        swordT.text = "\t                   The Glower \n"
            + "A fine piece of weaponry made with the matrimony of titanium and energy \n"
            + "\"They say the glowing Glower glowers at the enemy.\"";
        swordT.setFormat(AssetPaths.FONT, 20);
        add(swordT);
        //shield
        shield = new ImageButton(25, 245, shieldClick);
        shield.loadGraphic(AssetPaths.shieldbm__png);
        add(shield);
        shieldT = new FlxText(125, 225, 650);
        shieldT.text = "\t                     The Cower \n"
            + "The shield that saved countless line infantrymen's lives back in the Great Wars \n"
            + "\"Not all who cower behind The Cower are cowards.\"";
        shieldT.setFormat(AssetPaths.FONT, 20);
        add(shieldT);
        
        //shotgun
        if(sgshow) {
            shotgun = new ImageButton(25, 360, shotgunClick);
            shotgun.loadGraphic(AssetPaths.shotgunbm__png);
            add(shotgun);
            shotgunT = new FlxText(125, 345, 650);
            shotgunT.text = "\t                   The Musher \n"
                + "Deadly when upclose and personal. A favorite of the Sapper Corps.\n"
                + "\"Being hit with The Musher is like tying your limbs to a group of huskies and yelling \'MUSH!\'.\"";
            shotgunT.setFormat(AssetPaths.FONT, 20);
            add(shotgunT);
        }

        //revolver
        if(rvshow) {
            revolver = new ImageButton(25, 475, revolverClick);
            revolver.loadGraphic(AssetPaths.revolverbm__png);
            add(revolver);
            revolverT = new FlxText(125, 470, 650);
            revolverT.text = "\t             The Single-Action PewPew \n"
                + "Space cowboys like to charge 'em up for extra hell.\n"
                + "\"You telling me that I can fire 'em as fast as I can cock 'em?\"";
            revolverT.setFormat(AssetPaths.FONT, 20);
            add(revolverT);
        }
        //cancel button
        cancel = new ImageButton(300, 550, "CANCEL", noShowSelect);
        cancel.loadGraphic(AssetPaths.cancel__png, false, 200, 40);
        add(cancel);
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
        jWeapon.kill();
        kWeapon.kill();
        j2ndWeapon.kill();
        k2ndWeapon.kill();
        next.kill();
    }

    private function killTut() {
        wMask.alpha = 0.0;
        //tWindow.destroy();
        tText.destroy();
        tButton.destroy();
        confirm.revive();
        inTut = false;
        jWeapon.revive();
        kWeapon.revive();
        j2ndWeapon.revive();
        k2ndWeapon.revive();
        next.revive();
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
        if(sgshow) {
            shotgun.revive();
            shotgunT.revive();
        }
        if(rvshow) {
            revolver.revive();
            revolverT.revive();
        }
        cancel.revive();
        wMask.alpha = 0.75;
        confirm.kill();
        next.kill();
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

    private function shotgunClick() {
        if(curSelect == "j") {
            Main.SAVE.data.jWeapon = "shotgun";
        } else if(curSelect == "k") {
            Main.SAVE.data.kWeapon = "shotgun";
        } else if(curSelect == "j2") {
            Main.SAVE.data.j2ndWeapon = "shotgun";
        } else {
            Main.SAVE.data.k2ndWeapon = "shotgun";
        }
        noShowSelect();
    }

    private function revolverClick() {
        if(curSelect == "j") {
            Main.SAVE.data.jWeapon = "revolver";
        } else if(curSelect == "k") {
            Main.SAVE.data.kWeapon = "revolver";
        } else if(curSelect == "j2") {
            Main.SAVE.data.j2ndWeapon = "revolver";
        } else {
            Main.SAVE.data.k2ndWeapon = "revolver";
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
        if(sgshow) {
            shotgun.kill();
            shotgunT.kill();
        }
        if(rvshow) {
            revolver.kill();
            revolverT.kill();
        }
        cancel.kill();
        wMask.alpha = 0;
        confirm.revive();
        next.revive();
        jWeapon.revive();
        kWeapon.revive();
        j2ndWeapon.revive();
        k2ndWeapon.revive();
    }

    private function clickNext():Void {
        FlxG.camera.fade(FlxColor.BLACK,.25, false, function() {
            if(_level <= Main.SAVE.data.levelCompleted) {
                switch _level {
                    case 1: FlxG.switchState(new Level1State());
                    case 2: FlxG.switchState(new Boss1State());
                    case 3: FlxG.switchState(new Level2State());
                    case 4: FlxG.switchState(new Level3State());
                    case 5: FlxG.switchState(new Boss2State());
                    case 6: FlxG.switchState(new Level4State());
                }
                if(_level == 7) {
                    if(Main.SAVE.data.katyCaught == null) {
                        Main.SAVE.data.katyCaught = true;
                        FlxG.switchState(new CatchKatyState());
                    } else {
                        FlxG.switchState(new Level5State());
                    }
                }

                if(_level == 8) {
                    if(Main.SAVE.data.bossTalk == null) {
                        FlxG.switchState(new BeforeFinalBossState());
                        Main.SAVE.data.bossTalk = true;
                    } else {
                        FlxG.switchState(new FinalBossState());
                    }
                }
                if(_level == 9) {
                    if(Main.SAVE.data.wifeLives == true) {
                        FlxG.switchState(new WifeLiveState());
                    } else {
                        FlxG.switchState(new WifeDieState());
                    }
                }
            } else {
                switch _level {
                    case 1: FlxG.switchState(new TutorialState());
                    case 2: FlxG.switchState(new Level1State());
                    case 3: FlxG.switchState(new Boss1State());
                    case 4: FlxG.switchState(new Level2State());
                    case 5: FlxG.switchState(new Level3State());
                    case 6: FlxG.switchState(new Boss2State());
                    case 7: FlxG.switchState(new Level4State());
                    case 8: FlxG.switchState(new Level5State());
                    case 9: FlxG.switchState(new FinalBossState());
                }
            }
		});
    }
}