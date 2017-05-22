package;

class RatingCalc {
        private static var time1:Float = 120;
        private static var dmg1:Float = 50;

        public static function getTimeRating(level:Int):Int {
            switch level {
                case 1: return RatingCalc.Time1Rating();
            }
            return 3;
        }

        public static function getDmgRating(level:Int):Int {
            switch level {
                case 1: return RatingCalc.Dmg1Rating();
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
}