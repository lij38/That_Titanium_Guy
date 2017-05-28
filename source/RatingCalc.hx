package;

class RatingCalc {
        private static var time1:Float = 120;
        private static var dmg1:Float = 50;
        private static var time2:Float = 100;
        private static var dmg2:Float = 22;
        private static var time3:Float = 43;
        private static var dmg3:Float = 0;
        private static var time4:Float = 150;
        private static var dmg4:Float = 40;

        public static function getTimeRating(level:Int):Int {
            switch level {
                case 1: return RatingCalc.Time1Rating();
                case 2: return RatingCalc.Time2Rating();
                case 3: return RatingCalc.Time3Rating();
            }
            return 3;
        }

        public static function getDmgRating(level:Int):Int {
            switch level {
                case 1: return RatingCalc.Dmg1Rating();
                case 2: return RatingCalc.Dmg2Rating();
                case 3: return RatingCalc.Dmg3Rating();
            }
            return 3;
        }

        public static function Time1Rating():Int {
            var seg:Float = time1 / 2;
            var time:Float = Main.SAVE.data.timeTaken;
            if(time <= time1) {
                return 3;
            } else if(time <= (time + seg)) {
                return 2;
            } else {
                return 1;
            }
        }

        public static function Dmg1Rating():Int {
            var dmg:Float = Main.SAVE.data.dmgTaken;
            if(dmg <= dmg1) {
                return 3;
            } else if(dmg <= dmg1 + dmg1) {
                return 2;
            } else {
                return 1;
            }
        }

        public static function Time2Rating():Int {
            var seg:Float = time2 / 2;
            var time:Float = Main.SAVE.data.timeTaken;
            if(time <= time2) {
                return 3;
            } else if(time <= (time + seg)) {
                return 2;
            } else {
                return 1;
            }
        }

        public static function Dmg2Rating():Int {
            var dmg:Float = Main.SAVE.data.dmgTaken;
            if(dmg <= dmg2) {
                return 3;
            } else if(dmg2 == 0) {
                dmg2 = 15;
            } 
            if(dmg <= dmg2 + dmg2){
                return 2;
            } 
            return 1;
        }

        public static function Time3Rating():Int {
            var seg:Float = time3 / 2;
            var time:Float = Main.SAVE.data.timeTaken;
            if(time <= time3) {
                return 3;
            } else if(time <= (time + seg)) {
                return 2;
            } else {
                return 1;
            }
        }

        public static function Dmg3Rating():Int {
            var dmg:Float = Main.SAVE.data.dmgTaken;
            if(dmg <= dmg3) {
                return 3;
            } else if(dmg3 == 0) {
                dmg3 = 15;
            } 
            if(dmg <= dmg3 + dmg3){
                return 2;
            } 
            return 1;
        }

        public static function Time4Rating():Int {
            var seg:Float = time4 / 2;
            var time:Float = Main.SAVE.data.timeTaken;
            if(time <= time4) {
                return 3;
            } else if(time <= (time + seg)) {
                return 2;
            } else {
                return 1;
            }
        }

        public static function Dmg4Rating():Int {
            var dmg:Float = Main.SAVE.data.dmgTaken;
            if(dmg <= dmg4) {
                return 3;
            } else if(dmg4 == 0) {
                dmg4 = 15;
            } 
            if(dmg <= dmg4 + dmg4){
                return 2;
            } 
            return 1;
        }
}