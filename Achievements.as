package{
  public class Achievements{
    public static const PICKUP_AXE:String = "pickup_axe";
    
    public static const CHOP_1_TREE:String = "chop_1_tree";
    public static const CHOP_10_TREES:String = "chop_10_trees";
    public static const CHOP_25_TREES:String = "chop_25_trees";
    public static const CHOP_100_TREES:String = "chop_100_trees";
    public static const STORE_AN_ITEM:String = "store_an_item";
    public static const KILL_1_GOAT:String = "kill_1_goat";
    public static const KILL_10_GOATS:String = "kill_10_goats";
    public static const KILL_25_GOATS:String = "kill_25_goats";
    public static const KILL_1_FOWL:String = "kill_1_fowl";
    public static const KILL_10_FOWLS:String = "kill_10_fowls";
    public static const KILL_25_FOWLS:String = "kill_25_fowls";
    public static const KILL_1_CANNIBAL:String = "kill_1_cannibal";
    public static const KILL_5_CANNIBALS:String = "kill_10_cannibals";
    public static const KILL_15_CANNIBALS:String = "kill_25_cannibals";    
    public static const DRUMSTICK_PLEASE:String = "drumstick_please";    
    public static const GRAPES_PLEASE:String = "grapes_please";    
    public static const SEE_THE_DESERT:String = "grapes_please";    
    public static const BUILD_A_RAFT:String = "build_a_raft";    
    
    private static const ACHIEVEMENTS:Array = [ 
      PICKUP_AXE, CHOP_1_TREE, CHOP_10_TREES, CHOP_25_TREES, CHOP_100_TREES, STORE_AN_ITEM, 
      KILL_1_GOAT, KILL_10_GOATS, KILL_25_GOATS, KILL_1_FOWL, KILL_10_FOWLS, KILL_25_FOWLS,
      KILL_1_CANNIBAL, KILL_5_CANNIBALS, KILL_15_CANNIBALS, DRUMSTICK_PLEASE]
    private static const ACHIEVEMENTS_TEXT:Array = [ 
      "Found the axe!", "Chopped 1 tree!", "Chopped 10 trees!", "Chopped 25 trees!", "Chopped 100 trees!", "Store an item",
      "Killed 1 Goat", "Killed 10 Goats", "Killed 25 Goats", "Killed 1 Fowl", "Killed 10 Fowls", "Killed 25 Fowls",
       "Killed 1 Cannibal",  "Killed 5 Cannibals",  "Killed 15 Cannibals", "Drumstick Please"]
    private static const ACHIEVEMENTS_ICONS:Array = [ 
      Axe, Tree, Tree, Tree, Tree, Chest,
      Goat, Goat, Goat, Fowl, Fowl, Fowl,
      Cannibal, Cannibal, Cannibal, Meat]
    
    public var achievements:Array
    private var stage:Object
    public function Achievements(storedAchievements:Array, island:Object){
      stage = island
      if(storedAchievements == null){
        achievements = new Array()
      } else {
        achievements = storedAchievements
      }
    }
    
    public function addAchievement(achievement:String):Boolean{
      if(achievements.indexOf(achievement) == -1){
        achievements.push(achievement)
        showText(achievement)
        if(achievements.length == ACHIEVEMENTS.length){
          stage.showAchievement("Ship has arrived!")
          stage.placeShip()
        }
        return true
      } else {
        return false
      }
    }
    
    public function showText(achievement:String):void {
      trace(ACHIEVEMENTS_TEXT[ACHIEVEMENTS.indexOf(achievement)])
      stage.showAchievement(ACHIEVEMENTS_TEXT[ACHIEVEMENTS.indexOf(achievement)])
    }
  }
}