enum abstract Months(Int) to Int from Int {
    var JANUARY = 0; //yes it starts at 0 smh
    var FEBRUARY = 1;
    var MARCH = 2;
    var APRIL = 3;
    var MAY = 4;
    var JUNE = 5;
    var JULY = 6;
    var AUGUST = 7;
    var SEPTEMBER = 8;
    var OCTOBER = 9;
    var NOVEMBER = 10;
    var DECEMBER = 11;
}

class Birthdays {
    //[day, month] => "name of birthday person :))))"
    static var birthdays:Map<Array<Int>, String> = [
        [23, JANUARY] => "EggKiddo/ShultzyNG",
        [31, JANUARY] => "Diamond & Flootena",
        [15, FEBRUARY] => "Alyco",
        [8, MARCH] => "Timson",
        [20, APRIL] => "Furo",
        [24, APRIL] => "Flezard",
        [25, APRIL] => "OwenTheMC",
        [1, MAY] => "YaperPaper",
        [6, MAY] => "SPG64",
        [17, JUNE] => "Random Inc./Josee",
        [21, JUNE] => "Ame",
        [9, JULY] => "MazhiTK",
        [3, AUGUST] => "Hero & Dylanesg",
        [14, AUGUST] => "Ryaltheamazing",
        [4, SEPTEMBER] => "RemTweaking",
        [7, SEPTEMBER] => "Sapph808",
        [16, SEPTEMBER] => "Luminator",
        [30, SEPTEMBER] => "Doubletime32",
        [5, OCTOBER] => "Friday Night Funkin'",
        [28, OCTOBER] => "Jospi",
        [1, NOVEMBER] => "Super Mario Galaxy",
        [15, NOVEMBER] => "Serenity",
        [15, DECEMBER] => "Pixlexia",
        [26, DECEMBER] => "Shell",
    ];

    public static function getBirthday():String
    {
        var currentDate = Date.now();
        for (date => person in birthdays)
        {
            if (currentDate.getMonth() == date[1] && currentDate.getDate() == date[0])
                return person;
        }
        return "";
    }
}
