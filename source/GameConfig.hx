class GameConfig {
    public static var gamebananaModID:Int = 444759;
    public static var defaultWindowName:String;
    public static var updateStatus:CoolUtil.VersionStatus = #if debug UPDATED #else UP_TO_DATE #end;
    public static var discordUser:{username:String, discriminator:String, userId:String} = null;
}