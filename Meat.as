package{
  import flash.utils.getQualifiedClassName
  
  public class Meat extends Item{
    
    public function Meat(related_node:Node) {
      super(related_node)
      tile = 24
      emptyTile = 26
      sheetClass = piratesSheetClass
      useable = true
      takeable = true
    }
    
    override public function take(stage:Object, world:World):Item{
      world.player.addToInventory(this, stage)
      return null;
    }
    
    override public function useItem(stage:Object, used:Item):Boolean{
      var usedName:String = flash.utils.getQualifiedClassName(used)
      if(usedName == "Barrel"){
        stage.food += 1
        stage.barrel.push(stage.player.clearInventory(stage))
        stage.food_text.text = "food:" + stage.food;
      } else {
        stage.updateHunger(4.0);
        stage.world.player.clearInventory(stage)
      }
      return true;
    }
  }
}