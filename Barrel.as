package{
  public class Barrel extends Item{
    public function Barrel(related_node:Node) {
      super(related_node, true)
      tile = 0;
      itemSheet = new itemSheetClass()
      useable = true
    } 
    
    override public function take(stage:Object, world:World):Item{
      super.take(stage, world);
      world.player.addToInventory(this, stage)
      return null
    }
    
    override public function useItem(stage:Object):Boolean{
      trace("using barrel")
      if(stage.barrel.length > 0 && !stage.world.player.hasInventory()){
        stage.world.player.addToInventory(stage.barrel.pop(), stage)
      }
      return false
    }
  }
}