package{
  import flash.utils.getQualifiedClassName
  
  public class Axe extends Item{
    public function Axe(related_node:Node) {
      super(related_node, true)
      tile = 9;
      itemSheet = new piratesSheetClass()
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
      if(flash.utils.getQualifiedClassName(used) == "Tree"){
        used.node.removeItem(stage)
        used.node.addItem(new Log(used.node), stage)
        stage.updateEnergy(-10)
        return true
      }
      return false
    }
  }
}