package{
  import flash.utils.getQualifiedClassName
  
  public class Axe extends Item{
    public function Axe(related_node:Node) {
      super(related_node, true)
      tile = 25;
      sheetClass = piratesSheetClass
      emptyTile = 26
      equipable = true
      takeable = true
    } 
    
    override public function take(stage:Object, world:World):Item{
      super.take(stage, world);
      world.player.addToInventory(this, stage)
      return null
    }
    
    override public function useItem(stage:Object, used:Item):Boolean{
      var usedName:String = flash.utils.getQualifiedClassName(used)
      if(usedName == "Tree" || usedName == "GoldTree"){
        if(stage.updateEnergy(-10)){
          used.node.removeItem(stage)
          used.node.addItem(new Log(used.node), stage)
          return true
        }
      }
      return false
    }
  }
}