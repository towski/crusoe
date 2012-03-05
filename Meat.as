package{
  import flash.utils.getQualifiedClassName
  
  public class Meat extends Food{
    
    public function Meat(related_node:Node) {
      super(related_node)
      tile = 24
      emptyTile = 26
      sheetClass = piratesSheetClass
      useable = true
      takeable = true
      energy = 4.0
    }
    
    override public function take(stage:Object, world:World):Item{
      super.take(stage, world)
      return null;
    }
    
    override public function useItem(stage:Object, used:Item):Boolean{
      stage.addAchievement(Achievements.DRUMSTICK_PLEASE)
      return super.useItem(stage, used)
    }
  }
}