package{
  public class Egg extends Item{
    public function Egg(related_node:Node) {
      super(related_node)
      sheetClass = piratesSheetClass
      tile = 17
      emptyTile = 26
      takeable = true
      //items = node.store(stage)
    } 
    
    override public function take(stage:Object, world:World):Item{
      super.take(stage, world);
      world.player.addToInventory(this, stage)
      return null
    }
    
    override public function useItem(stage:Object, used:Item):Boolean{
      stage.updateHunger(0.5);
      stage.updateHealth(0.5);
      if(node == null){
        stage.world.player.clearInventory(stage)
      } else {
        node.removeItem(stage)
      }
      return true;
    }
  }
}